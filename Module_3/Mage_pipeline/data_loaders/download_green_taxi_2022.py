import pandas as pd

if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@data_loader
def load_data(*args, **kwargs):

    base_url = 'https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2022-'
    df = pd.DataFrame()

    for i in range(1,13):
        url = base_url + str(i).zfill(2) + '.parquet'
        print(f'Loading dataset {url}')
        new_df = pd.read_parquet(url)
        df = pd.concat([df, new_df], ignore_index=True)
    return df


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'

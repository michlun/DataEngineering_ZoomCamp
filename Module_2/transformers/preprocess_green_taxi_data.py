
if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):
    print('Initial dataframe shape:', data.shape)
    print(f'Preprocessing rows with zero passengers: {data["passenger_count"].isin([0]).sum()}')
    print(f'Preprocessing rows with no passenger count: {data["passenger_count"].isna().sum()}')
    data = data[data['passenger_count'] != 0]
    print('New dataframe shape:', data.shape)
    print(f'Preprocessing rows with zero trip distance: {data["trip_distance"].isin([0]).sum()}')
    data = data[data['trip_distance'] != 0]
    print('New dataframe shape:', data.shape)

    data['lpep_pickup_date'] = data['lpep_pickup_datetime'].dt.date
    
    data.columns = (data.columns
                .str.replace('(?<=[a-z])(?=[A-Z])', '_', regex=True)
                .str.lower()
             )

    # for i in range(10):
    #     print(f'vendor_id = {i}', data["vendor_id"].isin([i]).sum())

    return data


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output['vendor_id'].isin([1, 2]).all(), 'Not all vendor_id are 1 or 2'
    assert (output['passenger_count'] > 0).all(), ' Not all passenger_count are greater than zero'
    assert (output['trip_distance'] > 0).all(), ' Not all trip_distance are greater than zero'
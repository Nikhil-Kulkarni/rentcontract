async function main() {
  const rentFactory = await ethers.getContractFactory("DelReyClubRent");

  const contract = await rentFactory.deploy(
    "0x1cD8d1d79AA869c5e9EA80964ab883EB56785B7c",
    "0x22Ee39ca6845e19954308790e752e99fF6d56899",
    2945000000,
    "0xe11A86849d99F524cAC3E7A0Ec1241828e332C62"
  );
  console.log("address:", contract.address);
}

main()
  .then(() => process.exit(0))
  .catch((err) => {
    console.error(err);
    process.exit(1);
  });

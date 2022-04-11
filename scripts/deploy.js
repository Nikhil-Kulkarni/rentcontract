async function main() {
  const rentFactory = await ethers.getContractFactory("DelReyClubRent");

  const contract = await rentFactory.deploy(
    "0x1cD8d1d79AA869c5e9EA80964ab883EB56785B7c",
    "0x22Ee39ca6845e19954308790e752e99fF6d56899",
    2945000000,
    "0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174"
  );
  console.log("address:", contract.address);
}

main()
  .then(() => process.exit(0))
  .catch((err) => {
    console.error(err);
    process.exit(1);
  });

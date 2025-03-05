Return-Path: <stable+bounces-120447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E28A503AE
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 16:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85BD73A50FD
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 15:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB1C24E4B4;
	Wed,  5 Mar 2025 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gyBAE/gU"
X-Original-To: stable@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013021.outbound.protection.outlook.com [52.101.67.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36882230BC6;
	Wed,  5 Mar 2025 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741189347; cv=fail; b=oWthgz112A67LB+DvWIMGi7jLOsQoYzI8cBasge12kwOq4QaktJ6BKtEsZfZbCQND0LFr4yJqq8o0P2kFb/JkFNp7V3vK15+lcSH3YgeGQeIgLCmZCt2iwWppB2zgmHfSBib/Av0FmFiHuW5WkRZnEhEoMMMvPg4IQKvD612NH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741189347; c=relaxed/simple;
	bh=0dvY8usiuK8cCi3wR+ypEOdl0JEml35z9n1343Hd9nA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EzGgcDRiHYEI7TLAyOIo1MlImNWDtBDUTV991HgUIyQaoRpthqiurJvPpi7Fyoq1TC37r8KH0vNt7oJ7olLdupMtx76tqiFyTAKCFOXMYGQHyFmA/JDVFIzdE9ep4OrtGI9/6Kiry8UbQdks5Awi9sLVBwhz+1Wil/mosZOUK+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gyBAE/gU; arc=fail smtp.client-ip=52.101.67.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nbM+N5SLXX3Bmb43Q4dEZjy8rN1HwMcIukAPm2/tYenNPVRbIUK7qUR5X0l1GM+Kpvd3ZVGfCaHvhY8u0RZPBpItpSeUu6EvmzmZLquAeigEriZSHYeyFODSU6pv/YmD+nxvkRE9UBb1dJ4n9u6Zi48DTRIZEVq9QRApYin975u7x5QKCagigJLDOub+xlRkxfK+04ny8pdZP04aSJnnQg5nAdDDJ6Xe4h+SA1bQDt0hwi6epR7n+4K9FokSuyoiUBjGvPoD8Ss9pYvjMaZ1po2em69ut51t1E0U76IcsKnfxLjO/vazQxhL/Muu/t0jL0YiF9fWRvaUVw61brJIrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIdAET+6Y35mYOcF+P2jrw6vClf0MPpwb1Ue860o5T8=;
 b=jaAxX0nBd3RLPy95UYzUutiWaI5kDkC9K2HjiHdpGDJNUD6kv1MXyYSop3K/AkN8+H63FOtYbPgdUk0Pb/gnBG3sAsHwMhuxQPh28xKPRh+9V4elmao9Do4vKDIdg4PTWXjW98ZHuktaa7K9UkSRnuzPWq6ZZVABeAq7et3kagSmO2L21KM6l1aEMgnEUn9vGRzsVIzX3WnVwycJfeOXzg64vxGB87qr6AMQkA/N3vSp3vSL/XzqXbOVu/rjCz3uMcVM1IVbcV+v3rAODGAxC0i9c5pTKoqZeX1Zx+9fCSIwBSzlQFmGOCrJ8OXYwV8/TTKHs+elENIsAZM5HIa+zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIdAET+6Y35mYOcF+P2jrw6vClf0MPpwb1Ue860o5T8=;
 b=gyBAE/gUrYAyjPeGnIAkpARAwAK8Sf2hAiPjVLwgkEYtz5d5+kqIqFBuyCoYAGp2+y11IPqGrFaM+gkhNChWFxI/8Xl+ktmc/cqmyOUUllBpAOlsp5AEul4OtfNUrp+tFNS3HU+MpGh5edo9C4kq70KT0xI4E2RLx0mHlt1cHgorfY0YUzdHKuZclwhOrSoYfwtzMDIT+L5UKbp9LnHEXmwvyau4pCIhLIVspLxdbZ/FRCYDG6RuOCyQ6OELXxn/lFybq+FmdadWTf+n6G1cACe7JCQThQgCI/ISZPnWg/2pH81SdMvDDO1pEfN6U9d6FLTA2FoBHQfxKu93JJ50cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AM9PR04MB8162.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 15:42:21 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%4]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 15:42:21 +0000
Date: Wed, 5 Mar 2025 10:42:13 -0500
From: Frank Li <Frank.li@nxp.com>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: vkoul@kernel.org, kishon@kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	p.zabel@pengutronix.de, tharvey@gateworks.com, hongxing.zhu@nxp.com,
	francesco.dolcini@toradex.com, linux-phy@lists.infradead.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] phy: freescale: imx8m-pcie: assert phy reset and
 perst in power off
Message-ID: <Z8hw1W0PBsmanylZ@lizhi-Precision-Tower-5810>
References: <20250305144355.20364-1-eichest@gmail.com>
 <20250305144355.20364-3-eichest@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305144355.20364-3-eichest@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0292.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::27) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AM9PR04MB8162:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e3d8571-f489-4ab7-4874-08dd5bfc517c
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?CqY9JeCnnhIlxmmSVvd3Q47p8Dtie2Bf926RKcqDpUl+vXvoKMhYs3jJfrlZ?=
 =?us-ascii?Q?ujUEFghehCf8gEeXMHVkCGwkAUtzmKlQYHCVCDI85LT9D9FctrD+sCZimcTB?=
 =?us-ascii?Q?c7+ohC4lbJN1lSAvKKjtbPvh/jJK/tpgpuZMUGLXPMBtZfbxeVBN6bI7RkOS?=
 =?us-ascii?Q?l7G7BJjv79TuG8y9L5j2NmXal/koWE3VoTFAzg+val9pGEWMzfzPei3tRcIG?=
 =?us-ascii?Q?lDJUhpV4YY+nFS+SUQRJx/Z4WyXCO2dQY777h0EWHcQ8eUh0ZswUZNWPKt6O?=
 =?us-ascii?Q?17LHNKWxE0DJsc0hJlAEAP/fGQsPPkgkoB2CyrLOWW2SP4jAQn8gx8bYVgPd?=
 =?us-ascii?Q?28G5Ip42hVSY1RTV/9nA043F4qXoOf0mnSA324SwC3duJHyGFqO+JiGfb9Im?=
 =?us-ascii?Q?5VbPBIE504a5xUqDgN3PHYNcd3TLpjOpcPU305vUmQK+uiII7KZbZDkzCp0Z?=
 =?us-ascii?Q?d0j5NeTux9KyNqvvKRjQdQM9PjnwhubKLrQjLco9u2nKiC7cmEl4N9HBQFSN?=
 =?us-ascii?Q?+Kb7ZrBQKDpSNQ2oTwDE6Ejrf2V2GwlDnmNzYsVAHXXZq6Isydj5Kj2S/OdO?=
 =?us-ascii?Q?cYVII5qvoWNaGzTS3Qvj6fQU2m/qf9LsdXL8A4IfIif705ifKU/W08EQWwJ5?=
 =?us-ascii?Q?LYftHuahKm6XsauOjjIFIsStg/8npqlsyyORwIPekpRzz71fh8D7+IFUX2le?=
 =?us-ascii?Q?t/muNKzStw7R4jFMLbi47gX1rJhiAzpb9ThBO2+ISRRDdhPT8bQw355sArXj?=
 =?us-ascii?Q?Z0cUKSr89/tuQQ4XlIX0IdCbr65CYf5/hqXSPD2iJMuXwdA8IDwp8A4xRref?=
 =?us-ascii?Q?rS7EwnWSpVJ/AQKjc61Mqt4DohP4JrbyWd1VcLLIgWbUBYZPgGo+opNOnAEh?=
 =?us-ascii?Q?w3qxlMVyVMbxjWYg6Tt2wXnOebkToiRirTfA1JEzs7pjWRPz9okn4nbMnBdS?=
 =?us-ascii?Q?5s3tw3z4abAa10TvIrRoCYHH6QHw54lEK33erwZFR+DmEC0T6KXKF4UVMtdR?=
 =?us-ascii?Q?btncpt/Nk1Au4bWMhNJajCYBtT5SqaIVsDG6Ca2SJWwoSi3ht9O/9JrZBbUk?=
 =?us-ascii?Q?XonmdTcNXKACo6sca34drKRMYLZ0mnLDJDO11OpbI7ZiF2qOj5vQjYZJPyKh?=
 =?us-ascii?Q?YCl+rXO8+7i2fJ+hjw0iWUb0s6RVkcd2fiHDIAwTpPMynBQgIfYtFDeP/hZa?=
 =?us-ascii?Q?U6Hqe+nKuuqXSCVEnDRLYBvgjsaSsP5csqj8MgAtUdegthmNB5VXlYtRoiHZ?=
 =?us-ascii?Q?NcpQiMlj9cr6/vS5t5WCMttOdXzwZmJ6BVqyEk390WnEAXSRktyXWlJYCnlc?=
 =?us-ascii?Q?HAXTIDhqHCuG5zdCbBymEyUpOjjkfszMAE0VxPQdNmn1QG1712FgeybB1Xy1?=
 =?us-ascii?Q?/xUY0F/aGDFY3oKiED5+PTOEZlSy/ZNmkZU9fQhSvyw0hB40AJd8Jzhdu3NP?=
 =?us-ascii?Q?xTpwsC6JCWItdXZ+EqlUEB46IXvyfeXs?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?l8OKB6Cf4+q4wvq7hgn9e2U6Nr6DBb7W+5yirJRgyT8meZzQOOKznm6cA/Cd?=
 =?us-ascii?Q?OVulXbCKCKqBMrC+a+lLoD61OGz9kpnNe8IBiccL4AtU4izxsWA6JORkbAre?=
 =?us-ascii?Q?BHsUiQkgqtnCGB7YiSvc4Cl0bIRd6Hxg0Lxa8X2DUgIIHXE7G63+/GltseCD?=
 =?us-ascii?Q?z6624xa6vnV+rFEUg+Ott5f/+OH3nVznK8qpudm5EfvFCOPAmBuUUL78NzU9?=
 =?us-ascii?Q?0LFn8hNbFmAr5xCxt5SEyazHhbvZOqqPQ3blG4uhmvPtzkcqanxMZH+gpR3k?=
 =?us-ascii?Q?e/FkfnYEEH8WEIp3hMs5Ll1rJmWopFekE1FNqvSuUDYfMBIpJj/AcaMfJvhl?=
 =?us-ascii?Q?5H7+zQLJFlDYKGv8+GeFprrCNIOfIPYpO833v61XDWpzzTk4Ei/elgpc0G+A?=
 =?us-ascii?Q?rfLeuC69Btf3YOZ2jbWTpTcXNVl7H9DiypR0VQSEmEhH8I643ciKXxVIhtuW?=
 =?us-ascii?Q?4cKqT5n1hk0+DspDB5stMWtExIihJSkBsvoV8y915g+4zrWFYJM6pIlMUGkx?=
 =?us-ascii?Q?gWFYpa2a1+O6Lq5jNs2EA/aTtyeBhJAKnzDBhqXWBr9XNHeHHKysQT7NfwS/?=
 =?us-ascii?Q?WycK33Hb/JdqQZ9l14JOs1s1cUNLwIWAzJWhLf1E7WNDgJPRPROXfSUrWQA9?=
 =?us-ascii?Q?S8amDBwVCCBPhuWj1fjtyk60JZKazgk3BZOHZqi/Ivjv4BpKrjD+9j2JZO0m?=
 =?us-ascii?Q?hCpccanvyXVP2BozNvOxWkgP2aNXXp1HlxIt0UxrzkdMgA+lz4nCRwW2YFJt?=
 =?us-ascii?Q?uA3LbAyVsfa3WyVxZmnx1s7iOdqK8cNj2h75A4waT8M4m9MoakYYi2wgkHlB?=
 =?us-ascii?Q?0XNemkapBMjfCYhpuFMdp4N9cvldXvsnzIff5X7m2YcqIJdbQUBrjcezLmMK?=
 =?us-ascii?Q?Kz6gnOs9BQxbA7YB4CKdDKdTFcHBZjMRxaKApmegJ7/J/EXguYI/amAk+6yK?=
 =?us-ascii?Q?PZ1pr7doASRFEafXyJMIEXC8W21cBTt19IlYVUNsI3705h2IIRZkQVHWmseS?=
 =?us-ascii?Q?/NKl4kvrEVRoaet7CM68hPO62E5TjXPQ6vMlYne8b9yGfkpLAERBdxF+SH9u?=
 =?us-ascii?Q?b7GwazHbVabKNZmxhP5LeZgyNvj7lbkPtj8cB2sMXsuyntfTsoHBd4hc9cVl?=
 =?us-ascii?Q?kB+az4edDy4N9G7h320YB6sLTiIirDmDB1NXi+vda5hbvQSgIZAEBlvo/aLB?=
 =?us-ascii?Q?BYzjikr24Wf8HTga5FgzxivVY35gZOlsm7zvGI8t0GdwRIB23my3gIBZ29zD?=
 =?us-ascii?Q?AHXHNg/7LyELRBM4iaxDgy0UYafW7g6tjvAIlnt4n2tgO8Jlu6y71mUiF3Eq?=
 =?us-ascii?Q?+CJfSfWsPQy3e3bVn/cw7xsjF9wsxQYjU52BqjV9hyXZP7jcIc/tQRzTHj7t?=
 =?us-ascii?Q?3aJFpH7D3oi1F2ZpIuX3vrIU4nL5zEpf6sfPJhjfE3FfigHtdkb4S19Ljavo?=
 =?us-ascii?Q?l2DyzUY3bJhckXiik0jWLHRXABHCDKvT0Hc8Y/oNw54QULiQ2Nwozv90S1ri?=
 =?us-ascii?Q?JrNm41UoNCmT8Kimg2WP1d96SryDCaCUSy6bazqGw2JeDA2/x5KfccDXNTbU?=
 =?us-ascii?Q?dJx2zRLErWybPnW/6dljD+1XjLNiknI+cFr+Bp8L?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e3d8571-f489-4ab7-4874-08dd5bfc517c
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 15:42:21.6544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FKFSmQZPJBni8VQySEOEoSMHzy9JD3a07RCowNmhj0ot0uzWuH1kt5CoPI0BEa+rGYx9EKZV/5umEY2e5M0zug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8162

On Wed, Mar 05, 2025 at 03:43:16PM +0100, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
>
> Ensure the PHY reset and perst is asserted during power-off to
> guarantee it is in a reset state upon repeated power-on calls. This
> resolves an issue where the PHY may not properly initialize during
> subsequent power-on cycles. Power-on will deassert the reset at the
> appropriate time after tuning the PHY parameters.
>
> During suspend/resume cycles, we observed that the PHY PLL failed to
> lock during resume when the CPU temperature increased from 65C to 75C.
> The observed errors were:
>   phy phy-32f00000.pcie-phy.3: phy poweron failed --> -110
>   imx6q-pcie 33800000.pcie: waiting for PHY ready timeout!
>   imx6q-pcie 33800000.pcie: PM: dpm_run_callback(): genpd_resume_noirq+0x0/0x80 returns -110
>   imx6q-pcie 33800000.pcie: PM: failed to resume noirq: error -110
>
> This resulted in a complete CPU freeze, which is resolved by ensuring
> the PHY is in reset during power-on, thus preventing PHY PLL failures.
>
> Cc: stable@vger.kernel.org
> Fixes: 1aa97b002258 ("phy: freescale: pcie: Initialize the imx8 pcie standalone phy driver")
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/phy/freescale/phy-fsl-imx8m-pcie.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> index 5b505e34ca364..7355d9921b646 100644
> --- a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> +++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> @@ -156,6 +156,16 @@ static int imx8_pcie_phy_power_on(struct phy *phy)
>  	return ret;
>  }
>
> +static int imx8_pcie_phy_power_off(struct phy *phy)
> +{
> +	struct imx8_pcie_phy *imx8_phy = phy_get_drvdata(phy);
> +
> +	reset_control_assert(imx8_phy->reset);
> +	reset_control_assert(imx8_phy->perst);
> +
> +	return 0;
> +}
> +
>  static int imx8_pcie_phy_init(struct phy *phy)
>  {
>  	struct imx8_pcie_phy *imx8_phy = phy_get_drvdata(phy);
> @@ -176,6 +186,7 @@ static const struct phy_ops imx8_pcie_phy_ops = {
>  	.init		= imx8_pcie_phy_init,
>  	.exit		= imx8_pcie_phy_exit,
>  	.power_on	= imx8_pcie_phy_power_on,
> +	.power_off	= imx8_pcie_phy_power_off,
>  	.owner		= THIS_MODULE,
>  };
>
> --
> 2.45.2
>


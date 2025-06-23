Return-Path: <stable+bounces-156141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F855AE4837
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 17:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A2513A1E1E
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8AB27A930;
	Mon, 23 Jun 2025 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Tx2gt9d3"
X-Original-To: stable@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010013.outbound.protection.outlook.com [52.101.84.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D04279DA8;
	Mon, 23 Jun 2025 15:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750691657; cv=fail; b=Q8XTAIYqq6FHW4z0WYYNUM/G0ARGPnJVjvDyxNuPI4qeM1Rckjh30H+kllHztBzbgJDMPr2mgTX6Lf6dNTAL0Zcutiji9dgU/eLu6bnsvQ3YyS2cgrv/ymHT+37Le0DbiczOCNDIlw+CIWZec72BfjcaDc9fkcXzKQOKvqDFkUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750691657; c=relaxed/simple;
	bh=RS0WQw4QnxKGlnrAD9P12QAYTqhMD4X0GJExEm2IZFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eD4/96f0kDPs8yP21FIxwrPWPX6fLO8MTffNA/OAHbbm6xyXBZ4fj/Hb5jYAXdalTUZ5GOOSII5rzH5IWYmwZqG6PeKhdaBvuSGg0oDlp7KCtIoE3cNmCdFc26V6gtM8n634Pp4wISNqsl42CecR1+TMmymWnKsETsu8TEAB0jM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Tx2gt9d3; arc=fail smtp.client-ip=52.101.84.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y2yNktvFs16UrIarGylSMZFwoPD09qBXs5J/Bpv+fhFlcbPR/KPZ7F99pAjb55KXwycoICnO5RoMFaMO8yD/4ZNjCBIJRcLcmM6D5BwCB2j+sCMRKxwdTkyOug7DWnjcBY11Oru0aoF5yOPYUYARCNlB9+B6RBGn+1l+S4wx8MUlhrTxMV32hlw0Ykf1finhUz8IH2AXKk3ZAI3hqW7V5ODiXIF/bfgAX8MYjL1wbknKRGUvMYI0kuAoYR29VPBH/uZELHbEMXj7yoqu0LrQU3gMK1sW8UVSSRyoi23PscUQin2E+1AIWS6ArDhR8pIwTD4awt4eYGsbqt4j5zQkXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uyoIYHc877QhoU1AdVe/goMgUmUNPPBEd7kD87NhtVw=;
 b=MjT5+9i01oeBdtqC2iruO4rcmtrABZAEJ/y9tLcxXpY+PykBGMFC5qETGX5yPWzC2ptmZzEzDsH1aNj7NbRxDiBAkrTSkyNGNyBEmKSXE8ome11ms/GjB+t+8vCBkCa9vXZI9n5XssgmTzMW1tMCQbwLZgYCLHk7zjBoW+6Hv2djc6C8eOCCe0Sn2OMwpzO94qlfBYrOnipwwHN7ysDH0Jx+545MCSglvZ+GrYyl7KMcoACn/4eOvq4Xi9jUEdT3DWPHd2v1cQKYCiXXoVP21O1b/lDXHAFVvVs0z1tpvJqPdcQHr7azQN3C4Og5fxVgfIZWgvbf351kqL9jXV/i1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyoIYHc877QhoU1AdVe/goMgUmUNPPBEd7kD87NhtVw=;
 b=Tx2gt9d3esvRwoFQSaGHQMiKLkQyiqMOZeK9uC7e4XQksxIdmxLLarDN0mf1837JLOlvuU+8osryH9tlTQ0YuZKO1eNvNTvuHOsKndmbf1LATPJ971XsITVcB7TmIi8EtWjVHyKCPRcv/QE6Ixv+fX5IVKcLOW4cRN3qHjuAIdRM3pX1oyetZrDAU92R6uPD8RsjeHi4sd9Pvt2nw83JpvjiTU16mR74L59Zxj2GfyZ+famh6IODswlrL6mz8s7vYfgiIqn4mVQFeQqVQ4H8kG0BaAKrd/LSIj7yvd1/Q2vlssy7RvFuDbQeffeKgdOSQUvby5Cn+JaYxOj9qhCHEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8735.eurprd04.prod.outlook.com (2603:10a6:102:21f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 15:14:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8835.027; Mon, 23 Jun 2025
 15:14:10 +0000
Date: Mon, 23 Jun 2025 11:14:02 -0400
From: Frank Li <Frank.li@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: freescale: imx8mm-verdin: Keep LDO5
 always on
Message-ID: <aFlvOshtO8WcbcBV@lizhi-Precision-Tower-5810>
References: <20250623132545.111619-1-francesco@dolcini.it>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623132545.111619-1-francesco@dolcini.it>
X-ClientProxiedBy: SJ0PR03CA0354.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8735:EE_
X-MS-Office365-Filtering-Correlation-Id: 584f2fa9-3bca-4731-cc43-08ddb2689b2f
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?grNnEF1cKl7NmJPtXtB89i+9rg56CmqMuviKAkBegPCXrkuZEef/LssYdWx9?=
 =?us-ascii?Q?flsK042ZGYpwde5+3fdsst6D8xtOYbPE/PjmdFdfEisARBg5oFou+OyUyUrO?=
 =?us-ascii?Q?JsCGmO+/6BqYno7xWduA1/QBHSHCsEIV1URRQ3yOPYHfvrN5Lgt31SDcA9PB?=
 =?us-ascii?Q?CccTDlc68O5MggXUz5OYMMoM9RMRCPF8DCO8BzaP4lCV996Pqg0vJkb2W9Yf?=
 =?us-ascii?Q?iieSpGWKN2D1nUqyOBwE+rxhq9Et6gfP4GrvO+sYDsap/CO4ncNB8rt85l5q?=
 =?us-ascii?Q?HHeDjAmyEg8OnW5tFSJnIQbk5EsThOlKbx7xZQFTn6jWjqlPvNW0LCerAkux?=
 =?us-ascii?Q?ZhLDzmfyXq8/8x1gS19KyP4gBUeaq0L3BgfakvJcJDVFzsg6aoUw+gQyusWH?=
 =?us-ascii?Q?GwTToS3IfJP64QbnUb4wpdltk139CNIUEqj+c1k3u72GkUhV+L17+/LOfqlU?=
 =?us-ascii?Q?vOs5uLsjVz/eZPdvvckv5G2Z+iKhc41g2ffjbIZvEyMWKB7o1AaGRepfofj4?=
 =?us-ascii?Q?9UxNMGcAC9Ek/1SLrwTsMsI0NfX3i/kgoZLpJ6T4KwOhjHfB0BvyCv42GOz/?=
 =?us-ascii?Q?rUu7eKAAV2BeD6PddHzSR4dEMhHdzUdz3yq5jChOMU6I2tt0+0fJVR3ea3r4?=
 =?us-ascii?Q?JqjhmqGh+zW49ZXWpEpnrvp0TGFE7zlRSWdi2pRL/e0KYRn4i03wNd4JLJOT?=
 =?us-ascii?Q?OANFELWAxftT9hAYXq61QhDSQU4L296GiWZuEQGosRCsOnTvvMuDePguOK5Q?=
 =?us-ascii?Q?Ll6hThVKZAWqbS74X/vLvge+DX+BXWo6gPBEs02CW0qqN+D5dEVBfjyWXeRh?=
 =?us-ascii?Q?bwn4S6LqoswcTRZr04ij+M7c+BRyboFGdQhxyCVn0wqKr5gIB6i5jCkpWhc0?=
 =?us-ascii?Q?RzN6U0SQacwk1CgBwBsoOOaiHi8Q+ZyOT0U/tRjxMqdnLzzCg2FBMnwmegXh?=
 =?us-ascii?Q?ldPHX3hyW4LsL40eSWYa7jjNXJHH6IdLxe7/0SiIjW7sbpDPIJPHXJq41lwK?=
 =?us-ascii?Q?x4EF7KvshFl3dMrC1Rcca1Jj1cBMxwDyyYOAYUHsQlQtKEgAdMUFQKo1oQt+?=
 =?us-ascii?Q?ttaFDruzJGz/MsYS6BxOYFZHAV1+QbUTwsw93JR8VCfH80MoIjXMf7Pv83mQ?=
 =?us-ascii?Q?QJ3k6QEPgO1+FNvs6JqxGDMBDfF0l+tOjS0GgUbMlwu83pnl1S21MNgR5+Wa?=
 =?us-ascii?Q?xP5w0SZ/rypBeeqe6qzEdqOKCLnMu9P8LXBJUcJnLbx6dyLqlEqJBLB42yFF?=
 =?us-ascii?Q?hwXXeSJjnTcq7RGr3HIrQPgQyVRV1h/cS/LVpS0ndMOjZYm5K9EMqszNJXur?=
 =?us-ascii?Q?HdCqjQuYvG7lU6xhTbz4HfMeI7OiJGgSxQmcjHsFD5QZxAcZhbu9YqcHcmQT?=
 =?us-ascii?Q?31S6NjPGtzIHb0DnGEQrCENoRL03r1md0/XXz75mxAdtJirjZ33n2jNhT0Eg?=
 =?us-ascii?Q?GdMVD/2lT6VgmpvG9/jk7Sp8V/BhuN0iqMPjIIG7+HkH7y0Ps4IBuw=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?IEicoCoQKrpLNiZSkz9naSqfNAnRyp0MzPCz9BGuzPrAnzrtsOSOgXv+kqUv?=
 =?us-ascii?Q?ImbV4KZVbfPm5tzpS1HCTlsosZ3qKAItN2JhvUwzuaprHZolINFmgog2eTK9?=
 =?us-ascii?Q?i9xqslaisN28zxRPw6z+3Ww89DfkJuTz3etvqFvBuleLP2/R3AL+5S3TPHqZ?=
 =?us-ascii?Q?jSZHFbGy2NjEwqPTR4YShZup/OtY2GNPPLnbPLI/CJ0eKh12ULRpiw6OE8qg?=
 =?us-ascii?Q?buhW5bU6IuNpgVgP3PGcnoS1naMUFNb7Vzj2SpfesrKjH2US5kv5PBzS7v24?=
 =?us-ascii?Q?jG0kCLFftWxyWuskc82xYupXGZV8Mgm4n0EVPouZfPgCFu00+NMjTtw3w/g2?=
 =?us-ascii?Q?OluQq502fF8dSCG0/7iyg4Qk+6eaTFbFyMdLRoLjxTzuxyV9MYbsNHQPha5a?=
 =?us-ascii?Q?cksK6fYTRbd0ymdY2bSEoCCAcjEBbh/5gU0Pk9voVAR3oBSORtWvNVSPo0YC?=
 =?us-ascii?Q?h+Kyozpdt4CXkStjj9dUfAqbgrXQYQNIAznVBo4dus99EjpkDk1SMLVz6eJd?=
 =?us-ascii?Q?2iYlupenkS6ee4OKWES0llKLAtExhu1OPEZk6ll9UjpJ/H/3+VH2a2eSE17Q?=
 =?us-ascii?Q?lc/XuY8oFb6aOmYa83AAx27D9A3uwdnnWdTxUZ2Ay9K6IMalwhOPjQ06LzFk?=
 =?us-ascii?Q?aYkGdQsZp8SML5p4hAXKWgrGySZDBmi+FHcvMIXkZnlz0G8lgfPkux/8stnd?=
 =?us-ascii?Q?XJTxAa2oG3kBFOFh4Z0/SIKD/mbqZX2qe/+7IGJYeJSu1aJBAgSwc1cZfYuT?=
 =?us-ascii?Q?cleiOtZA9bnsHTjdj0OiQKhVvaR1LRiU6B+g7FF2UgQ98rckBqwxGsIW0Bdc?=
 =?us-ascii?Q?k5k1sn/w/JVZjewKl/7ghBtqHP44eV+GRDZ59JBIr0t4jiu24hkdZxyq9UQ1?=
 =?us-ascii?Q?6k8sATiVjOE++xmaoVFckYH4KG+tiP5+L4Zx+XIFqUtT7ovCgAqNuCsCsp59?=
 =?us-ascii?Q?+Igd5PHVuE2seyxw86NEe3vouPLn6GOb7RLWO1c39DRLHTdxvw2QFCIBYBXI?=
 =?us-ascii?Q?ohkofzEZwy+K8D0pcqnmdwVEpOCV86jO1xBYGalk6VAaDlHtSbf37j7NSIzn?=
 =?us-ascii?Q?DRXMIxINfE0VeKVrJlqvGYsF+SpyQlBD/oJYW/0UTodI49GtmmARwIjXv89i?=
 =?us-ascii?Q?v/4c4iRh6xaGUJTCUBO/cL7EpwzuUIMVi3A23noX1c6eMt5R2qY34mHy1hbW?=
 =?us-ascii?Q?qJTHQcvS3wE0HqgMewaUw/GMIOPoL4UPlPsxtxewUd3M3SAk8ni9t2n5Srjh?=
 =?us-ascii?Q?kdyykeortf5tLhum8aOVONW6qA3WaFdPmLQoHYMf0E8F+YZQWY1T8n+CTt2l?=
 =?us-ascii?Q?YFRB4lBXQsWT3Cv4ABfl1Ui+QM4Rha62cbRIJyTu7hOg45nVzc7YtJGlj8tQ?=
 =?us-ascii?Q?bgrJvNjT6g+53C8VrH5AA6T0sZbhoQWV3aEGVo/oPl9voYbql+JwkofRpj+J?=
 =?us-ascii?Q?TIor0IE22wGv8F61dJiU8Q8kqoseeIEZZlS7LNpzq1VFznmLc0wYAyJYk1hA?=
 =?us-ascii?Q?6cFyH7NXrsiytSg2MntwUnEANBAZkO0FRxWUT/rBkIm9+at2ZiVK5IEwZs8O?=
 =?us-ascii?Q?daX4p09JUioY3GJlHCI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 584f2fa9-3bca-4731-cc43-08ddb2689b2f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 15:14:10.8190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DIPtLfCr6R/NirCEtB25CtzkcWNX8lV7Ik3fxfpqCq4mfT2r2OmgZGPbRixe5o1/5IH601zgf1vDxQ9FQvmAeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8735

On Mon, Jun 23, 2025 at 03:25:45PM +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>
> LDO5 regulator is used to power the i.MX8MM NVCC_SD2 I/O supply, that is
> used for the SD2 card interface and also for some GPIOs.
>
> When the SD card interface is not enabled the regulator subsystem could
> turn off this supply, since it is not used anywhere else, however this
> will also remove the power to some other GPIOs, for example one I/O that
> is used to power the ethernet phy, leading to a non working ethernet
> interface.
>
> [   31.820515] On-module +V3.3_1.8_SD (LDO5): disabling
> [   31.821761] PMIC_USDHC_VSELECT: disabling
> [   32.764949] fec 30be0000.ethernet end0: Link is Down
>
> Fix this keeping the LDO5 supply always on.
>
> Cc: stable@vger.kernel.org
> Fixes: 6a57f224f734 ("arm64: dts: freescale: add initial support for verdin imx8m mini")
> Fixes: f5aab0438ef1 ("regulator: pca9450: Fix enable register for LDO5")
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> index d29710772569..1594ce9182a5 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> @@ -464,6 +464,7 @@ reg_vdd_phy: LDO4 {
>  			};
>
>  			reg_nvcc_sd: LDO5 {
> +				regulator-always-on;
>  				regulator-max-microvolt = <3300000>;
>  				regulator-min-microvolt = <1800000>;
>  				regulator-name = "On-module +V3.3_1.8_SD (LDO5)";
> --
> 2.39.5
>


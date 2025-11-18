Return-Path: <stable+bounces-195111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A19C6A87C
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 17:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E0BB4F4BED
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 16:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F6F36A039;
	Tue, 18 Nov 2025 16:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OzwyKbTP"
X-Original-To: stable@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011039.outbound.protection.outlook.com [52.101.70.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358BD36A030;
	Tue, 18 Nov 2025 16:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763481852; cv=fail; b=BC/idQo5X3WZ+8XfuZPpCQLt/3QELTYEGZJWL3pdjhepXb4TBUhq1HMFvKVWI/WLUbJWWt72InBUPImdTxy7+gsrJJ/i27wC3GEkwh+KH9FzdlWDYhdVkyZlEDgytI9TT1QaAp+SOoGWeJdfgulDfTJxHKvs6izalib0c5IbpBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763481852; c=relaxed/simple;
	bh=Ay9abSLjcppkMqydL0nWKhDh93sXubgqRpiwvMfpnIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GNvi/sL8GhMloMH4BO6ttE2TUBhMzRh7XL6JnmNT45XMWURxR5jY5xkFCklWOgeBFDp8fHl3u3zHEQSHWTRymMVdfHEV1YGfWXPKX6+T2iWT68IcgQDwQUKQErRV4iHGkZ/fEOy8HXqnt2fRYU78ePYfQ6A+ReyABW4Ih+SoxuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OzwyKbTP; arc=fail smtp.client-ip=52.101.70.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oyK9Ln673Ag3unhZMfJwyJyj3iRAO2T/osxDns3AepP0HnNrcPuvxLqR8+HwEUPEt4G81hM2TLb6iGxOtpM1yYa8X725WriXTb1ZMQAfvYBeOXSW+0jObQa19BBG1ApPuETXyaAmvlazmGoDtWpQgXIMYHKmdPlRKUeIjzl9lNaNhFwGBNtVt557mXWeSHBCHtDT77UmbXd+AC1aDRQZ3/2LU1zmA2vCiXLmvgbk18jlA3IB6mdeDh8c24ie7MXYD7HyJBOd0vtF71jxcPe/lRu4mPybUGUC8IhFJo2kvC7qMjcoXi/ZMByHxkdxKJjfwZVGNDs+Iw+U7kWBj98MRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bcRK4P7z1FhP0qw+tdzlBxTfheQR7+rc6pKJPy59eI=;
 b=gP6M4dV2YqGrPRGZlW1Pxz33/uAB3krqyB9NtLP6oWGuBb7Yau/u4xwApRleQVfD5/cArJdQdr001yGe0LvIeukpbu5qPAo/BCxKlTxMLvYhXFVdyXNVlUnEGuD9wiv56t9P0RoGy59wHyR1AC19bopJ2iG7hgIl1LlMG/tY8fYt94aNu8fZPT+QX+djlFSJgWHUnQgOBcU1FCEuHV1JNu6J4zMjJYPFQZsk1KECMzo/DEQWeqCBVJDMfY3sUVDs4ncu8Mn8lZPL0Q8Nyd5LVyg2t71JJNR5a8V5pqNY61oJSVFpPJtKePFCvH9QkqzDPlaRpntpqeUbZgG/SgwTaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bcRK4P7z1FhP0qw+tdzlBxTfheQR7+rc6pKJPy59eI=;
 b=OzwyKbTPuY/7bRE7L+kLPHmkBveRCiozW9NA5SmgJy9vGaD81Bb18AFXRhPVk7IGTKbDOLwZfrWfybaPsvqh3QxhmDr9O/dZALfmgARXzzJmWP3PjF9N6IC4xC/hZB9q9xPcRcCIj+sMRZcg9dq+NEKanYPUuT5eep79DaX70d62t3g1cFjk0dD+MvV89S+Z4MwX6NLEPiJGz9/HXrqYPEcCKHj+bW7HW8PFkhcRwSCc8pXgHvgXQulasdDiG2NhihqKiwkL30jcLbz0YqkhyFpmdI9KCi6r0CZDPrQsFfjWDhE5P12pNTQiZHNnBQ6P+a10wyvFQ5g12KQ29flayw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by GVXPR04MB9733.eurprd04.prod.outlook.com (2603:10a6:150:119::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 16:04:06 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 16:04:06 +0000
Date: Tue, 18 Nov 2025 11:03:57 -0500
From: Frank Li <Frank.li@nxp.com>
To: Carlos Song <carlos.song@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	s.hauer@pengutronix.de, shawnguo@kernel.org, kernel@pengutronix.de,
	festevam@gmail.com, daniel.baluta@nxp.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx95: correct I3C2 pclk to
 IMX95_CLK_BUSWAKEUP
Message-ID: <aRyY7TIAIJW6nlG8@lizhi-Precision-Tower-5810>
References: <20251118062855.1417564-1-carlos.song@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118062855.1417564-1-carlos.song@nxp.com>
X-ClientProxiedBy: BYAPR02CA0032.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::45) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|GVXPR04MB9733:EE_
X-MS-Office365-Filtering-Correlation-Id: f892a73a-e105-4262-42f2-08de26bc1993
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|19092799006|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wd69oQO2aWdPFmfiLWzREqh6d0cO5y8zRMT0nhDK1TT1mS1YA+D3r1W5ysyL?=
 =?us-ascii?Q?qOuk+cWLg5XzgMaSGSScnyqoXBsmGFqGDBkpUHHyGGDdcjmp4UPlCVOIgm+f?=
 =?us-ascii?Q?AvZyvYD6B7d7LwZQxET6HYL8PBVL/v4lES4iqErOCM9ZI9v34IB/CietDMOM?=
 =?us-ascii?Q?eipGxpMIe8fe9h5o0cpRJ+ChAOKEkutuiYrKRbIAepkbKzFLlYs8dxP/38fj?=
 =?us-ascii?Q?vKd47KNt8AhLqOPnEVaewcNmFlxYx5wRW9YRahHRhpajpmxLhk5DYn6cr416?=
 =?us-ascii?Q?JY91QwHHOcRVvQQA7O/TrViiYX3p1vmft2Bok0gsOyAFY78CUj5CgNjT7xpo?=
 =?us-ascii?Q?MoNAyUhv40nJ06qfJuIZVbHTGIO5dWmJOS80ljI5TN3lxo4fxKr1hF2SACe5?=
 =?us-ascii?Q?ftsv8KEx1zmikQUA5NHjNU0ZBWlAQzwMuf0z5UsVllwNFFqeJ5dSAquNsvUS?=
 =?us-ascii?Q?bGsz8TcX6GX3BHUyYVHG+cPi5trRl/dAoQ02FAKYeZ27uQEcSaJG//HoF/pL?=
 =?us-ascii?Q?jkWx/F+y1T4QhryH5Cm0n1Jv6xBThDm30gzoTW+IKEOYCZI4WWnUKVPwddNM?=
 =?us-ascii?Q?ie4PMEvMH2bbgBZkO2o4F4MhaBLfQ9f2SC2nkVio5J6doesgZ0GZk8jWEzcw?=
 =?us-ascii?Q?EYqvW9nInkLmEO6EogaZNNklOqlp0nNH9xmY8P4CESsVy3KHhqiMZd7BMNpc?=
 =?us-ascii?Q?tSmX/ryHu3urG61XVRLIenjDjaqBrw+pVeMXk5A7JGL8kewi3e4xnsg8pSWx?=
 =?us-ascii?Q?9Yw4ysHYP9FD9hex+cIg+TWo7EcYwDqPZEI0WDXCk3gfpPhbDkIGnDF85rXG?=
 =?us-ascii?Q?DSmZPjtdJAHmDr2Evg0NIHoWUwMk0PWN5M+j9koEeQRGsig2Ct9ZaU1iMFhP?=
 =?us-ascii?Q?YpEOi01JSbwiQ3OpDfBAH72WbDsAGuyThcRm2SrxEvQGl1RNasTTe/+svgGr?=
 =?us-ascii?Q?cFaawwaoh0xH4jCOniFMPaF6cG0RRjZK0g7qAI47AQGmx16b6A09M1z6UAUc?=
 =?us-ascii?Q?zED62Gauha2sx9dL5m6s1Z6r1nt+F3RN/koNPpyljzCXA0PmML/WJYQSAPgO?=
 =?us-ascii?Q?pCyZaScvrt+GAtbz0FwpVcZo1hWTmsyhWCUeRBaQCGtSmflP+QpddnZ64AoN?=
 =?us-ascii?Q?KcKEt4giLuLE8OJ5ih26iA874VTZo4QIi7GoQaS0f3zod2UUGDydXvm7tqSf?=
 =?us-ascii?Q?aPDWkiS2YVQhJ78AA/H2Kv+cL2LaQ/c1WZtQjlzIQ3HGdsXzIx66t9Jo6pTB?=
 =?us-ascii?Q?hDXg1uRVkiHrCTbe5cJSKKCyJxmYQ4nIHMoMfjQe0P8+92vI4v0QhsChBOJm?=
 =?us-ascii?Q?pXY1Fhv+O+NfJ4lf9MXGoKZZsShX1r6JdFnz8bmCI+sRf2gy+c7iDk7PpDNg?=
 =?us-ascii?Q?aM+Hho+ZSzBpXmhYeKO7fvEP8LPkrZ9qBetD5NTdozMI8dbCTNNjVpp/JclJ?=
 =?us-ascii?Q?9CoCvKUC09Kc4jMNbemeS4aCrQWyO0nQmbrZZX3Wk83CU5jKEVG+xv71Ta3p?=
 =?us-ascii?Q?LD8JSs3Q/Cs8DzmbRUlUytgt6o8+26aODTot?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(19092799006)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ap30wTOqY2Nj/UcFMJ4PveRnjgGogmxKzYtgEdD5+C6o6wBva/dx9/qN5a6/?=
 =?us-ascii?Q?MDRaH+vFdCGu6wjIGuoYuUfBpeY9RoHModXHby4xxJf2GaYp2B3FFA4o2DK4?=
 =?us-ascii?Q?ihIFt+fJlABg3IWQpDo5OjREJr2tHrM/kRYPc5hWDdJcd9CHPzJz9v4yY65t?=
 =?us-ascii?Q?bWJyy5v/orv2/zSb/QdNcaa8kf9e5zOC0fdUHvgIcKQ1Mf8TrSmHonXGc5aI?=
 =?us-ascii?Q?PYZlbsD8/F1aCuJpGJB1za/BQDA1xlS/3LAW0opa1ErvjQzG0iVHjQlip5mn?=
 =?us-ascii?Q?oBQxZq2wXpeWvr3PAOFwFWd7p8NqVuRNBGyjkpXs+ITrK4b2CZPs/lAeEdXc?=
 =?us-ascii?Q?sDGRDQhPZHeptVnl0MrCNeZAjWj1zBcOlsf57rQRYaGMOrlxDfpXsC/BkR9O?=
 =?us-ascii?Q?kqty9cD3rAkPwGY9PqYn+SnQBNNuoljPrkbOJpINtVieeIOVq8JpxCAtDWHP?=
 =?us-ascii?Q?bxCJ8dirdG5LoKP+xu2tol3b06vnlZ2F0YTEvP6XlkxkD8CpHDAQtDS6lrlW?=
 =?us-ascii?Q?4l7q5k4KV1etY1vt3ZmFdMJ0N7Zjj/tvvSGmyxRTO3umuU2ZM9XSmD8o3n8m?=
 =?us-ascii?Q?L3n2HRhr0avCg2lpa4CZnkk2grMB/m1wNcspfLS7HSWtw3XuwEVZXysofewp?=
 =?us-ascii?Q?ixECq5I9N2VD64r1iYZDEn/cf88hsNXyz9OwDPmrAOUf3EpXi9ayNWuZmYR4?=
 =?us-ascii?Q?V+Y/Bb1jE+2fuF4kIVoWURf1hidHUMLtWmBk+219JeXY4EpZDb7sbqC9HshO?=
 =?us-ascii?Q?Yoz3yPjkPWdaCdTwPJLy8YudWx22lHEkTKY3p8O+gGMZ0oZYWcdl6YXHbRv4?=
 =?us-ascii?Q?BMNZ5dVZks3Z7zAMbwkVxGAhzPqhADiLa+IipUVH3QrC94+jGvUEvn279Pa3?=
 =?us-ascii?Q?OU+0245i9HHMvoabZDreABUjkd/thUm/Q6MAgNIcs9ar48aew82FSVN2rmn4?=
 =?us-ascii?Q?zM5XSSuZQ6d8pcPp8ZApJ6CPruIcPsvrDvebA7Ui+ewiG2dAZcs/jgFTeMtS?=
 =?us-ascii?Q?bTpgY2cgow5mcQVLfcmOyUm15EE4jh+PicSmqYBArsk0PvjVnB/mFmc73u6T?=
 =?us-ascii?Q?qUtA9Vw5WqgAFiplfvxNN9WyCPuPndHfNgfwsE7mZUCWQ7isd+E2x7zwB50I?=
 =?us-ascii?Q?L9YsNEH76tvyBkBnJkmvFKo9M/2+QXr1+Pv6mpX59ZazXKpHaYbVEy2/jgXL?=
 =?us-ascii?Q?guwT5Q4pSULYTREKTTTOcFUx9l1NHaZROOWSNGafDtCZ1v4BbLeN7C5aWcmd?=
 =?us-ascii?Q?JmAuucEfRYfOtEmILzvXRbdzBRpGPEa+vHSsCzC8ulnDwn1iQXDFL8kltJjx?=
 =?us-ascii?Q?W3gr6dNEpCWTX+wMaS+E86fVRf7pczWWkLBfoz9XNKDZWFHf3nn8sSDhBlCW?=
 =?us-ascii?Q?BovQk43qkkGLVGzijWCMTt+r3rSwIRSzWDFpH4k7MAzXR6MhFkwrdul/6dBn?=
 =?us-ascii?Q?MF28Ot0N79EEb5LXygvEYJ13MU31APzkt8Dy4OZmdOdpa87C9G8xWAzj3EbW?=
 =?us-ascii?Q?h3Ue5q81FFMa59NE6PuHJ87p7IPRu/Q0jhOxLNygTJDdJRxxOFfYk0PgJ4FL?=
 =?us-ascii?Q?wL85ErLeg0mPjC2Sckb7gKiv21fOXn53Xd+Pxr+u?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f892a73a-e105-4262-42f2-08de26bc1993
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 16:04:05.9316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8JV5zyCunpv4f3pwbFYRK/ULL8uCeHuMpArjW8N8RVqmiUaIIUtTajUdVZmmtB45aubg1rvm8NsImOpo1mVpGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9733

On Tue, Nov 18, 2025 at 02:28:54PM +0800, Carlos Song wrote:
> I3C2 is in WAKEUP domain. Its pclk should be IMX95_CLK_BUSWAKEUP.
>
> Fixes: 969497ebefcf ("arm64: dts: imx95: Add i3c1 and i3c2")
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> Cc: <stable@vger.kernel.org>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  arch/arm64/boot/dts/freescale/imx95.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
> index e45014d50abe..a4d854817559 100644
> --- a/arch/arm64/boot/dts/freescale/imx95.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
> @@ -828,7 +828,7 @@ i3c2: i3c@42520000 {
>  				interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
>  				#address-cells = <3>;
>  				#size-cells = <0>;
> -				clocks = <&scmi_clk IMX95_CLK_BUSAON>,
> +				clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>,
>  					 <&scmi_clk IMX95_CLK_I3C2SLOW>;
>  				clock-names = "pclk", "fast_clk";
>  				status = "disabled";
> --
> 2.34.1
>


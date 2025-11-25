Return-Path: <stable+bounces-196868-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B7279C83A86
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 08:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E9934E69E2
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 07:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B475B2D838B;
	Tue, 25 Nov 2025 07:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QxrhMTyo"
X-Original-To: stable@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013070.outbound.protection.outlook.com [40.107.159.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60E02FB998;
	Tue, 25 Nov 2025 07:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764054697; cv=fail; b=gL2Xm8G1nNxb96brgfRsYUZj4rXr4qLW+TxE+0lumjzX4zsY1Y/X6zCDXYe1JhUEW+kUkC8ZPpAF4wBcXN9P4AqCzrOqgvzQyMxOYuJ1epHCkfc1bQz/uC8J4OQT4Aogsl6N+PE/8YRjfvaXI1cR+9gg2e7OLc+ZbkEB9JJZuCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764054697; c=relaxed/simple;
	bh=Kp62WUV9GFucVIXAUYZL7h60ZPyR/mT5nzDrIJyKMMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PN1LM3ka06jBSROQtlcWqHYuco9sqfHxMvXMTanYSlJ1GzbEzgJO6rl4Y1xgs1mNFBryqKfF9luWjbxrNLgtoYQ/fAcDas+ILNJ+KanANwfAJXtKrZZUmu7tBxxsHK1miobPX4mOVCdorMLIptkR4zvCFPIom3ollwpLRtibzwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QxrhMTyo; arc=fail smtp.client-ip=40.107.159.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6sr90P5qvg4hhRJvy7uY9ws7jZcTNzLvITqMn+0DRmgSDP+osRk8t678DY1uNIqqPLQqM4PmgWEUq1k6ZkKl1Tzs4Uvxc5DlxpMzjzCT7iXKKvhnRtdoHWBkpmzC0hXgHa5gJy97ajKmyeVb03qjSoUDOtgeKtJhXAm/xLYR952eLILQ4b+HPDes0BSUY4u/SzpqEi0JIa4npApNjVPNQdVehBUlNn6sJetl8FAIJ5CEh3IBawyKXcywhhx5daaoktMtdcLyGzqmmdCFk3l2Cbi6bTDRndcUa7x4Tq/0ydOz/hgh3wph7RkbAbDnc0RiUHfAoJqAxB2Rr08HRj1jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHnUU4Pbd4HWzL+mhH84UgwBZfQ6Z/mabMQdNRk5vi8=;
 b=GTT9f8MmduXpMeQqNIxaCi0z1N2UIo1LJfnH3xicIXhMDxXdE2GdAb9NL9DdA3b6t+FTEMb80CGiaWnYHRZ27Zazo1eUe1u/jqPNZK9leTxby4p4ElHei6/edFDnCTXcN/O6oSSLQz5WMzqSeVwJAdDRvqyxWQDhdG5xYGy+uLI49ocFSPNmTzHTruUrn4WPRXLQ3vs7PDVHxQ6PipZkBvxI8kqgHWMlHgaSNMZT2Hmlv/KLKtbAYz92AeUfP+2Nhq3xVfGI6oyeZCD8R+eTiS8B2bvs7ZRKwe9jITsYb/4fgQS3CuDkhakWm7RC6oCS5eAo3cR3jV9/cuLR0s18YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHnUU4Pbd4HWzL+mhH84UgwBZfQ6Z/mabMQdNRk5vi8=;
 b=QxrhMTyoMh3B+hfEW+7alt/wnZqNoQ9uPL0U7EeBzHWR0Y7cFDQNtoaJg1N6UDPq4spVhm2zIcwWtTeaTbMjNY6Jmi1vUKh6oMwC11PfolWJ5U3iq5mkhrxD0ha/XayoQ3a21bq1CYseKI9VG2LxuCJ2ze1pToGbRPlHvkPImryW72XvTm2COl4lSvXTU59IKiHzg4HhKDrUYxRdYbEDPNsJGwcH99c3rfX6zuDe5wpnWtZV5SE1PugnINDq3Om6ukAeaLcfYxRl3R9xI+ioU4BJ8uE/GHHRzl6/qUpZnW0hhbhmLMqGNw1oDIiUUCbuD9FYr8C1Xq/XHwiQzpHRWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8825.eurprd04.prod.outlook.com (2603:10a6:20b:408::7)
 by GV1PR04MB11064.eurprd04.prod.outlook.com (2603:10a6:150:20b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 07:11:31 +0000
Received: from AM9PR04MB8825.eurprd04.prod.outlook.com
 ([fe80::67fa:3e46:acd8:78d0]) by AM9PR04MB8825.eurprd04.prod.outlook.com
 ([fe80::67fa:3e46:acd8:78d0%3]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 07:11:31 +0000
Date: Tue, 25 Nov 2025 15:04:43 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Franz Schnyder <fra.schnyder@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Franz Schnyder <franz.schnyder@toradex.com>, 
	linux-phy@lists.infradead.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Francesco Dolcini <francesco.dolcini@toradex.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH v1] phy: fsl-imx8mq-usb: fix typec orientation switch
 when built as module
Message-ID: <w2dpsbfspr4od2j5seidi3tcpo3r2revhahhxiuacqehkqy3nn@2zjb3xvso45d>
References: <20251124095006.588735-1-fra.schnyder@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124095006.588735-1-fra.schnyder@gmail.com>
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To AM9PR04MB8825.eurprd04.prod.outlook.com
 (2603:10a6:20b:408::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8825:EE_|GV1PR04MB11064:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e352b82-b87f-4f30-f71d-08de2bf1db52
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|376014|7416014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?OFXFYR68vdbl2Nb10U1nmIMOC65RebRpwATJ1hPz/Du5QhE3dc3kvbNGF393?=
 =?us-ascii?Q?YHmpZMbFLN9kXGcdC715+5dJzCHSacnEs8x7v/pi/eaxHdHroFV5CBxNMlpx?=
 =?us-ascii?Q?fme12hhDtTSOWiJwKkPbXyzOtlyYWvJJOmVwLtxZ6pIlCKpumpyAXib8yM0x?=
 =?us-ascii?Q?70AR5S9v/y9rM0rm7/+laz57GE/Ja9CjY6+UAlG4BO82cStBfXDTdT4DuKay?=
 =?us-ascii?Q?RhGIPs0yWXbEALEwpuYmPg22ejYp0566oIf0pl/FxEYr3xOYZegWKZfvI/zS?=
 =?us-ascii?Q?irVRdExdOycWRpQ0GQc9J1I2VC+E7wKVf/DLS9HeriErcYytBbfBYmLQ6+ia?=
 =?us-ascii?Q?gqhBiq1lEaPURik7UTD7irHtXxtKvHdy2HNZGNIASBPBjpIfHgPjgU5JWNTx?=
 =?us-ascii?Q?2ZjAawZqvU7LTSHGtnGOf8y/yAaLcaxKqCaMDSxW3JxeozpNBxmpdYF/5H1o?=
 =?us-ascii?Q?78fzA+YV/Yw9/6rKvDwJcw9thdkiLwcTNugFn+mzFp70qUdjD8e0J3Xy7Fm7?=
 =?us-ascii?Q?Jt6rw7/WIlQFgmh953uYfeHnTfQvlrS08loKAFAZRYimfskCIZIBmL7MOBje?=
 =?us-ascii?Q?IV5AoyoWd5XQ/rsxtXwBlWNASPr6SrZrYIYAtLBXRO5qFEy1yoW0+zuR4mBg?=
 =?us-ascii?Q?1RRv19q3SyuCXEbPftOniSx9pB0kitPJ+Xy/gRLQ0407bcNQF2xHjGm740tr?=
 =?us-ascii?Q?aH+MlG6tkG7bnXgTX+S5qh5/j/ot/Lw4YA6/RYw1Zs+puFir/Fvu+RnK4sVy?=
 =?us-ascii?Q?HyCSNxULQLg1buqVqxiwuwXFQOS18A+1cH9G08BQFiXWLJTRM69r/DvQfkSJ?=
 =?us-ascii?Q?popj3avKxpNI6blv2+bzdaMEk1f7YDvLWNkGPqW42+dWW75+1Cxs3m+GOxuZ?=
 =?us-ascii?Q?s+FY0qLYMHJLTvHKHDUyMf6mKz+in4JKGDGbI9V0Atv9HxEjSdD3FGCSe+qU?=
 =?us-ascii?Q?Dg+I27VsSzCydgMkyA9TUGgZ/EHkM2wonBi+1iIeDWrXmSkwKw2Zqb/06lGD?=
 =?us-ascii?Q?cYofblsWWgNqW8j/pi9MA6KRaxo8OhELYs2ycKbiXbQKCHAxWBGOUgzeIhNf?=
 =?us-ascii?Q?+AnBMLxLVlRur3URcvSvAJZLGKIScBzOGw63jDrvQ840QUcuCkntyfVOGs16?=
 =?us-ascii?Q?pAzhsLhWxIf23fyFnRL59tyg6LFtKrb3pDDQymc5pKzdwEuHWRVbLQTSxpAW?=
 =?us-ascii?Q?bpk1uNSscntlmBAmblmhfxGXF5B3kOMxj8YMdpojpJvDqLez6F7orz5BIh9v?=
 =?us-ascii?Q?1eFUZCbeOIISgMTrTrMRLX8aLzja/Vm77Fbhh0LzRf5Gj0lwkb2E0e5PaKr4?=
 =?us-ascii?Q?Ca0AhiO2MMCI1uqND0PXdhIu9AozmnCBpX4pZoy8tPNuIGPHJKtit6mzttFJ?=
 =?us-ascii?Q?dM9n/C0J+Xh0KLmwWUiugiixedJGDLC9fg9ft6WhMRLqFhj+8idklHJiWD2U?=
 =?us-ascii?Q?EUZQnUUzcWmP5D7A3Fvb3dXDW9b8/+LxS5T3ezx8Wl3UogpXugF1XxxnRgYT?=
 =?us-ascii?Q?fJpvKCSDCnjQ5KXSkGdpRJfXZlMZuZlu9Hmk?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8825.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?SeFxQdJBQvL1yTXe9epXwrYw1qBq42nG+FcjcR/UZJtraht2VVfUDH45E8AI?=
 =?us-ascii?Q?OCbGOHfHIgcPH3bkOVFNYp9OpGyyoqF5GLOSBQ/nzrdW5PkRIKnkihBtcKSJ?=
 =?us-ascii?Q?Y1oQ8oFGl7Pcf1WRSgvBcA6c63D6rY+xWzi5JKLt8BaD14Ahz469NEdegxjt?=
 =?us-ascii?Q?9hgJzOKkv9K/mk8GvsOacsBJb5jSs1EdlhsBPOZ0suxhOPoqGDbtAMJwXI/1?=
 =?us-ascii?Q?7HsD0mwMSnhMwv71LzGJDTYYxXfk4CuKjoE9GQWqkwPAwBkmqlL7ANy82jin?=
 =?us-ascii?Q?LxsOJlr72c4nfr2Cis8SwaXnJB5CMBGD+tPUcxI2emWAjpnUs6TIBlv6ec38?=
 =?us-ascii?Q?BGqqL4O9dH001/R9NUFsZYHw+No/mxuq+xymgIiIFHQLjWERMtzd3OBmipVB?=
 =?us-ascii?Q?DLyRkc/jk9arxXSfjxRUw0PAr/mAeV/vl8LklqRjZOobx13iZXhWW3ibw2aP?=
 =?us-ascii?Q?8MNyxtWWzwDq86qQscoegJEmnL1fmaG6zAtey91iEApLMThtWcWOfE7J/99o?=
 =?us-ascii?Q?WRshkGxaPE9lUBXTtyZl2FjXg0zABx0KtQc2fks/xlr7S4waX4YpLHMpV3mG?=
 =?us-ascii?Q?9DE7zAtbkIVa4OajyAWgMLuaDRrwvrzMpP5heEKRe9X1FuWoB4yGRmbXnd/l?=
 =?us-ascii?Q?oAwbrc2oGskTOTENuomzO8iuzVI5KT3AmHuoSsjx+SeX+DtR56b6aA3c+ZvD?=
 =?us-ascii?Q?JGILK2X7KCEUWbiJKZhP51Ctbd83BW2BrSJDKYQww2XMP1HmuKP6fGgaSI7P?=
 =?us-ascii?Q?OPD1+KaK01EwxP3FidrixSXTuO/qtlCpsV5XtYJ5M61mSkjxiWJc64+qXm+H?=
 =?us-ascii?Q?wE0IVSeaPwgiX53FWnaNCJcCVLEcYYLA+kppASPDb7M7Xmo+KH3WYd4Nu1t3?=
 =?us-ascii?Q?HV4W0ByoZ3qbCcQCkG6jtx1XJzRPLfZlDOrg0mFbcHV9iYldE+y8hN5W1+jd?=
 =?us-ascii?Q?bA2pf+so9++5c/Z3Fr9JNX5+kdWCgkz7V2sg6COIdYiJDJdLr1w8kCXDiuDb?=
 =?us-ascii?Q?4gvS33zOj12uyunFNhbpXDP0k+6RRyJxUW3+ThW9PBhyeiaPB0iLwj//682D?=
 =?us-ascii?Q?pMZr4m/NlIlX16LjNqDp1mKdbRCgB4Cw2vXa7+2Q8T5ZodLcxc3sRTKekaK3?=
 =?us-ascii?Q?K1reSVpxq0hKJOkJYYxcBXExT/CaTiSM39H0TMWlCRuWAL2P94lW3TiRw6cS?=
 =?us-ascii?Q?s/8e635q7AyHNel5ytRR8CQ7MGzcK5G6eyZSsAfnlAFnKMQLlOAmr6PawCIX?=
 =?us-ascii?Q?fLlnECNRULFyTajFcBPurcDLzHKl4bvNwtXYePipLhGR7ybGQiBIazr+M3dZ?=
 =?us-ascii?Q?fGf+Zko1zCDrBWuI9g6XWC70oGVvXE6jz+svrUsRfgqEqJ7kElrfdU5vG+OI?=
 =?us-ascii?Q?f7Y2kCW2WDCujdZ86oqfW0KWhUirt18Gyl2piM8+Ww6XC7PqQuNEZEy5wDX5?=
 =?us-ascii?Q?E/HliGRL83BkGe5x4pxE2GK5YgQg4ipPQBPmgXYvuIN5791a1nQqYzQEGTft?=
 =?us-ascii?Q?WT9NoeqNCV718Z1wKxMU0DSKcvQPFDqqoeksvUdn+p9w7KITL4NACaYtF/A2?=
 =?us-ascii?Q?d7kNC1X+bUeIpafj9trxwwqN9+jEWieWPLyVDYBd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e352b82-b87f-4f30-f71d-08de2bf1db52
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8825.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 07:11:31.3032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cRdLOABmuwaO6llbKLrB1XWXlSPcmqXIjBIk/YEOfWe9i8Wg4w+pBHSAXlL0KsOorRarMsp4Kovez6wIFQhORA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11064

Hi Franz,

On Mon, Nov 24, 2025 at 10:50:04AM +0100, Franz Schnyder wrote:
> From: Franz Schnyder <franz.schnyder@toradex.com>
> 
> Currently, the PHY only registers the typec orientation switch when it
> is built in. If the typec driver is built as a module, the switch
> registration is skipped due to the preprocessor condition, causing
> orientation detection to fail.
> 
> This patch replaces the preprocessor condition so that the orientation
> switch is correctly registered for both built-in and module builds.
> 
> Fixes: b58f0f86fd61 ("phy: fsl-imx8mq-usb: add tca function driver for imx95")
> Cc: stable@vger.kernel.org
> Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
> ---
>  drivers/phy/freescale/phy-fsl-imx8mq-usb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
> index b94f242420fc..d498a6b7234b 100644
> --- a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
> +++ b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
> @@ -124,7 +124,7 @@ struct imx8mq_usb_phy {
>  static void tca_blk_orientation_set(struct tca_blk *tca,
>  				enum typec_orientation orientation);
>  
> -#ifdef CONFIG_TYPEC
> +#if IS_ENABLED(CONFIG_TYPEC)

With below commit:

45fe729be9a6 usb: typec: Stub out typec_switch APIs when CONFIG_TYPEC=n

I think this #if/else/endif condition can be removed.

Thanks,
Xu Yang

>  
>  static int tca_blk_typec_switch_set(struct typec_switch_dev *sw,
>  				enum typec_orientation orientation)
> -- 
> 2.43.0
> 


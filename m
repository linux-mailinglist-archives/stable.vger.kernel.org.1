Return-Path: <stable+bounces-196871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C51A9C83D87
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 09:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23B5A3ADAAF
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 07:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFB92BE7A1;
	Tue, 25 Nov 2025 07:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y5uU86Pa"
X-Original-To: stable@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010038.outbound.protection.outlook.com [52.101.84.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3910B2FB637;
	Tue, 25 Nov 2025 07:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764057530; cv=fail; b=jhL6sw5PM9utD1rGwcIwd/3KchJYf/5l5neUmyjW4JwhEHiORB+eJmsqJQI8TCtpyObmIsJGpDhmsS3q6Wm5/UengnRxJfU3EdNPMSzdSz989Ck2CBGg7h8QzQ0ryANmVz3gX64Jb0wu9Q08fvitK5MNhq3OvXkXx9nuPPUZ7tk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764057530; c=relaxed/simple;
	bh=F9nEZXrif3yAPfK9VGweEZhk5Vycp6DLpJCfN4DcS2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fp3t9roOHRkkYcxVARSZMwESJi3erkwZjq5ufnI8CfTzYbAXrjxR5XL4U0FI6GmHUMjpAshNAJDGp5ilQPUG1J3lDgPr8BWBcWqGGt2HvG44KPvJ1S+JkECctPoUP0blRq1n/2BPGqWoUTcy2dTJ6M/K3OO6vU/nBubCYnDISew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y5uU86Pa; arc=fail smtp.client-ip=52.101.84.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YxV36knawdg0gW3iu+oyl6xfSVSYO0BxgmQaknHCEeHhPh/FVO2LftQ7JeDuK7Co2sIEusdoWUyvhmx0yq8rl2w2DkBReWsamShOjs0oa1vvKJusGetObC05WFkgPj39K9seHxKbaAObraVQDOasTjavJxcqn+trxXo8T2DWHdsVJU4VkZ6BPLHzKTCaCKfcZjRcLLflsZi/nY+041NnpKU6CVJqHKbOjk7TqaZEjT5tDvuktUqLlpzkJV8MhARHa/vBJBMs38WIZk/9+qxwBDf9ZUv5Tw1XtBVoLyZOLmgOyMAVuki/q3h4CiHZk+cUnItyIZ2kXVxoEiKk8myhfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OirmIjUKENxPdU70FNmnmNoJlq3JWulXNqb6h8cf55k=;
 b=kaVKJQPyPzusZ5N7UUE4AUpPP+frXwlgrMi7HUBPOKzwxgc1+KgLDiL0L1v5N45/jYuF5shRRF+EKc5OYJzUArR+hpK2S531open/wJSm7zzrgCaqxE9R9ixe36t4GLt4gA9i63bjOJ3l1BQj467yu4Ks2ruC8pHEocgXKH1LsnQ7ocn0rRZOxH+EgtCzg2u5i7LSCmS4Kz19fUtDDWXDB7L+5vLal+8DFNy5J/wYI7QibWQ+ZiyAobdp4Tu5Lq+9cNjvS8K+A0vBy6JIXBK/gVp2tnuEk2jTEn7tqFojUWVhvtI29ZTcX0KD5zAXHNTjyE3OtdNCRA2kAwP0rAMHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OirmIjUKENxPdU70FNmnmNoJlq3JWulXNqb6h8cf55k=;
 b=Y5uU86PaDGzehy0ajjF9QUJiXILCNqq3LOrcsuaC9FMm0gNZbO0G3J7JVZAa6/5ndQvnuj7jKcZNSr8s7cUufexeT9/h1C6jFbWS/1/t+HUsrMwwxhsFlRev16pQWUCnr9b/j6RKDadih8FY4temKHBp+mdVz9jJYyjiJAnAvx773zWh8NlM446/RBHVzPi1+1F6wgqepT2QFwQgr/++0+gofzXzqwZx0S0iq5ykZwZ/rhURl28hPIt7n1kk+PJ2fJi0Y43XOGxRF6/8yhMMqkYGsMpaECmdAy+uF4DmNvbvgNFCCWhDwtC2CqkoHAYvnuYmiO1wsfTuQtsOpKarlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8825.eurprd04.prod.outlook.com (2603:10a6:20b:408::7)
 by DBBPR04MB7881.eurprd04.prod.outlook.com (2603:10a6:10:1ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 07:58:44 +0000
Received: from AM9PR04MB8825.eurprd04.prod.outlook.com
 ([fe80::67fa:3e46:acd8:78d0]) by AM9PR04MB8825.eurprd04.prod.outlook.com
 ([fe80::67fa:3e46:acd8:78d0%3]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 07:58:43 +0000
Date: Tue, 25 Nov 2025 15:51:58 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Franz Schnyder <fra.schnyder@gmail.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Franz Schnyder <franz.schnyder@toradex.com>, 
	linux-phy@lists.infradead.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Francesco Dolcini <francesco.dolcini@toradex.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH v1] phy: fsl-imx8mq-usb: fix typec orientation switch
 when built as module
Message-ID: <nk7hrpl22awyp7zqnkmqnlenj6hvc2itdpfepzdgcotkljx2fl@7vma3ss46juh>
References: <20251124095006.588735-1-fra.schnyder@gmail.com>
 <w2dpsbfspr4od2j5seidi3tcpo3r2revhahhxiuacqehkqy3nn@2zjb3xvso45d>
 <20251125072011.GA5375@francesco-nb>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125072011.GA5375@francesco-nb>
X-ClientProxiedBy: SG2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:3:18::26) To AM9PR04MB8825.eurprd04.prod.outlook.com
 (2603:10a6:20b:408::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8825:EE_|DBBPR04MB7881:EE_
X-MS-Office365-Filtering-Correlation-Id: 0da62c71-deca-435a-be42-08de2bf8743e
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|7416014|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?qJPV8v6ULSBgNAulh9CbAogrrPigR+zEPRveRiUv/I2lstuvLjvh72twx2xz?=
 =?us-ascii?Q?KpMb7dEjY2lDI8NTCYiZoNCWkGTmMlnqQDxY5RobcN8v/vjUWKxoB88BPX0n?=
 =?us-ascii?Q?//Ia+v+a5K+pIYpVirnpV1h20qZRWTjvw/mTZeRQtlDl2aHENJtbr1GC/CRj?=
 =?us-ascii?Q?zXlgLQm18o2372SqXc6Ri+SnTkt4xbKt20NWNs3QmFUIDtmvKPF2YVIgQwMf?=
 =?us-ascii?Q?eGuRHAGFLbGvKWJt2YDfOoEghHptAet1aRheoEXlpgdooP3mE7evjbZ31GbY?=
 =?us-ascii?Q?dMQ92lX0fuZuJKx8U9X0xG5HaIOe9XHu/tNZhVo0L5NbX5Hg7NE77y3ExM0Z?=
 =?us-ascii?Q?+1AaSeNmf0lwuCZApFcKIrVt+ueD8+akUeAy3B2DZlZ9NhXW/4YFtqbEfAon?=
 =?us-ascii?Q?gw8Nr8G4cj8wRwxiHX72q6Q+je4outbO6+n4pYLYhUNWMrqfUjCGhHeXS6g4?=
 =?us-ascii?Q?5QDErL/PSio+g+ra3B7TcSpOkQaKVToq2VG3/KJaWgH6GC0LK34HavE4DTZu?=
 =?us-ascii?Q?9/td+2YOUmcJN2BgTfV4uhhGQbaa+OIpoekmUwumxqeErC0LVjIdXmiHHeLF?=
 =?us-ascii?Q?KvoPjHSh3g9Io4OSL4KajfCtSaLMxqdk7ATWvMAl90Jp2GDjis3Elt4omvEv?=
 =?us-ascii?Q?L9GS9KoGJzlaZfZeaUn+A/1CiQc+5tzzFn9T1D8Vbfvx31b2YO1mA05cxPg4?=
 =?us-ascii?Q?/3Fx0Uln5dWhnfGKUEzygb3ogIEOvq2BVUi9O4xSoOVddNAD33mFpJfUPvqf?=
 =?us-ascii?Q?f3WfBNGWGjfFrsl2tKa6V7Ov15P827zHg/1k3I51ZK8HNM5J0YAax6rsRKwd?=
 =?us-ascii?Q?PaWexMXrqlYr+Z16RarPVjFJfUll9d2RBEOKbiJzlVCK1yuM/1ECzbAbtzo9?=
 =?us-ascii?Q?rr1sEi8RTW04lSdu0PrIQ0jw3Sp7PPHvil6Ch0WmFQd4nDJursHX30J2wwVH?=
 =?us-ascii?Q?cMGSw1i5mwpuT6xXy+Le7S9H3o8GV6EFpKq8fxbvsBIl1oZ2tkrV2QUOyHph?=
 =?us-ascii?Q?P+tIJiANNCqojlN10plU6T71yjqia9Dqap8zidywHJnfM9oAOzU/4tnWWLB9?=
 =?us-ascii?Q?bRNtCPTG94Jpbj+8DqCgjycaFt2RnHup74kUHFAPtN5f9VbR6ij3H1fOkvka?=
 =?us-ascii?Q?Gjkev4G5ySYs6JMSzb7W1iQHjXAynxnG754bBzKoY6XFv5k0XvPf43N7AfND?=
 =?us-ascii?Q?JBjZOYVDGG0A4MAozUlBWqHDxS5oNeVf4ElF1stlQRB62l3qdR+QMCTm/Tpf?=
 =?us-ascii?Q?PoDi8UTB3DNe8iQiWDs9zEtQigsQbY64pa5eQCcTzqHwx1vUzYKQCX+lTGMV?=
 =?us-ascii?Q?a5DmpI5h/nhJO2iWnGuWVh+J4Vhd9KKRqukGTMT5eLoQeBl33622bRiRFWA0?=
 =?us-ascii?Q?YTtrc2/gfYk89Y4jPf8OowizkQURI7OjAxBTbeuwO8g9fhD5fduYquL0NLVO?=
 =?us-ascii?Q?YMxBNaKz/BHKX/6PxNU68vaSZ0ZhPEb6VOdvjRF2x8p9J1XNMsMzHEWtavqK?=
 =?us-ascii?Q?Rf15XRvV+YkNI+5qvTeK2Ym0BOsQWjr7MnPR?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8825.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(7416014)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?dRWVTYihLALdmtCS5s7KFSyvKzlcG5YnnqEIlJrpQAEiZFh8/X1IWV9NmftV?=
 =?us-ascii?Q?XfN9gtWQwI2gjHt+wPgDQ84vsGMP4Zbi7OwwlHB35a5LKETrEDIwN7H/BaC5?=
 =?us-ascii?Q?XcmLAIVItKH0aOAr3r3J24Ml20yZp/KZnyOFCURHd2bLlz7PkIHgfNpY9GrG?=
 =?us-ascii?Q?bufUAszkQJtW1rJ4fPbVjzj7sBHAAmcqQYMecntMISnIgAIr1D8BVyfpfgth?=
 =?us-ascii?Q?3RyRjUvZkHoBNgjxHL1Mq1KUdF3tPQCxLzRH4Tho0tNqaXedMlwDXO0ejINY?=
 =?us-ascii?Q?dEF1hzxTXTEmaJXjPgjfzyYgtdVn02PxE8PMIT2QpbS+sEJWv4WyDs6Lfw+A?=
 =?us-ascii?Q?LZSqoCSTvcJAA8OzL8Ju4FdWPoyrosVZQOXkCHOeDWX/i0+0ZpjdpdF8pUAm?=
 =?us-ascii?Q?1BD9hunFeDuAOSWWzm+upe158sIefRSNxjm8aaDN5ijofgGeMRY9NUtuTpRF?=
 =?us-ascii?Q?6+ukywCx2zK7xgEj9HU6nYW1kkQvcIoTv0fdTf9l0gKkRl49Qli1F9Pldfsx?=
 =?us-ascii?Q?WFdIjqUp/p4LzN2NOVCZsDYCLcs7mT2//gs9rSLM1j9wG8jIMKUApCEkjolc?=
 =?us-ascii?Q?ZOdNcCal6cRCfd+Jm0CLeM8M8355t+gDprxWA8TEap/EDWqpAVAH3dPictS9?=
 =?us-ascii?Q?sVk2qhyo6zFvOb1inzRH9JlKCYKuK3j4n+BQsJqopw8ldno5/jws+47v/I52?=
 =?us-ascii?Q?/oxlqSv6HT/p++1ChaSZhb/9l03dx3yZlPqRL6BRunZTg5HLA7YJpXXxyKe7?=
 =?us-ascii?Q?Tw5gZ5YhrQ9ZBYR1Ia8XJVOWXrJF5RauEuXwvFfNnM+sUPtTnCq6GGSFoz7d?=
 =?us-ascii?Q?7BoIn+xxz3At4VJgGmOWNMfFs2/yH/lxx7LDTT2EvdKZkwcSCdTNeexDvqiZ?=
 =?us-ascii?Q?vNYXJfVvighZSOTsGb9huG0dsYaywWqLahaGySVreiKcPHP6wTWYT7loGCoP?=
 =?us-ascii?Q?DBeEqHZGZ+tf0YZgvnFsQfBKsvlgUiBXIBwtbFYt3DpWIHuMyEsrL1VeXwpr?=
 =?us-ascii?Q?h7iT7Mk0AfO+q/2Ks9NqB2rz1V1R/vkb/FdqHq5v1cH5ZhAOAtfEcIl0Vw3+?=
 =?us-ascii?Q?4v5CroSTQtiX7V4MgXfz9o5NZFViQ2mdYjWe15Av254whIgWJFURrXSYC/rr?=
 =?us-ascii?Q?uwY8e5yffmh3oLDvrmAVBdMbizJ2u2EkLh1igK5gVT5FPMpS/zswVh7KMmHy?=
 =?us-ascii?Q?F+B+kcSmNSuS4j8LjeGdtmM5f6OEodiAPO/IRZxG5f4sYfbEoVg1cuNKgy4s?=
 =?us-ascii?Q?Rr9JPqj8oRoZxuj37vyU5VDy5YrTKyq7KctJqwFqTYpAhGUe4mtdEREI816m?=
 =?us-ascii?Q?FZg4kBf1Ul/GRIQsHcvVYBIRH+YAMxPBDItqkj8+0VWtefhsfGp8j7vjQE0R?=
 =?us-ascii?Q?WHv8KI5QG2tMq6Ax9QEiNWE0OmsIaIvc2yby8aTltGaYlA782xh6kDHEUM51?=
 =?us-ascii?Q?PRa5nV8leU5gCDQG00NZ9b+tsHCM1Q7Wtl7H5DA7PoxOhsEkVeTMvlYO3VPf?=
 =?us-ascii?Q?o2v+XoVP5LHM9SBCQkvaPxDYQJjMJWVJIQBSLNQM8QanvWpwMwwpstSKgrQX?=
 =?us-ascii?Q?qQl0zIDRj+ie1yd51AAY34mstgZBZlF2cDk1DxA/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da62c71-deca-435a-be42-08de2bf8743e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8825.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 07:58:43.8420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L91VBbodQJ6uYUySdvyFHAQzCwRpRdyaC/QbkLDARRXeG4b9mjZBL5HTvSwI7EtQR1OxbjwkxX21kdbp65xAWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7881

Hi Francesco,

On Tue, Nov 25, 2025 at 08:20:11AM +0100, Francesco Dolcini wrote:
> On Tue, Nov 25, 2025 at 03:04:43PM +0800, Xu Yang wrote:
> > On Mon, Nov 24, 2025 at 10:50:04AM +0100, Franz Schnyder wrote:
> > > From: Franz Schnyder <franz.schnyder@toradex.com>
> > > 
> > > Currently, the PHY only registers the typec orientation switch when it
> > > is built in. If the typec driver is built as a module, the switch
> > > registration is skipped due to the preprocessor condition, causing
> > > orientation detection to fail.
> > > 
> > > This patch replaces the preprocessor condition so that the orientation
> > > switch is correctly registered for both built-in and module builds.
> > > 
> > > Fixes: b58f0f86fd61 ("phy: fsl-imx8mq-usb: add tca function driver for imx95")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
> > > ---
> > >  drivers/phy/freescale/phy-fsl-imx8mq-usb.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
> > > index b94f242420fc..d498a6b7234b 100644
> > > --- a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
> > > +++ b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
> > > @@ -124,7 +124,7 @@ struct imx8mq_usb_phy {
> > >  static void tca_blk_orientation_set(struct tca_blk *tca,
> > >  				enum typec_orientation orientation);
> > >  
> > > -#ifdef CONFIG_TYPEC
> > > +#if IS_ENABLED(CONFIG_TYPEC)
> > 
> > With below commit:
> > 
> > 45fe729be9a6 usb: typec: Stub out typec_switch APIs when CONFIG_TYPEC=n
> > 
> > I think this #if/else/endif condition can be removed.
> 
> This patch should go to stable, and that commit is not present in any
> such previous kernel.

Well, commit 45fe729be9a6 was merged in v6.18-rc2. Previous stable kernel
doesn't have it yet.

> 
> Should we have 2 patches or "force" 45fe729be9a6 to be also backported?
> 
> What's the general advise in these situations?

I am not quite sure either.
But commit b58f0f86fd61 was merged in v6.15-rc2. So the stable version to be fixed
will be v6.18, right? Then commit 45fe729be9a6 will be included already. If so,
I think only 1 patch will be enough.

Thanks,
Xu Yang

> 
> Francesco
> 


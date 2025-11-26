Return-Path: <stable+bounces-197039-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 789DAC8AC8D
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 16:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46EF63B8722
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 15:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970F9330D29;
	Wed, 26 Nov 2025 15:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NMmUKV8j"
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011036.outbound.protection.outlook.com [52.101.65.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260A53093C6;
	Wed, 26 Nov 2025 15:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764172709; cv=fail; b=UI437lvjzKsEB25+60iP65XBJIUrSGQbmZF2ZCMlufV0PXGAumsbKBzbEZWdYYkfs0pn/gu+F2VcBf5smLR24kZCIGj8tapdqjVahcnU53iGRcsUbLg1m30QTKY28o/IjObU3HoP4rLf8QXXgPKmNd0dyvJGVXuhg0wuwLgCybQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764172709; c=relaxed/simple;
	bh=ER7qZpERZiUD8j0dzg9rQxifjtOoqUt3I4kIxMJDeeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JboZNc6rl3jZUlMSDblXUJ0Icpv3ThUrk3Zti7KRveX4O0LyZNpDDmgUCC9suSQzIiOFAbmlTCuf/4+37LAnpUqpi4YAfPN52sgLaJig6xEAUSo8ePaec9Hfp5tXXFeomD1eLaME6ZTnpi1KbE9XImsYXKqRPIzcE6iyhKV82g0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NMmUKV8j; arc=fail smtp.client-ip=52.101.65.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dTmBb+irpDGNjiwwHnoIEG1jcWHH+cT/zdhp4Eg8qP6mGBNaeHrMkCKHLKtr4D35UTf8bMYbkzQmZX7D5/lsaWP4clEzZcubde4yjI/lTBEcXs5RHsn6hjfog+CV7AhuwxpFeX8o5MBSBpF6W8TI7XEd6Y+irS2o1OYAzXrWqaGRiOtmKd0jUUXd3/1jNDXf9dyZeOhHB/zdaKwu4NJKAeirPapuU8A0+bWWwfruVGNIi5Q/OV2fBlsvyjz7D+RxiSBr8YvDCj/yBvmxYgIzXzfnS6yzI6jcd+MQgCsdw1MphD5rR3JqtGn73neyq6ZLM1KEwIYpiwOsedaY1/HBJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KERdB35fdZJQwlTkaIBbWBNw1MQAyN5I4+Q3sKDn7oY=;
 b=JdPjcysr4LjSjadceeMNWa5vZw8M+nvunBuYJsxHNgANnb/VnHKtQKS+HZR+ZR4bS0Jf2uRwBPBpFmXW6bxalN2zpbYs91x7gPVZr/Wq6rMqPNJNGdnbKxtslprLmoQ56g/c5KR3KCpglGCBKUR0FcM8NC9C38duQSCc9bGGIoU129oWT7rOPwHa56BHPYpY93W+bCDl99Sec1RZhNriNsQ4MFOB/GA3YG2nTgNWJjL1rtOSysh4+mYUp7AbqIb7PyXXec/O3SsFkwJ//so9B7goTXfwuuwXc27vxxgWEMe210/5BX/2LT3dRyfwUUxvk5ELhBqYUNF9/HgW0Jf/iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KERdB35fdZJQwlTkaIBbWBNw1MQAyN5I4+Q3sKDn7oY=;
 b=NMmUKV8jCpHlpt+bWZHO1KPOAZXjGRiTwkF9yLGuJMjrxhd+JeZUxrl0DQhHQZk3Xk5IMfqoJe2u4aJDwTK0esPCo3OPbjb2oUWscOFJzH3I3jGgadRcwcZvC90cUVFkBCEJxlbGUB8hQlowU2P1NPg94pw6fLGKOGatsVmYw9l9FXB2eQaoO7cMRIzhSXQFtbBqtcPoYwfhteYR2wEUt0LrvoKh9LBbEQhaKajrW4/QTKuqDSaifJPHh6jfXSGEUJP7JP8SZRVLMrwfCSktcvwT1FiWB56TfEw75k4tcIRueogivni3lyoMltC4IQKr9+ZfechDBFf36jqoo4RpUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by VE1PR04MB7487.eurprd04.prod.outlook.com (2603:10a6:800:1a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 15:58:23 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 15:58:23 +0000
Date: Wed, 26 Nov 2025 10:58:11 -0500
From: Frank Li <Frank.li@nxp.com>
To: Franz Schnyder <fra.schnyder@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Franz Schnyder <franz.schnyder@toradex.com>,
	linux-phy@lists.infradead.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Neil Armstrong <neil.armstrong@linaro.org>, stable@vger.kernel.org,
	Xu Yang <xu.yang_2@nxp.com>
Subject: Re: [PATCH v2] phy: fsl-imx8mq-usb: fix typec orientation switch
 when built as module
Message-ID: <aScjk7WR5gkF1NeO@lizhi-Precision-Tower-5810>
References: <20251126140136.1202241-1-fra.schnyder@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126140136.1202241-1-fra.schnyder@gmail.com>
X-ClientProxiedBy: SJ0PR13CA0211.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::6) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|VE1PR04MB7487:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a4d856f-3fd1-4d56-e3b1-08de2d04a0c7
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|19092799006|7416014|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?u5RJXJivFuapdvxglPZJ9xqw0snk3ZNLsqJG6xb3D9llwxPQ39ZVlNbUzacj?=
 =?us-ascii?Q?4A17zNk6ZRaTsUv66PJPZW72jeehHyvDa7k144g2D9/vMVvfHg/JIERRKfrk?=
 =?us-ascii?Q?zs4XmUba60NY15gHQd6pKCly+3S5MVry4xQKXSLJJQzR6XK1oLRVFVr3xa9c?=
 =?us-ascii?Q?VpEvhsODLDm83q4LlGuUBzdqDhwY6XfTInD1/LFox9RASLlxxMBOU1ZqYP93?=
 =?us-ascii?Q?OxCSv/Rc1r0ID6di887lQ+qwIGloTPYRrAdYUoikL134eHr0wCmIpmZK05JT?=
 =?us-ascii?Q?orT1i2TzG01EWD4nKteaJePWg+z4j9fGOxHaw3Xfv6AbD11s6tHzwej1UfbV?=
 =?us-ascii?Q?DRMMVg2BCJq0balYXsGZQUueAX0xaITBpOZYDqyfkPoeUZII5o0fLPQAto0r?=
 =?us-ascii?Q?AadrfCAu8dbxikdXEke1r8T/S8dHjYO6BXQwdBUIG62CSUfuEm0FsoO6hGYo?=
 =?us-ascii?Q?JWNiv6nNIHuV3vdtFMQT3ySaigF7O0u1Ie9U6wRYDSAjxpTjM3nqpw1xqSvr?=
 =?us-ascii?Q?657eoVTNIU18JV9tmCC/OkyybbfGt8BSo1QJ1OHyAqtO66ihPiQ6ekjw/PDd?=
 =?us-ascii?Q?foSLKhOOaM/sjxciy6vasWWVDMZPN09GcfiSTA2ZkEIvhgeC+LRqP3dIaZG1?=
 =?us-ascii?Q?TJJ0c+JNhpmHwMF/ydd55PjDnCBQsrYAMww0/oy6q0Q072DQhGaj75NP2cbW?=
 =?us-ascii?Q?UTTjCzlRk8s4nM8NUGAd4baCnmGQVpmKEEIxcR5s/QPRj+W9jzv7urRhzLN3?=
 =?us-ascii?Q?cYV9tLlMSqvDhjbwV0R5RvTK7BXxTvgnEOWMn2EJY5xZw3YzOaiGNfwWnCnZ?=
 =?us-ascii?Q?Sz+CTee5w97cAMJownVHtFE+tuD2RVPqDnYU75X2lXi/PNIeqnbBD4846Sys?=
 =?us-ascii?Q?8mIWbtVQ/Ufm0bz/JBYjj52Hw7J3e/4wpsQ0AT0YbB0OGWewUCWM5XvRzgkg?=
 =?us-ascii?Q?NGI+uVPxho/UNHujzRkCKKS5XPzqNklM6Y8qtTuPwiNKwmBU0QtEqbgTLW2r?=
 =?us-ascii?Q?yLhT1LcrvFjY1SooFq5eUSTr4kP3FNvFcdjGpobX1LWvAZgAc6PrbqVPS3Fw?=
 =?us-ascii?Q?G+/H/+STIn3zJTT2dWlz45hE04OchsKdCdXfThQ3SOFTGlTKOgspKLqNhtbb?=
 =?us-ascii?Q?Gn8xLxiTSUBu3jwwYedlGUxnOwtbqVnYG/UOUNAjkXRIMTh2EotLHNRngnm6?=
 =?us-ascii?Q?dfbBCb7giYPvbKkDgGUC+027JkX8G+twyp6mYIdeFFSvuoZgL2uQU8MB2DMf?=
 =?us-ascii?Q?f0SAkN6B/CbYU31BUAVlXbXnCTr48DC0exUhnm9zYUsEKH7LriTG7ldbQNRe?=
 =?us-ascii?Q?YlNbV7wBsuSSrqDnq3lWJjR6Jp+S4gDOK3hH53/pQqxclB4zcsWepdgWbS/B?=
 =?us-ascii?Q?bKhZfv3SUDR90IUL0hD95XwtpfFUUQZ6O2Vss/8anhspCHhMuUHQTGlFmxGx?=
 =?us-ascii?Q?Rl2CMXfUwvc+W38TLsY55tp3ksOu/ragtmBKTscVGM+DZU7MTUKLXbtY37qH?=
 =?us-ascii?Q?UhlzpYERJP4ZWUhnYbdKRIPqKhS3q8bsrxi7?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?xi9mJXOlv/mWS4fRCqGOP7aS2Hz8wldYptL+6JpB7+H7wpXpeCh8l/Z17SiG?=
 =?us-ascii?Q?NXLgQg3flnKoaQ4L++4YYM9AurwP5unyeVtn9V5IzFBQA0/G8Vbj+xV1GwGj?=
 =?us-ascii?Q?KBGkyZtbZNmwTrdn1lJSbFRLlkmNTUs93j8pStKoaFR1Jnk9Tmkepza/tjcN?=
 =?us-ascii?Q?Rz2xw0K/6vsM6X3l5C0npWUPZ4TIivTMbbO09PZMw+hEKWtlQG3UgJBKoXa7?=
 =?us-ascii?Q?za3m1ccAXbE9TfuLAEckHBeT8oJeZlwtZfla27IMKTQxVUbSRxubjjoxxuQ+?=
 =?us-ascii?Q?RdrujQy6mSZuQlt1GsQREU7YN6EcC/UY4I/t4NggNZSxcfN0E7fbrOAveMGp?=
 =?us-ascii?Q?aPwrMkYqYdCo9hfrr5Eljh3nqaNTEjgf31p9JkGkhXjgMbe1zyxiSuIGzjxh?=
 =?us-ascii?Q?PbfaPDQNq5i/zKTcEA/7sWCQoTzk0rcQONBAURmACHOYyh563JU6PmXifDTY?=
 =?us-ascii?Q?0joLTe3gmi/pcKuGwrRtrIV/bSw5xsS243QxmcfXV/FFUIBYeAUmJ8pv0lLc?=
 =?us-ascii?Q?Mw1jwNSMtyFhw3z1/VUPVlsosdTYQDFSi7qbffwr7/vkqpTDGyKHLC0q3i57?=
 =?us-ascii?Q?/ltueXNSnUZX2ZDlSEsV3/3MzfybexNa5OAZdf0X2Xl3b7mxaLBPCYtQGP3L?=
 =?us-ascii?Q?q4ZdtTMZarqs2xzdG6QCHU6gCjSD/NAzUw5LHC3eNELMdVmTJ8/k7oFpvKDy?=
 =?us-ascii?Q?S/XojSZSdgMghp77RxZzSUIX7of9jx29euEUdMsADiWsRCKv/KAzBT0C2zSl?=
 =?us-ascii?Q?RdamgNVmg1uC6Emx79NtaJqePGOZcooZZAVgT4RE1596nMnkM60Pju3+G7Fx?=
 =?us-ascii?Q?XrKs4es4nlxzi/wQtVYftpXU3IKV9c3LHAvGgvCSLBwNkDi8LeVgCeCJ2ijG?=
 =?us-ascii?Q?cRdHw++lPyS6XLhk4zlOSxoDUTlM2CNZNoc9NtYWcUYHnuP0yEgYw3St/XuW?=
 =?us-ascii?Q?l/89siji2rlfYZoMp/Cyv1iEZjjjHgBAzgamNrU5ghEGa2vM5DXKFGpFNtnn?=
 =?us-ascii?Q?PsvZo+GYw2tSkZqwplnLk5j9zsHiYI711SzUGSHXZEmIyX36yU+TkfA23U3H?=
 =?us-ascii?Q?/MaK1ZrvYO95crq8xrut1s9jHhOsyyxyJJZ+Ah5MQqN2xK59MVN6HHxsRUTW?=
 =?us-ascii?Q?b064OT+tBAV0X9Gs5EIwDSOtu+qiQVeGOIp8pMGSTD267GGYNSM3zim7wxl4?=
 =?us-ascii?Q?so8K5E3nsceDyGsLtM52F6EBGrFfMB8Bmn9eqdk2JyYSTAMpNFKJmLfpgGdS?=
 =?us-ascii?Q?nUPCF2wyYR1ca6zIGbPwJvxGm+PCQU+7F+q6TSEjJRerOX/6gIOgH9L/yU5s?=
 =?us-ascii?Q?jfYLuQfy7RfiUJ8DiulvfT6+7ytxi3kboZvSRv6JGMr4P0UWKezW/+ZnQA8i?=
 =?us-ascii?Q?5BMCrkvdeYs6VA4af+cdJSzIkm+juKex3UMysq937EpWl07L9jxceejhjT+X?=
 =?us-ascii?Q?tdQ2FG3F+HTROOWkq40mmtxs7FioB5iOe22Mpvi/2PRVqYyL24m7AKJ3eggl?=
 =?us-ascii?Q?DYgqDHuCTHVsyuv7IGPiXjhUkqEBp27EqN5ATHadtmxjJKrHm4p1gdsT+6R5?=
 =?us-ascii?Q?oS6GOW8lrl42TFjMDjmcLQpeKHVR42HfO9Thwe5H?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a4d856f-3fd1-4d56-e3b1-08de2d04a0c7
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 15:58:23.6355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LIozV+PFPYjJcvV+k0Wib7bUGTAVy0lof02nWtTA3QQmW1ez7Ff8x0T5QaBLbC7L2VR5JVu2/pTw2sYwtBaYSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7487

On Wed, Nov 26, 2025 at 03:01:33PM +0100, Franz Schnyder wrote:
> From: Franz Schnyder <franz.schnyder@toradex.com>
>
> Currently, the PHY only registers the typec orientation switch when it
> is built in. If the typec driver is built as a module, the switch
> registration is skipped due to the preprocessor condition, causing
> orientation detection to fail.
>
> With commit
> 45fe729be9a6 ("usb: typec: Stub out typec_switch APIs when CONFIG_TYPEC=n")
> the preprocessor condition is not needed anymore and the orientation
> switch is correctly registered for both built-in and module builds.
>
> Fixes: b58f0f86fd61 ("phy: fsl-imx8mq-usb: add tca function driver for imx95")
> Cc: stable@vger.kernel.org
> Suggested-by: Xu Yang <xu.yang_2@nxp.com>
> Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
> ---
> v2: Drop the preprocessor condition after a better suggestion.
>     Reviewed-by Neil tag not added as patch is different
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/phy/freescale/phy-fsl-imx8mq-usb.c | 14 --------------
>  1 file changed, 14 deletions(-)
>
> diff --git a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
> index b94f242420fc..72e8aff38b92 100644
> --- a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
> +++ b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
> @@ -124,8 +124,6 @@ struct imx8mq_usb_phy {
>  static void tca_blk_orientation_set(struct tca_blk *tca,
>  				enum typec_orientation orientation);
>
> -#ifdef CONFIG_TYPEC
> -
>  static int tca_blk_typec_switch_set(struct typec_switch_dev *sw,
>  				enum typec_orientation orientation)
>  {
> @@ -173,18 +171,6 @@ static void tca_blk_put_typec_switch(struct typec_switch_dev *sw)
>  	typec_switch_unregister(sw);
>  }
>
> -#else
> -
> -static struct typec_switch_dev *tca_blk_get_typec_switch(struct platform_device *pdev,
> -			struct imx8mq_usb_phy *imx_phy)
> -{
> -	return NULL;
> -}
> -
> -static void tca_blk_put_typec_switch(struct typec_switch_dev *sw) {}
> -
> -#endif /* CONFIG_TYPEC */
> -
>  static void tca_blk_orientation_set(struct tca_blk *tca,
>  				enum typec_orientation orientation)
>  {
> --
> 2.43.0
>


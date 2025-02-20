Return-Path: <stable+bounces-118486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 140AAA3E17E
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 17:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4776C19C1931
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 16:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12023214A99;
	Thu, 20 Feb 2025 16:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RTiHFx24"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2044.outbound.protection.outlook.com [40.107.22.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE327214800;
	Thu, 20 Feb 2025 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740070223; cv=fail; b=I8lrXOpwqLBF4b1e1OATZhpE4ayEAt7JG95qutllZRVDEydNZcg4DsWVdaQF8lfpoaEihNS2CQYsX0OpDUNUwzI3pN+ElDb861f0PynSxT1WX5UCs80fcwhYG9anM7gXMTH4/N0fjeekBQdyD/KQVnyLv4fwzSRXn2MY8aF7Tv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740070223; c=relaxed/simple;
	bh=ObQjXjDFJNYYozOYVjCRN+6ooLscerFD2ZuTBKLsflg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AlSixdKTYVcAYTEND90tZ4AduxEkNVPM2kZ9zgzxgaK/z5n0tLuROAOiZZBGtpxHZiIVGAg7jTCywlPv10YQxYHjdKpl/UAScEhLUifZAO5Lm5wuuhhSl5jGdd9rw0ILUddb9V3Dm+/JltOc4ax9NLKOPYyYnoDEVG+z/z9S/6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RTiHFx24; arc=fail smtp.client-ip=40.107.22.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJi09ppEkWRZUEADZ+E7sZ+MxjdqhNcF1N7R7vXMoSIgK7huWXM5G92buoY2dhjWeJlyFmYEq+/mSoNS6y9Mhg4yNHq622cwJBRgmTcgk//tDYniqzMZVItU0BeZxyaQP+2nZl/PL4ytRjWAEkUzwiU25QBbQ5IF9Z2jZOuKulX2PJ7wkcG+Ypmr4LgkVz1zEfht3PO3bNpqNv007KuI1nQePSoX/uhoI/p0mDhakvTWBYuHTnS1hoo/VcauXFBVRDZ2TVx4Kdyi4BLfwbkLe8IosK5G2MZ3BvaZm1nEzEs4ff8reAZd9J52UVap+GV1VSOWaMRAhEShtO89hilJag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kqgn/2Lgmrz7oHr8CCDmMPOy67Ys8JO1QoTTFGJ0qIU=;
 b=T4AN0cQmR6C5A2fYlj+hUM6Z8mwRS26bK+SVCp9u6Cd2K285FPjzeFYbg7KY+TnVtz4oHIQXjD5T4CEqui+D9L80L8cW89z1FvSVL2dzNw0BJ3iRg7AKpi0tR/yiHC5ScSVNwUFf1DeQxgLeOhvSSdfwiL5LRAZkQfu+4eUGpN5LQYdL8elLyHUeXcAzMICRDR6Aa+eZ6Ho23v809Seejg+qVRoox1RkTxZpavMZKkMOgX9SsyOsOnX583pk/tyHBVZNEBJJ1lugRMRlrLIJVoHiGttIiKfjddW2uhK8TirUZJglcCFsJmmjT3uHV7EXW8sOo0yZmQru7cDWtHa5qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kqgn/2Lgmrz7oHr8CCDmMPOy67Ys8JO1QoTTFGJ0qIU=;
 b=RTiHFx24/mDQsDJwjoys+9FpT5ZR8+mLbqztBMiT0CeD/EXcNAfvRcNUSVaE/WqUiX2j0K+Qv+CWrcJPNKrFCLJsgASMrnRpblN8+P73XQvnLHavgjzE7rSiTAqzOOl94nuxwYkBIwCW0FI8YoVSCYV59MMAG5YiA3NlIJ9j6UmIrfNQB0rqvCYiiKVvyy509NmNKnhysryuUWw8y2IpqBAL9sXb8+mWHV1jmK9DbjIc5g+1VKmasrMlxyzvXghz/FROZdmv/r5lDelRJ7Tc+/0Tn6O354HRWsCNeZTbSOpweUYq5NOnV3clHu+c2vMGIHnt4jJNItJLHj4jU2mpag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by GV1PR04MB10200.eurprd04.prod.outlook.com (2603:10a6:150:1ad::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Thu, 20 Feb
 2025 16:50:18 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc%5]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 16:50:18 +0000
Date: Thu, 20 Feb 2025 18:50:14 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ioana.ciornei@nxp.com, yangbo.lu@nxp.com,
	michal.swiatkowski@linux.intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 net 6/9] net: enetc: add missing enetc4_link_deinit()
Message-ID: <20250220165014.hj7wcwureqtdaggs@skbuf>
References: <20250219054247.733243-1-wei.fang@nxp.com>
 <20250219054247.733243-7-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219054247.733243-7-wei.fang@nxp.com>
X-ClientProxiedBy: BE1P281CA0026.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:15::14) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|GV1PR04MB10200:EE_
X-MS-Office365-Filtering-Correlation-Id: 39bf5e18-5c4a-4de4-2915-08dd51cea7c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BQ8dvnVqjm14N9vKnABaAZ2SSs5DHWIaNe1cmfj5Loi5PcaNxto7rNzYKywA?=
 =?us-ascii?Q?nzQOt0lyupFG0SZmnt6tFxU9rlSXqYvXSM2jwpisg2SXL94aMLZ9ugiCS8wB?=
 =?us-ascii?Q?RxK3gLHkGr2Pw6WrmZQGI6QuzKN05wdZ11ViyyVT+PwNNvzMwrgDtPRnqpBU?=
 =?us-ascii?Q?I70PjEwQU+TR/bMnLm6EcDDDuUEtbL6qEepJW2uRnQ1kbU0egPRXqK/B0A+W?=
 =?us-ascii?Q?OATA4yPph5sC37SNQjIr52BpsrYLgOyF7DBw0XfQO6eveRu9P3KyMEXans6U?=
 =?us-ascii?Q?bLen1WIfACrUp8OWacqkzqrNSaZntkleevbs9fH8rBefMMyFb1fKCDrhMKZc?=
 =?us-ascii?Q?4LtigzGsZdwA+qf5imgBVfqLPf01zPtBxExQ7OxIhsvHRIwm3OptcEvDrEUH?=
 =?us-ascii?Q?gyQi1fJabbUjw2BYm2tQqDY31k/pV9qNu2a0CZOpgNw7xUpML0CGoHQPw1IY?=
 =?us-ascii?Q?aK7DYEqhY5gq3HsmsQD9e8vnX55hQyE1BA31xfohPmA55NYbVBqyLOIIyK9x?=
 =?us-ascii?Q?grasdrbQLWQj8BV/N7IIulI5BDZdR8UVDF+L817FqW90D3+9vwC7XeCtotic?=
 =?us-ascii?Q?hwOxZBGzb8yTHmj4OtucChIIfnBOK0pDRbUgWaSLiJSD6dEZb2Dz+o/UW141?=
 =?us-ascii?Q?+TPPatey6u3pcfuWpA7wQXeOuKJL+8L1EJjlUkf5ERRFCLE/HOB1UQaFKKpD?=
 =?us-ascii?Q?PW97Wah6PA8rs7Auw8lN8sYTKLX7x00bnVd1ovHeI8YZ6JAMmLtUXTrHLTvf?=
 =?us-ascii?Q?G3tMaBpe8GLrZ58sGDCgL7glz4ch8bifTdQ7HdoCFonHP7ynQMB0TOO0V0+0?=
 =?us-ascii?Q?VlVyYR8R8hOmkXAtqvPX4foyshusDrNXmCmMTR2t+Oj7esvRYyMpqMBjEj8E?=
 =?us-ascii?Q?S3UJsc6yskrWoMixDJehX2uRuv7hNxSvzlUQTznV3N/634SNZucjpX0WNGWx?=
 =?us-ascii?Q?aj636gM0KzHwm13/DAMO0kXZ5oVSOzcp7e9MeklGS46jILpgVc4WgY5q7Wbu?=
 =?us-ascii?Q?zN1WEvk+UciTrjCc2xN+t2y/XCSw2Xyad6dpnRrn97/1UVk4ceypk2eozlMs?=
 =?us-ascii?Q?sW7QSM6gehA/agpH0z4H/ZlFtILve3STQ9d1damNlUYxsAmv57t3cQDz5SNV?=
 =?us-ascii?Q?WZQ+y2tYuAOwMmwq4gmW4C05tq9dl9ZzPgE+BGi3K1fkVIpVc8ejWHS8ETds?=
 =?us-ascii?Q?cZSC6tW8U3OpGFJox93n/l6hHXAUQTIGJpPXtb3+6OB01rEXqj3pN7nm11Yu?=
 =?us-ascii?Q?6M/N+ziOlk2vqUFScbQmI7YuEBa71C7BXJPELJ3ewQ7uPUo6VAaFVBdSx88m?=
 =?us-ascii?Q?CVhWCwY9oH91trE6JPTOet+OoGlErJOfWUT6oBE3C1vuKYR8knJCH3R72Q2b?=
 =?us-ascii?Q?zMbXYNNWRWsUlR0VOJNWCFpfKfzT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EVjbaP5f7BBSIakzDOPrJRpVS2KZ+lO9i9ZQQr/vIRkN79Gwl2fF1WlR73LK?=
 =?us-ascii?Q?FRTZIUccffROtZTPOpCjJe8D+1XfzSU5SmU5oz/zOPn9c6l5lE2NfhG1fno6?=
 =?us-ascii?Q?zaZeUFltndiyrAeccpPiEi9aCwzXOXk8+tdzbfaM3KuyOXK8PLWnPgBXQfdy?=
 =?us-ascii?Q?q4J3HNfFWQUsngEjKenSewe8AvGXbZIt/SyjODRtMYMX8d3Z1LatzqsAAL7v?=
 =?us-ascii?Q?v2OkbCuAse74fUMH0lRApqnve/dRfg8C/zmi0Xo6fC8kmmRs0Y+TpRhVxH3+?=
 =?us-ascii?Q?R0nAMTqmU0gpCM0M0SUETV4HwuSSDZmniyPb/yX+9SEFDgqeiBag+PPYmlqT?=
 =?us-ascii?Q?lyUHDnOvR84FaAEEzWYfuDwsOm7Q4UOeb2o4uPPJeombLnWDw0FtbGlx6mn4?=
 =?us-ascii?Q?Z8IeMvzPrx0uVzfKeDAafsk1q2Xcx+BjCmCNMTzEV4S/hYYlHM7JFlovxyZt?=
 =?us-ascii?Q?4BJgsTI9MuqUkYN+IKzsAhlrk0JsYqU4VfL8YGqDzC4B0pmTs7gIkYyrTVjl?=
 =?us-ascii?Q?MJiTkb7cyOvjyT76zFcfn1PpotqmkQYAtyIgVnzYJxbYDtkKEgLCmJaufKaO?=
 =?us-ascii?Q?BaSOh3skDhEZSrqMXhk4UyXBZBSetiMTwFWcNwp7/JGNPHnM3niiT9giF4zA?=
 =?us-ascii?Q?Gp+0rVu6MUsNe7UqbLS6BWdyNJ6kHOdegS82FdFIWYVzy/PtBHamJBh9RnWs?=
 =?us-ascii?Q?OqgwEQrVQTLq6myY84DmvSQvTi60ETX/bTkOqIEaNt0J1pJxpws1ZOMA0j2k?=
 =?us-ascii?Q?3A3n5kbPVb7BNuqyNE7aG1m+6sh00wwWtQwZqL7XiB3JnqzWfk2/1rRVe2e/?=
 =?us-ascii?Q?iMPalUeyVJ2jTyViPeNMrQ/EDEivOnghjPuU+fjTp4PSiIcLEOE5TGnlXBVU?=
 =?us-ascii?Q?+rHxYA9zzSUOXVJc1PupzzsLJHJv+nUWff3Gnpm/34TKp5IqYe+Wvgq1WlyM?=
 =?us-ascii?Q?jJJYoN9k1ImW8q3zlCBcZ4tpny1VaWYzC3drDHU60AjhJP21TAEoMR73Q/6o?=
 =?us-ascii?Q?xT8PyRQXQUxdzH6qFzxl4vzcrdl5iFJQUdALHbG6qC2gEkApib676wDP9WXM?=
 =?us-ascii?Q?VRlxUvPLdr4uMEjFYxcjYZE4cIkh0ZzLEqVQWafW4iBPwhG6zsuvPbmhTNLj?=
 =?us-ascii?Q?RTU9LFk6o9NjgOjhlX3IAZZQWQUQC5+0ACQ3hT1A7bUGrl6Ozb+hXNonhy0P?=
 =?us-ascii?Q?zsVTEfB0detoxyfYHl9M3ZADs1TLn0qgSx2k3X26NK6guBwYEZJxZdhrSWZ4?=
 =?us-ascii?Q?6iH25+cqhJaZGPliUfY15mhew+dhQG4JZ+l358WdTXmDeHt/YQS3Pm9d41ok?=
 =?us-ascii?Q?Dw8aVr7IuDknknprteU+AOgCBoiXShTORS3NBlKiHs1ApqwOq1p3oV5svtSZ?=
 =?us-ascii?Q?ea/6AIzTwyThSj4iwio/zeU3j3BVR52cjYgiplSY1gt7FWVUWPAXPk5JSQul?=
 =?us-ascii?Q?d/mLTGX4DGOsTsxsJ0TafRkkpdIXiGDSVhyAHs/8s+DBWqeC1iq3WtBjzGJO?=
 =?us-ascii?Q?d2Acyf+bWabxaiyiMAv0Iukqzbblncc5tvqn2xT2NRHV+bsCao9+OvgVQIwQ?=
 =?us-ascii?Q?HYo/fMIiX8910vn+xGvFI910NRJNPobCOXMqIK/vrHIQjoPPIvThd3KLfqmb?=
 =?us-ascii?Q?9w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39bf5e18-5c4a-4de4-2915-08dd51cea7c1
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 16:50:18.0987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pz27b3XF8+A9v3s+ybveJS62Xi+BBfroyyjHI4yKsJNsHECR2l1N50WenyCRe6a9EZvKC+DPdC4oI+s1s+939w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10200

On Wed, Feb 19, 2025 at 01:42:44PM +0800, Wei Fang wrote:
> The enetc4_link_init() is called when the PF driver probes to create
> phylink and MDIO bus, but we forgot to call enetc4_link_deinit() to
> free the phylink and MDIO bus when the driver was unbound. so add
> missing enetc4_link_deinit() to enetc4_pf_netdev_destroy().
> 
> Fixes: 99100d0d9922 ("net: enetc: add preliminary support for i.MX95 ENETC PF")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>


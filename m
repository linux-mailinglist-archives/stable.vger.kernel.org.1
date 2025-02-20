Return-Path: <stable+bounces-118488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA2DA3E1CB
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 18:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A01B13A324F
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 16:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBB320E6F7;
	Thu, 20 Feb 2025 16:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bcwEzSC2"
X-Original-To: stable@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012047.outbound.protection.outlook.com [52.101.71.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B4720DD6E;
	Thu, 20 Feb 2025 16:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740070727; cv=fail; b=rYipx5j2MSi6hsx/Nrjko5/HifhjwrCxI/GaT4iF1PLIKP9Pz8UKy0PrgAtBRWbt84ye5CILiaXK7rZeqXg5ILo7ecXuu9p3A/FfPzKlirkdlxI4WwrxAVxJLI1fKDC3oO+4AeNbmK06+nzXu4mogtsKjAbiTvu/j0hy7Cig1Hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740070727; c=relaxed/simple;
	bh=EZZX26aK5KeV8/wMGZkwekFtDahQ0NWgdhJdcMIOYTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U07DTmh3sR0nrRpac5jF26WHh0SY2ts3eHx04LsA49LOSHTNnN9jdnqEd9DvXxjJot9x9HEwnRPSg3SRooT4pNZTUIYwphRJI1ZYxygL1hDBht9o6kyTbwDBmFS1kqhOknR2Vm35uPjae+v01DmZMbwHowLuDT6zfZnHZS8yDbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bcwEzSC2; arc=fail smtp.client-ip=52.101.71.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MugfK4YwM3DeZGw7pk+YLdT111bZlx5v8pH46sMrTVgnQFELnoo8CuC9ftFrXUteaTfPf36OSy+FeYwc4JTC+hG6JTPXswYoSAlRNPR54znCUlPxmC/xu7bBMveYWW8J66m/vrdhNI3g3u5zmiNeG42YS160PU5JIgTcVjcTMLwKja18A5+0PNsVnn3eGg9LxrLp+stOx0vfgwLq73diYko1JvMGa8ndbFilAwANLBORHR6kZTad+eSjfMCfROvOvtbh0m7LwrhhXIoX5h9XgDvexfstZx633HRXcqhZf8H+pgqhDClNwJcmsN5tzWLILRhAfc9GKZPwDNjEPW5xnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PjoIE2arwba55DhOJar8poeNfV2ijbaJ8T4d5stTSyk=;
 b=dIP4jzAFa8KgwDM/lRJnsKrRBJxlqDMpl7mzPap79nTkcmLGrxVIiFErauL4NeHVMSlH9+9C/MT07hZbEpqN25MBk5laAX4Mo7oO2XG1fQFub41TwgirOjGrH1THDuEICqimizFFBkCEVOzudvIs33k3QZkbaZUeGLbLM84ZXnWoM86S1eNCSTup43TOJ+axhTT4yYOIUn6o/q4O8LtrAvjzqRSGPru20BEuJ5ciorwbOwN9wkVyn9z/OJj9b6WJef+TgFF7SmGcNbGHee7D9nwuC0oai3Bzuxu9BKC4h1evKSEIWtXc1QY5FfLMnsLwHLMVHJUWwGjcVNAETCu98g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjoIE2arwba55DhOJar8poeNfV2ijbaJ8T4d5stTSyk=;
 b=bcwEzSC2ZhwQjqVbZ0sqmWCgQPqKO2neg+c8LFtE4dqSsm+rx0aYPQFbO6WtAATI5/ernpi4snf1C63kEPTpeato/KrIp72u/nPv2rdJzanxT+pB4NSVtnp//fmK7tPnolVtA8HOPGtfuxowfdotlE/bCQNcxGhsR6aqA2r4MmiJuAeJCJhskv8ufYqq1907jRuIvl/XU6UrCSStNt/Hqif6FRyjPsyKsGeu/qOPELRv1cDiUt3FlKGyvA3pfs4X8CDmaeJTufgM2QIeaUpRkK5lhI5j3/VL/wdziwM7/LSyHFQwOIgIIWZCeGCD7POkWhobCMK9kToHHJKFfx9aTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by GV1PR04MB10680.eurprd04.prod.outlook.com (2603:10a6:150:20c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 16:58:39 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc%5]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 16:58:39 +0000
Date: Thu, 20 Feb 2025 18:58:35 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ioana.ciornei@nxp.com, yangbo.lu@nxp.com,
	michal.swiatkowski@linux.intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 net 3/9] net: enetc: correct the xdp_tx statistics
Message-ID: <20250220165835.3wrcl66lbxraz5u7@skbuf>
References: <20250219054247.733243-1-wei.fang@nxp.com>
 <20250219054247.733243-4-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219054247.733243-4-wei.fang@nxp.com>
X-ClientProxiedBy: BE1P281CA0283.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:84::9) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|GV1PR04MB10680:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e8f5f30-dbc2-466f-fc0f-08dd51cfd272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oph+C0HQ9/Ecz6epdE72slkU45ULUR/f/luOboc/U0mMg6if1376AtfXyITo?=
 =?us-ascii?Q?l0WXCDjMoeo5ESqmOoBYPYC4RuJ4OKgsCavyftNNYinhKHS+2+wPnyiap4q1?=
 =?us-ascii?Q?SitnWEYEqjWTdsQ6VjbzsP5hQJXQJ4igTVYhUNWxFA0mpK3NE87GsA28TTIU?=
 =?us-ascii?Q?QE55VH1lhYrKFHv1QzCRsNgU5TpsSjqb2ebXstFKM9UmAhRezthrVJ3n1+E2?=
 =?us-ascii?Q?lMoVvR0E9oS1d6N6MKLi8EI+YN637EFSLe0L0VLBcSVQysdGPmefFZtRiAwb?=
 =?us-ascii?Q?ABzcx1MiM7pCkb3uX8sG68S6JHLPb0PcxZTjY04bl8WpOwuxGuG1vAC+ryL+?=
 =?us-ascii?Q?2jw0xMa0h4fwKJP5ht72asyD1YVIPaMFVlz9eadO5pXZ1yhwZ2CchGuMsIYM?=
 =?us-ascii?Q?rl8wKSKk1lnm3RohnXHsHvf1wozuUhOrXX8R1Mxu+jG44LHUbvtjpgRuWljJ?=
 =?us-ascii?Q?Ea55KOyaQU2vSNUSxYknFh24joBWE1mUHDhIvvtpzSAB+JP+COlPAkybAkBT?=
 =?us-ascii?Q?+qi7bW1U4deVg/fSYfUTYCXkTk00103zbAVmf3ZTyJFyBbE+Gi/pVqkvKMnr?=
 =?us-ascii?Q?Ukr1DiTRdxpwRl6dfNvLv/UHA6egkWYCQ5e9qA+7fohO/o1FCbNTAGj+pNfi?=
 =?us-ascii?Q?gLSoaYj3WVdC+IUfNNLV/mWEX1yvZ9YR/v+9L3wTPnbWv4gyMqjzgFS6zYka?=
 =?us-ascii?Q?C4V19yvJfJWBFGXDFd9lvAFs3V/qBXeEXMrHn5K787hdz6UYICT/9u2nLtUv?=
 =?us-ascii?Q?/1ijMem9W9e6JhiWtXYQosW4F6akc73k6hNRIjQcjf262rvP0CHyB8badLRN?=
 =?us-ascii?Q?N18bs3jeHYuvdxfp7xwbAv7dekr//gi33WlWC7I0gHFen62IkOMFvq8I9cQN?=
 =?us-ascii?Q?gnZ5to76eZ+xBz9zCem86uWPDABSLilVTuhbcjpOa72gUOgNshJ4BLv4NADt?=
 =?us-ascii?Q?V7A3gb14uEkrY4OeTLvBAvCTeanj2k90z9vDLAC9x1hqRmUbj5YuoDObPvXN?=
 =?us-ascii?Q?3akLpq4xENkAtMs/bQFNLcxO+/bx3UMOGp/WZKGs0DfI6lvwrILJbcPmGhzb?=
 =?us-ascii?Q?YL971GSSLvY48PCVJ5dVQDnMUZ2a+Lb8C2dNsyWQppM5eRBll8Tcm2O7LdWD?=
 =?us-ascii?Q?6h38reYeW0AFAwmE8Ef11MdUYm6xjn9q3TGYOda1U8kMEHxde7za4Bh4lzbe?=
 =?us-ascii?Q?Coa/U8NeBrCJB8Nlmcd4yyjHUkrQV67aw/rkOB8jx7up1Mt8fClHpk7XS029?=
 =?us-ascii?Q?LZXdCIVT16pEINn7fUVjWHCqplujMmORBasWSFt1nzqtGkquIeUmSuRq72wh?=
 =?us-ascii?Q?AqAEfXUB69G+k65SU1ZPERKkAKGe8HGUdqnbqVV1X+UFBEjyKRayyYaVBE2v?=
 =?us-ascii?Q?AQ6lQbvX1L76e8WTAN1TR/TlqA8r?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qHe5v0jt1GEPL7ff5q26u5QUHR+822Bx3sTmDJtZYhNDf4k+1yyHHpmO/sm1?=
 =?us-ascii?Q?9xrsSU/GdQDXkPM4fNNGGDtHVPVX53lgwEMLyvGkYcNg7Ynj0+qPDV0POb+/?=
 =?us-ascii?Q?BW4H/O3f30hHY+1+y/JKxA26E7ExkEOHmGkD295jxf2Fpl6dyXDZ5NLEh7kg?=
 =?us-ascii?Q?0sMEobRuq4F7TBb5X7id1P9p1ySc2Rkhw2KykYwnYrgX9rWLxNdGMX4S+31L?=
 =?us-ascii?Q?bnEp5RIVHdwvyq9QbLy4jQ2DgcnDS0QWTw6xvSq6EiWyp1L6lY++2efs5O1l?=
 =?us-ascii?Q?kwRJOFMGIkNEmStCDf5GgwbxCrlgTdSIE6fhiPlZ7AoJMDNnTGRtLSbsOHqz?=
 =?us-ascii?Q?Gj9aJsGxSAHbE9uF71bKKAs//Dk2b165ZlSt4KAyGDg7DHe1cTSoZVuKeNpY?=
 =?us-ascii?Q?4zXtCO2P5BR1J0VqBGYdQDrqAq3cQAt4m/irUZiFwAqJPJ01vr2qOKylBkHj?=
 =?us-ascii?Q?5r1II5WNzuLjCqYB2zU2vLt6iFEN6TcDPjEbjsbxHbA7ZygHJgYnnl8L4H9G?=
 =?us-ascii?Q?DZspx8IO4W/nQUk3MmFtSeW/iGEh4Gr5qmBLOd6+dbEeefGuGEmF0zYyTXiw?=
 =?us-ascii?Q?RgYYRO8+6MS9VZgu/i2JPbgt2dvXcmJ/uaAV8jM28r4MDM1s6aZ0bDmFPdb6?=
 =?us-ascii?Q?VDkWZ+VGPcBLiBtEN9I7rdWWDdNOFwuHOBjkNN/BDmEiAjvMv8w2iYpC5P0a?=
 =?us-ascii?Q?rAfMQvGTWhziZ6II7mGPLZ5IR6EvFWYeqyToRk3EVDuKbkBhr+ZwudTKduVS?=
 =?us-ascii?Q?tyDyt1UMBcUBHnwB3Z1Ci4WKTkh6i3PdX+VbO6Fl3YyJfbUU90n8XqIwOqlX?=
 =?us-ascii?Q?2VIIwhw4M/43kKfl53ym1rVyHMChZjNpia7LyK1BMtJqj8epwj+ADIWb80D2?=
 =?us-ascii?Q?wzLVuaV4M1jviuUO3oqEtqCWDTfRgzsq6UenQdrcbYOKBKCGdXxDubnVVHNe?=
 =?us-ascii?Q?ahO9lvUHKlvYwWEMmovVpycjq6LFOTycIrn4SFsKgwrWRwU4PZRP8xSIWYIb?=
 =?us-ascii?Q?Kcik3qW+wFtuwGq9fWgPW4+QHaV3m0QgzIPBAsJ5ZBbTd5kUXYajoLMYOcDG?=
 =?us-ascii?Q?EWcPhAfWBXWULaX9siVzFn/y3kTksGFHFowESZViXbtrv/7x6lgRHwjmRcDN?=
 =?us-ascii?Q?c5sCeL6neRMv2dWF+N1KtBrnlh5Bm2nOjs3uAMiXz46zmrC944GwGK0+LQ/1?=
 =?us-ascii?Q?Eg2YHBK+oCG8f1M/eJBWtGh24YNFCtD7ksTdn0+9Rv8xEF8NjjFILGSaOhL1?=
 =?us-ascii?Q?9TImbvlhxjWF//FgCzQGJ6k+UmFc86D4/i3EUj7ZOfXXJWNMGU0Yl0ShIy/5?=
 =?us-ascii?Q?B2dmtpm3UJwkYHPSYS6sEYwEAPHpcz42ei2YDYm77BdO+Ns4K7lo7sPcoTt5?=
 =?us-ascii?Q?FC3boqOhfrKhOn5an8CNyfUpS/onwLohniGFvHpHjTwUtHGT9CwJ5WY6y2jT?=
 =?us-ascii?Q?A1RWxdXOkwoyrUH824Rk7wmLaN2Yu3h7fuFTeICXfapTH3d1yStr37R59S5A?=
 =?us-ascii?Q?vaAX5JYULiHX9GmgSgSCR+OMSiu8bgnbnhd8mNGM9YjDU3CL+MCRZhe8ETdd?=
 =?us-ascii?Q?0E0/cI2kCOgw9Te6aIUg1z5FlWVThZUFR/jWR6QDd4f0d4YZDTavsULaRzOD?=
 =?us-ascii?Q?yw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8f5f30-dbc2-466f-fc0f-08dd51cfd272
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 16:58:38.9635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WHhoiuQCfWzbpAMmPQGP8m4vJvQxmjPagMzgs01XuXmBVLZq89Vj1IRErsv1tiVm9XFvfBViBXdWHW28WdLFRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10680

On Wed, Feb 19, 2025 at 01:42:41PM +0800, Wei Fang wrote:
> The 'xdp_tx' is used to count the number of XDP_TX frames sent, not the
> number of Tx BDs.
> 
> Fixes: 7ed2bc80074e ("net: enetc: add support for XDP_TX")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>


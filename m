Return-Path: <stable+bounces-118482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EA2A3E142
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 17:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96F7F188D96A
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 16:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6152116F4;
	Thu, 20 Feb 2025 16:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="evYb8R8f"
X-Original-To: stable@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011047.outbound.protection.outlook.com [52.101.65.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729EB17A2F0;
	Thu, 20 Feb 2025 16:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740070027; cv=fail; b=NDIHdAhMD6RRH/omQ1r9lA4jBOZ3LVGbGzy8NeJONvAOJ9jeHZoKzIfUUY6X7rFcQ+DWd5QFFy3QaxktkRimOw99GQSH6CBZlk02W51XxYNzQspe2UnnD9hPAR9vnZlSeoxinMMgmAszn/vb2azQ8zooZek+y78MYvkcQn5c5lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740070027; c=relaxed/simple;
	bh=xfwxO8ZyYyHaOdGtSR3FYSYiDjFmtOtqPJlU8aumeBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IPL0qu7FWMIwkjo/9Qi8iaoxkJqIG2OXv1Cp1l281h8NF9gjjVhJM9m4R+wAEq4dtsQHqpCYVeCu6fq47x3i+Tfh9gWTLwaN8Ye9l9TXTFwNFyHYMMh74gEqquxX8mGCmJShBKcMsX9d3uW3xd/9PGsZJmm9dtNCzVC62D/oxXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=evYb8R8f; arc=fail smtp.client-ip=52.101.65.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lSeIGcDG1k4jViGRg145Gf/oTHDZTlzewaYt2SHdVc037RKVdpFMg6Pg0y3ImcSHJHuw/97bfPGzUyrkGymJubat2DX84lbS3ZFfwJu6Ze7W6iBJnq5c0/H9kjD0lGDmoUyv8MDK0xAymex76bGIxqK29oVsBTgQgH7pLZRAB2clyQMB5CxHzExBqtI5WvTLJOcXbMDhU3wcGUo7nLwM5lJywIp00SZFGDQnr6Wjrw4ZYFSdPyK5pHkBcwUpQRFzkjWIW+oLxoNt9lTEekigseUYhyLhCLNQxPYtithDt235UuYX6I0kU83n0D84+orbQebuMmIV8JEqah5fplUPCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfwxO8ZyYyHaOdGtSR3FYSYiDjFmtOtqPJlU8aumeBU=;
 b=JXpxUWbYshNC1F5xDL48dOh9ledzdhQF7hTLwb0No1cjWRlDikEoQwFS3zRAQsLz2+iCAm+Jp0UOf0KM+zRhs9B9xNJQ805zeEiVFyywpH9boCrWYdHCiA4gcw1946d5y/2pZ48ii3zQjLpcHCsrStF33RuyO/hSyQeBFeNjZXyHiPXDBElOWYvZ+h+fFoPqzyaorJ54qPXqQn578v9tIreLKigde0UrPbRff/3n/nhESkel1v3xuO58C23r9+QZGzCC2lqXlxRfD9L8e/Zf8wwwv/w2K47JwhEOHONsNCb8hNz6Jym9uMzZCNOsLr4tmqkVi8hFAkRLtln+El/hnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfwxO8ZyYyHaOdGtSR3FYSYiDjFmtOtqPJlU8aumeBU=;
 b=evYb8R8fT6yrAeozeFh/qWgtWbYMLpxvBojrLNek3PT9jsVRI9B6sfSbJUSLD9aDXxhMOS1fXODjOGGXJcqlggRQFv5Pmjjr7w33mKZde5WdkLyzpOP77NZyeoCRuw8k0LC0IRzI6ZX/NZZDT4MeQJ49CLKJtkAK5QZ7JgkjftAaZvymd06A15DK0OmjBWSajqVHM69pL7QXD51eU9aKOG1K01nwY8X9p+ki0c2LpgcbaDJogYkPE6u8/iCnDxs3odRLtcVpSBrseP4KV8mIqaOOdggkRQJBm2/LJ4Fs7VZXYC9nzESbWf0zU1p+7iGdpsOQDzLXOkR2npkzGehdtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by DB9PR04MB9257.eurprd04.prod.outlook.com (2603:10a6:10:373::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Thu, 20 Feb
 2025 16:47:02 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc%5]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 16:47:02 +0000
Date: Thu, 20 Feb 2025 18:46:59 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ioana.ciornei@nxp.com, yangbo.lu@nxp.com,
	michal.swiatkowski@linux.intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 net 9/9] net: enetc: fix the off-by-one issue in
 enetc_map_tx_tso_buffs()
Message-ID: <20250220164659.hqewxa3zb4oqgo5f@skbuf>
References: <20250219054247.733243-1-wei.fang@nxp.com>
 <20250219054247.733243-1-wei.fang@nxp.com>
 <20250219054247.733243-10-wei.fang@nxp.com>
 <20250219054247.733243-10-wei.fang@nxp.com>
 <20250220163226.42wlaewgfueeezj3@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220163226.42wlaewgfueeezj3@skbuf>
X-ClientProxiedBy: BE1P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:23::13) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|DB9PR04MB9257:EE_
X-MS-Office365-Filtering-Correlation-Id: d2eb9dae-bfd0-4e4d-04a0-08dd51ce3350
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mnWKHTkJDY2qI1Ve/SAbtaGOIjnZAsnVGWAkouooqIT5NY3bS7imgg+9Mj8+?=
 =?us-ascii?Q?hAD2JrO+Lvc9PDGGOTcMVKIi+5rLTtUh86Mg/AlIMPCHraHxZHCiCQh//RGp?=
 =?us-ascii?Q?umgZ3Zdw3Aub3fysnbnbmd+B7z0g0s/6Rhh2gzPvdQglwXgAoEhT2eJEXTRJ?=
 =?us-ascii?Q?RpAUqaT4qRGhyUu3at2S5ypcqczCwz7SjqWNaXuBhw8x4q0HmpSV/1fa6Ob1?=
 =?us-ascii?Q?XM8SD+rme3O97/QQGXjPoJ8gMyv8gnxxrVJCMgSa0nCZ5v30mgag878eaZxD?=
 =?us-ascii?Q?7kcvJHTMTZYfMA95z/4adkG5Vpfn9Hyivi883XbgcYavBfL30gtCfEznEuWL?=
 =?us-ascii?Q?F7v7VBfuMpJlya/sWuyZQ9weofpawtQTOoIX9IvjkHmf5MBD/Xjv2CpC2DVx?=
 =?us-ascii?Q?DVLXam+wCiZfRBI6bXhiZYb58kCb8ozGb2cY9Ti7spZhFqrKPVtGX0awmCUE?=
 =?us-ascii?Q?DsH/hl34CInxqCXWA8jR237T83gJDUFSgtZMc1Rv6hpowqLHgKtisbJtptm4?=
 =?us-ascii?Q?YXMsHqjsfUL+uJhIRmv7+nNsZwehmu4tPP0mR/LNuTKY2GK4CReaeXCKN3ba?=
 =?us-ascii?Q?skynh4vLHTzGwhMApzX19rl2r/efrPvnhcJpNp3XuRYAMjkg/DI4Y05g89u5?=
 =?us-ascii?Q?Mw6btjbIQUKIXhe99K1VDwZQhT1aaylOULYUyLHGtqJOlRcyIlAiCk2XMvPE?=
 =?us-ascii?Q?Z8jmZ147ucTLHAUNhrvIBfGN9+0LX5GJKdb1WWvIS9lu73MyHetKk++qmctJ?=
 =?us-ascii?Q?p9+lCy0Saoz+VXRKbfLDasWnKpzyJW7+C7e1pvUNaQ+zlgoF93I+7a7Mw9sy?=
 =?us-ascii?Q?5B3Z7mMoC4JATKbbyultwdkfO150UCBn5GKPRmO3jNRH4BLPGApswd/Ocy3X?=
 =?us-ascii?Q?GLykhRfs0Udrkr6oUd/rfkbqIbfHyD8HrTq+StvILsg9l30LgDNBvXrniF1i?=
 =?us-ascii?Q?VcHgRceS4TazCjYySWs3e72Iw8+pQgexBVjXfg4deQ7FZ+y6IsKuzM2nhKj2?=
 =?us-ascii?Q?9khZpYMBimkSGzDqbmAIXIVf9NufA/lJ0vEhS31gvGMJhbkm/hsQOcqbVU64?=
 =?us-ascii?Q?R9s+K/fBJ5EvJomj6X2zsPaxnBHAtETSEQDZH8ySV6+bLnKOSGLgA8aP0Q0r?=
 =?us-ascii?Q?wIaTKYFYXcKpGUIkaZwLL2l6brRO+yk3ghJugyjavKWxMIQ0dPjM7Vbvtw8C?=
 =?us-ascii?Q?vreZpRt6lWGIPrbyie/5eEYcE30keqioSMbLV31nsPGqQ28QBs+6Vq4tfBps?=
 =?us-ascii?Q?C+pfQqMagu71i4g5sXnMg4USu2k5Sz7RpAOui3RxE4bOCopKC/PZPLvelYtn?=
 =?us-ascii?Q?9IuMmqVUWJsGe1eY7o+7pFjNOAW6lD59E9PSFL+yZNw3ijQG/aq5SsFdoLsR?=
 =?us-ascii?Q?+Y2De6W/EIm7vXlSk3xt2HlZtqBE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PLp+bPmBjaZcUUgecqRIMdoyyUL/w6Q54766ZhcOwMMWoKwgkOaJO75l/yEJ?=
 =?us-ascii?Q?SqaaUa6e7du1j75LkDe+2xobBg/1Z0igbl6iqf+J8PFjqaG15Ql/jOZokpxO?=
 =?us-ascii?Q?h//f8v1QAKCGPHcqMXWhw0fug6AX16zU1grSinqJ6o54+SFKFphEm1fsp3kN?=
 =?us-ascii?Q?NShHwjtTWfvX1AKDQzHOQ42C2f96egakK6om3gnmbV5gauQkvWvHKgMYPZsw?=
 =?us-ascii?Q?WrlQuLkderkOdjgCKFA3eUR2z7pC5JrRJG2YAkAMcfaZO58n1vyjEvUJtpgG?=
 =?us-ascii?Q?Hzfqw5nCff2fKvXVLaPNlAuksBPVxuTI/no83z7DsP+KdXgYzh7S3Ri9HgDr?=
 =?us-ascii?Q?Kfr/FdNMWspLdFaExYrz5cPgpwsrZtf3srLTEJQHr9+Qh7pSTYsDh7Jpz6e+?=
 =?us-ascii?Q?JRrwYnnoXAvOWiasFdYeaX0xCo9S11XC3H/BhWPA8mZZyibPOj7Ql71KiCH1?=
 =?us-ascii?Q?MtQ6xDyYdf+Lrblw8E7CCqkAtzCAUp2BKI6mJGkohKQ8cym/qf527fx+SMFR?=
 =?us-ascii?Q?RW/y2L/+Tu/F+MT9CkdE+MHIwTHf+zbFQAR3Pphw9N99rWYL80OATyoZk1C+?=
 =?us-ascii?Q?KvT1TCv3u6tFWvlS/8GjHRZeTavwI/GaGwfSu0cf3sEJlOYRzwcicdjA39Qi?=
 =?us-ascii?Q?RUzDDmnmAVXaA+ylWyEzNd+3cQjYo09wUg57STgf6K0hNH7V/pSjzzOmQRFc?=
 =?us-ascii?Q?sgNH8q+1dMtGs6K0/rqct+UeKbTDNi1bcLo9fo6N+xeIiKZ2Sok5vpcajwwW?=
 =?us-ascii?Q?eWPW/iNFGyOdBL7mLO6G5JNTTWxfFQ9ExxxVXHVf0ajjpjH9TRhFG8RQT9M6?=
 =?us-ascii?Q?iick93S/BIOcGgyMKzPAn9swS7i7SeHIakUG/oaozjf/oy6nx1YLrXiE/Mv+?=
 =?us-ascii?Q?v89/QTEbfhTZ/rsK5nQ3Tiri78fC2DTH4Z/rxCf3Lov1dBoML04IQzmZjfSW?=
 =?us-ascii?Q?3BFwYdvQ4gBDwt9tMlqarVYSkgFBjux2zXZrVdw2XiIPwE5F5A65tt5NsA3n?=
 =?us-ascii?Q?019vF5Pn265KMx2hzEKFzgk9XyQ8CDUjhI4NWKSsWt9fLlvce1zRU4cPbojA?=
 =?us-ascii?Q?bz+qjYOcvKJU42vOYy8u6wQhuUDrPQplZF+a4i2XTgCFGWI65l3BvTfIj2xc?=
 =?us-ascii?Q?H8SNsH7rPeobcExLnN/XFJU/oYRoPI9nDr9ZBLXZa67KQa0+ZNCcVCOZbaEe?=
 =?us-ascii?Q?LfxDZxxDaFN2BZlDsnEwfbt9Q+mwgMoxO9UuCyT0YROxkq47rEQnapO3+NS+?=
 =?us-ascii?Q?Jnmn583phMpvdok7Wo7LhkY99HPQ8PyTEnEwqwSzLWu29IPaeAWEEhzICUoj?=
 =?us-ascii?Q?E8Y7XdSHs+mElb2M9FS7AS+CF+6nybYMIORc062Fu2XYKyPcC1laokWAZ9e4?=
 =?us-ascii?Q?cOhX+WFCrT8mrhcDYt3CTriB42aWs6QcaTKDXKvBpWKdyCVSlSoWqdtMWfbc?=
 =?us-ascii?Q?nkiAtwK51LJLd/29O+H8m05q0/sfOrQhUmeOIvlMbCOF+KU3TT8E4BVnxCO9?=
 =?us-ascii?Q?R3T9U6r+rInab+EF79nN0NbyqYtoL4NKU/3971K64DG6ED3SCR1YihWtHE/A?=
 =?us-ascii?Q?ApRUt3d8ljaqQEhSuMC6EH2L3f9ZDqzXA35IXbdsmAuFKGK4q+M9IOUWWf7w?=
 =?us-ascii?Q?5g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2eb9dae-bfd0-4e4d-04a0-08dd51ce3350
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 16:47:02.3941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZmuGCGHVAIG219PGWhB+hcUFEUfL8/xkgQmGyKSUHAOr9jo6LyRxvI5SyimR402knt6cBwbo0rpnBPI7B/1ISg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9257

On Thu, Feb 20, 2025 at 06:32:26PM +0200, Vladimir Oltean wrote:
> +/**
> + * enetc_unwind_tx_frame() - Unwind the DMA mappings of a multi-buffer TX frame

Ok, maybe "multi-buffer TX frame" is not the best way of describing it,
because with software TSO it's actually multiple TX frames. Perhaps
"multiple TX BDs" is a better way of putting it, but we can argue about
semantics later.


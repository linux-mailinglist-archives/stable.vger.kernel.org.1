Return-Path: <stable+bounces-144719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA5DABB09D
	for <lists+stable@lfdr.de>; Sun, 18 May 2025 17:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A04D33B9210
	for <lists+stable@lfdr.de>; Sun, 18 May 2025 15:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B261DD877;
	Sun, 18 May 2025 15:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g2mAkOC5"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D221372635;
	Sun, 18 May 2025 15:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747580602; cv=fail; b=qkZQEYNDNi3DC2I5uYeyfBHIv8qrnlMhdYCp570C40qm4A4kHWoUkClOOIn0JIdd5o9GOzXhstUwOISmXv8+HpXaF33qzoNFOoGCgVNHtFs4TOrQQwYTUeIRsXxOXBR1zp7m8oDgEmHGM8Ll/lBY0GC99dIaSscggrZBolu66/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747580602; c=relaxed/simple;
	bh=CeqmeZ25K5YHqqc/YiMwC+CNPIlh9G3fgYi9fWSBbt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IJ1/q7a5srzyWDNpOreH2u9xZiZ5UGUKBa6QjUKjwmt6Iqhfe+B/HJWBYMs/WiSE9GMWUIFeS24VpGfqq6hI9HD5RXim0SAxyFOSVclo7AjJ1pO+giKMghsp30pZ/IfOedssi1g5WgBbbgjhm7tX+DrvDdy44LFH/4zNsKKybQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g2mAkOC5; arc=fail smtp.client-ip=40.107.244.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJDDuGvnQnQxvp7aBki5SYU1fmeB9zDWOHxrm+jVcQj8ghDjrxb2lvMnpDWR1jiGJQUVgLJo9oc2K44tYQA8IHDxGNOUzV963u2MNlxIgN3AXID9IsndaQdVPs0iIpuwIYWrRflTw2SVOVbXFNzKR6bVUJ1EWAPNUao6oe6BjSZLRXr1y8SwhPe+xul5zLi6RirPznDwpHpQ8es6MSMcSmhzc7Y59Z2lGOBKgabL0m6N99kgirQUVPcF4FflXKbUatAwVoZXNFhNt2MO7ADboUDbKUJjSx75k+P3Yd0QbfKq9ErVXWIAM2O755YcpCc55iAb2K2U/Ig/pvJcBgerJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3T80e57EgeZnewY1+Ctp4nRqaQVzqXFk1Dw48mnkas=;
 b=ad2BQJoOoQWf28FKVkEsH2kZPvETlXApqQsUCkt8sk59J+5XSK1X2RWlv9cVORQEaG8qeBeQ70kSB7sMSwBwh3rEhee5e/Xs4cpHlGuZ46u6zAlBvCMrmODQeKonhgDcZuRNNjz918c8sHaMqUf2eTKEKl3MPWGPBifFlNdzQUIgfPj5OHQu/YrbGWKU2WjwVHssMSCJUsZc3XXRIuRzcMOhfc+EFJXTW/FbBSb9eZr3cB+C/+9hdET1LVRK1+RHwi/EIsnNMEdanDOxHRdpLOz+BSqw5oegqr06XzxYx0enKJeQhHU0qlq/BHVmZtmM3Fffhhe7ysjy5ntSNBLyOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3T80e57EgeZnewY1+Ctp4nRqaQVzqXFk1Dw48mnkas=;
 b=g2mAkOC59NwJNKlMtlKN68L4krIRVjejb93tb6cj3+C1YFpzTKn1CGgBr6R8xleIvLT3uwNH1gP/fqe9StCd1hdqhKo4ra2eJJcWP2aLjbMPmNQdd9k2PPSRoGdzfY7BchFSmddudKWvdPfHKVLchKtAlSmmvqSHqiCT+3VALEKz2qdOO+uUoRFfIst874zcEqtXbibIWt5W681HZG1Y/7mXylptE341E8pX/SGEtatDIIBTVTY++NzK2vOseV/wXI0flhyeXTw5yg8SKNGitrzj3H2Z+k9icY+67LwuwpBgUybgcXfggcTaR1Cx6k0ocBqxlFPl5mRGZJ6C9W92ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB5735.namprd12.prod.outlook.com (2603:10b6:510:1e2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.29; Sun, 18 May
 2025 15:03:17 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%7]) with mapi id 15.20.8722.031; Sun, 18 May 2025
 15:03:17 +0000
Date: Sun, 18 May 2025 17:03:14 +0200
From: Andrea Righi <arighi@nvidia.com>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: Patch "sched_ext: Fix missing rq lock in scx_bpf_cpuperf_set()"
 has been added to the 6.14-stable tree
Message-ID: <aCn2soZgtO3kWAyX@gpd3>
References: <20250518103528.1830160-1-sashal@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250518103528.1830160-1-sashal@kernel.org>
X-ClientProxiedBy: MI0P293CA0007.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB5735:EE_
X-MS-Office365-Filtering-Correlation-Id: 4193009a-c0f0-409d-efce-08dd961d1eb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o8C0fE3Gt3TNLnGT4QgljADfLCX0CkC03wr46kxN8rmjVsXqddLhg5ZFwtuX?=
 =?us-ascii?Q?4Ua8ryvWfjWNzcE3hfJdb2ZCB9AaCZloc5cMNWO2YiDywPuyiJuKtmXRKm0g?=
 =?us-ascii?Q?BCOACDWvHMEVR4OJyaCjzriuqUKALrP1B41d58UrczyIU/wH0txn66z0cwud?=
 =?us-ascii?Q?NhRtPDsshv1vxRsLTR1f998kp5TdOZkAVrgJ/fWe40aNEUx+i/r54UbTQbpy?=
 =?us-ascii?Q?OgEUSe74Bjy17QEXEIxcN6hKRTwHo7BAAd/KQat3Ge3vKp6LGJeYG+w6+MN3?=
 =?us-ascii?Q?zTwaPVMvnBv1d9i9RgmYFjqzsZdWRe02yClnepIXNWY4CT1yW10AXhhKJ9lU?=
 =?us-ascii?Q?3T2NmxFu3DO0mxdhn7NIrNeBvhks5YvTyu3NTbIps8cUXPQ5wgizkebSc5VX?=
 =?us-ascii?Q?AkH7bYPSpmBDXJATwNfrlNGWncNkHW0HKXwVVr9F8BMZ7nPTNx+NlxXE1X3M?=
 =?us-ascii?Q?7aFkhWFe9J9m5oxN0l2yUnweG5s7Rdqslyb1+o2KZGrK+ZkU5k+BWOrkxl0p?=
 =?us-ascii?Q?RfeiO88NgOMEwfigSexKJMrzkZwTniGdLEzpp0W22AGesHmpucnwn5Iz2Evl?=
 =?us-ascii?Q?G5XDZgJ5L1kqV60cjLp+Xj13ggaD5782l0CS8B8QOiOY/qnRKEInVK8rSAMm?=
 =?us-ascii?Q?u6qqE5185SBV9In8Z6KVQSeicSGr3cc2FQXV6OIRRwxEgwRQJhSNwT6xyyOe?=
 =?us-ascii?Q?47b/VVBaBHmBreOOOzkNDPXd8GZ889qaoGojrtWGZBHGgW9TyilucFhqTTcf?=
 =?us-ascii?Q?nK2SKFtPFgLwIkM1znecWxC8jNvpIxzT25R19v3IyidxPHOPoZ+zXRuwpPUF?=
 =?us-ascii?Q?0tREurPv4DL1wWYkQYIeSoTA1fRkYREsSbyb6vpjoiVLyf3a+x7c36+P7pVp?=
 =?us-ascii?Q?UarLRcRluxmBYUJgw4QAgwpxcIHKceMF5//CuGveqazDfxDuQClTN53x9wwx?=
 =?us-ascii?Q?TdhlISrI8m/o86G+Kf1KPPqT0OavDp88Jt4OtZkQV6XwUOe4s/G6T28k7bAl?=
 =?us-ascii?Q?ofgYRlxRuPKLs49BW0PIZ8dgRh2fbiQ0w17xzNOMa8yq5nWwceOj7M4kyT/q?=
 =?us-ascii?Q?oMFUhZ3XkwyqcG391An82sdhi1pgVKtF/zPg360D/OBYr6p9ZsiZqgtj1YYO?=
 =?us-ascii?Q?t7oV1K1qGmurDrAM6xuhQqxeaMgrfj2ONHlEsLTvLxY3ctDBLMhrl1Ye/wG3?=
 =?us-ascii?Q?R/E7bSfCHeUxMH1wTwZh3+h6reRgkVVOuXhTld5nAneZF37MxYw49eF99WDa?=
 =?us-ascii?Q?96jO0kTcIVMt646xunEX03lbSaPynsWp8Ajevtkvo1gD126DqCqSMV5IBRT0?=
 =?us-ascii?Q?ItxbXIRfEQOFolp3a6U/ZBl4Njr0x8AENMrmU/4VhiTgvjMBaKxYzHZDh1pJ?=
 =?us-ascii?Q?2Bk7boXA6jBzIYe7U7FDB3TW0vNmi5eSfLAkowPVyLs2qYC7bZXC/ZqUe3jC?=
 =?us-ascii?Q?6sasKjFjYo4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YJiXSNFTcsxk6U3A0rThTzHaNxXDUAcAB7KA0o4dwxXth2jh/25u23eja++Y?=
 =?us-ascii?Q?lrbzkPeTge9Mw1VlqYANHT/DG3l1F6kiMSCo6aHh3chZQ2dxFKnek0WGEdZP?=
 =?us-ascii?Q?D76WEQ8mLncW8lR/Mj6O7MOlqT4+cBzBw0KljSloPRsqi5ZeSfMRvN8O9Prt?=
 =?us-ascii?Q?yn5t9NBNHnv6/TPEgRHwNG7WP7j2/svFfd9AUrz8VKC796+MjOs249HumXjD?=
 =?us-ascii?Q?V9+CnZOCB716U88m2gsE7hAKqwKOKzVjbBrT0STrqTCsF2NhrJs5PqO1bZHP?=
 =?us-ascii?Q?OwzMoqCWtT+jf3sVPzd3YUacnRiNcRbt+RH0wlGVSijVvuj04jrjBfFdBdp2?=
 =?us-ascii?Q?JC07NulLyqPhj13AjkvbJBSwhLYBipaDr107vHyqWM0C083NL2mOjr4Sk52W?=
 =?us-ascii?Q?7Le8J6ZxOPlaCy6I5WtvejPZ/pzRIz1MCBqM9iHsjtqu162p4U0sWhnftLh+?=
 =?us-ascii?Q?Q+5nR5MrRVNMAwwlLzl6JKISjk1fuBuvKp8mUhFTI0IOTBxmxKscRaZPdl+l?=
 =?us-ascii?Q?niydxalO0pgG2jzemiQALTgUPtsvxOI0P0jn2m3tOjUVFoI7H9zWS6u3MOX+?=
 =?us-ascii?Q?csuBUr5e66301PgXNTaMRfTttECTOXf5O9d3f3YsjvEG4VHaLgacMwdjqkzn?=
 =?us-ascii?Q?CXOpbL6G1/5+V5IYDNGwMuHDYCXJuX5eyn4/YgeRt/PHGXMFIXxSttiBEhjE?=
 =?us-ascii?Q?YLCxWHYglgUXqiooNICyEvJoaXaDB4KQJvMA251cJ23O5230GILUmYFSHdjI?=
 =?us-ascii?Q?zzNf9icwvEMqFSokRoVS6KGibtkS32UOp50Zv0R5jc6OjVl6I3I8EJt2UnY2?=
 =?us-ascii?Q?D1sjBYQarYWamxmJo4LsNHpWArqoAvaCKDxVEI4hlP3oyiJq83YjmT/bis2b?=
 =?us-ascii?Q?T0SisNuiSURLMdsCvFlTAetWgkXeP4AwGV6GFP8BR5dLgx8n8B4QFu3YiBzc?=
 =?us-ascii?Q?c2Nx8PsaIOtIJ95qD+hmkSO9UFRFQ3sMTVsnUqWJ+nr6IXbUYqbkE7UqBiCn?=
 =?us-ascii?Q?gvgx5I0ad1S23KpDRUlPHz747oN9bbd9BJOgDw9gONNykv6FfBhWsQF158Ix?=
 =?us-ascii?Q?8v+zHZME3qEoeAogAOE/nFV3OBKgXMMMWWtp8GTkCd1/DG+cKZJV06j1zpij?=
 =?us-ascii?Q?d48UcmTZdC9ZkWA4hL+n76nHWjJHOKATKTKaQakqeHPOhBteHjWgdqIIyXuQ?=
 =?us-ascii?Q?uzDXqTemVg39lIBsDKl9i2Sh9hppXTFdbwnfSCFDGVns8cR95gdrtMu2lr/1?=
 =?us-ascii?Q?bjzLTia6X/N700CrWEhObYf7f3bbNbTRb6j6J55rM+1axSi/qqYUA7bJEv31?=
 =?us-ascii?Q?1uMasKiCH/BW9fUPNz9vncAOxtlv8Ji6B+d8cw+xJoMjYkrQ53C2dOIcMCAU?=
 =?us-ascii?Q?h915D5nefSR5VYRty1CWTngAHLrau2KG5xY23nTb6eYWaEVCen2y6ttCdR7K?=
 =?us-ascii?Q?zBJfbfhMhfRt0WNt1dPX8Nv103n24malC1gzGabQmXTHFwXlTC0qa2eFaNqR?=
 =?us-ascii?Q?vAQg/psKy0FvqLWcLMI6V4JuUvsmJK18w0/QNkkLrpvPKNEBErXM5p6aPvCG?=
 =?us-ascii?Q?oGp9WPu5ppfyHhdWmPP63l78yR1NWFzWm/8ycJnw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4193009a-c0f0-409d-efce-08dd961d1eb7
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2025 15:03:17.2425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zGnOsNgfzau35ReuIk1ZxWuRhdzoGarMxrJkhKS9dgnEVSIKrPXN+M6oead21Pgg6mporylHxBpNdsNIXhXCZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5735

Hi,

On Sun, May 18, 2025 at 06:35:28AM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     sched_ext: Fix missing rq lock in scx_bpf_cpuperf_set()
> 
> to the 6.14-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      sched_ext-fix-missing-rq-lock-in-scx_bpf_cpuperf_set.patch
> and it can be found in the queue-6.14 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

This requires upstream commit 18853ba782bef ("sched_ext: Track currently
locked rq").

Thanks,
-Andrea

> 
> 
> 
> commit e0dd90f92931fd4040aee0bf75b348a402464821
> Author: Andrea Righi <arighi@nvidia.com>
> Date:   Tue Apr 22 10:26:33 2025 +0200
> 
>     sched_ext: Fix missing rq lock in scx_bpf_cpuperf_set()
>     
>     [ Upstream commit a11d6784d7316a6c77ca9f14fb1a698ebbb3c1fb ]
>     
>     scx_bpf_cpuperf_set() can be used to set a performance target level on
>     any CPU. However, it doesn't correctly acquire the corresponding rq
>     lock, which may lead to unsafe behavior and trigger the following
>     warning, due to the lockdep_assert_rq_held() check:
>     
>     [   51.713737] WARNING: CPU: 3 PID: 3899 at kernel/sched/sched.h:1512 scx_bpf_cpuperf_set+0x1a0/0x1e0
>     ...
>     [   51.713836] Call trace:
>     [   51.713837]  scx_bpf_cpuperf_set+0x1a0/0x1e0 (P)
>     [   51.713839]  bpf_prog_62d35beb9301601f_bpfland_init+0x168/0x440
>     [   51.713841]  bpf__sched_ext_ops_init+0x54/0x8c
>     [   51.713843]  scx_ops_enable.constprop.0+0x2c0/0x10f0
>     [   51.713845]  bpf_scx_reg+0x18/0x30
>     [   51.713847]  bpf_struct_ops_link_create+0x154/0x1b0
>     [   51.713849]  __sys_bpf+0x1934/0x22a0
>     
>     Fix by properly acquiring the rq lock when possible or raising an error
>     if we try to operate on a CPU that is not the one currently locked.
>     
>     Fixes: d86adb4fc0655 ("sched_ext: Add cpuperf support")
>     Signed-off-by: Andrea Righi <arighi@nvidia.com>
>     Acked-by: Changwoo Min <changwoo@igalia.com>
>     Signed-off-by: Tejun Heo <tj@kernel.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 77cdff0d9f348..0067f540a3f0f 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -7459,13 +7459,32 @@ __bpf_kfunc void scx_bpf_cpuperf_set(s32 cpu, u32 perf)
>  	}
>  
>  	if (ops_cpu_valid(cpu, NULL)) {
> -		struct rq *rq = cpu_rq(cpu);
> +		struct rq *rq = cpu_rq(cpu), *locked_rq = scx_locked_rq();
> +		struct rq_flags rf;
> +
> +		/*
> +		 * When called with an rq lock held, restrict the operation
> +		 * to the corresponding CPU to prevent ABBA deadlocks.
> +		 */
> +		if (locked_rq && rq != locked_rq) {
> +			scx_ops_error("Invalid target CPU %d", cpu);
> +			return;
> +		}
> +
> +		/*
> +		 * If no rq lock is held, allow to operate on any CPU by
> +		 * acquiring the corresponding rq lock.
> +		 */
> +		if (!locked_rq) {
> +			rq_lock_irqsave(rq, &rf);
> +			update_rq_clock(rq);
> +		}
>  
>  		rq->scx.cpuperf_target = perf;
> +		cpufreq_update_util(rq, 0);
>  
> -		rcu_read_lock_sched_notrace();
> -		cpufreq_update_util(cpu_rq(cpu), 0);
> -		rcu_read_unlock_sched_notrace();
> +		if (!locked_rq)
> +			rq_unlock_irqrestore(rq, &rf);
>  	}
>  }
>  


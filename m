Return-Path: <stable+bounces-144718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB954ABB09C
	for <lists+stable@lfdr.de>; Sun, 18 May 2025 17:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91F3A3B91AC
	for <lists+stable@lfdr.de>; Sun, 18 May 2025 15:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD2B1DC988;
	Sun, 18 May 2025 15:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JgYGvHKZ"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5A541760;
	Sun, 18 May 2025 15:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747580561; cv=fail; b=msUVUuMl/6usaacSD/4mOl4apyPPAHnRyIzOA26f1yFzD0oETmGkGtYLedcYGrMcaTzUjHwwvIstplwHki0H6Galvwa9rHQhDC7/mtaAHy0QsIUHWPnRpsrIorCpGrRFOrnPyTAnLJWh+y6jqPWqk6Gf0v7kF8cQeDfoF+pYcEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747580561; c=relaxed/simple;
	bh=wEH9TpVPS6mUcwjvsNjcLOmNMsn2CvmU7jBn9acN3hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SBkLrOyKMdq5ld2RdgSsO8nHGAKmCxE5dXFfNNkOtBOaNfziD0LkyBvJmpz3ylttcKHK6JmgOeuyXFT6SoI3z9rlaCljFamvoSBpVVdxmI4c8LLCWmOHpEktyGEr8curxwm72WNIX4rfJSO5CYUg6ObCjITYyJNYsJl+VlUkYBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JgYGvHKZ; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AoE+LWFsMFha1PI6PKXNRU4JHnX0qHoaWhzHtfF7zqs9K04yM8nTIinG9/G+d2gjG9G8ND5IvvaiOtk5PUzgTzoh+kgtM3PmU1wgwjaHCBc/YWw8TEiqz4OpjiYD75A+kJDQCXqGRPK2nW2h01x5Ze/IVLTPXjtuEYrJnmqoA3hQkqA/VbaikVM8SSVOzPYTc2fPA0/N0oJVsrOcPDQ/wA8LuVcT7nzdZVBj2wHeC44SikerVf1QOY7oIsT/N+WySuVIyVLd/AWHX9EiKqz6vzAi6+c08T0QVZj7HlsqZR1K1vEQfpblrfeNsuKRZLVJ6khrr3wfQ1pZULvZqalAhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GaaknrdVGh3yxcYsaECXygWwmScArrZBPuel7HUF0w=;
 b=OUiXbuAMyGV23eP137AVMl6KklQpIYq6OITp9PKgIFDV0DtrCRO+Q26eJWFviyCBv+bRq1GLbD1YWDKfobttynpherk/QTs3z/JsKHFYXJC55te1JZRuGwi7Lirqbn8asEnPNMGi5J8Xuy3XD7HciFJAg73MwMOHF3bYos/NSyye9b1ippiGKNBdgznKmHLw8fit8mko6+f7XhtQvT66/GKQOleimPRAaPuSyURVUt6+dRFVRFlYKhV1Egh8G3rqfvNTCtGz0Wpu8y9qU2eZUV5/BBudxTr3el96c16lXfSt0wh378U1OrN4GdmNOToEQomg14KuyD0IighFlOGjrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GaaknrdVGh3yxcYsaECXygWwmScArrZBPuel7HUF0w=;
 b=JgYGvHKZhCnrbkI2aB9eufEJ/YQ/RGvDJYAhiZQrjGf9JhILKTK2DWGvl8b7BEN3W3Xz7dfUbxlD5/3qqR5ZSPO4KUTaNMudOKALVxEKKJOorpVSHgvzlJHK8YxCMFkCPFOg/gGMnL102dK9E3UFaxZ4N4a0sppfbpNfJFjotHW9/R+Ne5gi5QuEb3oUWx/TcMMI4bFyD+us66Rs+IaSIOYJZOdn6L5lS1OcwfWunKHiBbWZYBJ0KdvtptsUWWnGeSPH4yrxfaT8guo1uyQut1kOw0dsGVG4KnGNWVDlAgVAzQSVs2hf+tJ2TG8eO58+0M0TXSaJOBfeQU79wZWobA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB5735.namprd12.prod.outlook.com (2603:10b6:510:1e2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.29; Sun, 18 May
 2025 15:02:36 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%7]) with mapi id 15.20.8722.031; Sun, 18 May 2025
 15:02:35 +0000
Date: Sun, 18 May 2025 17:02:33 +0200
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
 has been added to the 6.12-stable tree
Message-ID: <aCn2iYHo6pfVFzQE@gpd3>
References: <20250518103801.1832481-1-sashal@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250518103801.1832481-1-sashal@kernel.org>
X-ClientProxiedBy: MI1P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB5735:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a62adfd-1af3-43dd-60ba-08dd961d0606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S4kG20TDa3/L+ty5xUBe5FniFLkOhc18LUoheZtjvfLgCmlwCH623QRQhW3/?=
 =?us-ascii?Q?RfIDZZHhtQRQOcDBfYnVBZuu5ROGtpExqm91aQLIcm/7vpF5Wr5UIlljp/be?=
 =?us-ascii?Q?6XRJTUYzc6dYuTTYyytMF4f4hBmfd6GCDuz5nvvb71chATQ6tAsf+dSe+aRl?=
 =?us-ascii?Q?/sguL9R3+bTUjQU3TcMiGtX9hVRsKmi6UJ0XYXcMGcXXJiXEcKHBPyai+P4w?=
 =?us-ascii?Q?JWnNe7UbGZ/848QyzahHs/CwotFGVg3vyVwYX3HhQZEF46fIYsGryx6LG9G6?=
 =?us-ascii?Q?/7yDQQirNh30m8QOnG/fEElb+BPsCeoT+pr4L1mXDZ2sRf66M0Dre977xaGE?=
 =?us-ascii?Q?ZNesF5zC/nDG0B62g7DLMn+h5ztVZ6k45ZNgpf3R+Yj/E1StdUEOfSQri5LI?=
 =?us-ascii?Q?gqlH6TfRxJVWkSwHOHGClteRwBhWuJJ/yp9KnIE31PuVcW8QB5QaiPdiIwyy?=
 =?us-ascii?Q?QeU6KP5NpZOpd2tI3k3qAuL5gP8dlzPRQtPXi1mQ8Oz7CgeQwQyMpX9Y7Too?=
 =?us-ascii?Q?chnVvafueaW8lVP7tJBCVR2CZeCkorqcztJh7XhaPptnOiyiZlWVo4r9QoYT?=
 =?us-ascii?Q?tygvqBEHqlmcH8omjDR03dsLbwVy/L9yXk87Go6ZJ+5Li6ErSbkp9lMRfmGM?=
 =?us-ascii?Q?PAccQvHB90ol7lSd7MOuvJGFuCW8hMfWHYLTr1Z4gAaFz6L3RqeWxBVhVD7n?=
 =?us-ascii?Q?quvyTL92iGwAwn5Y7NrTgZywo1xtOGNXFSTLDbSYagoXl7OSmen4BcNdpHy2?=
 =?us-ascii?Q?2o3PHZvDaum52mL3rd2X0tXzljq7MIsaiMGC01o1fqPQbaETNJy9FBPtpaKL?=
 =?us-ascii?Q?NIOeOQ41psu/be2u0QWQzBCviH1dKt48akHKBDlAiAG6l2cbVA86mSGygxsE?=
 =?us-ascii?Q?UgRbgNGGXhoMUJQoCbEvsW11u64X2quWT+JP+FTfyIwH0UWHJEGbqo/5lAuw?=
 =?us-ascii?Q?vvM0ae9bPepFI8oLi8PL3zB6UAGuOhO73IH79yOgP3vpkyqjhkcPZHc8oplc?=
 =?us-ascii?Q?estSE2YH3LA1PMknrsXzNB1QlFWVpyrwHSh80FPm/J5kI40UbSE5qC4EdhR6?=
 =?us-ascii?Q?cIImgZdHwsF0dNUZUnywAkpxDgfq3t5EpF3kTLKws9dcbXyxk9Jw5tfP0BeA?=
 =?us-ascii?Q?7hq8DJkzLl2fnInsullwJ9nGfsKA0PD/t5RunYKkhuGhRKv5MiE7D1CFn0u2?=
 =?us-ascii?Q?bgEMdJFYP1j4P71F3cyXaKB+uA2CF3O+UE5fScpXAhm6+tk7Hib/YeaXleUI?=
 =?us-ascii?Q?2PoO8ghA3CDWJ3f24p5g1zlVks7NMlj+CWsU91iaZdFrxYHWm3CRdRU2J3ut?=
 =?us-ascii?Q?P/vyzbIFaP40C7VqHfNPmPdgEhZnpohFBKgTQxl3SkkXRGkKavxXRRVXiFrG?=
 =?us-ascii?Q?1hk5OXit1QO8wHZgGVICwhqQzVNA7h2+iIUTzo/AajbJrA1WY/LVBhds0oLV?=
 =?us-ascii?Q?M0/TWgBxjrQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R5v2Q9vQCWk+LtjXDS9/neXiJIdUJs9e2e/Eg5r3VYa537aDM46vFPEddCA/?=
 =?us-ascii?Q?WZho40lrHduY+xnnZXuDBJJOFimHyoUYy4ro9H/UL8Sh+IDwOunxl4cVx4iJ?=
 =?us-ascii?Q?H68DRsCP7yQmhkt+ynbOXUgTyBTskjFC2puyiZopzH9BSlv2rPloXojYaQAJ?=
 =?us-ascii?Q?FqakRB3JSPDuvNI+qZzeDmQY2CnDv2EifXlvQCGUo6cmBh7T/Z+bkx6wAELl?=
 =?us-ascii?Q?mTmf5JV80h6CGXCQNEvvqrIrmankZRIT1xPOTmvzvGe3wSBoi6HRZ0O89QfA?=
 =?us-ascii?Q?iQAwlQxL3zphMhMIgXlyvXLvUh16MZntbQmyIVWNSVerOrwzoDDRbN9BYVXy?=
 =?us-ascii?Q?RlJ/XdIUFyI8plGLOockxjGr/jyPwn+gJbpwrmzL1/gzs8xAVJXZJ+8hFxaM?=
 =?us-ascii?Q?4gfmCUqz6y0TlmfMmHuTDkER2ljDjzwO2HvIXxNdm81G20UogF452f3brqYJ?=
 =?us-ascii?Q?L9I9cOomv+ouBwsQRIjl+uks9mwi7Z22+9l76KVF17/WxZ9S/hZeBh+qdkJj?=
 =?us-ascii?Q?FeA7PIRYr/RA8ymQGii/G4sBTp+LVZr8B3X83B9bqIxAFuqd3+Nko2zjr3ls?=
 =?us-ascii?Q?i0YvHlnjv8mOEH+Krp7FZhz9/pV0c3rbsJoWuJ3rLUvZQwtU8WugDhLAud98?=
 =?us-ascii?Q?0qTB8+Kz35MkF5Y5Y9uQTmoUV4mdh94xklZ35ARpMNl0UE53sA9E6gjDcLzv?=
 =?us-ascii?Q?PRkzitn8uzVoUhs6+GbXZdEKzD2PzupDwCT/C7WVovZTfmDhO2vRk5vFoy4p?=
 =?us-ascii?Q?eaVC0ho4dVPCOyN8vV374Ya3Ua4QUbZ/M+GtpiG99m1cAa8LM4W4aSDTzJoM?=
 =?us-ascii?Q?VPUQovv17pwoUHXjDggr5ujDMSHEI7w0LbSScirVZ5qpNulve887y5xGIflB?=
 =?us-ascii?Q?CVkHWrvu2QXnAn0hUWYIU3VTBMDWBABSfmXQ/fJtijMHIeDn8w1K48ufwxti?=
 =?us-ascii?Q?SfblzR0Bza4vaHCbhrcfff5JSTlY9gcCGjnf039VqHTzvNipkbhAaGhuv9uO?=
 =?us-ascii?Q?JFl7OIx2keGwU59v5lURO+1vz/k/3hQDBf2MG7irREOY5pYk39ZUl6mA38DT?=
 =?us-ascii?Q?8f94S7trjbJaRy2wKIwRITgZSZ9oMwAnYF4gLmge8iuxWCs9hQWLqefUIfZ2?=
 =?us-ascii?Q?vpdq+nfluxe7P9cryKvRxnvNJI+dd4m24Mq5l+vhZzXtCxzKa3CEjsAHrmjm?=
 =?us-ascii?Q?3kVmgxRiaQWVgUqQtsZ3XDu38GT8Ne+xXUnPJ7KGHXFfbbTDU/Oro+n0vkPh?=
 =?us-ascii?Q?iDYw/7Gj4G51keRP5wgIumqtXGpDPGAcUtqsCqpY3S/TV7+/gTlPaW7b0EdZ?=
 =?us-ascii?Q?IbjvT7QStOhbpbgbrTmJIRrpmhYfpAGo51P3GUCb36CFHwbM3UH67VhPpr79?=
 =?us-ascii?Q?a6M7TJmWlMRZmiCoNv1DlX/fLRVUrHi2wlJxEk+/7rS/72bQHyj9TXxIiN/Z?=
 =?us-ascii?Q?zl/1a4SgQ324DD3Lt5cRhrTX5WT++ft4ST+x9i0PL3mFqCNLZhFsrYZzPXuv?=
 =?us-ascii?Q?bZx01v2/SgcBN6kEyGG4ylsBcR1hPNBpwAqcLPyfWFI+46omM74pDWcj7QK5?=
 =?us-ascii?Q?T7RmXC2geyWJC9tdxCQpYsJ5S3V6gCEp8N51eGxO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a62adfd-1af3-43dd-60ba-08dd961d0606
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2025 15:02:35.8408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fhfolS/vi31k0ZRwhZcMDdEzUW9xi9MWxFNXMop57+hHnwzFQK9pNGSQc0039TUcQWhSEMy9lEynmXB54Hd6bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5735

Hi,

On Sun, May 18, 2025 at 06:38:01AM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     sched_ext: Fix missing rq lock in scx_bpf_cpuperf_set()
> 
> to the 6.12-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      sched_ext-fix-missing-rq-lock-in-scx_bpf_cpuperf_set.patch
> and it can be found in the queue-6.12 subdirectory.
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
> commit b19ccb5dc4d3d35b83b94fe2514456dc0b3a9ba5
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
> index 7ed25654820fd..0147c4452f4df 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -7018,13 +7018,32 @@ __bpf_kfunc void scx_bpf_cpuperf_set(s32 cpu, u32 perf)
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


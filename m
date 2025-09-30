Return-Path: <stable+bounces-182275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51180BAD722
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 17:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2850A3A2D4E
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 15:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0ED27056D;
	Tue, 30 Sep 2025 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OWwsqzxm"
X-Original-To: stable@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011011.outbound.protection.outlook.com [52.101.62.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD2A306D23;
	Tue, 30 Sep 2025 15:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759244417; cv=fail; b=gMQ76LT/fdCch3x6K6Hj/BlUx0IIGwZykW3cCd0eqsUWBZT+MePwdUONeHnTxW1NPBV4A2/6i4GTmxd4CMUey4qxMoxatnk3IrbOTifZgnkzU/GFpMjfYpGVuMAxDN4OPWK5w3pFeufrEjRzI9LU98OyUjJklRiydoUA0RUTrwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759244417; c=relaxed/simple;
	bh=l4MGMYrn3wEde7zBYtgYGD+sjKXcNB7moQoEPTWqbII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O9gROAA1OnfX4S34Cbt3gKd1xVUNKaau0J2UI8iU8z2onBdWc+J+X7eK5Szxzl7XKtn66VBJZZnoU+IOTJ4b9Kb5juCwWaFd3nmPF2ht5LUx6FDV0DNZ1wwJa8kGLWlmR1r2NvUkmiyXEEepBnmZx+AESaGKA+jwJ6GtTbMWMcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OWwsqzxm; arc=fail smtp.client-ip=52.101.62.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JIsorty8JLbiKAX2aCIV1JqNQxsYcW8Z6gnUrkn4AXxQja6IfWdQ0iVhWZ6tz/8u9NjuaLptzYQkR5J76nQ1pJM4F5sG8kWRK61JQdaZyTlx1zaFwVPZ8IAuPDzt/cBCmPMVbinEp63YfFUuoILHqAwzUS4KilkW4hrApMaihnGoiZPTul7LXOdrGNTCOKSVx97x6kdoRYBaTARwHU6NafsT50SgWJboRELVDn4Rl7xpgWSVrQKrd3Yn+0Bcs8Xu999eP8MeZZW3EsoQmmThbVae0UkRD2fGtTCNlboiwVLv6Wctewqq+5wrRHt+0SkRrtiq8u5uQE1FoDBSOa9/Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=045mX67bklqMXTDBLbye5fsIt7Y0nLGzq1LXUiyTojI=;
 b=bEbWZDSWIJ2bGxIGetJwMkYtd6BhDJq1ZTs33tOpWLCEcjpf4EpuQR4eo0vkQG5n5xmT1M6uzPkdfuXqmrNWmAGF6v0SM0swQjpbZ4vObGnYo2MJbD6Z6VSO56xfQ9+gY92tnY2XYbC4agAkvnWI/42BaGzCvgTk43p4E5NEcvilbRYvMgq/cAqsI41Dfze+WtmAP9uhhdkbWUfr7F9TGFJq5G1XJFQGrus4ohQNMo/rb3r8vj+QM1dlRkRz0EQa9o18LrPLIvEa7emCt9Td06aHtax5FDpnWm4ZBpLgC16L0gnp4tAfDp81BQ/hOFhrjO4ReU9wMXhgUSWaZ4lpDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=045mX67bklqMXTDBLbye5fsIt7Y0nLGzq1LXUiyTojI=;
 b=OWwsqzxmlWE9wxUMn8KJlZXCq1szN+h4bRnKmio/+e0bHMJiADLhaBY0Wd51H0Nc05iSXB4VA0X2pSBDDpHvEkhxR21YLlmf6haoKeRtjvZY4BjIjNKUtvTF+erE31PtiN70wttqdMHNzEHkLoz41NJGOQhE+kDEBSdbCUpdOSYgsWnXb5ZAecIdpzqhoNGThb4gd0h4D6ZREEESzLaoGtYoxp7JfqUcdTtJGkLWs3QjUPbLvPjN0r8hi889fwweyrWsbGlHdOhAFF33Di4WHfiCrBoJvDWTCW9St6T+X3qR1E8jRxNoGWFNhMYKt6wSbzD6aL7Va74Cq17CMf2Uhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS2PR12MB9711.namprd12.prod.outlook.com (2603:10b6:8:275::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.18; Tue, 30 Sep 2025 15:00:08 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 15:00:07 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 peterx@redhat.com, baolin.wang@linux.alibaba.com, baohua@kernel.org,
 ryan.roberts@arm.com, dev.jain@arm.com, npache@redhat.com, riel@surriel.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, harry.yoo@oracle.com,
 jannh@google.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
 rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net,
 ying.huang@linux.alibaba.com, apopple@nvidia.com, usamaarif642@gmail.com,
 yuzhao@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 ioworker0@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v5 1/1] mm/rmap: fix soft-dirty and uffd-wp bit loss when
 remapping zero-filled mTHP subpage to shared zeropage
Date: Tue, 30 Sep 2025 11:00:03 -0400
X-Mailer: MailMate (2.0r6283)
Message-ID: <98A8D177-A476-4D97-B6C4-DC3F34E91126@nvidia.com>
In-Reply-To: <20250930081040.80926-1-lance.yang@linux.dev>
References: <20250930081040.80926-1-lance.yang@linux.dev>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN9PR03CA0506.namprd03.prod.outlook.com
 (2603:10b6:408:130::31) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS2PR12MB9711:EE_
X-MS-Office365-Filtering-Correlation-Id: 14888aa3-0d40-4cc5-fe94-08de00320b76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BUA5L6qR9Q9kZ0O0Wsp2N3T2lvkAlTono+EdQtDcpGUpnul8CEHvfZ21OPrG?=
 =?us-ascii?Q?Tv43LPp9jkO2JvsWg/pfk2o8FXeYICtc4d9cm0AF4d87ZaksK0gUGPZcjySY?=
 =?us-ascii?Q?2gSh4QOio6NNHSf4dwnj3jC/aymoyFHyKInxwsGXxdJwv9hL8fuvmudperCT?=
 =?us-ascii?Q?RqsmGuD/XRJQhH8H45/NSmr32BDH47uWDLu5iqn3AdwQMUJJg+IcD9dcKB82?=
 =?us-ascii?Q?zi4Q6PPyNwhAWnpRIl92/wGpMFMMemuZRf95bOrmJBbBDd9dWku+djrrTQa8?=
 =?us-ascii?Q?djGEGfmvcqXjZqR0AP3pNHfW0RX0Fv5n1aR/9tEuIHrrxY/EmX85st5ksCuj?=
 =?us-ascii?Q?HUxVvb0eSuZYEylgGwGxN7fQbmIs7zMiWS9eqhXM4P2yB7DOJsCMFZYFqrKk?=
 =?us-ascii?Q?z5lBgDeSLScHgA6PqWuJgCjg9/TEOvCmplGeGRa/LQSi/1YkMkZjyEqpPT8e?=
 =?us-ascii?Q?d4bW7bI1fME76PLaZF2cJeMlCRfH852IzoD9bh+HWuXxCBNebvJG1A+bBei1?=
 =?us-ascii?Q?LUvZu37SlAcJpsW1kavTvRiPdRgPIf6xQbctGZZOG0DhUYvEjxWlygho7qXy?=
 =?us-ascii?Q?EfTyR562huYPraNFl6ciNjhBPvdtujT5C83Yy6DLatAuTKwnJV0qWLybHVyj?=
 =?us-ascii?Q?i2acKAv9KzgtjsiPzPU6hKa5M9a+2cxdZc4oEpj4yuBE+NMwoc0sKWZrzPM9?=
 =?us-ascii?Q?oIpYMEfMtqemMEYM3R5IOwXy665ZrgI2f95haZEmMpuBG1WM6FYUDNeKINYl?=
 =?us-ascii?Q?azb579AgwE7b4gh+E4SPTcJ1bO+dLTjf7KGmvqqFU/F4dtdkfzxS5aRoH9uO?=
 =?us-ascii?Q?3Gpdy5QYuK3FViFJqVQltmogukLQXQWNzIxjM7aVCSG5CG2MXhpO+dnNudCi?=
 =?us-ascii?Q?12wfyVqzMmmDpbMVxJevQ2h7zn7t9V0YZBSapys7yMamxyScmfMST7mBcsMQ?=
 =?us-ascii?Q?fxn6dLSE+2n7GCnA3pC0gcu8SLR27Jj95U4+kFLr/R5yjG9C8Whk1k5/pZdc?=
 =?us-ascii?Q?uTzoQICOGHxhJ7pjXf8OfSIXp4wVfhn3pZJ/ZgAmeVJV8b+vVnkst7I7VaPr?=
 =?us-ascii?Q?CBB+0xHXQEsuDcHHERJVTL3DlwNWGVtvnsN12bdrMmOCnKI5iTq/DJH5Kumt?=
 =?us-ascii?Q?xV+hoixBYG1F5lBsK209D32vHf7KbPvCEBxLH13UP15ySrXK/vr6T5VnV5ib?=
 =?us-ascii?Q?JMVzSLutj31sPICiOJlwdl8cHMAtCykhAIbv9nSORULta+FlYeDFVO/qcVMN?=
 =?us-ascii?Q?XUT4cH5psYbVab04I/gYt5QKKnhSv/cF3iHDgjl4x5oWjppHhVFUnF/Y2O+A?=
 =?us-ascii?Q?n9ynP+ytuKYxO515aOpmFH9LMl9eEuV8Q1JaXMeejTsX8wTkgM59IWcLEkMY?=
 =?us-ascii?Q?UWykbw6+ImbEQL4PHv9H69xEhvUnogqf4W1HpNs1BRVFHaNBzII4ioAqLraU?=
 =?us-ascii?Q?zn9mqgDfqRN0UUxKQ9gwD+RVHbcgO7q5Ir0NT/W2Bq+GLELwrl5oGQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NOA29DnCULw+bA0QYSz+tzFnXgnxPXUK/7gEGd7S64654sjFBNpaOPS8sA5d?=
 =?us-ascii?Q?uJ8oGkLtyS7D9OhkZCi2Vcs3b02h8eXFjv2Tw1UI4U90p0EyIxRhN/rueZiQ?=
 =?us-ascii?Q?14YyzJbI7QiO4wEo3opWz31HVeQCTvN6xJR7gn435WvBV0bFJAShA26hJAds?=
 =?us-ascii?Q?oYm1hnWZ7aIkIoxx+3YfMnbZx8oXNFxGYamk2tksS5SyPWGomEoq5N5tgUTy?=
 =?us-ascii?Q?N/Hz5xwQZuqIKMgXg5hhSwjJeNDcBZwIwJXeKRJtBqgWO00mqUX7Mr9vQbLw?=
 =?us-ascii?Q?I3jCSBlhvB1+Cjr6tRKg2ZhsJR00qeSj+24p0/bHH5PHzxQau05qANH6SLoF?=
 =?us-ascii?Q?MBKciTccpXqwxuMGIvvg3MQNAjfAErsNp5Zp+7BZymMFxXZGkjhzhu25Xhac?=
 =?us-ascii?Q?eTji1VgXNUstWa00xAmk7GDKne2FnwHHHllMyI2N6zVZdgI8/F068WBEemDr?=
 =?us-ascii?Q?FrusPIXJjmdfMl2yU/KSCHvCto213VfQgRIb7zF/lko+Kb+4YOzejo9CJNtg?=
 =?us-ascii?Q?sdKuaYF86GmrqSYbyK0YGfQGTYPUk7BESgSqE7QwjQl1GBNK6cb/hmTM72v9?=
 =?us-ascii?Q?vOBgRmSp9WhpvLJaznOfgPYgqpNHHOK02nPUOpmqribzlZwYxAQ4m8JiOdAU?=
 =?us-ascii?Q?C6MFK+bLrNP09S6hSnu4njdPJffMTtKZmkwWAI3U/iVa+rRNX56d015nd7D2?=
 =?us-ascii?Q?MhriP/FzCOm4jPPa/2Glkw0E3WL3gJtaE1cOuB/AC7TD32D7X6Nci/Vz1hIr?=
 =?us-ascii?Q?weaWtUvn9E+jqr23Drv74puo1HSy4wA+A15TkuzMcmaE8pBRIqUi37oOJufC?=
 =?us-ascii?Q?GzI3sPNaw0nB3RJWmbxWIfirptBDVipJJncmJ4x3BAiHQNphOz6KrjrQos2G?=
 =?us-ascii?Q?PLQWkKrsygi3dlvNh5chqv5TTeVGoJsar+z8FPf4nA1vLRNOgLpvJ+76Sc9s?=
 =?us-ascii?Q?7Nf/7aK9PxryEKc60Qb6NdnF8Bq3bse4/c+iIV6MFX8VB7cg5du6/fpt1KzH?=
 =?us-ascii?Q?YLl1EmZubSeWV0Hsv5Cbphqs45Gh9dT2qbxCxgodQ1sfBsK5XF5G//u16zhD?=
 =?us-ascii?Q?HDUtUHdIMCFzLYlnW/rJatMD1Gzs4HIBGL8ZPGPGTfkkDXlbxdKFfDs6vO9J?=
 =?us-ascii?Q?jDZYdeH1W8u+KWvSKHaQWVb/D7x0A3W1Be7nZl8a4+9hc/kX3Ny/Fakp0lf/?=
 =?us-ascii?Q?gjIv949qt2cpozSR8/4fm3zOE5YNrpRlyMNJ1IpePKTc5MrnEt3QkmGzol1p?=
 =?us-ascii?Q?+9RgBmRuAQqCSxS6+KNv/4/XPH3z3LnmQw8pKHYE6602hVNLiARgR5VJ6psN?=
 =?us-ascii?Q?JfEnWRd9UKlmsaPuWIT8L0FmFboC6IRIjMOVVPvK4JlMQnoNC9etEiiLe76L?=
 =?us-ascii?Q?lzilcW72d454CblN9TEjSHGdZncIJXv14mU1k2vLK6gIhwsSbOHP0CPHaeaq?=
 =?us-ascii?Q?cjxmri4+LE9OmWougMI+gLUF/CPZIdEzNLOlLayGzLWJBNL74PZ6tUx11Bn8?=
 =?us-ascii?Q?hrh1eoP76FFrOxTRNf4QxMJyIo3NN8qjhwZKFWH3WyEU/g1ShoXhZvIxw8Za?=
 =?us-ascii?Q?FztzNHoVSAqxmP2Fk93hOsueW8essPumiTe0IKnQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14888aa3-0d40-4cc5-fe94-08de00320b76
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 15:00:07.5810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: biGW8kX16xvGISVPjPRl4U1c893kdEPBzqTviBWyokpgSFu2JuQ7St9tCZbNSsAt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9711

On 30 Sep 2025, at 4:10, Lance Yang wrote:

> From: Lance Yang <lance.yang@linux.dev>
>
> When splitting an mTHP and replacing a zero-filled subpage with the sha=
red
> zeropage, try_to_map_unused_to_zeropage() currently drops several impor=
tant
> PTE bits.
>
> For userspace tools like CRIU, which rely on the soft-dirty mechanism f=
or
> incremental snapshots, losing the soft-dirty bit means modified pages a=
re
> missed, leading to inconsistent memory state after restore.
>
> As pointed out by David, the more critical uffd-wp bit is also dropped.=

> This breaks the userfaultfd write-protection mechanism, causing writes
> to be silently missed by monitoring applications, which can lead to dat=
a
> corruption.
>
> Preserve both the soft-dirty and uffd-wp bits from the old PTE when
> creating the new zeropage mapping to ensure they are correctly tracked.=

>
> Cc: <stable@vger.kernel.org>
> Fixes: b1f202060afe ("mm: remap unused subpages to shared zeropage when=
 splitting isolated thp")
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Dev Jain <dev.jain@arm.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---
> v4 -> v5:
>  - Move ptep_get() call after the !pvmw.pte check, which handles PMD-ma=
pped
>    THP migration entries.
>  - https://lore.kernel.org/linux-mm/20250930071053.36158-1-lance.yang@l=
inux.dev/
>
> v3 -> v4:
>  - Minor formatting tweak in try_to_map_unused_to_zeropage() function
>    signature (per David and Dev)
>  - Collect Reviewed-by from Dev - thanks!
>  - https://lore.kernel.org/linux-mm/20250930060557.85133-1-lance.yang@l=
inux.dev/
>
> v2 -> v3:
>  - ptep_get() gets called only once per iteration (per Dev)
>  - https://lore.kernel.org/linux-mm/20250930043351.34927-1-lance.yang@l=
inux.dev/
>
> v1 -> v2:
>  - Avoid calling ptep_get() multiple times (per Dev)
>  - Double-check the uffd-wp bit (per David)
>  - Collect Acked-by from David - thanks!
>  - https://lore.kernel.org/linux-mm/20250928044855.76359-1-lance.yang@l=
inux.dev/
>
>  mm/migrate.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>

Acked-by: Zi Yan <ziy@nvidia.com>


Best Regards,
Yan, Zi


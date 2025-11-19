Return-Path: <stable+bounces-195170-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6096C6ECD5
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 14:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0069934287A
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 13:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678EB35F8AE;
	Wed, 19 Nov 2025 13:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iEs+Tjhj"
X-Original-To: stable@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012042.outbound.protection.outlook.com [40.107.209.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D08C3590A1
	for <stable@vger.kernel.org>; Wed, 19 Nov 2025 13:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763557690; cv=fail; b=FC9I6Za96BoB9FmgXHWQ482xhwnqG1gJkTGnPqi1BoKcguYt8BmgbBTYFCEnhGOd3vEtS6N4OnDCmPudYb6sCOW7U2Xr/nQq/cfATNrI3wmx8bIwvGO+nIoGnjnHSbEzf968Fs992pKioUlZgggCLF4i787VMIX+1JwJSj+8TBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763557690; c=relaxed/simple;
	bh=sjK7zmmhO14X9gpSlwHug0TWdp00hhh853t14iB4lDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h9vNPdv/1WLNu0hQw7/AM7mFk8yiMFsrZiPuib7mtlgRLxdFByV2SPtzdGcgxLCOMD3OyrMZmpdTAsMglOHtFgdG0stAskwZik4JWIbPa3fK6IEedmmmTwsmnT16p1xggRIZvgrwzhZkfx8ZGXFxk0Tv3G5Ry/4tbthPOkDG5A0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iEs+Tjhj; arc=fail smtp.client-ip=40.107.209.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MD8iH9RBmsn4lpCSmYLgClxcgWe3BYsyvc8xXLPcj9A9iEBcLjI0j9cyXPy4ygc0q2voLTHd2MD2nTP2E0XEktCrqzSbcWJreVuQWxsxuA2eZ/N3X0iq1BUW8VDmWNX2GM7fjdzKDRZ+TWRC5rdcznRV+fedI3ZRhGuV+eNPcL8senBXfwb83ED3FvFDTNqyDM0fZFQR5VqExn1/e1PaX2TZDhPfDOfvsmGHfou5bJBYS2Yxo6TGUoJohFTkSUQfVhYx6mEkBzpYiIVHP+K6v+XRduZH/RpPW5qvR6E51HJZ+WsydfsB+VWkVFIFvgeuJAWwjDwdTZc2iBblJST5nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVtduOTpfBMgrw9BfZYiJmENO/0pKPCK2rvX7nTT8PA=;
 b=LFeMn3OB47rwXK7Ib3obnAwiBvNBxBsyVc/m7avrZ5RHvtonorvIp3XYxOrbSNlZXLJL5nulrFkQmOpntnmMIVWITNjVaCMIbQJj2mMLrY0lHbhW6xicOWH/mWn5gfFbg7hBPX1pLJgHUkVLzUWgyUUkHSogfpvlvfweGRzFLw83DUaK7vM4RSK0pXAvVkDjKL0jSNh6wbXUtrw5i7i11a/bHZtLqonN3YpEua3KGSWqX+Z9Fl0Yo5I9H3pOXIh1UzKFeh5nSOfrcYzAVwOItfAiDKLWWjAIZq3vWZgNWCoEolAEkXyiSIrRZr60fKUEd+432T5Xn7XoWvjT9WcPww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVtduOTpfBMgrw9BfZYiJmENO/0pKPCK2rvX7nTT8PA=;
 b=iEs+TjhjAbB92+omDRL4c4jHn2ex5Mmpx8RiwjxoTDIFBgg0bJZjUEx38H76Bxt0qu0zL6jDHvVDE6YGVvWEFXaUQ7O3lSVccx8zDQSifEA8QgZrVgfHBOawGEBcbyxLnCuIjYHm/TSg+jNn59medlXJwGZ5+8DkreO0vc2M+68xJuxIrj2Jf8PuOeDderELEkEtNzQpRhge6S//QW7N6ftnoNXnAc0kHxRhGzDlssYXV1kxFhEL64VdcSdIxGDZlekYhldCkolH/dY4jitXE+eUkVKzfUEPR5jJVsOFn7lhPjr82s56UWZC1ORqhCjPUBmSDeBgQooRFOiSLboOTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA0PR12MB8302.namprd12.prod.outlook.com (2603:10b6:208:40f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 13:08:03 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 13:08:03 +0000
From: Zi Yan <ziy@nvidia.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev,
 linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: fix NULL pointer deference when splitting
 shmem folio in swap cache
Date: Wed, 19 Nov 2025 08:08:01 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <950DEF53-2447-46FA-83D4-5D119C660521@nvidia.com>
In-Reply-To: <59b1d49f-42f5-4e7e-ae23-7d96cff5b035@kernel.org>
References: <20251119012630.14701-1-richard.weiyang@gmail.com>
 <a5437eb1-0d5f-48eb-ba20-70ef9d02396b@kernel.org>
 <20251119122325.cxolq3kalokhlvop@master>
 <59b1d49f-42f5-4e7e-ae23-7d96cff5b035@kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:208:d4::40) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA0PR12MB8302:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fbc2c52-4fdd-4077-4f98-08de276cac29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p/+O4Vdx2bBctd7pdQb81onzbkD+LC2N/OLbA+i8GXgG54X3bDQ+XCB11QOa?=
 =?us-ascii?Q?nbtB3HCTa6KohQqAmTeohWKu7aZNEZgk8RW7o2slTgzfmJykda5/m6iekBEn?=
 =?us-ascii?Q?4fB8zWSArDZBmr8GBTY6grBoAfMNTYoUHAN9CQbX05phYPNwBrnPO9mD15l+?=
 =?us-ascii?Q?my+N6mlFBzDG1COlMxl1vUsI308D/Lh3+xLy4lwpa051SSrbzwufkHHSa96O?=
 =?us-ascii?Q?uSaJUdkoiZSiLRKJjN7LSrDW3wSyRh1u0o59ll+DgFUXFSB7q+DdOHu+7Ps2?=
 =?us-ascii?Q?fCEj2u+HZx/QDjBB3L8F5KvlifqNUfi7rPBHEwDNdIQ+T+OEDOHQpYuXHRW+?=
 =?us-ascii?Q?TFGwPbIgSMaR421wuCHiZVNhgyadAw5n7Cl/Tv5v5NpOYzYAhJVb3RieiJxw?=
 =?us-ascii?Q?LioVFsMl70lKMCmBQFYndI87RBG1VIzXR1fejgorm65+GSMaQlVQE+FimsuV?=
 =?us-ascii?Q?r2ZSzG8CEAx6MleFrepyMbvBxSeTzIj8s/xwxb3Ev26wickHUwGgowdJhiMz?=
 =?us-ascii?Q?wgxY3Zl4xL30YkmjUtFtPX8hyM05sbIiUutJR3Z//5ukTRIgMImCUtf2mjgn?=
 =?us-ascii?Q?JhHjuG50Al7L7rV8jp3K4IhAG+GnH6HVqEsfq2dIIXdu6M+8DEhg2ATwGr2b?=
 =?us-ascii?Q?XwTqg5+oqv+ySf4Cqs9lrrgFQNKnUWMkw0zWJfbUr9epRxHKPqDmjH3WHi3h?=
 =?us-ascii?Q?rouebQH4J4/32L1VRYP2a3gJyJCUopJ7n56Ewh1OOQn7ij7Tcd+Oe3cxXIo/?=
 =?us-ascii?Q?8HAHaGPDu7AJmRnCFS22RMv3ZuxyC/5d/KKFGNNUCGPS3HpmFKW0RWUgNBbc?=
 =?us-ascii?Q?k1y5XEUGy3WanA0CFnMz4AnBx0uYc4QCHgwuQp/8lhTVqlNbHrsIzWFiHQ7x?=
 =?us-ascii?Q?3ttzgy+d+ME1j+DQySAYK5hwjufbxAenn+Fqbrbl0KM3AbgoJAvOOaHxTN7O?=
 =?us-ascii?Q?Z0SnZobOzNsvXTWWYvcDrrtMHKCwW6Xet2L8qMFTQenUO9ZSCjsYu3Ko/fL9?=
 =?us-ascii?Q?kyvoAIi/9dd5cUsW+1sARUYyO681c5lT2UoTXftJQZkMUAvMYVqW5W/2NCz8?=
 =?us-ascii?Q?fhtKhhdoMMcMmVVRcKOv9YfqJJ6izD+W/uwuZT/xYzibr0Qpa5h3XWAbKHyX?=
 =?us-ascii?Q?1jesbrhgDVmoiDS8x+nTUX7u0HVmrJbb/WBmVcYPn60ARtda9FydGZqspR2f?=
 =?us-ascii?Q?AHkkPloF3lNp7o/rX9r9z3qDtWhZgoJFBZtvZ+A6yN+LXcPPIEF+wUvSE4Tn?=
 =?us-ascii?Q?yIlG+an58arMsATdiKRb2EM+JXABbLvsxAbShxuVXkkMgRqPQ0a2jBcQHhXN?=
 =?us-ascii?Q?d/u9ajPhLcB5W3jbYfENleQBpeeaDM/3ekFRyRjXCVKEbVeWcgqXa0XDgzq+?=
 =?us-ascii?Q?GM3PypsR9a/9h9VANoQ074YhgA0/zIrTaVXDORSLC+RgNaWTwgqVMwIplWc5?=
 =?us-ascii?Q?4HnjDWeTPPPEs7Z+zBdnCTTlZ8yH8Y2N4bGhhdJ4p0WfLZHwP9LzRw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4jfkVS+1lQ0mFBUmxdypdGgV1A3jBp5FJeOTn2Qta3B2o7eak6NIjd4BmAty?=
 =?us-ascii?Q?WQMO2JJnhMk/BZj+PMlRypis9xqiEJ9cgLNLV/msV9YMG76eZhWTXkWyrYQ2?=
 =?us-ascii?Q?W29m1VUrAoXBVSCjUr8b04xWd8tgiB/dp8tgUH2MnBE02YZ5KQ463/HcH1gx?=
 =?us-ascii?Q?V8n5dofyZ5o2FubMsTCCRSYdQoTKjAnhBbLSL7VGfIToIZqYo580GDLvATEc?=
 =?us-ascii?Q?gBhZJ7dEqWrNCZ8waa3kt9tOhmxf3y7MtlY71myyrWfiUbe1ziYwI4ARWIfa?=
 =?us-ascii?Q?ORbvrbCDsW4XpKdmo8FHgevGzlbSe29a+r54Ulj93SFRChj35WUDfrXzb0gl?=
 =?us-ascii?Q?fxLVD3HURYXUyb6aW1OrQjPV1QfRpoq+yNap7C2FttnmJHJhCpqGfxV+CqbP?=
 =?us-ascii?Q?/GPks+AxA0IslSrHQWLodKtCHZLLcVDtWK+4rdQe7tBtArVeYwHde+Y+Arls?=
 =?us-ascii?Q?QClqUhVXeXfKGL2pokEuBH6A1Gc3B2/sXMDx93PR3bcGduQF0byO/IDqlSEW?=
 =?us-ascii?Q?g3xgnPT+P8jJUgma7WwuqGRI2DR72zLXYlhHWXX+4Knrh92ycpkgPLeJ6+HO?=
 =?us-ascii?Q?BcZRvl0+G2GMPpkCKvO9T0gI1YnqQ8EnUTmQ+izXCZTjqKJA7JiTjcszaLik?=
 =?us-ascii?Q?xpQE6ym9ygmwBzH5KjmL76AWVwiaRbReJfOnuUHsERKNIhmnSivDkKL4HMEH?=
 =?us-ascii?Q?pTTRdaShvpoml3mVV6Ud5bJjtMUfl87o4pqU649Ea9umirBrIU1PSmhDFN3w?=
 =?us-ascii?Q?bVQU7hyzlyXa5Xw4Lk+S7aokcNM4HXDDkq7EOw9qaMNcinRy3oGc6TMMHPBb?=
 =?us-ascii?Q?Cr8k+HaPuW/n/3PvfsPvd1+0A947v62froRG1YsSesUwdD+bdbrmAj2SVgES?=
 =?us-ascii?Q?wOrKkLQTA6Qkj59CDRId75sbtsQ4n+R3Z5mLuK00lOeos2MeKhbOdUDDBSvY?=
 =?us-ascii?Q?En/8I3wHUnreTuY9WfrmJLVAdMcBzjDWETy92SxL5tXseynUQ5OkBNXgV3Oz?=
 =?us-ascii?Q?ZR9H7ip3/tEuHPXGlyd4PQ4LXm1uuhLYEtQNSI127saqpDkfCN5TyN1njkSL?=
 =?us-ascii?Q?Da1Eq8jEk6wPPcM45hlrFApZ3MJYXLonJfGWhrU3bLE0a6+068BZl8iLWaPc?=
 =?us-ascii?Q?yJKFaz8RWZTlwltEF39KxzWRlPqjrcjsSJbxwmc+BJLrzUtpD4zDWR2BlkQ4?=
 =?us-ascii?Q?lPVpifGndPHiq8ycpoXay5HaKWE1FW1oaf98/vkWn+ly3pNQgn2rO2/StM0L?=
 =?us-ascii?Q?FXwMOZHONh17ALQcnyw4MWaAtoiG68vrDJzXId1O8eebCkP78GE9bbGBDLHM?=
 =?us-ascii?Q?6J/MOzEMDxvM+IpnRNWSM/aOZ6IOyyxtzKVaE2bjaWEtKxV+jJRuLijSiED3?=
 =?us-ascii?Q?sIF+lglzsSQEzkkzxU80ysek0CT5AOsa4z1b6Jz4yzRzlUWBZ7nr3LXaUgW+?=
 =?us-ascii?Q?VfCRTi8q3wTTaHD1WjXV9OR0j6G3vR/T1MlWXKiHDZiqtlc3tQSY/BmuiqXt?=
 =?us-ascii?Q?BESeJ9/CvdtyYZ32yfA7oZ7jpfikLMZtg+CcVKi5bYYRBpwaNL9De3banZX0?=
 =?us-ascii?Q?89XbZHY1wE6ejRagnyvEGIdRwlJisFthuIgN/Ow8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fbc2c52-4fdd-4077-4f98-08de276cac29
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 13:08:03.2745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BSTxiju8VcJN9sleNiDuLeNDFVK0VMmPhkBwmHlqzaGm8mBoN999w/dyu5vcFyMU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8302

On 19 Nov 2025, at 7:54, David Hildenbrand (Red Hat) wrote:

>>
>>> So I think we should try to keep truncation return -EBUSY. For the sh=
mem
>>> case, I think it's ok to return -EINVAL. I guess we can identify such=
 folios
>>> by checking for folio_test_swapcache().
>>>
>>
>> Hmm... Don't get how to do this nicely.
>>
>> Looks we can't do it in folio_split_supported().
>>
>> Or change folio_split_supported() return error code directly?
>
>
> On upstream, I would do something like the following (untested):
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 2f2a521e5d683..33fc3590867e2 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3524,6 +3524,9 @@ bool non_uniform_split_supported(struct folio *fo=
lio, unsigned int new_order,
>                                 "Cannot split to order-1 folio");
>                 if (new_order =3D=3D 1)
>                         return false;
> +       } else if (folio_test_swapcache(folio)) {
> +               /* TODO: support shmem folios that are in the swapcache=
=2E */
> +               return false;
>         } else if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
>             !mapping_large_folio_support(folio->mapping)) {
>                 /*
> @@ -3556,6 +3559,9 @@ bool uniform_split_supported(struct folio *folio,=
 unsigned int new_order,
>                                 "Cannot split to order-1 folio");
>                 if (new_order =3D=3D 1)
>                         return false;
> +       } else if (folio_test_swapcache(folio)) {
> +               /* TODO: support shmem folios that are in the swapcache=
=2E */
> +               return false;
You are splitting the truncate case into shmem one and page cache one.
This is only for shmem in the swap cache and ...

>         } else  if (new_order) {
>                 if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
>                     !mapping_large_folio_support(folio->mapping)) {
> @@ -3619,6 +3625,15 @@ static int __folio_split(struct folio *folio, un=
signed int new_order,
>         if (folio !=3D page_folio(split_at) || folio !=3D page_folio(lo=
ck_at))
>                 return -EINVAL;
>  +       /*
> +        * Folios that just got truncated cannot get split. Signal to t=
he
> +        * caller that there was a race.
> +        *
> +        * TODO: support shmem folios that are in the swapcache.

this is for page cache one. So this TODO is not needed.

> +        */
> +       if (!is_anon && !folio->mapping && !folio_test_swapcache(folio)=
)
> +               return -EBUSY;
> +
>         if (new_order >=3D folio_order(folio))
>                 return -EINVAL;
>  @@ -3659,17 +3674,7 @@ static int __folio_split(struct folio *folio, u=
nsigned int new_order,
>                 gfp_t gfp;
>                  mapping =3D folio->mapping;
> -
> -               /* Truncated ? */
> -               /*
> -                * TODO: add support for large shmem folio in swap cach=
e.
> -                * When shmem is in swap cache, mapping is NULL and
> -                * folio_test_swapcache() is true.
> -                */
> -               if (!mapping) {
> -                       ret =3D -EBUSY;
> -                       goto out;
> -               }
> +               VM_WARN_ON_ONCE_FOLIO(!mapping, folio);
>                  min_order =3D mapping_min_folio_order(folio->mapping);=

>                 if (new_order < min_order) {
>
>
> So rule out the truncated case earlier, leaving only the swapcache chec=
k to be handled
> later.
>
> Thoughts?

I thought the truncated case includes both page cache and shmem in the sw=
ap cache.

Otherwise, it looks good to me.

>>
>>>
>>> Probably worth mentioning that this was identified by code inspection=
?
>>>
>>
>> Agree.
>>
>>>>
>>>> Fixes: c010d47f107f ("mm: thp: split huge page to any lower order pa=
ges")
>>>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>>>> Cc: Zi Yan <ziy@nvidia.com>
>>>> Cc: <stable@vger.kernel.org>
>>>
>>> Hmm, what would this patch look like when based on current upstream? =
We'd
>>> likely want to get that upstream asap.
>>>
>>
>> This depends whether we want it on top of [1].
>>
>> Current upstream doesn't have it [1] and need to fix it in two places.=

>>
>> Andrew mention prefer a fixup version in [2].
>>
>> [1]: lkml.kernel.org/r/20251106034155.21398-1-richard.weiyang@gmail.co=
m
>> [2]: lkml.kernel.org/r/20251118140658.9078de6aab719b2308996387@linux-f=
oundation.org
>
> As we will want to backport this patch, likely we want to have it apply=
 on current master.
>
> Bur Andrew can comment what he prefers in this case of a stable fix.

That could mess up with mm-new tree[1] based on Andrew's recent feedback.=


[1] https://lore.kernel.org/all/20251118140658.9078de6aab719b2308996387@l=
inux-foundation.org/

--
Best Regards,
Yan, Zi


Return-Path: <stable+bounces-195142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB256C6C63E
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 03:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id F41C4295A3
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 02:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DAC2222CC;
	Wed, 19 Nov 2025 02:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VGpAYysw"
X-Original-To: stable@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011062.outbound.protection.outlook.com [52.101.62.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5E41B0413
	for <stable@vger.kernel.org>; Wed, 19 Nov 2025 02:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763519540; cv=fail; b=kGBStJp8g1m2Ggf+SVWXf2IL7EXEV7T2T7R5MP1BG+IJaw8t3YlW9S4w2ss9jr2C6Os60CfdvCx3Y2TEWwxp+JYPbvXi/4Qlfys3jP8Iwh5KdD7iXjdcwOHtI0qDOK9N48iKtWsc21YQzywRdWQXghqKzh3XVc+qCmJ1Ac2LLrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763519540; c=relaxed/simple;
	bh=iT7C/z6EcDSPR5yFX75aE3wWKxRx5lP8Dn+OTsDadto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VnHwSsNi6Ct1o+vkL7P2kgJ4x3bYHqIxxgDLiAHa8KxCvyBzHJWvd42MavNflhKkSd8PeJ/HoKeBVQ8CS1AFCpRaXQpB0pDdTPbcJbcl9+gBKbTceD11CFBRQXo2Oy6UvawC3qEF1Sc9FTn0g2V12oIKKmNfzCwcUgDptsiCERk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VGpAYysw; arc=fail smtp.client-ip=52.101.62.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Od2qpi/y0oJsY9rQ1naMFoPG7t35V8AEC1JPNB6jqMAgUzuoILu4zJOAVE4z/3eXbB0Z3WOa81HCNGiY5OwSDBY2E31TxwZp7QP+MqlyIWdFN6fbzFTld3MC4Qh38ySBo+tToAFvJZ2nZUfICx1ZzcIq6hqG+yIuJUYTsKyJJ0PjlOLnvuYWqu3p0HWqJUffY2P6mhRukjVZyxvtSP9zRF9YoyYO3j05HmNOntXGi1JJXVQ4o/EK4MulN7iT8JEof8GM/+0hcGWESobsAGV8mmCsQDSnSWZafXY1awvnu68A6A3AQaoR7vgISnz97ZX06iXEv39rAuz6pwxhVcyvVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=al+ODu7ni6lPPea9uD4R/uCjvxjIQg9nubtu8Ii/9qY=;
 b=n/TGA5zctC/r8385BcqNtjU8FO073a3PMcPMHzieaYNOKEruGRGIEdjPb4zkbZCWsDbq3s7iYRtgMkKkkqtvzJhsV2PPwWQOlWcdO7BP9Nd8zzrgVU2Hv6MNlgXgJuAzoh0ZTHl1FS6qGAliP3eEV3ZEMgE8ym7dLGqz3ZFhDMrlkwX5//StNGjQiF0iL97RFhigbfQORMqMA/ZUWyWklV647cJNkhjCHB4V3wPBV8wiZEZbIXihrGKNiBIm/hGEXQcxeBFXEG03docZ2c7noduoenCjpA3nhGFPX+R8pQVkZ7wxUlLHHyLczI1FKyyYCmiaMdWkE9c9ctwd2yXGPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=al+ODu7ni6lPPea9uD4R/uCjvxjIQg9nubtu8Ii/9qY=;
 b=VGpAYyswpK3+1OtNEeDDpnvYYvDqkPdQ0fJd7XTeQrAUnZriQhVaX3gHva3DRPDieDAOhbZO01JnDCjphhLgE3NZNyltVF7DBfvw4TVQd00mhFq8G/ZRmUYpb/avx5sx/HBxnK/1CfNcmlhEiY/30r/ZUk5iPFTLGBFTsrXQXILn2q6qlukTgYgInE0O/8eAneNts21OaC5N5UvwgaeXZZ2BSi4/rHGCNsUO9+nrTq2ptd09i+wT2PQjRV9elEv6A4VKNUr5JGz1F0SHOfY9wwrhJqDtYYC78YU/hIDCO31lqB44uOn3mFp+o0oenGQ6RSwbCjLMcjnisZ1LryJLrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH3PR12MB8187.namprd12.prod.outlook.com (2603:10b6:610:125::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.22; Wed, 19 Nov 2025 02:32:09 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 02:32:09 +0000
From: Zi Yan <ziy@nvidia.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, david@kernel.org, lorenzo.stoakes@oracle.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 lance.yang@linux.dev, linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: fix NULL pointer deference when splitting
 shmem folio in swap cache
Date: Tue, 18 Nov 2025 21:32:05 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <A5303358-5FA3-4412-89B2-FF51DA759E28@nvidia.com>
In-Reply-To: <20251119012630.14701-1-richard.weiyang@gmail.com>
References: <20251119012630.14701-1-richard.weiyang@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL6PEPF00013E0B.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:10) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH3PR12MB8187:EE_
X-MS-Office365-Filtering-Correlation-Id: e0759cbe-8fc9-4d17-a23a-08de2713d615
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8S/37ETC0Mwk/HLx7wcnH82l/WOmH82G9wCB/TUyxjxt5Cf3t6/MwxMTkhPY?=
 =?us-ascii?Q?xI7z3EYsctWg3T79QToog4RyrcC22BIgnfWigYYNVzRc/Dt0XR4r7SYhjPqI?=
 =?us-ascii?Q?W0Q5KwMfQSyHQA7ybCmq6OZX6x4F7PqgV9vO9ZP90kyKinH4V8+vrAYp4ug6?=
 =?us-ascii?Q?EqceATdblLtIw1BRKafxNKxhEIis2fvfHDd55TmMhJDSPg4Aqp9BgBbue7hJ?=
 =?us-ascii?Q?eXFGBT6AkY59TzZeVUOGZ8UBJNg8LhCiGefnEzZypFz36J4gWaJiT5ccJ5Hf?=
 =?us-ascii?Q?pZYp+fVHBlLvZFZXsprsoIE2CcrjFC4qB8uxTxIZrBG+vD8EZ/w3QS3lLMSv?=
 =?us-ascii?Q?kwCyuwrYoKzk0Mexsbyp99tBvzDpfOEc+TNNxPjbrm4XU+B+Fy2mgnpevLix?=
 =?us-ascii?Q?psNkIXIQwsURxS2QLPHZdR/ThCjym41PTb6hTJMduZdEM7RJQBivs9PB+wpZ?=
 =?us-ascii?Q?GKiW3eqTVpHoygjFaGWjzWyXCI77qa5vRQ4wwXp93VP422JHzOYVh2VQyXSg?=
 =?us-ascii?Q?XfxUmkujZekCfywlXguRbQHcX5czRzqFGSjLU5P5YmdN/YnszbGlVYL0NkUG?=
 =?us-ascii?Q?ZkTmWyfMqne+3idTTtI2q31/xw8e1p4N8RhgtLHPuO/WA/YaBm+WR7o+kvTt?=
 =?us-ascii?Q?0E5tV4vIbj9q+ARc/dmgoOCYeqRebdzKIPNRYsZ7NOXAcJ8GH6vr0qPZa11b?=
 =?us-ascii?Q?oVr4GzPDeGues0gZx2clSnJ9hdoqj3rlX/JYylmMseqvLSV+xLaawe94BuMh?=
 =?us-ascii?Q?JN9aLzADk9AZmGeWzhrHKqrnDWDjPakfIO7Rzky2R1N29d1NFKoS/Db1chgn?=
 =?us-ascii?Q?spg0aYzzjmq38pv/7dVm9ThJaiKvDbtiWYnoCRlJFG1k+Hmv/9ec8F13FMfj?=
 =?us-ascii?Q?Er/h9So/NvlX8nuz+lhatXw0Tc6TJlcb3cBxH5bdtYGkSK9+1tzr6xud3e0t?=
 =?us-ascii?Q?ocszt9lxxMJq3M7cvKR7WQQm53vxgWqZpXxEZhZRoinY8eVSFJNlCbOqRP2W?=
 =?us-ascii?Q?ra9jgluo7w1rJL+KMLegmiZwWG4xhZZzpKS4wV8VivzTyUVLms185GJ/AqqS?=
 =?us-ascii?Q?Y4sOCBz+aW/B0E1WSXJJobpjMGnZJbkAmO+6ZOAU7AxVdvLOqEGfID4c4WyP?=
 =?us-ascii?Q?qy4Q1W2yv84witP90NipBbDEnVc71esKk1vNyZryh77D8VY8Yq1ZxtoDLsr5?=
 =?us-ascii?Q?4311yC67XhVirQHcnFO8yMY+67aRBWoNc72eDnEUPY2yTOSGotcWLeg6ARz8?=
 =?us-ascii?Q?YZzfAMmFsbccM3FtpjnRW8NYzZ1/E2NeVGw7OnRK0nt/X3rS/4Q+y8/HFWOL?=
 =?us-ascii?Q?pDA8FfoTBkq5k3sKaYH7/H/1PNyGXWp3r+c1/I34oIRpGoUJZPU86uca2X9l?=
 =?us-ascii?Q?kPmDqQl0TfDSQktmypZWO2qbK1ZsVjKTF3U2LIDt7zwP3HWtNVarbGP7+NP4?=
 =?us-ascii?Q?exXfMlPBct86xZFBQ7s+5rzxHY/Q8rBx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TXSLQsM9V9sf57NLqNUEpzeQNRScJolzS29HsRX2V9vsk6OP7x1kcE/B7EfM?=
 =?us-ascii?Q?GxprlFH3sRMzBg99/zmUEKAdO2oCbHqxujldO13O2VS73UmumdRZg6/ZFmyk?=
 =?us-ascii?Q?SmSdLTXC3Yp6X+vedoWDe0Zux43NufZR1/h2YGBKg8tEPr7MpFFjUs6f6AUM?=
 =?us-ascii?Q?T40AP7jBJByHMTiBjo54q3dWMdPlyxq63FouJCI0oZj4BqyTbKQjTYGGHnSZ?=
 =?us-ascii?Q?O9zDsc/PsXQkA8lYqhXwCJoM4/nfs22A22/U3l4qL79Un7g89Wfi+FA0ZTgF?=
 =?us-ascii?Q?nWcNP+cpMSeg+Kkv1UerDM4KzqcMv+cVDIz+mcyDOOWAWeCDcdCtCqeHz4F1?=
 =?us-ascii?Q?ZsKvZ7e8LtgxHdGNykbd9qKhRkJC7BTz1uAv6vyBwxQfQkOEng/PYGFffLfe?=
 =?us-ascii?Q?t1+/C0ZdNndCT/4/9AZ9+f8PGvX/YaUZlCSbLR/cZmY3WOXBXyLcBzZKDrYO?=
 =?us-ascii?Q?GOr5rdVi7vZlpqm5UbbtZ7+uRPuRPUuKyIgHSyFs5UfI3t28tlm126CV+Wn2?=
 =?us-ascii?Q?a+Rsqkkh+5k484k1DSl81zTrZIoRWrxXI7JQyrzB9yqB2twLVZYTlMmFJ3R9?=
 =?us-ascii?Q?Tb+nEEdrHTeR92PbhW97J5+bTyLcsB1ZV+ODtXlhCg6rez+uKtyr38uLVNst?=
 =?us-ascii?Q?q4LN4aCx9lVttxslIfmQ2pMx89yOQ1buq5BO1hFLYDjYHGhZ79TRdXItHpR0?=
 =?us-ascii?Q?2dE6+T2FtfpitRRTucUsodleIPvbFFStJ0T1LPmoVj/jSYVLHF9UZzXsxSLG?=
 =?us-ascii?Q?ODAfnfa7tvmaJGjOcCCgClqxl/fQwDSNOhaRQuK3W3XZQUIHUkRv8WKHwHJi?=
 =?us-ascii?Q?GyTrR7m51LBzuMKz0unIYkyKujUBUZuw/IVxT/4XgfPl8Lp9lglBx7AU3B5L?=
 =?us-ascii?Q?R1OmsUduYQGob6BW4Jh5/o0AHaQybLNJ9U7ty8e+LiWCrZeq4ZLbXOoXiwyu?=
 =?us-ascii?Q?vt6Xstnftc++bF9o3ogvxyoFy4WKkjm6juhE/ERjDi1y1GAriFRPY/jYHkLK?=
 =?us-ascii?Q?CpXjPw2dgZQqZB8dTkdBnh/GGDHPC6EHugnGy8AfJpBgm4pvx0WnYC2ps+7C?=
 =?us-ascii?Q?hPWjy0Ujo/GyAnudyufEv/uVYuy4GlM4+9qmn4O0rsVjdywTUiIGGNuCixRK?=
 =?us-ascii?Q?cmsBPHW6TbRSeXamBZVuWyY/5YuYMUEPDkXczOBrpX/7BMzJhXKQkabDcgsZ?=
 =?us-ascii?Q?nbu+bLnhdhbNRcX6hwwPyDnncfron2oxz0p5++izrXbanSST95LOtdxGfgxa?=
 =?us-ascii?Q?nPC8/Lmi/7myj3PlSyzsTVYYRk9O4QX7vzsTG6g8Wk2CyL8fkOlMcITSydC0?=
 =?us-ascii?Q?aovLpo1ob5w0KD3pZ1x803TrQeW1pVPnIj2IC8yZSn/WTGf99L9DAd+YAmf/?=
 =?us-ascii?Q?oJw8i8z8EhxugMVPS2HeiR7+KZjhvMhmm2hVbff5LKd7f+vacOYWkSuymTBC?=
 =?us-ascii?Q?hVrXCj7/KN662D1nzj0MQvC2up1baJTzFH+HmesOhq/Dt4l4/Xx9Szsqqis2?=
 =?us-ascii?Q?lILdfo6b0AfnVGDGkgnagqE2Ck0pAGf6ce7TMqOdX4EZEhjk/FbujAEEJlYn?=
 =?us-ascii?Q?TlFQYyUR3ITVlIbZiWgbPserLGkFU6GOsN7dmpwN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0759cbe-8fc9-4d17-a23a-08de2713d615
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 02:32:09.2087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yrNRkSCXS9uAIUjmm6vMjc9RuYk+glJq0Zy9EyvbQghu5bKu228iRKjlbdW5qEXQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8187

On 18 Nov 2025, at 20:26, Wei Yang wrote:

> Commit c010d47f107f ("mm: thp: split huge page to any lower order
> pages") introduced an early check on the folio's order via
> mapping->flags before proceeding with the split work.
>
> This check introduced a bug: for shmem folios in the swap cache, the
> mapping pointer can be NULL. Accessing mapping->flags in this state
> leads directly to a NULL pointer dereference.
>
> This commit fixes the issue by moving the check for mapping !=3D NULL
> before any attempt to access mapping->flags.
>
> This fix necessarily changes the return value from -EBUSY to -EINVAL
> when mapping is NULL. After reviewing current callers, they do not
> differentiate between these two error codes, making this change safe.
>
> Fixes: c010d47f107f ("mm: thp: split huge page to any lower order pages=
")
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: <stable@vger.kernel.org>
>
> ---
>
> This patch is based on current mm-new, latest commit:
>
>     056b93566a35 mm/vmalloc: warn only once when vmalloc detect invalid=
 gfp flags
>
> Backport note:
>
> Current code evolved from original commit with following four changes.
> We should do proper adjustment respectively on backporting.
>
> commit c010d47f107f609b9f4d6a103b6dfc53889049e9
> Author: Zi Yan <ziy@nvidia.com>
> Date:   Mon Feb 26 15:55:33 2024 -0500
>
>     mm: thp: split huge page to any lower order pages
>
> commit 6a50c9b512f7734bc356f4bd47885a6f7c98491a
> Author: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> Date:   Fri Jun 7 17:40:48 2024 +0800
>
>     mm: huge_memory: fix misused mapping_large_folio_support() for anon=
 folios

This is a hot fix to commit c010d47f107f, so the backport should end
at this point.

>
> commit 9b2f764933eb5e3ac9ebba26e3341529219c4401
> Author: Zi Yan <ziy@nvidia.com>
> Date:   Wed Jan 22 11:19:27 2025 -0500
>
>     mm/huge_memory: allow split shmem large folio to any lower order
>
> commit 58729c04cf1092b87aeef0bf0998c9e2e4771133
> Author: Zi Yan <ziy@nvidia.com>
> Date:   Fri Mar 7 12:39:57 2025 -0500
>
>     mm/huge_memory: add buddy allocator like (non-uniform) folio_split(=
)
> ---
>  mm/huge_memory.c | 68 +++++++++++++++++++++++++-----------------------=

>  1 file changed, 35 insertions(+), 33 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 7c69572b6c3f..8701c3eef05f 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3696,29 +3696,42 @@ bool folio_split_supported(struct folio *folio,=
 unsigned int new_order,
>  				"Cannot split to order-1 folio");
>  		if (new_order =3D=3D 1)
>  			return false;
> -	} else if (split_type =3D=3D SPLIT_TYPE_NON_UNIFORM || new_order) {
> -		if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
> -		    !mapping_large_folio_support(folio->mapping)) {
> -			/*
> -			 * We can always split a folio down to a single page
> -			 * (new_order =3D=3D 0) uniformly.
> -			 *
> -			 * For any other scenario
> -			 *   a) uniform split targeting a large folio
> -			 *      (new_order > 0)
> -			 *   b) any non-uniform split
> -			 * we must confirm that the file system supports large
> -			 * folios.
> -			 *
> -			 * Note that we might still have THPs in such
> -			 * mappings, which is created from khugepaged when
> -			 * CONFIG_READ_ONLY_THP_FOR_FS is enabled. But in that
> -			 * case, the mapping does not actually support large
> -			 * folios properly.
> -			 */
> -			VM_WARN_ONCE(warns,
> -				"Cannot split file folio to non-0 order");
> +	} else {
> +		const struct address_space *mapping =3D folio->mapping;
> +
> +		/* Truncated ? */
> +		/*
> +		 * TODO: add support for large shmem folio in swap cache.
> +		 * When shmem is in swap cache, mapping is NULL and
> +		 * folio_test_swapcache() is true.
> +		 */
> +		if (!mapping)
>  			return false;
> +
> +		if (split_type =3D=3D SPLIT_TYPE_NON_UNIFORM || new_order) {
> +			if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
> +			    !mapping_large_folio_support(folio->mapping)) {

folio->mapping can just be mapping here. The above involved commits would=

mostly need separate backport patches, so keeping folio->mapping
as the original code does not make backporting easier.

> +				/*
> +				 * We can always split a folio down to a
> +				 * single page (new_order =3D=3D 0) uniformly.
> +				 *
> +				 * For any other scenario
> +				 *   a) uniform split targeting a large folio
> +				 *      (new_order > 0)
> +				 *   b) any non-uniform split
> +				 * we must confirm that the file system
> +				 * supports large folios.
> +				 *
> +				 * Note that we might still have THPs in such
> +				 * mappings, which is created from khugepaged
> +				 * when CONFIG_READ_ONLY_THP_FOR_FS is
> +				 * enabled. But in that case, the mapping does
> +				 * not actually support large folios properly.
> +				 */
> +				VM_WARN_ONCE(warns,
> +					"Cannot split file folio to non-0 order");
> +				return false;
> +			}
>  		}
>  	}
>
> @@ -3965,17 +3978,6 @@ static int __folio_split(struct folio *folio, un=
signed int new_order,
>
>  		mapping =3D folio->mapping;
>
> -		/* Truncated ? */
> -		/*
> -		 * TODO: add support for large shmem folio in swap cache.
> -		 * When shmem is in swap cache, mapping is NULL and
> -		 * folio_test_swapcache() is true.
> -		 */
> -		if (!mapping) {
> -			ret =3D -EBUSY;
> -			goto out;
> -		}
> -
>  		min_order =3D mapping_min_folio_order(folio->mapping);
>  		if (new_order < min_order) {
>  			ret =3D -EINVAL;
> -- =

> 2.34.1

Otherwise, LGTM. Thank you for fixing the issue.

Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi


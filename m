Return-Path: <stable+bounces-65949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FBE94AFF9
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 20:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25888B20DEE
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 18:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68566F067;
	Wed,  7 Aug 2024 18:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mUlfFaDI"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B341D13F426;
	Wed,  7 Aug 2024 18:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723056467; cv=fail; b=gNFwsKwtuYEycN8ILCkDXW66dBIlt28D7W+PPTmkwwTvVVJyZIhV95RSSmpNZPFdDjL0UtIfi3saUUVOZWjqAYDV+F2aic/4pe9bcDz3s9KsoqMIaPceBYwTrzVQ93TnyyAD5LRlvLyLpQHhqYxAV4Q7D4DDq4oMJ6H/xWLve+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723056467; c=relaxed/simple;
	bh=eDwZvb9LUeGfCBaMvOLCvdsIk5cS5//skrYQVxLJQU4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=s8VNQvP1KRj324Am9ndFpRoIBu5h/fpXFPcZd3RLEscOS9Fo/ia6md+Vo4aQPEgteWDeduwAMqPQiWd9V4PG5L2WDvNk++zJ+TbSC9MvzZZJXAhTc2Pv3OfSy4aL2ufhgh5CFemS8uylwC7R4cF2b/RudTNJSuFdQsFfBndcWiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mUlfFaDI; arc=fail smtp.client-ip=40.107.244.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FppmKo6FNPXJu9WfVKkdXAG+iuoo+ctmB5dYlfG++b2Jhuq/heGYDBguJZmrCSaeIs77IkYnkIJNh85VVPcLR6WdkUWaPdB4Gc5amDbkVhz91DYh0o83YYpqM6mQ8LwxO092aJDv3jHIDy6OcYYkE0LsVHG1noB9xBnfxvZlE/n9E3iuBR4W3pjHkmCS6V5zUSQOm2HN44N2ih+jilBA442lID7cW6cPXbIBztgicdwNyd0IZ9QUoanoNz9oQHnvzUlkgolXNiRZZcJM1kV/hGxM9aFiASKE89qbd5raAAUxj15RAmZl97u2RkPVLiT/ZeL05XqRHoYZ8AyLlY7Yhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QgSRUJpFPCThw1qBMK75xzgd6AwVOF73GtHFFcbZjig=;
 b=V8cukK+Hh3dOHDTXHrkPhkbQssolINkN+oZWLGPu1s0frzHiEQ8VC82K4L0d627IBjySQAQd1GOdVufgltAUajX1lv8brog79+RLYg/hm5ZaVLlVO1hvTXdEf3XflDhkVO02tsOPSR2cRLJ0eoeHyTpfH/spLMDBRM2Un65wTjd55UDwoVDkz815fEEIEKrynxjls98l14EhFWoTCJH4XNdJ81wTSvOY8NHoJvvHO/DFNX5hJKXBpyXq3G7CHi++KAYovb1RNVi3X35UH3euXLUgjv7v40DGv4VQibnyXGsZUYoj+JU9RslqqSE+pe8tecTFIB2gu2/Yzxnw/IRrKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgSRUJpFPCThw1qBMK75xzgd6AwVOF73GtHFFcbZjig=;
 b=mUlfFaDId7Vsm1JZphFqgX1Mt9ZNJJMPLtFI2hkc9XlumAeDtGAct4Z3Crfc1/OP2qPkyHz/ojg/Wb9RgWFI+I/0Mjv+VpNmJJBnQIt9ymh1nmTWLQc+nYLkqPPsPSrT/S4vMP2Ec62e2LM/5o+ZNlVdJ3e0z4Gy0Rpn/+AKbbViSFTTL1Pr1pvAaTIQgoWaa+IaNFbB4UQIunNdIVrc4SEyxdFPBaIuDQjEJiXOPVRKy1BDf419Px4Q6MMQRS9aiHmlkHj9uM6MKZz8uKspMfgj4qcspQbQG4rntkfRPu8S4ABK3SNfdXeZoN8L7O3Dg05kmmQpkNIQL5W5RNDgJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9)
 by PH7PR12MB7209.namprd12.prod.outlook.com (2603:10b6:510:204::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.23; Wed, 7 Aug
 2024 18:47:42 +0000
Received: from CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f]) by CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f%3]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 18:47:42 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] mm/numa: no task_numa_fault() call if page table is changed
Date: Wed,  7 Aug 2024 14:47:29 -0400
Message-ID: <20240807184730.1266736-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN6PR17CA0050.namprd17.prod.outlook.com
 (2603:10b6:405:75::39) To CYXPR12MB9320.namprd12.prod.outlook.com
 (2603:10b6:930:e6::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9320:EE_|PH7PR12MB7209:EE_
X-MS-Office365-Filtering-Correlation-Id: 09826eae-a083-440c-c684-08dcb7116b13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z3uAOY7YNl9MhU+YBpXgwnu6z4LLLj76uXUtkp5EFi/HTZlVoa0tg04XQgOH?=
 =?us-ascii?Q?BpZukFlUh5wdByzm8LSlDyso+mJBSeakg7GbHBKqvNXBFWlYKTL72CGA6Gev?=
 =?us-ascii?Q?0l9MG7fe6NxDFF/+JyKVcMZIVSVEjb6t16sc+xZeEFwXpEdHYArXWy3zZQXv?=
 =?us-ascii?Q?qaliU1xUXNOsYYPm/wbXLehmE31rk9ARO9+PcNxJsSINj73bo1cjjZlgNBs0?=
 =?us-ascii?Q?z8eGV54W8+bDkJ2+hHBttasJla//g/Y1Xo2W3p5ATQqZ3idG3n7+EitfUr4N?=
 =?us-ascii?Q?Iyn2PlFyMfgCUiGIxoprHWHuLswOWyJhMr1vTpaKluZf1ZOprvTITZ59rAro?=
 =?us-ascii?Q?kgL00r1KGfg05NnQ0oehrBNwWooh9hNUZJXt9dKmz2zz3HT0AHXAsW+x0cK7?=
 =?us-ascii?Q?vMHDR4+JXTkhxGmMTDLIPE6R+dPREwG0cg/U9mwnb/LVRPLDvPMeNs9WhIcK?=
 =?us-ascii?Q?K1cF0t4Vojk+6T9Wt39Cst1lF9SlOKvJLfkdDufmXhKLB+a4zgE3XDlRgqcY?=
 =?us-ascii?Q?6lzhSkj6nDa4uIj37v4GEEOAV/SWKrUNKeyQA1Y4UGYAJI36pW2yAeTRlzEv?=
 =?us-ascii?Q?UoZhN0szlOa5uRDeU4m3M550o2TswfNLr7hJIKMAMHIL6oXO8RfSpPMB4+gn?=
 =?us-ascii?Q?B4HNz3MPdQoEannoxfnc7VklNxieTSHl59yp0E3CqT+SqHOS9cn+vgpvv8zm?=
 =?us-ascii?Q?yZnMTvKxtv3yiWPamDWJhe3WfQv8v2huFUAkriBTVSbFakpPGftTXHWdMqP2?=
 =?us-ascii?Q?grUpEL+lB74bIWStyqoiM3w1IVGnRhY0qA1NBospcG5P6LEXbTro41E4hJ37?=
 =?us-ascii?Q?CQavmkj5gralHs/I/CMMMyWSBR+c9bKn31q8fcAC3lH5Z/Uq1Ahl4PhcHFiV?=
 =?us-ascii?Q?4tsO/Uaeqrtv9AxZ7dC6O9upE6+Jzxmb99rEl0+Fo9LhBx92pOkmvqhf7WNz?=
 =?us-ascii?Q?GjQ5PlPWetj0Bw8ogOfjVYgbwXBwQ0XqSGsUXaSFjjOSY7OqZzBYhc2bBzdI?=
 =?us-ascii?Q?yEjjNU9W2ycqggtBhAIWIl9Fk3I0oOJfkSBNHzieTkoGtqVIO7ssnaJYiSiB?=
 =?us-ascii?Q?trnZHSu7qgzi0tkxdEnyveJGrw8d9XeCZEOYses1OFf4avaVp7zWychbhbL0?=
 =?us-ascii?Q?tLS96sglQEX8XzBUPq7kMscREJRNFnkQ1/kYXfdZmYRmZf6rKuDxdvKqCWoM?=
 =?us-ascii?Q?IsorFMUhHIrpmN36OLiVyJpJZVCGhq/aowD5zjSUyfIFvrnDOZg4IeCK89BB?=
 =?us-ascii?Q?PNc9EcW+Mq3oh6vSJVE7rCglVt8XPs92K60KhgTg99BTeFuZBnxgcxNK5Cno?=
 =?us-ascii?Q?23lg3G/vGRYnWEEILDp1sK4WpiHCxPyR2S50wJ53YyJZZVY+uAQIvvNtGBxH?=
 =?us-ascii?Q?Wg7N01o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?83R386iDKFJz8zkYpraWX7FgDcuFatkjQWGYQHicBrgMOi35diBXEEJ6hyWm?=
 =?us-ascii?Q?/4QAKQQJGEMc65HVWFYeeTEjopeFbJiasxh/2SAOIatEwYPEhmzdka3QT5rj?=
 =?us-ascii?Q?6gwGjPdNQfM1hJL618Hd1JEuKboTGtl01NSVCdU5kQaho6QJDRypbdAlq+z7?=
 =?us-ascii?Q?LzjCIBbm1RgsP815u6e7+KKjnkZWMu7Nbh1xS36MWpgrVkLh6OpfrfTSMIeN?=
 =?us-ascii?Q?e2f2ee5zUHUoxD9dOfSxQdlTq9jnGNJsK0HNdyI+S3eQfEFkA5z1UnlfsHk4?=
 =?us-ascii?Q?Pif8HYYQCcroLo7ChGy59taxs8NiKbBNoaDeSywayk3t+y2UQ6WSnc2umTID?=
 =?us-ascii?Q?dU2FIl/hS/bAo5Fdfx7whgvK1SwLxa0uv2bZCiMYNWCNSR8gjOxGe+ltgPi6?=
 =?us-ascii?Q?n+Zf+SywkITE+zvQuG8gi79I4axl9cGLGVrYZmVxJPPZZChUOdTGVAPcQv9q?=
 =?us-ascii?Q?AkLhKIleYjiOmsl/nNYUetO95AAJjchm1MYmJ1UYPCx6VEcXTqG5Xucw3eIs?=
 =?us-ascii?Q?ziy8z2Ekzw6IZBqUYtj59iIBT8u56BvX1QfQgwtSC0wE2u0CdyJFbude1cYY?=
 =?us-ascii?Q?fC0B+lad491YWYSo98tJOQxZOAvBgnIOWVH4sY+EmL9Niyme1yqfbKrP9AM6?=
 =?us-ascii?Q?Lnik3HVJyVTpHpaptRUhV56fvEF++ZI3Hq4mfqxdZLICq9u50+vFDD21HvRA?=
 =?us-ascii?Q?yZ7EzeJ7gbcDexsPYeLNHvC1gYc4PPCcuYRYFGUEgq0V6L9fJIRffNg+VkMB?=
 =?us-ascii?Q?zuPZoMX/slVyV7kAimU5hA3J2zWnqRnFdIL1RMkT9So2bVt3S+qpKtQ7SBk3?=
 =?us-ascii?Q?fQar4W7lI1TASaiUxSg1nzM0pR66iHJEqDG4kAZxUMQZRf7jmaa2vpoBCtcT?=
 =?us-ascii?Q?xlT0UiX2vDYtIkgK/v5izieWTF7PD0Q0pT6ws4wLlWyLUTCM7FdI7OdJnhkw?=
 =?us-ascii?Q?4wYf+tLiXkMqcNYNPwyuVtp5vKrW0X0TZB+tsMXC31WkQOxj2taV/NYxejhY?=
 =?us-ascii?Q?iTEVEUFnbZMOBw/u8rKDJ8S/9JGregGv7IJJIxc/gB/BiLpvCqvy/ZX2T30c?=
 =?us-ascii?Q?jH33ueVGMX/tFImD6uYgWxgkqc5q2Q464TRQPhJ2H7iziEaIgxacD7h+YhXX?=
 =?us-ascii?Q?wcK0ZsUSc52V47fYv3Ik3vqpYupsfelsu605WFEL4obuIUcHoEYTEm7Xw6N0?=
 =?us-ascii?Q?kCJuApH5aWy8OlKOR2JbUEO/wVi6PFnA/Z81oOHQ2XBbqGF/V8W+nQfirF8b?=
 =?us-ascii?Q?Leht+1ea0ZofaAbHU7KjVTsRQKfVVjNNuWwVDpBAtM6f+yCopNBvREQ+m3dg?=
 =?us-ascii?Q?YPnEd9a/5jwizcCaWQfq737QQTjfxnpQuOVcvpDunMGaMEChgLRuSdsWZo/K?=
 =?us-ascii?Q?xVCqNlNQM6mBqx5YXE/xk2FPBL2G3HZH24TUKzjZBgiAKJL08caItpEzaoJ+?=
 =?us-ascii?Q?xbOKASqZ9xRJlKhSpk9UPeRJTRfxCgVj0tcGEzjlgWCo95ELfA8mz0tlLAPv?=
 =?us-ascii?Q?o+MVUAbgEprYQbtxRtCZjOYfD54DdPS0OWyWFRaKmuqrRAbwWbYLyT0/iM69?=
 =?us-ascii?Q?sv5xn8xgBfi2RI36LH0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09826eae-a083-440c-c684-08dcb7116b13
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 18:47:41.9872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ZGNerOvgz/kOwhPH8dAZIVDHTBqmBrtvoxib95vj7ivmE/vg+u0oTROoZVaqgBJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7209

When handling a numa page fault, task_numa_fault() should be called by a
process that restores the page table of the faulted folio to avoid
duplicated stats counting. Commit b99a342d4f11 ("NUMA balancing: reduce
TLB flush via delaying mapping on hint page fault") restructured
do_numa_page() and do_huge_pmd_numa_page() and did not avoid
task_numa_fault() call in the second page table check after a numa
migration failure. Fix it by making all !pte_same()/!pmd_same() return
immediately.

This issue can cause task_numa_fault() being called more than necessary
and lead to unexpected numa balancing results (It is hard to tell whether
the issue will cause positive or negative performance impact due to
duplicated numa fault counting).

Reported-by: "Huang, Ying" <ying.huang@intel.com>
Closes: https://lore.kernel.org/linux-mm/87zfqfw0yw.fsf@yhuang6-desk2.ccr.corp.intel.com/
Fixes: b99a342d4f11 ("NUMA balancing: reduce TLB flush via delaying mapping on hint page fault")
Cc: <stable@vger.kernel.org>
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 5 +++--
 mm/memory.c      | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0024266dea0a..a3c018f2b554 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1734,10 +1734,11 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 		goto out_map;
 	}
 
-out:
+count_fault:
 	if (nid != NUMA_NO_NODE)
 		task_numa_fault(last_cpupid, nid, HPAGE_PMD_NR, flags);
 
+out:
 	return 0;
 
 out_map:
@@ -1749,7 +1750,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	set_pmd_at(vma->vm_mm, haddr, vmf->pmd, pmd);
 	update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
 	spin_unlock(vmf->ptl);
-	goto out;
+	goto count_fault;
 }
 
 /*
diff --git a/mm/memory.c b/mm/memory.c
index 67496dc5064f..503d493263df 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5536,9 +5536,10 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 		goto out_map;
 	}
 
-out:
+count_fault:
 	if (nid != NUMA_NO_NODE)
 		task_numa_fault(last_cpupid, nid, nr_pages, flags);
+out:
 	return 0;
 out_map:
 	/*
@@ -5552,7 +5553,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 		numa_rebuild_single_mapping(vmf, vma, vmf->address, vmf->pte,
 					    writable);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
-	goto out;
+	goto count_fault;
 }
 
 static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
-- 
2.43.0



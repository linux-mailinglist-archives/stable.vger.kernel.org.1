Return-Path: <stable+bounces-69807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3316B959FF6
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 16:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA3131F22711
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 14:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5181B2527;
	Wed, 21 Aug 2024 14:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ff09pLC/"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D09D1B2516
	for <stable@vger.kernel.org>; Wed, 21 Aug 2024 14:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724250796; cv=fail; b=Ba/SnZVHJRrOu9K9+M0b4hR7oxYpWtl9EL0clLFvU+dkK2TDoqOB62sWLn4kfjGKk8/0Dhg/1Z2U9P/BzcDjQcQaACEGeCA8HLmITBkC9MyLuRAjC0yAq6oH271nrRro/F4EbCaZtRL9XNKWAPet90kfqC+G5mJUiA62usKcS0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724250796; c=relaxed/simple;
	bh=kXmSauzWjId9Z+sNd0FQmmqs4N0u3s5MnZY07SZRrHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ihaX2RI5WXsq43Or/l+4C1i+VFdGPnlhufp9P7ZmAz9EbjZdapFrlNdM94KE7eihOxcdfXPW6KzvfWJKEtAbzY07b6cvnEHULtrBInI6NkZ3ZRvMZ/ZjvuLDKWmgToW+H8gtBOsZk9RgkZT/wtZ1m73N7OGqo8Q3P7Jcixp9u9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ff09pLC/; arc=fail smtp.client-ip=40.107.223.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j9FEDeEBgYpwsibs2TsVfCGvtZnnNXvhpHVCf8VOoWxcERLLAvY2HRpISgw/EPu7Jy3g2GoqBQLFqzPqvAZWVqBxlEEoMhk7WgQUyyji9YraeOcBT/ZwcoLNveMbaBspB1YjJtWt1ht8DjqckWDWZzpsEtLDRrtNKmq2afUR5L9LYbo3LPjA6OL4vba5jGK1muT6mDF98TROsOupdxiqgr4DEJeriXjfY3D06MSVrwtl2RgdFwYzWntzGp7lMAtip/7f9qtQKhqfXsDWOAsTg2akDp1UMlYQiKTpAtEnllHJ3v65hu8q9iJRTvDx4xGzyyZHZ0NAFyeYWBrrJpnkxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AXMRMlXZU3/MTOUHIzCDUqxwIBw2wQUTfiPR5pZ6bA=;
 b=wXEwpR31kpoTYpOSzr/xsjyGljUBznIqN5yhJ7xgWfDJwcr1wxyuDx/aCKt4aWaKmcVfbPpWULmSy55MI77Iyh5vJ8QcKtU5pHUj9BHVd5FABYayAykzsiiyITt3I42iPuiTN3AGP8hAjDc1V2scEsdurmOIIF5CXchtQjsD547nZ5a6MyD+ZPC5L0Gfh3ML0NDnv++RfOd7SNxAwmqMwHSfS4yPeY/CKJO5DaOKIqPuEzTgMmBtG5qRTGF/QrauIIzO97jjs9tFYusq44KWnjiTbF6gsszBLmjLpM3B7nYFgDvp5lCv+n4qyCk5Wn0vD493SamQo+ZxeaqE3wAg7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AXMRMlXZU3/MTOUHIzCDUqxwIBw2wQUTfiPR5pZ6bA=;
 b=Ff09pLC/bpTt6cqJWom0I86Jk5VOjK7KPqB5+Gzs3Z/3u9bqsLqwpBtMtV65kTrzNuXR/WKz6IB6SDaoKkqG8GKgQda8RddsIYHYGIxviRseO++wwlbDYgLe/FApFSsy6GUG1X0AFIS5P4xiVO9PI1JxxcA/SoQt23trii8xdGYQfB2H0+n2/1RNF9JH5DSyxi0BBLK97oNYPa3jhwYWkuOFwyEPViOPmaqsyHpBkpyJx1DmiE8a7fq5ouH4FDuhaK26O6I7YQ9PX0q6Kugyp9KyUx8VhXMvvV2INWE+aeDIpSLFfKBHHdRNyI3Nulzae/S0M1fMexcWfWDGQ3Cg9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9)
 by PH0PR12MB5677.namprd12.prod.outlook.com (2603:10b6:510:14d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Wed, 21 Aug
 2024 14:33:11 +0000
Received: from CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f]) by CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f%5]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 14:33:11 +0000
From: Zi Yan <ziy@nvidia.com>
To: stable@vger.kernel.org
Cc: Zi Yan <ziy@nvidia.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Mel Gorman <mgorman@suse.de>,
	Yang Shi <shy828301@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] mm/numa: no task_numa_fault() call if PMD is changed
Date: Wed, 21 Aug 2024 10:33:09 -0400
Message-ID: <20240821143309.2034491-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024081951-fable-brewery-9048@gregkh>
References: <2024081951-fable-brewery-9048@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:208:335::26) To CYXPR12MB9320.namprd12.prod.outlook.com
 (2603:10b6:930:e6::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9320:EE_|PH0PR12MB5677:EE_
X-MS-Office365-Filtering-Correlation-Id: 9473d7c1-669b-4700-bcd6-08dcc1ee2efc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Teo3VhKx/GQbRsuZKVEBo+cp4bjcquKzwMCW7dlpgDciPt8x+gl6cpbPz+qn?=
 =?us-ascii?Q?ClgIMAhjAY1BOreBUKhO/m46NIjx7w1VaQ6UY0GKu+nmG799vHz6WDcbs10X?=
 =?us-ascii?Q?G3b4y7o6mi0JzQokuULJolnD+zAwlfRCw+AOQ9Igady/jrpUaPkxkUS3gcTj?=
 =?us-ascii?Q?RPHGKm9d8A5dTBroCbMIj8KvYYf10CJvWTWx/wdUjGs2kHnypjUfnIkE1zJD?=
 =?us-ascii?Q?A2B2SIoRgdKszyT/B87gLWehI4kylAGtcf0oqxzpTs+lsoUAb75qHjCl9TT5?=
 =?us-ascii?Q?L4ACNTACFDdyiS0f8x3QD85SdXH1Se8YMj6VllBbRT75hx7aKJgAIFkrpupL?=
 =?us-ascii?Q?P4+5C+WDw0QK8i2W9YSILPEuk5QMpuIfZNtn0XqejLZh6cCK4xevlry8pGcn?=
 =?us-ascii?Q?bZsQJ2EzdTr9tyZ+wIav/AW3HgpWkzBfkSeDmqeP2MnTgOWiKIUREpj4g7VF?=
 =?us-ascii?Q?Mzc+NfdRwsLQw1iok6aJXhNAEntn4LX7KWbbEkJLBA592ydlU97jWxFuc3o7?=
 =?us-ascii?Q?TT9rhNofvHRamO8Bbz8XqPZwUjMEe6lpf4i56MI0UMT4/sHw6H5bT/RHeaur?=
 =?us-ascii?Q?qLje5fLNCOBhdCyy1xCuvn1IyfM3CoezhjgRKAkmqwKrytK/HO39hmoaTFVk?=
 =?us-ascii?Q?ZrPe5Sca8lgONv9YAuzAxCPhxG2Cj0XmlcOZ/yCCDCX1ZgmrhMS2S2nSdGxW?=
 =?us-ascii?Q?8yoMlmKuBrxRDL7G0CkD0eaWjPpbDXowAxc2sgZWi6fOOf/6CerCcu4z0GLZ?=
 =?us-ascii?Q?Y5IRKogcM0m5yfxILdJKnZ2TCgEhqz0hycW6onCwNimlGUP718zV5VudAEv4?=
 =?us-ascii?Q?X2pdFLFXya+gSfCFvMtlEUOPPOUZmtvv+bgZEXcfUsVojJm4+3JcGPMKdLpz?=
 =?us-ascii?Q?xH2mB2ZUoLq7vP7ppTlMFTjS2VKCDtFg+xCuJGiAzkximWhIkozN/nc+tlCX?=
 =?us-ascii?Q?NxxAW/7TPynssfOBrQIGfYBrh2gf0zM+bBE7xaWs4S72AtQT39k4FrBxx5uf?=
 =?us-ascii?Q?iz48z+llSvVl+vp5n2ab1ZowBzYOA721PN8QJnJwQHqV4vzeh6pxc+bhpXB1?=
 =?us-ascii?Q?uGhWSjwgPOiaKZG8mQRrXCdbkIVWxPHQi0zEg0nZbek0IkDF/UicJZndik3j?=
 =?us-ascii?Q?50Fn6rlE0TYwWgdv6JILZAQnWTU3AVoT50rg9uioxVA2lsOCU2Poln+8T3wh?=
 =?us-ascii?Q?rx0MbWhhjSlQvpAsNRUE2qI5zhcOZd8DMMV5hk3jNrIc98xp77S2ZG2ITUHp?=
 =?us-ascii?Q?xzJB5C8ar5IGdUuFUdonop573HrSDnzooYaM7Bgb7bi8tDLmLcvJ4uF4t5q9?=
 =?us-ascii?Q?vMCGozjMvqWLSnEOp6vif6poMeFV7shyTLJ+Ktl5e/pbKLjuhhVV06qPm+85?=
 =?us-ascii?Q?oPv40SE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i5o/jmo50JY8ax188pQCQswLIUN/PWQabETfC71iWFRGrV3k1KVGgLOYpic7?=
 =?us-ascii?Q?QW5AIw+9u2HuuRVfidLaHQkGT40lq6Qcb3sp+0RwuAo8EB2CVsa0HxPNcB8S?=
 =?us-ascii?Q?+fN3a7Qd4ZgTegxVP1F95HS0DjAQnqJjLkOkm/xZbetkSBl6l/Qq915o36PW?=
 =?us-ascii?Q?LPvJt9ev2jPlqK12GAIt/S6iM8ZajrpJUchhEsiXzpv9X0ITU6pZUNLkXIA0?=
 =?us-ascii?Q?7M3rRi4QGKLQXP1opiaewUKgQHgrpjr8l+tinUOE7y/4xGAgHA1k+AlbvCjY?=
 =?us-ascii?Q?7x1uflwWTmV0f46ZbyR4KKOjFr5SHoedVhwH53L7vlKozOHUz8pktiJWwx4a?=
 =?us-ascii?Q?RkqIkcYDVo8iYmQRyJ4wiQrfDq3jn7BY66of1X5UpMHk6ImCYgIP7Yr4y3oM?=
 =?us-ascii?Q?oNu0NhBC4ymt+E/jsp8uzg0ESWPwfKl5HOD4jSqM1yhKZWffEGUuIn/jp/Ij?=
 =?us-ascii?Q?NuDawxIBZhhKjAJf5OO9oHe0r9xesGkhlWLtoLo7xBRdd1QZhgiMhEojakYW?=
 =?us-ascii?Q?qqCda7umV2p2ARh8Zj0gEunHHn6Bs5FELlfHQoMtMNYVPNBv7J4NCSg3ZXnQ?=
 =?us-ascii?Q?ywlEbmVJfIWxKvN1wnfb9syByrEBDiHS2DJLKPKJVXPAexwi/QPT4y66I4pH?=
 =?us-ascii?Q?3IQPDFAaPt06KN1i0mYmkAdbpX7G3LvFk9dR1dH6qfBbmxgevCLPSfhtm0/1?=
 =?us-ascii?Q?MiFMYQ7za+PGtoaHFDOprEoQVuRcY7fDj4gltMAjstH0hKfZeT+C5lI1F6cp?=
 =?us-ascii?Q?hrPzYmAwFZHjtw+kc/dznE4wrUym4YFnaiiawhfn743qVKudhht0Hr9sFM0h?=
 =?us-ascii?Q?UoDQB/OZJq0sGKv5FaFJZy3tcZHSIg0owd08yF3Z7ZieyF5ixS/wJjI1moRB?=
 =?us-ascii?Q?JQvWzl5EjNa46Ch/SeCvjneEAMyCvR16i3qdYOltOdOnjN2d6iCE2ONyxjSs?=
 =?us-ascii?Q?Sosk/s5kHvGyUBaKgodbp9P/soQnVKTtxVEBwtBCx8R9oP6ZLUuPNTqcnGwc?=
 =?us-ascii?Q?bMNa48ZZlJi8ehzyqua3YMFR8YLpqLksYr2ZZeKrxd3gK+SA3QgXUATp1eK9?=
 =?us-ascii?Q?TI02MMZncJEPCya1TYaDIVz4USSV2vQSp+HB09cpuMhSdKRYOcpVl4wviJzP?=
 =?us-ascii?Q?sniKW+zs5NeXZm51jK0YrZ6lHX2hDgOcp2kxFLfk6sCtTTOS61JSf0p8/Vbu?=
 =?us-ascii?Q?L712Y4IHiBxhmVK9N+LtGxnamHwIC+JhB4SUYgZhxgpNHwoleH8z4W9Al4c9?=
 =?us-ascii?Q?7ww6vTKnv/4d7G+gKnkMpstYxe25nyphlKb5FQvvngk7e2rIESKVf5oLA9ST?=
 =?us-ascii?Q?U+jtOh9bscEA50uMc4Dza/LVXOnnk3pTDAN8BIoGgiA5ONDQTOwHcol5ZJ6g?=
 =?us-ascii?Q?/ORVx3iT5UiiGmTPQrzCuLIREUn7ZvfAOCJ4IonzwwWfKZSGKkFGs78xcLDe?=
 =?us-ascii?Q?J/Yo8w7++/ScOmGQxJvaDLsLwVJ0F5ic9A8+wlr36W515K0rko0TEG5kr7N0?=
 =?us-ascii?Q?naJSCW4SbNxgfw5aYv/PSv8yug528vE2h2V6Ljy00g41duR1XUnFNniday0s?=
 =?us-ascii?Q?S+JgoAaoO4PPjLIkHhk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9473d7c1-669b-4700-bcd6-08dcc1ee2efc
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 14:33:11.5757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hRoccU5x4fRvglm5xs+vw2I8lh1fhHwEAdBc+ZUn5PNEKTJtRmWi5Jy5CBKUaVnY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5677

When handling a numa page fault, task_numa_fault() should be called by a
process that restores the page table of the faulted folio to avoid
duplicated stats counting.  Commit c5b5a3dd2c1f ("mm: thp: refactor NUMA
fault handling") restructured do_huge_pmd_numa_page() and did not avoid
task_numa_fault() call in the second page table check after a numa
migration failure.  Fix it by making all !pmd_same() return immediately.

This issue can cause task_numa_fault() being called more than necessary
and lead to unexpected numa balancing results (It is hard to tell whether
the issue will cause positive or negative performance impact due to
duplicated numa fault counting).

Link: https://lkml.kernel.org/r/20240809145906.1513458-3-ziy@nvidia.com
Fixes: c5b5a3dd2c1f ("mm: thp: refactor NUMA fault handling")
Reported-by: "Huang, Ying" <ying.huang@intel.com>
Closes: https://lore.kernel.org/linux-mm/87zfqfw0yw.fsf@yhuang6-desk2.ccr.corp.intel.com/
Signed-off-by: Zi Yan <ziy@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Yang Shi <shy828301@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit fd8c35a92910f4829b7c99841f39b1b952c259d5)
---
 mm/huge_memory.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f2816c9a1f3e..9aea11b1477c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1504,7 +1504,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
 	if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
 		spin_unlock(vmf->ptl);
-		goto out;
+		return 0;
 	}
 
 	pmd = pmd_modify(oldpmd, vma->vm_page_prot);
@@ -1548,23 +1548,16 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	if (migrated) {
 		flags |= TNF_MIGRATED;
 		page_nid = target_nid;
-	} else {
-		flags |= TNF_MIGRATE_FAIL;
-		vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
-		if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
-			spin_unlock(vmf->ptl);
-			goto out;
-		}
-		goto out_map;
+		task_numa_fault(last_cpupid, page_nid, HPAGE_PMD_NR, flags);
+		return 0;
 	}
 
-out:
-	if (page_nid != NUMA_NO_NODE)
-		task_numa_fault(last_cpupid, page_nid, HPAGE_PMD_NR,
-				flags);
-
-	return 0;
-
+	flags |= TNF_MIGRATE_FAIL;
+	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
+	if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
+		spin_unlock(vmf->ptl);
+		return 0;
+	}
 out_map:
 	/* Restore the PMD */
 	pmd = pmd_modify(oldpmd, vma->vm_page_prot);
@@ -1574,7 +1567,10 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	set_pmd_at(vma->vm_mm, haddr, vmf->pmd, pmd);
 	update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
 	spin_unlock(vmf->ptl);
-	goto out;
+
+	if (page_nid != NUMA_NO_NODE)
+		task_numa_fault(last_cpupid, page_nid, HPAGE_PMD_NR, flags);
+	return 0;
 }
 
 /*
-- 
2.43.0



Return-Path: <stable+bounces-69830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C4D95A1D4
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 17:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE4A31F24A5D
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 15:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8F61C86FE;
	Wed, 21 Aug 2024 15:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i4I8kKg2"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041F81C7B71
	for <stable@vger.kernel.org>; Wed, 21 Aug 2024 15:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724254867; cv=fail; b=CftLor0qlJQQ2GrWww09uQc96fx7aHe5TvbQZG7HToc2G6ZRuOgn3xfSud9J/Pq+TqZSO0WU9oiV9E2I6u35vS4eCv/f5S+R/3qRq4LkpNvmFMmmBnSiNTskei3iuJQihMZMGEmYhBsgVBWlbWgeDPsNuFWK/Uu1+70Rm0PLG18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724254867; c=relaxed/simple;
	bh=D2y8cc4rdzcXf7ICjSi387UXc0sSWkrZ7vVakLqEjgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FfC0aL/vrwRrRfKDqPHxWHw8tVZb0jEhFLj2X8CjtMciAHH4B6hw2Qv2YoeyUdIw2IxOoRW1WEt5H95Y/DE6WTbmbgIxlymb3JkiblkrJx4LhVutFD7Qaik3XlrVEdGVtXMbutWpf1rwP0sR/RnuyPfewdAkqh/XtMaoBcC5dv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i4I8kKg2; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z31CW8TofauGai2KCA5IFHpNWrE0NniQutfqKrzmF6V0wfXUL3QQHOcp0EOEOmnDNdWBrvQ8ZP1Stxl3yCIkblSb/2L3tPOE70MdiS1dABfC+VqR9W0/0Eull7hGToMcxRR2R5AJHqs7WN845kv3B7wv/BqyxGq0EvN0gQP2VIH1YVunrt8ChqQE09V/qm+t78OMPOz5jYd/RlBPsJTf3n8FZ7ECYb/NMhJW1cP5AgEVrUbeKbtVpZuQKFEjhb6I0O/kX2v9bdAy75YvtkHO+xo6g80yTJ7wfVTqFNvqctOiuEhZM7fYdgAyHyBZ++BGcGDaDH23KKl5Cguq2e7pEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLI8ePIBAxdGwg/39CSJbF1b+RSKuU1xBx/74B8gYd4=;
 b=iPtcL0GF/nINfEYx9DqFYJXw/iaapK1PX3LctGq2M26juomh4+VQ6xHxbF8HL2e0y2K89IZlD2P3ARXokuMMK1nDtJyhVurfI+bmTIF4QVtEpK7XyA1jHKJz1FTqPkVz9cXlDIQlyjNOtkYbz2ctsySSc2y+6l+xb9aIounrhADlK5jhoPOD0z3AgXmc/kbxQzH8fmeMfrGvibNL8CwBPfTzHvn57byeI0iVj9FN4EgWH06staLidjjOig83j5g560usQuNDCJ8L++YzqbzedmE+hwIDeLY3ofgkVGj1rQqJBVYtHnOF0dm1JSJyqdto60fiLAQAvGUJ2esv0eL9RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JLI8ePIBAxdGwg/39CSJbF1b+RSKuU1xBx/74B8gYd4=;
 b=i4I8kKg27MWCCzh3cYgXazxxmURwvbcy4DC3GTlWV9bMBBGLcPRZq5guhYDaEXTQaZgmu89CvRmwxkpsGfHNOlgJfj8zpeS7AKAVlEo782Xbs5GDV7zK+6vE8cQroEzYlKJxfXUtPE87WbxXxumo7L6CCyX0EdK+v+dsyotrtmzVom0hfeRVVGRZpVubIyey4E+37uETGYXw8W3dVZsts7He2vHawP6ANP3gNIyOByXEYLY3ByG6P8NAsecE5S5/8IV3N8v6Wh6aaQZoqyUmSRIBIhKqYHYUL7hqsVuOV6h5ZjyskKpOK3pkH5Onbc1M4XqyfJZu/Ex+UnX2BuKRhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9)
 by PH7PR12MB6881.namprd12.prod.outlook.com (2603:10b6:510:1b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Wed, 21 Aug
 2024 15:41:00 +0000
Received: from CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f]) by CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f%5]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 15:41:00 +0000
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
Subject: [PATCH 6.6.y] mm/numa: no task_numa_fault() call if PTE is changed
Date: Wed, 21 Aug 2024 11:40:56 -0400
Message-ID: <20240821154056.2244959-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024081932-vastly-ice-7932@gregkh>
References: <2024081932-vastly-ice-7932@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0054.namprd16.prod.outlook.com
 (2603:10b6:208:234::23) To CYXPR12MB9320.namprd12.prod.outlook.com
 (2603:10b6:930:e6::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9320:EE_|PH7PR12MB6881:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d69296b-84b0-478a-2572-08dcc1f7a826
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ErFdkVLAZr1AKUbJu/ntooLEYlZGJrI6mJrUZsTGWQ1Ead8xghO0VmH6Mc+A?=
 =?us-ascii?Q?RC+8xcS9uJ+s8gMxljmaU4ofYdabYOjW/MCOrzWHoe2SphIXt+Z5gZi+K4R6?=
 =?us-ascii?Q?0XbSu9RjI16i0C6Zfahp47UGYP+HHMOP4yCMChEtU5/mvH4FABQ7Nzdw2OSv?=
 =?us-ascii?Q?y3GZ5SHSuIgKhPyHKDZvlse9LZjPlG2ghbP3nx6rr/AHuyWIjZR0rSSse7j+?=
 =?us-ascii?Q?cSMVKN+7eaC7pV+KZG8Uya6rfrwUFdMyNp07IIWjk7AwRYlnkpGVAht5DSwF?=
 =?us-ascii?Q?2LTBc69WkuDO8lOO5JHII7x1LV8Y8vVlR3X4DvvmV9aOnKYszSWrqYuOe3g3?=
 =?us-ascii?Q?uWpVgqljIyYY4vNy2/pVIuX1lnxKFFj3K/r2KFUTnPVfp4kpQR354kS0V2FC?=
 =?us-ascii?Q?MihYAOh326gtRemrouVVLBh/g0oaS4g39r4eMXrcTt3vYLZt3YaKZWLI0Y/r?=
 =?us-ascii?Q?4UrHmxx41JN9S6NzeZ+fzWD3pa5Vc/GVvlHdaZ+gvq6nnOfAM+7YTidHgjkZ?=
 =?us-ascii?Q?JB/uKuZ6oYeKLXqDMNb2/USv7FhEA9SSjoZ1+Z4lNehl0jhszIKT8/wJH0fg?=
 =?us-ascii?Q?tyJUIW+fcvnHwljFzXGoEvP66CGMqynZrF7JYnEPO6GaPru+akDzW2dXT/Ft?=
 =?us-ascii?Q?mUsHOCv9b2+kSq/p+whi8fbMGz5lWzeW39+4oDvGT2Zm6Hhxx28jcX57O5P6?=
 =?us-ascii?Q?YtQJylHGWFuA8ZyW2dDRVetv9AZlfA96JRom3Xk4131YyBd2tGllvhatz7z7?=
 =?us-ascii?Q?HNzH/X1K7VmWCRL7BJAXkgkenLGD5X6DhCbpmbZ40xaGoo2L4H4F2uosg1qq?=
 =?us-ascii?Q?e+Cc2VACSZwJrGCMCi0qP6cYkNjGhBNL4Gu2V3ijapTDL3TMfBMpEGJLLwU9?=
 =?us-ascii?Q?lYza8tvugoibiVwxxVxBZc0IgDKa6Af44z6/+v4hvjHHNbvDOlmTUzfqNZtz?=
 =?us-ascii?Q?anPUobHIRXIP4zVaLshGhFE5iv/wMF0WUTjz2AJcHwbstB6WBVAhgc6CuMzJ?=
 =?us-ascii?Q?u+y0L06C8X9YI2yTWdgcsNsYd2VN7spx3ps054R60dtCbobbxj5nhiCo+//p?=
 =?us-ascii?Q?FK95hRQk7luMLqpEU2Ts2xhKkbs14pW4FDq95GyOfUMJ3r+Bs+VAedKtUvNK?=
 =?us-ascii?Q?6n6wDpubUIp6J3BHSp+TXobGVXRtI75/XDUB3IR559uZWlAvC0gWe50CZQdD?=
 =?us-ascii?Q?zbTZjr25B2y3fUopyuMKvdx6YmDN8krK+KzZuhTaTbgUyR/E3d+8zAT+k1BV?=
 =?us-ascii?Q?0Ct+5xRtaxRI4Kg+G46uRTNt8pkjiNLXyL2WFNIL30FHkKhx4hhSFMxaETvV?=
 =?us-ascii?Q?lRK34+p72mB7gFT895GZRL/nqn/SNfJddVsxJxUl7v4tlQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fTmxk643w8yuJdCHSNCT4LHrexVaJnXFEEzdG/ykqpksA7+kciOIBWfB4rKw?=
 =?us-ascii?Q?B46P0jVtFglyVigoQJnLmoNipwGHsPUpdiLUYXyUi2++wZIAcWrI3BFZuKha?=
 =?us-ascii?Q?ws9WmB2vGHZEPT0rU7Nu98ZA8LXqoQB60fq1Igq//zf+h4HK/n3m0N8bShLb?=
 =?us-ascii?Q?GVBOPr33iD+YpOMuwknEpNo6ushwMsd7pKtqYg6XrZ97SYupI5LHBpKu8OhT?=
 =?us-ascii?Q?nTCYcKqsaX/izD0UUc0ZK/kHoYeXr5k9btGs2IMGkgLNpkPDMQmuZmZApl0y?=
 =?us-ascii?Q?Qp3uNr72l6xbK//sUqAan4lvf16CVEDQBbT4zrvd2w55AXyFfMgPhcOZVjCU?=
 =?us-ascii?Q?5/S7hA9DdxhdoRLd0VrGQelTDkNUs+m6uCUzghDYqDrsijqmr2SE5zT0nMOV?=
 =?us-ascii?Q?O9thdKvWdAyDv7a6kGICxBIGv8+4SzqM8r0ln593VkX3L4v3x4/e1VanVTif?=
 =?us-ascii?Q?Ij8+4iod6mR5MsDnkm2qN35adq3w28LIfqS6CXhN1H8M07c9LmKPEdO2b7vO?=
 =?us-ascii?Q?yDoJ39PvnYaSniKTLYPmymhbnLzjgUSL9kFJnmw0L14ma18Z+XQmgMSK2NUL?=
 =?us-ascii?Q?O8wBUZdAYlE+xyHGXN8bxl7KVy0LWt3uMnuFjY/RBHdhZQvl3F9MLNb/wQ2D?=
 =?us-ascii?Q?TXUN1a0k2lwg/O/jsWDP/fLcLAEYpZ2/UVtHw8r07jNSLyLQ25+jmrC5uFan?=
 =?us-ascii?Q?c0sDo8mpuOmswFUH6HEVFUPjMNdKVMCaC03d3ofOnkQD3yHGQNGNQPYMpDBF?=
 =?us-ascii?Q?bAHmpECKBgqLtY54d7LtfqeWirhYpYjBVKxG5Shq51CykxaZBE8RXF5BbD2A?=
 =?us-ascii?Q?tAHhKe1nOEf/xcLhWZnJWQYIQvJRY0NS4kw/e935Rqt4Ly5nqPjKeXLkNpVw?=
 =?us-ascii?Q?0S4qKPVCLxCVtqfqmCnUp6tVyzHRvq8L5/5DE9EVv5fk1KeyWxI/jZ0IXZL0?=
 =?us-ascii?Q?dYRTsmtMUrgvN4m31kuX8HFMrHD0eRux7Snojz4sndauVLizOTlROsM0h652?=
 =?us-ascii?Q?hlr+JCeKUuCs5Ct5fF5Hx+WS3tC2NLELlwoDkyEEqYFJ7q2Uqg3pTDKcf87l?=
 =?us-ascii?Q?j7JOLJv33tFYinPi0+gjmBk8qCZUQBt7JPP0vlx32PWL0+E13ByRXO/Du0tg?=
 =?us-ascii?Q?x24RFa9oxiA/Tm0mgTHSeAgvRCZi6k6AKXjuBRayMFNIfpR+K+9os8nQJhGJ?=
 =?us-ascii?Q?G6XGtsRQFkyU9G0saKLHb1SpXo+AAGkzKE6YCWrlprkjP9BCVbvMIVYuOib6?=
 =?us-ascii?Q?ztLCmS+j5eF6+QP/XbEchhxuMSFj3m/77DRHuCWrPHv5R9k6gKrxUtZzWpi2?=
 =?us-ascii?Q?jVkH+ny/p3mdsikI9Ppge3Ucw4gWb1p0Z64Mhp3UvHFX41GmHN+EGadEpOOQ?=
 =?us-ascii?Q?faFxKf/B1zz+EBrTyF5uU9q+ndj8PUhGyTfLqQGsCZ0qPdIlj1687qFSKORk?=
 =?us-ascii?Q?gZHU76Vt03wzRqb/vjUtcW7+t+EystiyfyELbcG6kLNxQXhsbVzqAycm3lmh?=
 =?us-ascii?Q?i0IzqtvBH5umQ2O8VG5rIlboS3j7rkssMWxUWlYO31tDs4XE9DXbpbfLULUb?=
 =?us-ascii?Q?37laiwAJE4oFHJhlsMZ3qKd+2svSIjWItkCG0Zl2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d69296b-84b0-478a-2572-08dcc1f7a826
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 15:41:00.3256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O+/GLfx/R3xTbesf5/oKjuAx6LGv0mjGzvhRvrgdroetcUjjxrrVstm6mxJNu3Qe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6881

When handling a numa page fault, task_numa_fault() should be called by a
process that restores the page table of the faulted folio to avoid
duplicated stats counting.  Commit b99a342d4f11 ("NUMA balancing: reduce
TLB flush via delaying mapping on hint page fault") restructured
do_numa_page() and did not avoid task_numa_fault() call in the second page
table check after a numa migration failure.  Fix it by making all
!pte_same() return immediately.

This issue can cause task_numa_fault() being called more than necessary
and lead to unexpected numa balancing results (It is hard to tell whether
the issue will cause positive or negative performance impact due to
duplicated numa fault counting).

Link: https://lkml.kernel.org/r/20240809145906.1513458-2-ziy@nvidia.com
Fixes: b99a342d4f11 ("NUMA balancing: reduce TLB flush via delaying mapping on hint page fault")
Signed-off-by: Zi Yan <ziy@nvidia.com>
Reported-by: "Huang, Ying" <ying.huang@intel.com>
Closes: https://lore.kernel.org/linux-mm/87zfqfw0yw.fsf@yhuang6-desk2.ccr.corp.intel.com/
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Yang Shi <shy828301@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 40b760cfd44566bca791c80e0720d70d75382b84)
---
 mm/memory.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 58408bf96e0e..bfd2273cb4b4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4775,7 +4775,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	spin_lock(vmf->ptl);
 	if (unlikely(!pte_same(ptep_get(vmf->pte), vmf->orig_pte))) {
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
-		goto out;
+		return 0;
 	}
 
 	/* Get the normal PTE  */
@@ -4840,23 +4840,19 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	if (migrate_misplaced_page(page, vma, target_nid)) {
 		page_nid = target_nid;
 		flags |= TNF_MIGRATED;
-	} else {
-		flags |= TNF_MIGRATE_FAIL;
-		vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
-					       vmf->address, &vmf->ptl);
-		if (unlikely(!vmf->pte))
-			goto out;
-		if (unlikely(!pte_same(ptep_get(vmf->pte), vmf->orig_pte))) {
-			pte_unmap_unlock(vmf->pte, vmf->ptl);
-			goto out;
-		}
-		goto out_map;
+		task_numa_fault(last_cpupid, page_nid, 1, flags);
+		return 0;
 	}
 
-out:
-	if (page_nid != NUMA_NO_NODE)
-		task_numa_fault(last_cpupid, page_nid, 1, flags);
-	return 0;
+	flags |= TNF_MIGRATE_FAIL;
+	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
+				       vmf->address, &vmf->ptl);
+	if (unlikely(!vmf->pte))
+		return 0;
+	if (unlikely(!pte_same(ptep_get(vmf->pte), vmf->orig_pte))) {
+		pte_unmap_unlock(vmf->pte, vmf->ptl);
+		return 0;
+	}
 out_map:
 	/*
 	 * Make it present again, depending on how arch implements
@@ -4870,7 +4866,10 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	ptep_modify_prot_commit(vma, vmf->address, vmf->pte, old_pte, pte);
 	update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
-	goto out;
+
+	if (page_nid != NUMA_NO_NODE)
+		task_numa_fault(last_cpupid, page_nid, 1, flags);
+	return 0;
 }
 
 static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
-- 
2.43.0



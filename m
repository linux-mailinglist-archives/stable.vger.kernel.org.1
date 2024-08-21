Return-Path: <stable+bounces-69832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D15BD95A242
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 18:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87333289F08
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 16:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75331531D8;
	Wed, 21 Aug 2024 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CL9VhkMq"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860471531E1
	for <stable@vger.kernel.org>; Wed, 21 Aug 2024 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724256055; cv=fail; b=Fp986MVqzh9JCH9pE7W36hVCPqsf5ylSZiV1LV2MAWj3OdztLBnY7bYL/4AUIBIw277r0Sq/Ae8PmkKoWD+nHdD/9RGyVNt2U0Sgs6SMqNXs18p2np1lfVY2/oDt1QDXElo5PoLtpL+CxkPCYm353uKssuUPn8oJYWC2Pnjn8QI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724256055; c=relaxed/simple;
	bh=HCgdlYD3tZDc/PAsZfQyotSuBu5g0ZSqnl4zxW3yLdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kGwIMGCoCjTxYE/ZiocJS2fyymbO5hQZ4u3fvmY+4tuMZV4W0JssAUzZnJxppJ2g4Un9Rv/2+lFZ3v/RW3LLoav09glBoR/U+KDvQsrXCtaNCa0xLz/uatoe17i4Kc3TfXtKDvb1n8PD8lZSrxobiyxsPXUwvvxVGbo7pPqVkpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CL9VhkMq; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YhItyaddhw5tcPbLlNh4apL2rsyA8g3/vClQ9UOEdY6QI6fHJddILM4ZOZOJv90aMMd4l2Up5QqTA8LOGpRH3vnBXcH7raPZ6tjwtJgkbhXEG07R4b9S3FdckoK4GtVsb7XIcfBXeJmyGkbTdCs+jcmMUgP2xr1tTtMkbXqBeoTPp7C3tfFmZtp8LnieTJBhUqXcelQX48N4Ebr3X2KdVB9NrFNR07Mq6vm6PDP5fAXtSNSVo/CpAPxs4JpxvbVM70JCf+D3cXweRWJsV8afdCfWvEvekjObK64M820KzuCxHtee46lwTAraBR07u9ttBLsr2VWUN/YyZGgfl2sVvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lnQbN/1JYMXaxs8nQbMcCZNsDi9fR6sGBnds7ozgSc=;
 b=igW0J1E7PTaNvfKqTiXOdcCUJiWra4vtctboE61uqy465vFPFZfbHf7pj3a8Axy44BhrB5xGRCw/f1fuh1OPyKQVkYkMCbKen2ihfffbrE3caVJZaxoSjlcFW9arHI2ykcrAMqEf79dG4St0w4o+XBYWCHoAmI4pwN+/Fbow/Icc91UfpLGkCPxSoVF2nuH1PMMx7swAt2qNpP8Pfdqt/8LMCsV5kmm5ZufCheBK0uSRIGSQ5rgJc/qaAdE6l0mSkXwjWw58RdHQJTRdN3qfnfq8FQCuj5w+I7OYSt0UtKWINfnGlKQnYWy/DfzaOzYHdLeyKKcCebWtf+VzrpCmhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lnQbN/1JYMXaxs8nQbMcCZNsDi9fR6sGBnds7ozgSc=;
 b=CL9VhkMqgkdt9ta8mwjrtjXXyfLR796fySR3ob8c/TyzABvkPx9xAfNrdP/+llOh5jV/0OBBS0sMaUlpgcbR5blDiKNb7GIma6GMcqJGMkMBqeCsEiAubUmZnzVuXa4TFFCW8d90oYSjXxg7UCA2rif5ytdg8B03O0QOY/9xwBBIT1fDdFzKSZbN2iA8+OoKPL9M1DKEbSyk7GhZelTyzlUFvlMbxzkmBLS48xnXPkZdconji74rIWKmIXq5A7onXKCFA056K2nmbu6z7wvej7DZzlJFl+N5u+6lRome13hM1WlxewK95dlHm2X/Fc/SHHVXisZftLwrXj3B1ns2/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9)
 by PH7PR12MB7258.namprd12.prod.outlook.com (2603:10b6:510:206::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.29; Wed, 21 Aug
 2024 16:00:47 +0000
Received: from CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f]) by CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f%5]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 16:00:47 +0000
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
Subject: [PATCH 6.1.y] mm/numa: no task_numa_fault() call if PTE is changed
Date: Wed, 21 Aug 2024 12:00:44 -0400
Message-ID: <20240821160044.2327824-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024081933-cheddar-oak-0777@gregkh>
References: <2024081933-cheddar-oak-0777@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P223CA0016.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::21) To CYXPR12MB9320.namprd12.prod.outlook.com
 (2603:10b6:930:e6::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9320:EE_|PH7PR12MB7258:EE_
X-MS-Office365-Filtering-Correlation-Id: c8547d6b-9ad7-416a-fd57-08dcc1fa6bca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IUlpdsZBx7LhLHzmuqY4KKirjXxey9DYq8KnKaqTcj5kG6Zi9Rf+heuQsQ4R?=
 =?us-ascii?Q?/w/Wpi9V6ksHtOaPSGkUnV6flzVhENkyyThPQrvL5kqPxr9t+8HDSqXQrNLg?=
 =?us-ascii?Q?mV1WCy8/k/NAN+iIaWNSZ6T5OsliYRTqlae3o2r/HzMP8yCvkuRwkwIcW60R?=
 =?us-ascii?Q?rlYVZkrzZM5Vq38qISSGZKjrYEyNmqqgBj/wHhaOsbvYWDsjZ3QekJ2i4FOK?=
 =?us-ascii?Q?264kr98Bp5PQRVqKGfZukf/E/0IGUEARGGsdOmOrN/5wiWlxNRgwI6W43LB0?=
 =?us-ascii?Q?NvTzG9uPD0T2Dt0A7PGpM3XXQNvjqtgkqSlxBOLqYq2T5JHmQZoy9RbSjxQT?=
 =?us-ascii?Q?hFw1oGlOrHc5vVH5FIxcenYEYAmdUvitSK7Sq6tArKdZ7INHuV69TywApOrO?=
 =?us-ascii?Q?bsgziwENF83f+qu+U6ckSGELizVojFlR7nGJ9gt5Y7o95lN4SepfJsUqJ2ai?=
 =?us-ascii?Q?1c3fZeAxyWF0MPbLLIFcfuXyBuzc4KA50xaCqTAiGPd+tIWqBzhVcoqU5SEi?=
 =?us-ascii?Q?uncs/tMMRfXuJwNzPdNLK/rbzJiz0qvxu4upzjeXhM2lEsGit1agTQsLB6tt?=
 =?us-ascii?Q?tlypzbE78l6MvjfM9tLzXQpcDvmdYAKcI95XNdl3hbByE1DJNYvPSsUx8mdR?=
 =?us-ascii?Q?y+qID31VeZj0VBsUF0zS4XtbhwI4pdUpdZ8QVgNiipX4NhIFf74r/W4jpaXC?=
 =?us-ascii?Q?Gv7rtMPevqESRLb/3o1yd91tB9qQkFHUqKJjO32BtnyKiMOaguDRccc2b+gk?=
 =?us-ascii?Q?l4o+/8+3O2++1zCrLKxsmzaetJ7u12QwGTqaVRsrgSs5uVs5gweTC4YTwuR1?=
 =?us-ascii?Q?LxD533pWARpet/a7OL4VQYnt8T1Ps/PR/lFxjcp04BAkajw1bzJbZvu0zbco?=
 =?us-ascii?Q?K8vJ7xzOKfhUAV1WJQqiaNn0dw5ogcHksMdUo6L5ny2OpR948sJHaDW2fyiS?=
 =?us-ascii?Q?Jzpqv5PzzxwSt3xQ8bFKFKc6S3mpCoTFBxpl/aMeVVEpTjrPTigPqk44Q5ZA?=
 =?us-ascii?Q?+zqX9fMFbXc6ANfqOgmOYbvxz7a2PghdULEUWV5FwspB+l0qTm4cIOSVi1Md?=
 =?us-ascii?Q?4rzV3QXdqtN47SoVuZu6r56nj961lOI4MizFiVsBW2/5xmBkMt5t8EAKvklm?=
 =?us-ascii?Q?1PEXh8aYlNi68lVLH3PKOCWk+K2xneyYxiSb9nxgRnSRNpg1OqSmXOdhqkOg?=
 =?us-ascii?Q?9L4gkLXM62yNm1/VfWYTet/pkVwQm0ijyH5xqQiB1pNb6uGQfoQKQ6kHXiwi?=
 =?us-ascii?Q?mxy0ZcDLmXU28lEezUsQoX5m6NlRHS8c6cYk6cRlApeq5bXnsyP3c5esKGD5?=
 =?us-ascii?Q?yCVBSWKWDHKAKT139yEGExsH6gCmfo7tNwB1zkh6huHe8A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iyQfqUZ0TE7v31vpPoev/AtF0o4G+b5/eeUh690VbGPguW7kxFGgp6gx9uB2?=
 =?us-ascii?Q?32iaV+YS/hmYQnT/HM5N+qQmLQdHFMCAcUDifLyteWHTyCtnUP46A4GLoxZl?=
 =?us-ascii?Q?hYnJI9THyzYpPqHDU7zLHRLFwC94745+0WzpInhK9NNTt9FT3wNgUIfCmoz2?=
 =?us-ascii?Q?S66N/uwhiezt+bsxwaGabkj4o5NfYexVK0WlVD3/Agzb8bTkmHs8lpdRCIt8?=
 =?us-ascii?Q?HkKYOmKG7Crl2OvBs7FBEllEioGUWtTNRmlCE+WOPKdVZ4vwq7lJ0u/ttxCH?=
 =?us-ascii?Q?YILLAgqP1BmEWiZNDOaOyeXrieQS8n6+k0BEj6cl6FUvjlook5HiJFU+Vs6l?=
 =?us-ascii?Q?d58A8nHT0GH7NWv/grDYYPVv+5jX0KjRBE88iOkmB0N4DtktYTOnF+90M4Mh?=
 =?us-ascii?Q?Wb56yo+OQ/01r0Y45+zd1lT2ggLsjVtGHr0nBqegkrCaxJeGZ/XZizKvbInQ?=
 =?us-ascii?Q?E3chmIEH4RthYLPBaD/IUKIntlhgq47JBpzSDtmgiqvRLR5jL00zQrzHhebH?=
 =?us-ascii?Q?1IOPCZWxVnNYpwrgMCq6kZK3GxFXmDzfvXLTPiicx0HwjlGeyF6OvsS66J5j?=
 =?us-ascii?Q?C4R00KfcRqtlguRx5ttgyUby+sse3UEqNwid77wSiUb0WVgeyrHePTF1mMdH?=
 =?us-ascii?Q?CBnBqufuPx6l1TzPXv7zYUrKGJKAIx+QeuNptKqhBewvuHD4vuE6AOPVRbxO?=
 =?us-ascii?Q?EI0wU7aWbmpUJ9psPbYKdyvTOTDAAgcf3Bcjs1+4d48rgZA0cI9y9kRwDyg9?=
 =?us-ascii?Q?UUfZEQfDAN7DCWPR0bLYDlZ1iBxqj4NGUU+YDgzQmzqpLFjOeGU5c0ak/jmF?=
 =?us-ascii?Q?CTCknZuH5X6Uw2HEtbZ6NIgYbpGAB8SjYpzQXZqlran6tOTXFmBeMrTJ2C16?=
 =?us-ascii?Q?gmWybIm0znnxLs9N1xFO23Hk4BoalBohC1XOmGnmGTl9AQJsL9/O1BHOE5x2?=
 =?us-ascii?Q?HWPIrUa5LaXsYuJxErBa9gvg88AFJzFrZddKds1ZF6Uogqww2LoBpHTF5bLO?=
 =?us-ascii?Q?td0+WY4XZQ04Ok2GUQ8wf85YekNIekyAOTwr46Y3fmfRyPLTkTpo6T5dc6I7?=
 =?us-ascii?Q?f47ljoUAw/545FTgZUg8DNPX+q36R5dfZej83ehpLuLGV021HF1Kb7wRkeU+?=
 =?us-ascii?Q?hdPugObx3CV+FWnObHy0O/13FgY+oFGp1lYT+79fvLSjkr90di3fZ1uROa9R?=
 =?us-ascii?Q?kVZLYl6A1TbmJFmPHM6dyOgRhq2iZKsw0QCplhfd+1YKj3NjfghLRIFnu2WY?=
 =?us-ascii?Q?XqU/gWQXzqwdA0wqmADpxK2GDW7frQTyE7BahCfnBDHhBah/U4gZANCig6jT?=
 =?us-ascii?Q?4ffgnRGM7u4jHk2/yK6NTPIlLNIubMMI3qn4dNB9SckDV/x3cgdseiWpbwlg?=
 =?us-ascii?Q?KfHhAg6obz3hwHz0nP2RrWtHWiJAaWPsRyA851kVIKenHJ/oQYYEvlDzdxsT?=
 =?us-ascii?Q?eaaikrMm9V7A/hSM3ZMXIqbYJSSjKWn/M6wCNHyXZfQ+W1BLfvk0D78ajExG?=
 =?us-ascii?Q?H8oBztghkn9sFfN3bpwiKvP4bBJPXBp6G9qvRvzpXxW9pfnKe/p65+beie4P?=
 =?us-ascii?Q?ouJ3Hi6HdMLsOCSfhfI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8547d6b-9ad7-416a-fd57-08dcc1fa6bca
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 16:00:47.5709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K/M27Q/N3S4fvLzpGtgRIiHqLhWQP+EgZWH4xtIkRHFRFGRzzdlS4NAdfyzcCA5X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7258

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
 mm/memory.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 301c74c44438..73085e36aaba 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4786,7 +4786,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	spin_lock(vmf->ptl);
 	if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte))) {
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
-		goto out;
+		return 0;
 	}
 
 	/* Get the normal PTE  */
@@ -4841,21 +4841,17 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	if (migrate_misplaced_page(page, vma, target_nid)) {
 		page_nid = target_nid;
 		flags |= TNF_MIGRATED;
-	} else {
-		flags |= TNF_MIGRATE_FAIL;
-		vmf->pte = pte_offset_map(vmf->pmd, vmf->address);
-		spin_lock(vmf->ptl);
-		if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte))) {
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
+	vmf->pte = pte_offset_map(vmf->pmd, vmf->address);
+	spin_lock(vmf->ptl);
+	if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte))) {
+		pte_unmap_unlock(vmf->pte, vmf->ptl);
+		return 0;
+	}
 out_map:
 	/*
 	 * Make it present again, depending on how arch implements
@@ -4869,7 +4865,10 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	ptep_modify_prot_commit(vma, vmf->address, vmf->pte, old_pte, pte);
 	update_mmu_cache(vma, vmf->address, vmf->pte);
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



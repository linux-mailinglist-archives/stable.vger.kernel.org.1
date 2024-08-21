Return-Path: <stable+bounces-69834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A06F995A27A
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 18:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5F431C21AC1
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 16:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC23614C59B;
	Wed, 21 Aug 2024 16:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZaFLorNi"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3472F14C5A4
	for <stable@vger.kernel.org>; Wed, 21 Aug 2024 16:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724256624; cv=fail; b=RjqsPGUq9YBvlHtwCv20DFI0BtDxI1RDoLChsk9yEifCxWT1FM9vXGMWFw7h0YVGd1Ro5mxPxFKEe2ggOorGgfeOSiSlkCw3DMN2OJvoo9Nj7LwromrlEIFOv8z4c4anR6J1161Np09QowZNSBsFZ8VcO3uQ39+vwei53fhqh5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724256624; c=relaxed/simple;
	bh=nvgr8DRZunUQSK8tzks1IHwWE0NperXgHI0DvqYZFL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fXrEQBU8ZAXjzA5+uXBPoGS7yyl4yDPxszK9/VhoALi9yH8Xb1GXLd33jV3KRmJzx19pa+9g7JrfuqpesGhnjQMzljJ11XE4O3ZOdrVFoDLhVGHaFnYXgT+kQA39Ri0E0u3Cv72CucuGljEsE8dHWdJzDMirrh15Q6yfyW0Mvqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZaFLorNi; arc=fail smtp.client-ip=40.107.101.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FOFjXr2SNURvw1bMIFW55hV+0dOPtiQEBJKMMw8b8FMaOBu5kxoL8hJqnN+uPuttPbZLlk0XgLr6FvQDuj7ZA6tfIurEZfNqjIkx0QBqlZm5JzC7vF2eRBCtE3mxYTgpem9XBdQjmj2aBo99SURCYccWM/15FG04ohezjkm+VFvYtY34PA2BzXSVttkGfFDDki21ze7CN9fVsN8inO5YHX64F/OWcb6SnNSVZZ5YYuAJJcCOa+0W52mGLW9qsgWSiZViqNBPCedDl5m6VVtqYASzYcJ/VJlaWck/8V8wDPzuJPLmcsfe7Oz1n3NQ59JeyeIBytCG1Msj/Zxq7TmQ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YKZhyN+AFGi56kALXLOgURocK5t76Hn5IH4/UgvmxkM=;
 b=Fnx6OQKxVlKPHOKRbQSKPmb1pVimceLmRNsqJ3FEFuu9OI4ZttM+bstGTW36acoQUsi4aZ02GKSHsypaql8OHkt7yHy+HbA1YvrjZe2zXEuD2fqPE3GmYNZha9AOvWLiL19YRpCldYLXDhS42Z3dH73CfQ1TQ1UfGEx8iL6gtAOo300Vif7dn4LdEk3DkWzFJI0ApxvFyuGmcRO3p5P9yVV5sE2XTQiDUDV/2Ug5DNQtxIZnoUz90IajhZwHwXwvIPkM1TxQphe4BBrGBNufdSAMFLZylu6pYJ6lhch8PGjC9Wv+pCqvCjUAcj6NhDhhrM5g6/cDhxVIREdIkesdbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKZhyN+AFGi56kALXLOgURocK5t76Hn5IH4/UgvmxkM=;
 b=ZaFLorNivopKr09O0pf+ASk4v+alLaRf7espHFSCE9IUjpQV22WZMQg/ot7gj7Bs3vW9gE7IFGAt2y5duJ+7acEEgHJdPfv2ynvef+NWEG7+0yklU1NrCo1KEuW5X7TY6MmQskHR/amuRHw8fA12vKiWxcULVozja1mfr8P6B+fSkItZ4/lDCkRgoKDil4WD4pOSRM9rCmxgmKxvfW94Pc/k1CVW5V35l4+Y4RuCBv2mdW2XKIKOaTPsNgcjZoq7hqy0VRofn1hZid7VBZIiJP+fVg0j55B83WKPV6ABXJCBKsbqsHtRVg57MHkvrdJikKsIksm3L90zMhitlwj93A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9)
 by CYYPR12MB8892.namprd12.prod.outlook.com (2603:10b6:930:be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Wed, 21 Aug
 2024 16:10:20 +0000
Received: from CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f]) by CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f%5]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 16:10:20 +0000
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
Subject: [PATCH 5.15.y] mm/numa: no task_numa_fault() call if PTE is changed
Date: Wed, 21 Aug 2024 12:10:17 -0400
Message-ID: <20240821161017.2399833-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024081934-embargo-primer-a23e@gregkh>
References: <2024081934-embargo-primer-a23e@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0376.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::21) To CYXPR12MB9320.namprd12.prod.outlook.com
 (2603:10b6:930:e6::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9320:EE_|CYYPR12MB8892:EE_
X-MS-Office365-Filtering-Correlation-Id: c619e867-d601-43c9-2066-08dcc1fbc12a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8OoM/vqcF2p6hdd2o/uST7OrNpPIy83zXA89TnUVC+OUFnobw4yrvZgxoOoV?=
 =?us-ascii?Q?DVcvxrZrBPuYz05KfYy2fg3Qwf2+ubaZfa9Cmur1jVFQI+EuR/3ufmzk6uKx?=
 =?us-ascii?Q?PDLR/lW5KlvOc2jSKRSwfI6uV3ms3EMOHdaE7z6myNmUgLPh/GkaGzO//rHK?=
 =?us-ascii?Q?q+fugxFr61vY9fe+/Z+mWe9Nik/hRQ3R/H2qGxZWFhYD9d/f/ZHR/XBPFROq?=
 =?us-ascii?Q?MLsllF9ZDuy1mSxaltk3d/IuBb/cGlJCc8+TXlerYKEERpOOftO/rhfe9V5D?=
 =?us-ascii?Q?tkfYoRjjVV45wjviQqhylyt0Z4ff/NtVi+7ijQe2oRNiuQYgKdnKopGup4Ai?=
 =?us-ascii?Q?a3bTWJbc2TPRzVymBEXv+io7jKtvjq/UXOOwvy8EwEGbTeHcZq63lpPV+L1E?=
 =?us-ascii?Q?4UBOY3RqezFrjMkcsoyxOWULa9BflhjZLha4grWVTPLpgdzT3q09uzzqfRpF?=
 =?us-ascii?Q?/XvyXdo05U2P6oGb+Nq9TSbLyard0J4Zt25cQ7Ac4043YrUFeeTDMYWeUyvU?=
 =?us-ascii?Q?JeyTqQmN10mTQERr/A4bAuQJ1n0XySLRIoBWD/y/EFxfhxzmMHvlzkNEEyoc?=
 =?us-ascii?Q?fxp3tLEx83LoL6dE9H5KEpbKYajrRCC7OlrvJd0Lc6MVuCK+yQ5oRAkf+6iI?=
 =?us-ascii?Q?pF2fdq6Rp9IJmK5tvgy62CKNp46wHoxes5YWbY4m5xQsQQujPrT5kA8B2BmR?=
 =?us-ascii?Q?udBzesfl+kS2MmdkFChmrQoG5WB1ohILnUkAM8mQTYlVeUFGzP1SU5yfV75/?=
 =?us-ascii?Q?Kahv8rcp1htqMTMEqDsyX1Ikqu2JZaPiEentwCw2xTiIWCgszG1sXBHN90WM?=
 =?us-ascii?Q?g+jWkQ8Hw/sauspedVIPrTzhUtbHtN/D3fi3tztFmiAz9X7ll4IDD1nIsJlo?=
 =?us-ascii?Q?hAEwRVz2TCAwvJ8mWNnTfK2zorwRFQxzEc+VkcCAWc0Tm9MSD6jpJ6VQk0Ou?=
 =?us-ascii?Q?1Qvcczjxv3S6gph3zSgrMfUY/ASubcls9YGJ6iUIHIXZ3q9iQHcTMFkEcMbz?=
 =?us-ascii?Q?t0m7WBstEOrj4pXLl5j3ziQAimkWVnVdJV3tVMcQinek39iRyu2UqKmnHJsi?=
 =?us-ascii?Q?/9aowfr14+el01pbWL7T/INJW1kTCqDr8V4+ErbyClKqUebGd98V6FNRcFed?=
 =?us-ascii?Q?zTdISDvx5JXhzf4Y/K0jYN6/UHMP/cwaUaxNo94veELlidrmVDisCXxiSMFD?=
 =?us-ascii?Q?dHySdbqqU4bqP3qutNphD6jXe5ccst/PyCMlAdHkwcQKULn41NqU7ivfCSED?=
 =?us-ascii?Q?AJE7jNUjSXgOHLFEqOB053o6fldshBn7VqoI6oCtOKcvMsR8Tsqq6+eze+ua?=
 =?us-ascii?Q?IaB8+dtyiwYTfvdYZ07qQ1H63aZ34hbZbx//okZFZl7C/w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ePDtzuVkv5KqDmgZXlb/e3lS5Yw0AmN3NmnyeM14MalBgAGUcs61m0TrM8cp?=
 =?us-ascii?Q?8HaYfFKwOC1Pu6D450QKYlcgMBFQyKBhZ7VeS2ck3TnoGqUP3WiI/VETanrR?=
 =?us-ascii?Q?VpHS+lbSAepdpQn8e3FK0JMLlH2iDXs/aflQRN00T71giYAHV6MqOuBUfDAa?=
 =?us-ascii?Q?YhzYxXQMR/QHDiJtJWamGKVtRR/4jvzv2ZS3I0dE//Pj034FD3qplCslVWEe?=
 =?us-ascii?Q?z1afdmze3jQxAS0WsnVhIHbR3TTJ5q1afFVjVsb9gCnvlKsN9yNADyCaDKsJ?=
 =?us-ascii?Q?Nf94+tsmYnUks2fLwMhzDsHHss8gIEGfqxtMEHtJhdqt+wsuJxyzY0/JQudX?=
 =?us-ascii?Q?FzWDTIm1mJHdeODMP6KiboNmrhXfdzeGll/xVzFuVBJv0ut50lf5Iyr1PIZt?=
 =?us-ascii?Q?xo9O5ePd4SeH8L+if93NDBGfWK6yi3NRgsMzvSIIjgVZpo10ZRccik0IpnoZ?=
 =?us-ascii?Q?BkIaq+PcbybPADBcBQfOI3I42Y9WNBKoDUHfqC4rlnlMcYtbHVZYTHerj7s3?=
 =?us-ascii?Q?DC8JyKmj5KGfVMMCwuRs+rSzI8eFksNH1lCDfr49xdCMN/W/Lu187926IWLi?=
 =?us-ascii?Q?6pdtPdvJdxTqX39qHSY5sQNJoZkc58qIS6LK6W9uMYRjHm3Gcye9tFSvU8FY?=
 =?us-ascii?Q?LpjCGyoR7X5gv8xiEHU4/B1yszVLOChfVKLi/gnjQnI+qZ2X6cKn58fib4MS?=
 =?us-ascii?Q?oNyijfyT0JceV6EyKecnlPRWwP7iWPSiz6p/UWoxL5ZnuzBrQNPmrMLH29sb?=
 =?us-ascii?Q?q48O1uFke+6T+eVhhr4djo8573tmyhwKkftS8MuYG7L88qj787/wG2OycIlW?=
 =?us-ascii?Q?xx21GmoACI4wopZmCUkptV34TXw09yqA9LsabnJCQYrgW7R1ut4gatmfghZN?=
 =?us-ascii?Q?pJy5pAfOXyhBCGPVJ/Dfz6kn9aQIuZYYqR3kRfn1aHRWbGBZDejULA4M0VbQ?=
 =?us-ascii?Q?vUTdfOebzHIq9REHvNDvo7DiCmy1rjGE/bOAI7yC5wsPK89Hz6HNB0w++VuU?=
 =?us-ascii?Q?sV3Xm3POfm297n7nDPkttWLsZERaH34qtYb8CiGT/mjZBfNtjVXJZ36eLCzY?=
 =?us-ascii?Q?yXswFdgrcGUAbLP0gHkubNEOvxqggB6wJEo10azG9iRTgNaZ8dQXzD2XT3vG?=
 =?us-ascii?Q?SKMqiRZPZwpB9Qd4R5KZMPJ6Stq0o1Nf5EsXAFDJz/HrZwsfKkoixVOEpsp6?=
 =?us-ascii?Q?zDBOr8n953j6UINadYb4u1czfkf10nE9Thj6x1538adT2kfxBDLKt8r/BOjO?=
 =?us-ascii?Q?aRUHlaBvbKygiKEHq5z4+x7ISSxDe4QMQSn8bV9dQ2cGANUL63ELO0hKpAci?=
 =?us-ascii?Q?Bi6qV9VuKVYCE0cvOK6ES2F5kOXDin+PVoyHPZJBmlZYQcxkSi8GWY6mnNtI?=
 =?us-ascii?Q?65rrkiU0cpSlk5JUAjtcht74D5qWN5aWyFBKcHfQPlVytd1J0bEZohFtU12/?=
 =?us-ascii?Q?snwJzdD9exexnb9w8WR5cdSOWiemKhF2TTKv8ajCwBQdBfOx2OR/hUScflxl?=
 =?us-ascii?Q?wN0Kgr6om0xSs4DNmsZ3CMNPsF+qmBL7xFng/pWruPETsph6mbE+u41BZ6AY?=
 =?us-ascii?Q?bwDxj5SVc6wu+bhZU9Q=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c619e867-d601-43c9-2066-08dcc1fbc12a
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 16:10:20.2786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rlpAOrBFT+VmmTEPBzJRv7LajVqC0QjFjspzFlfizYWA6M+m8zYHpT5FEaD7tcg/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8892

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
index 99d15abe4a06..4d6eda1cdb6d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4407,7 +4407,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	spin_lock(vmf->ptl);
 	if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte))) {
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
-		goto out;
+		return 0;
 	}
 
 	/* Get the normal PTE  */
@@ -4454,21 +4454,17 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
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
@@ -4482,7 +4478,10 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
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



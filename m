Return-Path: <stable+bounces-66277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B28F694D2C5
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 16:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BABD21C209D9
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 14:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944C6197A68;
	Fri,  9 Aug 2024 14:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ifdlw5nZ"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2056.outbound.protection.outlook.com [40.107.102.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDC1197A66;
	Fri,  9 Aug 2024 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723215566; cv=fail; b=vAw2CneiNIatIqJ15Qhes6gU9ddom86ko7p+zH0IJa6GRV74QebltVxHVdPPJw+539ms1ztiki9rk86jBiW2fNCVOddl3KYE0q5HIHMW7ljLrxInwvK6GGnPGjAxI0Jse5WQOe62M7s4qT/ydMLXMjzgGn8SrkLrynaLnpwyqGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723215566; c=relaxed/simple;
	bh=Fz8VaNKwi2LWkmSKVb9+vIce53pqf+FOxkSn3IfM1uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XYBXi3uivgyjxPK1DxIk3avv2jAG9yYy0Ep+YoX9bnGLZPOegc0ch4DbE8jdFI4WpwL72xVyErmwg+sMbjH/KUioIvdYW33hlwitvvSAjr+tVDItGu/nkHUVpVLce6yPuyb43Xd5lkVffg1yVQ4p+cOu9YPEgMsk6+rakelCb+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ifdlw5nZ; arc=fail smtp.client-ip=40.107.102.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kNqaHLv5gNzECjF1Dp4j++PobWqNnLKnNSRXSHIZkUArNW80x7/oBMX4/c59b6UBuXW9wUNgynLKd7Xuc5sHsF7YW1YHorj9s25RjYIsJDGPb6Faph1JU9isLaVBDtVj/Bd5ihAgWGvsGuPVKQH/IePzVe8mdZFE5Eglekykzuo19K++nSShhCvyFJ4O06h8rrtrAffhHoDf9W6bQ6rvh+ojh2g9XwUOiuSkCkqfrvOMf+vF6mw7gHk4Q04eneB+gRxm2Ois41xaC7C+mpp5AYifV6O9omZW4OA6p3iOtG+TR488AIDb6GGYz4MMGFWcQ8LaKOmHpZY44gRPUoIjdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edoJuHT7gWila84psYDlaeDgJJza53cSwF1dPd/agJ8=;
 b=ACzyjykpcGCbcANyyQMmfBo6rAt7Z/xz1VVeC59DPGJ0nasTJQP4t90ihJKD9VbQ8OnWq2UciNMWpq3F5tP9d+RM3bn158j5H6A9bAwyKWjYKwowrGR46SubQhUNRKj6V28tB7sxrTmrhLQh3eJizbqMo2mEDUukoBbKE+HPggchdxOH24WftXKvCyak6ckcaUB0BvNyeekpo23hUG/rnadhBuvK1u8drMQ6sYuhResTbFqRjprqpUx6NY/Y8Mp2TEi9S+yeCD4gqWXst+pnRrnMfj/LaeX3oZaL/ojvnarJEXZk36XxC1Iqul+ZWNnU7tPOhRdRQavu16jveaC2FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edoJuHT7gWila84psYDlaeDgJJza53cSwF1dPd/agJ8=;
 b=ifdlw5nZj/Vp5u8Qoo43/xhTWmg8eRtrt+IvcffviFotbTFHBhpyzdyqnc9E1TqpL+iQCl888itNL7juNb8oFLArUGqP7QHXir0jVmV9ppgDG0lMLSfr7y/tCtxpODJzX/gDqTxmgD12rWhxBYF7StrUzn8Y2LlDuVHpYyJ9Xts9feUcHDETt+yDx1cLDaVL3j3O8TJDyrX4uF1EVG/HJrikJKaQmZx2weLwOgB40zlXq45SSK+W0bzVdc6iiW3vaKFYpqUH70odIXUwEqgz7VQyKAtVfSsmdUWLzpAuUkGdot3fFB92SSCjY/aS2x//7RPHhfN9wakT381eCxjkdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9)
 by SA1PR12MB6823.namprd12.prod.outlook.com (2603:10b6:806:25e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Fri, 9 Aug
 2024 14:59:19 +0000
Received: from CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f]) by CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f%3]) with mapi id 15.20.7849.014; Fri, 9 Aug 2024
 14:59:19 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Yang Shi <shy828301@gmail.com>,
	Mel Gorman <mgorman@suse.de>,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/3] mm/numa: no task_numa_fault() call if PTE is changed
Date: Fri,  9 Aug 2024 10:59:04 -0400
Message-ID: <20240809145906.1513458-2-ziy@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240809145906.1513458-1-ziy@nvidia.com>
References: <20240809145906.1513458-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0084.namprd03.prod.outlook.com
 (2603:10b6:208:329::29) To CYXPR12MB9320.namprd12.prod.outlook.com
 (2603:10b6:930:e6::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9320:EE_|SA1PR12MB6823:EE_
X-MS-Office365-Filtering-Correlation-Id: c2ddc1f3-7a4a-449c-31a5-08dcb883d8d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BcV98Ixm6bFTO0Y8qjsi3CJsQoguHCTzfeDNaKgbTVwaK3X6NSgedOUOgZvh?=
 =?us-ascii?Q?HfbsGxY7z1ktAizjQbL1LaBGW6vYxUjvLvHtvEGeI1j1t+dS4NApCvaTuIW/?=
 =?us-ascii?Q?pBM92nQ/QcynwQ3z5p2iR6d5Z7SIDAa0EqH3rav7yHvbzuIn8GQceTf+1jZa?=
 =?us-ascii?Q?IOn1Ti+dAgK9x3u3U2QPIHbq1BsbsjmhgYseO8Yiu5d42AvX4gks8UhtALpK?=
 =?us-ascii?Q?miacYgeTVkOInR8ssb7FZUFcg0HYDHO/cSWMqUcGbKXuQQr+Y5rfHI27yfqy?=
 =?us-ascii?Q?rpt/9A8iizGUCUl6F6UEQG5dKGM6ucA/yuwyFNk6Cmbyk0r7qUFFgzncdA8c?=
 =?us-ascii?Q?Rj5AeomZKmjz7w7v8BbunuyUTRxIzj1q9N+FFr98PuOSYtByzs/RCRK8rxOR?=
 =?us-ascii?Q?X1TxoDT4dpJs8VFpqyyFS/gXb6r7pJOEC4DSSJhw0gjsQfwkiWo6eGsFSqZc?=
 =?us-ascii?Q?ZMOcykyQNkwJMhf1hjgjqPb/CJqsE2NRkSbYdBY3sITOBsCMVeYA075yhRMj?=
 =?us-ascii?Q?mYtPlZctsuRYH00cgznAyyW87T/gWV8sBNjuf136ar+UMZ/NO3PRIN9yBeoW?=
 =?us-ascii?Q?Iy50Ry+hkZvlfMEOpDBsvv+6dPmqlpQz8kCneX8Qv9BIFc4mKJPCW1mfWNkx?=
 =?us-ascii?Q?U52Fdk621aWFT28rsj5yx0wjsmOv4FBqvt4VkQ8amND7smBRdsVzb0ZeT6vE?=
 =?us-ascii?Q?j25VSmZ2yHt/juq/+Y0nyx/ZgwHmP4+wv5SfHSjDHc4w0Q/HrBxysI9ImSnY?=
 =?us-ascii?Q?zBm/bY6NivAsUh3cs0cpvNiarFeEj75S60fvZX+aOr6E0ISyzRk2+kkKIseL?=
 =?us-ascii?Q?7a7WuKur31G2EfcZaODGkJ6kSGI1c/ma0rxoMD6Q/e30CPVJmtGxX+LoT2tE?=
 =?us-ascii?Q?FLKIOLqPLHcU6m6UQIY+5xJbxMcz7D6lS+yomGCmZkUSAYjPnDz1hE7rMTav?=
 =?us-ascii?Q?Rg0+CCcbjdm2QHmqSfuTAT/W1gu+fcHXDUq6aYCpgcmXdUcNtL3l4VfTSkjy?=
 =?us-ascii?Q?ZUmF7TiIRzOnycl6Zue12gisIx+7C23BzMMKfWyee5bf/hF+aYQbduyIzuA4?=
 =?us-ascii?Q?9A2ItYfG2L+ek9W8JCj+Z58UmbfWOjo0ljmLSdeixVTmkIC2wKnDEtpM50dy?=
 =?us-ascii?Q?TtdUN1VSYAuemSvfLnqMDVlGAyntvbFDPtXmirNxJqQWpn74DTjIpgJnAWHC?=
 =?us-ascii?Q?0oJsYjA9z0P14D+IYsggBUbnx8HPUbjfkogc7OvEY9XYugg4tt+TyTT8saEc?=
 =?us-ascii?Q?UWJTdDKD9+v2IFR3rBXM7CHP2Zq8XzLwUFTsdUp2P2L8rcPMWdQnzpcKp8Lz?=
 =?us-ascii?Q?jJDvd+SNWgFeWi7SQbjvco3FkJAzP0I1suELMKreEXu8dw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k9Wio8SjiAzNpz3xTlFaNsXwl0I3SXEqtJVuL4ymN2CbmrzpGmjxvf7RbDrO?=
 =?us-ascii?Q?OLyMPafd38dL9U9n6Kzurc02Y6r2TjqvV6CbNK7ehNLIDBeBMyyaQpSFZlqU?=
 =?us-ascii?Q?UfrTG7xaDilVXvHCxmyuorbnED3K+tk+JRRliLs4JWpN9oANHvwgSCeTWO/G?=
 =?us-ascii?Q?SVZXuSykacaSQskMvh3OPELJz8UGyqgz+m4ia7D1vO38DJ4tRSF+F9lGL/8f?=
 =?us-ascii?Q?bzik3mdcoQlxgGUUyqEQEl0G9IB6PHMGH1WROqjXpk8h2IPQoPTPU36g6I0w?=
 =?us-ascii?Q?DrlM8AujO4lgYGekSjOGIWa0Cd28LyytgPdujpWK9lNKzf0imUCsPyDeabcC?=
 =?us-ascii?Q?Nw1o7BPYvFV9waAA6J2LL46+0wVMd36Z8mh0QMc5xaIUqfhiye/Sv07VLtCy?=
 =?us-ascii?Q?4fugxLeJQKrkGZc+6mFf1thVv2o54mL/5NQqPo8lfKdfZShscD6asBYjefKJ?=
 =?us-ascii?Q?Kb0vI2RgJ22//MuD0NhcldsnsRZPCGUJ7jA8gg6Q8u1BskSsGlUyH6N5bhC5?=
 =?us-ascii?Q?4/v4VOj6EC+dmgQAsgTtwTtbfWzX3r3Y7vXLc+YzsGK6dqS9lhmh9jRZN2DI?=
 =?us-ascii?Q?Vfi6943in/A89wpuJEccAvwYWcsfvXTpbhSEbTXLYBD1DVILgLyOiHXbQP4V?=
 =?us-ascii?Q?X9uhA/Pj7KnW+HOMBft01pBwJlXLoEBWNai4U3ZevuVZiEe3olUSvrb8Lk8m?=
 =?us-ascii?Q?2cg+1Z8VTt5j7fserfX4JiLep9xHqedtKJNPKT9le4mtohGqO6LMba3Okpfr?=
 =?us-ascii?Q?hpAnY4WZZ6HQu55D+S4dn7COTb0wNstTn0+yKE74WmRn5R081u/A1om0MQQe?=
 =?us-ascii?Q?9teH5vLL2fyGcbHyeCg54SjIYt4KftJGaivS+4gphus103WIPD3Ueh9QuCcf?=
 =?us-ascii?Q?2s6d701e5lF+7S+iIs2yYks9SDzDhVY724vevFnqzQ79O+JWoEtQXGOnsHz6?=
 =?us-ascii?Q?nBNo5/E4RCMVJeUvFelD/zMqBaiLdyeBsQKGBcCCUQBF1s1IIe/P9KIzJ0NZ?=
 =?us-ascii?Q?fs+fvlhUfUEeHU+JXA53em3GSVrJA+c57o1dnkGeO6CPxJWUihrcsnEzdSp5?=
 =?us-ascii?Q?l7PMa6d114TxwjN4Vuuujjv/ERzUF37eK8A3BupvpPDT8Jqkhc0VqjiJ8UzP?=
 =?us-ascii?Q?ErpKzsjcpfddcD/elBDA4UlG8hj5slOO2kdeEbGZFcHxoYTTgaydRLX6hueF?=
 =?us-ascii?Q?sFLY2wBd+AWAcMlFEf4G/LTNbbjolP/F+1y4nCo5th+p47KZNxbrfw50uYKn?=
 =?us-ascii?Q?Uz+AQjbrMnzXWmfQtHZ8ugKYmK3XkfqpcNtx0DF4ulXW5S6BPcUSHFCOBHBw?=
 =?us-ascii?Q?ltjtInRyRym2XXhLPpatxSEr8svxVaBSgstF/mFJ9/Tk70vER4hzIWBsKBNy?=
 =?us-ascii?Q?IemTNEyHdwOep8KeFm1SxUpVin2AuC8lR7CuBLCmSeoD2KSqXexZwKK3B99s?=
 =?us-ascii?Q?WZ1LMuuhpByU/XxQu0leu+GfzkdkFqGeDVGXtIn6nm3HR4Y4+KndtqxwIqw/?=
 =?us-ascii?Q?WyG3x+HI/Gv6VwHUPAEh0hpFhvMdfCBFW3CBTKjVj5wmI8tI5Qp4mmZuZjEj?=
 =?us-ascii?Q?izAeikIk0DhHiwIAkBJNy1FdKjIvzgBXlUOKD41W?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ddc1f3-7a4a-449c-31a5-08dcb883d8d7
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 14:59:19.9173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cNfpbJyV7zMWue2Usz7z2XcTFv/g8gJpnoNNEdg5+ojbST0y2+BcUR8jTgYERrP6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6823

When handling a numa page fault, task_numa_fault() should be called by a
process that restores the page table of the faulted folio to avoid
duplicated stats counting. Commit b99a342d4f11 ("NUMA balancing: reduce
TLB flush via delaying mapping on hint page fault") restructured
do_numa_page() and did not avoid task_numa_fault() call in the second page
table check after a numa migration failure. Fix it by making all
!pte_same() return immediately.

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
 mm/memory.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 67496dc5064f..bf791da57cab 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5461,7 +5461,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 
 	if (unlikely(!pte_same(old_pte, vmf->orig_pte))) {
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
-		goto out;
+		return 0;
 	}
 
 	pte = pte_modify(old_pte, vma->vm_page_prot);
@@ -5523,23 +5523,19 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	if (!migrate_misplaced_folio(folio, vma, target_nid)) {
 		nid = target_nid;
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
+		task_numa_fault(last_cpupid, nid, nr_pages, flags);
+		return 0;
 	}
 
-out:
-	if (nid != NUMA_NO_NODE)
-		task_numa_fault(last_cpupid, nid, nr_pages, flags);
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
@@ -5552,7 +5548,10 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 		numa_rebuild_single_mapping(vmf, vma, vmf->address, vmf->pte,
 					    writable);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
-	goto out;
+
+	if (nid != NUMA_NO_NODE)
+		task_numa_fault(last_cpupid, nid, nr_pages, flags);
+	return 0;
 }
 
 static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
-- 
2.43.0



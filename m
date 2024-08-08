Return-Path: <stable+bounces-66034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6268594BD46
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 14:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1D55B22C74
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 12:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3359E18C33F;
	Thu,  8 Aug 2024 12:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="TyQ/56Ud"
X-Original-To: stable@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010015.outbound.protection.outlook.com [52.101.128.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119041891D6;
	Thu,  8 Aug 2024 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723119647; cv=fail; b=IrR7l5G/SobsYinu7ACqLXSk/WE2Tw8NAmE7kYjkqpwPaR7kadryBCP4tIuTSU1Brq37w++kcnpKgxG/CT0mvjvnBZA2Idw4OiwFD3eomXEkB3NKj24ezNfQdVMQ+TK93Yf6E2pu7Hi8sPTbFRMQrZV+CIDE91WETFMFu7viooo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723119647; c=relaxed/simple;
	bh=SZYQcrtqjOIMlrAwhqi9PVgZgtSsYBQm34woqYq8EVM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h6HScuZXKFRwpfADYu+FZwG6YG9x4Y7LK2MRivJb7pQG9Jq3pEPhY3SLugtHd0gyyQdGn0hlFJhJ2CbBOV3W21W0FXDWRDxyIgcAzPznwEFge7rrKAJt1ZBpDYWnvkHJC8jQcVFYis2IfEDspz5q2QPHBGHMc7G9WjMzjx7mKAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=TyQ/56Ud; arc=fail smtp.client-ip=52.101.128.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FM2uyhFMEl0C7zLkxjoMSLQVmFMfa/JOe4ACWnVE8U3XBknvg6+Ol1yxC+kbCOQUopWtO0kRLl2waHdc2z30ZoP+9tl4ZyMLvyQtjljyCb6E/HKuH+btG7e8WQNpFcBCyFTsahwsVeyk9k9Bi2SvEoJKmQJOxjSpy2xKOQ/32jC+bz3lukTTc5k0eA6KxJhyTubnGL+keW8UZ5WsvGxON/L3pjMrKy/oEegsBtTSpCAXzVskLckYfYNoZWALFQj+3hLM8WTZn5FHsY+1MnJmxZqdFWeJXUir6U/lEez0JANaU6r2xKEWwbyCa+5zzSYLFdbqYtlqQPf0huznhOcnOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFRQ53R+djKUPnahF0yjTjjJJyMEoANp+bquweFGGvI=;
 b=zUXzQbyVOjLdXGVFAymkUEpTSvJdX280F1M96kC/YemzY9b962fwnJjPRP6HgtEcHA1fVz4BJ2btq/3+edBA3lDrFDoWokxsFz3wg7qlhzQvNOUan5llEBoVoSyUmIyqoCzTnecPTbHXbygaHyamEjqQFNZxZXSoWs8HvjHLpNErEfL2o2eLsexYRzPmw+O6x4nOvaWRQeK4Sr8UAEM/t6Y9oJ58YbCOf/tgb4DGuTGylZt3DN56qlo+O6svGrooLQ0M95xjkZ56EQrQq/FvS4WZxMXMxFjGRrmeyQ/hpb1FAWzz0lXD/1qo01jzxk2mhKlxaFDRHGx+ACFr1novPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=oppo.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=oppo.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFRQ53R+djKUPnahF0yjTjjJJyMEoANp+bquweFGGvI=;
 b=TyQ/56UdDIPxMBfkV3TwGX/TkRpb4GGo0EHRSrJT7xo/5VtRYO/WGYq1t0sBfQXi/H8tQaXbxHeQ7soLSNbn3wAiKVjbb/W3uJCz7h+naEd35QVxFBVjj2MjGZ7Uu7Nxb2s7TUmmZoyOOcwMgmOvXkxmKOzk1LYfEd1Opb/4fXQ=
Received: from SG2P153CA0041.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::10) by
 TYZPR02MB6222.apcprd02.prod.outlook.com (2603:1096:400:282::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.25; Thu, 8 Aug 2024 12:20:40 +0000
Received: from SG1PEPF000082E2.apcprd02.prod.outlook.com
 (2603:1096:4:c6:cafe::5d) by SG2P153CA0041.outlook.office365.com
 (2603:1096:4:c6::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.8 via Frontend
 Transport; Thu, 8 Aug 2024 12:20:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG1PEPF000082E2.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 8 Aug 2024 12:20:39 +0000
Received: from PH80250894.adc.com (172.16.40.118) by mailappw31.adc.com
 (172.16.56.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 Aug
 2024 20:20:38 +0800
From: Hailong Liu <hailong.liu@oppo.com>
To: Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki
	<urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, Vlastimil Babka
	<vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>
CC: Hailong Liu <hailong.liu@oppo.com>, Tangquan Zheng
	<zhengtangquan@oppo.com>, <stable@vger.kernel.org>, Barry Song
	<21cnbao@gmail.com>, Baoquan He <bhe@redhat.com>, Matthew Wilcox
	<willy@infradead.org>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH v1] mm/vmalloc: fix page mapping if vm_area_alloc_pages() with high order fallback to order 0
Date: Thu, 8 Aug 2024 20:19:56 +0800
Message-ID: <20240808122019.3361-1-hailong.liu@oppo.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mailappw30.adc.com (172.16.56.197) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E2:EE_|TYZPR02MB6222:EE_
X-MS-Office365-Filtering-Correlation-Id: eb268ca0-7ceb-4bd9-b103-08dcb7a48418
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xy/ez0pjFqDppU5akyL7UG7eRmCsE45/mwWQNisZTyJK6x5pMCoBXQ+v6AD4?=
 =?us-ascii?Q?tiJ1UoiBD3giZVd6BLrqZ8dZrRJ20l+h5j30etj9TjI9j18ekP/IC5mJt6Zl?=
 =?us-ascii?Q?52cD9Lj4tvvOH76luwBDJPAF74lf2yiWs10VLt20Ils2d+zrFH0jaD9LaDhZ?=
 =?us-ascii?Q?MpBiO5aPI4EVOdtfMxi5XWG06bV19kSbt6L0pf3WcBDx++bnTel3RTrX5gmO?=
 =?us-ascii?Q?59dXnGIdh46S7VJ5NXIRUZwKnjh1aRHoY4M1jQ95cChHyI2FiU77Pkih0ON0?=
 =?us-ascii?Q?Manakzd2bRPbohDaP89jJjN5Jev2Ncr+/0NvxYJClZr7U0++2FmmPxH6FPQ4?=
 =?us-ascii?Q?6NM7IbIYsBVpdeeP1YCvu7qSiRlURQmBJCuYpGCqFPM7BghGQ3sXWG42cSig?=
 =?us-ascii?Q?HeyqIrHdWMMX8lNsZH4TkpqY5NuO1Cavcg9RKBvBVflClhqu0koi9Itx8Z1b?=
 =?us-ascii?Q?wOevDHPIq2HWTk/RS9rsXPF7PwLK9PZS0nNGC+jgOXdl8jabd0OzQosDI5BB?=
 =?us-ascii?Q?EZVBwpg0sT9FVTYvkIxlyVoLeg9shV5OwfdY4vfu+ghoHK8pbefsavg/CscV?=
 =?us-ascii?Q?rDOV4I78ObRDQzjekDJM/ChrRefJAba8bl1vtjj6sm4n3w1rhM2ooeBA8ywg?=
 =?us-ascii?Q?SfJvPdHjg6+UNP2nXeERxux2bpduFATDYwzwGrFLDR+pYH54DpWFayRCLByC?=
 =?us-ascii?Q?eOSP+sXn5jC8K6aGebJTCsUSkqlj+gVOis5UIPyUteyL1hFutcc2nA42pp9c?=
 =?us-ascii?Q?BfEQpZ4DfIqIdZjozro8nG2FI3504rYnGnVsh2WEzmOXcRZrjBK9CF15XJQ0?=
 =?us-ascii?Q?v7p3I4iDma27UttJ2m/tiNYPRPzRUmdcHUq5GYtdvXBv9IBRuE//P9qVVubc?=
 =?us-ascii?Q?LhKiLwpPNrY2rep+fV3xGAaxDxvJsVsQwBjEUo2v5c8j/bS83INCpX87rYUD?=
 =?us-ascii?Q?ugZXJXTM3jyOG08OHkN8ttpZaG7Mle79zqc9mAYaGDu8/SjS821dDsU0NcOf?=
 =?us-ascii?Q?1S/wfZS1O7D1nVTbQMOSoHaxCZLyXQRXPMsPaBaqs2PZ+TVLL3owCh7XrSqO?=
 =?us-ascii?Q?ZqkWIPAUN+oXXunpGpr0ieWb5PuiAoqJCHfU9pOLOpzpBtewJcWFT0nD9ct/?=
 =?us-ascii?Q?XUpE379UkW50BGeZeXZteZU7Je5rTp8YJgbp5asHB7DCcYk19Raq80gIjuOT?=
 =?us-ascii?Q?RQ8Y+SJfnbA/HstQR5RrbcFTgkSqtjwFi8aJutvQIcD7acfRZvBfosq3eCZh?=
 =?us-ascii?Q?M9r774bJ+Xzv6ZMD4feyaFVCPgh7c+XBOPbERGrM4rh4XlObSckNNPgnKA03?=
 =?us-ascii?Q?KAo7pFA1uGrzwFjoYGgOm9RkqYhNQ3xGHSgaYuT1ZNqT6NpiBMTBtdrDD+rF?=
 =?us-ascii?Q?7YAf4fZNLOf6G2Q1Lhi/Wv2NkQEei8rPGGv+FqTzLF7HeP/Kuw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 12:20:39.7560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb268ca0-7ceb-4bd9-b103-08dcb7a48418
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6222

The __vmap_pages_range_noflush() assumes its argument pages** contains
pages with the same page shift. However, since commit e9c3cda4d86e
("mm, vmalloc: fix high order __GFP_NOFAIL allocations"), if gfp_flags
includes __GFP_NOFAIL with high order in vm_area_alloc_pages()
and page allocation failed for high order, the pages** may contain
two different page shifts (high order and order-0). This could
lead __vmap_pages_range_noflush() to perform incorrect mappings,
potentially resulting in memory corruption.

Users might encounter this as follows (vmap_allow_huge = true, 2M is for PMD_SIZE):
kvmalloc(2M, __GFP_NOFAIL|GFP_X)
    __vmalloc_node_range_noprof(vm_flags=VM_ALLOW_HUGE_VMAP)
        vm_area_alloc_pages(order=9) ---> order-9 allocation failed and fallback to order-0
            vmap_pages_range()
                vmap_pages_range_noflush()
                    __vmap_pages_range_noflush(page_shift = 21) ----> wrong mapping happens

We can remove the fallback code because if a high-order
allocation fails, __vmalloc_node_range_noprof() will retry with
order-0. Therefore, it is unnecessary to fallback to order-0
here. Therefore, fix this by removing the fallback code.

Fixes: e9c3cda4d86e ("mm, vmalloc: fix high order __GFP_NOFAIL allocations")
Signed-off-by: Hailong Liu <hailong.liu@oppo.com>
Reported-by: Tangquan Zheng <zhengtangquan@oppo.com>
Cc: <stable@vger.kernel.org>
CC: Barry Song <21cnbao@gmail.com>
CC: Baoquan He <bhe@redhat.com>
CC: Matthew Wilcox <willy@infradead.org>
---
 mm/vmalloc.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6b783baf12a1..af2de36549d6 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3584,15 +3584,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 			page = alloc_pages_noprof(alloc_gfp, order);
 		else
 			page = alloc_pages_node_noprof(nid, alloc_gfp, order);
-		if (unlikely(!page)) {
-			if (!nofail)
-				break;
-
-			/* fall back to the zero order allocations */
-			alloc_gfp |= __GFP_NOFAIL;
-			order = 0;
-			continue;
-		}
+		if (unlikely(!page))
+			break;

 		/*
 		 * Higher order allocations must be able to be treated as
---
Sorry for fat fingers. with .rej file. resend this.

Baoquan suggests set page_shift to 0 if fallback in (2 and concern about
performance of retry with order-0. But IMO with retry,
- Save memory usage if high order allocation failed.
- Keep consistancy with align and page-shift.
- make use of bulk allocator with order-0

[2] https://lore.kernel.org/lkml/20240725035318.471-1-hailong.liu@oppo.com/
--
2.30.0


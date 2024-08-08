Return-Path: <stable+bounces-66032-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 519CD94BCE2
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 14:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74D981C2254C
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 12:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04FF18C333;
	Thu,  8 Aug 2024 12:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="O4oD9/cR"
X-Original-To: stable@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2068.outbound.protection.outlook.com [40.107.215.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C7A156220;
	Thu,  8 Aug 2024 12:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723118701; cv=fail; b=It9jxisSNZn2lcnIHVg54SLJlSANJxdM6nMqZ2Ytm8u9EViODS4tvfMg44knid0mziOohsE7TeXbf8rYzh1rCMnTa1gylHea8mq9CQY8LgqoMYBOwjW0RfYhTvlZr38oj62VXxYPP+8BlU1lMzrBAWm3DR0pylhulEX/Q9DgOLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723118701; c=relaxed/simple;
	bh=UVw4J33lgHRWfH/j6TiiuwtuhK6HTPyQ85MphdVrlXU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=il1KwDcc/a9+DqUdZN6GrHfJ/ZxVCx0aRQ/FdgovNLba0UWVGNCEAteznHmwXmAIeCxoMTffbK2437eXzi396h4cBWT8x/Eo3sIMLYOZZqsfz8q51tFzqiO1bk+ugL47SGlgrPO4RZQfhAz32Jj20qE/LGvhyzmpJnP9BIGs2+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=O4oD9/cR; arc=fail smtp.client-ip=40.107.215.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C24e1jiAga1DTslTp+sOwT4233wUObY3Ek4MnL4jmWOrZVlUKXVnqWS5+NrLcWz+HqNczb06OYHlkePMXTqkOWxFJl6iswHZBwczXhrXZF9LRrQsYQsP5NIxJWkLShRHD5Ji9J2GEsjqzmMUkp9Mgy3uMBYK+LdNRupyo0sYnUIj4k0UBXNWkA4YCJPQ0kch4+Y+HXB6uPBM1oUsJUVCSOXd03FurAQPe8fljZyT/rVCzHNJ3lmmjUcmUj/lA1VMyW2PnlXGszwacybVHEjL7H32b15RxCxcWJ3/3/2uyz1h22OJ786mKgW50DzsN7P1QT2wH+6RaEJDHE9wD4J6dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pB04DcauAbecGVy8g53NxBIg84tdNR6Q/9aYmUVv9cU=;
 b=reqJXf6G8zNH27vM10ilUQ5BOPqsyHugRBlvVoIMegtjf83NkkecIIq1wV4MPLnjwJaEq5+Lb/cQMJTWgtnfYflVMZmVf4pPuBQAJTLZF/uKhDoNricsgJVfDp900kIlR32k5c8waYUMDvgSG+PsxB4EPJTtR7LLAxiUH5fxv0Um1InLVWg9yveGdtttPFyGvequXnZR5PRZ400Yle/kse4sYaOhCfUA4jesjxw/iP8hHnKIss95suXE5GhAwWm+cEWLOgwh4X8H+uqTDtRuQ4XAO0NP44WhYmxb9mA3d8YlWOXAOXspAvDBUA9smb4xrA5p3IXORDsONa8BOlG0zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=oppo.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=oppo.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pB04DcauAbecGVy8g53NxBIg84tdNR6Q/9aYmUVv9cU=;
 b=O4oD9/cRpOGinO/obKTQXtFuk0BxsOzgehJNAdvGAI5hHyg94qRKzskxnSu7C6juUGLBhWZoIT8fLw8M2ZIP9ENU1Xizuwm0MLOilIuUi81zAfpwWIhxLnoSYo/+PMDuALlcJ8hFwQq5I/zizxc0d56Q9InG5AmSCXELvf+pXCA=
Received: from SG2P153CA0051.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::20) by
 KL1PR02MB6610.apcprd02.prod.outlook.com (2603:1096:820:115::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Thu, 8 Aug
 2024 12:04:56 +0000
Received: from SG2PEPF000B66CF.apcprd03.prod.outlook.com
 (2603:1096:4:c6:cafe::ac) by SG2P153CA0051.outlook.office365.com
 (2603:1096:4:c6::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.8 via Frontend
 Transport; Thu, 8 Aug 2024 12:04:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG2PEPF000B66CF.mail.protection.outlook.com (10.167.240.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 8 Aug 2024 12:04:55 +0000
Received: from PH80250894.adc.com (172.16.40.118) by mailappw31.adc.com
 (172.16.56.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 Aug
 2024 20:04:55 +0800
From: Hailong Liu <hailong.liu@oppo.com>
To: Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki
	<urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, Michal Hocko
	<mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>
CC: Hailong Liu <hailong.liu@oppo.com>, "Tangquan . Zheng"
	<zhengtangquan@oppo.com>, <stable@vger.kernel.org>, Barry Song
	<21cnbao@gmail.com>, Baoquan He <bhe@redhat.com>, Matthew Wilcox
	<willy@infradead.org>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH v1] mm/vmalloc: fix page mapping if vm_area_alloc_pages() with high order fallback to order 0
Date: Thu, 8 Aug 2024 20:04:23 +0800
Message-ID: <20240808120445.3150-1-hailong.liu@oppo.com>
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
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CF:EE_|KL1PR02MB6610:EE_
X-MS-Office365-Filtering-Correlation-Id: 51fc52aa-790c-48f8-a0a8-08dcb7a2517c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6JvTVSpJxpUE/IDmeoGjvwA3odecFmym1YE0UMh1XCYNfWxJrNinUsZ2EXvd?=
 =?us-ascii?Q?uXOwCkPrJnugfL8xihma748O9nrh4tzqRJgz4X8OFsWuYq5CfY0fyJAkVMb3?=
 =?us-ascii?Q?0NcqdQCb6rXemMuqoQr3NopYrxvuOZyMa6pZxMjYWNmVpZKxh55VSmq0bSBo?=
 =?us-ascii?Q?m1IfnQb6HXgXHdUkhhg6QXLLQl9AOcfB8eVfD9vP/oXeztSqyuksWSDgvHCe?=
 =?us-ascii?Q?KJcmyTvFXOoy5XhKEz3ynxkvd7kAtHAj9T9E4NmLIcqs7hVBfg4A5ORcllmj?=
 =?us-ascii?Q?E2SY5irZG5lmdDEF0cXoDEqlTz94vMKaThhwpp/UeuCa/AKKabqtzNV6L5OM?=
 =?us-ascii?Q?FY5WD0kfePISCZwQX6AuqxX9heGwsQe1RYqbzZM6m5ibVWeqcdJw4EW0tkJW?=
 =?us-ascii?Q?le6xKOZNJMEZ9c/SNA2ANkN8LyJE5BMghU2jA9cEwtrviSvU8orpzG7A63Cn?=
 =?us-ascii?Q?qfrIEiPV7H6PC2SHLwaPBxhIWNjsjIYxSSHvO8kWWEH7Vgx1Be+RhuDzl2Of?=
 =?us-ascii?Q?C/DwrV8pOJr1Psc9Zv1QR8heU9P1Ap0a+bFEwk/jX1KFknsqbkPAMLFTGjp9?=
 =?us-ascii?Q?qGDUBNeM9pnhSjCpGEgrrqDV33BXpX/for15dON/+vTikXPQ1THQOtlpZBSu?=
 =?us-ascii?Q?9QLgj4g39pMtezAhh58wrbczSck3mNzr8YMNcxywGu8fNe78s/Nm1mdm6+oa?=
 =?us-ascii?Q?0hqFGsgwZ3yoqueiJ7JY1OEEcrOsCSZq3xCbwwh0drFg2cKcGQQvNdO7ETV5?=
 =?us-ascii?Q?jIvJA7l9O292Kg37bbW+/247fSGw02pexfwwtLDEip7HbSXYKddp9aBLFRNB?=
 =?us-ascii?Q?Ncf/F/wQoBAYb+3N/HJ2Aksy4dgCRjLUqxuC3r2CnZQIT2y6j54uOapj+7k1?=
 =?us-ascii?Q?qZj24fWO49A/AcM2i5Feb0x4ASTLM2xz/U17+xJEheToSAseoqhk5bWfnRVc?=
 =?us-ascii?Q?aGcyeKtsUHnMmNto2dOQSwuE4KFX+XN5zaiVUVFp1+yD/FBhjuAH1U4weizT?=
 =?us-ascii?Q?kr0BIfwViLEKYvowPsuqAms3jEklvmcbqzMztgBlTzaELXyBO3LDwjlSw5J3?=
 =?us-ascii?Q?cN2GjsMitDWVxh9YMvDH1pdDK0v0NUuyTN4gN3/d/ZfpagCV1T0Gn9cgQ/Gh?=
 =?us-ascii?Q?Z/jsGOsjFlbIpSYWZfVjzzAo0o/tsztzWTxbFm4Ci4qeqbanlhLnyUiwxtZR?=
 =?us-ascii?Q?/qIYANuiCs6bsol78C84zDSsm/qhWvUF/UgaIFQodnWxh9CjBlfTMHq9KGzO?=
 =?us-ascii?Q?Eo5pea4vj2VcdBprM9brbZ0j7luMQOmy6gwT0c/Slmgri4gmPw+Q+DD8Jc/S?=
 =?us-ascii?Q?Rn0wioSZG0yBV1CRyVDf7yE9h8CB4s0IavzOVF8aJZPZ8jcvVwu89nuZg4tu?=
 =?us-ascii?Q?cMrGO/2CKcZBUzMBu8N1iQWC4wKNtJf7PzRPPOobm6t+TsCIRQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 12:04:55.8537
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51fc52aa-790c-48f8-a0a8-08dcb7a2517c
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CF.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6610

The __vmap_pages_range_noflush() assumes its argument pages** contains
pages with the same page shift. However, since commit e9c3cda4d86e
(mm, vmalloc: fix high order __GFP_NOFAIL allocations), if gfp_flags
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
Reported-by: Tangquan.Zheng <zhengtangquan@oppo.com>
Cc: <stable@vger.kernel.org>
CC: Barry Song <21cnbao@gmail.com>
CC: Baoquan He <bhe@redhat.com>
CC: Matthew Wilcox <willy@infradead.org>
---
 mm/vmalloc.c     | 11 ++---------
 mm/vmalloc.c.rej | 10 ++++++++++
 2 files changed, 12 insertions(+), 9 deletions(-)
 create mode 100644 mm/vmalloc.c.rej

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
sorry for fat fingers. with .rej file. resend this.

Baoquan suggests set page_shift to 0 if fallback in (2 and concern about
performance of retry with order-0. But IMO with retry,
- Save memory usage if high order allocation failed.
- Keep consistancy with align and page-shift.
- make use of bulk allocator with order-0

[2] https://lore.kernel.org/lkml/20240725035318.471-1-hailong.liu@oppo.com/
--
2.34.1


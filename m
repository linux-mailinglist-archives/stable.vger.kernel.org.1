Return-Path: <stable+bounces-179255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B991B531D5
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 14:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8034358739C
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 12:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15BB320A24;
	Thu, 11 Sep 2025 12:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Mxs57s9e"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9526D3203AF
	for <stable@vger.kernel.org>; Thu, 11 Sep 2025 12:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757592913; cv=fail; b=gDNicxkPfpwOOno7dbBQ0gdlo6Cgt1jHgVlW6jDG3K7vWDMtM6VouUqBd2249ePff8oIE937WA58fawoTrvCKMuEfM94RgSCWhuWINpU2k70D5VtIu0VJ0DI4IIKUWQrITjoSDH+sVBMa7vx7U+Q6fbaaM0JwzEJKxoajU3hPRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757592913; c=relaxed/simple;
	bh=R4G7D1wHD3KKKvmp2tRPTGwNQKY/dhMKJzaQPnafuRY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mhZPlMgytvEpV3/pAxhas8nXiX3oCk++9/b8c8zMmEJcgqxd9HtWgqSn3YLDcYlk6foB7XsVB03fnlMJ18DHh8JggdP5ndzxixvomNdxvnhn58HqojqRgjAISVWij/QVOLs+nJ/sxAwyezTNsQFUMlyEOINYVYlUbtDzYdgIKkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Mxs57s9e; arc=fail smtp.client-ip=40.107.237.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=msyJyvJAWRt1Ld1EPQgqB/7v3W6RsbaDxS039m90iA42GronnK8o07GTAxFWD7pU1PGG2oj/6qu4x9d+lQHnkzwf5oANIswF2BM2XT/bVivj1WhaVgndKaEAP2hv5V/Qqt59UtnnBtzAthIziv3w1kDo6DEdasvn7kiYeHDkiJ1Ey5c+ZYjlCiNTx7L/7nYldk++YngA++kzy+Xc42WjY0vZXZnSJ7/kAAhHwV7Cj6D6XZx9J4Lp+6nGGJJoa1vWJtqY6IDq7gCdeFcWt/ats7LDNxxVJa64LKSGHyn+nme+pkkMeWaEmiHOoe+CTpdtzeAiQ5g70y93jOjBGpcNag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pf22lSQsB3gX/ny/lF65ct6eyskFkg37qKSjH5hIPQY=;
 b=mMfVHzbCSYdKXO6H4ZlTZwhDWTDFG3IeGe8xzA+HHlTJdWIPYAkuP02KzNQ28LLmaUGv8+UxpGiRdx7YykYyUhtKzSCfmHPHR4Zj/+obrOombCl2yhEP9mK4kYYbeB+bDg3cJWSUDHqf+Fw1dsHP+yQBY4JXCmMFYfpgwZubCODrcMuepPFu+tyw63EhEefm0ofDSjHsPAX6Voki9QAlSBtxDsFEA5sY7Q1nu2LdliTOz5fdusRgQT9wPZTQqwr19SnNuTwvp5uoxUft2BUuyocOOqwa0dJZ0tozNlQA438cIccc6Orkdyd2NN9mKUda2C9tWwTheHdhicR07ZC2xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pf22lSQsB3gX/ny/lF65ct6eyskFkg37qKSjH5hIPQY=;
 b=Mxs57s9ejYq4+X1mOobpQzZTtdZ+IDkXAvV0uDbgXH3LC/slYndGmkUGH1UCiMJe3jaljP/jBciiutgOnLgVTfDdtiwxZwtCehhDiH7bWEAUq08K8yfcKsrkwt8fVjgsKNz9D7LjP5xoAgPDGVIAFqFCBSTZfMVoc+9HnTd3qnI=
Received: from CH0PR03CA0022.namprd03.prod.outlook.com (2603:10b6:610:b0::27)
 by CH3PR12MB8547.namprd12.prod.outlook.com (2603:10b6:610:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 12:15:08 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::74) by CH0PR03CA0022.outlook.office365.com
 (2603:10b6:610:b0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.23 via Frontend Transport; Thu,
 11 Sep 2025 12:15:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 12:15:08 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Sep
 2025 05:14:58 -0700
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, <stable@vger.kernel.org>,
	Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH] iommu/amd/pgtbl: Fix possible race while increase page table level
Date: Thu, 11 Sep 2025 12:14:15 +0000
Message-ID: <20250911121416.633216-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|CH3PR12MB8547:EE_
X-MS-Office365-Filtering-Correlation-Id: a5deb8ab-4cf8-4dbf-f4ed-08ddf12cd992
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UVrWH1DQqj78U1qpnRIRPgJ2rC4actmWp5SzZxMtfiG0SPtX1oYgnA7Mfd0w?=
 =?us-ascii?Q?kTba6S1iBaaT4eSbm9zndeQB2Vg0UInAdRTbm6Z1r5tpdrRmsx+tHwRh0m5G?=
 =?us-ascii?Q?OAjDoW2KJaZE2lFu0Mc+bk0QyTk9SZuKSqDce+zThr3F94pzOt8S5FkHIBjM?=
 =?us-ascii?Q?knJWbuESZa2S+JLTwCZOP0zlALd+PsRx1GeQtDk9YUVYjAvoY/dsGIYYqNZQ?=
 =?us-ascii?Q?NNt/PQTmcSlrfbhm2CWqhtPcznhAwY32ynoJAj8oM/ZVN3koSkpjvQdVy38Y?=
 =?us-ascii?Q?ewCQ5+W0/BeN1oNTy/Ae1B4ffppekLGe7uUPdmz4URlmoqMc/Kb+6JkI+PlP?=
 =?us-ascii?Q?kakgxxowpw/oCN7raBBU3L0bAqxlrXxGtjZ9o/8NXVhqFEbB1v5xrYeAmCnW?=
 =?us-ascii?Q?y1RWGlgAUqNA6q0l/99+lnNLaWVO4DYZ+IUcRVzBzHKTQU3adfz7ORmAA07d?=
 =?us-ascii?Q?Tn/SSUxKIhkckpgaQlFUMTTr5yKKKsL0t9WUdbXj0QZj8VsKFBk5EgLoUtR1?=
 =?us-ascii?Q?iI0uGS1fTo+ghW7u9IChyQuqWUjzKMMXwjodGOU6xzriRj9R6H32slTtgQLs?=
 =?us-ascii?Q?q71ZXaQDgxDcJmotF+4cFHwk5ovFXaIrjVj7E+WijtjRFEca9QQFXM/ks6tH?=
 =?us-ascii?Q?PV886QGhe9Bopyp/ZUiWTkklDD9xV6yICLkB3ZEqyshdcYu48XJLd4n+Oi5X?=
 =?us-ascii?Q?yZ6q313lCtJL59Ni76gKJjRzNvnFfD3eEbkYlN8wKrjDfkWMrjt1vOACmD7T?=
 =?us-ascii?Q?3Y5Fj/iHNdJ3gkIvC+luhbbKgol4r63nwr6El6HalGKkV7+UZA+yhYs4yrlo?=
 =?us-ascii?Q?1CFMF6zRbCb6x4cI5yzvOIP7Zw8HW5Xj0e3L7tlla57KAj/YHh+lsZwjCgRa?=
 =?us-ascii?Q?mZ+WWKTw4LsbRyyR2xRz47Eitx6OjCQGtgMcU6YDafDgPhgr2G43PpGyIVO1?=
 =?us-ascii?Q?/BMT9iat2vYXAUJSnHv49GmDcDpMMsEgCR3XPCjGQ7MWB/5Dta7SoLUXt+XC?=
 =?us-ascii?Q?01LjXik0ZLWa3nd34v5ZcQe2NKN5YVMAzxGrLarEJUvRb/wIMkLRESc/1Jdg?=
 =?us-ascii?Q?ZugQGAQVkjmw1CZCVD0R/G2sOym/GsgQdY57vTvRWQ8kTT69tilgPehwbQQR?=
 =?us-ascii?Q?1noQ9YPNVZv8PIWhWJueSNv4fPF0h8hcQmEr8dB+idsJxusi0TmIQvxWi6Jt?=
 =?us-ascii?Q?i9mtNcLR4FP77owMuOzFd6dioS7qutbAom7nJB+BcSm/q4KJ/awyeu6wCzvE?=
 =?us-ascii?Q?GN4Nj5/0wAow43Phrg4bnegKnur01lJ6HtjOXY7LZR3sk09xFYpwdKOmBqs0?=
 =?us-ascii?Q?pjLZcw6fUAT0krjB1e1/pnsVIlQY0S9VByA0E7oX0hAICzzIr7ys1ABmLeve?=
 =?us-ascii?Q?9tZAZ2iONyKKQvJ37zOTnX/9qKqz5GM65a6BnJ/n/B/9zdeqKLPU6ChKs6G+?=
 =?us-ascii?Q?IYvwDBoOHyAQTokJ206yf2FYTEFjzA7UdEoDckbHSJfFjbI/6M5wts4/VYD+?=
 =?us-ascii?Q?E6LcK9wNZ/ir6nPN1qV/QP+BtsQccNplgdH/?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 12:15:08.7097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5deb8ab-4cf8-4dbf-f4ed-08ddf12cd992
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8547

The AMD IOMMU host page table implementation supports dynamic page table levels
(up to 6 levels), starting with a 3-level configuration that expands based on
IOVA address. The kernel maintains a root pointer and current page table level
to enable proper page table walks in alloc_pte()/fetch_pte() operations.

The IOMMU IOVA allocator initially starts with 32-bit address and onces its
exhuasted it switches to 64-bit address (max address is determined based
on IOMMU and device DMA capability). To support larger IOVA, AMD IOMMU
driver increases page table level.

But in unmap path (iommu_v1_unmap_pages()), fetch_pte() reads
pgtable->[root/mode] without lock. So its possible that in exteme corner case,
when increase_address_space() is updating pgtable->[root/mode], fetch_pte()
reads wrong page table level (pgtable->mode). It does compare the value with
level encoded in page table and returns NULL. This will result is
iommu_unmap ops to fail and upper layer may retry/log WARN_ON.

CPU 0                                         CPU 1
------                                       ------
map pages                                    unmap pages
alloc_pte() -> increase_address_space()      iommu_v1_unmap_pages() -> fetch_pte()
  pgtable->root = pte (new root value)
                                             READ pgtable->[mode/root]
					       Reads new root, old mode
  Updates mode (pgtable->mode += 1)

Since Page table level updates are infrequent and already synchronized with a
spinlock, implement seqcount to enable lock-free read operations on the read path.

Reported-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: stable@vger.kernel.org
Cc: Joao Martins <joao.m.martins@oracle.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/io_pgtable.c      | 25 +++++++++++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 5219d7ddfdaa..95f63c5f6159 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -555,6 +555,7 @@ struct gcr3_tbl_info {
 };
 
 struct amd_io_pgtable {
+	seqcount_t		seqcount;	/* Protects root/mode update */
 	struct io_pgtable	pgtbl;
 	int			mode;
 	u64			*root;
diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index a91e71f981ef..70c2f5b1631b 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/dma-mapping.h>
+#include <linux/seqlock.h>
 
 #include <asm/barrier.h>
 
@@ -130,8 +131,11 @@ static bool increase_address_space(struct amd_io_pgtable *pgtable,
 
 	*pte = PM_LEVEL_PDE(pgtable->mode, iommu_virt_to_phys(pgtable->root));
 
+	write_seqcount_begin(&pgtable->seqcount);
 	pgtable->root  = pte;
 	pgtable->mode += 1;
+	write_seqcount_end(&pgtable->seqcount);
+
 	amd_iommu_update_and_flush_device_table(domain);
 
 	pte = NULL;
@@ -153,6 +157,7 @@ static u64 *alloc_pte(struct amd_io_pgtable *pgtable,
 {
 	unsigned long last_addr = address + (page_size - 1);
 	struct io_pgtable_cfg *cfg = &pgtable->pgtbl.cfg;
+	unsigned int seqcount;
 	int level, end_lvl;
 	u64 *pte, *page;
 
@@ -170,8 +175,14 @@ static u64 *alloc_pte(struct amd_io_pgtable *pgtable,
 	}
 
 
-	level   = pgtable->mode - 1;
-	pte     = &pgtable->root[PM_LEVEL_INDEX(level, address)];
+	do {
+		seqcount = read_seqcount_begin(&pgtable->seqcount);
+
+		level   = pgtable->mode - 1;
+		pte     = &pgtable->root[PM_LEVEL_INDEX(level, address)];
+	} while (read_seqcount_retry(&pgtable->seqcount, seqcount));
+
+
 	address = PAGE_SIZE_ALIGN(address, page_size);
 	end_lvl = PAGE_SIZE_LEVEL(page_size);
 
@@ -249,6 +260,7 @@ static u64 *fetch_pte(struct amd_io_pgtable *pgtable,
 		      unsigned long *page_size)
 {
 	int level;
+	unsigned int seqcount;
 	u64 *pte;
 
 	*page_size = 0;
@@ -256,8 +268,12 @@ static u64 *fetch_pte(struct amd_io_pgtable *pgtable,
 	if (address > PM_LEVEL_SIZE(pgtable->mode))
 		return NULL;
 
-	level	   =  pgtable->mode - 1;
-	pte	   = &pgtable->root[PM_LEVEL_INDEX(level, address)];
+	do {
+		seqcount = read_seqcount_begin(&pgtable->seqcount);
+		level	   =  pgtable->mode - 1;
+		pte	   = &pgtable->root[PM_LEVEL_INDEX(level, address)];
+	} while (read_seqcount_retry(&pgtable->seqcount, seqcount));
+
 	*page_size =  PTE_LEVEL_PAGE_SIZE(level);
 
 	while (level > 0) {
@@ -541,6 +557,7 @@ static struct io_pgtable *v1_alloc_pgtable(struct io_pgtable_cfg *cfg, void *coo
 	if (!pgtable->root)
 		return NULL;
 	pgtable->mode = PAGE_MODE_3_LEVEL;
+	seqcount_init(&pgtable->seqcount);
 
 	cfg->pgsize_bitmap  = amd_iommu_pgsize_bitmap;
 	cfg->ias            = IOMMU_IN_ADDR_BIT_SIZE;
-- 
2.31.1



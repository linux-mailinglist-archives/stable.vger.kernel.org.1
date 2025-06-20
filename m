Return-Path: <stable+bounces-155083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6E8AE18D1
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 12:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07690189E720
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 10:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28600283C87;
	Fri, 20 Jun 2025 10:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="loN0/SVg"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35538199947
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 10:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750415345; cv=fail; b=bSadWWjlyAFZ4q0aD+gkjjTfPHkZ8ztMle79Gaz3bNTIn8LYlmUvZuhYBda7NefBCzo4M/CRnTRuEAJqdprm8+bXlratNmRkQ7y/D9luCKDS96DO6PhQcj1WFCvhw/kKT90u7DZaKjKW4+dAINyUu5j/ko6wPqvts8sDb9yM/wE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750415345; c=relaxed/simple;
	bh=viuCksOoWMXJyojIk1Gw/c1aEXbFG00e6yJ6hmoFa3A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hh9Pq0h72VKzoOJ7f4ELBoO2vhawgc6SUp6pJh7C+xovoFZr/ydqov8Cshoyv6N8iW/gQOs4VoIMvVcCbNIQP1SncZ2gogEcy6YnIZ1qLH5NyFkG8jbYotAphuPedS4jwBQPaVlcZvTZ+vlFceAbgWlREaRGSZDYSUt7Ka7HeQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=loN0/SVg; arc=fail smtp.client-ip=40.107.223.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HECcox4ePwUf3COImW5KCZop49D/ane59fuWzoh9QekxT+TBmSxa29IrwR6BMPxrsTzAOh2mIDPvwaArLypjW9frzXumGnDwRxdM6NCGAUnYmiUr9+i0ifZajlnR4wqTqf0u03ewsYZ8lfMdTIiP69oV+gypOVWoFQ8kAuDwbAzYIsV8Yq/nbRtQCxOCFvEDoO8czR7VOpz4GwIUiNqn0Ye/myhhwa6ObzwoMIWdWsmGgi+LWhb+th3U0nb+FehFefSJLhGCimYQ4B2KL9ugrD0vQw4XIyuARsOYtq/MWhqCRjazb+BvjPoerCDNLVBJqQxEBdgw2atlQVlmz5gUPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbYOFIzADLFl3SWW3USV71LGrz7X/J2QlauBo+RtHGE=;
 b=cSMwB8tD9jpypVW/B0eoPeN1S9r1iTN8nBAvp1kBcfdCbpyiYUP2mWBKl+4p2NBrGailpValxjbhnPST09YquEmE283Wur0YjlJvbWO0QV7Tgb4gHlglkI1vkzYKWoD5YviN1nQQu58+omt411T8trzs4uuqYMRFNXavkyykA1rrIsXcD/GDnp1pSfPSvxM9sVwZRnfFrL7re4gLFbXHPcww6/Hb5+8mOZbc1dc8u1qMYZIfFEYSOzGsBpyo5T1fGd76Pfy8FCTkRYhfbp60MdYccv0/q4i2ZYM1st6484ELRtRuwOZ0iNrXAf1wVQCvDAgWXoNP1YAekZUeqOeHZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbYOFIzADLFl3SWW3USV71LGrz7X/J2QlauBo+RtHGE=;
 b=loN0/SVgPXEUhqAK/4ADOBE+S/ezJj+NovJ+nIYKuIsODWo17UX01vXCykoER6SXok8b3+yd16VzzzW3487DHb50eorXsI51TeYl1I+mTdf0mvjrupj6hFnura17ENq7MFIhg5rUcLhj8n98Bz+MHg2PDGAdlR+1f3300J8HHiE=
Received: from SJ0PR13CA0111.namprd13.prod.outlook.com (2603:10b6:a03:2c5::26)
 by SA1PR12MB8988.namprd12.prod.outlook.com (2603:10b6:806:38e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Fri, 20 Jun
 2025 10:29:00 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::4b) by SJ0PR13CA0111.outlook.office365.com
 (2603:10b6:a03:2c5::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.12 via Frontend Transport; Fri,
 20 Jun 2025 10:28:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Fri, 20 Jun 2025 10:28:59 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Jun
 2025 05:28:55 -0500
From: Shivank Garg <shivankg@amd.com>
To: <stable@vger.kernel.org>
CC: Shivank Garg <shivankg@amd.com>, David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, Alistair Popple <apopple@nvidia.com>,
	Dave Kleikamp <shaggy@kernel.org>, Donet Tom <donettom@linux.ibm.com>, "Jane
 Chu" <jane.chu@oracle.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Zi Yan
	<ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.15.y 1/2] mm: add folio_expected_ref_count() for reference count calculation
Date: Fri, 20 Jun 2025 10:28:16 +0000
Message-ID: <20250620102817.1185620-1-shivankg@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025062039-policy-handheld-01c6@gregkh>
References: <2025062039-policy-handheld-01c6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|SA1PR12MB8988:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b1839e9-858d-4757-19e6-08ddafe544d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yPiqo5+VF0G48yDB0hUhUlSaovSitapvg0t0TfpJFqOfe4GWwBsNsCLKpDQ9?=
 =?us-ascii?Q?5B8qyvLbCh0yHtWlDKEB+Swr71Ga+e9yC6i3/VRfk7hKm9UfOSjYAlDtrijW?=
 =?us-ascii?Q?vjTxm8C9JsHOjWflgVfXZwSg59Qyd1VppEyCMMLcuQbvC0a2eKnVLkgKQOCf?=
 =?us-ascii?Q?TPuQufl/7N5majL9bftry/Rn1MFVbknq6DUA2TTWApYqvlXS25La7D26R5CC?=
 =?us-ascii?Q?eVZ4gMIZALUGjkB5YIOB+mAOaGYAlRPYCGFZRrvxq235dw0gLyx7VAuR7eaG?=
 =?us-ascii?Q?wu4IxXBsdJyRw7NQ6JA+xME/sDG9GlYrtlf3Hum0tD8hJCMhRr1LwesApBmL?=
 =?us-ascii?Q?SZ/0qUOP0HGm3XI/5ljntYd54Er0hz/6ZtF51YVdDQgtSFb6bMFVlFK48Vaz?=
 =?us-ascii?Q?XfOh39A/31duy4RR20bautmwEM+EKO0WnBOuqME+ReOoG5N3E/oWiIeHhGLT?=
 =?us-ascii?Q?eLGA09+9vwEKUOFdCGZlXsTNObK48zLYCVVnj4amIsqCzW5qV5WZcdTYOOUk?=
 =?us-ascii?Q?E8Z2K2YN1mPn6WLb/qg6TlQZRuXw1cJhQaBoou11UhYSy8qzv1GIW8BgZdZH?=
 =?us-ascii?Q?w6lKRDj9E1sDQTRzRtJKgcc9+mlidZ8EZO1UvHCCnG18nrhmsZpdJG6J2CdF?=
 =?us-ascii?Q?tG/ebrIyFpqilypVc2ZPMkSnRiRXe6hD/vpGVxI5+FGRC4+g8OwqiFZ/011d?=
 =?us-ascii?Q?Nh0UUXYYjsh4VUAWSgcN+NA1SpboYh2AaVm30X8dr0P62FVtoxF2atTijwV3?=
 =?us-ascii?Q?X06qb5o4Z8ULq9HjPemqoh2JbKBtYEh3s4sSB+Il4l3ltGGuiWi2ILJKz67d?=
 =?us-ascii?Q?CCIlLsm3d2zNWzpwVtvT9Xdamvecmj6yowCYAoq2gsUrf1lS6LBiC6HjPo5k?=
 =?us-ascii?Q?kAtFN7imqcM5vWkOAgrzDV0znZlnqLJk7vUGIAj1sKdqtogIQzTSL+E54pjQ?=
 =?us-ascii?Q?c0pScD8LCDbZTv+w6aGO+zBw13AdbICtl+Dki0+wrtfAD6KG+CEXD88BvftQ?=
 =?us-ascii?Q?FcXMF2OfGlrssDehHdyhImeMplvJEY+VfpcmdePMG9dU4+X3Ea+nu9G73OHO?=
 =?us-ascii?Q?KJLHoMv4SteTh7k+9mj+uXh7KoqiKAL/Ke3RxaYOUpduynWvnUIH9LEfSgmT?=
 =?us-ascii?Q?cNcJkSxKpUUX5gXFQ4wEgx6sRajCyDmO4M44cLlqunOBD7+ungIDw/QVvUiD?=
 =?us-ascii?Q?r8T30i8wAo5Ymrr0EYn739LRazggVOzhnAWRwNf5ZHNqR7UmP06PW+ROHvaz?=
 =?us-ascii?Q?W4fmLxfp/K2yZTEwULy20Bibpb96/tcrkS1ozqEDenC7FpQ/CnlkW/BZqDMX?=
 =?us-ascii?Q?TfPWqasZEtfdimy5qIbaESc4xjYrcYhe8mPg+i7jjBaxqt4MLRXCARJ5Ta0k?=
 =?us-ascii?Q?t7wuw9sXfbeHG1w+agM/7atrptCxmBRpz+pnETyaIXfk8C+l7eoaanSRAgRe?=
 =?us-ascii?Q?iJFrRs7Ao3hc3zeg8VAxbxVEhAgMMwRURrDo7mGu9nGiMScb/I1qiA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 10:28:59.2454
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b1839e9-858d-4757-19e6-08ddafe544d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8988

Patch series " JFS: Implement migrate_folio for jfs_metapage_aops" v5.

This patchset addresses a warning that occurs during memory compaction due
to JFS's missing migrate_folio operation.  The warning was introduced by
commit 7ee3647243e5 ("migrate: Remove call to ->writepage") which added
explicit warnings when filesystem don't implement migrate_folio.

The syzbot reported following [1]:
  jfs_metapage_aops does not implement migrate_folio
  WARNING: CPU: 1 PID: 5861 at mm/migrate.c:955 fallback_migrate_folio mm/migrate.c:953 [inline]
  WARNING: CPU: 1 PID: 5861 at mm/migrate.c:955 move_to_new_folio+0x70e/0x840 mm/migrate.c:1007
  Modules linked in:
  CPU: 1 UID: 0 PID: 5861 Comm: syz-executor280 Not tainted 6.15.0-rc1-next-20250411-syzkaller #0 PREEMPT(full)
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
  RIP: 0010:fallback_migrate_folio mm/migrate.c:953 [inline]
  RIP: 0010:move_to_new_folio+0x70e/0x840 mm/migrate.c:1007

To fix this issue, this series implement metapage_migrate_folio() for JFS
which handles both single and multiple metapages per page configurations.

While most filesystems leverage existing migration implementations like
filemap_migrate_folio(), buffer_migrate_folio_norefs() or
buffer_migrate_folio() (which internally used folio_expected_refs()),
JFS's metapage architecture requires special handling of its private data
during migration.  To support this, this series introduce the
folio_expected_ref_count(), which calculates external references to a
folio from page/swap cache, private data, and page table mappings.

This standardized implementation replaces the previous ad-hoc
folio_expected_refs() function and enables JFS to accurately determine
whether a folio has unexpected references before attempting migration.

Implement folio_expected_ref_count() to calculate expected folio reference
counts from:
- Page/swap cache (1 per page)
- Private data (1)
- Page table mappings (1 per map)

While originally needed for page migration operations, this improved
implementation standardizes reference counting by consolidating all
refcount contributors into a single, reusable function that can benefit
any subsystem needing to detect unexpected references to folios.

The folio_expected_ref_count() returns the sum of these external
references without including any reference the caller itself might hold.
Callers comparing against the actual folio_ref_count() must account for
their own references separately.

Link: https://syzkaller.appspot.com/bug?extid=8bb6fd945af4e0ad9299 [1]
Link: https://lkml.kernel.org/r/20250430100150.279751-1-shivankg@amd.com
Link: https://lkml.kernel.org/r/20250430100150.279751-2-shivankg@amd.com
Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Shivank Garg <shivankg@amd.com>
Suggested-by: Matthew Wilcox <willy@infradead.org>
Co-developed-by: David Hildenbrand <david@redhat.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Dave Kleikamp <shaggy@kernel.org>
Cc: Donet Tom <donettom@linux.ibm.com>
Cc: Jane Chu <jane.chu@oracle.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Zi Yan <ziy@nvidia.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/mm.h | 55 ++++++++++++++++++++++++++++++++++++++++++++++
 mm/migrate.c       | 22 ++++---------------
 2 files changed, 59 insertions(+), 18 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e51dba8398f7..000a67a789ad 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2306,6 +2306,61 @@ static inline bool folio_maybe_mapped_shared(struct folio *folio)
 	return folio_test_large_maybe_mapped_shared(folio);
 }
 
+/**
+ * folio_expected_ref_count - calculate the expected folio refcount
+ * @folio: the folio
+ *
+ * Calculate the expected folio refcount, taking references from the pagecache,
+ * swapcache, PG_private and page table mappings into account. Useful in
+ * combination with folio_ref_count() to detect unexpected references (e.g.,
+ * GUP or other temporary references).
+ *
+ * Does currently not consider references from the LRU cache. If the folio
+ * was isolated from the LRU (which is the case during migration or split),
+ * the LRU cache does not apply.
+ *
+ * Calling this function on an unmapped folio -- !folio_mapped() -- that is
+ * locked will return a stable result.
+ *
+ * Calling this function on a mapped folio will not result in a stable result,
+ * because nothing stops additional page table mappings from coming (e.g.,
+ * fork()) or going (e.g., munmap()).
+ *
+ * Calling this function without the folio lock will also not result in a
+ * stable result: for example, the folio might get dropped from the swapcache
+ * concurrently.
+ *
+ * However, even when called without the folio lock or on a mapped folio,
+ * this function can be used to detect unexpected references early (for example,
+ * if it makes sense to even lock the folio and unmap it).
+ *
+ * The caller must add any reference (e.g., from folio_try_get()) it might be
+ * holding itself to the result.
+ *
+ * Returns the expected folio refcount.
+ */
+static inline int folio_expected_ref_count(const struct folio *folio)
+{
+	const int order = folio_order(folio);
+	int ref_count = 0;
+
+	if (WARN_ON_ONCE(folio_test_slab(folio)))
+		return 0;
+
+	if (folio_test_anon(folio)) {
+		/* One reference per page from the swapcache. */
+		ref_count += folio_test_swapcache(folio) << order;
+	} else if (!((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS)) {
+		/* One reference per page from the pagecache. */
+		ref_count += !!folio->mapping << order;
+		/* One reference from PG_private. */
+		ref_count += folio_test_private(folio);
+	}
+
+	/* One reference per page table mapping. */
+	return ref_count + folio_mapcount(folio);
+}
+
 #ifndef HAVE_ARCH_MAKE_FOLIO_ACCESSIBLE
 static inline int arch_make_folio_accessible(struct folio *folio)
 {
diff --git a/mm/migrate.c b/mm/migrate.c
index 676d9cfc7059..273d46771a6c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -445,20 +445,6 @@ void pmd_migration_entry_wait(struct mm_struct *mm, pmd_t *pmd)
 }
 #endif
 
-static int folio_expected_refs(struct address_space *mapping,
-		struct folio *folio)
-{
-	int refs = 1;
-	if (!mapping)
-		return refs;
-
-	refs += folio_nr_pages(folio);
-	if (folio_test_private(folio))
-		refs++;
-
-	return refs;
-}
-
 /*
  * Replace the folio in the mapping.
  *
@@ -601,7 +587,7 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 int folio_migrate_mapping(struct address_space *mapping,
 		struct folio *newfolio, struct folio *folio, int extra_count)
 {
-	int expected_count = folio_expected_refs(mapping, folio) + extra_count;
+	int expected_count = folio_expected_ref_count(folio) + extra_count + 1;
 
 	if (folio_ref_count(folio) != expected_count)
 		return -EAGAIN;
@@ -618,7 +604,7 @@ int migrate_huge_page_move_mapping(struct address_space *mapping,
 				   struct folio *dst, struct folio *src)
 {
 	XA_STATE(xas, &mapping->i_pages, folio_index(src));
-	int rc, expected_count = folio_expected_refs(mapping, src);
+	int rc, expected_count = folio_expected_ref_count(src) + 1;
 
 	if (folio_ref_count(src) != expected_count)
 		return -EAGAIN;
@@ -749,7 +735,7 @@ static int __migrate_folio(struct address_space *mapping, struct folio *dst,
 			   struct folio *src, void *src_private,
 			   enum migrate_mode mode)
 {
-	int rc, expected_count = folio_expected_refs(mapping, src);
+	int rc, expected_count = folio_expected_ref_count(src) + 1;
 
 	/* Check whether src does not have extra refs before we do more work */
 	if (folio_ref_count(src) != expected_count)
@@ -837,7 +823,7 @@ static int __buffer_migrate_folio(struct address_space *mapping,
 		return migrate_folio(mapping, dst, src, mode);
 
 	/* Check whether page does not have extra refs before we do more work */
-	expected_count = folio_expected_refs(mapping, src);
+	expected_count = folio_expected_ref_count(src) + 1;
 	if (folio_ref_count(src) != expected_count)
 		return -EAGAIN;
 
-- 
2.43.0



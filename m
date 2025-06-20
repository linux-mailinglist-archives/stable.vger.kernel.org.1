Return-Path: <stable+bounces-155084-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C4AAE18D2
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 12:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFDA04A4EBA
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 10:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E456283C87;
	Fri, 20 Jun 2025 10:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rBi3hE6x"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2063.outbound.protection.outlook.com [40.107.96.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632EC199947
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 10:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750415356; cv=fail; b=E7keb113xY8z58S8v9dCiEOL0bdIy/n9wapVGuKrLqEpvqToXze61bG0XEGiltnSdMsWY6102jbkmQhv/2r9WVNMbKuoL7YJUhj0Su3D5iDLCN8hUHig0SG/mBfqnlhSAVBhvc/cS10Bz2rT/RVEsZpx1LUUXzoXy4AcHxp891A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750415356; c=relaxed/simple;
	bh=HSMuk6NgBkXUZpUj/wib/YgE7wIWHiSxiUlooEb/rp0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AS7FoxxvFnQVXw2EjtRT0s4dyGCDXQK+UNGh9SaAC7hgdTd+rIl99bdgh3roCp9fHBJRvUFYeSfqOVTAm9s+aecWPiaa/0P2ocLKR3rNiOPbH4LiXY+PHGjbnov/YIXyT3BuE88i7FCDczBd51ipBkKFynBnbpL4vYoy8+s/p4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rBi3hE6x; arc=fail smtp.client-ip=40.107.96.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VDuISyV5Gwc1YrPl/jIRfwpyNcGJ6lJKt/Gn76OBmHIz2iu+Rf/SWXAwkMcAaD0x27OpBvy3gnZMXBbwY7OEgZ0R2Bca/dfh6iyVcErHtJinkdKrT1xj+mYWz4Lcuku50PvUvu7VNxcuUy2SL0ccvXhEFbJFZAojqkZ6CFBqpv8USL6ESOQ8FYyolLJuUmKJuw8ok4YyvDCBLRycoGTdPslHi1Z09bRHes0qyw2NKif7b28y8muwHDAtERF+WBsc6c8CewLDn6v8Z5K9/nPYOXd1wgx5hMG+HgUsb2yjPrr0OvzIuN58bveb9r/l+cX1dQjnn65Pn0x7DV40QhoPsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEK5woGS6B9VW2HbdZ6+Qx+Yy/H8IxZ3FOZoc/1fAPY=;
 b=XMN77/i/McqqHEyrOUU6jDpixHqqoGsLogLVcLXboBSc+VdmAPtFWBnHss7Ps1taq+Icpfggq2o1JJGoR4I4apgYKE3T/NhJVW7hW0dHmlEtvEYiDFgah8uaMk5gABNLm7Wp1n8WVRGfeyMCKCVf8tYGH2ocbarOAVSuzy9e7YL4UalAnawkdMhriUlxG7tQs1S0Kc9ey0xaRkkMldJfSiMFm5UkYp4HnE3e1ZUes7S1YZjSwro/BLW4dcjZ8ZjcJN9TBhWPN/2jQvEzUwfG6rnmaB2Ks3kjICfd9kR9F3A0iuN1VYPjBHvv5a0v6eOSyn2NwOvErMppR6qOAJW88A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEK5woGS6B9VW2HbdZ6+Qx+Yy/H8IxZ3FOZoc/1fAPY=;
 b=rBi3hE6xNF7Mgz0AOlMpAookQFL0Nu6+FXsul5RMhrGA/wVw8JXlPkg/BYN88EU3g5ndD9sXPLOHoryKH/UyENlLRP8MXm4lkWn2RLFp82IflBBkqC16yKDXAye8ZMUjGGDh5EI0G4QA4/LFMt5DSkcDjeHhskZ0EGf1vFHwMnE=
Received: from MW4PR03CA0145.namprd03.prod.outlook.com (2603:10b6:303:8c::30)
 by MN2PR12MB4485.namprd12.prod.outlook.com (2603:10b6:208:269::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Fri, 20 Jun
 2025 10:29:10 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:303:8c:cafe::1f) by MW4PR03CA0145.outlook.office365.com
 (2603:10b6:303:8c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.25 via Frontend Transport; Fri,
 20 Jun 2025 10:29:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Fri, 20 Jun 2025 10:29:10 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Jun
 2025 05:29:01 -0500
From: Shivank Garg <shivankg@amd.com>
To: <stable@vger.kernel.org>
CC: Shivank Garg <shivankg@amd.com>,
	<syzbot+2b99589e33edbe9475ca@syzkaller.appspotmail.com>, David Hildenbrand
	<david@redhat.com>, Dev Jain <dev.jain@arm.com>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, Bharata B Rao <bharata@amd.com>, Fengwei Yin
	<fengwei.yin@intel.com>, Liam Howlett <liam.howlett@oracle.com>, "Lorenzo
 Stoakes" <lorenzo.stoakes@oracle.com>, Mariano Pache <npache@redhat.com>,
	"Ryan Roberts" <ryan.roberts@arm.com>, Zi Yan <ziy@nvidia.com>, Andrew Morton
	<akpm@linux-foundation.org>
Subject: [PATCH 6.15.y 2/2] mm/khugepaged: fix race with folio split/free using temporary reference
Date: Fri, 20 Jun 2025 10:28:17 +0000
Message-ID: <20250620102817.1185620-2-shivankg@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250620102817.1185620-1-shivankg@amd.com>
References: <2025062039-policy-handheld-01c6@gregkh>
 <20250620102817.1185620-1-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|MN2PR12MB4485:EE_
X-MS-Office365-Filtering-Correlation-Id: b210a10f-6766-427e-f020-08ddafe54b55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?30LqIx3i3n68gqAs03/eTRGOwCQSHL8jpW3qwz0fH4PNcH9a7z9gcx86/BZd?=
 =?us-ascii?Q?3PQse07k/OC6u7nbvZ11WHj8YdKpt3tFbiHeY7dX9H1m6GMLozNCIw5k+PAk?=
 =?us-ascii?Q?OmusxqNfprMVXGsv4JRLl6riXnOZzNaGDTzADJ3h0vMS0VopJn2w4KVy06Hz?=
 =?us-ascii?Q?1E4HKRtUGWZMllYs11MqLsmG0t7RY2nXmK7PxMzrGMlPWVFic2hCQmY/63+i?=
 =?us-ascii?Q?irVpKrnFUcCkfmB3ZA9KCI0oVxHFlSCB/UJ7uDUr2NYtguBwPSSjJHj1EB+L?=
 =?us-ascii?Q?Iy+OnUVd+YYRN3W2B2lPQmZekvNJByLfgpPgcbzpSP2wHGTXj6TRh9aeFzYF?=
 =?us-ascii?Q?MiccBXLpfVt5F+gEmEIWM3vFKFtG3p45zv3XKXCUxMvj0Wx6j8RXvFiJ0+MP?=
 =?us-ascii?Q?Fb3u37LLfTMojWiOqgRR7vTbV3EXXBbHYilIJgOj1ZzzRSNkc0XpQ0vOtT8F?=
 =?us-ascii?Q?FclMIdtaeb4pIOaMKp7wiJszjukW/Qa74ZEdBeiqx9x4X5jaP5Z2jhmWw+YC?=
 =?us-ascii?Q?EYRSysv39dq74ZyQ/BpFk7zjv8CMmnKBxjW9giK1wgjZXB4rs83UkcIIrGKz?=
 =?us-ascii?Q?ILsfWcdpiGu1IYZBQfDWD3a/AnTT1+e6Ymqf+wOWm+EYGW1E/BcM5ArxQ8tI?=
 =?us-ascii?Q?BXpp6wCz4KnWlgMV1boHsC0Sk15jgEmJww+aZDsgzs6P/0oHhmOg+NY2n/zA?=
 =?us-ascii?Q?2NydTBmKzCD/jccKXeCggOQ/NfXlKolS8g8V0iUrJ6CAqdZwBMWfC08ol+1/?=
 =?us-ascii?Q?DppTPIEVwutIX1zVF5M58h0rStuif1CUnoyyvUaFjq50kQpU+I/TrvZWHpWb?=
 =?us-ascii?Q?9HgM6hzdRxnvBl4urUr9HyLW5zQPNVz5OaNz6ZoGE5GpM9bS+qhK6VlcuQMD?=
 =?us-ascii?Q?LQTZdIwhzMwnUHTNk5neRmCTog/n6P3f/6l36eKZ3bqKwqUEuIxeFMMkG8yB?=
 =?us-ascii?Q?Z2amRs+K4hxGGdg/UheiLMCqRv1lpaVOo8JdndI7mhlg6o8ElbPStZnBLPrm?=
 =?us-ascii?Q?NvazQHZ3j6ioM0Xfd05sb1H8z0U10+oLjjlCzUyoKeScbRihxtfy33j3kqTn?=
 =?us-ascii?Q?Y4rje1DKdd9FlFRXjjoiCL6qyZx7qLnEnMPMs122cx0HTkwr2bbmscW92OWg?=
 =?us-ascii?Q?YDrEvzrKl7z0XGcDJKLyyUVEZbc95iZ3dYVhCJymhQMMPxdOPpOHDu0nI8mP?=
 =?us-ascii?Q?zsHasfOpaGN50L7NPFqrNslduDgYHUDX6Mx7VH8K1LOBfDMjahBgxhLejUKc?=
 =?us-ascii?Q?iW2r44KmtHEW7wH13q0WBJkCs0JekQTdeuObgboFE8sxA8IaHYgtm7aqudpU?=
 =?us-ascii?Q?QIqlnliUsFb1zxPurcrQETBWzJI5ghyBDeX04whRb0OYovyCJkehc6HOxTdw?=
 =?us-ascii?Q?tBgMEj8V7Ah+W6DbjhdIlhqo6RVKlY9cVy39Dr2wJuiZ68z8BGp6MePQ8roR?=
 =?us-ascii?Q?3tPyFfMrhlIq1H9/dNZHiEvESRE1qpJ2/WSA2P5bhrcWiXvdectZXA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 10:29:10.1441
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b210a10f-6766-427e-f020-08ddafe54b55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4485

hpage_collapse_scan_file() calls is_refcount_suitable(), which in turn
calls folio_mapcount().  folio_mapcount() checks folio_test_large() before
proceeding to folio_large_mapcount(), but there is a race window where the
folio may get split/freed between these checks, triggering:

  VM_WARN_ON_FOLIO(!folio_test_large(folio), folio)

Take a temporary reference to the folio in hpage_collapse_scan_file().
This stabilizes the folio during refcount check and prevents incorrect
large folio detection due to concurrent split/free.  Use helper
folio_expected_ref_count() + 1 to compare with folio_ref_count() instead
of using is_refcount_suitable().

Link: https://lkml.kernel.org/r/20250526182818.37978-1-shivankg@amd.com
Fixes: 05c5323b2a34 ("mm: track mapcount of large folios in single value")
Signed-off-by: Shivank Garg <shivankg@amd.com>
Reported-by: syzbot+2b99589e33edbe9475ca@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6828470d.a70a0220.38f255.000c.GAE@google.com
Suggested-by: David Hildenbrand <david@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Dev Jain <dev.jain@arm.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Bharata B Rao <bharata@amd.com>
Cc: Fengwei Yin <fengwei.yin@intel.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Mariano Pache <npache@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/khugepaged.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index cc945c6ab3bd..fe1fe7eace54 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2295,6 +2295,17 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
 			continue;
 		}
 
+		if (!folio_try_get(folio)) {
+			xas_reset(&xas);
+			continue;
+		}
+
+		if (unlikely(folio != xas_reload(&xas))) {
+			folio_put(folio);
+			xas_reset(&xas);
+			continue;
+		}
+
 		if (folio_order(folio) == HPAGE_PMD_ORDER &&
 		    folio->index == start) {
 			/* Maybe PMD-mapped */
@@ -2305,23 +2316,27 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
 			 * it's safe to skip LRU and refcount checks before
 			 * returning.
 			 */
+			folio_put(folio);
 			break;
 		}
 
 		node = folio_nid(folio);
 		if (hpage_collapse_scan_abort(node, cc)) {
 			result = SCAN_SCAN_ABORT;
+			folio_put(folio);
 			break;
 		}
 		cc->node_load[node]++;
 
 		if (!folio_test_lru(folio)) {
 			result = SCAN_PAGE_LRU;
+			folio_put(folio);
 			break;
 		}
 
-		if (!is_refcount_suitable(folio)) {
+		if (folio_expected_ref_count(folio) + 1 != folio_ref_count(folio)) {
 			result = SCAN_PAGE_COUNT;
+			folio_put(folio);
 			break;
 		}
 
@@ -2333,6 +2348,7 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
 		 */
 
 		present += folio_nr_pages(folio);
+		folio_put(folio);
 
 		if (need_resched()) {
 			xas_pause(&xas);
-- 
2.43.0



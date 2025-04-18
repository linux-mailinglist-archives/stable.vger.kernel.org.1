Return-Path: <stable+bounces-134540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F32A93500
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 10:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A7C17B3404
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 08:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41F726FDBA;
	Fri, 18 Apr 2025 08:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="HnD7GPY/"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE2626FD82;
	Fri, 18 Apr 2025 08:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744966764; cv=none; b=RLfR5GgzVpFw9xz9q9rhk6fteV7yje5C4Cd0PXrCCtrZSsPRFNbiwLuW3Ht2lb6ip84bWvA9G5sP23jAY7c+p2T9s27JLkY2bQFe2N1BahQ3es2kyzCHFlh9VYJQwaN1x/7/6AWrPSj2kwNy9VY/i9kouLlS5KdMDZ0GmmrVNwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744966764; c=relaxed/simple;
	bh=KlZox/FhfiDHrEDYrtGoIjJ878K+yX47TPz+ztcPYt0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XXlbUWiHb48WGZNsIjgSTkDJgWSwenVoMKLEFhlZArB1hVQuf5WUdX1ie3uPNRmH4WXrScXJm84GgQ6a4hXHk3WHKF3dftCXPxU1IECKuZeKo+MoEJKLrh3cUnV25T5JOy70XyaMr7HOrWj5BxhMF6xF9R4/RLmhscustmUlKQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=HnD7GPY/; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=2cOFs7O7/L6f8JwExiEKzmQTdI10W4SPn5o+BQaDJHw=; b=HnD7GPY/+mHCutXBYnAlJE3wac
	EeJ/7Og8qsfX9ScGMa/uxwMJ6ASHNNp28hbX0SLTMqL/GgTy/65C/M+hl0pteLaqkT7z9DdS/0lbu
	S2X8UGDbfGd8JZi9+GQEKOCpk0tzcmwmo9RJUOS6lJPaG28cSZTIQioaYrDM3EJG3OTgQWuAqQttU
	FLlyaHGKG3XBFEeDDtSFzKdWlTR5ATR2Gt/wCdNnZu7gqDSoMD5omRurzXix/Sj8sIkv1PSenuB8k
	ba8d3denksSZfmcbp1GN+DcPxhV9j3axez0gDGbWPHH+w436h4Z3j3XsUI+slB/18Kse+maq4mnuT
	482TkmZQ==;
Received: from 114-44-248-24.dynamic-ip.hinet.net ([114.44.248.24] helo=gavin-HP-Z840-Workstation..)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1u5hYp-001AVr-3u; Fri, 18 Apr 2025 10:58:59 +0200
From: Gavin Guo <gavinguo@igalia.com>
To: linux-mm@kvack.org,
	akpm@linux-foundation.org
Cc: david@redhat.com,
	willy@infradead.org,
	ziy@nvidia.com,
	linmiaohe@huawei.com,
	hughd@google.com,
	revest@google.com,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] mm/huge_memory: fix dereferencing invalid pmd migration entry
Date: Fri, 18 Apr 2025 16:58:02 +0800
Message-ID: <20250418085802.2973519-1-gavinguo@igalia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When migrating a THP, concurrent access to the PMD migration entry
during a deferred split scan can lead to a invalid address access, as
illustrated below. To prevent this page fault, it is necessary to check
the PMD migration entry and return early. In this context, there is no
need to use pmd_to_swp_entry and pfn_swap_entry_to_page to verify the
equality of the target folio. Since the PMD migration entry is locked,
it cannot be served as the target.

Mailing list discussion and explanation from Hugh Dickins:
"An anon_vma lookup points to a location which may contain the folio of
interest, but might instead contain another folio: and weeding out those
other folios is precisely what the "folio != pmd_folio((*pmd)" check
(and the "risk of replacing the wrong folio" comment a few lines above
it) is for."

BUG: unable to handle page fault for address: ffffea60001db008
CPU: 0 UID: 0 PID: 2199114 Comm: tee Not tainted 6.14.0+ #4 NONE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:split_huge_pmd_locked+0x3b5/0x2b60
Call Trace:
<TASK>
try_to_migrate_one+0x28c/0x3730
rmap_walk_anon+0x4f6/0x770
unmap_folio+0x196/0x1f0
split_huge_page_to_list_to_order+0x9f6/0x1560
deferred_split_scan+0xac5/0x12a0
shrinker_debugfs_scan_write+0x376/0x470
full_proxy_write+0x15c/0x220
vfs_write+0x2fc/0xcb0
ksys_write+0x146/0x250
do_syscall_64+0x6a/0x120
entry_SYSCALL_64_after_hwframe+0x76/0x7e

The bug is found by syzkaller on an internal kernel, then confirmed on
upstream.

Fixes: 84c3fc4e9c56 ("mm: thp: check pmd migration entry in common path")
Cc: stable@vger.kernel.org
Signed-off-by: Gavin Guo <gavinguo@igalia.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Hugh Dickins <hughd@google.com>
Acked-by: Zi Yan <ziy@nvidia.com>
Link: https://lore.kernel.org/all/20250414072737.1698513-1-gavinguo@igalia.com/
---
V1 -> V2: Add explanation from Hugh and correct the wording from page
fault to invalid address access.

 mm/huge_memory.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2a47682d1ab7..0cb9547dcff2 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3075,6 +3075,8 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
 			   pmd_t *pmd, bool freeze, struct folio *folio)
 {
+	bool pmd_migration = is_pmd_migration_entry(*pmd);
+
 	VM_WARN_ON_ONCE(folio && !folio_test_pmd_mappable(folio));
 	VM_WARN_ON_ONCE(!IS_ALIGNED(address, HPAGE_PMD_SIZE));
 	VM_WARN_ON_ONCE(folio && !folio_test_locked(folio));
@@ -3085,10 +3087,18 @@ void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
 	 * require a folio to check the PMD against. Otherwise, there
 	 * is a risk of replacing the wrong folio.
 	 */
-	if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
-	    is_pmd_migration_entry(*pmd)) {
-		if (folio && folio != pmd_folio(*pmd))
-			return;
+	if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) || pmd_migration) {
+		if (folio) {
+			/*
+			 * Do not apply pmd_folio() to a migration entry; and
+			 * folio lock guarantees that it must be of the wrong
+			 * folio anyway.
+			 */
+			if (pmd_migration)
+				return;
+			if (folio != pmd_folio(*pmd))
+				return;
+		}
 		__split_huge_pmd_locked(vma, pmd, address, freeze);
 	}
 }

base-commit: a24588245776dafc227243a01bfbeb8a59bafba9
-- 
2.43.0



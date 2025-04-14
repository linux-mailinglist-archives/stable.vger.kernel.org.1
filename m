Return-Path: <stable+bounces-132404-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 394CAA878BF
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 09:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A90B188FF60
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 07:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296791A3169;
	Mon, 14 Apr 2025 07:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Ov8XkArb"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A219B86344;
	Mon, 14 Apr 2025 07:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744615864; cv=none; b=iWrCYR9liXP0TDrU700jo4GhFnXWE/yBbI219UY6iBajzB5UzjTgw7frKDqp/dIH4wR1JT7O+8glbXk4tGpIZFr6gNOUgKYfVJTSwaDXxOtPUYa5rNI8o5UWWMXger6glNYoi+6fL4VINx26RuKUmjJ5AyJS16KegFwsZM66DKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744615864; c=relaxed/simple;
	bh=J5T5W0NJLy8lDsH4lewzVbpxAHn03oE/y6l8dOkaqOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H4ASUrzeXpHb6lmwe5kMdKQBoO0h9A63PHDYRm/TR6QijybNHSz81LjhiAix09gOLtfqXwPOWAK7pVEwgPsaP9ur2kIcE7yNTkTnOhlJH4t733yiXLiIMiMo5VFPw3hhCPUvwVlytouX57x+TVbFSbNBl+p9xfSKYI9v5mz2IOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Ov8XkArb; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=vEgQw4Oeh0QWFwliFzc7dalA4Bm+0n5fXz5F6FYvZqM=; b=Ov8XkArbr9XmCTfO400l0lXI5h
	Vm8AVuIA9VvF7xGsbmxrBIvZs/LsGC+NwwHi49LN00REb73Qj1EceSuoQT1zmzXee9penmNUcJnV3
	RotzY8UC+jwnC55zzItWfD1/ykelnhWEkDaphrcmEYtx8W76zeeru1AdAbYsHaAhaJzSv0GzBDndm
	J5PtSpaNmQORvtKQ9/TVqgWZ0Iav9tZrhX+8nN7yTbWW96O/YCnJ37VQkaHW+3B35k+yd4mER3Rxy
	evzVNhBrZXo7u9DaMoGov41ijQOW93qjeQylVqVrzUjftpH4z6jcMrePkz3qmCEUTdmUuYmGN1AVM
	s3pgzcMQ==;
Received: from 114-44-251-90.dynamic-ip.hinet.net ([114.44.251.90] helo=gavin-HP-Z840-Workstation..)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1u4EH2-00GG91-A1; Mon, 14 Apr 2025 09:30:32 +0200
From: Gavin Guo <gavinguo@igalia.com>
To: linux-mm@kvack.org,
	akpm@linux-foundation.org
Cc: willy@infradead.org,
	ziy@nvidia.com,
	linmiaohe@huawei.com,
	hughd@google.com,
	revest@google.com,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] mm/huge_memory: fix dereferencing invalid pmd migration entry
Date: Mon, 14 Apr 2025 15:27:37 +0800
Message-ID: <20250414072737.1698513-1-gavinguo@igalia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When migrating a THP, concurrent access to the PMD migration entry
during a deferred split scan can lead to a page fault, as illustrated
below. To prevent this page fault, it is necessary to check the PMD
migration entry and return early. In this context, there is no need to
use pmd_to_swp_entry and pfn_swap_entry_to_page to verify the equality
of the target folio. Since the PMD migration entry is locked, it cannot
be served as the target.

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
---
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



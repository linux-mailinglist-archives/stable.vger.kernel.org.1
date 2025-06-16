Return-Path: <stable+bounces-152687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C446BADA67B
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 04:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44D927A7759
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 02:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE276CA5E;
	Mon, 16 Jun 2025 02:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ptYKwV1Y"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB2417B50A
	for <stable@vger.kernel.org>; Mon, 16 Jun 2025 02:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750042213; cv=none; b=bN0YiW0XWasdeuZb+d94IFOPRY0deCmZ74Uh6qdnD7ttkpEslZobp4JnyEVwEFR4Pe083q+th4OZ5NK1HDoK++PbBfRllauT5oojAhjKUiy/vQ6nGgYyA9gtBqXuSl4A9xuwwq+6t8L0n/knVutsZLdIiSlJZ/aWYnTqlr2yrmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750042213; c=relaxed/simple;
	bh=D+I/pvvXY+DxZZseLuN0uZa+T6m563qfKW9m+HAXqkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ovppw+g+dc9CCYD4u2hvaaw29uXblpdQNwdQLU5aRsR06AI2dUpqlCUcR6goB7BK5fcGFjq225hmWQuoLY4Hkh3d5T04cmZFQ9mNXpg2lOCMYsMasGlQTkdNCcXkW22+nBsF+TkBjBN/qmFT9pLiyMsREiVwJHurohfJ9u0WnLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ptYKwV1Y; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=8jpQPF6oDc69eyAxjjNcss4GVS9U+QydqFoVR4ycFoM=; b=ptYKwV1YFAtX90hQBCX5EoBEmc
	+NNn0SA00QRpPcetlRSyPEQpJkKZbRrUrXOv2+gkIIr8+ZB5spLSMcmX/vQ9di5p9hS0tp5FpzV+6
	hBjtQo8pKIfJZGz3ay4xZq3IDeISZpgCS9AD+FgAByeu1nmRmR+A31TRfGFdaEKQoplVueq0YT9T/
	+yETSASVoym2dLXMqRWX1xlpW6OTZSUwRdYYSJuMUtcQvtnVTcfyuF6e0HzHq+CXKnkh3RbK1NNer
	1E4vEgQYHi8OK1OZbqdBOeDHwP1ktiUbbZFXL0jVTuy+xq59nQeNRpo7D6eQRZm/0VAgPSr/s93r5
	8fojP02w==;
Received: from 114-44-254-110.dynamic-ip.hinet.net ([114.44.254.110] helo=gavin-HP-Z840-Workstation..)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uQzv5-003viF-Qg; Mon, 16 Jun 2025 04:50:00 +0200
From: Gavin Guo <gavinguo@igalia.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Zi Yan <ziy@nvidia.com>,
	Gavin Shan <gshan@redhat.com>,
	Florent Revest <revest@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	stable@vger.kernel.org
Subject: [PATCH 6.6.y] mm/huge_memory: fix dereferencing invalid pmd migration entry
Date: Mon, 16 Jun 2025 10:49:52 +0800
Message-ID: <20250616024952.1791381-1-gavinguo@igalia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025051202-nutrient-upswing-4a86@gregkh>
References: <2025051202-nutrient-upswing-4a86@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit be6e843fc51a584672dfd9c4a6a24c8cb81d5fb7 ]

When migrating a THP, concurrent access to the PMD migration entry during
a deferred split scan can lead to an invalid address access, as
illustrated below.  To prevent this invalid access, it is necessary to
check the PMD migration entry and return early.  In this context, there is
no need to use pmd_to_swp_entry and pfn_swap_entry_to_page to verify the
equality of the target folio.  Since the PMD migration entry is locked, it
cannot be served as the target.

Mailing list discussion and explanation from Hugh Dickins: "An anon_vma
lookup points to a location which may contain the folio of interest, but
might instead contain another folio: and weeding out those other folios is
precisely what the "folio != pmd_folio((*pmd)" check (and the "risk of
replacing the wrong folio" comment a few lines above it) is for."

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

Link: https://lkml.kernel.org/r/20250421113536.3682201-1-gavinguo@igalia.com
Link: https://lore.kernel.org/all/20250414072737.1698513-1-gavinguo@igalia.com/
Link: https://lore.kernel.org/all/20250418085802.2973519-1-gavinguo@igalia.com/
Fixes: 84c3fc4e9c56 ("mm: thp: check pmd migration entry in common path")
Signed-off-by: Gavin Guo <gavinguo@igalia.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Hugh Dickins <hughd@google.com>
Acked-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Cc: Florent Revest <revest@google.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[gavin: backport the migration checking logic to __split_huge_pmd]
Signed-off-by: Gavin Guo <gavinguo@igalia.com>
---
 mm/huge_memory.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 635f0f0f6860..ad04162f637c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2260,6 +2260,7 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 {
 	spinlock_t *ptl;
 	struct mmu_notifier_range range;
+	bool pmd_migration = is_pmd_migration_entry(*pmd);
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma->vm_mm,
 				address & HPAGE_PMD_MASK,
@@ -2274,13 +2275,12 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 	VM_BUG_ON(freeze && !folio);
 	VM_WARN_ON_ONCE(folio && !folio_test_locked(folio));
 
-	if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
-	    is_pmd_migration_entry(*pmd)) {
+	if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) || pmd_migration) {
 		/*
-		 * It's safe to call pmd_page when folio is set because it's
-		 * guaranteed that pmd is present.
+		 * Do not apply pmd_folio() to a migration entry; and folio lock
+		 * guarantees that it must be of the wrong folio anyway.
 		 */
-		if (folio && folio != page_folio(pmd_page(*pmd)))
+		if (folio && (pmd_migration || folio != page_folio(pmd_page(*pmd))))
 			goto out;
 		__split_huge_pmd_locked(vma, pmd, range.start, freeze);
 	}

base-commit: c2603c511feb427b2b09f74b57816a81272932a1
-- 
2.43.0



Return-Path: <stable+bounces-152686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAFBADA675
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 04:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87FDB164AEE
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 02:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23F577104;
	Mon, 16 Jun 2025 02:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="mfYPF7vH"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E4815DBC1
	for <stable@vger.kernel.org>; Mon, 16 Jun 2025 02:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750042089; cv=none; b=WL8VyEbxNTpWqs1PG/6ZyrKoQdGeCf/lUr/Kf+hP8Cmr5hCg5VX5ifngIHz9pGpg26DbV3yKrvE+hm+OFTMtYln3mq2FmCtdUYIFfLoamsqad5znNsdzFX0Ld86PobiR3Vd5BZebDhN5wW6FQqYKhMhpf6zbZDJLpSRl79zEDxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750042089; c=relaxed/simple;
	bh=rKjS7IHSbv2O7HU9FOqi3Bm7mXBBlOW9LcggSL/iDuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ifNRJm4JsR6Pn4uBFnsgQ+J5+xjxTxonybFa3FkSdgt2L5Kis521ncDV07qfYZQCrdWRKkizV/nwoaQzzpcgJNnu1x7zhCypmaKLPzqWQG3STo3GxuASOG2ghmcWM5/jkHVKrN9p99y65GezpdbIOrYgO6CV7TiGTJBMv5gwG5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=mfYPF7vH; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=kK7vOvl6LM7OKwbpoPd70MjOZXOBnJLiT9t5EQMM8PA=; b=mfYPF7vH4m3Ut/syqVeIlyMgaa
	jXwRoZOpzVpRy01m0iyOI0WMHOg4hikZUkOa/F9KzA37uLs+v/fkfYddgTq4E+++AHBUl4WPmdreG
	dl9DZtn5dR1n5V0AqsEjEJKS0xtt5R5sPTJ8RDF5Eo+g4gzSxnxqyUYawOthSQdm5F3b9qdebT2ca
	oy8/fkGY/23MTC2YAzUa2K7CC1grUEPkxe3sxzDXzyFr3+aVf2n+UIsHPZZobxno9OJEuEZDWjR4u
	IPvTe4RuUpBJMDHRqUEIM2VSNZKYgnxR27+hLLqUBoV+G+i+UpHHleBSBXciod1oDhNDZstQrQOwo
	HJXzuE+Q==;
Received: from 114-44-254-110.dynamic-ip.hinet.net ([114.44.254.110] helo=gavin-HP-Z840-Workstation..)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uQzt5-003vfb-0p; Mon, 16 Jun 2025 04:47:55 +0200
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
Subject: [PATCH 6.1.y] mm/huge_memory: fix dereferencing invalid pmd migration entry
Date: Mon, 16 Jun 2025 10:47:47 +0800
Message-ID: <20250616024748.1789123-1-gavinguo@igalia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025051203-thrift-spool-ebc8@gregkh>
References: <2025051203-thrift-spool-ebc8@gregkh>
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
index f53bc54dacb3..d697d6b73f2c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2282,6 +2282,7 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 {
 	spinlock_t *ptl;
 	struct mmu_notifier_range range;
+	bool pmd_migration = is_pmd_migration_entry(*pmd);
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
 				address & HPAGE_PMD_MASK,
@@ -2296,13 +2297,12 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
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

base-commit: 58485ff1a74f6c5be9e7c6aafb7293e4337348e7
-- 
2.43.0



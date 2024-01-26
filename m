Return-Path: <stable+bounces-15881-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BBD83D912
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 12:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44AFFB2B10A
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 10:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B58855C31;
	Fri, 26 Jan 2024 09:55:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6125555C1C
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 09:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706262954; cv=none; b=NH0CAL3vG0c2NheUSMMGDMutNvQPhmqtuEJ8+mi40PeRFD2dD3FPxYo0f3HqrHCxkFmtYPD93mS9FDPMVO1XlOeieaddu1JgNwEbYHGDIwZGoi5ZU+qDObCP/b+rKLzWMZxn6/pgVOiULOF/St4Ro5B7UONwZmD1WIXaAwVbNHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706262954; c=relaxed/simple;
	bh=TXRpBSVjCJUcc+Ou62Ur6MM+Di8M71iBf31d0N8EyxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M9v9hve1IiinvRsZjeJ625H/SU51uWUUKW5xhkoDbajHvpp3rOd1W5uQpxwkjLBc382eWwT7J50Wny7nRe+ChLXMw3gxtfWrbaeOidYIJ8zPbFfEKQDOmEayQ75Teuek0RdxlhhC1S7WE7lJtUSrMXDtLbF0ooqH2/ayVnvybr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 7B5802F2022A; Fri, 26 Jan 2024 09:55:50 +0000 (UTC)
X-Spam-Level: 
Received: from shell.ipa.basealt.ru (unknown [176.12.98.74])
	by air.basealt.ru (Postfix) with ESMTPSA id 35BF42F2023C;
	Fri, 26 Jan 2024 09:55:44 +0000 (UTC)
From: oficerovas@altlinux.org
To: stable@vger.kernel.org
Cc: Alexander Ofitserov <oficerovas@altlinux.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	kovalev@altlinux.org,
	nickel@altlinux.org,
	dutyrok@altlinux.org,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH 2/2] KVM: use __vcalloc for very large allocations
Date: Fri, 26 Jan 2024 12:55:14 +0300
Message-ID: <20240126095514.2681649-3-oficerovas@altlinux.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240126095514.2681649-1-oficerovas@altlinux.org>
References: <20240126095514.2681649-1-oficerovas@altlinux.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Ofitserov <oficerovas@altlinux.org>

From: Paolo Bonzini <pbonzini@redhat.com>

commit 37b2a6510a48 ("KVM: use __vcalloc for very large allocations")

Allocations whose size is related to the memslot size can be arbitrarily
large.  Do not use kvzalloc/kvcalloc, as those are limited to "not crazy"
sizes that fit in 32 bits.

URL: https://lore.kernel.org/lkml/20220711090606.962822924@linuxfoundation.org/
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Alexander Ofitserov <oficerovas@altlinux.org>
---
 arch/powerpc/kvm/book3s_hv_uvmem.c | 2 +-
 arch/x86/kvm/mmu/page_track.c      | 2 +-
 arch/x86/kvm/x86.c                 | 4 ++--
 virt/kvm/kvm_main.c                | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
index 3dd58b4ee33e5..5f6b3f80023de 100644
--- a/arch/powerpc/kvm/book3s_hv_uvmem.c
+++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
@@ -250,7 +250,7 @@ int kvmppc_uvmem_slot_init(struct kvm *kvm, const struct kvm_memory_slot *slot)
 	p = kzalloc(sizeof(*p), GFP_KERNEL);
 	if (!p)
 		return -ENOMEM;
-	p->pfns = vzalloc(array_size(slot->npages, sizeof(*p->pfns)));
+	p->pfns = vcalloc(slot->npages, sizeof(*p->pfns));
 	if (!p->pfns) {
 		kfree(p);
 		return -ENOMEM;
diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
index 81cf4babbd0b4..3c379335ea477 100644
--- a/arch/x86/kvm/mmu/page_track.c
+++ b/arch/x86/kvm/mmu/page_track.c
@@ -35,7 +35,7 @@ int kvm_page_track_create_memslot(struct kvm_memory_slot *slot,
 
 	for (i = 0; i < KVM_PAGE_TRACK_MAX; i++) {
 		slot->arch.gfn_track[i] =
-			kvcalloc(npages, sizeof(*slot->arch.gfn_track[i]),
+			__vcalloc(npages, sizeof(*slot->arch.gfn_track[i]),
 				 GFP_KERNEL_ACCOUNT);
 		if (!slot->arch.gfn_track[i])
 			goto track_free;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 13e4699a0744f..6c2bf7cd7aec6 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10826,14 +10826,14 @@ static int kvm_alloc_memslot_metadata(struct kvm_memory_slot *slot,
 				      slot->base_gfn, level) + 1;
 
 		slot->arch.rmap[i] =
-			kvcalloc(lpages, sizeof(*slot->arch.rmap[i]),
+			__vcalloc(lpages, sizeof(*slot->arch.rmap[i]),
 				 GFP_KERNEL_ACCOUNT);
 		if (!slot->arch.rmap[i])
 			goto out_free;
 		if (i == 0)
 			continue;
 
-		linfo = kvcalloc(lpages, sizeof(*linfo), GFP_KERNEL_ACCOUNT);
+		linfo = __vcalloc(lpages, sizeof(*linfo), GFP_KERNEL_ACCOUNT);
 		if (!linfo)
 			goto out_free;
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 356fd5d1a4285..b7638c3c9eb7d 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1008,9 +1008,9 @@ static int kvm_vm_release(struct inode *inode, struct file *filp)
  */
 static int kvm_alloc_dirty_bitmap(struct kvm_memory_slot *memslot)
 {
-	unsigned long dirty_bytes = 2 * kvm_dirty_bitmap_bytes(memslot);
+	unsigned long dirty_bytes = kvm_dirty_bitmap_bytes(memslot);
 
-	memslot->dirty_bitmap = kvzalloc(dirty_bytes, GFP_KERNEL_ACCOUNT);
+	memslot->dirty_bitmap = __vcalloc(2, dirty_bytes, GFP_KERNEL_ACCOUNT);
 	if (!memslot->dirty_bitmap)
 		return -ENOMEM;
 
-- 
2.42.1



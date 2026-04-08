Return-Path: <stable+bounces-233906-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uESNG3lb1mk1EggAu9opvQ
	(envelope-from <stable+bounces-233906-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 15:43:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5763BD159
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 15:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 694B33088B8E
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 13:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E631D3CF665;
	Wed,  8 Apr 2026 13:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ky4bW9K9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62313CF042
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 13:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775655447; cv=none; b=CIUKtN3kYbSWxvFOIwVPbNtc4MVqUClHlJLx1HDBB3RTqfVO502QNhzdtAO+QemV2JUG8JNYwgCiOodCOHoq/2JaVr+ig19mVCzUhMNhLDEFx9RnR0+jFUpNWrln+5f6mZ657ozIyGk5qMcyThnQYwW4Bzh3gwfgzJe931l95/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775655447; c=relaxed/simple;
	bh=5nKJVaP9yOao5Rmc2Mv1zPZPIxHX5uZQLZpmV53Ig7E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=trgdcu90tR+HBq0m/1izLgSBycXE07v3iWJ5YXRW1YSvRa89g46BPpRT1VESPsiKCM1XVWWYU+RCfUOVlzfxmpgrqv8Z6OpqKDNCwTQXT/hAXkcuNSXtCsK11Nk6WDPfqB9CV5G+hhMDIhlOS1D6c6K0MDkOdgTlNPz4pC8YfAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ky4bW9K9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9F4C19421;
	Wed,  8 Apr 2026 13:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775655447;
	bh=5nKJVaP9yOao5Rmc2Mv1zPZPIxHX5uZQLZpmV53Ig7E=;
	h=Subject:To:Cc:From:Date:From;
	b=ky4bW9K9zwGSDMlH/j54Vcwnh4HPKqIrpFloHk5gmrwYxkCASeBvAalFm6lxY6RDP
	 7HXwqSUcgzH3D7C1BVz/nPMl7dbrDFlNIbsfz8p1eYVeXmC1l/+F4AbKViD9hIjCAd
	 hlsX+yps+C++qFlOL6jPCFW8FAc+nIUjow5KwrVI=
Subject: FAILED: patch "[PATCH] RISC-V: KVM: Remove automatic I/O mapping for VM_PFNMAP" failed to apply to 6.6-stable tree
To: fangyu.yu@linux.alibaba.com,anup@brainfault.org,dbarboza@ventanamicro.com,guoren@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 08 Apr 2026 15:37:25 +0200
Message-ID: <2026040824-chess-override-1b55@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233906-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email,ventanamicro.com:email,brainfault.org:email]
X-Rspamd-Queue-Id: BF5763BD159
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 8c5fa3764facaad6d38336e90f406c2c11d69733
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026040824-chess-override-1b55@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8c5fa3764facaad6d38336e90f406c2c11d69733 Mon Sep 17 00:00:00 2001
From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Date: Tue, 21 Oct 2025 22:21:31 +0800
Subject: [PATCH] RISC-V: KVM: Remove automatic I/O mapping for VM_PFNMAP

As of commit aac6db75a9fc ("vfio/pci: Use unmap_mapping_range()"),
vm_pgoff may no longer guaranteed to hold the PFN for VM_PFNMAP
regions. Using vma->vm_pgoff to derive the HPA here may therefore
produce incorrect mappings.

Instead, I/O mappings for such regions can be established on-demand
during g-stage page faults, making the upfront ioremap in this path
is unnecessary.

Fixes: aac6db75a9fc ("vfio/pci: Use unmap_mapping_range()")
Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Tested-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Anup Patel <anup@brainfault.org>
Link: https://lore.kernel.org/r/20251021142131.78796-1-fangyu.yu@linux.alibaba.com
Signed-off-by: Anup Patel <anup@brainfault.org>

diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 525fb5a330c0..58f5f3536ffd 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -171,7 +171,6 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 				enum kvm_mr_change change)
 {
 	hva_t hva, reg_end, size;
-	gpa_t base_gpa;
 	bool writable;
 	int ret = 0;
 
@@ -190,15 +189,13 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 	hva = new->userspace_addr;
 	size = new->npages << PAGE_SHIFT;
 	reg_end = hva + size;
-	base_gpa = new->base_gfn << PAGE_SHIFT;
 	writable = !(new->flags & KVM_MEM_READONLY);
 
 	mmap_read_lock(current->mm);
 
 	/*
 	 * A memory region could potentially cover multiple VMAs, and
-	 * any holes between them, so iterate over all of them to find
-	 * out if we can map any of them right now.
+	 * any holes between them, so iterate over all of them.
 	 *
 	 *     +--------------------------------------------+
 	 * +---------------+----------------+   +----------------+
@@ -209,7 +206,7 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 	 */
 	do {
 		struct vm_area_struct *vma;
-		hva_t vm_start, vm_end;
+		hva_t vm_end;
 
 		vma = find_vma_intersection(current->mm, hva, reg_end);
 		if (!vma)
@@ -225,36 +222,18 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 		}
 
 		/* Take the intersection of this VMA with the memory region */
-		vm_start = max(hva, vma->vm_start);
 		vm_end = min(reg_end, vma->vm_end);
 
 		if (vma->vm_flags & VM_PFNMAP) {
-			gpa_t gpa = base_gpa + (vm_start - hva);
-			phys_addr_t pa;
-
-			pa = (phys_addr_t)vma->vm_pgoff << PAGE_SHIFT;
-			pa += vm_start - vma->vm_start;
-
 			/* IO region dirty page logging not allowed */
 			if (new->flags & KVM_MEM_LOG_DIRTY_PAGES) {
 				ret = -EINVAL;
 				goto out;
 			}
-
-			ret = kvm_riscv_mmu_ioremap(kvm, gpa, pa, vm_end - vm_start,
-						    writable, false);
-			if (ret)
-				break;
 		}
 		hva = vm_end;
 	} while (hva < reg_end);
 
-	if (change == KVM_MR_FLAGS_ONLY)
-		goto out;
-
-	if (ret)
-		kvm_riscv_mmu_iounmap(kvm, base_gpa, size);
-
 out:
 	mmap_read_unlock(current->mm);
 	return ret;



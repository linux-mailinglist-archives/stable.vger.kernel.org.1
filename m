Return-Path: <stable+bounces-116719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FBEA39ABE
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 12:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E01DD1893BC8
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 11:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E045D233D8C;
	Tue, 18 Feb 2025 11:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="firKkYvU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDA21B21B7
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 11:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739878061; cv=none; b=qopCmZFEA9hfJpbnirfDV6TA07inYaB6bmkP0jqjS7+A6Rwg8E/QqbrhWmxPyIyXoe7gDcYFUTHuaUzRLWVvNMBykLDm8YjoDjdkaQrjW2iFUejtsB5tbFA9O5gkHJ8tExdQDZ+oULs9ci9G4VNytDxDzzPpXgCjwSizxXEIW0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739878061; c=relaxed/simple;
	bh=9rebkhPhys0lIZB7CgBhnRg06nk7H8gxcS/4nHi4/1Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rYRLOGANWT/m3NM6J3QoBJ3TkeLK0lcDg7l6t1567ZHIQNxoRGP8lC7+zYmfYawaoXxm6X5PdQvqedtojpvaISBdqU9alfqysDhFJvP6o/tUCAv7it9201tVor9IpFCIPMY6TdnVoUXSkQr5pe64fHdOMdIhbp4OhdouuzNrrtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=firKkYvU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97632C4CEE2;
	Tue, 18 Feb 2025 11:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739878061;
	bh=9rebkhPhys0lIZB7CgBhnRg06nk7H8gxcS/4nHi4/1Y=;
	h=Subject:To:Cc:From:Date:From;
	b=firKkYvU4E4jbpaB6J+JcfHEKKR3ymenPdi+aBlghKRvxahgWmFklTrFMm1FL7Vq9
	 Q6LVaURvV/S8BeWuPb990bcQ1XFkN6ozpkpDYIiy6t4X0AtHCgys+HKAHN4fYH/PTJ
	 cw2JlT39hLHJKCDj0hSozlsZ4yeZ7otWmcT617Gw=
Subject: FAILED: patch "[PATCH] KVM: nSVM: Enter guest mode before initializing nested NPT" failed to apply to 5.10-stable tree
To: seanjc@google.com,yosry.ahmed@linux.dev
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 18 Feb 2025 12:27:38 +0100
Message-ID: <2025021837-volumes-twig-2514@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 46d6c6f3ef0eaff71c2db6d77d4e2ebb7adac34f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021837-volumes-twig-2514@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 46d6c6f3ef0eaff71c2db6d77d4e2ebb7adac34f Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Wed, 29 Jan 2025 17:08:25 -0800
Subject: [PATCH] KVM: nSVM: Enter guest mode before initializing nested NPT
 MMU

When preparing vmcb02 for nested VMRUN (or state restore), "enter" guest
mode prior to initializing the MMU for nested NPT so that guest_mode is
set in the MMU's role.  KVM's model is that all L2 MMUs are tagged with
guest_mode, as the behavior of hypervisor MMUs tends to be significantly
different than kernel MMUs.

Practically speaking, the bug is relatively benign, as KVM only directly
queries role.guest_mode in kvm_mmu_free_guest_mode_roots() and
kvm_mmu_page_ad_need_write_protect(), which SVM doesn't use, and in paths
that are optimizations (mmu_page_zap_pte() and
shadow_mmu_try_split_huge_pages()).

And while the role is incorprated into shadow page usage, because nested
NPT requires KVM to be using NPT for L1, reusing shadow pages across L1
and L2 is impossible as L1 MMUs will always have direct=1, while L2 MMUs
will have direct=0.

Hoist the TLB processing and setting of HF_GUEST_MASK to the beginning
of the flow instead of forcing guest_mode in the MMU, as nothing in
nested_vmcb02_prepare_control() between the old and new locations touches
TLB flush requests or HF_GUEST_MASK, i.e. there's no reason to present
inconsistent vCPU state to the MMU.

Fixes: 69cb877487de ("KVM: nSVM: move MMU setup to nested_prepare_vmcb_control")
Cc: stable@vger.kernel.org
Reported-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Link: https://lore.kernel.org/r/20250130010825.220346-1-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 74c20dbb92da..d4ac4a1f8b81 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5540,7 +5540,7 @@ void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr0,
 	union kvm_mmu_page_role root_role;
 
 	/* NPT requires CR0.PG=1. */
-	WARN_ON_ONCE(cpu_role.base.direct);
+	WARN_ON_ONCE(cpu_role.base.direct || !cpu_role.base.guest_mode);
 
 	root_role = cpu_role.base;
 	root_role.level = kvm_mmu_get_tdp_level(vcpu);
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index d77b094d9a4d..04c375bf1ac2 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -646,6 +646,11 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
 	u32 pause_count12;
 	u32 pause_thresh12;
 
+	nested_svm_transition_tlb_flush(vcpu);
+
+	/* Enter Guest-Mode */
+	enter_guest_mode(vcpu);
+
 	/*
 	 * Filled at exit: exit_code, exit_code_hi, exit_info_1, exit_info_2,
 	 * exit_int_info, exit_int_info_err, next_rip, insn_len, insn_bytes.
@@ -762,11 +767,6 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
 		}
 	}
 
-	nested_svm_transition_tlb_flush(vcpu);
-
-	/* Enter Guest-Mode */
-	enter_guest_mode(vcpu);
-
 	/*
 	 * Merge guest and host intercepts - must be called with vcpu in
 	 * guest-mode to take effect.



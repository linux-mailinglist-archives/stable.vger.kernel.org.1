Return-Path: <stable+bounces-116718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8E1A39ABD
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 12:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1542C16FCA8
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 11:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2822B233D8C;
	Tue, 18 Feb 2025 11:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="thHKXIRF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9851B21B7
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 11:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739878047; cv=none; b=bZj+tJTEa2dWNvNsLsZYqWJP/wlgffyB77JT1xAu4p2j4Hckz9Oj5I8d7sBO7bC9pay3p1BGzikQ/q828hHVqJg6aaut6O32aNLAer1Dyhch9aF+VY4teRT/CgWJqrZ4Z8MYzkX0SIS68m7MBz8vIwjVsje8nLKrd6nGtj9Z/lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739878047; c=relaxed/simple;
	bh=8Utp6T41kPrcgXwZ+iMVHoD/k1c6qEQXzEf00UC9dyE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=of6mgCnWUo8LD2mnrLFNDTl3Of4tEB5+AhOMMJ8HIhYl3Jf8NjjvzuTE41tJmQkt9ukpFjM0HtjOSFzfl7g6jXwrZYiRTuedWKSlwrmTpT9iPzzY/V+i/nV71QsQQQHJyVwooPgfdRWSeEjMWju5/QvdzAtcb130DvpMFvEKVIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=thHKXIRF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DFB0C4CEE2;
	Tue, 18 Feb 2025 11:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739878047;
	bh=8Utp6T41kPrcgXwZ+iMVHoD/k1c6qEQXzEf00UC9dyE=;
	h=Subject:To:Cc:From:Date:From;
	b=thHKXIRFZfZBXybdaUzic+a0R7VCfOkxiU4LQDD8G05Eh5wk7ztfetpotjnFVAWiV
	 EMYGURhEolkcGRtU8trPshbNNgbcNbsgaeLxkN8uCdlANfPXpGtw96cJUnRYMeaVQq
	 9iUW8pLack3MOutj/P9oD6XaBr9DRiBR8mxMh24I=
Subject: FAILED: patch "[PATCH] KVM: nSVM: Enter guest mode before initializing nested NPT" failed to apply to 5.15-stable tree
To: seanjc@google.com,yosry.ahmed@linux.dev
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 18 Feb 2025 12:27:24 +0100
Message-ID: <2025021824-strict-motivator-41ae@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 46d6c6f3ef0eaff71c2db6d77d4e2ebb7adac34f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021824-strict-motivator-41ae@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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



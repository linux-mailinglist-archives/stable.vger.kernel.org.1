Return-Path: <stable+bounces-118145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD89BA3BA90
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E40B3BA8FE
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBA21DC996;
	Wed, 19 Feb 2025 09:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XADDEteA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3866E1BEF71;
	Wed, 19 Feb 2025 09:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739957365; cv=none; b=dQwFOxb4PP7yx7edT73nFYXglRv9sYbBqRJYUOayc6pkBtScm1fWmoFTxN/wtihNopWelcyqyHsnNOu1+GC3MF+G1WHwFSdXepvMKP33okwR41uUh+GWNm4dAqFmdJn5KSh4Sup0lGKa/5aSPB9YquwCfn38/cPObUodlJZRAx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739957365; c=relaxed/simple;
	bh=cRrJHCW7VNBXgLb4xq/9XRlELfHuLK/RBQO0gLsko50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TaFg8FTTwvnCJ9xWj6jDUEsgrG9RHusILT/nfuCuVV74c0MJpVXufpgS7XJxpXanS2DVz6cJTVeS8eHZbphzF9Rl4C34ADCSk7NS4alDwIpStMWANfSvE7SfKqfYu4laiwjBfpsKpTyKhZdYXoDERkXO9KRvBtPnjxGKFdI6JWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XADDEteA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7097C4CED1;
	Wed, 19 Feb 2025 09:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739957365;
	bh=cRrJHCW7VNBXgLb4xq/9XRlELfHuLK/RBQO0gLsko50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XADDEteAuG7lRgIcduNEFOSxU78ymMlwUN9zUZjRXeukgw0KatzRFSzYycKHFNmCf
	 nkFyK3xW6xBYPrw/Pfff76wogs/dMMnNio54z49tn2v/2JvInNs5NKuKjiqVBEmQWL
	 FzACMIw0MbNtEwsClmAVnrijn4OVIEY+mEgSeJjE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.1 501/578] KVM: nSVM: Enter guest mode before initializing nested NPT MMU
Date: Wed, 19 Feb 2025 09:28:25 +0100
Message-ID: <20250219082712.696679043@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082652.891560343@linuxfoundation.org>
References: <20250219082652.891560343@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <seanjc@google.com>

commit 46d6c6f3ef0eaff71c2db6d77d4e2ebb7adac34f upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/mmu/mmu.c    |    2 +-
 arch/x86/kvm/svm/nested.c |   10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5150,7 +5150,7 @@ void kvm_init_shadow_npt_mmu(struct kvm_
 	union kvm_mmu_page_role root_role;
 
 	/* NPT requires CR0.PG=1. */
-	WARN_ON_ONCE(cpu_role.base.direct);
+	WARN_ON_ONCE(cpu_role.base.direct || !cpu_role.base.guest_mode);
 
 	root_role = cpu_role.base;
 	root_role.level = kvm_mmu_get_tdp_level(vcpu);
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -619,6 +619,11 @@ static void nested_vmcb02_prepare_contro
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
@@ -717,11 +722,6 @@ static void nested_vmcb02_prepare_contro
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




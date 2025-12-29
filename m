Return-Path: <stable+bounces-203609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DE192CE7027
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5CDC73001600
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 14:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB1931D366;
	Mon, 29 Dec 2025 14:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bXyZsvOY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F032331BC94
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 14:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767018417; cv=none; b=hTLXDAWCYYhyj9IdO/lAOcuisp/CBSYyOyPSV13pVJTqM8c6To8sOzJR8FBhL95YBtTNZ91SBalXFvrXKTq3QXhHKqxpfUnPk3vGcfNptL2exqxTYgzqc1DdWcxfb+lGG0X78TzuqbPs8yiRZ+0msZRhfHjfoxz+whUFBj2W4ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767018417; c=relaxed/simple;
	bh=r4ejCt9Zs053h40agfKc4bhPtfNIorZo61kKiHrDAD4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=i8x1mW3EFyJiNkGbr1qjZLomnCnI4xtt3K3kQ6P8xc0Wj/YoN6aTK+Nb84kmDpqG84keCFeym7vxqSicCaQ2KVPMacPEs93tC1KOBj2vOWYj98prlg5X14uiIh3ahyWLc70BdUKn09xRIZKR9hI724RsFFZt10p9Dk87voSuoJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bXyZsvOY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70DA4C4CEF7;
	Mon, 29 Dec 2025 14:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767018416;
	bh=r4ejCt9Zs053h40agfKc4bhPtfNIorZo61kKiHrDAD4=;
	h=Subject:To:Cc:From:Date:From;
	b=bXyZsvOYkstYL6i7vZoexaAEvLc/asrJ0dWZ8SsZNgMkkIyvc9O1nBbbwVgyacb4C
	 QgEJVXMtiojsiKcudP/ajhwl09OX1KsTieizY5/8O5A+It+qExiY6QQlWQk4s9VNyt
	 mDoOb+4bpenB+7pN+zDRwxt+emKO/JrPLIiI49Yo=
Subject: FAILED: patch "[PATCH] KVM: nSVM: Avoid incorrect injection of" failed to apply to 5.15-stable tree
To: yosry.ahmed@linux.dev,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 15:26:54 +0100
Message-ID: <2025122954-augmented-paralyses-a384@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 3d80f4c93d3d26d0f9a0dd2844961a632eeea634
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122954-augmented-paralyses-a384@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3d80f4c93d3d26d0f9a0dd2844961a632eeea634 Mon Sep 17 00:00:00 2001
From: Yosry Ahmed <yosry.ahmed@linux.dev>
Date: Fri, 24 Oct 2025 19:29:18 +0000
Subject: [PATCH] KVM: nSVM: Avoid incorrect injection of
 SVM_EXIT_CR0_SEL_WRITE
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When emulating L2 instructions, svm_check_intercept() checks whether a
write to CR0 should trigger a synthesized #VMEXIT with
SVM_EXIT_CR0_SEL_WRITE. However, it does not check whether L1 enabled
the intercept for SVM_EXIT_WRITE_CR0, which has higher priority
according to the APM (24593—Rev.  3.42—March 2024, Table 15-7):

  When both selective and non-selective CR0-write intercepts are active at
  the same time, the non-selective intercept takes priority. With respect
  to exceptions, the priority of this intercept is the same as the generic
  CR0-write intercept.

Make sure L1 does NOT intercept SVM_EXIT_WRITE_CR0 before checking if
SVM_EXIT_CR0_SEL_WRITE needs to be injected.

Opportunistically tweak the "not CR0" logic to explicitly bail early so
that it's more obvious that only CR0 has a selective intercept, and that
modifying icpt_info.exit_code is functionally necessary so that the call
to nested_svm_exit_handled() checks the correct exit code.

Fixes: cfec82cb7d31 ("KVM: SVM: Add intercept check for emulated cr accesses")
Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Link: https://patch.msgid.link/20251024192918.3191141-4-yosry.ahmed@linux.dev
[sean: isolate non-CR0 write logic, tweak comments accordingly]
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index bd8df212a59d..1ae7b3c5a7c5 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4535,15 +4535,29 @@ static int svm_check_intercept(struct kvm_vcpu *vcpu,
 	case SVM_EXIT_WRITE_CR0: {
 		unsigned long cr0, val;
 
-		if (info->intercept == x86_intercept_cr_write)
+		/*
+		 * Adjust the exit code accordingly if a CR other than CR0 is
+		 * being written, and skip straight to the common handling as
+		 * only CR0 has an additional selective intercept.
+		 */
+		if (info->intercept == x86_intercept_cr_write && info->modrm_reg) {
 			icpt_info.exit_code += info->modrm_reg;
+			break;
+		}
 
-		if (icpt_info.exit_code != SVM_EXIT_WRITE_CR0 ||
-		    info->intercept == x86_intercept_clts)
+		/*
+		 * Convert the exit_code to SVM_EXIT_CR0_SEL_WRITE if a
+		 * selective CR0 intercept is triggered (the common logic will
+		 * treat the selective intercept as being enabled).  Note, the
+		 * unconditional intercept has higher priority, i.e. this is
+		 * only relevant if *only* the selective intercept is enabled.
+		 */
+		if (vmcb12_is_intercept(&svm->nested.ctl, INTERCEPT_CR0_WRITE) ||
+		    !(vmcb12_is_intercept(&svm->nested.ctl, INTERCEPT_SELECTIVE_CR0)))
 			break;
 
-		if (!(vmcb12_is_intercept(&svm->nested.ctl,
-					INTERCEPT_SELECTIVE_CR0)))
+		/* CLTS never triggers INTERCEPT_SELECTIVE_CR0 */
+		if (info->intercept == x86_intercept_clts)
 			break;
 
 		/* LMSW always triggers INTERCEPT_SELECTIVE_CR0 */



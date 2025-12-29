Return-Path: <stable+bounces-203634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F48CE7180
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE7D230213DC
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 14:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD8F322B6E;
	Mon, 29 Dec 2025 14:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PY59CPJK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE405321F27
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 14:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767019171; cv=none; b=jgODIyc7OAsGUURDFwQsaHqql+8g1snU030KkH8zaWuTlTsqHzg4Ch6P1jqIuQXyRPLsRibZDXV/4PKwWZfPytRctqq2Ey93t2mrwQqXu7osCeHOP9gF6FZLW46yOPA3FCBdplEls/SITpKZRgszrNf0ZSQXetFKGfvtp7cHXD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767019171; c=relaxed/simple;
	bh=lbH/a987o+gvTgiM9TTHCLdRPxZ48B2kMID2HPYYhvs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PsxsomYqWLj/9CNGpHZNgyQK3FCSTO2QWeEx+sLby5cGZ6pj3eqjSzZw7S8aHSGjd2BciG6LBwskbMF5yg3PYWOm88UjArftBN7dCRhHcV0ZTdq98BHdQYwWVxj/PXYG6vv7kkjifsL1HWuQyzhmJCh5dtHTf1lOVX8S27HfgOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PY59CPJK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B06DC4CEF7;
	Mon, 29 Dec 2025 14:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767019170;
	bh=lbH/a987o+gvTgiM9TTHCLdRPxZ48B2kMID2HPYYhvs=;
	h=Subject:To:Cc:From:Date:From;
	b=PY59CPJK9G+B9XetLy/2xtIOUuWYey8D0pkJz4Wiz21F40T7iY0i5/8rzhVZBTu4Z
	 d8rizx0I3E53CCkpuENTxG/f3lRRMHRIGi8EUOggHApgF+Me4LwRiBWIM2HQLALfDY
	 Euf+b5fAZ5ZpLojlM8YSUZxTb2BVUdlMecGtROq4=
Subject: FAILED: patch "[PATCH] KVM: SVM: Mark VMCB_NPT as dirty on nested VMRUN" failed to apply to 5.15-stable tree
To: jmattson@google.com,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 15:36:29 +0100
Message-ID: <2025122929-riveter-outreach-a5e9@gregkh>
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
git cherry-pick -x 7c8b465a1c91f674655ea9cec5083744ec5f796a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122929-riveter-outreach-a5e9@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7c8b465a1c91f674655ea9cec5083744ec5f796a Mon Sep 17 00:00:00 2001
From: Jim Mattson <jmattson@google.com>
Date: Mon, 22 Sep 2025 09:29:23 -0700
Subject: [PATCH] KVM: SVM: Mark VMCB_NPT as dirty on nested VMRUN

Mark the VMCB_NPT bit as dirty in nested_vmcb02_prepare_save()
on every nested VMRUN.

If L1 changes the PAT MSR between two VMRUN instructions on the same
L1 vCPU, the g_pat field in the associated vmcb02 will change, and the
VMCB_NPT clean bit should be cleared.

Fixes: 4bb170a5430b ("KVM: nSVM: do not mark all VMCB02 fields dirty on nested vmexit")
Cc: stable@vger.kernel.org
Signed-off-by: Jim Mattson <jmattson@google.com>
Link: https://lore.kernel.org/r/20250922162935.621409-3-jmattson@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 35cea27862c6..83de3456df70 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -613,6 +613,7 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm, struct vmcb *vmcb12
 	struct kvm_vcpu *vcpu = &svm->vcpu;
 
 	nested_vmcb02_compute_g_pat(svm);
+	vmcb_mark_dirty(vmcb02, VMCB_NPT);
 
 	/* Load the nested guest state */
 	if (svm->nested.vmcb12_gpa != svm->nested.last_vmcb12_gpa) {



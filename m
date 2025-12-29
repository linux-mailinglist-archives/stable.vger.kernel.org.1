Return-Path: <stable+bounces-203611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFCBCE702D
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1A3B3009F4A
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 14:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D6B31D371;
	Mon, 29 Dec 2025 14:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sJHFGexy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1131B31D366
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 14:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767018473; cv=none; b=tbSSaH2i8GDhGQblB4ZzeO+8ycFvDa7R/0Rvt33YmxJTWLTX0L5Natc5Vv0MISYacIwxi641vHziivAsFFDsdtm4IJOmLhH3lCjrkkT+0JAq9vWKZ0w5Kg9pbXVa9f3Z7kp0DZB/t2REUoyYP1o+bP9Bd/u9fIwX0u3eAb4kF+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767018473; c=relaxed/simple;
	bh=AIl/kaJith+CWHalB8ABSkL6DafnAgidS/SJaphJ8lQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lVxxUESAMcG/NL6uxEQKcNyGNYgT+gSyv8V4bCbH7x4JzMhNro/inEyOy4SnK3tA1L/zPAPFB8znLyy5ODwVGSaSr2pI8k5MA9EsYDtS+KQx9kiYymf098OY+Z/MVkpXFVfU+XkDoGZHkAFv9uKNfBP0De3Gj022MgeIgHBCh8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sJHFGexy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E58FC4CEF7;
	Mon, 29 Dec 2025 14:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767018472;
	bh=AIl/kaJith+CWHalB8ABSkL6DafnAgidS/SJaphJ8lQ=;
	h=Subject:To:Cc:From:Date:From;
	b=sJHFGexy7OHzZVOCLzEGyTI6HzFifpMQZuEXNDPLP1+x3t5thLAo+8XbAU/F/LGmT
	 RdJOIpu5FjLDG6rg26yq0GDaYit+xmhF+u3h5eT6fFhz+CEOPcxS+mu5kuxjg2+NTM
	 6zpuLi6wlpwz+0+GEAb1IT1vzFn5v5maSsiIlOo0=
Subject: FAILED: patch "[PATCH] KVM: SVM: Mark VMCB_PERM_MAP as dirty on nested VMRUN" failed to apply to 5.10-stable tree
To: jmattson@google.com,matteorizzo@google.com,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 15:27:50 +0100
Message-ID: <2025122950-corroding-irritant-bfbf@gregkh>
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
git cherry-pick -x 93c9e107386dbe1243287a5b14ceca894de372b9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122950-corroding-irritant-bfbf@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 93c9e107386dbe1243287a5b14ceca894de372b9 Mon Sep 17 00:00:00 2001
From: Jim Mattson <jmattson@google.com>
Date: Mon, 22 Sep 2025 09:29:22 -0700
Subject: [PATCH] KVM: SVM: Mark VMCB_PERM_MAP as dirty on nested VMRUN

Mark the VMCB_PERM_MAP bit as dirty in nested_vmcb02_prepare_control()
on every nested VMRUN.

If L1 changes MSR interception (INTERCEPT_MSR_PROT) between two VMRUN
instructions on the same L1 vCPU, the msrpm_base_pa in the associated
vmcb02 will change, and the VMCB_PERM_MAP clean bit should be cleared.

Fixes: 4bb170a5430b ("KVM: nSVM: do not mark all VMCB02 fields dirty on nested vmexit")
Reported-by: Matteo Rizzo <matteorizzo@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jim Mattson <jmattson@google.com>
Link: https://lore.kernel.org/r/20250922162935.621409-2-jmattson@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index a6443feab252..35cea27862c6 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -752,6 +752,7 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
 	vmcb02->control.nested_ctl = vmcb01->control.nested_ctl;
 	vmcb02->control.iopm_base_pa = vmcb01->control.iopm_base_pa;
 	vmcb02->control.msrpm_base_pa = vmcb01->control.msrpm_base_pa;
+	vmcb_mark_dirty(vmcb02, VMCB_PERM_MAP);
 
 	/*
 	 * Stash vmcb02's counter if the guest hasn't moved past the guilty



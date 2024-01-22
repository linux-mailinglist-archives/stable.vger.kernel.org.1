Return-Path: <stable+bounces-12783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF2183738E
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 21:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6D2328F539
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 20:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CFA405EA;
	Mon, 22 Jan 2024 20:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hyaVAbnp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BC13DB86
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 20:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705954419; cv=none; b=RIFMQ/b2Hli8sXJ7+R7iXKgydX8UlR8tLWBondaNdL0YMyrQJbbqsCErpK+rGDKngUVQWdonqWx/wdj/uaj3m4lWYiP0TofeT1lhT5B0tuCrMfIwHUSO98zURxWcaTiRrg2eYy56UJ4742A9SWxt6sIEA9bJKOqerB57KfrzG5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705954419; c=relaxed/simple;
	bh=ivNBa+W1W2qQrhAJy6RHF3HObpSOS58qTSj1Ed4T2DY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=j2mzp5xUypdZdilIos3UxSNk1yhFGrvfnjblmN8hbH4tL3Ls8Gw5olu1di5rK0uH4ydkBdfD3hWrnwcXe951mOpTGO7lCDDXzj2th6G45ezzKW/sEry2XUKZjPVoMT2Mt+lh5zi6mjZTPY0oWsCZvnQM86RvBWZdNiQdM1desyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hyaVAbnp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA1AC433C7;
	Mon, 22 Jan 2024 20:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705954418;
	bh=ivNBa+W1W2qQrhAJy6RHF3HObpSOS58qTSj1Ed4T2DY=;
	h=Subject:To:Cc:From:Date:From;
	b=hyaVAbnp7iqwh6hqlESpk3s4R4/7hMfnDP5S+QxR9qkp5Lax9TH9O867woxyKvOqT
	 vl19xEnXeWKIlKA2ibtIMTonIsY446KQOUnsEt4Nnl2YUfYzVJz/aCD7agVXaNkH8j
	 fCHWkPuhA4xhTza5gcbr8khOo87u13t5y++6sFC4=
Subject: FAILED: patch "[PATCH] Revert "nSVM: Check for reserved encodings of TLB_CONTROL in" failed to apply to 6.1-stable tree
To: seanjc@google.com,mlevitsk@redhat.com,s.sterz@proxmox.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 22 Jan 2024 12:13:36 -0800
Message-ID: <2024012236-pebbly-coroner-581f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a484755ab2526ebdbe042397cdd6e427eb4b1a68
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012236-pebbly-coroner-581f@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

a484755ab252 ("Revert "nSVM: Check for reserved encodings of TLB_CONTROL in nested VMCB"")
0977cfac6e76 ("KVM: nSVM: Implement support for nested VNMI")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a484755ab2526ebdbe042397cdd6e427eb4b1a68 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Wed, 18 Oct 2023 12:41:03 -0700
Subject: [PATCH] Revert "nSVM: Check for reserved encodings of TLB_CONTROL in
 nested VMCB"

Revert KVM's made-up consistency check on SVM's TLB control.  The APM says
that unsupported encodings are reserved, but the APM doesn't state that
VMRUN checks for a supported encoding.  Unless something is called out
in "Canonicalization and Consistency Checks" or listed as MBZ (Must Be
Zero), AMD behavior is typically to let software shoot itself in the foot.

This reverts commit 174a921b6975ef959dd82ee9e8844067a62e3ec1.

Fixes: 174a921b6975 ("nSVM: Check for reserved encodings of TLB_CONTROL in nested VMCB")
Reported-by: Stefan Sterz <s.sterz@proxmox.com>
Closes: https://lkml.kernel.org/r/b9915c9c-4cf6-051a-2d91-44cc6380f455%40proxmox.com
Cc: stable@vger.kernel.org
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Link: https://lore.kernel.org/r/20231018194104.1896415-2-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 3fea8c47679e..60891b9ce25f 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -247,18 +247,6 @@ static bool nested_svm_check_bitmap_pa(struct kvm_vcpu *vcpu, u64 pa, u32 size)
 	    kvm_vcpu_is_legal_gpa(vcpu, addr + size - 1);
 }
 
-static bool nested_svm_check_tlb_ctl(struct kvm_vcpu *vcpu, u8 tlb_ctl)
-{
-	/* Nested FLUSHBYASID is not supported yet.  */
-	switch(tlb_ctl) {
-		case TLB_CONTROL_DO_NOTHING:
-		case TLB_CONTROL_FLUSH_ALL_ASID:
-			return true;
-		default:
-			return false;
-	}
-}
-
 static bool __nested_vmcb_check_controls(struct kvm_vcpu *vcpu,
 					 struct vmcb_ctrl_area_cached *control)
 {
@@ -278,9 +266,6 @@ static bool __nested_vmcb_check_controls(struct kvm_vcpu *vcpu,
 					   IOPM_SIZE)))
 		return false;
 
-	if (CC(!nested_svm_check_tlb_ctl(vcpu, control->tlb_ctl)))
-		return false;
-
 	if (CC((control->int_ctl & V_NMI_ENABLE_MASK) &&
 	       !vmcb12_is_intercept(control, INTERCEPT_NMI))) {
 		return false;



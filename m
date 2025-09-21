Return-Path: <stable+bounces-180776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3081B8DAEC
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 14:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D04A17BC3B
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 12:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341E344C63;
	Sun, 21 Sep 2025 12:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UW1mWEQX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E420A1853
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 12:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758457886; cv=none; b=ohRJALIjarr3mkaty++T8UH9oCc8jY2mubqYZ1lUd1Z9u4KVEFv7hXKAX1l4x+7TDURH+1GBkBj+EFC4ELNmBt399510ZnUrdwKnVWsTGe3KpkRi91k5DeRggihqHR4BSyKFkH3YPRbrx+f485ZNy13EvguCR5viZDg3ZG+kqGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758457886; c=relaxed/simple;
	bh=A83+TgY5Wes8H7D84aXNYy0b8UlSb0weLWV3oB7MnPk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mB2DoEhC//ps3opKG7/npsXPJsUyGdmVSa7SkT/fEVl0h9U3ribh4aqy3IXCnHhkgVJoG5Y1jrlJ70gmAfmWr53A7gDhVCRpCVQGdhdKqIvZ3b5wsa2hoocrAANn5POxwG70X1vlxqdeauEFOivOejhwLOg0HQQaZXV4sfs/HeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UW1mWEQX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D563C4CEE7;
	Sun, 21 Sep 2025 12:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758457885;
	bh=A83+TgY5Wes8H7D84aXNYy0b8UlSb0weLWV3oB7MnPk=;
	h=Subject:To:Cc:From:Date:From;
	b=UW1mWEQX4Gitafvxx4Voeu4O4xQ7Z64+U8CRDDK0uXfXDrm3PFzF5+RxHzNYIcw5+
	 85jtL33+hcSTzjMyllP5V/oSpxFdVofJEaGkvEOWuDGrqNY9UUF8CA8S76dYzit1Ye
	 wTwrvjkbKWeB+vBLHyfyUwyQUg5cijfLApEbG/vg=
Subject: FAILED: patch "[PATCH] KVM: SVM: Sync TPR from LAPIC into VMCB::V_TPR even if AVIC" failed to apply to 5.4-stable tree
To: maciej.szmigiero@oracle.com,naveen@kernel.org,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 21 Sep 2025 14:31:22 +0200
Message-ID: <2025092122-popper-small-d970@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x d02e48830e3fce9701265f6c5a58d9bdaf906a76
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025092122-popper-small-d970@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d02e48830e3fce9701265f6c5a58d9bdaf906a76 Mon Sep 17 00:00:00 2001
From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Date: Mon, 25 Aug 2025 18:44:28 +0200
Subject: [PATCH] KVM: SVM: Sync TPR from LAPIC into VMCB::V_TPR even if AVIC
 is active

Commit 3bbf3565f48c ("svm: Do not intercept CR8 when enable AVIC")
inhibited pre-VMRUN sync of TPR from LAPIC into VMCB::V_TPR in
sync_lapic_to_cr8() when AVIC is active.

AVIC does automatically sync between these two fields, however it does
so only on explicit guest writes to one of these fields, not on a bare
VMRUN.

This meant that when AVIC is enabled host changes to TPR in the LAPIC
state might not get automatically copied into the V_TPR field of VMCB.

This is especially true when it is the userspace setting LAPIC state via
KVM_SET_LAPIC ioctl() since userspace does not have access to the guest
VMCB.

Practice shows that it is the V_TPR that is actually used by the AVIC to
decide whether to issue pending interrupts to the CPU (not TPR in TASKPRI),
so any leftover value in V_TPR will cause serious interrupt delivery issues
in the guest when AVIC is enabled.

Fix this issue by doing pre-VMRUN TPR sync from LAPIC into VMCB::V_TPR
even when AVIC is enabled.

Fixes: 3bbf3565f48c ("svm: Do not intercept CR8 when enable AVIC")
Cc: stable@vger.kernel.org
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Reviewed-by: Naveen N Rao (AMD) <naveen@kernel.org>
Link: https://lore.kernel.org/r/c231be64280b1461e854e1ce3595d70cde3a2e9d.1756139678.git.maciej.szmigiero@oracle.com
[sean: tag for stable@]
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index d9931c6c4bc6..1bfebe40854f 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4046,8 +4046,7 @@ static inline void sync_lapic_to_cr8(struct kvm_vcpu *vcpu)
 	struct vcpu_svm *svm = to_svm(vcpu);
 	u64 cr8;
 
-	if (nested_svm_virtualize_tpr(vcpu) ||
-	    kvm_vcpu_apicv_active(vcpu))
+	if (nested_svm_virtualize_tpr(vcpu))
 		return;
 
 	cr8 = kvm_get_cr8(vcpu);



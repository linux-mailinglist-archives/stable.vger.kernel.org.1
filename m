Return-Path: <stable+bounces-203633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A38CE7141
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 276CA300CA2D
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 14:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A05322523;
	Mon, 29 Dec 2025 14:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KU01WZLv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF26322B68
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 14:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767019168; cv=none; b=A2eXXB9kUD9ASbDGBxi9CzOJq2NshX/cNJ307/0PkHET6HEpOphzRGUXwfupOdtxW0Ei0ShO7Q8wdtG80mh0mZIiero2Yho3BwKIVlENNw6OHnt9XLwBVM5rDl+cekR1uZnqW0/fr/BK4TXFRbgGvcJa/9hccHtb5YrWYOCTsfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767019168; c=relaxed/simple;
	bh=mkMgXVTQqxAds8hDS4M0IIoZ8caAn/XQ00TwCF7Clrc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lMTZSxBeL2cJL7Jwt3au2b2ti/rYIUIiQOkAVFvCGsIfCFSZ+AG8Z2lEPBXw3TeY662DRgouKsZkeUinrHgBdYE8hUYFEbVKuNEzUHhjJu3K9F7go2HhE76SNmGH8TIKUbOD9BQlSUpwyywhi/Qu882LdXCVBT7jzhRjhirogSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KU01WZLv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3F3C4CEF7;
	Mon, 29 Dec 2025 14:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767019167;
	bh=mkMgXVTQqxAds8hDS4M0IIoZ8caAn/XQ00TwCF7Clrc=;
	h=Subject:To:Cc:From:Date:From;
	b=KU01WZLvPAi8xZr9wdBW2P8UbkFk6+1TvnHvMQtcouftbnZK4QPVNmpEWR7SdOV3y
	 rBxPUKDTj6Ga9rTOQ8aKNdQcdPwRFI9illTrvHKsb88Igrcp5gWVl/OsIUAWvh6c4Z
	 ZMRl8vAVurqNL5kqFtnwzYASZp6iL+IofAEsnAjI=
Subject: FAILED: patch "[PATCH] KVM: SVM: Mark VMCB_NPT as dirty on nested VMRUN" failed to apply to 5.13-stable tree
To: jmattson@google.com,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 15:36:24 +0100
Message-ID: <2025122924-outnumber-heroics-0ca8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.13-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.13.y
git checkout FETCH_HEAD
git cherry-pick -x 7c8b465a1c91f674655ea9cec5083744ec5f796a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122924-outnumber-heroics-0ca8@gregkh' --subject-prefix 'PATCH 5.13.y' HEAD^..

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



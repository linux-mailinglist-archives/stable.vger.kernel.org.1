Return-Path: <stable+bounces-136880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9B1A9F026
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 14:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCC6716C5F0
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 12:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F51266B62;
	Mon, 28 Apr 2025 11:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ib48jYZo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE76256C64
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 11:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745841586; cv=none; b=g2JARgzeXXvkUxxZ3XAK+hmbxCaEVB/qKNjs+1GtRjGudFiCCiuNRZLRtnHOmtXU08nkBm6A06eutdhqVeCELz6swLxXOJnR9GfJj1+wuIg/MG95WmWg2fgcxTh5fVpa71+YTcj0mPj6FxsbaMTiP+nE1f1VwweAqPR6A2yrpQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745841586; c=relaxed/simple;
	bh=VPWsIWozZqkbIfArErXD2KZAWvV4ohdMn0g3EJayikY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=b/ivTWuKi9l9+dP27ojmPEoPHR3xirdDp3eUm/imyp0yPgLzOHxIct/pjrc0O9U8N4WRBI/SQH1YZY2FxwKSbAu43ZbQ8iD1cgO1Au3D8FqzEPK7djJVAeyD73L/0TS906ieomEDwZYPaBrqoZ3w5kf/XbyvDOtKpQxxHBIZejo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ib48jYZo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC4FC4CEE4;
	Mon, 28 Apr 2025 11:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745841586;
	bh=VPWsIWozZqkbIfArErXD2KZAWvV4ohdMn0g3EJayikY=;
	h=Subject:To:Cc:From:Date:From;
	b=Ib48jYZo4PmC4ipvcJ9/wy/zfJUhjnlZG0hamZFGd87agh8URCGAcE02SJaQXqFIK
	 umgcgbxa6JChGtWDmA3io2QKWEFq0STllYJkrkU6qxL0RDBjsi5ZWSAnHPYvRINuVr
	 W0GeLItYo6d9zd+DmDiceuTRg9IsKZ51boO4OhSo=
Subject: FAILED: patch "[PATCH] KVM: SVM: Allocate IR data using atomic allocation" failed to apply to 5.4-stable tree
To: seanjc@google.com,pbonzini@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 28 Apr 2025 13:59:43 +0200
Message-ID: <2025042843-headboard-same-531b@gregkh>
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
git cherry-pick -x 7537deda36521fa8fff9133b39c46e31893606f2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042843-headboard-same-531b@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7537deda36521fa8fff9133b39c46e31893606f2 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Fri, 4 Apr 2025 12:38:16 -0700
Subject: [PATCH] KVM: SVM: Allocate IR data using atomic allocation

Allocate SVM's interrupt remapping metadata using GFP_ATOMIC as
svm_ir_list_add() is called with IRQs are disabled and irqfs.lock held
when kvm_irq_routing_update() reacts to GSI routing changes.

Fixes: 411b44ba80ab ("svm: Implements update_pi_irte hook to setup posted interrupt")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20250404193923.1413163-2-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 901d8d2dc169..a961e6e67050 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -820,7 +820,7 @@ static int svm_ir_list_add(struct vcpu_svm *svm, struct amd_iommu_pi_data *pi)
 	 * Allocating new amd_iommu_pi_data, which will get
 	 * add to the per-vcpu ir_list.
 	 */
-	ir = kzalloc(sizeof(struct amd_svm_iommu_ir), GFP_KERNEL_ACCOUNT);
+	ir = kzalloc(sizeof(struct amd_svm_iommu_ir), GFP_ATOMIC | __GFP_ACCOUNT);
 	if (!ir) {
 		ret = -ENOMEM;
 		goto out;



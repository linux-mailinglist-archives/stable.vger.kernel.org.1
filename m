Return-Path: <stable+bounces-108400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EA4A0B476
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 11:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CF843A3A7A
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 10:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B5F1FDA65;
	Mon, 13 Jan 2025 10:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DCG+LAnQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC0E235C12
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 10:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736763800; cv=none; b=qTD7UHH4saLoWCuKaWlvIVz98oa5ZJAclYsgt/yEgHV+4LfVchDefpO85Q/uDRfIjS+RxkU3r1rtpSpBpJXcBon9H1v0kkdHwZc2sDq1rJkRqnxZU9f1UbG5qupjmI1CBPJy2n8B0lLGcDA5mOSgOAC1YlwPZ+Kf4EOQj/5o0c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736763800; c=relaxed/simple;
	bh=grPk7kOK/s4e0rl4RpbucHyKxt9+QJL6IhnRspXGi6A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CE+z9l6hjy5hmPpXT0aEaHxvpxkSDrkM0Su+kCwNs5JV5iTsYgl6mnX743jH1aP8SacAmEwb6SFcGV8rC2T4v75dwrF2hM8WupPtayJlBBRWix2fypPZw7CxRS5+C8TKFnzsQHlgN3kv9i1HvQyHsQFGWGRkgpmfNZ7BYuJHgjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DCG+LAnQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BEAFC4CED6;
	Mon, 13 Jan 2025 10:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736763797;
	bh=grPk7kOK/s4e0rl4RpbucHyKxt9+QJL6IhnRspXGi6A=;
	h=Subject:To:Cc:From:Date:From;
	b=DCG+LAnQM+E3GrITBsuu3OL5Rg+IWt4gbCbpUUtxE2acpaQ/LvkaoCoAi01kJv0Ku
	 3lHLGIX85acfYKMkcpdblV9S4gR/ZzJ+keZHP94RsTo+9AZN9d0/Yxwv1l9SHQq6nF
	 QZvxqgfYuaIink6QgxwvNW/m6xkeDTunHseAr89Y=
Subject: FAILED: patch "[PATCH] KVM: e500: always restore irqs" failed to apply to 5.10-stable tree
To: pbonzini@redhat.com,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jan 2025 11:22:53 +0100
Message-ID: <2025011353-wooing-stitch-0ab6@gregkh>
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
git cherry-pick -x 87ecfdbc699cc95fac73291b52650283ddcf929d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025011353-wooing-stitch-0ab6@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 87ecfdbc699cc95fac73291b52650283ddcf929d Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 12 Jan 2025 10:34:44 +0100
Subject: [PATCH] KVM: e500: always restore irqs

If find_linux_pte fails, IRQs will not be restored.  This is unlikely
to happen in practice since it would have been reported as hanging
hosts, but it should of course be fixed anyway.

Cc: stable@vger.kernel.org
Reported-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
index e5a145b578a4..6824e8139801 100644
--- a/arch/powerpc/kvm/e500_mmu_host.c
+++ b/arch/powerpc/kvm/e500_mmu_host.c
@@ -479,7 +479,6 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 		if (pte_present(pte)) {
 			wimg = (pte_val(pte) >> PTE_WIMGE_SHIFT) &
 				MAS2_WIMGE_MASK;
-			local_irq_restore(flags);
 		} else {
 			local_irq_restore(flags);
 			pr_err_ratelimited("%s: pte not present: gfn %lx,pfn %lx\n",
@@ -488,8 +487,9 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 			goto out;
 		}
 	}
-	writable = kvmppc_e500_ref_setup(ref, gtlbe, pfn, wimg);
+	local_irq_restore(flags);
 
+	writable = kvmppc_e500_ref_setup(ref, gtlbe, pfn, wimg);
 	kvmppc_e500_setup_stlbe(&vcpu_e500->vcpu, gtlbe, tsize,
 				ref, gvaddr, stlbe);
 



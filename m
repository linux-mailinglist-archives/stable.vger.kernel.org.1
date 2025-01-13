Return-Path: <stable+bounces-108396-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47424A0B471
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 11:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F49B164BDC
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 10:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD8C1FDA65;
	Mon, 13 Jan 2025 10:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p9+xSZsc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D458235C12
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 10:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736763770; cv=none; b=GD9SaP1JOdPD+SScuK8siJT/6Oa7dzuJZACvhlua1sDprJftiwnMNn72T9AfWgUWCaLRyH2H49KomGZ9p9cDQxp3mxZbwT2Eo30AO+RuG7ogwLXgPZnl0KDIw5V8eAs7zuYq27Piuqe50ZhbwQDigLHGFoFY/olnHCWBg0SEZ9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736763770; c=relaxed/simple;
	bh=nsPhKM1VPNmSdKGVAMnibGtHzt+jeJ/97cPzm7qpnv8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rqKBK2tHfpA9Oy+gcorPl5pKnAuObZaqgPresDXBh1ZIoCVoTr2GK0Az1Mpg0NE5W96Sk5GISjQxfsDCzDPkcv8Kfo0h8O3uSKNTcfEFAEbAkCBVfI40oPFfzuo32+oh/D4wn+sy++RFEPHKRqioIVPa9WvnpCUCXB3+NqOBUws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p9+xSZsc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DAB9C4CED6;
	Mon, 13 Jan 2025 10:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736763769;
	bh=nsPhKM1VPNmSdKGVAMnibGtHzt+jeJ/97cPzm7qpnv8=;
	h=Subject:To:Cc:From:Date:From;
	b=p9+xSZscYFNrkb38acyCw+zfaMHxprI4zMLRNrQxoJJzorAt42uPU61cI902GJCgU
	 LhhMBHoj6qfZdqVvBwuObEU9eAg6UusDR5T1TzBspDsqQt1tkmdi0sVzhA83dTA0x0
	 +1PZd8rAQhDNCKpvUKFOiall1R+j8eEx0DGCpvNM=
Subject: FAILED: patch "[PATCH] KVM: e500: always restore irqs" failed to apply to 6.12-stable tree
To: pbonzini@redhat.com,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jan 2025 11:22:46 +0100
Message-ID: <2025011346-pesticide-silenced-822e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 87ecfdbc699cc95fac73291b52650283ddcf929d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025011346-pesticide-silenced-822e@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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
 



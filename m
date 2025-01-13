Return-Path: <stable+bounces-108401-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DD3A0B477
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 11:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FE92164C01
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 10:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574F721ADAB;
	Mon, 13 Jan 2025 10:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jkx2UEZQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16809235C12
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 10:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736763802; cv=none; b=SXb9NgxUjKPNuFXzsDreerzHmlQvSC6Ft3lTmztQ/wsuFzu2gkmSMnLmQvnQT7+drrQ4BNP8TpU6AfJcAs8dJiXKKjtXfRtoCgxMXgS0g09l98dHeBeOxooV6G2bSNOpIl5Djr8gPh0rlshjhtYIjuCdDcm5awNCNn0MDc/hGts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736763802; c=relaxed/simple;
	bh=7Kw2t4v+hNLNkqO1L44YZPAz3iHHYZ0X1P86GAQQc6A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AC7q7QIRaFfmuKkORQTqcJzhLzmobdoLRPNYGpILbcDPu+JdqxbcMFM5RGr2LcxJQJ3ObmoBnMwd/qi2zAPgC6Zbe8Vp6hdno7Fmbr5zwxSnE4wgt5AUOW7iCfRmcRjQ3N3XLCNQGXA50PyNaGuC9aTyTFJuxNvlBYbTneTHev0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jkx2UEZQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1A4C4CEE2;
	Mon, 13 Jan 2025 10:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736763801;
	bh=7Kw2t4v+hNLNkqO1L44YZPAz3iHHYZ0X1P86GAQQc6A=;
	h=Subject:To:Cc:From:Date:From;
	b=jkx2UEZQcSJ6+ZwbRsR41ac/tNy/BlY7PT5U4DyfpDJADYBDgbVAzgc+krIfQj7v1
	 kVB+HmJvoaa0L3FVCxYEQTQXhLZawL3NR+yYIvSsIa3k1SYnA6FueMZH12qgvwTuWG
	 6VQd35fo/bV/oDz9/V0yGC5rpIsc9qrdp/KmFgls=
Subject: FAILED: patch "[PATCH] KVM: e500: always restore irqs" failed to apply to 5.4-stable tree
To: pbonzini@redhat.com,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jan 2025 11:22:54 +0100
Message-ID: <2025011354-trend-playmate-36dc@gregkh>
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
git cherry-pick -x 87ecfdbc699cc95fac73291b52650283ddcf929d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025011354-trend-playmate-36dc@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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
 



Return-Path: <stable+bounces-108397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEF5A0B472
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 11:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4963518856D6
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 10:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E609F1FDA65;
	Mon, 13 Jan 2025 10:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="07IcdctM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5425235C12
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 10:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736763777; cv=none; b=auLATgRqZhbDs7zvCBCzevAo1MqvQUCohnHWs5hfshHzVJKIFtlveNZBeEFBqCo/JCCGyE0NnlUAQ4bUgncnp+6b+96hj86N9r8tX97pn6xE6fylomonJB7F046/oFe1+ugymr38FuBKi3Eud6naWi1owm7zCP3Y78p46iNie1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736763777; c=relaxed/simple;
	bh=HqOD4q9MITHqVWqCQE0UbndxhLqPB7EMgFm3kLe4gqw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TxSZyon16QJHtrYYNfIfub+80mgbDNYJz39zJCMY3ZPsup9NfaXViWwFCTjkSMrqpN3C6ztTdOQ8S4/sAc7JGVA1VsGvYLo5jlD9PDyPgNuC3CkvscbwHK+KtX8GHpoe78+UiuMNzkxJnRpMVZCkNpq5QJwAdzPVcvhhKTNxYBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=07IcdctM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E13C4CED6;
	Mon, 13 Jan 2025 10:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736763776;
	bh=HqOD4q9MITHqVWqCQE0UbndxhLqPB7EMgFm3kLe4gqw=;
	h=Subject:To:Cc:From:Date:From;
	b=07IcdctMalDOb2Ewyl5N2lU03tCzb8ZepbhNS8rb/jVa/ZoI1ydsPfnWmx8DfDTLO
	 Q/cvdhbfZGDWu1VgYLlc1AJefzGPPYQ6dwS5Yjezp4E15DPlii4q2pMpdNMWIweIV9
	 Mny5HfCf6xgyCr5rkl6JovrdO+m56YvXBl592mdI=
Subject: FAILED: patch "[PATCH] KVM: e500: always restore irqs" failed to apply to 6.1-stable tree
To: pbonzini@redhat.com,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jan 2025 11:22:47 +0100
Message-ID: <2025011347-agile-appendix-65e2@gregkh>
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
git cherry-pick -x 87ecfdbc699cc95fac73291b52650283ddcf929d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025011347-agile-appendix-65e2@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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
 



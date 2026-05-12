Return-Path: <stable+bounces-245787-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OwwKLRCA2pV2QEAu9opvQ
	(envelope-from <stable+bounces-245787-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:09:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FFD52355D
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E76A0305F2C5
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066EC3AB49A;
	Tue, 12 May 2026 14:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZQf/b54o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5F7399888
	for <stable@vger.kernel.org>; Tue, 12 May 2026 14:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595873; cv=none; b=rvYfYLX7pvzGplQ9RqNY37smqy24QN3pBnBCJ/CJGWz5k+u1zqHxKsyYRsoFagihHIfqecU1DdgXHAZfq2Q7lmcic3qfDPNfRf6mCyVZO8u4/aMBR40eIOgyBUnaiRr0X8Z16dZ/0bITeFGoFmEZztmnQYKYpLaXG8TIWTxQwEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595873; c=relaxed/simple;
	bh=6x7oprb6cI7kxVTs7XaO8c+3mfVAbnOWBAe99wN6Rk0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TlcAT3rX6FOSrvpbNbiPZ3ZSWa2t33UYxAIz9/EmE4oC04EUVcqR18HZVK2imFAxaH41wSrTx7kQpCnSV1PUYZ7Uyot5/bHhDlrVEC5bkCoTIZM4X8AE8kLmzJdiDbzWF32OMwXIANL4GXKkQtukldi/UY04RWzkISeblwp/WZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZQf/b54o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1969AC2BCB0;
	Tue, 12 May 2026 14:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778595873;
	bh=6x7oprb6cI7kxVTs7XaO8c+3mfVAbnOWBAe99wN6Rk0=;
	h=Subject:To:Cc:From:Date:From;
	b=ZQf/b54oDrv0S5zx7lD7AJYcaLFgCoadOA8YoqxBsXEhmtogv3XZAL2WDG6IraLNq
	 EpFAyqBcBMRF3QSAqfb0XxTMVDTe5gsLKeaIvd4P3tCDRnwETZGa1UyLWT67TohbaZ
	 Xuj7esyl8FCxAzvdNmZY7Y78648ecZN9bQgUfPjE=
Subject: FAILED: patch "[PATCH] KVM: arm64: Wake-up from WFI when iqrchip is in userspace" failed to apply to 6.6-stable tree
To: maz@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 16:24:36 +0200
Message-ID: <2026051236-flaxseed-tiring-cf79@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 96FFD52355D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245787-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email,msgid.link:url]
X-Rspamd-Action: no action


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 4ce98bf0865c349e7026ad9c14f48da264920953
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051236-flaxseed-tiring-cf79@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4ce98bf0865c349e7026ad9c14f48da264920953 Mon Sep 17 00:00:00 2001
From: Marc Zyngier <maz@kernel.org>
Date: Thu, 23 Apr 2026 17:36:07 +0100
Subject: [PATCH] KVM: arm64: Wake-up from WFI when iqrchip is in userspace

It appears that there is nothing in the wake-up path that
evaluates whether the in-kernel interrupts are pending unless
we have a vgic.

This means that the userspace irqchip support has been broken for
about four years, and nobody noticed. It was also broken before
as we wouldn't wake-up on a PMU interrupt, but hey, who cares...

It is probably time to remove the feature altogether, because it
was a terrible idea 10 years ago, and it still is.

Fixes: b57de4ffd7c6d ("KVM: arm64: Simplify kvm_cpu_has_pending_timer()")
Link: https://patch.msgid.link/20260423163607.486345-1-maz@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 176cbe8baad3..8bb2c7422cc8 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -824,6 +824,10 @@ int kvm_arch_vcpu_runnable(struct kvm_vcpu *v)
 {
 	bool irq_lines = *vcpu_hcr(v) & (HCR_VI | HCR_VF | HCR_VSE);
 
+	irq_lines |= (!irqchip_in_kernel(v->kvm) &&
+		      (kvm_timer_should_notify_user(v) ||
+		       kvm_pmu_should_notify_user(v)));
+
 	return ((irq_lines || kvm_vgic_vcpu_pending_irq(v))
 		&& !kvm_arm_vcpu_stopped(v) && !v->arch.pause);
 }



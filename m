Return-Path: <stable+bounces-245792-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LIHAjQ6A2qh1wEAu9opvQ
	(envelope-from <stable+bounces-245792-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:33:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BE765522996
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 641A3307A633
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3773AFAF4;
	Tue, 12 May 2026 14:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hIJIsVk2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915F53AFAEA
	for <stable@vger.kernel.org>; Tue, 12 May 2026 14:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595973; cv=none; b=BXsAIYD5cZyorZKZXGEQ/gcIYvUZ7mScISO0aal8vycfn76JYYxUC/ofulcWlNkGZ/A1wENBfsHWlnx/ytbdSTRZIi+3PKVw3CB7CbWMBYqFkt+d3CssW0ai19+zDDUFSe3NzzCqWUiWej9c6l8wbzye6cO0qn/cs2mjDRVwapo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595973; c=relaxed/simple;
	bh=7TNPGC79+1rlEOdjTiCvROH8G/IW8XmLN3SoHpoAroA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cbI1II9Sni+WZcdszROQwqf7NwTbvRr8q6/vBpCndC5Muji+8dKeJ07Rd0r3/NqFWD+4CZlXZEv+6UgMhgzmGE059ifir++rWj+pLb/U6Pe/hzDC0cX5OqBqdPBm5a9XSfk4dqI+er5iYkftsKnfuW3MR1vodpKTkwDUAKWhtMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hIJIsVk2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9FEC2BCB0;
	Tue, 12 May 2026 14:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778595973;
	bh=7TNPGC79+1rlEOdjTiCvROH8G/IW8XmLN3SoHpoAroA=;
	h=Subject:To:Cc:From:Date:From;
	b=hIJIsVk2lnvjswaKeKhaJniU/bkBwnTN1xkc4xcrigUHKfqJlEa0QY4CuZOpGP+BM
	 1G0MdmwzLwR+BcfCrtz/fePf+C32dMnJVu391sl7RZTU50HqO6+wtCoS1bGNRGPY+y
	 Zum/CBxAWM7UoM7tzb89J8OVwELsf4rq7G4XGayE=
Subject: FAILED: patch "[PATCH] LoongArch: KVM: Move AVEC interrupt injection into switch" failed to apply to 6.6-stable tree
To: maobibo@loongson.cn,chenhuacai@loongson.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 16:26:08 +0200
Message-ID: <2026051208-atrium-bacterium-fe2a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BE765522996
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245792-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Action: no action


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 6debfff78584f0adedf7355fe5263198a3fc6b19
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051208-atrium-bacterium-fe2a@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6debfff78584f0adedf7355fe5263198a3fc6b19 Mon Sep 17 00:00:00 2001
From: Bibo Mao <maobibo@loongson.cn>
Date: Mon, 4 May 2026 09:00:48 +0800
Subject: [PATCH] LoongArch: KVM: Move AVEC interrupt injection into switch
 loop

When AVEC interrupt controller is emulated in user space, AVEC interrupt
is injected by software like SIP0/SIP1/TI/IPI interrupts. Here also move
the AVEC interrupt injection in switch loop.

Cc: stable@vger.kernel.org
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

diff --git a/arch/loongarch/kvm/interrupt.c b/arch/loongarch/kvm/interrupt.c
index 32930959f7c2..53dac8ab8fb1 100644
--- a/arch/loongarch/kvm/interrupt.c
+++ b/arch/loongarch/kvm/interrupt.c
@@ -33,13 +33,12 @@ static int kvm_irq_deliver(struct kvm_vcpu *vcpu, unsigned int priority)
 	if (priority < EXCCODE_INT_NUM)
 		irq = priority_to_irq[priority];
 
-	if (kvm_guest_has_msgint(&vcpu->arch) && (priority == INT_AVEC)) {
-		dmsintc_inject_irq(vcpu);
-		set_gcsr_estat(irq);
-		return 1;
-	}
-
 	switch (priority) {
+	case INT_AVEC:
+		if (!kvm_guest_has_msgint(&vcpu->arch))
+			break;
+		dmsintc_inject_irq(vcpu);
+		fallthrough;
 	case INT_TI:
 	case INT_IPI:
 	case INT_SWI0:
@@ -66,12 +65,11 @@ static int kvm_irq_clear(struct kvm_vcpu *vcpu, unsigned int priority)
 	if (priority < EXCCODE_INT_NUM)
 		irq = priority_to_irq[priority];
 
-	if (kvm_guest_has_msgint(&vcpu->arch) && (priority == INT_AVEC)) {
-		clear_gcsr_estat(irq);
-		return 1;
-	}
-
 	switch (priority) {
+	case INT_AVEC:
+		if (!kvm_guest_has_msgint(&vcpu->arch))
+			break;
+		fallthrough;
 	case INT_TI:
 	case INT_IPI:
 	case INT_SWI0:



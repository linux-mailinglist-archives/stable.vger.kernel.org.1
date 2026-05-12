Return-Path: <stable+bounces-245793-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GZUGkA6A2qh1wEAu9opvQ
	(envelope-from <stable+bounces-245793-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:33:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1140D5229A4
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 76921307B035
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658873AFB18;
	Tue, 12 May 2026 14:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v9YB3v3P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C9D39AD34
	for <stable@vger.kernel.org>; Tue, 12 May 2026 14:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595976; cv=none; b=cY8KrXmNojWLO82azZAIYXvpT3hrnTFf1aWIVd7JUMson6OrAG28llbQ/QfY4kO9DfAzUd4QPXOFLwQMCpItO/3vTFU111uVUxi+tYP1vdbpLSYWwDw79oUVUg3Ll3tMvjjYn+sOipVFgxxaELKH9Ov/K3lvvCpjtEHugfDRmtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595976; c=relaxed/simple;
	bh=+iqWmgRNxHCeKBIiNg9xQrX9sT4DOHD3JVegsr5bPE4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sAX0ee+Hr4IC4UQ1R/sbmtixV1/7AeLD4MrSsfeZIk/zS/gIkXpqsy/QsLFcLqUA9QnPisq4beac3RNJKGY3BKITjuZdp9eDcJtFUCiX7Mie1+puhoa76IoMej6e8G+oi7JRVKEIn1+XeJp07Lf2CohSQLuVWeX2HSqOuaOzFzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v9YB3v3P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C1EC2BCB0;
	Tue, 12 May 2026 14:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778595976;
	bh=+iqWmgRNxHCeKBIiNg9xQrX9sT4DOHD3JVegsr5bPE4=;
	h=Subject:To:Cc:From:Date:From;
	b=v9YB3v3PQZGkBwZ/8rWTFUv3H2wiq6q/g7/3ScGOyVbkwjZxvTjNl7Yf6zfAi2gzJ
	 kLNtK09pvGCcsVK/7NamSNnOTYy5JSE/oSOzQ6XJ51ntRvQ0DNVLRIhi4yuE7WSigs
	 TpMHXpA/pxyAxx4gql3OeYKHD8C9MNcis7VPQ13M=
Subject: FAILED: patch "[PATCH] LoongArch: KVM: Move AVEC interrupt injection into switch" failed to apply to 6.1-stable tree
To: maobibo@loongson.cn,chenhuacai@loongson.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 16:26:08 +0200
Message-ID: <2026051208-outsell-ribcage-1842@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1140D5229A4
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
	TAGGED_FROM(0.00)[bounces-245793-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,loongson.cn:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 6debfff78584f0adedf7355fe5263198a3fc6b19
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051208-outsell-ribcage-1842@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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



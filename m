Return-Path: <stable+bounces-242697-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFG2OsM392nQdgIAu9opvQ
	(envelope-from <stable+bounces-242697-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 13:55:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E77EA4B5696
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 13:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C8D8A300159D
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 11:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D4A2E093A;
	Sun,  3 May 2026 11:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qx04LFgM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD5638DD3
	for <stable@vger.kernel.org>; Sun,  3 May 2026 11:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777809342; cv=none; b=MJKIdmdCPMzF7ywL4aHdliYHM34M5OyvB66zV6uWQ0lunWgQgIFzV9H3mdkR8mcBr/v8CU0cOu1bJaKOLikmRWK0D2jmXvbS1LgBScimboK6Go+9M1ejvKUxlOwKniSmuPD4w3+2GQ6kyfjeSyvH+GhnWV9o6dbxLNI3z3U/aY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777809342; c=relaxed/simple;
	bh=C71pB07ZO9ljjN8yGMZe4j3ukyHUvsK4wJqRutL3POc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pNnhHSF55x3XHUDWlZhkow9oC8zf8AKfFBPrNjl6GYn9TK2gRBVqjUALdx7qitWKWGACpnWp2oRS353JBYh2hADC6EyzVcRyHfwd0XVoQyDpULoaRPIV9W/rzuYdumZraCyfOVLU41lD7g9O+Fc3PesUCVWEhlFvRn8sHSJBwY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qx04LFgM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83D3C2BCB4;
	Sun,  3 May 2026 11:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777809342;
	bh=C71pB07ZO9ljjN8yGMZe4j3ukyHUvsK4wJqRutL3POc=;
	h=Subject:To:Cc:From:Date:From;
	b=qx04LFgMnZEmV+oMJePrkjOesija/92UvZTt3V4fDe2u0TXkSPD9jyB3Gh/PN9PcG
	 7s//DR4qc45q37VzcjhPLaAs/fDSDekiDsvaIDgljwWu/pOWiQ6hjCEbdMNKGxwz3e
	 abY/aY9sz73zWXy65baLIVtdJ8d5/R8wqf90GYVA=
Subject: FAILED: patch "[PATCH] KVM: SVM: Inject #UD for INVLPGA if EFER.SVME=0" failed to apply to 5.10-stable tree
To: chengkev@google.com,seanjc@google.com,yosry.ahmed@linux.dev
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 May 2026 13:55:39 +0200
Message-ID: <2026050339-pony-probe-1c97@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E77EA4B5696
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-242697-lists,stable=lfdr.de];
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
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,msgid.link:url,gregkh:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:email]


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x d99df02ff427f461102230f9c5b90a6c64ee8e23
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050339-pony-probe-1c97@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d99df02ff427f461102230f9c5b90a6c64ee8e23 Mon Sep 17 00:00:00 2001
From: Kevin Cheng <chengkev@google.com>
Date: Sat, 28 Feb 2026 03:33:26 +0000
Subject: [PATCH] KVM: SVM: Inject #UD for INVLPGA if EFER.SVME=0

INVLPGA should cause a #UD when EFER.SVME is not set. Add a check to
properly inject #UD when EFER.SVME=0.

Fixes: ff092385e828 ("KVM: SVM: Implement INVLPGA")
Cc: stable@vger.kernel.org
Signed-off-by: Kevin Cheng <chengkev@google.com>
Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Link: https://patch.msgid.link/20260228033328.2285047-3-chengkev@google.com
[sean: tag for stable@]
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index d82e30c40eaa..543f9f3f966e 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2367,6 +2367,9 @@ static int invlpga_interception(struct kvm_vcpu *vcpu)
 	gva_t gva = kvm_rax_read(vcpu);
 	u32 asid = kvm_rcx_read(vcpu);
 
+	if (nested_svm_check_permissions(vcpu))
+		return 1;
+
 	/* FIXME: Handle an address size prefix. */
 	if (!is_long_mode(vcpu))
 		gva = (u32)gva;



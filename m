Return-Path: <stable+bounces-273942-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Cy7gCSMqVWoBkwAAu9opvQ
	(envelope-from <stable+bounces-273942-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 20:10:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1960674E58B
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 20:10:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Iga8eYlJ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273942-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-273942-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 759FB300B9C2
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 18:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9940135203C;
	Mon, 13 Jul 2026 18:10:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D67344D9D;
	Mon, 13 Jul 2026 18:10:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783966229; cv=none; b=BQyg8bh5aotKMJkUP0saR0uPPgpovOWAnMr84EflSWqvwIQuvs7tgD+QHpNnRB5iWe19RmCFT9FkkwxMgpzf4jqjPU9QM7zZWInEjbrq7buqv8IsWM+Sv77E7L+Z4xtpVgCl/MzW1IP0/XdyYbImZM0p4H7nX9NzXVTHtkl46k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783966229; c=relaxed/simple;
	bh=PdyoCxhWzQPCEYXZIOD+s1mV5fgcRcifMCpnwebJ2Yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Te0OS/zIKO62gQE5JzJ7ihbo/SmcezlWg44/FAETyyoigtBcWyChJ/ah3fyNQWbUvwrk8ELwecmtkVttSi1IX1nyYWT19QRleI9+vS5rFk8Fz8QA+4Yg/znLG5bazmgy+cJRoqmYnJCtBAyyG+KVYQDjI9n3W0SNzP80s4eQfOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iga8eYlJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D561F00A3A;
	Mon, 13 Jul 2026 18:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783966228;
	bh=laAAuph6fYRNISHIwFKYYSgJ64Ls1B+RoDXHUEIXeS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Iga8eYlJ8ECbWrK5ojNlszqjsju81f0CCgu5gWTjxrc0wOszc2irRRFyk2Zc5U0BJ
	 43kvBo0k47L5w9cYfXqyiUJBCAe+T3Q9Y6e/xoMeDoo/+iqlm6ocVjQGzTa5XdhLTZ
	 XJqIFLlsan656BvdVKtjIoFN01rJl/GKOsJZlBst3UJor4kws+tPWovpZLFLutHmPL
	 gTaJWluVbp5MBJRFI+tLFauFA82W/YU3jcYDA1FBLBcgHESOjcYmdHOAk+5qFF2CMd
	 yBLoZgIbkKACHWJWC7gOVEoo8v6ReZeWfvKTXjwWI5YeeH77WKc90cGKC7zHZK7YuC
	 YgX7Yr+haI7Bg==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/5] KVM: x86: Move enabling EFER.SVME and EFER.LMSLE to generic EFER setup
Date: Mon, 13 Jul 2026 18:10:16 +0000
Message-ID: <20260713181020.2735367-2-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
In-Reply-To: <20260713181020.2735367-1-yosry@kernel.org>
References: <20260713181020.2735367-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273942-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:seanjc@google.com,m:pbonzini@redhat.com,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yosry@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[yosry@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1960674E58B

Move SVM-specific EFER bit enablement to generic x86 code, with the rest
of EFER bit enablement. Unifying the code for EFER bit enablement allows
for a later change to re-initialize EFER bits on module init.

No functional change intended.

Cc: stable@vger.kernel.org
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/svm.c | 4 ----
 arch/x86/kvm/x86.c     | 6 ++++++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 91286d46d13ad..09799fd8ef38f 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5628,10 +5628,6 @@ static __init int svm_hardware_setup(void)
 
 	if (nested) {
 		pr_info("Nested Virtualization enabled\n");
-		kvm_enable_efer_bits(EFER_SVME);
-		if (!boot_cpu_has(X86_FEATURE_EFER_LMSLE_MBZ))
-			kvm_enable_efer_bits(EFER_LMSLE);
-
 		r = nested_svm_init_msrpm_merge_offsets();
 		if (r)
 			return r;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1f5dc685f0490..ca01a2f2ec466 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6921,6 +6921,12 @@ static void kvm_setup_efer_caps(void)
 
 	if (kvm_cpu_cap_has(X86_FEATURE_AUTOIBRS))
 		kvm_enable_efer_bits(EFER_AUTOIBRS);
+
+	if (kvm_cpu_cap_has(X86_FEATURE_SVM)) {
+		kvm_enable_efer_bits(EFER_SVME);
+		if (!boot_cpu_has(X86_FEATURE_EFER_LMSLE_MBZ))
+			kvm_enable_efer_bits(EFER_LMSLE);
+	}
 }
 
 static void kvm_nested_ops_update(const struct kvm_x86_nested_ops *nested_ops)
-- 
2.55.0.141.g00534a21ce-goog



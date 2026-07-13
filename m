Return-Path: <stable+bounces-273943-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A2SbKS4qVWoGkwAAu9opvQ
	(envelope-from <stable+bounces-273943-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 20:10:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 960DA74E5A3
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 20:10:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hYQfDQye;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273943-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-273943-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C052302BBFB
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 18:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171C0353A71;
	Mon, 13 Jul 2026 18:10:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3F934D4F9;
	Mon, 13 Jul 2026 18:10:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783966229; cv=none; b=MNAuZJiv3NyoOW2bK0zBJZbknr3owRzG47ujNzsWAnU/wwCqZ2zf4x4OHqBMQIFXdfFnkVTpcofz8VE10plBgY0f8iTgOaJCepLboIO5UotMOwFP+XVrfc/sRINEDQyaHIus0GT90Kd+s7/p6mE/NhUfND0yJsqRQA3o8f+ywk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783966229; c=relaxed/simple;
	bh=CEzJP8iXiE81KaVA8s3E4s9qC3Tqhw4yjd9MVLZenc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jbspkKjLEa3MaehrrIiOPX8MaDsFpORi8PNeuj8DTdzemn+WZFoM2n8Ze2KhUgPWqRDJf6/rUtbM44dytX7FUTSCpqpwk3nycRGg961c/MZXjy8weVV6zlwbWykXgxSC3xaJFJadLoOIm3KWFJx1Ss9qu/j6Fc0mCgGGt42tGGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYQfDQye; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FDA1F00A3D;
	Mon, 13 Jul 2026 18:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783966228;
	bh=O75oVI8HOnhEwJFlZoZQsUnH7nY5IlDX63zUhNhf9S8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hYQfDQyeMHI0+PkgbJj9rhLbZXj/XW1EhFLhlczvQ/kuY1JE/4/AXBGfI5oFMNJOr
	 wt/K46o2/poZoxRxZhOJjo++URh6j9dF4+J+h5LPDmmwALZdEBP203MHYjkSj6q33+
	 Icaa5JPERAlzjTMscZ9OwF8+LbzM/kGw4SFE+XlzpP3vuWt4NP0imsXyETO+WFzERj
	 HaxhYJ2GxQTtmurc19zPvt1pscGST8J2+hv3yNUHCiMvVzi2TGYdtGYomj1oS4xqCY
	 lLCPj5PjzmcmQPZxfESUEivFA0of3DkoRuP4nk+RhFHqIXOzi988Vp2iUvamsIEHBL
	 MsvqDHciAc78g==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/5] KVM: x86: Disallow EFER.LME and EFER.LMA if long mode is not supported
Date: Mon, 13 Jul 2026 18:10:17 +0000
Message-ID: <20260713181020.2735367-3-yosry@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273943-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 960DA74E5A3

Remove EFER.LME and EFER.LMA from EFER reserved bits only if long mode
is actually supported. KVM does check long-mode support before allowing
the bits for guest writes and userspace writes through KVM_SET_SREGS*
(in __kvm_valid_efer()), but userspace writes through KVM_SET_MSRS only
check reserved bits.

In practice, this doesn't really matter. The true motiviation is getting
rid of the #ifdeffery when initializing efer_reserved_bits.

Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/msrs.c | 10 +---------
 arch/x86/kvm/x86.c  |  3 +++
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index c230b18d87e38..67481429ad6b8 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -19,16 +19,8 @@ bool __read_mostly report_ignored_msrs = true;
 module_param(report_ignored_msrs, bool, 0644);
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(report_ignored_msrs);
 
-/* EFER defaults:
- * - enable syscall per default because its emulated by KVM
- * - enable LME and LMA per default on 64 bit KVM
- */
-#ifdef CONFIG_X86_64
-static
-u64 __read_mostly efer_reserved_bits = ~((u64)(EFER_SCE | EFER_LME | EFER_LMA));
-#else
+/* Enable syscall by default because its emulated by KVM */
 static u64 __read_mostly efer_reserved_bits = ~((u64)EFER_SCE);
-#endif
 
 #define MAX_IO_MSRS 256
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ca01a2f2ec466..f68424a985cda 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6913,6 +6913,9 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_setup_xss_caps);
 
 static void kvm_setup_efer_caps(void)
 {
+	if (kvm_cpu_cap_has(X86_FEATURE_LM))
+		kvm_enable_efer_bits(EFER_LME | EFER_LMA);
+
 	if (kvm_cpu_cap_has(X86_FEATURE_NX))
 		kvm_enable_efer_bits(EFER_NX);
 
-- 
2.55.0.141.g00534a21ce-goog



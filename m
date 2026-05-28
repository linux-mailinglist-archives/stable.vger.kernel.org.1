Return-Path: <stable+bounces-255029-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JhJCMBXGGoQjQgAu9opvQ
	(envelope-from <stable+bounces-255029-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:57:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9D95F4061
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1ED6930297A7
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 14:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBDC3F39DC;
	Thu, 28 May 2026 14:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tzgrw1X7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vi5Y/SVw"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88EB3F4DC7
	for <stable@vger.kernel.org>; Thu, 28 May 2026 14:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779979730; cv=none; b=apxJJe+IMqtigg5GLOzgCbxz67fN5YuxDkSgQ763Ie34o0uZLDiDQB8lwzrodd/WveA8VpcG2xdRjRTUQ2j+JVCiURkjd8BYCQEQK20OhJRFHzG2iFAiiWEquhFWvO8EHaDD+bc2QuEIGVGXMSeZNIFpjNdQEvTXqHmStXM+eq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779979730; c=relaxed/simple;
	bh=La6L/VdznKshEvkRR8iJpjWPWe+qnHOdcpAwjvoNz+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nTPoC7hmsJXeL+qVuKllIMNvBo6ONqBfDVmzafB+MjoWR/cZ5y0+Ob7l7lLHxarjKsqnB4vbU/rnNky8jJ6Gn7tu9zTZtV+HK1AULbD2L6Q8WQGbQvJHFrr7DJzN/5J688Qt5x8STkvtQJctXDuurR+oAjogMedl/vlA+u+wy0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Tzgrw1X7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vi5Y/SVw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779979709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=udp+DLqBX2lfkJv3OL1i7jhQuEHzeorMSX79GLF4WO0=;
	b=Tzgrw1X7G0hvAU+hESgYd/L43dLqDdCLl4o8NNlvqBDNAw8S0Ar2ShXcMOjzc9DtbrzraB
	ei869xB+EcNWTD7hw9pl1zQwZq9RBGRXckK9RwkszFa8DCUSMW9NemXuwxLamZYQcZoddH
	IxRLhN4V8ROTqd+VDBb8T+xfQbyR7xm1UH3ud+MfvoVLEmiOAnVU9JbBgcYZCgSbCD2e9O
	LG/kPgt/CWbw2Z7Cp4d2FRuX/XrLHYbcS9Led2r2a4i7CN3ziF9UI7i6Z2ulGNAYNO2jLm
	muohxqsn8Fhj1EF+QwIZ//AlJ19oIV6iKD+YdS0aYX2j0JEVJ8nu+E/UHx3uZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779979709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=udp+DLqBX2lfkJv3OL1i7jhQuEHzeorMSX79GLF4WO0=;
	b=vi5Y/SVwVIAHbZb30ah9wBuuZMv4GbqrfZdaR5ctZL9E4NtaTB8ItyyKfjVs6lWNqOObWD
	lkROEoO9ef59OyCA==
To: stable@vger.kernel.org
Cc: Mostafa Saleh <smostafa@google.com>,
	Kees Cook <kees@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 01/14] arm64: Introduce esr_is_ubsan_brk()
Date: Thu, 28 May 2026 16:48:11 +0200
Message-ID: <20260528144825.850351-2-bigeasy@linutronix.de>
In-Reply-To: <20260528144825.850351-1-bigeasy@linutronix.de>
References: <20260528144825.850351-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255029-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,linutronix.de:mid,linutronix.de:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8E9D95F4061
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mostafa Saleh <smostafa@google.com>

Upstream commit dc1fd37a7f501731e488c1c6f86b2f591632a4ad

Soon, KVM is going to use this logic for hypervisor panics,
so add it in a wrapper that can be used by the hypervisor exit
handler to decode hyp panics.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Kees Cook <kees@kernel.org>
Link: https://lore.kernel.org/r/20250430162713.1997569-2-smostafa@google.com
Signed-off-by: Marc Zyngier <maz@kernel.org>
Stable-dep-of: 6adfdc5e2ef9c ("arm64: debug: call software breakpoint handl=
ers statically")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm64/include/asm/esr.h | 5 +++++
 arch/arm64/kernel/traps.c    | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index 5f4dc6364dbb9..b0520b18192c5 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -409,6 +409,11 @@ static inline bool esr_is_cfi_brk(unsigned long esr)
 	       (esr_brk_comment(esr) & ~CFI_BRK_IMM_MASK) =3D=3D CFI_BRK_IMM_BASE;
 }
=20
+static inline bool esr_is_ubsan_brk(unsigned long esr)
+{
+	return (esr_brk_comment(esr) & ~UBSAN_BRK_MASK) =3D=3D UBSAN_BRK_IMM;
+}
+
 static inline bool esr_fsc_is_translation_fault(unsigned long esr)
 {
 	esr =3D esr & ESR_ELx_FSC;
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index e2e8ffa65aa58..5e138cf5d4ade 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -1136,7 +1136,7 @@ int __init early_brk64(unsigned long addr, unsigned l=
ong esr,
 		return kasan_handler(regs, esr) !=3D DBG_HOOK_HANDLED;
 #endif
 #ifdef CONFIG_UBSAN_TRAP
-	if ((esr_brk_comment(esr) & ~UBSAN_BRK_MASK) =3D=3D UBSAN_BRK_IMM)
+	if (esr_is_ubsan_brk(esr))
 		return ubsan_handler(regs, esr) !=3D DBG_HOOK_HANDLED;
 #endif
 	return bug_handler(regs, esr) !=3D DBG_HOOK_HANDLED;
--=20
2.53.0



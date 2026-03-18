Return-Path: <stable+bounces-227138-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIlzE2f3umlwdwIAu9opvQ
	(envelope-from <stable+bounces-227138-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 20:05:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B462C1C48
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 20:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BC378309827B
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 18:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C12B3E51FB;
	Wed, 18 Mar 2026 18:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O0ozNxyk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OzaBkHEN"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7A52D879F;
	Wed, 18 Mar 2026 18:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773859876; cv=none; b=ppxZUZDGcx7YVwNP2C77QWxhbkg4doN1t4kgeFIR7jP4Cwon4sfCTtlz3s1EGADByL48YOEzuijjMPDsh51dJmQ9i47j6Y/qPIc3o8RlOw6ag9eyTK0ab7vN/TovjL9a0RNmcLl0TMr7qT1FtIo5ZDg5RJGZZpjQw20/4Z2PmPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773859876; c=relaxed/simple;
	bh=jaH27wQQoKoxqskHEYTDKlW4LHmvEkGSpRoMP6gK0D8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sIaf4ni8gFr4/HuYE4EXhgYiLbUm+AqJuUGrMb8RBenGvVQnRVwf2m3Ks+rvcz2vOx9ojK1xjxXVekVvWZKH0iI0y6mHFENsl7R4104W52AUBsN6BL8WmTWH+THBwBugmc7GkrK3DxSLow8LOOMSUdat+d+n1rR6JLVYVJ4riFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O0ozNxyk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OzaBkHEN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Mar 2026 18:51:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773859871;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fBP17ZCMr0JLj1+whTATS+xC8ZedUM4qp0lkrC2rWNw=;
	b=O0ozNxykFgyYfnPNm+WmXyzr2wK855P1JVMqhfjMO26GHFQMVXecCTyuipad/WFu05lWs2
	0lpWctcM0HcHi+N39v6dYZ4rUT4Zi3zQg5iny8BZHINfeR1YkfNAO0QiA10WstNu30Klsf
	kgX9kPC9zCh7GMgnJLlwT62bvg1ct5eSbxVFdTEFYStg9EQXj6GvMV3kZUx4n/R99EXvFk
	5NaZFg7TULgrUoletkxw3W3LqJk57rgXxM5TMJLKOtMUG+QhmDHlI5Q2nTdXgF+DThUaw0
	0qethEfV/B/F5c7y6WUXWIB7fGAVJBewTdiTfjV3YETBKqLKW8rF54aCt4+s0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773859871;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fBP17ZCMr0JLj1+whTATS+xC8ZedUM4qp0lkrC2rWNw=;
	b=OzaBkHENcfGlqHEwAv8bN6/gYf23anMuyQIGGrEc+EkzfZgefdvlBCTRz1S2e+dwYk5jWM
	f/QjNUNd4u2xUSCw==
From: "tip-bot2 for Nikunj A Dadhania" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/fred: Fix early boot failures on SEV-ES/SNP guests
Cc: Nikunj A Dadhania <nikunj@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Tom Lendacky <thomas.lendacky@amd.com>, stable@vger.kernel.org,
	#@tip-bot2.tec.linutronix.de, 6.9+@tip-bot2.tec.linutronix.de,
	x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260318075654.1792916-4-nikunj@amd.com>
References: <20260318075654.1792916-4-nikunj@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177385986974.1647592.3469761665995617263.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227138-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.959];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,vger.kernel.org:replyto,linutronix.de:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,alien8.de:email,amd.com:email]
X-Rspamd-Queue-Id: 53B462C1C48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     afc77687e917b386e6878107cf70b43a38d6f209
Gitweb:        https://git.kernel.org/tip/afc77687e917b386e6878107cf70b43a38d=
6f209
Author:        Nikunj A Dadhania <nikunj@amd.com>
AuthorDate:    Wed, 18 Mar 2026 07:56:54=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 18 Mar 2026 16:40:54 +01:00

x86/fred: Fix early boot failures on SEV-ES/SNP guests

FRED-enabled SEV-(ES,SNP) guests fail to boot due to the following issues
in the early boot sequence:

* FRED does not have a #VC exception handler in the dispatch logic

* Early FRED #VC exceptions attempt to use uninitialized per-CPU GHCBs
  instead of boot_ghcb

Add X86_TRAP_VC case to fred_hwexc() with a new exc_vmm_communication()
function that provides the unified entry point FRED requires, dispatching
to existing user/kernel handlers based on privilege level. The function is
already declared via DECLARE_IDTENTRY_VC().

Fix early GHCB access by falling back to boot_ghcb in
__sev_{get,put}_ghcb() when per-CPU GHCBs are not yet initialized.

Fixes: 14619d912b65 ("x86/fred: FRED entry/exit and dispatch code")
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: stable@vger.kernel.org # 6.9+
Link: https://patch.msgid.link/20260318075654.1792916-4-nikunj@amd.com
---
 arch/x86/coco/sev/noinstr.c |  6 ++++++
 arch/x86/entry/entry_fred.c | 14 ++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/x86/coco/sev/noinstr.c b/arch/x86/coco/sev/noinstr.c
index 9d94aca..5afd663 100644
--- a/arch/x86/coco/sev/noinstr.c
+++ b/arch/x86/coco/sev/noinstr.c
@@ -121,6 +121,9 @@ noinstr struct ghcb *__sev_get_ghcb(struct ghcb_state *st=
ate)
=20
 	WARN_ON(!irqs_disabled());
=20
+	if (!sev_cfg.ghcbs_initialized)
+		return boot_ghcb;
+
 	data =3D this_cpu_read(runtime_data);
 	ghcb =3D &data->ghcb_page;
=20
@@ -164,6 +167,9 @@ noinstr void __sev_put_ghcb(struct ghcb_state *state)
=20
 	WARN_ON(!irqs_disabled());
=20
+	if (!sev_cfg.ghcbs_initialized)
+		return;
+
 	data =3D this_cpu_read(runtime_data);
 	ghcb =3D &data->ghcb_page;
=20
diff --git a/arch/x86/entry/entry_fred.c b/arch/x86/entry/entry_fred.c
index 88c757a..fbe2d10 100644
--- a/arch/x86/entry/entry_fred.c
+++ b/arch/x86/entry/entry_fred.c
@@ -177,6 +177,16 @@ static noinstr void fred_extint(struct pt_regs *regs)
 	}
 }
=20
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+noinstr void exc_vmm_communication(struct pt_regs *regs, unsigned long error=
_code)
+{
+	if (user_mode(regs))
+		return user_exc_vmm_communication(regs, error_code);
+	else
+		return kernel_exc_vmm_communication(regs, error_code);
+}
+#endif
+
 static noinstr void fred_hwexc(struct pt_regs *regs, unsigned long error_cod=
e)
 {
 	/* Optimize for #PF. That's the only exception which matters performance wi=
se */
@@ -207,6 +217,10 @@ static noinstr void fred_hwexc(struct pt_regs *regs, uns=
igned long error_code)
 #ifdef CONFIG_X86_CET
 	case X86_TRAP_CP: return exc_control_protection(regs, error_code);
 #endif
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	case X86_TRAP_VC: return exc_vmm_communication(regs, error_code);
+#endif
+
 	default: return fred_bad_type(regs, error_code);
 	}
=20


Return-Path: <stable+bounces-227176-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GO23AUAiu2lofQIAu9opvQ
	(envelope-from <stable+bounces-227176-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 23:08:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C06D2C3438
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 23:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 166FE3055DF2
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 22:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D26F35A3A0;
	Wed, 18 Mar 2026 22:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vt56S+/6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MEr/P9k2"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279B12C15A5;
	Wed, 18 Mar 2026 22:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773871675; cv=none; b=rT/NYcfCcncvbeTcqt/79XHrC0kkkrHyZVEzlFDE+JRVt9C0GCBVwbsvPa+elGKCGuV/T2Dxd8rvmruIOjkPNRT+qxG+bB1vBo4Hiywvc8wZuP0E9vuWaHuwJUognc0jexDIcM75saL1m/9yt5uLWsb2YfosEbfAryp4alZMTLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773871675; c=relaxed/simple;
	bh=/zzCuY+0qLjS6Fxb9elpOY4PySYKXdLoAVYhG5Etcas=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=qmEdlO1qgfhJJ+mnyXQDaBDfpMiYWkJIGCByLzwlmPzSlFw3WmHrmA3jACwDLk/ldnFxHBOZyoytWMShyTt1Ajy0r+xKnIilDyjvbp95GZ6AoqVB7gLXm8DhyitERWHcOo7PLf8wSk4DuLtM3++HgNUaLgjDQuVZrruMR09wv68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vt56S+/6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MEr/P9k2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Mar 2026 22:07:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773871672;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=jZJKKTqO8P+jCyrnqWR8f46OGPkcylJr+E7KJRpOifY=;
	b=vt56S+/6VP8N3ZOUYHTcupYbWYjKA3vnXmBWjoyCDYtioBa/CvZgDjOCpBS2jthZGQt3Pe
	EmJDDqV9PCKuLtabur6I9BsbxatCtG7b4I+m+WMskJnI6+HRGIXuClkYfvPGlTiI/jw4CD
	hWfcBEz7dGUsvddBN3VVS+zxdeebqVecpvOFJGChQiubsyS98hXvhgPs9xKBK/scLPtWJO
	Xy861T/BjUyH4n+NRgCs/nAbWxA7CneyjLO3o5C4mOR8Q/yKgT0LR8oOYLLc43fuIQ8gVd
	cjtmxw0YqIgH3VY2olsOh0yVIe2TneNqM5UEO302zCv6C6Y+ztO1ili+GpumFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773871672;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=jZJKKTqO8P+jCyrnqWR8f46OGPkcylJr+E7KJRpOifY=;
	b=MEr/P9k27tprlR/esktg5JgK8QAmlqBcKfdwvtg4weuw15h/j/WCpauZs2MrhKGI55FHxW
	gxtZp0O9ZimgcdAQ==
From: "tip-bot2 for William Roche" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/mce/amd: Check SMCA feature bit before
 accessing SMCA MSRs
Cc: William Roche <william.roche@oracle.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Yazen Ghannam <yazen.ghannam@amd.com>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177387167044.1647592.7936336301829220582.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227176-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.986];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,alien8.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5C06D2C3438
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     201bc182ad6333468013f1af0719ffe125826b6a
Gitweb:        https://git.kernel.org/tip/201bc182ad6333468013f1af0719ffe1258=
26b6a
Author:        William Roche <william.roche@oracle.com>
AuthorDate:    Tue, 17 Mar 2026 10:38:10=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 18 Mar 2026 23:02:16 +01:00

x86/mce/amd: Check SMCA feature bit before accessing SMCA MSRs

People do effort to inject MCEs into guests in order to simulate/test
handling of hardware errors. The real use case behind it is testing the
handling of SIGBUS which the memory failure code sends to the process.

If that process is QEMU, instead of killing the whole guest, the MCE can
be injected into the guest kernel so that latter can attempt proper
handling and kill the user *process*  in the guest, instead, which
caused the MCE. The assumption being here that the whole injection flow
can supply enough information that the guest kernel can pinpoint the
right process. But that's a different topic...

Regardless of virtualization or not, access to SMCA-specific registers
like MCA_DESTAT should only be done after having checked the smca
feature bit. And there are AMD machines like Bulldozer (the one before
Zen1) which do support deferred errors but are not SMCA machines.

Therefore, properly check the feature bit before accessing related MSRs.

  [ bp: Rewrite commit message. ]

Fixes: 7cb735d7c0cb ("x86/mce: Unify AMD DFR handler with MCA Polling")
Signed-off-by: William Roche <william.roche@oracle.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20260218163025.1316501-1-william.roche@oracle=
.com
---
 arch/x86/kernel/cpu/mce/amd.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index da13c1e..a030ee4 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -875,13 +875,18 @@ void amd_clear_bank(struct mce *m)
 {
 	amd_reset_thr_limit(m->bank);
=20
-	/* Clear MCA_DESTAT for all deferred errors even those logged in MCA_STATUS=
. */
-	if (m->status & MCI_STATUS_DEFERRED)
-		mce_wrmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank), 0);
+	if (mce_flags.smca) {
+		/*
+		 * Clear MCA_DESTAT for all deferred errors even those
+		 * logged in MCA_STATUS.
+		 */
+		if (m->status & MCI_STATUS_DEFERRED)
+			mce_wrmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank), 0);
=20
-	/* Don't clear MCA_STATUS if MCA_DESTAT was used exclusively. */
-	if (m->kflags & MCE_CHECK_DFR_REGS)
-		return;
+		/* Don't clear MCA_STATUS if MCA_DESTAT was used exclusively. */
+		if (m->kflags & MCE_CHECK_DFR_REGS)
+			return;
+	}
=20
 	mce_wrmsrq(mca_msr_reg(m->bank, MCA_STATUS), 0);
 }


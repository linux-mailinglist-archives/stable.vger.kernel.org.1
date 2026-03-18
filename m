Return-Path: <stable+bounces-227154-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BCxDWkMu2lHegIAu9opvQ
	(envelope-from <stable+bounces-227154-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 21:34:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB732C2860
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 21:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6564303DD32
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 20:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18BE34107A;
	Wed, 18 Mar 2026 20:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mTfr1La5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LoD6KGKV"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7A0332EBC;
	Wed, 18 Mar 2026 20:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773866075; cv=none; b=ZhT+ruKtyf6YYKhXvSN0jRHXd57xinf8a7BR3yDlDkEcP+xciTXygJnbcWky51GJaWOv+LkDu4coo3b9eLMlFgbCWfMNOxRJ5G0FADDHpFh0UdexaBmYU4ORSuzhV/zg4bzh7e1VPAzps1xUMUalrPb9kZ+MUyppIpp6WjIA+AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773866075; c=relaxed/simple;
	bh=KvShYZ+D3Imm33PtX93U5t+SJ7ZnabW+H9ks1KboTBk=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=mQSjJiuFMscxgB2nYtfc1AB3o8wP8KP7BxxSReJJypniJGrfesEu0ZhM5pJhKo+Icj0vILMfl2OWnuYCZAXzzrLCeadfIqZPeHRgpwgnYLrchm7W76coNBcElWcY3N9iWFpmch8ODzverB9J28JAfmgIAPvMWEhWE7uaz6G4PN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mTfr1La5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LoD6KGKV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Mar 2026 20:34:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773866071;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=8OpgSssdpfR3nI4URVD7jxzVdwKlRfyiiQadySN4dAc=;
	b=mTfr1La5bKTueR8K0fDatJezgfjzyZiDeaLsOG6xkJsoQ6Gv6UU3KF/bFnlRgV7eJ9m2Um
	Ly6f7THscEWiTq8aA73jc6V4NNFZSiYo64QCFEflLNMXXko3blZlTIlpksHwWumMTfrNAR
	yZaE4t841NakE+7vXjCW69ulBO1v3xAuP5AQ6Eqjl8kzMjA1y+IwGy0qXPGSNoM+zexaRe
	rc1ovs9jR4OZdiRU8qzIy5yi7wP2EUp+30VeAMhwMcEtTBBu81GJTUoUyZxMIGn2E1cdwU
	4pWv5kDgiqFtvv2ihrLm6Kpsr9vDbrpAAUDBc5GvHcnhZ4MqKfuLYPIQ9s86Hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773866071;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=8OpgSssdpfR3nI4URVD7jxzVdwKlRfyiiQadySN4dAc=;
	b=LoD6KGKVvjb207Yf9FCJqckgioO6ho6I/qBhoFEn6SRUtr5/ToIojlbaWD7/8OS6TzSX09
	SrDmkAiLHc0Yb/AQ==
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
Message-ID: <177386607039.1647592.4151788935615459894.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-227154-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.982];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:dkim,amd.com:email,alien8.de:email]
X-Rspamd-Queue-Id: 8CB732C2860
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     06d45803a3c8d2390027443bbf329bba43f9f3e9
Gitweb:        https://git.kernel.org/tip/06d45803a3c8d2390027443bbf329bba43f=
9f3e9
Author:        William Roche <william.roche@oracle.com>
AuthorDate:    Tue, 17 Mar 2026 10:38:10=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 18 Mar 2026 21:25:26 +01:00

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


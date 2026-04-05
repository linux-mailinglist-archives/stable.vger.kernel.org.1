Return-Path: <stable+bounces-233330-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sB72KwZC0ml/UwcAu9opvQ
	(envelope-from <stable+bounces-233330-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 13:05:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2784339E1A9
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 13:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9FC33005394
	for <lists+stable@lfdr.de>; Sun,  5 Apr 2026 11:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D8933F394;
	Sun,  5 Apr 2026 11:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fXGjrcW5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m5Db6w5b"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4212D0603;
	Sun,  5 Apr 2026 11:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775387137; cv=none; b=fYydMrYLMB3f3v9cwFRWBElN6zamJqyGuCGrfuLy7Aum4z4qKVWNefNjF+Siap7wyAZqdCF1Gg3QCcam0PyvMMiWVcu0zogAHLIiGqBX6dGnBrFFLfEBT84Ue6FsXb4Ll5URVKOr6L284dQUGN8Su8dtuAmdW3i1Us+6IwKXnuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775387137; c=relaxed/simple;
	bh=RmRcpMF4OqcTJ4LPE8O3Rv+dYaiboJjNRLPzlXs2KUk=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=diFYyDNQwn/RCXjY3J69PkZqisKNV/GUUDXj9B5xZqPwyGO7Sfx9VrAivwW9LLvDfszmpCbEGpT4vwdLoPtGZ/K3ezE2dKsHKpnZbim4cHrI02F7mfY8jirp82ipAzzGE5Go5sqslUT2pjl+gdppC5KVsyEKAzzP+7Xx+iVz+tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fXGjrcW5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m5Db6w5b; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 05 Apr 2026 11:05:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1775387133;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=iAwU4I0i7YzJv/Jgl5ii9nsCVpn16JrBfwlR8dVq02o=;
	b=fXGjrcW5Ikpq5dPgefq9zmcw0b1qA4W1IAwuUOYn/Pg6sf6/Nmul4geE3lELST/JEwXcIa
	sy9vfmnKtctoZm3WquEPLURSzIJYWmGFih21qxyMQBSRA9t77PSCJaFFPkTdliztNhIefH
	XIE7S7U36IevBnou05y09sC7ZY8TjyRUu5QVimz/H3SsOrsIBTcfkv0uZ/91t91oSinsJf
	WCS26wcDGev5kj2UwqAbAsP3sVx7LuTYv88gpFVxMb/Pzcp/YeIAJWQ+vNCdUBNmWc6WUa
	jj10Cvpc8aMXrWCO8P1dXhHPy/T+qL1XCyZMj8ECNtHfvxCPI0MwzHOamsvBNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1775387133;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=iAwU4I0i7YzJv/Jgl5ii9nsCVpn16JrBfwlR8dVq02o=;
	b=m5Db6w5bkajym0+/0e7c6PtpSSphXcyQSDzM71PkJqHJ5as5VUuYJ8+XnE6cavISMeWWPg
	djsvbgQYZk5aRyDg==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: ras/urgent] x86/mce/amd: Filter bogus hardware errors on Zen3 clients
Cc: Bert Karwatzki <spasswolf@web.de>, Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Mario Limonciello <mario.limonciello@amd.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177538713213.226963.5944467932286571212.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233330-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[web.de,amd.com,alien8.de,vger.kernel.org,kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alien8.de:email,vger.kernel.org:replyto,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: 2784339E1A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following commit has been merged into the ras/urgent branch of tip:

Commit-ID:     0422b07bc4c296b736e240d95d21fbfebbfaa2ca
Gitweb:        https://git.kernel.org/tip/0422b07bc4c296b736e240d95d21fbfebbf=
aa2ca
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Sat, 28 Feb 2026 09:08:14 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sun, 05 Apr 2026 12:42:22 +02:00

x86/mce/amd: Filter bogus hardware errors on Zen3 clients

Users have been observing multiple L3 cache deferred errors after recent
kernel rework of deferred error handling.=C2=B9 =E2=81=B4

The errors are bogus due to inconsistent status values. Also, user verified
that bogus MCA_DESTAT values are present on the system even with an older
kernel.=C2=B2

The errors seem to be garbage values present in the MCA_DESTAT of some L3
cache banks. These were implicitly ignored before the recent kernel rework
because these do not generate a deferred error interrupt.

A later revision of the rework patch was merged for v6.19. This naturally
filtered out most of the bogus error logs. However, a few signatures still
remain.=C2=B3

Minimize the scope of the filter to the reported CPU
family/model/stepping and only for errors which don't have the Enabled
bit in the MCi status MSR.

=C2=B9 https://lore.kernel.org/20250915010010.3547-1-spasswolf@web.de
=C2=B2 https://lore.kernel.org/6e1eda7dd55f6fa30405edf7b0f75695cf55b237.camel=
@web.de
=C2=B3 https://lore.kernel.org/21ba47fa8893b33b94370c2a42e5084cf0d2e975.camel=
@web.de
=E2=81=B4 https://lore.kernel.org/r/CAKFB093B2k3sKsGJ_QNX1jVQsaXVFyy=3DwNwpzC=
GLOXa_vSDwXw@mail.gmail.com

  [ bp: Generalize the condition according to which errors are bogus. ]

Fixes: 7cb735d7c0cb ("x86/mce: Unify AMD DFR handler with MCA Polling")
Closes: https://lore.kernel.org/20250915010010.3547-1-spasswolf@web.de
Reported-by: Bert Karwatzki <spasswolf@web.de>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-By: Bert Karwatzki <spasswolf@web.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/20250915010010.3547-1-spasswolf@web.de
---
 arch/x86/kernel/cpu/mce/amd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index a030ee4..28deaba 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -604,6 +604,14 @@ bool amd_filter_mce(struct mce *m)
 	enum smca_bank_types bank_type =3D smca_get_bank_type(m->extcpu, m->bank);
 	struct cpuinfo_x86 *c =3D &boot_cpu_data;
=20
+	/* Bogus hw errors on Cezanne A0. */
+	if (c->x86 =3D=3D 0x19 &&
+	    c->x86_model =3D=3D 0x50 &&
+	    c->x86_stepping =3D=3D 0x0) {
+		if (!(m->status & MCI_STATUS_EN))
+			return true;
+	}
+
 	/* See Family 17h Models 10h-2Fh Erratum #1114. */
 	if (c->x86 =3D=3D 0x17 &&
 	    c->x86_model >=3D 0x10 && c->x86_model <=3D 0x2F &&


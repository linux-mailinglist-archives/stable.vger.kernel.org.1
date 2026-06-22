Return-Path: <stable+bounces-267662-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PgPHJfEOOWqOmAcAu9opvQ
	(envelope-from <stable+bounces-267662-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 12:31:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E79CD6AEB63
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 12:31:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=mfCJNwNQ;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=bZY5kRZ6;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267662-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267662-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D5F03062616
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 10:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A266B3A59BC;
	Mon, 22 Jun 2026 10:26:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEEE3A545E
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 10:26:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782124017; cv=none; b=AK7hKUHZTXL7LoYRx1j9wfVK7xYqNnenOzMWlsIpqOxeOh+Ox0xuaLCAhkb+DVAKQ5Jc4NaC38kZ6AcleYy4ryTV/5MmdJ1pBEnYnINrxbs4N8gSwkPUK1ArgbiNOpT5BslvZutOOhl260Rp8hkelZW8OOjOIXUAB9OiAj9B6mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782124017; c=relaxed/simple;
	bh=eBc+tU8kzsfH32lD1H3+mVaLhkOKjWBSsM9xJJcs0Ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DSSsz1P7OBoHCaVa5GjIEx+TwuZmIn3pbW7J/oVFb2B92xPvk255wyj9jHFzqBBxQnuz8YiRg77VQ6+88JLj2FRIzcUz4Z7wk6K2K/I90EDLhiY+cKPKAhClhGOu8NHJ2Eqm0sRw8zs9LOsN1tvaJbQ0dUdvIvHa4iF8SlN7kJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mfCJNwNQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bZY5kRZ6; arc=none smtp.client-ip=193.142.43.55
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782124014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fOzEjx5PQnC9UfVnNe9RtDdPxKOBZ1MuHuIdqCNNaus=;
	b=mfCJNwNQ/g+J/avmfKLwQeiFGdzxxkpedm0m/PTMD4+V/YOidHVwXaVNzbyqJNjNBvRtQb
	pFcGhcgm3qhGhNyIWjcEEdF+brCLVfL6SK5sVoJDvVXnbKzcCvFh3dXviqidVsTBlbaSCf
	eVjd8yAFYIjzynOT8xtpbkZH0CVI6E345C6OhqUZN+0O8u1VBEj1NGmISCOKgAfvtv1kni
	8ccLgZBMpFVj/QynrOkasb/Fl4muO7Z4t/jWPY0Z2iGadrPru64jaBv+S8zBgnsWEzSyNV
	/lYJ7qCwBq4WJmjHGGXh2VoEkSGbrwMOLJ+pQwH4g4kclNFbSigrVGoHFKLG8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782124014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fOzEjx5PQnC9UfVnNe9RtDdPxKOBZ1MuHuIdqCNNaus=;
	b=bZY5kRZ6cBpqeSAX3smnYBoQjCEcoZxXCLulWb/SNwQdtpotxEpZUla1UIRpq1/4HSV63O
	4V1MPGPFSKF2D0CA==
To: stable@vger.kernel.org
Cc: Bryan Brattlof <bb@ti.com>,
	Daniel Wagner <daniel.wagner@monom.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	cip-dev@lists.cip-project.org,
	nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/4] ARM: group is_permission_fault() with is_translation_fault()
Date: Mon, 22 Jun 2026 12:26:31 +0200
Message-ID: <20260622102634.780100-2-bigeasy@linutronix.de>
In-Reply-To: <20260622102634.780100-1-bigeasy@linutronix.de>
References: <20260622102634.780100-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267662-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:bb@ti.com,m:daniel.wagner@monom.org,m:jan.kiszka@siemens.com,m:cip-dev@lists.cip-project.org,m:nobuhiro.iwamatsu.x90@mail.toshiba,m:pavel@nabladev.com,m:rmk+kernel@armlinux.org.uk,m:bigeasy@linutronix.de,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,armlinux.org.uk:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E79CD6AEB63

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

commit dea20281ac88226615761c570c8ff7adc18e6ac2 upstream.

Group is_permission_fault() with is_translation_fault(), which is
needed to use is_permission_fault() in __do_kernel_fault(). As
this is static inline, there is no need for this to be under
CONFIG_MMU.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/mm/fault.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index ed1a25f457e48..879730a47c4a2 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -128,6 +128,19 @@ static inline bool is_translation_fault(unsigned int f=
sr)
 	return false;
 }
=20
+static inline bool is_permission_fault(unsigned int fsr)
+{
+	int fs =3D fsr_fs(fsr);
+#ifdef CONFIG_ARM_LPAE
+	if ((fs & FS_MMU_NOLL_MASK) =3D=3D FS_PERM_NOLL)
+		return true;
+#else
+	if (fs =3D=3D FS_L1_PERM || fs =3D=3D FS_L2_PERM)
+		return true;
+#endif
+	return false;
+}
+
 static void die_kernel_fault(const char *msg, struct mm_struct *mm,
 			     unsigned long addr, unsigned int fsr,
 			     struct pt_regs *regs)
@@ -229,19 +242,6 @@ void do_bad_area(unsigned long addr, unsigned int fsr,=
 struct pt_regs *regs)
 #define VM_FAULT_BADMAP		((__force vm_fault_t)0x010000)
 #define VM_FAULT_BADACCESS	((__force vm_fault_t)0x020000)
=20
-static inline bool is_permission_fault(unsigned int fsr)
-{
-	int fs =3D fsr_fs(fsr);
-#ifdef CONFIG_ARM_LPAE
-	if ((fs & FS_MMU_NOLL_MASK) =3D=3D FS_PERM_NOLL)
-		return true;
-#else
-	if (fs =3D=3D FS_L1_PERM || fs =3D=3D FS_L2_PERM)
-		return true;
-#endif
-	return false;
-}
-
 static int __kprobes
 do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 {
--=20
2.53.0



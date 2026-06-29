Return-Path: <stable+bounces-269780-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SaQWO/iGQmq19AkAu9opvQ
	(envelope-from <stable+bounces-269780-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 16:53:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 051C96DC534
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 16:53:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=yvqQT69A;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=AmUBT119;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269780-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269780-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 00E0F3021BF8
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 14:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674A03A2549;
	Mon, 29 Jun 2026 14:41:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7F63B6366
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 14:41:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782744101; cv=none; b=DYB251zEal/RtkXngyOFnNUcaoljPi5VMXmaRbuqvLaI0HmcvKhV4RXuoa/d5+99xsaqFyhz1ZEvDvVmWIw1bMBj1NFy25ndCqIXrGK6Cs1ISU1Qm2fDP4lQ4CFtXv3mOXu0z7+nWilhWwXLwApDNSSw8pHjU4WWvw2dBKBQ29g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782744101; c=relaxed/simple;
	bh=aNxmFevyw/OGWflCkChzZ1Ua7/gHf6xA5aB3eat+Pxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OptMzICEGVOkYN/AhUrxTQWjKJMaqLseztNEv5iyIPAF1kI+v0lXOO+JJsVFSvteq/5ZRt5XYw1iBzpDjazrHwi8cp4cseYubfmHvVr+wLBOYoUbuBaLf61ShNk6u9uHzpqbEynSbAcsK3+xjFq3ICXGl99TNUjeb0bROCSBpvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yvqQT69A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AmUBT119; arc=none smtp.client-ip=193.142.43.55
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782744098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gw+2wAMnJQovU/U8ZXY7DgQ5GNeZYXVr6rqiZz2TyWw=;
	b=yvqQT69AuRhUrWWpWxI1l7ne44cJEwvD3F2GsWBCkChRzfXLFwO/mesqY0k+E5+4zA37Ka
	gM2IxNvqGmezmwB3Q4VWcQS52iqC8fr5wBkTBgrnRiR3q/6YYUbZiOJ0/KI4/7EVgygZdo
	NbzQzKwn6wd5Iu+enR21xcxgHDrwP4Iv5O7YWr6Axp8ZmRL0JbcNw9wL/2Lv8IjdzKjhig
	SvOLCf2qlu5/GEknlEp44pwwrFKf1ucntZYdOoL5Lw7MXhZ9izBcjN4kHMeS6ERrjSIrCj
	b2rbhPyyAQoAZQTgCH3nvzC0d0+38UCnQpq3xRYEU4FcvZqzDY6mMXej1wbRKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782744098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gw+2wAMnJQovU/U8ZXY7DgQ5GNeZYXVr6rqiZz2TyWw=;
	b=AmUBT119iYZfjXkVyzN5YEndyCqXLzB3zs2K4ZmNvzC9SgLW1f3mAXbYDrz53tUHE9EI1/
	xvsVAYa+pwGzO5Cg==
To: stable@vger.kernel.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Jon Humphreys <j-humphreys@ti.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	"Yadi.hu" <yadi.hu@windriver.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v6.18 2/3] ARM: ensure interrupts are enabled in __do_user_fault()
Date: Mon, 29 Jun 2026 16:41:30 +0200
Message-ID: <20260629144131.788576-3-bigeasy@linutronix.de>
In-Reply-To: <20260629144131.788576-1-bigeasy@linutronix.de>
References: <20260629144131.788576-1-bigeasy@linutronix.de>
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
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:jan.kiszka@siemens.com,m:j-humphreys@ti.com,m:rmk+kernel@armlinux.org.uk,m:yadi.hu@windriver.com,m:bigeasy@linutronix.de,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-269780-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable,kernel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linutronix.de:dkim,linutronix.de:email,linutronix.de:mid,linutronix.de:from_mime,vger.kernel.org:from_smtp,armlinux.org.uk:email,yadi.hu:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 051C96DC534

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

commit 59e4f3b45b96a24fc9b7a89e5f8a2168b30f95af upstream.

__do_user_fault() may be called from fault handling paths where the
interrupts are enabled or disabled. E.g. do_page_fault() calls this
with interrupts enabled, whereas do_sect_fault()->do_bad_area()
will call this with interrupts disabled. Since this is a userspace
fault, we know that interrupts were enabled in the parent context,
so call local_irq_enable() here to give a consistent interrupt state.

This is necessary for force_sig_info() when PREEMPT_RT is enabled.

Reported-by: Yadi.hu <yadi.hu@windriver.com>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/mm/fault.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index ed4330cc3f4e6..6c27ebd490938 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -190,7 +190,8 @@ __do_kernel_fault(struct mm_struct *mm, unsigned long a=
ddr, unsigned int fsr,
=20
 /*
  * Something tried to access memory that isn't in our memory map..
- * User mode accesses just cause a SIGSEGV
+ * User mode accesses just cause a SIGSEGV. Ensure interrupts are enabled
+ * for preempt RT.
  */
 static void
 __do_user_fault(unsigned long addr, unsigned int fsr, unsigned int sig,
@@ -198,6 +199,8 @@ __do_user_fault(unsigned long addr, unsigned int fsr, u=
nsigned int sig,
 {
 	struct task_struct *tsk =3D current;
=20
+	local_irq_enable();
+
 #ifdef CONFIG_DEBUG_USER
 	if (((user_debug & UDBG_SEGV) && (sig =3D=3D SIGSEGV)) ||
 	    ((user_debug & UDBG_BUS)  && (sig =3D=3D SIGBUS))) {
@@ -268,6 +271,7 @@ do_kernel_address_page_fault(struct mm_struct *mm, unsi=
gned long addr,
 		 * should not be faulting in kernel space, which includes the
 		 * vector/khelper page. Handle the branch predictor hardening
 		 * while interrupts are still disabled, then send a SIGSEGV.
+		 * Note that __do_user_fault() will enable interrupts.
 		 */
 		harden_branch_predictor();
 		__do_user_fault(addr, fsr, SIGSEGV, SEGV_MAPERR, regs);
--=20
2.53.0



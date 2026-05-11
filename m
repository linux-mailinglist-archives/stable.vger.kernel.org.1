Return-Path: <stable+bounces-245223-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sACvDtbfAWptlgEAu9opvQ
	(envelope-from <stable+bounces-245223-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:55:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A9050F6BB
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A22693030D34
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 13:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD39D3F54AC;
	Mon, 11 May 2026 13:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0ORC6IDJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gDxn9kix"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227F63A4508
	for <stable@vger.kernel.org>; Mon, 11 May 2026 13:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507649; cv=none; b=Fe0X/Es3pyAaEFHayYwncuCE6xh3oyN6fBePCBWdH2JRyKYoLmsvVx0wOlQs3Esu5tdWBo1/M113YE2sYNOXR0QuPcuoYDl4PKklZgXK+V7XI0zU3U03hIJ/5k9tYvi0MoeHGFTAaCri8QqrZ2rCS40WOev7PgGXmWQcQc6P7ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507649; c=relaxed/simple;
	bh=ElcI8bGBKSFvBDIxoOqF0qOVB96ZXwqQO6QlJQAUFnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ch7F7A+BWOi4olkYxVh9UTKmmD0XLW6PNb7fpc8tvgV5vLniytDeiQXWl9n1JECOTFvtr7WclDeMGgGhP2fiySGjZgtmay6Fxg+bfnOy9S/3x/fn4DTDJH1qmW/nZFog9QlyCccIalWCcaa1yC0WwcOn7zrXbwMBuhs9wodzyYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0ORC6IDJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gDxn9kix; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778507646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PYx6Mv08jw+CttVnUu1dcxJYEji9HDgJer+ugEWlfKw=;
	b=0ORC6IDJV4heAa9IZ6Z9Ado/DrXdcoJBkCeaWSYvX0WLJ13GwNSxBrtIe55Bqz32Obgnof
	squWIIgb2Rd4zEkc/+WmZO0nBix39tvqs3yWh4FddWGvZrGiiUKnTottNKhCI+vRxvUiDS
	b/OUatPIKVGabocpytb7eaI8I2Wa58fS2cx3CT1cNS/uX8d61MYGxv+5/kWZq5BNbTHAiE
	NxRuwC1IAgtNUW1nHU4BuWEam39yuInC2SQKftW0z/yWQTA4Rr0FILnPacw44Z3ImzAz4O
	HZci7lCH8+PLkziab5sygvO5U//WXj7spQS65PXjZ4Gb9QAqG6m+iueTOPwzyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778507646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PYx6Mv08jw+CttVnUu1dcxJYEji9HDgJer+ugEWlfKw=;
	b=gDxn9kixMNmE1DS9O63BXgriLMTYZkIeV1UL1Rkkk/M0QRIPCHpAsbZEoL66XW66FWT0+I
	oqGDl6oO0oDIrZDw==
To: stable@vger.kernel.org
Cc: Bryan Brattlof <bb@ti.com>,
	Daniel Wagner <daniel.wagner@monom.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	cip-dev@lists.cip-project.org,
	nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Xie Yuanbin <xieyuanbin1@huawei.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/4] ARM: allow __do_kernel_fault() to report execution of memory faults
Date: Mon, 11 May 2026 15:53:55 +0200
Message-ID: <20260511135357.2786242-3-bigeasy@linutronix.de>
In-Reply-To: <20260511135357.2786242-1-bigeasy@linutronix.de>
References: <20260511135357.2786242-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C1A9050F6BB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245223-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[stable,kernel];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:email,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Action: no action

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

commit 40b466db1dffb41f0529035c59c5739636d0e5b8 upstream.

Allow __do_kernel_fault() to detect the execution of memory, so we can
provide the same fault message as do_page_fault() would do. This is
required when we split the kernel address fault handling from the
main do_page_fault() code path.

Reviewed-by: Xie Yuanbin <xieyuanbin1@huawei.com>
Tested-by: Xie Yuanbin <xieyuanbin1@huawei.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/mm/fault.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index f87f353e5a8b0..192c8ab196dba 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -175,6 +175,8 @@ __do_kernel_fault(struct mm_struct *mm, unsigned long a=
ddr, unsigned int fsr,
 	 */
 	if (addr < PAGE_SIZE) {
 		msg =3D "NULL pointer dereference";
+	} else if (is_permission_fault(fsr) && fsr & FSR_LNX_PF) {
+		msg =3D "execution of memory";
 	} else {
 		if (is_translation_fault(fsr) &&
 		    kfence_handle_page_fault(addr, is_write_fault(fsr), regs))
--=20
2.53.0



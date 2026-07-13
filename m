Return-Path: <stable+bounces-274021-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TElAJM9cVWqHnQAAu9opvQ
	(envelope-from <stable+bounces-274021-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 23:46:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3A374F55A
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 23:46:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=gTjxUhoG;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=9kGronYX;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274021-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-274021-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 523723010CAD
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 21:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F145363C64;
	Mon, 13 Jul 2026 21:46:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C413624B8;
	Mon, 13 Jul 2026 21:46:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783979190; cv=none; b=DD49K6PGzvsE9wbivfVuBvEZb6BR1GUg5sChBtdEAP9RPDyp9wzLw0TMzfu6JlqPgrz1egd5B3Ix34hAHD853ak4ZQPdiA0RLQuBVD4r/39G07zK/MG8ocInMziQ8K1QwJmJiVpyhfGty6Sl64HoxYaAv+eNKcuBTjPKSPADr9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783979190; c=relaxed/simple;
	bh=qA5MO448gajdwi1efn7cACtoicInFI9tG804BXXBz34=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bP52igeXzSKe1omD8TbffpdoptX/jfwzo6EJGIzEGXKZbl3Bo+SZQutwkQsVPAcoM8ZhEvum1SmY4mu8pO2L7Wg0Hn9CGQN0IMJsxErEM3E5f0jWAnn5Uqh9Zdboo4tbNZvi3lyz5yVE8U8/pPNOR2dJWrK5GMg7P4D6xsGNjFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gTjxUhoG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9kGronYX; arc=none smtp.client-ip=193.142.43.55
Date: Mon, 13 Jul 2026 21:46:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783979187;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dnS03/zqqfb1E9gOJ7DW2uvMbf2OLTRf/s0fZoiHpSY=;
	b=gTjxUhoGE7z4d8RklNncEgTJ+2AnTBsVN3o9xf0W4/IrD4DHNgejpd+h5hxiBe7fuWDGqY
	MrYJhTh2SIHoG7nid5sJqHIkTXoSDvhajp5Is2ZovE6JRwz6cln6JXx9iqtup5SaEA0ekT
	IJtSfwLpyfYQ2fAD0U8CUhFzF3VVQsOlTSqqfs+UIr13Qhya5+Uh6sHc5rm6V4yxo9I00H
	mPMqgdW2IdbU0a3sk1ZaQz5wAx8kWmXqLWVZRcgT8fWR4dFFxnLHGp9PFDMt+flMepJZ80
	oWfhcgYdUwGP2WqW+RBQLVUD+nigDkQdbKnvlPSgjwYpzfy35KS8Igqv1wD07Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783979187;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dnS03/zqqfb1E9gOJ7DW2uvMbf2OLTRf/s0fZoiHpSY=;
	b=9kGronYXFyv6Na2xO8Y1LGZorvsw+oI+8tcVjQ+WBegcwsnl9ZYOgax2ejlHvAt/xSWvOV
	GG8HRzY55pm3w6Dw==
From: "tip-bot2 for Kiryl Shutsemau (Meta)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/tdx: Fix off-by-one in port I/O handling
Cc: Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>,
 "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Kai Huang <kai.huang@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260713133753.223947-2-kirill@shutemov.name>
References: <20260713133753.223947-2-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178397918563.1844600.14310093428416512457.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-tip-commits@vger.kernel.org,m:tsyrulnikov.borys@gmail.com,m:kas@kernel.org,m:dave.hansen@linux.intel.com,m:kai.huang@intel.com,m:sathyanarayanan.kuppuswamy@linux.intel.com,m:binbin.wu@linux.intel.com,m:rick.p.edgecombe@intel.com,m:stable@vger.kernel.org,m:x86@kernel.org,m:linux-kernel@vger.kernel.org,m:tsyrulnikovborys@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-274021-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,linux.intel.com,intel.com,vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,vger.kernel.org:replyto,intel.com:email,linutronix.de:from_mime,linutronix.de:dkim,tip-bot2:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8B3A374F55A

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     0f63e656b1c679d32ac595de29d10c03efca6a25
Gitweb:        https://git.kernel.org/tip/0f63e656b1c679d32ac595de29d10c03efc=
a6a25
Author:        Kiryl Shutsemau (Meta) <kas@kernel.org>
AuthorDate:    Mon, 13 Jul 2026 14:37:51 +01:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 13 Jul 2026 14:45:07 -07:00

x86/tdx: Fix off-by-one in port I/O handling

handle_in() and handle_out() in arch/x86/coco/tdx/tdx.c use:

    u64 mask =3D GENMASK(BITS_PER_BYTE * size, 0);

GENMASK(h, l) includes bit h. For size=3D1 (INB), this produces
GENMASK(8, 0) =3D 0x1FF (9 bits) instead of GENMASK(7, 0) =3D 0xFF (8
bits). The mask is one bit too wide for all I/O sizes.

Fix the mask calculation.

Fixes: 03149948832a ("x86/tdx: Port I/O: Add runtime hypercalls")
Reported-by: Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.int=
el.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Link: https://lore.kernel.org/all/CAKw_Dz96rfSQc6Rn+9QBcUFHhmkK+9zu+P=3Dbxowf=
ZwxrATCBRg@mail.gmail.com/
Cc:stable@vger.kernel.org
Link: https://patch.msgid.link/20260713133753.223947-2-kirill@shutemov.name
---
 arch/x86/coco/tdx/tdx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 29b6f1e..b8bbd71 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -694,7 +694,7 @@ static bool handle_in(struct pt_regs *regs, int size, int=
 port)
 		.r13 =3D PORT_READ,
 		.r14 =3D port,
 	};
-	u64 mask =3D GENMASK(BITS_PER_BYTE * size, 0);
+	u64 mask =3D GENMASK(BITS_PER_BYTE * size - 1, 0);
 	bool success;
=20
 	/*
@@ -714,7 +714,7 @@ static bool handle_in(struct pt_regs *regs, int size, int=
 port)
=20
 static bool handle_out(struct pt_regs *regs, int size, int port)
 {
-	u64 mask =3D GENMASK(BITS_PER_BYTE * size, 0);
+	u64 mask =3D GENMASK(BITS_PER_BYTE * size - 1, 0);
=20
 	/*
 	 * Emulate the I/O write via hypercall. More info about ABI can be found


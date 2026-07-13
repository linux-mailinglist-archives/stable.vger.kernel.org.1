Return-Path: <stable+bounces-274019-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y11+L7hcVWp3nQAAu9opvQ
	(envelope-from <stable+bounces-274019-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 23:46:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9E874F542
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 23:46:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=Q8YyF2zU;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=eoq9MSAl;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274019-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274019-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D53DD30292ED
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 21:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BEA360EF2;
	Mon, 13 Jul 2026 21:46:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1443242B2;
	Mon, 13 Jul 2026 21:46:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783979187; cv=none; b=Msc+gPCgf7+KlsfRmMz8R/lU7+FgPPH/+VEmO39cmjiqRunM/eBBtmECNg7bsM9YioR3yd22TSZ7JQ116xEXMIzYm7wL7HOtB9DzLeSYbLfmJcj4arKrEeuuXimJuTncM/mMNxIkXiWrSJtG2tKkEKyBEZtxNajoKzKHXoeJBNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783979187; c=relaxed/simple;
	bh=MWbgXqTHi4C+M254I3PAXh8CQxSBkxEBDHbXjZ7vUvU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ql6TkhyrwvlY9JEAini4fitEGzh7Ro0wMBgSjtPBenwyvzh/xciiSihGy3NZQxUvAudNqPiirErsR0cAaniIkI7H6hDhuK+ftQeUTeQw/DNNYRiug6ru43Cfou1oQMfjaPxP+lyKpX5I4KMRRRmj0T7Rc7SeFDSx7JGXCKZ7YOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q8YyF2zU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eoq9MSAl; arc=none smtp.client-ip=193.142.43.55
Date: Mon, 13 Jul 2026 21:46:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783979184;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pCKm33c5eLl29HKZhcYn6iJgUqNeXqb+W7GuiS4rItQ=;
	b=Q8YyF2zUKIsui24YdkBjT3Zq51UI31p90zhAgApC1r6OQjDppVauN9SZa676DsUeKMoCZs
	jrc1XmzAj3jbHlMU+Zu6EuVceXnQT/KXppu4L+RQd8wjtibv4JWwjZVAmeUcSIfqMyfdLD
	lu+H1P7sNNSPLuGr6LkeBD+X/SvOlFFk9nRR8tLevjK/oy6XReLnDRG7TSbbLobv88CkPw
	Cf8L84O96esTx6flldCNXtYRlttDBw04lN3UGzd8ohAz5MPAzFR4EEIWgidIFFuRgLDL7Z
	2WWeNplcC7FFMr60tyssBU/7kSMITugpaCnuxAuiA2P8aora/BiCvEe4oBc8uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783979184;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pCKm33c5eLl29HKZhcYn6iJgUqNeXqb+W7GuiS4rItQ=;
	b=eoq9MSAlVyp/AOByqf4A4X35TZhWbWzZBhsaZiF6yvgR20HKfCb8iaAmvp+XfBtXapkLLH
	wrgifV8CfNeoQDAw==
From: "tip-bot2 for Kiryl Shutsemau (Meta)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/tdx: Fix zero-extension for 32-bit port I/O
Cc: Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>,
 "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260713133753.223947-4-kirill@shutemov.name>
References: <20260713133753.223947-4-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178397918277.1844600.6197169661339305082.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-tip-commits@vger.kernel.org,m:tsyrulnikov.borys@gmail.com,m:kas@kernel.org,m:dave.hansen@linux.intel.com,m:binbin.wu@linux.intel.com,m:stable@vger.kernel.org,m:x86@kernel.org,m:linux-kernel@vger.kernel.org,m:tsyrulnikovborys@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-274019-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,linux.intel.com,vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,vger.kernel.org:from_smtp,vger.kernel.org:replyto,linutronix.de:from_mime,linutronix.de:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2B9E874F542

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     941370fc93cc3474e26811f4d3b062903eefe2cf
Gitweb:        https://git.kernel.org/tip/941370fc93cc3474e26811f4d3b062903ee=
fe2cf
Author:        Kiryl Shutsemau (Meta) <kas@kernel.org>
AuthorDate:    Mon, 13 Jul 2026 14:37:53 +01:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 13 Jul 2026 14:45:07 -07:00

x86/tdx: Fix zero-extension for 32-bit port I/O

According to x86 architecture rules, 32-bit operations zero-extend the
result to 64 bits. The current implementation of handle_in() only masks
the lower 32 bits, which preserves the upper 32 bits of RAX when a
32-bit port IN instruction is emulated.

Use insn_assign_reg() to write the result back into RAX with proper
partial-register-write semantics: 1- and 2-byte forms leave the upper
bits untouched, the 4-byte form zero-extends to the full register.

Fixes: 03149948832a ("x86/tdx: Port I/O: Add runtime hypercalls")
Reported-by: Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Link: https://lore.kernel.org/all/CAKw_Dz96rfSQc6Rn+9QBcUFHhmkK+9zu+P=3Dbxowf=
ZwxrATCBRg@mail.gmail.com/
Cc:stable@vger.kernel.org
Link: https://patch.msgid.link/20260713133753.223947-4-kirill@shutemov.name
---
 arch/x86/coco/tdx/tdx.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index b8bbd71..f904a63 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -694,8 +694,8 @@ static bool handle_in(struct pt_regs *regs, int size, int=
 port)
 		.r13 =3D PORT_READ,
 		.r14 =3D port,
 	};
-	u64 mask =3D GENMASK(BITS_PER_BYTE * size - 1, 0);
 	bool success;
+	u64 val;
=20
 	/*
 	 * Emulate the I/O read via hypercall. More info about ABI can be found
@@ -703,11 +703,9 @@ static bool handle_in(struct pt_regs *regs, int size, in=
t port)
 	 * "TDG.VP.VMCALL<Instruction.IO>".
 	 */
 	success =3D !__tdx_hypercall(&args);
+	val =3D success ? args.r11 : 0;
=20
-	/* Update part of the register affected by the emulated instruction */
-	regs->ax &=3D ~mask;
-	if (success)
-		regs->ax |=3D args.r11 & mask;
+	insn_assign_reg(&regs->ax, val, size);
=20
 	return success;
 }


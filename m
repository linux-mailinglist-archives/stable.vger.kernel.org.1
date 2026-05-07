Return-Path: <stable+bounces-244526-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFEwB7VJ/GmBNwAAu9opvQ
	(envelope-from <stable+bounces-244526-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 10:13:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7393F4E496D
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 10:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 110E830A72CE
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 08:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FEA332ED3;
	Thu,  7 May 2026 08:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X/qKEVaQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3619hra6"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D5233263F;
	Thu,  7 May 2026 08:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778141286; cv=none; b=sxi2bkSsWJsd3D6pYo5VXBqZCMtXC2YMdv4S0Du2660m8uc0GRB3/6iW57vQ6sC6FSs2H+Umyin7XdasnnzeQFD0vPIKqHrM7SKFfcDYXba/q6q39GCi9+YQZHRPknt2Bc5sW9RcbMFe3OPwBDrj4OSdQCNQra8TZmbQQB+MXSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778141286; c=relaxed/simple;
	bh=e5FUz8UbsviSI97TWslxIkpv4cwCxqh6Umq2YzesGdI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rF+7qgN62oI21ko6E7OAfrjJhhqJI5BWtJw3KEByv4vt/f+GLK2ejipMFdbHvsx6Q0uTeJJyaBMwZ19vcwayUdW6lSZXWKX4oHmmqRY/QNmUlGTl8fp4cS4rH3kcexv8UQpaaAFTzO6DsULnePD4AWsv67PBBuSq+3LYR3wNiw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X/qKEVaQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3619hra6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 May 2026 08:08:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778141284;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=47hs2mszR7kZCmMkmowXiSdpIprcybYF8qVKVjmNNmA=;
	b=X/qKEVaQHr5SEF+AkZ9vPEZ1UkG7IO36AL5LK5LLDBh9ZOa36O+bNluIj5PCX3kdkZ5Fbq
	Nit5ey5LmvwSZhsUXfqa5qRMxISKviFlz/fzQ5l8K9Z95jRZml2OZ+GyE8Ey/VkJ7yQcm9
	fbcxQ1aVRk8KlohA7+oWCyNaXpQrgjmyl2KpqPPAYocw+iE5mJOwq5CfhAZQQ2zE693DEr
	4/24vADhUdoQ0MzFpvZuF3iKpP4Igl+1h9i1EdiCzL/J+yZ/u7XhaelAuSVFTpcaREwhG0
	kg/8vwn0jT89R2/ntY7YKZHJpOPzkrQZKnuQ4dLXfyQ7VlQCPxjk/2h44zobZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778141284;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=47hs2mszR7kZCmMkmowXiSdpIprcybYF8qVKVjmNNmA=;
	b=3619hra6Vi/TV2aYrgBX8AGKOI6EpET4ICVJA4knzOlEupKk2p+9WuB9hVh93kjgn96Pus
	ozdSRIRnwjDVMbCA==
From: "tip-bot2 for David Gow" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/boot/e820: Re-enable BIOS fallback if e820
 table is empty
Cc: David Gow <david@davidgow.net>, Ingo Molnar <mingo@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>, stable@vger.kernel.org,
 Arnd Bergmann <arnd@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260416065746.1896647-1-david@davidgow.net>
References: <20260416065746.1896647-1-david@davidgow.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177814128242.424702.2696884158519435184.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7393F4E496D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244526-lists,stable=lfdr.de];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Action: no action

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     5772f6535227ebd104065d80afa8ed3478d34c5c
Gitweb:        https://git.kernel.org/tip/5772f6535227ebd104065d80afa8ed3478d=
34c5c
Author:        David Gow <david@davidgow.net>
AuthorDate:    Thu, 16 Apr 2026 14:57:43 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 07 May 2026 10:04:54 +02:00

x86/boot/e820: Re-enable BIOS fallback if e820 table is empty

In commit:

  157266edcc56 ("x86/boot/e820: Simplify append_e820_table() and remove restr=
iction on single-entry tables")

the check on the number of entries in the e820 table was removed. The intenti=
on
was to support single-entry maps, but by removing the check entirely, we also
skip the fallback (to, e.g., the BIOS 88h function).

This means that if no E820 map is passed in from the bootloader (which is the
case on some bootloaders, like linld), we end up with an empty memory map, and
the kernel fails to boot (either by deadlocking on OOM, or by failing to
allocate the real mode trampoline, or similar).

Re-instate the check in append_e820_table(), but only check that nr_entries is
non-zero. This allows e820__memory_setup_default() to fall back to other memo=
ry
size sources, and doesn't affect e820__memory_setup_extended(), as the latter
ignores the return value from append_e820_table().

In doing so, we also update the return values to be proper error codes, with
-ENOENT for this case (there are no entries), and -EINVAL for the case where =
an
entry appears invalid. Given none of the callers check the actual value -- ju=
st
whether it's nonzero -- this is largely aesthetic in practice.

Tested against linld, and the kernel boots again fine.

[ mingo: Readability edits to the comment and the changelog. ]

Fixes: 157266edcc56 ("x86/boot/e820: Simplify append_e820_table() and remove =
restriction on single-entry tables")
Signed-off-by: David Gow <david@davidgow.net>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://patch.msgid.link/20260416065746.1896647-1-david@davidgow.net
---
 arch/x86/kernel/e820.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 2a99927..eb72537 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -450,6 +450,10 @@ __init static int append_e820_table(struct boot_e820_ent=
ry *entries, u32 nr_entr
 {
 	struct boot_e820_entry *entry =3D entries;
=20
+	/* If there aren't any entries, we'll want to fall back to another source: =
*/
+	if (!nr_entries)
+		return -ENOENT;
+
 	while (nr_entries) {
 		u64 start =3D entry->addr;
 		u64 size  =3D entry->size;
@@ -458,7 +462,7 @@ __init static int append_e820_table(struct boot_e820_entr=
y *entries, u32 nr_entr
=20
 		/* Ignore the remaining entries on 64-bit overflow: */
 		if (start > end && likely(size))
-			return -1;
+			return -EINVAL;
=20
 		e820__range_add(start, size, type);
=20


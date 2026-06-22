Return-Path: <stable+bounces-267735-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P9VOFOxKOWpbqAcAu9opvQ
	(envelope-from <stable+bounces-267735-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 16:47:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7676B071A
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 16:47:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=WJyOx7FD;
	dkim=pass header.d=linutronix.de header.s=2020e header.b="5/EV6RCw";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267735-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267735-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A6E83015CAC
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 14:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CB13B38A9;
	Mon, 22 Jun 2026 14:43:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3894A27A12F;
	Mon, 22 Jun 2026 14:43:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782139384; cv=none; b=Gm7uGPyxf9HPGFWYl0uC+C9k85a5zdRIfHX7A9w6Raid9Oe6TStPzJWMA9ew0bqMgiKAzBXNzmRzT1733OYz2l6JWYzS+BLrlzMPLyfEUScZOePJ3ZdmEymx8BcEkXXUlC3nOh2gWp8j8/cCr7zChM/WBPXOxmSWUn/XBhCblec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782139384; c=relaxed/simple;
	bh=8WxJA3u1727kdZkX03oHBEPKTiW3RdUCl5GOAh53v9M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hWhaiogwQjrIc+w3hGcro8fJtGs2/3lw1g4QIEoSqquC8WanS5cwpUfEuIbpWey786sPCylYaaBXWAerZxM61lAsRhw+KXAvl/vDteC69+zAgGWXaqjmFJZiXUOkURcTasSHNebbQRGBwqfEO9au7wigKtDoFxmbH5z/bWPDfVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WJyOx7FD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5/EV6RCw; arc=none smtp.client-ip=193.142.43.55
Date: Mon, 22 Jun 2026 14:42:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782139381;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dZRvN3grLHdYgpJB1Xh1qMr/IVyYSjbqjYUSyEl3cvI=;
	b=WJyOx7FDarOTnWpUqfxmpsBM3bFH7857GIUTQyhnPxEgiqFCLT2QZIuDQ20gCnww3iGvF1
	xjaiE0lSRm2inC2oTHukgzqUQPKnhYHdqbRl5h/ueTYEUZVjv/Qt6dJP+7n+MGAIzIzt9B
	sjjSVJvC8hMgkXtZ3d5swgi1vvb+YvTwK4Pa17ixH+0BJktvBQcYiDBl4qDG6XR4QcqX4O
	Xg8WIBTTHl6Hn/e3m987Y9QjkxZyEmCieK1/VR1TFHClB0ZjSNUh9trdogZee4KrLt+euQ
	/ZngfdfkilYreO2xXjhhMZFh5VPD0fTP5u5BGX7JVWwEM19JuecBLj6S4N85nQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782139381;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dZRvN3grLHdYgpJB1Xh1qMr/IVyYSjbqjYUSyEl3cvI=;
	b=5/EV6RCwdAOOPqp6jZ4wmtZAiRbOUqgboHDqJw7PKl5E/3gOezc9aPvxhkVkqEQ/ALYTc/
	CNJVMZjXKydlDkDg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: core/urgent] debugobjects: Plug race against a concurrent OOM disable
Cc: syzbot+5e8dda76ca21dae314b6@syzkaller.appspotmail.com,
 Thomas Gleixner <tglx@kernel.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <874iiwlzlb.ffs@fw13>
References: <874iiwlzlb.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178213937887.2745857.7200288274976162334.tip-bot2@tip-bot2>
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
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-tip-commits@vger.kernel.org,m:syzbot+5e8dda76ca21dae314b6@syzkaller.appspotmail.com,m:tglx@kernel.org,m:stable@vger.kernel.org,m:x86@kernel.org,m:linux-kernel@vger.kernel.org,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-267735-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,5e8dda76ca21dae314b6];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E7676B071A

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     b81dde13cc163450dcb402dcc915ef13ba241e01
Gitweb:        https://git.kernel.org/tip/b81dde13cc163450dcb402dcc915ef13ba2=
41e01
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Sun, 21 Jun 2026 16:47:44 +02:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Mon, 22 Jun 2026 16:38:57 +02:00

debugobjects: Plug race against a concurrent OOM disable

syzbot reported a puzzling splat:

   WARNING: kernel/time/hrtimer.c:443 at stub_timer+0xa/0x20

stub_timer() is installed as timer callback function in
hrtimer_fixup_assert_init(), which is invoked when
debug_object_assert_init() can't find a shadow object. In that case debug
objects emits a warning about it before invoking the fixup.

Though the provided console log lacks this warning and instead has the
following a few seconds before the splat:

     ODEBUG: Out of memory. ODEBUG disabled

So the object was looked up in debug_object_assert_init() and the lookup
failed due a concurrent out of memory situation which disabled debug
objects and freed the shadow objects:

debug_object_assert_init()
        if (!debug_objects_enabled)
        	return;                         obj =3D alloc();
                				if (!obj) {
							// Out of memory
                                                	debug_objects_enabled =3D fa=
lse;
                                                        free_objects();
        obj =3D lookup_or_alloc();

        // The lookup failed because the other side
        // removed the objects, so this returns
        // an error code as the object in question
        // is not statically initialized

	if (!IS_ERR_OR_NULL(obj))
        	return;
        if (!obj) {
        	debug_oom();
                return;
        }

        print(...)
           if (!debug_objects_enabled)
                return;

        fixup(...)

The debug object splat is skipped because debug_objects_enabled is false,
but the fixup callback is invoked unconditionally, which makes the timer
disfunctional.

This is only a problem in debug_object_assert_init() and
debug_object_activate() as both have to handle statically initialized
objects and therefore must handle the error pointer return case
gracefully. All other places only handle the found/not found case and the
NULL pointer return is a signal for OOM. Otherwise they get a valid shadow
object.

Plug the hole by checking whether debug objects are still enabled before
invoking the print and fixup function in those two places.

Fixes: b84d435cc228 ("debugobjects: Extend to assert that an object is initia=
lized")
Reported-by: syzbot+5e8dda76ca21dae314b6@syzkaller.appspotmail.com
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/874iiwlzlb.ffs@fw13
---
 lib/debugobjects.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 6fb00e0..877f767 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -894,6 +894,14 @@ int debug_object_activate(void *addr, const struct debug=
_obj_descr *descr)
 	}
=20
 	raw_spin_unlock_irqrestore(&db->lock, flags);
+
+	/*
+	 * lookup_object_or_alloc() might have raced with a concurrent
+	 * allocation failure which disabled debug objects.
+	 */
+	if (!debug_objects_enabled)
+		return 0;
+
 	debug_print_object(&o, "activate");
=20
 	switch (o.state) {
@@ -1071,6 +1079,15 @@ void debug_object_assert_init(void *addr, const struct=
 debug_obj_descr *descr)
 		return;
 	}
=20
+	/*
+	 * lookup_object_or_alloc() might have raced with a concurrent
+	 * allocation failure which disabled debug objects. Don't run the fixup
+	 * as it might turn a valid object useless. See for example
+	 * hrtimer_fixup_assert_init().
+	 */
+	if (!debug_objects_enabled)
+		return;
+
 	/* Object is neither tracked nor static. It's not initialized. */
 	debug_print_object(&o, "assert_init");
 	debug_object_fixup(descr->fixup_assert_init, addr, ODEBUG_STATE_NOTAVAILABL=
E);


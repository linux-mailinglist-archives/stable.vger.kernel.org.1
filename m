Return-Path: <stable+bounces-272428-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q5yAD4cFTWqJtgEAu9opvQ
	(envelope-from <stable+bounces-272428-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 15:56:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEBF71C2F6
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 15:56:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="b/6CwTdO";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272428-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272428-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4658F32002D2
	for <lists+stable@lfdr.de>; Tue,  7 Jul 2026 13:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB744422547;
	Tue,  7 Jul 2026 13:46:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2403FA5EB;
	Tue,  7 Jul 2026 13:46:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783431985; cv=none; b=QtTzuxu9YJNDxQyn4Th2Canv6YHSP6GDrL7s/YXCJ/fXtDkJADWkw3HFOo36nw8296s3M51xJch00AR9U8+bBgs6+5QdCPwvOtOox69dvHrcKImS1cR4PD/2RyemvOm3c9h4N9M2MpW2zSY8QpqGzhafOOygLWm/enLonq9sxe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783431985; c=relaxed/simple;
	bh=94hcNEtcdvV7KVjsVbN/46mvskZkqtz5iAKp0+NYinY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=i8DL7wzGQI5fSKd2szCWMQEyB5qtm934mEyCbEiHgiIZzTfPpNNlBIH/UZsvMv/O0yhRIiSQHbckabrXVSCCIHJ+jYLa5jd+B850lamPvfSLXIrMArUlF7kT7xII8Pd1aLB8u/lr/dcS5e0HTRxk+WTDPbj6Y76wnjRr7I6sjUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/6CwTdO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596211F00ADF;
	Tue,  7 Jul 2026 13:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783431981;
	bh=+2i7auYfxH+Wpn0TT15Yp87zPBX45q0Fv34N8u17wCw=;
	h=Date:From:To:Cc:Subject:References;
	b=b/6CwTdOO0w5S2Nv9w2dMlCDfCdhK4E24A2Urt7tYbPDfK6+GDym3tFYrtzP9tbXQ
	 qqwDWMkWRuOKrhnGZ+h0flTFLnUxg7l4Jzo3KkDRerAEmcyNa99fhyCWcaMlpwXJMw
	 aaPlr69cpuHUHRTBBLb/e3bpBOmLOER+4SlLKm5Q0Vo06OVpyrP0jyM8UIbb5BbnOT
	 n43Ajq/rUpyOBBOAWYmf1pbljzSFVB00jKozpBuarfQIUYb7AI/8EspFJGWqWSJlRn
	 v3FrBl+ymzMbPaO+dm2nysi2+4Buhc2oajhoarQJWQi+BIdvhHvMUFrFgyzma3US12
	 TVS5qAEqgoGwg==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1wh680-00000000h4a-2aGU;
	Tue, 07 Jul 2026 09:46:24 -0400
Message-ID: <20260707134624.467637804@kernel.org>
User-Agent: quilt/0.69
Date: Tue, 07 Jul 2026 09:46:12 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Michael Bommarito <michael.bommarito@gmail.com>,
 Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-linus][PATCH 08/13] tracing/user_events: Fix use-after-free of enabler in
 user_event_mm_dup()
References: <20260707134604.275787924@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,efficios.com,linux-foundation.org,vger.kernel.org,gmail.com,linux.microsoft.com];
	TAGGED_FROM(0.00)[bounces-272428-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:mhiramat@kernel.org,m:mark.rutland@arm.com,m:mathieu.desnoyers@efficios.com,m:akpm@linux-foundation.org,m:stable@vger.kernel.org,m:michael.bommarito@gmail.com,m:beaub@linux.microsoft.com,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rostedt@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,goodmis.org:email,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9BEBF71C2F6

From: Michael Bommarito <michael.bommarito@gmail.com>

user_event_enabler_destroy() removes an enabler from the per-mm
mm->enablers list with list_del_rcu() and then frees it immediately with
kfree(). That list is walked locklessly by user_event_mm_dup() during
fork(), under rcu_read_lock() only:

	rcu_read_lock();
	list_for_each_entry_rcu(enabler, &old_mm->enablers, mm_enablers_link)
		...

user_event_mm_dup() does not take event_mutex. The per-enabler destroy
path user_events_ioctl_unreg() (DIAG_IOCSUNREG) takes event_mutex but
nothing that excludes the dup walk. Threads that share an mm share one
user_event_mm and one enabler list, so an unregister on one thread can
free an enabler while another thread is forking and user_event_mm_dup()
is mid-walk. The walk then dereferences the freed enabler (for example
enabler->event in user_event_enabler_dup()).

This is reachable by an unprivileged task that can open user_events_data:
a single multithreaded process that registers an enabler and then
concurrently unregisters it and calls fork() triggers the race. KASAN
reports a slab-use-after-free read in user_event_enabler_dup() called
from user_event_mm_dup() and copy_process() during clone(); with
kasan.fault=panic the kernel panics.

Free the enabler after a grace period with kfree_rcu(), matching the
list_del_rcu() removal and the rcu_read_lock() readers in
user_event_mm_dup(). Add an rcu_head to struct user_event_enabler for
this. The error path in user_event_enabler_create() keeps using kfree()
because that enabler is freed before it is published to the RCU list.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260618222743.538915-1-michael.bommarito@gmail.com
Fixes: 7235759084a4 ("tracing/user_events: Use remote writes for event enablement")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Acked-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events_user.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index c4ba484f7b38..412ca1e3a40c 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -109,6 +109,9 @@ struct user_event_enabler {
 
 	/* Track enable bit, flags, etc. Aligned for bitops. */
 	unsigned long		values;
+
+	/* Defer free so RCU list readers (user_event_mm_dup) are safe. */
+	struct rcu_head		rcu;
 };
 
 /* Bits 0-5 are for the bit to update upon enable/disable (0-63 allowed) */
@@ -404,7 +407,12 @@ static void user_event_enabler_destroy(struct user_event_enabler *enabler,
 	/* No longer tracking the event via the enabler */
 	user_event_put(enabler->event, locked);
 
-	kfree(enabler);
+	/*
+	 * The enabler is removed from an RCU-traversed list
+	 * (user_event_mm_dup walks mm->enablers under rcu_read_lock only),
+	 * so the backing memory must outlive a grace period.
+	 */
+	kfree_rcu(enabler, rcu);
 }
 
 static int user_event_mm_fault_in(struct user_event_mm *mm, unsigned long uaddr,
-- 
2.53.0




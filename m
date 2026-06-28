Return-Path: <stable+bounces-269575-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id orB/BwxyQWoqqwkAu9opvQ
	(envelope-from <stable+bounces-269575-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 21:12:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFCC6D4B38
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 21:12:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b="fTx8f/7S";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269575-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269575-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D20DB300D33D
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 19:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421F62E7360;
	Sun, 28 Jun 2026 19:12:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19EA262D0B;
	Sun, 28 Jun 2026 19:12:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782673929; cv=none; b=hnSZtu/UKFml36eUu2sV82Fsq6XrMJTNzAxR7D1K0hWIiMiWmBiYODKNyAHkMeLfAUYUK/jACa9xcYiupqHyy38rjeRUU7Tjfxn+r86Vdtj3fj+1K7cxgSqqUJmmiF8IFAPxRiVvjG+omhS7fkn4Xtfrg+mOLXHzRfYrFtvzE1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782673929; c=relaxed/simple;
	bh=3L12A3lGnS6WG0q7TXqD3Hfilz27LeKchoCOUjTVtaA=;
	h=Date:To:From:Subject:Message-Id; b=TukzyaOsWdS/FNkBDO0J6ADqRE8vIXqJQtsaXsyIAJUKIJD+/f9VTC4gdGA5k7j+LeViLZRs7whDqM6f/R11c25dduxnhFqD5J+OnbsI4pFcco1OUzJwgL7lW7TS0USK9DDIv5hw6GhAYL6darwWXj8QHHbjiVNTihfIOK0jJuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fTx8f/7S; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CFCB1F000E9;
	Sun, 28 Jun 2026 19:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782673927;
	bh=NI2dmLjhi0P+bHrbVKSvxGp3PTHKHDRuyitdYyjnWcs=;
	h=Date:To:From:Subject;
	b=fTx8f/7Souh24wdVKn0pbWpFRf+OBKlrhKw/Io5cvw4h9zp+6kuu8ZSVhMV44B4uA
	 1Y+4xHrtkZx69yYVkkX68wTKI6AxD6gFB904A+SoYSLKl8s5NSGVvXC7vl7B5cQyUB
	 awJlJ4ugqdw2jTjCkhJ/LP3n1l6muhSGJxtzx4PE=
Date: Sun, 28 Jun 2026 12:12:07 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,rostedt@goodmis.org,peterz@infradead.org,oleg@redhat.com,nogikh@google.com,mhiramat@kernel.org,mathieu.desnoyers@efficios.com,elver@google.com,ebiederm@xmission.com,brauner@kernel.org,adrianhuang0701@gmail.com,include@grrlz.net,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + signal-avoid-shared-siginfo-namespace-rewrites.patch added to mm-nonmm-unstable branch
Message-Id: <20260628191207.6CFCB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:mm-commits@vger.kernel.org,m:stable@vger.kernel.org,m:rostedt@goodmis.org,m:peterz@infradead.org,m:oleg@redhat.com,m:nogikh@google.com,m:mhiramat@kernel.org,m:mathieu.desnoyers@efficios.com,m:elver@google.com,m:ebiederm@xmission.com,m:brauner@kernel.org,m:adrianhuang0701@gmail.com,m:include@grrlz.net,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[linux-foundation.org];
	FREEMAIL_TO(0.00)[vger.kernel.org,goodmis.org,infradead.org,redhat.com,google.com,kernel.org,efficios.com,xmission.com,gmail.com,grrlz.net,linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269575-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux-foundation.org:dkim,linux-foundation.org:email,linux-foundation.org:from_mime,infradead.org:email,efficios.com:email,xmission.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2FFCC6D4B38


The patch titled
     Subject: signal: avoid shared siginfo namespace rewrites
has been added to the -mm mm-nonmm-unstable branch.  Its filename is
     signal-avoid-shared-siginfo-namespace-rewrites.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/signal-avoid-shared-siginfo-namespace-rewrites.patch

This patch will later appear in the mm-nonmm-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via various
branches at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there most days

------------------------------------------------------
From: Bradley Morgan <include@grrlz.net>
Subject: signal: avoid shared siginfo namespace rewrites
Date: Mon, 22 Jun 2026 20:25:08 +0000

send_signal_locked() rewrites sender ids for the target namespace.  Group
sends reuse the same siginfo, so one recipient can affect the next.

Copy the siginfo before changing it.

Link: https://lore.kernel.org/86a8857d58d43ee26a8b365b837fd24830343494.1782159692.git.include@grrlz.net
Fixes: 7a0cf094944e ("signal: Correct namespace fixups of si_pid and si_uid")
Signed-off-by: Bradley Morgan <include@grrlz.net>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Adrian Huang <adrianhuang0701@gmail.com>
Cc: Aleksandr Nogikh <nogikh@google.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Marco Elver <elver@google.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 kernel/signal.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/kernel/signal.c~signal-avoid-shared-siginfo-namespace-rewrites
+++ a/kernel/signal.c
@@ -1181,6 +1181,7 @@ static inline bool has_si_pid_and_uid(st
 int send_signal_locked(int sig, struct kernel_siginfo *info,
 		       struct task_struct *t, enum pid_type type)
 {
+	struct kernel_siginfo rewritten;
 	/* Should SIGKILL or SIGSTOP be received by a pid namespace init? */
 	bool force = false;
 
@@ -1194,6 +1195,9 @@ int send_signal_locked(int sig, struct k
 		/* SIGKILL and SIGSTOP is special or has ids */
 		struct user_namespace *t_user_ns;
 
+		rewritten = *info;
+		info = &rewritten;
+
 		rcu_read_lock();
 		t_user_ns = task_cred_xxx(t, user_ns);
 		if (current_user_ns() != t_user_ns) {
_

Patches currently in -mm which might be from include@grrlz.net are

lib-string-fix-memchr_inv-for-large-ranges.patch
signal-avoid-shared-siginfo-namespace-rewrites.patch



Return-Path: <stable+bounces-264024-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HC7AIUhtMWo2jAUAu9opvQ
	(envelope-from <stable+bounces-264024-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:35:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A00D6912E7
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:35:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=DSfnVjqz;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264024-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-264024-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 386153036756
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FC137C912;
	Tue, 16 Jun 2026 15:28:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC20F30C360;
	Tue, 16 Jun 2026 15:28:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623722; cv=none; b=Ujm+0dt+TBu5vapzf+DQDw5BbJkZCTt7UdbE492HXlGeXXlvtcweLndJw4Bz5HmBdbD+0zPwyg7r6jmYlL62E1GjJV7G68FUF1utSt/SWGCX0DN2gND/cmEypKoX9LL7AwPwsczhYnUG8M7zan6P2162286XmB5oOOxjuuZCme0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623722; c=relaxed/simple;
	bh=FuMd/IXq3zFJkVve9Y0EgRrpgyrS5jKGSZ9LOB46DNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lzi4NWiuQSrtzcPoVGm2ZqmE16Y3C4VoYJdni6Jf2aqP5WhLJOkAMYRGsDlAvFKVzoFUpvAY1AVLRXaUMW7lauNa1M+UD9/tequ2dNkJ06xIj1RC+k8YG1CWn3qwgYKSHruX84dFqOta4ywM6qfctSkm0+o2QbXTadySWKEmstw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DSfnVjqz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B076F1F000E9;
	Tue, 16 Jun 2026 15:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781623721;
	bh=XD+3QjWoTYyIKmd6U2w6AdsKw/rggvYWjImOexT9p0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DSfnVjqzavc4yFyse/vSyM6gWeMATCdNLKXmz/B+GosGo4Ci3bMFGUWlf9q8HM3fm
	 17K1ZyclTRJwWYSVWAth//sL5S8xMaDqbLHngnBosz8xrNXnEmtU+vzRSmq8YEHHOR
	 yMpHRU3wrIc1BIa8ouPDFD4FDp9FaiXBQO9vBSKA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Eva Kurchatova <eva.kurchatova@virtuozzo.com>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 7.0 184/378] tracing: Fix CFI violation in probestub being called by tprobes
Date: Tue, 16 Jun 2026 20:26:55 +0530
Message-ID: <20260616145120.068262222@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264024-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:mhiramat@kernel.org,m:eva.kurchatova@virtuozzo.com,m:rostedt@goodmis.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url,virtuozzo.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A00D6912E7

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eva Kurchatova <eva.kurchatova@virtuozzo.com>

commit 0652a3daa78723f955b1ebeb621665ce72bec53e upstream.

The probestub is a function to allow tprobes to hook to a tracepoint to
gain access to its parameters. The function itself is only referenced by
the tracepoint structure which lives in the __tracepoint section. objtool
explicitly ignores that section and when processing functions in the
kernel, if it detects one that has no references it will seal it to have
its ENDBR stripped on boot up.

This means when a tprobe is attached to the sched_wakeup tracepoint, when it
is triggered it will call __probestub_sched_wakeup and due to the missing
ENDBR on a CFI-enabled machine it will take a #CP exception.

Fix this by adding CFI_NOSEAL annotation to probestub declaration.

Cc: stable@vger.kernel.org
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Link: https://patch.msgid.link/20260603153147.573589-1-eva.kurchatova@virtuozzo.com
Fixes: d5173f753750 ("objtool: Exclude __tracepoints data from ENDBR checks")
Signed-off-by: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
[ Updated change log ]
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/tracepoint.h |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -20,6 +20,7 @@
 #include <linux/rcupdate_trace.h>
 #include <linux/tracepoint-defs.h>
 #include <linux/static_call.h>
+#include <linux/cfi.h>
 
 struct module;
 struct tracepoint;
@@ -380,6 +381,13 @@ static inline struct tracepoint *tracepo
 	void __probestub_##_name(void *__data, proto)			\
 	{								\
 	}								\
+	/*								\
+	 * Annotate the probestub 'CFI_NOSEAL' to stop objtool from	\
+	 * requesting the kernel remove the ENDBR, because the only	\
+	 * references to the function are in the __tracepoint section,	\
+	 * that objtool doesn't scan.					\
+	 */								\
+	CFI_NOSEAL(__probestub_##_name);				\
 	DEFINE_STATIC_CALL(tp_func_##_name, __traceiter_##_name);	\
 	DEFINE_RUST_DO_TRACE(_name, TP_PROTO(proto), TP_ARGS(args))
 




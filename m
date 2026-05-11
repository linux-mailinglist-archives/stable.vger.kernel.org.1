Return-Path: <stable+bounces-245162-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHXhGXadAWoHggEAu9opvQ
	(envelope-from <stable+bounces-245162-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 11:12:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB53F50AAC8
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 11:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8FF1430CD844
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 08:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6913BED23;
	Mon, 11 May 2026 08:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYB004eR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5A63B19BA
	for <stable@vger.kernel.org>; Mon, 11 May 2026 08:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489849; cv=none; b=Kl7HSEO7L7pmCEjizmH/m2nDqnNAoEPWV4jGSCwJOwLtYYAeOF359g3+dpUmQQXlnqC/vxWKpkOtIrU/5IG/mnTwzgG1WG+xWrcgLoLKTXNLzmHdTwEZ85AXJcuPnpo8cd3QJToVQt9ZKYp5XVCvFItrH5VTm5WxKgCruJ6P4k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489849; c=relaxed/simple;
	bh=YzCSy4pqhp7BRo4Y7kuS9l0vVfqquZL9PXH4Wh+rAi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czoYzBQf1lFyPUM5JO+pCdJ4Dy+HsTgo3ihvkHKjkeLC459D/SE5yYsyTULQhF1Un2+5l5/jRRP4PdBq0Lf5OVz7gn2y64Gl7BFbPrGEpnADyn4jIyUGGMvMotGIucZoyqCN79n5pnt0nTbnkZvqcYoRF3lDRK+l03cokf4y0ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYB004eR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB2CC2BCB0;
	Mon, 11 May 2026 08:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778489849;
	bh=YzCSy4pqhp7BRo4Y7kuS9l0vVfqquZL9PXH4Wh+rAi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZYB004eRL8jPJL2V7SeMKmAJ06gN9fKbnT94AF5AJYzFHzRjMDyuZ0cY5sE8Ce6vT
	 Q8S3wfNrwYCTR8mG6FUbM9YKex5fvO/65AVdCB9jZ0aaInmgTyd/ZB8cnVd3uhJokL
	 v++HrrMjJsVeRI926YcHh7SZh9vL9qtk4Y+w1kClX4HHh69KGWSrunx3AccFVM/zFD
	 9iAJhQWuwuatbdWvj/rFre4q/WPbQK57HX2dROhpLoG/QdYK/JFVsJDX43DoZli2G5
	 K9pdz9HDBBD+DBKDYFwPOtHOtV5Y1imRhEpzKpN+mgm2Qd9DiXBLvQzVCodgmXA/W4
	 KGg9QedaOiAEg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Carlier <devnexen@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] tracepoint: balance regfunc() on func_add() failure in tracepoint_add_func()
Date: Mon, 11 May 2026 04:57:26 -0400
Message-ID: <20260511085726.1417414-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050737-recoil-baritone-4e0e@gregkh>
References: <2026050737-recoil-baritone-4e0e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DB53F50AAC8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,efficios.com,goodmis.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-245162-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,goodmis.org:email,msgid.link:url,efficios.com:email]
X-Rspamd-Action: no action

From: David Carlier <devnexen@gmail.com>

[ Upstream commit fad217e16fded7f3c09f8637b0f6a224d58b5f2e ]

When a tracepoint goes through the 0 -> 1 transition, tracepoint_add_func()
invokes the subsystem's ext->regfunc() before attempting to install the
new probe via func_add(). If func_add() then fails (for example, when
allocate_probes() cannot allocate a new probe array under memory pressure
and returns -ENOMEM), the function returns the error without calling the
matching ext->unregfunc(), leaving the side effects of regfunc() behind
with no installed probe to justify them.

For syscall tracepoints this is particularly unpleasant: syscall_regfunc()
bumps sys_tracepoint_refcount and sets SYSCALL_TRACEPOINT on every task.
After a leaked failure, the refcount is stuck at a non-zero value with no
consumer, and every task continues paying the syscall trace entry/exit
overhead until reboot. Other subsystems providing regfunc()/unregfunc()
pairs exhibit similarly scoped persistent state.

Mirror the existing 1 -> 0 cleanup and call ext->unregfunc() in the
func_add() error path, gated on the same condition used there so the
unwind is symmetric with the registration.

Fixes: 8cf868affdc4 ("tracing: Have the reg function allow to fail")
Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20260413190601.21993-1-devnexen@gmail.com
Signed-off-by: David Carlier <devnexen@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
[ changed `tp->ext->unregfunc` to `tp->unregfunc` to match older struct layout ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/tracepoint.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 64ea283f2f86d..38e83507e6fd1 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -337,6 +337,8 @@ static int tracepoint_add_func(struct tracepoint *tp,
 			lockdep_is_held(&tracepoints_mutex));
 	old = func_add(&tp_funcs, func, prio);
 	if (IS_ERR(old)) {
+		if (tp->unregfunc && !static_key_enabled(&tp->key))
+			tp->unregfunc();
 		WARN_ON_ONCE(warn && PTR_ERR(old) != -ENOMEM);
 		return PTR_ERR(old);
 	}
-- 
2.53.0



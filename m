Return-Path: <stable+bounces-246061-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNp+DN1rA2rF5gEAu9opvQ
	(envelope-from <stable+bounces-246061-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:05:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 50956526B41
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 95A9B30A9CB5
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B35E3C09F4;
	Tue, 12 May 2026 17:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0CWGarvY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38003C09EC;
	Tue, 12 May 2026 17:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608257; cv=none; b=e0aec0gVgLENSUbNijW8fmtojZHxwEUDVroubRPjQm42k1pDI3LXUb0hkNC/nAUI13/5iXxGEq31k61Llpvg9YyvtvU0pP1jymk7BJsEANwZE29t7d3FJMaqC7J7oQFtJNvgcADW3DdispTZidXqlmmRYp3OZLALGS3f1S+kLrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608257; c=relaxed/simple;
	bh=Nbsydq6ftNO7wg4wHItPeFtY95gwj6/K5YY+lLGHvBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GjwrM0JnpKMa1d9YNzuTfuSTk9fCpu42TBz3VBTBj6EHBsBG7F0j4ePk/zqYbreIcErQvTsJ7DgBKrxEzAnfJAu8Mni8r9/fO/im93X7pkh7HCVsxQ9gfEkjdAff6BKxv2JpiebuO4WRWPYrbCgw0EFoYUQIPbUY2y0RNpWEOtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0CWGarvY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D310C2BCB0;
	Tue, 12 May 2026 17:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608257;
	bh=Nbsydq6ftNO7wg4wHItPeFtY95gwj6/K5YY+lLGHvBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0CWGarvY1h+RL9RYl/BidBLoYyNzHBlA3pGVoPYBWlUIF3RG4d+Zsph4fId10JYql
	 CNerZxLb7gA8qEakYQySv8kMi6fhTv6EJQRHTEPosOZkmh4QUeKM2A7LVVQzME6I7F
	 JkE0Tm/AEQZg/F57pAKWeTx2qdmSyqJGeWJ2dPEU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	David Carlier <devnexen@gmail.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.18 010/270] tracepoint: balance regfunc() on func_add() failure in tracepoint_add_func()
Date: Tue, 12 May 2026 19:36:51 +0200
Message-ID: <20260512173938.671648529@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173938.452574370@linuxfoundation.org>
References: <20260512173938.452574370@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 50956526B41
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,efficios.com,gmail.com,goodmis.org];
	TAGGED_FROM(0.00)[bounces-246061-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goodmis.org:email,msgid.link:url,efficios.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Carlier <devnexen@gmail.com>

commit fad217e16fded7f3c09f8637b0f6a224d58b5f2e upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/tracepoint.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -291,6 +291,8 @@ static int tracepoint_add_func(struct tr
 			lockdep_is_held(&tracepoints_mutex));
 	old = func_add(&tp_funcs, func, prio);
 	if (IS_ERR(old)) {
+		if (tp->ext && tp->ext->unregfunc && !static_key_enabled(&tp->key))
+			tp->ext->unregfunc();
 		WARN_ON_ONCE(warn && PTR_ERR(old) != -ENOMEM);
 		return PTR_ERR(old);
 	}




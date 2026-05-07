Return-Path: <stable+bounces-244550-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INq4FURp/Gn0PgAAu9opvQ
	(envelope-from <stable+bounces-244550-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 12:28:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AD74E6C86
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 12:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79F153014BCC
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 10:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EA23E6DDB;
	Thu,  7 May 2026 10:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vWbfYWY0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229DF3E6DE6
	for <stable@vger.kernel.org>; Thu,  7 May 2026 10:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778149670; cv=none; b=t3pfFxExZlF01oddXvycXQbbkeqUoBT1xg+Q7y/BYgfwfdn0ayrsog3i9L4KQrPY1R70YbByj6GgT27I0Mt7CzprpElwTmmvV9exp39rU8+AlNciXK+Rn/v2A0cRAffhGlI21RknRE3OgytV7Kzlxda0ETiPjnLzZYsp7AYaBbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778149670; c=relaxed/simple;
	bh=kxG6rzQFdqO6v0rocDqyHWJ04uSzuv334X57HSGsApQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YBftfp+ejtoNoitrv1eIn+fr9au5QpQ9utbhMX++X7z3/FtqVRjB5jPTdz9cnMPD2yr2M9UT6gP+tNTrksYAUf9U6dwe2YyLMEIk7QMOIk6zMy1Qdqmw0SrS1zw9McQWlPTW4CJKUkzPuCI23tRG3h2a4MIPz+Uqp0qhks9WRb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vWbfYWY0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA18DC2BCB2;
	Thu,  7 May 2026 10:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778149670;
	bh=kxG6rzQFdqO6v0rocDqyHWJ04uSzuv334X57HSGsApQ=;
	h=Subject:To:Cc:From:Date:From;
	b=vWbfYWY0PPtf8p8kk0vi7vZ9Lcq6vwFSSjN0wFsK3VxBMOe3tbcXBUC8WwWef6xbT
	 HME1nkksGtPDG7YlocijbYoncd5UetfW3QncQs1K8SzejPhSO+7UG5iCx5bjWqeuCX
	 xXjl7/cJZvSbmdtAjOVn0QH+DCGQwqskkqlQhT1g=
Subject: FAILED: patch "[PATCH] tracepoint: balance regfunc() on func_add() failure in" failed to apply to 5.15-stable tree
To: devnexen@gmail.com,mathieu.desnoyers@efficios.com,mhiramat@kernel.org,rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 07 May 2026 12:27:37 +0200
Message-ID: <2026050737-recoil-baritone-4e0e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F3AD74E6C86
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244550-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,efficios.com,kernel.org,goodmis.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,efficios.com:email,gregkh:email]
X-Rspamd-Action: no action


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x fad217e16fded7f3c09f8637b0f6a224d58b5f2e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050737-recoil-baritone-4e0e@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fad217e16fded7f3c09f8637b0f6a224d58b5f2e Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Mon, 13 Apr 2026 20:06:01 +0100
Subject: [PATCH] tracepoint: balance regfunc() on func_add() failure in
 tracepoint_add_func()

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

diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 91905aa19294..dffef52a807b 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -300,6 +300,8 @@ static int tracepoint_add_func(struct tracepoint *tp,
 			lockdep_is_held(&tracepoints_mutex));
 	old = func_add(&tp_funcs, func, prio);
 	if (IS_ERR(old)) {
+		if (tp->ext && tp->ext->unregfunc && !static_key_enabled(&tp->key))
+			tp->ext->unregfunc();
 		WARN_ON_ONCE(warn && PTR_ERR(old) != -ENOMEM);
 		return PTR_ERR(old);
 	}



Return-Path: <stable+bounces-267808-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c0dcATKaOWoVvgcAu9opvQ
	(envelope-from <stable+bounces-267808-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 22:25:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DD36B2401
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 22:25:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=grrlz.net header.s=stigmate header.b=uoa7IfAY;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267808-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-267808-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=grrlz.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93D4D30433D0
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 20:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19A234E745;
	Mon, 22 Jun 2026 20:25:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05B934D4EA;
	Mon, 22 Jun 2026 20:25:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782159916; cv=none; b=m/hWhK77g5g533sBTsnMCdSzbMvjR/TrJkgy7YWOBuSH4M0tCEGz5er+gFygqH+kwAGkf7H8VxEvz7ydYKSSLMomEi7zRd9RNnauKfTCKC4cmkKW/76pNUIdghzPtAgNRpw2N75murEB6Wphk3mO3+H5ADY3aQG6c179unYAi1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782159916; c=relaxed/simple;
	bh=9zDHXLa66Xn/XKdO3WB8LnylbOQH868qI2JmHCyWXFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HYIFQRmiK5DFrW45Zl+5qChLVcvvL4onBRf1gl8w2P2YgWJHQnxpKu1h3MJABToyQmnAFFE0Anb6Cvzu1GDde0KSfor8fxnaaBxhPewb14ZdG9nvS8hxKBq92rmUVvZHr/XMV1EBki9TysYjIeMvpz+efutOhmaGpdSIGWcLiAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=uoa7IfAY; arc=none smtp.client-ip=93.190.126.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782159912;
	bh=k0v4xR04FoHT4BvbTEC8K2nsjXc2WGmzmSQQ7cw26QY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uoa7IfAYHPCRYd/QHMqJi6EO/eyDq4gVh9GOBmyldZmtPTOZKgoJSgXmvo/KERQje
	 Rs0EVrqV+mLMx8iPK4/7dk3giJxVbqTTwAoLOS++ZtZYRgymogQP59VOV+crrBdvBK
	 RyumuHSAm7g/GDTzKZgKxeN7yKSEcXoc/X8vFSbg=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4gkfp04TRxz10wb;
	Mon, 22 Jun 2026 20:25:12 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4gkfnz5HDxz10wK;
	Mon, 22 Jun 2026 20:25:11 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Marco Elver <elver@google.com>,
	Aleksandr Nogikh <nogikh@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Adrian Huang <adrianhuang0701@gmail.com>,
	Kexin Sun <kexinsun@smail.nju.edu.cn>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Bradley Morgan <include@grrlz.net>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] signal: avoid shared siginfo namespace rewrites
Date: Mon, 22 Jun 2026 20:25:08 +0000
Message-ID: <86a8857d58d43ee26a8b365b837fd24830343494.1782159692.git.include@grrlz.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260622164029.11474-1-include@grrlz.net>
References: <20260622164029.11474-1-include@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[grrlz.net,reject];
	R_DKIM_ALLOW(-0.20)[grrlz.net:s=stigmate];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[goodmis.org,kernel.org,efficios.com,linux-foundation.org,infradead.org,google.com,gmail.com,smail.nju.edu.cn,vger.kernel.org,grrlz.net];
	TAGGED_FROM(0.00)[bounces-267808-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[include@grrlz.net,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:oleg@redhat.com,m:brauner@kernel.org,m:rostedt@goodmis.org,m:mhiramat@kernel.org,m:mathieu.desnoyers@efficios.com,m:akpm@linux-foundation.org,m:peterz@infradead.org,m:elver@google.com,m:nogikh@google.com,m:tglx@kernel.org,m:adrianhuang0701@gmail.com,m:kexinsun@smail.nju.edu.cn,m:linux-kernel@vger.kernel.org,m:linux-trace-kernel@vger.kernel.org,m:include@grrlz.net,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[include@grrlz.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[grrlz.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,grrlz.net:dkim,grrlz.net:email,grrlz.net:mid,grrlz.net:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 63DD36B2401

send_signal_locked() rewrites sender ids for the target namespace.
Group sends reuse the same siginfo, so one recipient can affect the
next.

Copy the siginfo before changing it.

Fixes: 7a0cf094944e ("signal: Correct namespace fixups of si_pid and si_uid")
Cc: stable@vger.kernel.org
Signed-off-by: Bradley Morgan <include@grrlz.net>
---
Changes since v1:
- No code changes in this patch.
- Add patch 2 for Oleg's const suggestion.
- Link to v1:
  https://lore.kernel.org/all/0873AC4A-3CB2-4F7B-BFE6-75D855AD22DC@grrlz.net/T/#m89955d13f10807c316d34cc76680d690a2d95b31

 kernel/signal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/signal.c b/kernel/signal.c
index b9fc7be1a169..d72d9be3a992 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1181,6 +1181,7 @@ static inline bool has_si_pid_and_uid(struct kernel_siginfo *info)
 int send_signal_locked(int sig, struct kernel_siginfo *info,
 		       struct task_struct *t, enum pid_type type)
 {
+	struct kernel_siginfo rewritten;
 	/* Should SIGKILL or SIGSTOP be received by a pid namespace init? */
 	bool force = false;
 
@@ -1194,6 +1195,9 @@ int send_signal_locked(int sig, struct kernel_siginfo *info,
 		/* SIGKILL and SIGSTOP is special or has ids */
 		struct user_namespace *t_user_ns;
 
+		rewritten = *info;
+		info = &rewritten;
+
 		rcu_read_lock();
 		t_user_ns = task_cred_xxx(t, user_ns);
 		if (current_user_ns() != t_user_ns) {
-- 
2.53.0


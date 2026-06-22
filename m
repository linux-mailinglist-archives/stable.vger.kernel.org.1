Return-Path: <stable+bounces-267769-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WxF7HZFlOWpprgcAu9opvQ
	(envelope-from <stable+bounces-267769-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 18:40:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DCA6B1317
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 18:40:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=grrlz.net header.s=stigmate header.b=XI5JEL8E;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267769-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267769-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=grrlz.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9FB13017C29
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 16:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A343368B8;
	Mon, 22 Jun 2026 16:40:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0612BCF4C;
	Mon, 22 Jun 2026 16:40:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782146444; cv=none; b=FF8YHMGjowH1okuKao79yoYXyqGl0ZttKCxDBEIYOR+XLsi/0gMK0Gd0Dgs/2/99QMO3CmWm7fZY7Ao1gDm4HEBj8iXacEVj7XcpsuaqaEIF922Vxkq8L3DmtvQzFaQHUDwLoN48mYiP1tYbcQVX3gH8BVfKfBn4QuuwOvs3KL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782146444; c=relaxed/simple;
	bh=DCP3W9YLiAc31JR3edriHXrEEtfmniauBuuh65ADoVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uHSKG37GdQxJ0WNjQi8MPzQWOSl/BV/ZT4VDz9DgaugYgg9tfyZ6HuSRnihptWjtszTu2Oa9DR5VaM4305MhJLK38QquHRkbmoVdrbe0xGKp7k/vzq+R/NJHhAJs0OOzISHWiLeUVm2uXFfAfe5Mjw0XDkhoTShQMaKBTu8kRzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=XI5JEL8E; arc=none smtp.client-ip=93.190.126.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782146439;
	bh=SRSnCm+XvgkWvcngWiaeNCja7gM8kd6UVrJXrvVEfF8=;
	h=From:To:Cc:Subject:Date:From;
	b=XI5JEL8EdY7Mcp4yP1SnriH0hpzdlBsM6mw7Ws/LPhUY3wcHCwLIXUocYDHzERzcO
	 IH8nPDtq2iTxgmebn9aVWpomaKV84CQOoXP+9iz33PDLqel9sxpO2dOiC7euWtUNlA
	 Kr/XE/KltGiPB2UNX5IErucrcXUGAbTYjz5GlVvc=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4gkYpv6ryQz10vh;
	Mon, 22 Jun 2026 16:40:39 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4gkYpv1zwZz10wc;
	Mon, 22 Jun 2026 16:40:39 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	ebiederm@xmission.com
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Huang <adrianhuang0701@gmail.com>,
	Marco Elver <elver@google.com>,
	Kexin Sun <kexinsun@smail.nju.edu.cn>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bradley Morgan <include@grrlz.net>
Subject: [PATCH] signal: avoid shared siginfo namespace rewrites
Date: Mon, 22 Jun 2026 16:40:29 +0000
Message-ID: <20260622164029.11474-1-include@grrlz.net>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[linux-foundation.org,infradead.org,gmail.com,google.com,smail.nju.edu.cn,kernel.org,vger.kernel.org,grrlz.net];
	TAGGED_FROM(0.00)[bounces-267769-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[include@grrlz.net,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:oleg@redhat.com,m:ebiederm@xmission.com,m:akpm@linux-foundation.org,m:peterz@infradead.org,m:adrianhuang0701@gmail.com,m:elver@google.com,m:kexinsun@smail.nju.edu.cn,m:tglx@kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:include@grrlz.net,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,grrlz.net:dkim,grrlz.net:email,grrlz.net:mid,grrlz.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B4DCA6B1317

send_signal_locked() rewrites sender ids for the target namespace.
Group sends reuse the same siginfo, so one recipient can affect the
next.

Copy the siginfo before changing it.

Fixes: 7a0cf094944e ("signal: Correct namespace fixups of si_pid and si_uid")
Cc: stable@vger.kernel.org
Signed-off-by: Bradley Morgan <include@grrlz.net>
---
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



Return-Path: <stable+bounces-248148-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIdIA6VLB2pZwwIAu9opvQ
	(envelope-from <stable+bounces-248148-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:36:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E65553960
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 71F30311A2E9
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE6E3E0082;
	Fri, 15 May 2026 16:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RsJzxYfu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403F730569C;
	Fri, 15 May 2026 16:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860994; cv=none; b=Gh8auDVckJDcAxs4XzjIAk9kX1QcyEw71m0Fx3gTkXAsR7mGgMdEX+EL5iA7xU7EpBmA21zxaYPNf6eR/l6SnUy9cpjWsndk4VWCIjYX/mdzAppLgL7pfS620/8HbJRa2XpSS8oLgCyLm2Vr6yA7PPYjbKVvnAzlOXAq8tvrRQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860994; c=relaxed/simple;
	bh=/R31SjH9IpNnkkhRsu9Owd/nS1qV4vuQkTHhEFRXIZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHF4tfPsQHOxV/fTds8a0dkjenQMbef97a5lLwzDtBNtZc7pW7ULeAr1+871TBQpwaTyjv5AT9GPuUAoSaOoWFoniUwJrW3g36TQcvlw2yeEBH3Ts8WNf8fKVmnK59z+PadQSOKmkVU7xtyC9aBq6IXa4pYWdFui2amdkBbYmT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RsJzxYfu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAFFCC2BCB0;
	Fri, 15 May 2026 16:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778860994;
	bh=/R31SjH9IpNnkkhRsu9Owd/nS1qV4vuQkTHhEFRXIZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RsJzxYfuw24oaWSx2uacywpeS3J9y56QQZx4TEV7WqG8k9qDzET9JYPYZLdtfD3fN
	 6pSwxu9HkJtXd9TvH9So/rDBIP2my54HMHpBWzBUq7YIIboyz3kBUhXBJ98Fbubim8
	 71hu6qy2zF/6olTU7VVYopuxse/T221H/6sBH4Js=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Zhenzhong Wu <jt26wzz@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6 116/474] tcp: call sk_data_ready() after listener migration
Date: Fri, 15 May 2026 17:43:45 +0200
Message-ID: <20260515154717.547302331@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
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
X-Rspamd-Queue-Id: B1E65553960
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,google.com,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-248148-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhenzhong Wu <jt26wzz@gmail.com>

commit 3864c6ba1e041bc75342353a70fa2a2c6f909923 upstream.

When inet_csk_listen_stop() migrates an established child socket from
a closing listener to another socket in the same SO_REUSEPORT group,
the target listener gets a new accept-queue entry via
inet_csk_reqsk_queue_add(), but that path never notifies the target
listener's waiters. A nonblocking accept() still works because it
checks the queue directly, but poll()/epoll_wait() waiters and
blocking accept() callers can also remain asleep indefinitely.

Call READ_ONCE(nsk->sk_data_ready)(nsk) after a successful migration
in inet_csk_listen_stop().

However, after inet_csk_reqsk_queue_add() succeeds, the ref acquired
in reuseport_migrate_sock() is effectively transferred to
nreq->rsk_listener. Another CPU can then dequeue nreq via accept()
or listener shutdown, hit reqsk_put(), and drop that listener ref.
Since listeners are SOCK_RCU_FREE, wrap the post-queue_add()
dereferences of nsk in rcu_read_lock()/rcu_read_unlock(), which also
covers the existing sock_net(nsk) access in that path.

The reqsk_timer_handler() path does not need the same changes for two
reasons: half-open requests become readable only after the final ACK,
where tcp_child_process() already wakes the listener; and once nreq is
visible via inet_ehash_insert(), the success path no longer touches
nsk directly.

Fixes: 54b92e841937 ("tcp: Migrate TCP_ESTABLISHED/TCP_SYN_RECV sockets in accept queues.")
Cc: stable@vger.kernel.org
Suggested-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20260422024554.130346-2-jt26wzz@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/inet_connection_sock.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1429,16 +1429,19 @@ void inet_csk_listen_stop(struct sock *s
 			if (nreq) {
 				refcount_set(&nreq->rsk_refcnt, 1);
 
+				rcu_read_lock();
 				if (inet_csk_reqsk_queue_add(nsk, nreq, child)) {
 					__NET_INC_STATS(sock_net(nsk),
 							LINUX_MIB_TCPMIGRATEREQSUCCESS);
 					reqsk_migrate_reset(req);
+					READ_ONCE(nsk->sk_data_ready)(nsk);
 				} else {
 					__NET_INC_STATS(sock_net(nsk),
 							LINUX_MIB_TCPMIGRATEREQFAILURE);
 					reqsk_migrate_reset(nreq);
 					__reqsk_free(nreq);
 				}
+				rcu_read_unlock();
 
 				/* inet_csk_reqsk_queue_add() has already
 				 * called inet_child_forget() on failure case.




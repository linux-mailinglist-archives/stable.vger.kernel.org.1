Return-Path: <stable+bounces-229344-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eII/G/RvwWnmTAQAu9opvQ
	(envelope-from <stable+bounces-229344-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:53:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C48742F8FFE
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4AD231FF48B
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F382857F6;
	Mon, 23 Mar 2026 15:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gnt+cjwk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2F329CE9;
	Mon, 23 Mar 2026 15:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278822; cv=none; b=lYM3L4BPWKReLpg4GsJEtvsVbDVVvSgN6YRNEGg84Iz/hTxVQcjWX64PC58uDAf7VDBoI4oalzRbhSpVKswuIKzKzK25m7fEecEWefo+r349qasmo4//Gx3Xe2wDM6c+Qde2lsMKNfBd8Mub9OIulpsdFLV/EnRjckquCktpv6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278822; c=relaxed/simple;
	bh=/LPmMd/xMce0Rpp32OHKv8gjT+1JQjhHS6Fe0fnYXWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SdVAcjf7sKo3BWoVa9qivuIBE/1EU7Akom1koFBbzwi1ywOEDlSBUFs1+A2WyR3SLDvHydbdEaj6lvRwyrqOWvBUdEfy5u/AGc5NyNRgTih/+fo6ZDYs1sGGaskJfKcZHBnelqxOdLgKPhNJkUszE12YJbAjUwm/uhYEXCzp42M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gnt+cjwk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748E1C4CEF7;
	Mon, 23 Mar 2026 15:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278821;
	bh=/LPmMd/xMce0Rpp32OHKv8gjT+1JQjhHS6Fe0fnYXWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gnt+cjwkSmRngDYmb+KuD8KOZJ29NUZPlbpWRI+9Qlgfo8Rtoi0pwZ3HuPUZfB/jm
	 bM3i0zEYy5lpP0ZbMWoKsyFuEUan8emE85aqQMViKPvkNyRfH3MoaMlKu4fMryQCCe
	 VdT89NUHumsQtcE8h58hZ4OFqmj01aKsgdBADJ74=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	James Chapman <jchapman@katalix.com>,
	Guillaume Nault <gnault@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Qingfang Deng <dqfext@gmail.com>
Subject: [PATCH 6.6 431/567] l2tp: do not use sock_hold() in pppol2tp_session_get_sock()
Date: Mon, 23 Mar 2026 14:45:51 +0100
Message-ID: <20260323134544.592923970@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-229344-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,google.com,katalix.com,redhat.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C48742F8FFE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit 9b8c88f875c04d4cb9111bd5dd9291c7e9691bf5 upstream.

pppol2tp_session_get_sock() is using RCU, it must be ready
for sk_refcnt being zero.

Commit ee40fb2e1eb5 ("l2tp: protect sock pointer of
struct pppol2tp_session with RCU") was correct because it
had a call_rcu(..., pppol2tp_put_sk) which was later removed in blamed commit.

pppol2tp_recv() can use pppol2tp_session_get_sock() as well.

Fixes: c5cbaef992d6 ("l2tp: refactor ppp socket/session relationship")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: James Chapman <jchapman@katalix.com>
Reviewed-by: Guillaume Nault <gnault@redhat.com>
Link: https://patch.msgid.link/20250826134435.1683435-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Qingfang Deng <dqfext@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/l2tp/l2tp_ppp.c |   25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -130,22 +130,12 @@ static const struct ppp_channel_ops pppo
 
 static const struct proto_ops pppol2tp_ops;
 
-/* Retrieves the pppol2tp socket associated to a session.
- * A reference is held on the returned socket, so this function must be paired
- * with sock_put().
- */
+/* Retrieves the pppol2tp socket associated to a session. */
 static struct sock *pppol2tp_session_get_sock(struct l2tp_session *session)
 {
 	struct pppol2tp_session *ps = l2tp_session_priv(session);
-	struct sock *sk;
 
-	rcu_read_lock();
-	sk = rcu_dereference(ps->sk);
-	if (sk)
-		sock_hold(sk);
-	rcu_read_unlock();
-
-	return sk;
+	return rcu_dereference(ps->sk);
 }
 
 /* Helpers to obtain tunnel/session contexts from sockets.
@@ -211,14 +201,13 @@ end:
 
 static void pppol2tp_recv(struct l2tp_session *session, struct sk_buff *skb, int data_len)
 {
-	struct pppol2tp_session *ps = l2tp_session_priv(session);
-	struct sock *sk = NULL;
+	struct sock *sk;
 
 	/* If the socket is bound, send it in to PPP's input queue. Otherwise
 	 * queue it on the session socket.
 	 */
 	rcu_read_lock();
-	sk = rcu_dereference(ps->sk);
+	sk = pppol2tp_session_get_sock(session);
 	if (!sk)
 		goto no_sock;
 
@@ -528,13 +517,14 @@ static void pppol2tp_show(struct seq_fil
 	struct l2tp_session *session = arg;
 	struct sock *sk;
 
+	rcu_read_lock();
 	sk = pppol2tp_session_get_sock(session);
 	if (sk) {
 		struct pppox_sock *po = pppox_sk(sk);
 
 		seq_printf(m, "   interface %s\n", ppp_dev_name(&po->chan));
-		sock_put(sk);
 	}
+	rcu_read_unlock();
 }
 
 static void pppol2tp_session_init(struct l2tp_session *session)
@@ -1540,6 +1530,7 @@ static void pppol2tp_seq_session_show(st
 		port = ntohs(inet->inet_sport);
 	}
 
+	rcu_read_lock();
 	sk = pppol2tp_session_get_sock(session);
 	if (sk) {
 		state = sk->sk_state;
@@ -1575,8 +1566,8 @@ static void pppol2tp_seq_session_show(st
 		struct pppox_sock *po = pppox_sk(sk);
 
 		seq_printf(m, "   interface %s\n", ppp_dev_name(&po->chan));
-		sock_put(sk);
 	}
+	rcu_read_unlock();
 }
 
 static int pppol2tp_seq_show(struct seq_file *m, void *v)




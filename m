Return-Path: <stable+bounces-265206-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RPJLOfCFMWpVlgUAu9opvQ
	(envelope-from <stable+bounces-265206-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:20:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7E8693038
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:20:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=JedYAvoF;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265206-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265206-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87A8F30378B0
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE1F3BFE5B;
	Tue, 16 Jun 2026 17:13:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C566D33A9EB;
	Tue, 16 Jun 2026 17:13:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781630010; cv=none; b=GYnlCuIA8IuBVmlx7LF+MvUxM1uNwPVuO+8ISfznSz80XRlZcOqn/6sT1ZczUspJKAoGhHkiFb3LvK3EiC5isYCZS8F6Jf4nV2OsNTUrgFQsn0wUYzgbyaLjBDlw923KwDnCXWPXP0Xleq4PUruXNDd4LzKEkr6RS4ObZrin9G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781630010; c=relaxed/simple;
	bh=eSAqxV/ZOT4nmZM8u/gCNiQhCiP18HJcwqAuE0YbR+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r2uxiqyhQRhIFB8Lftg76tgBkm88H6U/52VL8t1TB0Bh3WxR3glwc7fLQYzdstFS0HF86ZyeAnovjBjXRNJa5G/rjDsNZnGMsnnAvzxlNlJ0jXdfps4QY7GVDpatiPclTWg3p58GN5CXAz8bhRgFf7GpMJRz5qKUF7JMnjnQSLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JedYAvoF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B881F000E9;
	Tue, 16 Jun 2026 17:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781630009;
	bh=ytjgjCsqC6X48ivAzQn5eOebks5EYbPYJq4/1AM9q64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JedYAvoFlS+KD4bJUE0EUNJVNHVBMXHCs6/HSORmh8Sp/Q5Ma8EI98OmXYpxLJ8lI
	 def7EgjYgJDu0yhWTSAB/9KgTUCVKzBNU63D7JfIVYH0ZwWK/v1EqD5GMk8j+H4R8T
	 Uk+X/g1nDwJNguSDFr4/YdYnpBpgfLWvyqg2rytI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 394/452] af_unix: Cache state->msg in unix_stream_read_generic().
Date: Tue, 16 Jun 2026 20:30:21 +0530
Message-ID: <20260616145137.591747118@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265206-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:kuniyu@google.com,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A7E8693038

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@google.com>

[ Upstream commit 8b77338eb2af74bb93986e4a8cfd86724168fe39 ]

In unix_stream_read_generic(), state->msg is fetched multiple times.

Let's cache it in a local variable.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20250702223606.1054680-6-kuniyu@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: be309f8eae8b ("af_unix: Fix UAF read of tail->len in unix_stream_data_wait()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/unix/af_unix.c |   29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2714,20 +2714,21 @@ static int unix_stream_read_skb(struct s
 static int unix_stream_read_generic(struct unix_stream_read_state *state,
 				    bool freezable)
 {
-	struct scm_cookie scm;
+	int noblock = state->flags & MSG_DONTWAIT;
 	struct socket *sock = state->socket;
+	struct msghdr *msg = state->msg;
 	struct sock *sk = sock->sk;
-	struct unix_sock *u = unix_sk(sk);
-	int copied = 0;
+	size_t size = state->size;
 	int flags = state->flags;
-	int noblock = flags & MSG_DONTWAIT;
 	bool check_creds = false;
-	int target;
+	struct scm_cookie scm;
+	unsigned int last_len;
+	struct unix_sock *u;
+	int copied = 0;
 	int err = 0;
 	long timeo;
+	int target;
 	int skip;
-	size_t size = state->size;
-	unsigned int last_len;
 
 	if (unlikely(READ_ONCE(sk->sk_state) != TCP_ESTABLISHED)) {
 		err = -EINVAL;
@@ -2747,6 +2748,8 @@ static int unix_stream_read_generic(stru
 
 	memset(&scm, 0, sizeof(scm));
 
+	u = unix_sk(sk);
+
 	/* Lock the socket to prevent queue disordering
 	 * while sleeps in memcpy_tomsg
 	 */
@@ -2840,10 +2843,10 @@ unlock:
 		}
 
 		/* Copy address just once */
-		if (state->msg && state->msg->msg_name) {
-			DECLARE_SOCKADDR(struct sockaddr_un *, sunaddr,
-					 state->msg->msg_name);
-			unix_copy_addr(state->msg, skb->sk);
+		if (msg && msg->msg_name) {
+			DECLARE_SOCKADDR(struct sockaddr_un *, sunaddr, msg->msg_name);
+
+			unix_copy_addr(msg, skb->sk);
 			sunaddr = NULL;
 		}
 
@@ -2916,8 +2919,8 @@ unlock:
 	} while (size);
 
 	mutex_unlock(&u->iolock);
-	if (state->msg)
-		scm_recv_unix(sock, state->msg, &scm, flags);
+	if (msg)
+		scm_recv_unix(sock, msg, &scm, flags);
 	else
 		scm_destroy(&scm);
 out:




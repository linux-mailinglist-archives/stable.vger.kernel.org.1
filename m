Return-Path: <stable+bounces-253439-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCkZM593DmrK+wUAu9opvQ
	(envelope-from <stable+bounces-253439-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 05:10:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7677159E4E4
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 05:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9DC4F3023E4B
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 03:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481DB335BA8;
	Thu, 21 May 2026 03:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZIr3aNn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E7A31ED81;
	Thu, 21 May 2026 03:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779333022; cv=none; b=jBZmxpzwU2aEQ95DKrwBNGDIsx2SOTi9AMyCGLaqiBRMgzmEPgBFgY99vnEg0JYmt/mPJvoY1oP0r/ee4/llMrVka9wBG0k4I1WkcQ3ODyOz+Z28Skt7P2CkWztBiKnLjlYOkXJHfe+5N5H3SvpTs4pWZIxx6XUTzCh0u2EO7T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779333022; c=relaxed/simple;
	bh=K0ILoGJSDN/w1UabpH2sQKTwwGJIAI/IqgzRfDwRYaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WzPFddKxoo2YOTtsuVlC3RAwmblCBowNIcmbzp3/uqw7yMl7GBecQ91wd5aybh3o62bF5Npg5Kg715KloMfVkaXXuGIbI7+lWFWRT2ZUnAwciAP25kF8roQcvPbTG9/rqDCQVfu/WpUYm+3HqboMwTHfOreY5UsxOfd6fOzyETw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZIr3aNn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 534741F00A3E;
	Thu, 21 May 2026 03:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779333020;
	bh=sHfglxnALvhhMQ7dRnIFBN97Faq61nbYYW4V3KO1NRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bZIr3aNnmXuJEqczqXAwBZ4FC+s+MWNZck0+IYymaF6g0ug6vSRJx5oWl/pnpZXam
	 Vp5zdSM79BrZZrKBC9Y9ksaUEvnO5IRymnUhurvUqYO7rswtfeVmzVkdS1me1ZhKA3
	 fCy6FZ5u8VPiuNG2aZiJ+5hS1k3dAVXqmJ+JzcEtHJWjiWCbei3/8NOnqXKsOyRtVl
	 jaVu/1kl/ReYYZVQQC7Pz1e6NrE0ij6lQMWJXEjVL5Lyrsg+Fq6jwk0zLQTR8AqkWk
	 rIlPowOf/xPjCaLQ2mhJOqjweMEQ9ZEMSUU4ZPZ8mkcf0MOPl70CwbfxjX2o4BmgZv
	 WqnFZS9TBXiIQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12.y 4/4] mptcp: pm: ADD_ADDR rtx: free sk if last
Date: Thu, 21 May 2026 05:08:50 +0200
Message-ID: <20260521030845.723267-10-matttbe@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521030845.723267-6-matttbe@kernel.org>
References: <20260521030845.723267-6-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4118; i=matttbe@kernel.org; h=from:subject; bh=K0ILoGJSDN/w1UabpH2sQKTwwGJIAI/IqgzRfDwRYaI=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLL4youmLIoL3/fpz+27nHGZv3e8C8j9862no//LE80f/ UrZ/x+e7yhlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZjIzzZGhn8XxWJsa3ib3Uxn 2EzaqCuceG+95ZHtzJWxE3LE1tikLGb4zVJhI3LfkdlxZ4jixkZuCY7vx7ffnr7Q+sq27x9tNpS 6MQMA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253439-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url]
X-Rspamd-Queue-Id: 7677159E4E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit b7b9a461569734d33d3259d58d2507adfac107ed upstream.

When an ADD_ADDR is retransmitted, the sk is held in sk_reset_timer(),
and released at the end.

If at that moment, it was the last reference being held, the sk would
not be freed. sock_put() should then be called instead of __sock_put().

But that's not enough: if it is the last reference, sock_put() will call
sk_free(), which will end up calling sk_stop_timer_sync() on the same
timer, and waiting indefinitely to finish. So it is needed to mark that
the timer is done at the end of the timer handler when it has not been
rescheduled, not to call sk_stop_timer_sync() on "itself".

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260505-net-mptcp-pm-fixes-7-1-rc3-v1-5-fca8091060a4@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Applied to net/mptcp/pm_netlink.c instead of upstream's pm_kernel.c.
  Also, there were conflicts, because commit 30549eebc4d8 ("mptcp: make
  ADD_ADDR retransmission timeout adaptive") is not in this version and
  changed the context. Also, other conflicts were due to newer patches
  being backported with resolved conflicts before this one. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index be531df02c37..4ff6721ad5c7 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -22,6 +22,7 @@ struct mptcp_pm_add_entry {
 	struct list_head	list;
 	struct mptcp_addr_info	addr;
 	u8			retrans_times;
+	bool			timer_done;
 	struct timer_list	add_timer;
 	struct mptcp_sock	*sock;
 	struct rcu_head		rcu;
@@ -294,22 +295,22 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	struct mptcp_pm_add_entry *entry = from_timer(entry, timer, add_timer);
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
-	unsigned int timeout;
+	unsigned int timeout = 0;
 
 	pr_debug("msk=%p\n", msk);
 
-	if (unlikely(inet_sk_state_load(sk) == TCP_CLOSE))
-		goto exit;
-
 	bh_lock_sock(sk);
+	if (unlikely(inet_sk_state_load(sk) == TCP_CLOSE))
+		goto out;
+
 	if (sock_owned_by_user(sk)) {
 		/* Try again later. */
-		sk_reset_timer(sk, timer, jiffies + HZ / 20);
+		timeout = HZ / 20;
 		goto out;
 	}
 
 	if (mptcp_pm_should_add_signal_addr(msk)) {
-		sk_reset_timer(sk, timer, jiffies + HZ);
+		timeout = HZ;
 		goto out;
 	}
 
@@ -326,9 +327,8 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 		entry->retrans_times++;
 	}
 
-	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
-		sk_reset_timer(sk, timer,
-			       jiffies + timeout);
+	if (entry->retrans_times >= ADD_ADDR_RETRANS_MAX)
+		timeout = 0;
 
 	spin_unlock_bh(&msk->pm.lock);
 
@@ -336,9 +336,13 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 		mptcp_pm_subflow_established(msk);
 
 out:
+	if (timeout)
+		sk_reset_timer(sk, timer, jiffies + timeout);
+	else
+		/* if sock_put calls sk_free: avoid waiting for this timer */
+		entry->timer_done = true;
 	bh_unlock_sock(sk);
-exit:
-	__sock_put(sk);
+	sock_put(sk);
 }
 
 struct mptcp_pm_add_entry *
@@ -402,6 +406,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
 reset_timer:
+	add_entry->timer_done = false;
 	timeout = mptcp_get_add_addr_timeout(net);
 	if (timeout)
 		sk_reset_timer(sk, &add_entry->add_timer, jiffies + timeout);
@@ -422,7 +427,8 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 	spin_unlock_bh(&msk->pm.lock);
 
 	list_for_each_entry_safe(entry, tmp, &free_list, list) {
-		sk_stop_timer_sync(sk, &entry->add_timer);
+		if (!entry->timer_done)
+			sk_stop_timer_sync(sk, &entry->add_timer);
 		kfree_rcu(entry, rcu);
 	}
 }
-- 
2.53.0



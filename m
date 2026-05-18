Return-Path: <stable+bounces-249314-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id RB2SJ2coC2q5EAUAu9opvQ
	(envelope-from <stable+bounces-249314-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 16:55:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B70556F51A
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 16:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA4C13091C9F
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 14:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B166F371046;
	Mon, 18 May 2026 14:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaPW+POJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7245133A9CB
	for <stable@vger.kernel.org>; Mon, 18 May 2026 14:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779115249; cv=none; b=Kaiy4c7Vnh9ZvGmKkBk72jLl/Kxj2TrbC+6pDPaZnImzMwhSt6756f9lRuZlOdM4zy/AsOd2Hvb8Q133JstlIxHbG+recDelY6q0ca1aDmN1d95w76nrdiH2VZ0FwgBqApQFSX7LwfGonj/BhH6GdJE1w5agFvTGgreRp6BgWMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779115249; c=relaxed/simple;
	bh=JxdrTQ+O65bS16ZxtzTfWKoiid6oD6IqZFyUkJmaAio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/fTYsCOybzit1I+HdiZVtyOiS/qtwKAt4wo8tsq33fNDpdTaVzyz4eUKfoDIDR75cjpQQI1GXxJpAfN2s5V8nCh26fKErkj7dAucUgeonzJ2uxgQ+HJz79/XjoDVBNIaUQTzFUsi1fw3+7FP6233cZvize4OzE54lKx2XEllUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OaPW+POJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73DEBC2BCB7;
	Mon, 18 May 2026 14:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779115249;
	bh=JxdrTQ+O65bS16ZxtzTfWKoiid6oD6IqZFyUkJmaAio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OaPW+POJFshyHhyW9c1nGkIrRjqwa/dH8izaSTXvS3bK1GI4IszsfA3pvmVU0gKLL
	 03eDuWkKZ7QgHHo/1LQCVbwkbTBszBzmRJdqOA/yG9BV1hovDCUJ8Y9iNwB+Uv0VZg
	 H+4lkiLEzflkY8u6zH+3l5Q1TGcv7nu5Q8sbW8d75UQRm6WUub/GvH9wyUTCfZ7QId
	 VYeLRKJS8keNbiLHPzhSv3Hla28FZN9UqD/cLqsOeu4oM7RqozFTVp6qnwCnciub93
	 wCWtQWFGJ7THdk0JltP5ArNgZtItl6+fPzBQnOZFkj7NA3VpNjvKjosvOIJOOopwaU
	 nm50DEg3z+E7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mptcp: pm: ADD_ADDR rtx: free sk if last
Date: Mon, 18 May 2026 10:40:45 -0400
Message-ID: <20260518144046.1361430-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051242-possible-handiness-ef31@gregkh>
References: <2026051242-possible-handiness-ef31@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249314-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1B70556F51A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

[ Upstream commit b7b9a461569734d33d3259d58d2507adfac107ed ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/pm_netlink.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 3ac09bfe6e4b2..c9442f21b9e90 100644
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
@@ -313,8 +314,10 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	}
 
 	timeout = mptcp_get_add_addr_timeout(sock_net(sk));
-	if (!timeout)
+	if (!timeout) {
+		entry->timer_done = true;
 		goto out;
+	}
 
 	spin_lock_bh(&msk->pm.lock);
 
@@ -328,6 +331,9 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
 		sk_reset_timer(sk, timer,
 			       jiffies + timeout);
+	else
+		/* if sock_put calls sk_free: avoid waiting for this timer */
+		entry->timer_done = true;
 
 	spin_unlock_bh(&msk->pm.lock);
 
@@ -335,7 +341,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 		mptcp_pm_subflow_established(msk);
 
 out:
-	__sock_put(sk);
+	sock_put(sk);
 }
 
 struct mptcp_pm_add_entry *
@@ -399,6 +405,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
 reset_timer:
+	add_entry->timer_done = false;
 	timeout = mptcp_get_add_addr_timeout(net);
 	if (timeout)
 		sk_reset_timer(sk, &add_entry->add_timer, jiffies + timeout);
@@ -419,7 +426,8 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
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



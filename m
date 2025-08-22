Return-Path: <stable+bounces-172417-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16432B31B11
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 16:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14DA93A53E5
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 14:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B773043D3;
	Fri, 22 Aug 2025 14:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5NAsfWL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C1B301476;
	Fri, 22 Aug 2025 14:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871900; cv=none; b=j+fM5yQswcBP3QUsc3pmRGPwj1nOb4Yq2IR78at9IMOl6cpeWrmWYWhvEhxJbHxUR/VO1zzi1tFgTYT9qHPYXpNr/rT4E6HYVIMAoDMltWbQJ17FFRoUNEcXKdoRgCMcf6eX7qcNN06CHSAg+OdTEGCRTCAXZtA1T7DKjBoAhfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871900; c=relaxed/simple;
	bh=DPH3pE/IpR/sUauAYMSTs2YvC1Rabf+jlHM13SPcVAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NS4r+ryYiV6iZDgnhq4l641nAOLIQgHwvbsmysVycR742Ji9w8o2JnuU8zg0SzG6Xr0vaIlA8mWRLKOwhdVCLfb0Srk/2Nkc0V80M09zFvMRim9IxGb3L2ObBcU1z6xKGOwdslP/+bOh4ZKZtoZSe3VLXt2Ahn1e7NZhsXdO94o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5NAsfWL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A6FDC4CEED;
	Fri, 22 Aug 2025 14:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755871900;
	bh=DPH3pE/IpR/sUauAYMSTs2YvC1Rabf+jlHM13SPcVAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c5NAsfWL5YZ0GNeNILyMe3fSmc4TQ42HtzHQHjkUBDSKaKp5GfCB8LYHLRbN95zwm
	 DHidrz2sAKN6qd+e4IEUUxd24D7JqN1FMaGfKSEUQ6xBKw3VguOzmmq3BR5PLNJpIj
	 9razyKwur01D7lcdSNR4PHU1zyZ7g7M4TKqxNE02AePRXRh0MUIEUZrxla37DRqDH3
	 7w221TrpdFJ6mQJGLySV4qwd2fO8kYWMq6tZ0ECQFxWdivbWPUq/3I8EVDwG86Jjp1
	 bFAP1e/tmFgNXAxhKECXeqN5HnatP9dovAzKxaTxL8/cxxxEFJIw6fb2rcv3uKMbDM
	 N3c28/6ZFsVvQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	sashal@kernel.org,
	Matthieu Baerts <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y 2/3] mptcp: disable add_addr retransmission when timeout is 0
Date: Fri, 22 Aug 2025 16:11:27 +0200
Message-ID: <20250822141124.49727-7-matttbe@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250822141124.49727-5-matttbe@kernel.org>
References: <20250822141124.49727-5-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3467; i=matttbe@kernel.org; h=from:subject; bh=xq0E52XpZNwSZtXFiRZqObJZaOBTpWGLcJv/JmPWX5g=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJWVE043uTyJnWiwkMVD6X8G9FbAjtiX9SJ+d89bL4jT XXXkvqnHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABNZmcPI8DV7x3bNhTypSWKH Jbn4L8xy218oJ7Do4dMIVrllC5TqljD8D3j9L2XljXzBWwy9TLWhMlw/uHQfbEk7tExB+oX6hFk 7OAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

commit f5ce0714623cffd00bf2a83e890d09c609b7f50a upstream.

When add_addr_timeout was set to 0, this caused the ADD_ADDR to be
retransmitted immediately, which looks like a buggy behaviour. Instead,
interpret 0 as "no retransmissions needed".

The documentation is updated to explicitly state that setting the timeout
to 0 disables retransmission.

Fixes: 93f323b9cccc ("mptcp: add a new sysctl add_addr_timeout")
Cc: stable@vger.kernel.org
Suggested-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250815-net-mptcp-misc-fixes-6-17-rc2-v1-5-521fe9957892@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Before commit e4c28e3d5c09 ("mptcp: pm: move generic PM helpers to
  pm.c"), mptcp_pm_alloc_anno_list() was in pm_netlink.c. The same patch
  can be applied there without conflicts. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/networking/mptcp-sysctl.rst |  2 ++
 net/mptcp/pm_netlink.c                    | 13 ++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 213510698014..722b4395e91b 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -20,6 +20,8 @@ add_addr_timeout - INTEGER (seconds)
 	resent to an MPTCP peer that has not acknowledged a previous
 	ADD_ADDR message.
 
+	Do not retransmit if set to 0.
+
 	The default value matches TCP_RTO_MAX. This is a per-namespace
 	sysctl.
 
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 59d6e701d854..cf9244a3644f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -304,6 +304,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	struct mptcp_pm_add_entry *entry = from_timer(entry, timer, add_timer);
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
+	unsigned int timeout;
 
 	pr_debug("msk=%p\n", msk);
 
@@ -321,6 +322,10 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 		goto out;
 	}
 
+	timeout = mptcp_get_add_addr_timeout(sock_net(sk));
+	if (!timeout)
+		goto out;
+
 	spin_lock_bh(&msk->pm.lock);
 
 	if (!mptcp_pm_should_add_signal_addr(msk)) {
@@ -332,7 +337,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
 		sk_reset_timer(sk, timer,
-			       jiffies + mptcp_get_add_addr_timeout(sock_net(sk)));
+			       jiffies + timeout);
 
 	spin_unlock_bh(&msk->pm.lock);
 
@@ -374,6 +379,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	struct mptcp_pm_add_entry *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
 	struct net *net = sock_net(sk);
+	unsigned int timeout;
 
 	lockdep_assert_held(&msk->pm.lock);
 
@@ -398,8 +404,9 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
 reset_timer:
-	sk_reset_timer(sk, &add_entry->add_timer,
-		       jiffies + mptcp_get_add_addr_timeout(net));
+	timeout = mptcp_get_add_addr_timeout(net);
+	if (timeout)
+		sk_reset_timer(sk, &add_entry->add_timer, jiffies + timeout);
 
 	return true;
 }
-- 
2.50.0



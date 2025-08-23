Return-Path: <stable+bounces-172617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C12B1B32988
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 17:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4DD01B65A0A
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 15:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDA82E2EF5;
	Sat, 23 Aug 2025 15:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKBG/RqM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA68155C97
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 15:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755962553; cv=none; b=tf4gAyOF8zG6yLrH/aEY8RK8dDk3V2MOYQS7EKrFsUraNF0Kus0UjzrXZPJrDKwHT3IIkhPOo2OBm5aD9ge6TQRO6UcYsGyEnPaOIsU6BvTVp3gxhdG9NDsmqhKATfqYZHnRkfzMLUSyR6PaABaK0o6OXErfijK9Zwiu95RYArU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755962553; c=relaxed/simple;
	bh=9Bdt71osyKjosO/Rgr8TcwsFGfeneKcSzaAee035x5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FlPjiImTlXGc1PgH2Zj14Wbl4tW38vArJx3vgI8Gt2jUHZ2czNB4umzaxbWAM+sz4lZyHHMHrdqVgjyxE5xWyaYAK1Y0TOhxCvvilxHAFa3FAmLmUcZ5ef8P8f2X1S9AcgiWSnFyfCJe4+UesBWCZGOHOpQ0u9iJIdZyLnmGxFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKBG/RqM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C3AC4CEF4;
	Sat, 23 Aug 2025 15:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755962551;
	bh=9Bdt71osyKjosO/Rgr8TcwsFGfeneKcSzaAee035x5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jKBG/RqMCPcRSQa1+zgsRCFDK2AgQgK69oS1VamzJrgAorJlXDinZ1z8HXY3x69vO
	 ow5lvHNhlQAId9PlLtNU1Ld0qY/QgEl2j8tQzcoweRaC9vIDe4aVGG3/vYfKcEuX1z
	 pL9f4xq3hoD8V1c4+Jn7ILMvWq3nB/WezqoS51BMKMwEwrcaGqD1xa0nSEVmoZd83T
	 WYYIbkKzCmBiQpZ+RcwVzrnSF5QYJM3p9GWcdSEMuS0qL423dH7XkmHa0mhw/chZoz
	 nPpW+H6nwHd/zwC3Z1j8NpQEAOJ+zSATzi+TcU9xWv2+XJEXHe2ICMXKT0Ap4hnFF/
	 3V1ACvACgwZvQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Matthieu Baerts <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mptcp: disable add_addr retransmission when timeout is 0
Date: Sat, 23 Aug 2025 11:22:28 -0400
Message-ID: <20250823152229.2272429-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082242-enrage-armoire-a4f8@gregkh>
References: <2025082242-enrage-armoire-a4f8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

[ Upstream commit f5ce0714623cffd00bf2a83e890d09c609b7f50a ]

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
[ pm.c => pm_netlink.c , drop mptcp_pm_alloc_anno_list hunk ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/networking/mptcp-sysctl.rst |  2 ++
 net/mptcp/pm_netlink.c                    | 13 ++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index b0d4da71e68e..e72ebaa14004 100644
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
index 45708e67cccc..cf6c3d9cb0b8 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -316,6 +316,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	struct mptcp_pm_add_entry *entry = from_timer(entry, timer, add_timer);
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
+	unsigned int timeout;
 
 	pr_debug("msk=%p\n", msk);
 
@@ -333,6 +334,10 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 		goto out;
 	}
 
+	timeout = mptcp_get_add_addr_timeout(sock_net(sk));
+	if (!timeout)
+		goto out;
+
 	spin_lock_bh(&msk->pm.lock);
 
 	if (!mptcp_pm_should_add_signal_addr(msk)) {
@@ -344,7 +349,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
 		sk_reset_timer(sk, timer,
-			       jiffies + mptcp_get_add_addr_timeout(sock_net(sk)));
+			       jiffies + timeout);
 
 	spin_unlock_bh(&msk->pm.lock);
 
@@ -386,6 +391,7 @@ static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	struct mptcp_pm_add_entry *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
 	struct net *net = sock_net(sk);
+	unsigned int timeout;
 
 	lockdep_assert_held(&msk->pm.lock);
 
@@ -403,8 +409,9 @@ static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	add_entry->retrans_times = 0;
 
 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
-	sk_reset_timer(sk, &add_entry->add_timer,
-		       jiffies + mptcp_get_add_addr_timeout(net));
+	timeout = mptcp_get_add_addr_timeout(net);
+	if (timeout)
+		sk_reset_timer(sk, &add_entry->add_timer, jiffies + timeout);
 
 	return true;
 }
-- 
2.50.1



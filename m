Return-Path: <stable+bounces-110728-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A9CA1CBE9
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BEAC164405
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB4822F162;
	Sun, 26 Jan 2025 15:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHirYGEm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4F522E411;
	Sun, 26 Jan 2025 15:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903930; cv=none; b=VpwvEJafescSha92ToP3Yg6lPtHqX5Zy1d2DVqU2NA3LitX1FqJUNChd9t81XbVOn9WYQe5o8I5IMo0r8VjIp1BhfsmPbhvAZJhmpGkvwE/UWsreOFMKOG1oDcAByp2HSNhVuTBJJ8VIb+3R/o6uXsAIRU9cCpcRBfal4L7JCNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903930; c=relaxed/simple;
	bh=RpCw+REwpZaCrS5g//d39RSKJKrwi1IL/jrAZiYKCTI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Kg33AGSZcyjLM+IyU53+19KPGo1sMXaYXM+5Adgls94CaSiL5+zAWpRNmhjyXAHSjTbI5Q/7qs3qoGM840qWWoWFOzJ6rchs0hCXBYLnIBjL+FJMsW+n6je1FV27bQ1cRqT4Dy85TaKwX6uP/TsNHVx0+LVsLLecNKMSYZykgdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHirYGEm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFAF2C4CED3;
	Sun, 26 Jan 2025 15:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903930;
	bh=RpCw+REwpZaCrS5g//d39RSKJKrwi1IL/jrAZiYKCTI=;
	h=From:To:Cc:Subject:Date:From;
	b=KHirYGEmzc02v34pcQmhLz+UhdYelrAlATmp7I7xeQnBmh5C/mKnbueo/aIJ7j0Yt
	 6BOHksz6c/UGjqp6Lh6a1v6TcMQ2RuQYK24yW++ftwEOn0JKts51iXkoQ8WM21DlI6
	 8jMHG8XFqZaEQpsHqsSE3WnnBjTdF1OhOKcjRiXQSxNhq/PElWvLH0nBe0FTmmUUK3
	 xhFLM+78/R1q2hzH8DdG23aJA+412EPbSkQ6O4kCWp7eZCPzVIxsoNschjMDpiGc9B
	 +qF5qn+AYW/V211Hu6B4+9VtchtrzrfDHcz5aU/RGdpTvxJz5Izl4YwZuaGaB7LLNs
	 lWc8nwCiB3Q1Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stas Sergeev <stsp2@yandex.ru>,
	Willem de Bruijn <willemb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	willemdebruijn.kernel@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 1/7] tun: fix group permission check
Date: Sun, 26 Jan 2025 10:05:21 -0500
Message-Id: <20250126150527.960265-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.289
Content-Transfer-Encoding: 8bit

From: Stas Sergeev <stsp2@yandex.ru>

[ Upstream commit 3ca459eaba1bf96a8c7878de84fa8872259a01e3 ]

Currently tun checks the group permission even if the user have matched.
Besides going against the usual permission semantic, this has a
very interesting implication: if the tun group is not among the
supplementary groups of the tun user, then effectively no one can
access the tun device. CAP_SYS_ADMIN still can, but its the same as
not setting the tun ownership.

This patch relaxes the group checking so that either the user match
or the group match is enough. This avoids the situation when no one
can access the device even though the ownership is properly set.

Also I simplified the logic by removing the redundant inversions:
tun_not_capable() --> !tun_capable()

Signed-off-by: Stas Sergeev <stsp2@yandex.ru>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Link: https://patch.msgid.link/20241205073614.294773-1-stsp2@yandex.ru
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/tun.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 0adce9bf7a1e5..87cc7d778c3cf 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -636,14 +636,18 @@ static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
 	return ret;
 }
 
-static inline bool tun_not_capable(struct tun_struct *tun)
+static inline bool tun_capable(struct tun_struct *tun)
 {
 	const struct cred *cred = current_cred();
 	struct net *net = dev_net(tun->dev);
 
-	return ((uid_valid(tun->owner) && !uid_eq(cred->euid, tun->owner)) ||
-		  (gid_valid(tun->group) && !in_egroup_p(tun->group))) &&
-		!ns_capable(net->user_ns, CAP_NET_ADMIN);
+	if (ns_capable(net->user_ns, CAP_NET_ADMIN))
+		return 1;
+	if (uid_valid(tun->owner) && uid_eq(cred->euid, tun->owner))
+		return 1;
+	if (gid_valid(tun->group) && in_egroup_p(tun->group))
+		return 1;
+	return 0;
 }
 
 static void tun_set_real_num_queues(struct tun_struct *tun)
@@ -2838,7 +2842,7 @@ static int tun_set_iff(struct net *net, struct file *file, struct ifreq *ifr)
 		    !!(tun->flags & IFF_MULTI_QUEUE))
 			return -EINVAL;
 
-		if (tun_not_capable(tun))
+		if (!tun_capable(tun))
 			return -EPERM;
 		err = security_tun_dev_open(tun->security);
 		if (err < 0)
-- 
2.39.5



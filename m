Return-Path: <stable+bounces-110605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE91A1CA59
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2204C1883D1A
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E101DB12E;
	Sun, 26 Jan 2025 15:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2Cybz0A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F79C1DB153;
	Sun, 26 Jan 2025 15:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903637; cv=none; b=BXB5Cd6CezgY/1e5ZQOgxv7bT/zHfLgvkRoX2xDgEABwOlD7PA5U3Suaagl0wZgrEb9loDSSkkZzHkVpEnlBNW3EfchwqJYpI/2YaT8VeiXeSC3frtm0zmCF5z4MIdeE+P91oAf/N2j3U0pjurSR9bg/igOG1pB2MQCBRO7x4h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903637; c=relaxed/simple;
	bh=fObqih/2Zq/gvX/+WXZOufv98x30xVpavTBfRJMUPgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ajbo7Nfq1fIyaIbdEjcb3NhgD5tM1s3ZYqgA6WcviYlD/IRkqZx92RZMeUSVWoszUJMMApeQmbu4g5JWEHOip4TWnq1Z4p7YWT+ZT3k3Q8T3o871MlH7CrOqpf0ExS7Tj0b41c+c3qh/iulbI0C2ZrBNYKEJ9G5O2Tnj7EQ+0jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s2Cybz0A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8146FC4CEE2;
	Sun, 26 Jan 2025 15:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903637;
	bh=fObqih/2Zq/gvX/+WXZOufv98x30xVpavTBfRJMUPgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s2Cybz0AnyKQLtMQUe4JdIkRftLUayCLMmL5p4wK2xH5qFUwxqzGjzBKANwFfbUAK
	 LMiFJ+zBOfuOUCmY5I+yqVmpHOy//cK/7pKbA7ti0J6boWNJ2Nv+tcoR8RBgHe9zhH
	 D6sfpf3TXG0O46ssDFBN/LwFWHPVgQdL6VpO42fYO2hFwRfMPG9H24fPFJCF9T4tCg
	 YG4tEGLBjzgpTuqSo4/TYlPkEDxzx+XwX0uQH7rQ1o1C9Al8LWzcccLAGGNRDdDuiO
	 LZYel46LYhu6zq6mLsPl1Q5GKn5DMAqRvIwz91zaeijTd9ks9tbySv6R4UG9gJR632
	 i77FI0NxVVKUw==
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
Subject: [PATCH AUTOSEL 6.13 04/35] tun: fix group permission check
Date: Sun, 26 Jan 2025 09:59:58 -0500
Message-Id: <20250126150029.953021-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150029.953021-1-sashal@kernel.org>
References: <20250126150029.953021-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
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
index e816aaba8e5f2..9186348c9e733 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -574,14 +574,18 @@ static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
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
@@ -2778,7 +2782,7 @@ static int tun_set_iff(struct net *net, struct file *file, struct ifreq *ifr)
 		    !!(tun->flags & IFF_MULTI_QUEUE))
 			return -EINVAL;
 
-		if (tun_not_capable(tun))
+		if (!tun_capable(tun))
 			return -EPERM;
 		err = security_tun_dev_open(tun->security);
 		if (err < 0)
-- 
2.39.5



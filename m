Return-Path: <stable+bounces-110702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C92A1CB9C
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5869167A10
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E1022759E;
	Sun, 26 Jan 2025 15:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpuQHHtA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4D61F4282;
	Sun, 26 Jan 2025 15:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903873; cv=none; b=FGs4aw8+rOR6k/HeLp6x1kkctgalxAzfb64G6fJ0KLLOcYN/BppAVMRTzZRhBT8ifUCEx6GxtPsjk29PzRETQsSDnvIgzRArYiPUeRO/9rkW4OU0XLXaVilmM5MeJyK4Xn6ZSZdx/7lPqjnkABiE3pLhligttKdPdrbESsJIP4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903873; c=relaxed/simple;
	bh=SzLlpNzhiiOmyMMrQMe0x7+sjyZ/dxd7aZPBuWGG9j8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OjfKyr2/Pk/eMaSd+1snz9Ksjv7RJI+915XreCTHRLLK0qgd+NDnmrNpWJYu9poi2Hi1RKdlB94EjY1NzAX302rPjA2p8zgR3MjJ4pRwuBZRiNp7iYDvXwNXWHE1ozxE4GLd8VJ4z36aBLG4nj9kFmHq7zxklPvg1r7f5TGY+U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpuQHHtA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901DCC4CED3;
	Sun, 26 Jan 2025 15:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903873;
	bh=SzLlpNzhiiOmyMMrQMe0x7+sjyZ/dxd7aZPBuWGG9j8=;
	h=From:To:Cc:Subject:Date:From;
	b=qpuQHHtAviBIoIule+YIy7EWTOyETDNY47MaxzAC7tk+3u/UFKbxatDkb8bNEU2mE
	 fJtIBwgbYYL2k9UQ6iFCXvYQZbRnihtIaltGAj1iqiKv8rEVRwZPq1iJzlE/9pDBd3
	 sV7YHCFBTmia5oS2FKQKs+YyH9hARyA1B+eBjgTKciKqSq5Rc4fL/GyXkqK4VnF2CW
	 bxIPqGpGkpAIdxu452VB87rgTLCkjlcX8L8G4HfZjEPLDllrag6AJcJBcluhEI9OA8
	 u+5PYTbt6Z31IiKkJgdPmtuQkdKpZxdhtQV68mvfvThLk+ghNTWoQf8muTFgH3otXT
	 5MJeyUdLgKYhw==
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
Subject: [PATCH AUTOSEL 5.15 01/14] tun: fix group permission check
Date: Sun, 26 Jan 2025 10:04:17 -0500
Message-Id: <20250126150430.958708-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.177
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
index 959ca6b9cd138..a85f743aa1573 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -575,14 +575,18 @@ static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
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
@@ -2718,7 +2722,7 @@ static int tun_set_iff(struct net *net, struct file *file, struct ifreq *ifr)
 		    !!(tun->flags & IFF_MULTI_QUEUE))
 			return -EINVAL;
 
-		if (tun_not_capable(tun))
+		if (!tun_capable(tun))
 			return -EPERM;
 		err = security_tun_dev_open(tun->security);
 		if (err < 0)
-- 
2.39.5



Return-Path: <stable+bounces-110716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3B2A1CC08
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 17:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EF6C3A7FDD
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983A422B58A;
	Sun, 26 Jan 2025 15:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQD+tTJg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B9522B581;
	Sun, 26 Jan 2025 15:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903903; cv=none; b=Bpb24S3W2Xk8L73MUYwL0DpzecSQWeOjMyLthYk/ugNWmnTQOZEy+zt12o+KIF0io0duBoPAnXpqS0W0K5zab4vHpk2n4y3VmDHcpvF8+vhnhEjcakZStfqWqbvpozFohTU2pLX8Mjion2ytob7f4YNZDOQx0EbTx3lhA1VBP18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903903; c=relaxed/simple;
	bh=5hvmjX7+LYDoZQcBLztzu1cg2qHrKEOl1OOVbnloAPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Uq9v65xyJshWTE7YeYeI74bLm92wTdkNMrRUgSzOv+ynbReUy9/8Sjh0HY/KmuFgx9sy5HK36EyYrYtb3P5IjdG9GrX3s49HTrK/OvZ4ZIwLRdngt0eiaN8S9vhwYE9pPMwv45oYtETzD55hswOBqs9Pnl00/CtWS8umgSrNEQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQD+tTJg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD771C4CED3;
	Sun, 26 Jan 2025 15:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903903;
	bh=5hvmjX7+LYDoZQcBLztzu1cg2qHrKEOl1OOVbnloAPQ=;
	h=From:To:Cc:Subject:Date:From;
	b=XQD+tTJgCNB6dRbOKmIgeRohm0rj8TGZTUlkDx7/fDrXS66DPcW7R5o347pGXw6J0
	 70NaPsuN1ZE+0uBhLq5AYu3/heRRxV6pLosl7yx3iuEstoiFePvVVj9DJE8Vl22tHM
	 /mQWDcRq7FBC6rbzDbFZQxE1NYCGXgrLCUiNruBvfbQJX66j/CEVqoV3IoU9Um+ffY
	 qg2NsCkMozNQEcGCOEyASoHWfcKUIxV/KbzkKm38yB8O5jcV3rDTuIeplFsJAWEIXB
	 uLfvyS7XRRcLmMVETu8NSeXkYuGUeYxwgpQsUvekRv29rYFD41VWIg205mOk9C4jCb
	 JmW/0tDGJe9Pg==
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
Subject: [PATCH AUTOSEL 5.10 01/12] tun: fix group permission check
Date: Sun, 26 Jan 2025 10:04:49 -0500
Message-Id: <20250126150500.959521-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.233
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
index c34c6f0d23efe..52ea9f81d388b 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -586,14 +586,18 @@ static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
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
@@ -2772,7 +2776,7 @@ static int tun_set_iff(struct net *net, struct file *file, struct ifreq *ifr)
 		    !!(tun->flags & IFF_MULTI_QUEUE))
 			return -EINVAL;
 
-		if (tun_not_capable(tun))
+		if (!tun_capable(tun))
 			return -EPERM;
 		err = security_tun_dev_open(tun->security);
 		if (err < 0)
-- 
2.39.5



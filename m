Return-Path: <stable+bounces-92832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBF39C6447
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 23:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D93EDB87ED3
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 19:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF2321A4C2;
	Tue, 12 Nov 2024 19:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRWzEqlv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF852219E3E;
	Tue, 12 Nov 2024 19:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731439133; cv=none; b=LBSXLQW0Rqt0rsbDHmlWzGMLYRN0iUNtXdnFyOH0GW+CdWuopD6wBlnUKLL2sLB0Y0E6jYtrqmEjDBWpwrgWYk0jkPzCn4lwFzXfpXM8/cufZf4sH5TFzNvOMZMHVsdNmoVHVQ3IVjRJc4VbKqAEauaK2JV2Khs+giMopI4olMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731439133; c=relaxed/simple;
	bh=FuoIfdQJv7ccjApa3N1JNOIaXeJa2+2IdI4Dq5YRvys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JtInWTgON9YOCcld2dnwn3meZ0n4kC2hthriG1mPU3r/uNSWtuKtq8WQ2Z8q+4U6pXbLm8fKSC4TpAjmqfYOAUCmK8LLmmIpaTyMdMyGYw4ULW5PoFnHTFrgYl4EhKKxfAScWFfNB0tGsp92l2DfGA0HxNelHeocgD3T72Sl/LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRWzEqlv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C114C4CED6;
	Tue, 12 Nov 2024 19:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731439133;
	bh=FuoIfdQJv7ccjApa3N1JNOIaXeJa2+2IdI4Dq5YRvys=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mRWzEqlvBUmydeu8Goq3XGOqaNoQTPm75uEC18Jetvvm65q7w+I4T1ds/YyzseUHi
	 nj1qH5fiw8pmJ8nn+qhUip1MB8DMpsDJh1pY2ZJP2gMz1pCEjjhEjZ6im8rNizVqgi
	 py5wikl2H3dogO+nKMapzkZ04uepO2CQh/mpvHLX3hbK8shQ5cMzMqv8Sn8nlul6JN
	 fZn1+wYaXdf+leTbYRcv2eug4WQ7PfqvYGUSJZYo95InzVUItT6FXq4HranhItFJhf
	 XlRfIYeP3SGhLe54RW71LV1dVYCVAfXSfapDaZ1Q51j5zkEAZhTzS3U7MNF2AscoAH
	 KG/Oi9rHHsBKg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 12 Nov 2024 20:18:33 +0100
Subject: [PATCH net 1/3] mptcp: update local address flags when setting it
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-net-mptcp-misc-6-12-pm-v1-1-b835580cefa8@kernel.org>
References: <20241112-net-mptcp-misc-6-12-pm-v1-0-b835580cefa8@kernel.org>
In-Reply-To: <20241112-net-mptcp-misc-6-12-pm-v1-0-b835580cefa8@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kishen Maloor <kishen.maloor@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2016; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=7iaDiZC+u2/a+kvq6DT5vKQUNtAdNSAkppcjtytm4zs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnM6oVOKxcsjilnaj6GBpYLjdp5CAxYxhOBZUdT
 ih/HgbjvniJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZzOqFQAKCRD2t4JPQmmg
 cx8XD/4o0fgUv37zQQhyT+E4OdgrXpapwrLHMg8YZA1EVeP9x/h00ZeXslZcv7ei+uJrHEbdEEa
 7wQLTYmCn/67bmiqf7PNr0CRwZU7yG69DrS0mQQ34fyuwJ/Qta1Qh6LninftWx4r8MnAFQhHn2K
 F4AOPERMHXgTKiwOhMOM0WN4+PNDNTQZOvGNcVugQJ2QgvUU8ujHagB5RqnAxPEvoDnommJYZc9
 wz5HKzsYLavWqSeSuUEJ60NMcZNzLnPgBCzNHjw22ShZQ8kJn9WTUSLoifldJJ54lO7/97pFs5o
 J9NdlXY/QeKJUYpP0PTBq93fxKELIEmdXdRBVlFHJ+dgLhxdgieSNsOXEDrIh8Oi3/VZqJqLpGC
 ajCbthSK2mqnMjyZ9mFVgu2aI3JMn+mG+uH0XW4qo/IfuVyouDHPyx6zT77s9ZVytCgUGNDhigz
 KioeILf4Mhi9SKTQ8ZF/AbrFCiGQWy82DUS2MhvXMaugoMdZ4+BYs0GHFobACQTiAEIkS34PiRy
 QpIA2kf4NEZWSJu8jghVhmM8h/nNfGVtsgNWzQqBrLN6n60D+kiNKReUihmcw4y+zjyL4iKLNcR
 0DI6xtyYamU9+StiMY2k1d4POLeLXPmTaW+jIY90W7LRCQFxiAC+8uKlTnXSd6Vk/21cJCWszxK
 H7Kga7PB0mYeiYQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

Just like in-kernel pm, when userspace pm does set_flags, it needs to send
out MP_PRIO signal, and also modify the flags of the corresponding address
entry in the local address list. This patch implements the missing logic.

Traverse all address entries on userspace_pm_local_addr_list to find the
local address entry, if bkup is true, set the flags of this entry with
FLAG_BACKUP, otherwise, clear FLAG_BACKUP.

Fixes: 892f396c8e68 ("mptcp: netlink: issue MP_PRIO signals from userspace PMs")
Cc: stable@vger.kernel.org
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 56dfea9862b7b24dd0eaa8bbedcf22a7f6829ccf..3f888bfe1462ee3c75a3fb6eefe29cb712471410 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -560,6 +560,7 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct net *net = sock_net(skb->sk);
+	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
 	int ret = -EINVAL;
 	struct sock *sk;
@@ -601,6 +602,17 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 	if (loc.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
 		bkup = 1;
 
+	spin_lock_bh(&msk->pm.lock);
+	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (mptcp_addresses_equal(&entry->addr, &loc.addr, false)) {
+			if (bkup)
+				entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
+			else
+				entry->flags &= ~MPTCP_PM_ADDR_FLAG_BACKUP;
+		}
+	}
+	spin_unlock_bh(&msk->pm.lock);
+
 	lock_sock(sk);
 	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc.addr, &rem.addr, bkup);
 	release_sock(sk);

-- 
2.45.2



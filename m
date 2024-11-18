Return-Path: <stable+bounces-93822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9869D180B
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 19:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C77E5B23797
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 18:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107A41E0DF8;
	Mon, 18 Nov 2024 18:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuJ4Y+jB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C161F2E3EB;
	Mon, 18 Nov 2024 18:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731954463; cv=none; b=Zj7LycZFDwKZt+xUkHltr+5fffoFtszIFVOO78/HuzU/i+QwwE8vnyE76gi9C1JDUR/Q+y2KwWo7bnEq5kA+QEvLH0H9M7acVY/rPYExgW0G8BlAdDkDCnd3Vt4AGbS6NHdS5WewT62n6FQlGBkp/Sk7LWpvrV01P92QozH0tEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731954463; c=relaxed/simple;
	bh=Y0tEZ47rOa0qaWge6wWHVvhqklS3+feOuoSFjH3YHic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fo0fWLIanbT7S7yuVbFlvbkpYK7LVLMgl28f3TQqM5JT/mzqvJCZqg8n37eWSS2DP9mdBdva3FtgZnZ8Q/fM4kBuYyt4BGnsn4IL49NfuR1S/cikc1GV0p9xWV5+sY14jR7sTRsIEzVcvNcRwp0MYGD9YUhYjVcxgyv0TH8Y3yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EuJ4Y+jB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE44C4CED1;
	Mon, 18 Nov 2024 18:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731954463;
	bh=Y0tEZ47rOa0qaWge6wWHVvhqklS3+feOuoSFjH3YHic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EuJ4Y+jBX+eJrxCXP2o/cVG1W9UJWswyZ1GrTM1zWfOeweMWrA8eGM8PiyRq6HWil
	 QJdG9xu22C8H+ARDcn7ZumcEDske+llGOMB5B3uXndUcD/rZq2Vk55yicyALt7NXGI
	 5jQ/GScmbL21iPwUlRCvr/5L6HwNCoocMfxNN/AslG8dOBBT/EqgrvAvtvh05fgFUv
	 WIpbmcPZHHpgDIOcGOfpyqKm1Q9z9XPQwIoxhnSeHANA3nwXxiEIR9PUFceiDDCXtK
	 hMLkN4sWchmTzpwaVNKFtX7I3yeyOjPbjKrvWvtov2MhGU221gdw0y9enHEreHEXao
	 inhZ00vN+SbAg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	sashal@kernel.org,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y 1/6] mptcp: define more local variables sk
Date: Mon, 18 Nov 2024 19:27:19 +0100
Message-ID: <20241118182718.3011097-9-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241118182718.3011097-8-matttbe@kernel.org>
References: <20241118182718.3011097-8-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4507; i=matttbe@kernel.org; h=from:subject; bh=fvnyb/aCBAAzm1QXpzp3jY4kD/YgYdySxnjmjGPeXGg=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnO4cGxnKzu3GU0FqVj3vA9unaXRURfYxyXZOU9 YyyEEGhQKOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZzuHBgAKCRD2t4JPQmmg c+bKD/445mHZ8186p59b8vfOp7k/qmg5HXD02W5firl9zCxDtjyubjsoYpxLpS7CDdQmHGLO7m2 l5WGC3RGBWy34JL5C1wFz7cvMAUXcF7ThTG6QMa8JiefMTG7BTBn9KyJiICuhq2k1Z3ruzM1ma7 QQ8iV240kwb9TY5lR1Ykw6p7mu5sypzo1HW0PXEmkDBTYpzMNqrRiwQdJa0tRUO51Xn2SrGZoGi 3zp5vhnq5i332fCQeaLkqNL8FZMxSPjn3/FNemucHuS7crY1c73UgzztJ1/blZ5+p7E0b4hFrGA WG3zPegs7HEXANsE4Shih0BRkXb5QROrD1aDP9aV1uqhXU7YYFfnVw8kZyJPUvUK+jgUfkaYZgl lQH79EhXsw+esscZcSZRPu2jMjTWyghr0XuyRRLMl1bEcYNae9v/45r0WxwvqCGRXaem37FPFod eFeQgsrZHKDSohCPb/bCTH7IrPg6mKqpPG58J/yztWs+tPFGLZXfqIjRnUDTmZg2VChmKp6IJVx wwAfDoXOdM6lOiqyfBVoCEJgTdxgF9T3mtcLTiUPIxqbKCpAVUur11KjesI34oC+oZ5gMjdCa1Z Mo7v/xJGnoPQYeLCe0fMXOrL1wcRD6VagqgEHre/b5Ipe0frEtknR6WNxQ079fkKbdo7SNA1P1T YEEH/6Zdi6slJLg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

commit 14cb0e0bf39bd10429ba14e9e2f905f1144226fc upstream.

'(struct sock *)msk' is used several times in mptcp_nl_cmd_announce(),
mptcp_nl_cmd_remove() or mptcp_userspace_pm_set_flags() in pm_userspace.c,
it's worth adding a local variable sk to point it.

Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
Link: https://lore.kernel.org/r/20231025-send-net-next-20231025-v1-8-db8f25f798eb@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 06afe09091ee ("mptcp: add userspace_pm_lookup_addr_by_id helper")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index e097b6a7b816..eded0f9c0b6f 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -183,6 +183,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 	struct mptcp_pm_addr_entry addr_val;
 	struct mptcp_sock *msk;
 	int err = -EINVAL;
+	struct sock *sk;
 	u32 token_val;
 
 	if (!addr || !token) {
@@ -198,6 +199,8 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 		return err;
 	}
 
+	sk = (struct sock *)msk;
+
 	if (!mptcp_pm_is_userspace(msk)) {
 		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
 		goto announce_err;
@@ -221,7 +224,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 		goto announce_err;
 	}
 
-	lock_sock((struct sock *)msk);
+	lock_sock(sk);
 	spin_lock_bh(&msk->pm.lock);
 
 	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
@@ -231,11 +234,11 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	spin_unlock_bh(&msk->pm.lock);
-	release_sock((struct sock *)msk);
+	release_sock(sk);
 
 	err = 0;
  announce_err:
-	sock_put((struct sock *)msk);
+	sock_put(sk);
 	return err;
 }
 
@@ -282,6 +285,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 	struct mptcp_sock *msk;
 	LIST_HEAD(free_list);
 	int err = -EINVAL;
+	struct sock *sk;
 	u32 token_val;
 	u8 id_val;
 
@@ -299,6 +303,8 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 		return err;
 	}
 
+	sk = (struct sock *)msk;
+
 	if (!mptcp_pm_is_userspace(msk)) {
 		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
 		goto remove_err;
@@ -309,7 +315,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 		goto remove_err;
 	}
 
-	lock_sock((struct sock *)msk);
+	lock_sock(sk);
 
 	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
 		if (entry->addr.id == id_val) {
@@ -320,7 +326,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 
 	if (!match) {
 		GENL_SET_ERR_MSG(info, "address with specified id not found");
-		release_sock((struct sock *)msk);
+		release_sock(sk);
 		goto remove_err;
 	}
 
@@ -328,15 +334,15 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 
 	mptcp_pm_remove_addrs(msk, &free_list);
 
-	release_sock((struct sock *)msk);
+	release_sock(sk);
 
 	list_for_each_entry_safe(match, entry, &free_list, list) {
-		sock_kfree_s((struct sock *)msk, match, sizeof(*match));
+		sock_kfree_s(sk, match, sizeof(*match));
 	}
 
 	err = 0;
  remove_err:
-	sock_put((struct sock *)msk);
+	sock_put(sk);
 	return err;
 }
 
@@ -558,6 +564,7 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
 {
 	struct mptcp_sock *msk;
 	int ret = -EINVAL;
+	struct sock *sk;
 	u32 token_val;
 
 	token_val = nla_get_u32(token);
@@ -566,6 +573,8 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
 	if (!msk)
 		return ret;
 
+	sk = (struct sock *)msk;
+
 	if (!mptcp_pm_is_userspace(msk))
 		goto set_flags_err;
 
@@ -573,11 +582,11 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
 	    rem->addr.family == AF_UNSPEC)
 		goto set_flags_err;
 
-	lock_sock((struct sock *)msk);
+	lock_sock(sk);
 	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc->addr, &rem->addr, bkup);
-	release_sock((struct sock *)msk);
+	release_sock(sk);
 
 set_flags_err:
-	sock_put((struct sock *)msk);
+	sock_put(sk);
 	return ret;
 }
-- 
2.45.2



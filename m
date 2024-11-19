Return-Path: <stable+bounces-93937-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C35E09D21A8
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 09:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BD071F22B09
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 08:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBCC1531DB;
	Tue, 19 Nov 2024 08:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sN/NqR2e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B9B19E838;
	Tue, 19 Nov 2024 08:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732005361; cv=none; b=BFFCPERUmUpEr+sSeG5279Y/mlvOBVsugr9QrH3TkVrbJhj3PhklXJ1Rc97aO0Etn88D6sP/AbSBNyz6Yuwfzxxkx0n9C+0QWRK9aIyC7S7+Jn2yRQ4EhtYFZwFT8Ylh58B9flGYs6i08+kNouNILkMUPLICfLSsFKBqJaauqRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732005361; c=relaxed/simple;
	bh=RAVK/hc3PBBjJKvUp742l4IpMrbyZ6g+SMVTNWnphmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MV0onoepU9oW7wTI4BHUCqx38XZdXSMwDtRzhE//CbdUzq9uUS4KC3qtlFh8PAXxydidOrujCjxL9VLT8h6P8gDTKlRmoMd3mYaa4TgFZx1xl4EqJMIC51vpIKf/gILk1k1q95q9NkvPjfpvK2vJxE8+gkSkgVU/snSW9WVEadI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sN/NqR2e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDBC5C4CECF;
	Tue, 19 Nov 2024 08:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732005360;
	bh=RAVK/hc3PBBjJKvUp742l4IpMrbyZ6g+SMVTNWnphmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sN/NqR2eZ1nBYp+Zfneb6MyZIbYK1GtrgKzeoOmqRgjv+3g8C6CkorKIjAA6zaQRg
	 jmawV+jCVJeGScHrEoGDmhVT60jYPwHixrP6cXBHgD/qeo1PZlDEePmqlks1Kn4/fa
	 UKbn8uXhIDRtf1Xlv5WLuv8psreHVDh5O89ikeQr7h29D2wepYdi/s1W6hkwUYh/sG
	 pzw9Qs6nYNcwH/KTg+37zqnXnvHmIuiyh5rsXfxk/8Nfpy54KuSSWl5EF1//Xx6KjR
	 qgdR/AUFekULyZf8XV6DX5dLRt0t8X/Yf74xZ7qegtV+6AEczEwHZou4ukZDZep1Jj
	 PSk5uiEY6RWNg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	sashal@kernel.org,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y 2/7] mptcp: define more local variables sk
Date: Tue, 19 Nov 2024 09:35:50 +0100
Message-ID: <20241119083547.3234013-11-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241119083547.3234013-9-matttbe@kernel.org>
References: <20241119083547.3234013-9-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4507; i=matttbe@kernel.org; h=from:subject; bh=03IMwEUCz9FS+2ebJybY6rBqT1z4qneYqsTP7bcV6r4=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnPE3kX9pqXsh8gYNKWLmDRU/bdAZlUPBT+BZN4 5B0LFST4QOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZzxN5AAKCRD2t4JPQmmg cwg6EADuJZAwLLneAsXqEJPcJbo3XAoCMSZmU3s6iwSGvpV2r8wfWg0CsC7XLpaHGKBateLI7Ae boW9ayl52rkzkTLUD0o2bhXrOUcUEqrwMC2O64u+sJ7P7sW3IjjAHWmE48Eq7xwW8yCXiEgGQrD 0XQ625vKsvWzBrOR1cOmsMO7wb4JNIGFcHmLr0KS3eFOcN63tgO7H5jLGI8nhDfmhfGItqB+ZOg jykH/fUTNYhzZp2wzEdrytEj/Guvnii683fRKegUOsoYZJhDKoL5kdvSHoR/Slx4T3Thu/RSFLN /hD8JdBlqEoxsgNMTEAJXLCaMlGSTclIzfCIPQ8+Iz+ahBTHWbMa0taKueTjeb2du9UZ39O+48G lq9XAxyhR1W0bzyc6xAa5Xn7YyU/5DbuwogfUDuCQhgMfmKX9JaUM9HszQohpyJS6cvRcFtyiXy g0sMmeEyTk7+VNK3tImgS9+b8wZSMvTzJreXSjloFSePOnJ9LMs8Frho3Uvgh6mLSPI/BA26zOS ymnnZsUx7NCK83//RxSZTJamUnnC1tKQgR/OxnWlwAwvuI4jZQM4RA3XsZ4bTTfOH+7WxG41QVi J8A3YvXO+jzf+YZ3GcQd9R70mnv6B/47ro5DVzh65yWHDcmkdnpsD2uJt30wHTJ/5kAkRuTPCVs jyuqrWzc/qlBJLA==
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
index 748e3876ec6d..530f414e57d6 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -185,6 +185,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 	struct mptcp_pm_addr_entry addr_val;
 	struct mptcp_sock *msk;
 	int err = -EINVAL;
+	struct sock *sk;
 	u32 token_val;
 
 	if (!addr || !token) {
@@ -200,6 +201,8 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 		return err;
 	}
 
+	sk = (struct sock *)msk;
+
 	if (!mptcp_pm_is_userspace(msk)) {
 		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
 		goto announce_err;
@@ -223,7 +226,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 		goto announce_err;
 	}
 
-	lock_sock((struct sock *)msk);
+	lock_sock(sk);
 	spin_lock_bh(&msk->pm.lock);
 
 	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
@@ -233,11 +236,11 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
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
 
@@ -284,6 +287,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 	struct mptcp_sock *msk;
 	LIST_HEAD(free_list);
 	int err = -EINVAL;
+	struct sock *sk;
 	u32 token_val;
 	u8 id_val;
 
@@ -301,6 +305,8 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 		return err;
 	}
 
+	sk = (struct sock *)msk;
+
 	if (!mptcp_pm_is_userspace(msk)) {
 		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
 		goto remove_err;
@@ -311,7 +317,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 		goto remove_err;
 	}
 
-	lock_sock((struct sock *)msk);
+	lock_sock(sk);
 
 	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
 		if (entry->addr.id == id_val) {
@@ -322,7 +328,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 
 	if (!match) {
 		GENL_SET_ERR_MSG(info, "address with specified id not found");
-		release_sock((struct sock *)msk);
+		release_sock(sk);
 		goto remove_err;
 	}
 
@@ -330,15 +336,15 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 
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
 
@@ -560,6 +566,7 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
 {
 	struct mptcp_sock *msk;
 	int ret = -EINVAL;
+	struct sock *sk;
 	u32 token_val;
 
 	token_val = nla_get_u32(token);
@@ -568,6 +575,8 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
 	if (!msk)
 		return ret;
 
+	sk = (struct sock *)msk;
+
 	if (!mptcp_pm_is_userspace(msk))
 		goto set_flags_err;
 
@@ -575,11 +584,11 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
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



Return-Path: <stable+bounces-66068-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A6594C18F
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 17:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2F5928AFBB
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 15:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4501C18F2DF;
	Thu,  8 Aug 2024 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBs3UHmd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022CDB674;
	Thu,  8 Aug 2024 15:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723131377; cv=none; b=Zb/daYWr0H8nX0MzTXT170tSeDGWsCdtSY62vVizCX1sYEmDmparoYJUVrQQ+TJtwvzOALEzniAC/ovsDR9pIu8soC1gSwbMZeDv1PKry8iTMLLgj6oTI3A6Fv4CUs/EXp1sUBIZ38RULDBzrE+7Eb4PioeDBAlUGkOsyfVyO7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723131377; c=relaxed/simple;
	bh=4qwT9461u1kIoqJ7Etxwqmdmh4w56nzvEHPzODSaHmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SQ0G77HBC0qY3qnj5i7XBFzxlMKTEdA8t9yP8yrAajZ8Z9bnXOQOjoZU2/QDidVpMXM3eNYFQqLyX7WJzF8FJkx8rNdCZFoZHuFuQQ88XWxUz9N1jSP1yPSWyZWVpJJhtD9XpjK7TUWfQXmeW2nQS2kl//7Z7MkDIvPKK5+Lcgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBs3UHmd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680F6C4AF0D;
	Thu,  8 Aug 2024 15:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723131376;
	bh=4qwT9461u1kIoqJ7Etxwqmdmh4w56nzvEHPzODSaHmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YBs3UHmdZoDVjhRM5nYNHem6+LB/nYX7/cyZWXvfCUFDEwGepyCoVlF+aRRfqCAqV
	 Hqa1uGfaj2nxRE4ggjfjzPHm/IqpiA0Iuf8qTKUNFEjSjDs+Asz0JEa9S003f+6uhq
	 FszftceTfqfUSKLtKsjXPvBdhoZ7R7rdg9BnTtl+8q7yErZAl6qM3YvDbdx21pj2lc
	 jpIz9HVIuVN2TS08Ob0RBLa1K3/aQasNjeCVUcAkEiw23NKjq+yan/4OBHEBvAt/V8
	 GvoTSr2BSSoK4U51bPNxKYJue+oINy2/x757ftXNWvzI0w4Uut8mm6p+3ZXJDUzTlV
	 MhnQVlq4n/anw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.1.y 2/2] mptcp: pm: fix backup support in signal endpoints
Date: Thu,  8 Aug 2024 17:35:48 +0200
Message-ID: <20240808153546.2315845-4-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240808153546.2315845-3-matttbe@kernel.org>
References: <2024080727-stricken-overact-90c5@gregkh>
 <20240808153546.2315845-3-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6215; i=matttbe@kernel.org; h=from:subject; bh=4qwT9461u1kIoqJ7Etxwqmdmh4w56nzvEHPzODSaHmg=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmtOXSLGUstz7Fv2pbjPNjrceppKGAhr0uHCtUV Isjy3xlbmKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrTl0gAKCRD2t4JPQmmg c/UzD/4vR3NlBGU3TmEPEJnO2XQHtu2Cpy/F1WWG5rIvibbQhSNSVfIU12EoZfsbapE5IfhqZAp 6rGvB4dEMZLNEIfwAN52EFTvg9NISIFdEq6z7K280Cnb9LG56kh2pTG0HlzdW+xbfRO6IbZKwxS QuE6ykKQUciemgyekzAzDtF7ebWI3qs1Qr8+zg0hdZ5pCjN42PX8H2k9+S00BKX2AncHdkNhZbi S7OY9fwecjBlqfZnVBCdqd52R94ieZ8X6BYWqrSE5at7lfF35WKG9EjdLvQMX6mBrw3IyL/imGY E8iF1eScuCcE6ZQCsU9ELoLh8a3jl0ShMkuzI0lbfVek5iqpFXhrs7Nk9uMQieeGSd2cYb5WbI4 dxK1LLUWMjNz8/T8IiFqdOAU0NJeV98OO9NLtZxyATl+pEV+PsPceG3QvT5rHUMVolVJFccCoc4 3DaQSU7LjGMvCJAICc2fVfoKKX7w0BvQyO0TqhKPnKyEjw2eTkSsTIL9yj6aPUdkO502EBx0vCu KzdacZWuaVLBe+odoqK/L0XOexFIJBG631CL0lf2W/vYFCpnucc+/DskYHkM1AKvo5PKz0dT6Xn aDrdUhKUO2kc03VpH+BIyVjW/7E7dKNXXbQbdjcpm5OAYs+wXy+2gYoGM7+7F3UVkGVljsxqxye pIYNcZ5t+j7a1OA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit 6834097fc38c5416701c793da94558cea49c0a1f upstream.

There was a support for signal endpoints, but only when the endpoint's
flag was changed during a connection. If an endpoint with the signal and
backup was already present, the MP_JOIN reply was not containing the
backup flag as expected.

That's confusing to have this inconsistent behaviour. On the other hand,
the infrastructure to set the backup flag in the SYN + ACK + MP_JOIN was
already there, it was just never set before. Now when requesting the
local ID from the path-manager, the backup status is also requested.

Note that when the userspace PM is used, the backup flag can be set if
the local address was already used before with a backup flag, e.g. if
the address was announced with the 'backup' flag, or a subflow was
created with the 'backup' flag.

Fixes: 4596a2c1b7f5 ("mptcp: allow creating non-backup subflows")
Cc: stable@vger.kernel.org
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/507
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Conflicts in pm_userspace.c because the context has changed in commit
  1e07938e29c5 ("net: mptcp: rename netlink handlers to
  mptcp_pm_nl_<blah>_{doit,dumpit}") which is not in this version. This
  commit is unrelated to this modification.
  Conflicts in protocol.h because the context has changed in commit
  9ae7846c4b6b ("mptcp: dump addrs in userspace pm list") which is not
  in this version. This commit is unrelated to this modification.
  Conflicts in pm.c because the context has changed in commit
  f40be0db0b76 ("mptcp: unify pm get_flags_and_ifindex_by_id") which is
  not in this version. This commit is unrelated to this modification. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c           | 12 ++++++++++++
 net/mptcp/pm_netlink.c   | 18 ++++++++++++++++++
 net/mptcp/pm_userspace.c | 18 ++++++++++++++++++
 net/mptcp/protocol.h     |  3 +++
 net/mptcp/subflow.c      |  3 +++
 5 files changed, 54 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 10c288a0cb0c..a27ee627adde 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -416,6 +416,18 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	return mptcp_pm_nl_get_local_id(msk, skc);
 }
 
+bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
+{
+	struct mptcp_addr_info skc_local;
+
+	mptcp_local_address((struct sock_common *)skc, &skc_local);
+
+	if (mptcp_pm_is_userspace(msk))
+		return mptcp_userspace_pm_is_backup(msk, &skc_local);
+
+	return mptcp_pm_nl_is_backup(msk, &skc_local);
+}
+
 void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 223146a341b5..09cd612cf00a 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1110,6 +1110,24 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	return ret;
 }
 
+bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
+{
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
+	struct mptcp_pm_addr_entry *entry;
+	bool backup = false;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
+		if (mptcp_addresses_equal(&entry->addr, skc, entry->addr.port)) {
+			backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return backup;
+}
+
 #define MPTCP_PM_CMD_GRP_OFFSET       0
 #define MPTCP_PM_EV_GRP_OFFSET        1
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 414ed70e7ba2..278ba5955dfd 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -159,6 +159,24 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 	return mptcp_userspace_pm_append_new_local_addr(msk, &new_entry, true);
 }
 
+bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
+				  struct mptcp_addr_info *skc)
+{
+	struct mptcp_pm_addr_entry *entry;
+	bool backup = false;
+
+	spin_lock_bh(&msk->pm.lock);
+	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (mptcp_addresses_equal(&entry->addr, skc, false)) {
+			backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
+			break;
+		}
+	}
+	spin_unlock_bh(&msk->pm.lock);
+
+	return backup;
+}
+
 int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 5954e559f130..9e582725ccb4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -913,6 +913,9 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			     struct mptcp_rm_list *rm_list);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
+bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc);
+bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
+bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 
 static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflow)
 {
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index b8cb65bd9be8..b47673b37027 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -99,6 +99,7 @@ static struct mptcp_sock *subflow_token_join_request(struct request_sock *req)
 		return NULL;
 	}
 	subflow_req->local_id = local_id;
+	subflow_req->request_bkup = mptcp_pm_is_backup(msk, (struct sock_common *)req);
 
 	return msk;
 }
@@ -513,6 +514,8 @@ static int subflow_chk_local_id(struct sock *sk)
 		return err;
 
 	subflow_set_local_id(subflow, err);
+	subflow->request_bkup = mptcp_pm_is_backup(msk, (struct sock_common *)sk);
+
 	return 0;
 }
 
-- 
2.45.2



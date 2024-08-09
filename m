Return-Path: <stable+bounces-66255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6F294CF05
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 12:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E9271C21323
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 10:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3A11922F7;
	Fri,  9 Aug 2024 10:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIxJ/Tnk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0251922CB;
	Fri,  9 Aug 2024 10:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723200954; cv=none; b=JrwEJTEy2yd50D84ErabEGyepSyRVziN4hGHU8YwWbbDnEiTRaE+6+GEBmSgVXhOG8w/GHBP5rPvw3TdZ1XOtShesTurgnO/5Tv/nG4ovP4DxEzDqEpOKNNILJZ9kWtz9djLNQauS9T31r8ptiAccjFmrTZdRAVchjnAomn62ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723200954; c=relaxed/simple;
	bh=oAO+qUSiE3nb14YaeJa/c1ESUWlWr4xz92iMH0url2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QywEs9qodsORv0YxRaKdQfSI3znQVGfR1w7UCPYj7PvEnpX/cDcW96UNI5jxVQ6/pJGhjZym8/DWeN6RPJhCaYp7q4bmhOOxtv/ZPE4TJ8rNkVOJYRrDpPW0vIX6fT4xac7E/D8dty6H+oxuLXQlt7YfC7cJli1Zf6g7nRpa6Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIxJ/Tnk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E25C32786;
	Fri,  9 Aug 2024 10:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723200954;
	bh=oAO+qUSiE3nb14YaeJa/c1ESUWlWr4xz92iMH0url2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gIxJ/TnktD1z+RAEP9pr21pIaLbxw8V1LCOs92yQFaOCDOvxfgliTOwZOv5LI1EA8
	 RchMOQs6QrFu/S0yKOS2YzA7aX8h4vHBlk0Gv1vEtPcs7Rd1l/UYDGq0w2kFw0hePR
	 SCh9JeqajbihuXeAgCbp2hSXYRIkct0uVAxDoxvbGwCEQEcwh7hhTdexCuIMnH3JDJ
	 VJj1S3Y8o/biWqhku7YvklqvmPM2w3/SVM15NLtoPp7ukiRERwh2edaNreRt25hbiN
	 3hPKSGOrrqmUj/3TicJge+wzqRNgF7E3UKeZ4fgtsfQPa7Yxl9SfB8C60heCJSGAt1
	 ej9CTEvSDjl6A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.10.y 2/2] mptcp: pm: fix backup support in signal endpoints
Date: Fri,  9 Aug 2024 12:55:40 +0200
Message-ID: <20240809105538.2903162-4-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240809105538.2903162-3-matttbe@kernel.org>
References: <2024080729-unclaimed-shopping-6751@gregkh>
 <20240809105538.2903162-3-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6320; i=matttbe@kernel.org; h=from:subject; bh=oAO+qUSiE3nb14YaeJa/c1ESUWlWr4xz92iMH0url2g=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmtfWqWwCbrBqxy/Fd7iF2YMaiR8J02Q81rwL+H 53cuMXfUY2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrX1qgAKCRD2t4JPQmmg cxUQD/sExyDdyjWV7+FngJH7RJUpC2PmPENmvcABnzRmtIuXZ5+3GRbFrQE/qfk+EY8PJe3r/HH NT/VdjHhTdmxOgF6a4i8k+TChB0S1XQzDx6uJefV7HElG0+oypXBFwJ3o7zc+dv14lXo2sePDlx /+9i0MwLZI/HQBJP1/GZS4gW1Dg/XmbvHMUhMvmcBgxp4aWTViOylX+OJ2J4nOKbBc89/aAKb4M 9erDJ4VcwhaYMnRhk50wesf/L9bGKh6inH0q4DMMBQANQnE22bOuc6oO1eOggIIPw9ZEdjyuk4X yv+JnyHu4kfkBM87EweUBUBrim7HQJVT7MjOplxhGzbfFYwps7qAyc2W30Xt48wlLCA4OQLr8Zq 7dmskd6Fkk5FG8rQBaWE8jsU21v1IUoLCUrNGj6N4ALuYRi6PbVhCniumTpgC9MGU5ovByjVaDZ eHU35c7FaA0mFXssrlv1FLvUREq5YmRhOU36X6Naf9ScFjOFW81TwxMQLqn6zdmyWguVo9Z+GYo nR7nctPIYqbrGXLoi/Jt8nyRWvpxf3REDKrVCPsPBSc8mIN0tRU2zT3S9bQoB4CgIDpsdyx4q5Q Y2Albd1M4MqKqpKr85QFJuV/WorsVbMpkJcTDQiK69BvZqrN7OmJlHBMAMoijXFbUQ/P74wqC6X GcNIb/d5SkRpGYw==
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
  f40be0db0b76 ("mptcp: unify pm get_flags_and_ifindex_by_id") and
  commit 71b7dec27f34 ("mptcp: less aggressive retransmission strategy")
  which are not in this version. These commits are unrelated to this
  modification.
  Conflicts in subflow.c, because the commit 4cf86ae84c71 ("mptcp:
  strict local address ID selection") is not in this version. It is then
  not needed to modify the subflow_chk_local_id() helper, which is not
  in this version.
  Also, in this version, there is no pm_userspace.c, because this PM has
  been added in v5.19, which also causes conflicts in protocol.h, and
  pm_netlink.c. Plus the code in pm.c can be simplified, as there is no
  userspace PM. And the code in pm_netlink.c needs to use
  addresses_equal() instead of mptcp_addresses_equal(), see commit
  4638de5aefe5 ("mptcp: handle local addrs announced by userspace PMs").
  The code in pm_netlink.c also needs to be adapted because the
  pm_nl_get_pernet_from_msk() helper is not in this version, introduced
  later in commit c682bf536cf4 ("mptcp: add pm_nl_pernet helpers"), and
  also because the 'flags' are in mptcp_addr_info structure, see commit
  daa83ab03954 ("mptcp: move flags and ifindex out of
  mptcp_addr_info"). ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c         |  9 +++++++++
 net/mptcp/pm_netlink.c | 20 ++++++++++++++++++++
 net/mptcp/protocol.h   |  2 ++
 net/mptcp/subflow.c    |  1 +
 4 files changed, 32 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index e19e1525ecbb..1f310abbf1ed 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -225,6 +225,15 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	return mptcp_pm_nl_get_local_id(msk, skc);
 }
 
+bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
+{
+	struct mptcp_addr_info skc_local;
+
+	mptcp_local_address((struct sock_common *)skc, &skc_local);
+
+	return mptcp_pm_nl_is_backup(msk, &skc_local);
+}
+
 void mptcp_pm_data_init(struct mptcp_sock *msk)
 {
 	msk->pm.add_addr_signaled = 0;
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 6a0079d42dc4..ca57d856d5df 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -568,6 +568,26 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	return ret;
 }
 
+bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
+{
+	struct mptcp_pm_addr_entry *entry;
+	struct pm_nl_pernet *pernet;
+	bool backup = false;
+
+	pernet = net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
+		if (addresses_equal(&entry->addr, skc, entry->addr.port)) {
+			backup = !!(entry->addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP);
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return backup;
+}
+
 void mptcp_pm_nl_data_init(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_data *pm = &msk->pm;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ddfc7bde8c90..4348bccb982f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -481,6 +481,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			     u8 *rm_id);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
+bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc);
 
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_data_init(struct mptcp_sock *msk);
@@ -490,6 +491,7 @@ void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk);
 void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk);
 void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk, u8 rm_id);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
+bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 
 static inline struct mptcp_ext *mptcp_get_ext(struct sk_buff *skb)
 {
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index f4067484727e..ba86cb06d6d8 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -80,6 +80,7 @@ static struct mptcp_sock *subflow_token_join_request(struct request_sock *req,
 		return NULL;
 	}
 	subflow_req->local_id = local_id;
+	subflow_req->request_bkup = mptcp_pm_is_backup(msk, (struct sock_common *)req);
 
 	get_random_bytes(&subflow_req->local_nonce, sizeof(u32));
 
-- 
2.45.2



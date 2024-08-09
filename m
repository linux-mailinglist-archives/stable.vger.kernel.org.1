Return-Path: <stable+bounces-66134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F0294CCF6
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 11:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58B6C1C21241
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 09:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D0719005B;
	Fri,  9 Aug 2024 09:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8pK9l0R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6956190047;
	Fri,  9 Aug 2024 09:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723194572; cv=none; b=lA99WLHixBJoCRWs1aHSYGySmPyGfZg6jCbDe5zeJWURritscEQbMRD2ytzv9/8vfQil3z+n0KUz2Shbw0T9c0TNZuNuGtt59clNGJr1fQhxPHAnSknFCD+9nT4CoPEreBjCypO21Sbk35R4Rr6isam8NuzsnLYWGMLwLPKcbPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723194572; c=relaxed/simple;
	bh=RC3BEZ+p/gU0PMyhk4nhZWBTxWEVthUs1GIIx70HIm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lkx00SD9tg0ZXZI0iQvFD1DWNzg2is5dCpo1QvtqYPlPHi5bYiPMnslnaWvYZdxYiA0nQpbd7smhpI3lYy3LFGakxdBCUz8O9RkWL+bMKlu8msRcPRObHypzuEHiAfezZQ7HUI8ejAC0q5Uv/ot7v5KbbPFGIn8AHGRWzBcv+q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8pK9l0R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A75C4AF0D;
	Fri,  9 Aug 2024 09:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723194571;
	bh=RC3BEZ+p/gU0PMyhk4nhZWBTxWEVthUs1GIIx70HIm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c8pK9l0RkDsaq5fVWslNvemvn12PDJofhCzgYFS5k7EuL3mI6g/QEbEm/2TJ0zGPw
	 1pIvDlfIYHQtzelyHgPQ3G+g/ixtAvWoA5odiLDCCjA2sQY0ty3rk58fXKbq6jJuDl
	 H4O/PKUfKflGUupvwENvhGEVl0yrOzHlY+jZQCJh+B5TffBqryIJWdxGWW9XFqlzmx
	 icm42jU4X6IFXkAkmtI1vjmXHIgEbByat0sZqlEbz96kcyQf+b+AGo7ku88AhQM0iJ
	 M3/VJra8YmMDu3/ftgICigX7hovZB/ZDBJfRy5xt1gpeKKCYHbsLolv9raLE5RYNxt
	 9mS65nDXYZEZQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.15.y 2/2] mptcp: pm: fix backup support in signal endpoints
Date: Fri,  9 Aug 2024 11:09:14 +0200
Message-ID: <20240809090912.2701580-4-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240809090912.2701580-3-matttbe@kernel.org>
References: <2024080728-steep-scallion-4de3@gregkh>
 <20240809090912.2701580-3-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6215; i=matttbe@kernel.org; h=from:subject; bh=RC3BEZ+p/gU0PMyhk4nhZWBTxWEVthUs1GIIx70HIm0=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmtdy43dX0w3oqT1xGujJokYGreX+nTmZ64sLFf 5LoaUsRePWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrXcuAAKCRD2t4JPQmmg c15MD/wPTDv40oZdz6IyZ1ykjGBN0c4lB0epBmxGgedFVNM+0LOhNAiHx9khckEYc9ovpCOHgiB a1c5chu7g1Nq6nwjic1xulh/6olIvK6nG/xV+s+g3cr8NR7AaTPAcUskIJwFjOtF6Dhia3mHx67 tQhNlDMoPkOUTzLtUAkKpDlRCuDbGLkmbrkRAa1IP2TVd8ezkgX//rLCkCQoAvxwHZhORlMXE22 6Jt0CSao2Spd3MscbWcZGU5v4bImNv+dhjj5vV8A5GNT4MgCuAtjOB6POjbKUIHLog50W8N88mc R5PduJKtb+M4Kop24mkvIe+pxHUWa94ArzoW8ekmr2UA4wFf8wp9SDQ79Mh3SiaikOZWV32G3Uk BPm/xKz2plnLXfFIYgV4Sz3Qu0JPeuV4QH8eSffq3uCLJIqk18lVR7AJp/guaJpyt2WisJ75S8C /I3Klt9JoCxDEJayHsAE0PAGVutpdjq+FPTouzYugJ99VmxHcvyKCv/P7/o5BNZh99VQi2nqVGS F2KOHe5KPd+44ST8EgDIAuWcbFA16zL+Ndr7Z4m2+V4lI6at3yZA6Clg5BSkHxsS0oOMEZMzqfX tqVFbDuJw0cEnLyIatKOrsa/JdaRbydVVSH4bJAXyGx/bT6LySxkSKVUowbVC7BtDccA55GUVFN /ZzNg9BopLk/5UQ==
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
  not in this version. This commit is unrelated to this modification.
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
  later in commit c682bf536cf4 ("mptcp: add pm_nl_pernet helpers"). ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c         |  9 +++++++++
 net/mptcp/pm_netlink.c | 20 ++++++++++++++++++++
 net/mptcp/protocol.h   |  2 ++
 net/mptcp/subflow.c    |  1 +
 4 files changed, 32 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d9790d6fbce9..55e8407bcc25 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -341,6 +341,15 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
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
 void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 37e9ff9b99f6..1ae164711783 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1014,6 +1014,26 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
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
+			backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
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
index 0f82d75e3d20..234cf918db97 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -821,6 +821,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			     struct mptcp_rm_list *rm_list);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
+bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc);
 
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_data_init(struct mptcp_sock *msk);
@@ -828,6 +829,7 @@ void mptcp_pm_nl_work(struct mptcp_sock *msk);
 void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
 				     const struct mptcp_rm_list *rm_list);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
+bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 unsigned int mptcp_pm_get_add_addr_signal_max(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_accept_max(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_subflows_max(struct mptcp_sock *msk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 90e7a46a6d2f..2f94387f2ade 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -97,6 +97,7 @@ static struct mptcp_sock *subflow_token_join_request(struct request_sock *req)
 		return NULL;
 	}
 	subflow_req->local_id = local_id;
+	subflow_req->request_bkup = mptcp_pm_is_backup(msk, (struct sock_common *)req);
 
 	return msk;
 }
-- 
2.45.2



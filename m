Return-Path: <stable+bounces-65951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB0C94B024
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 20:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43773B242BA
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 18:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F881419B5;
	Wed,  7 Aug 2024 18:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkP/1gz8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3342485654;
	Wed,  7 Aug 2024 18:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723057072; cv=none; b=JjPANROawsuyuiSSV0C7a4z5cH9vijlQRWItsxBN2ipKnBmKIiemAFwMSwDNoxDgpZmRC5rHYfzk45tiomxG20LMl0YuOqUp6yOT3Rev4B2FLO4jxiijQtBSmKl+mqTa/jI2QKaxdJwDq/6B3ADDSnz5k3jR2CpCT2V6O4Y21Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723057072; c=relaxed/simple;
	bh=oWWzADt90sT5uCr0+I5uAZYnNef5fws6+y7KFWDzNeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O4w/XBSDKGFZ9qHceEu88sPdSTx33z7jb57wVKmf1pBvLNpnCvFr1U0h/7qLBgnZg+pGXbh7dlyuwndt4tuu10O0RH0AK/pjEadcQt3rCqWiwNQKqxtH0cODLCRDT+/fX5JXgrLH1pjAGvnNAgtQoIvZWvfH5fDud0hNWmOkIG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkP/1gz8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46580C4AF0D;
	Wed,  7 Aug 2024 18:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723057071;
	bh=oWWzADt90sT5uCr0+I5uAZYnNef5fws6+y7KFWDzNeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NkP/1gz8JgzW1BbuSM8wlyzDr6O0EhC0FVoAfTvoHMy7M2kTq3zZD265xeMlWCiwJ
	 +E+vzUZW+PonbgkKr3DMm3G4gjIkwDPgkUJRtQyzdaUNMkMsk+U577jPfJu1azZkC6
	 ddLyaSELIamBcNQfstqk/zq+50ZPLS8dDbs2Cobb3GXVG7lk0gL8AVFihsMlxTCLFD
	 saMJJq9BdmFGEK14Uuq2IVtv/kb7LOAWYEZssqfNoscfi5sDtCa22JRHXZltLET0Tv
	 +YO9KEh/uQWkQHOfaEdnd+RwuL/rXxmAK3VIDKd+E5rveEY8I81C+0wJgWL01oY1cd
	 i36vbPyA9qrog==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.6.y] mptcp: pm: fix backup support in signal endpoints
Date: Wed,  7 Aug 2024 20:57:03 +0200
Message-ID: <20240807185702.1871002-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024080726-educator-stubble-a08d@gregkh>
References: <2024080726-educator-stubble-a08d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6033; i=matttbe@kernel.org; h=from:subject; bh=oWWzADt90sT5uCr0+I5uAZYnNef5fws6+y7KFWDzNeg=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBms8N+d0e4ykr3XD6AerlmYHmLYyVn955fTjG/c yWMw9JrByeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrPDfgAKCRD2t4JPQmmg c7FeEADN/GAqeclkvD3MffEWmbwsXFfUJHjbBIw60mxvqBK0Cx0rSlha6yT5adsG0QtjJ7BXhUy Ley/yF/UpZDZCkrlKIvrP15xA8M4qTisjUprEanKooYikeQAHu7KiQvLtYfJUJ/Cq/l/d18gkMv wXeTzVI4kiOO8rmz4it802l10MgZMEq8EaSlJij3x+Fau1RUMjVomo1HalS5MeeHYxIvNVAliAH ke7tDqUHcteMiXQd/OPYwn0nx1rSCmHWbz3S4oTZcrQJ11WQ1L8zMf5Aj6MwXXpRkOrOtY5eYX/ QhUl/1y8hjOliJqmhXOnq5vEro/MH38dNW9K8ehRkhYpHICv4LjoUePDjL1tVqT6bAGADV8TNVD pNo11CQjYdvAQcMeOEBVIC/vKjC8nH6B7skhVqGn0LGNf+hQz8jgbnBVuf5UyE/mDgPFXvkIv4v l8fHkzIPpYscDQxoRw6ZkPUBNyEYqirSthui9MQpXTBU9ivM4O9Kvo9wItNbwcskstgMyYIHkfZ QMY+bFIpFfJr9aW00Mr827JH1gG7+4QDyM96kBIGpbdBlB6a7bd26wU3c7HS1HuzNB5S3J3frIy EMma+L2WS+l1Z2pkulBhGgkfZZHPtZ1A/GRkO8rt0ivPeoXkLuvUsGhy76ht2GXNQjYSwc2uLAe jHH52PqKawY15lA==
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
  in this version. This commit is unrelated to this modification. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c           | 12 ++++++++++++
 net/mptcp/pm_netlink.c   | 18 ++++++++++++++++++
 net/mptcp/pm_userspace.c | 18 ++++++++++++++++++
 net/mptcp/protocol.h     |  3 +++
 net/mptcp/subflow.c      |  3 +++
 5 files changed, 54 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d8da5374d9e1..cf70a376398b 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -427,6 +427,18 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	return mptcp_pm_nl_get_local_id(msk, &skc_local);
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
 int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id,
 					 u8 *flags, int *ifindex)
 {
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index db621933b203..ea06ef80c60f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1109,6 +1109,24 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
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
index f36f87a62dd0..6738bad048ce 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -157,6 +157,24 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
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
index c28ac5dfd0b5..0201b1004a3b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1032,6 +1032,9 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
+bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc);
+bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
+bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 
 static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflow)
 {
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index bc1efc178772..927c2d5997dc 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -100,6 +100,7 @@ static struct mptcp_sock *subflow_token_join_request(struct request_sock *req)
 		return NULL;
 	}
 	subflow_req->local_id = local_id;
+	subflow_req->request_bkup = mptcp_pm_is_backup(msk, (struct sock_common *)req);
 
 	return msk;
 }
@@ -601,6 +602,8 @@ static int subflow_chk_local_id(struct sock *sk)
 		return err;
 
 	subflow_set_local_id(subflow, err);
+	subflow->request_bkup = mptcp_pm_is_backup(msk, (struct sock_common *)sk);
+
 	return 0;
 }
 
-- 
2.45.2



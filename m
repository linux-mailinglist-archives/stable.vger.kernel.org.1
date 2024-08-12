Return-Path: <stable+bounces-67098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D6694F3E2
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 207DC1C21948
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870B2186E34;
	Mon, 12 Aug 2024 16:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EzKmLUY4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D4C134AC;
	Mon, 12 Aug 2024 16:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723479801; cv=none; b=Z7fXDkKsuiY5CEktnE6Gxh6XcEedEMDxaHj3fTM8jenOoSeiK3NKku03vc/YFI/thDGqhpoTX5ks7MV1XKB2NLXRaXPQY2Yk4Qv2seAOCIemUf19ge90V6PnGL1sm2Xc24JUIXKXTvdTMwvM2E61xfJEL6PCj1qJYtjH9JRdCtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723479801; c=relaxed/simple;
	bh=O/GuWgy0pLbgO/vd4G01rBABaCNxV5vhCUdaqU4RDfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r4958SEbhyj0hGjrhTQ6H8AMbjI/6APGnd8AetltR09vnkHFeT0gwTXxNTeuO9JNh3frNF4SgbjKrRmR9E8J502TmDYZpuB29+/MJrZwDtDY+vIT0mg20HDscZl3oQj7K3ZSK04Egx0XIB3frDSfqO0zDhMlrlSkyL0t7RS6RFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EzKmLUY4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F2AC32782;
	Mon, 12 Aug 2024 16:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723479801;
	bh=O/GuWgy0pLbgO/vd4G01rBABaCNxV5vhCUdaqU4RDfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EzKmLUY4ZB3nU042xv3tUteZ7wbQrcHGYtAlSg1NsUDkJI8+aiRkfprY/BpvZTZ46
	 WSxhhSMJUyKTzw4stWgaR0VtAH1yePC4iQxo6oyN90+I/4V/Hn5sXYryue+k+Y58kn
	 +u1uRSn1GeormOT/7hQYsli8YncJ+pDouV5HKAvQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mat Martineau <martineau@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.6 168/189] mptcp: pm: fix backup support in signal endpoints
Date: Mon, 12 Aug 2024 18:03:44 +0200
Message-ID: <20240812160138.614096318@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812160132.135168257@linuxfoundation.org>
References: <20240812160132.135168257@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthieu Baerts (NGI0) <matttbe@kernel.org>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm.c           |   12 ++++++++++++
 net/mptcp/pm_netlink.c   |   18 ++++++++++++++++++
 net/mptcp/pm_userspace.c |   18 ++++++++++++++++++
 net/mptcp/protocol.h     |    3 +++
 net/mptcp/subflow.c      |    3 +++
 5 files changed, 54 insertions(+)

--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -427,6 +427,18 @@ int mptcp_pm_get_local_id(struct mptcp_s
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
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1109,6 +1109,24 @@ int mptcp_pm_nl_get_local_id(struct mptc
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
 
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -157,6 +157,24 @@ int mptcp_userspace_pm_get_local_id(stru
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
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1032,6 +1032,9 @@ bool mptcp_pm_rm_addr_signal(struct mptc
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
+bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc);
+bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
+bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 
 static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflow)
 {
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -100,6 +100,7 @@ static struct mptcp_sock *subflow_token_
 		return NULL;
 	}
 	subflow_req->local_id = local_id;
+	subflow_req->request_bkup = mptcp_pm_is_backup(msk, (struct sock_common *)req);
 
 	return msk;
 }
@@ -601,6 +602,8 @@ static int subflow_chk_local_id(struct s
 		return err;
 
 	subflow_set_local_id(subflow, err);
+	subflow->request_bkup = mptcp_pm_is_backup(msk, (struct sock_common *)sk);
+
 	return 0;
 }
 




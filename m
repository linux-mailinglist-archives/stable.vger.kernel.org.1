Return-Path: <stable+bounces-186253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE42BE705E
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 09:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 96DF135B5A3
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 07:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E1725F984;
	Fri, 17 Oct 2025 07:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Osjw2ylW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843282550A4;
	Fri, 17 Oct 2025 07:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760687840; cv=none; b=bAr+7YKJQ3bpa8IA2n9Vhjkc2ggKglgTHvq9TrHi6twsHBxsRB1RvINUSwDbDK1PWvt5MRwJjpKEjP6CCUNozRt/wOCr56XFqpdgNs6G9ILpTzj67unybMj+H09MuJjFEbplh4tB/a+XwG/PgmFQ4bO3T5nXVQN0vKVbTlCAoA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760687840; c=relaxed/simple;
	bh=MgPkShBhUBzMn0U3g5lyMB86eaWakWS8Qs+4rxY7XuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ee7E5leyHk1WxEQNY3KH2HzXxL8kGroxTrj9JSzApOpYqKi1I0N44F5bttspEjxDlME7/WfT49ag+VVOcuWTUvDosH41HTBd8zHwdixEFI7QmyBnRptaJBTMsZID4Zr5K5H/cf4hjE+rR3QZAs467oiBe41NUPGuXpUorG2VljI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Osjw2ylW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7021C4CEE7;
	Fri, 17 Oct 2025 07:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760687840;
	bh=MgPkShBhUBzMn0U3g5lyMB86eaWakWS8Qs+4rxY7XuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Osjw2ylWRVpArcpPTq7oBR78LSG6ORVLGjVt64Y/gPh8inFO2leOEq+zOt/bvi4OO
	 dmWuN3d7zv/IjLFANdlF983iKVmUCxe+MarBf5KnrWX0Tb/R+x/e9KzV7S9ThF4MLl
	 6fSswbXOmdM8JoYdzBbYISw7aIG1/VlF+p+8Iaxngb6olFL7f94bP0R1B+OKfcnR7M
	 TLZXx+Qvq5UPgVd7bb68TRNd1qW4SRTUyGTQMUhkiUVnWzA3/KuhRot+jmfbNHd/Cc
	 2NIS/OVVAXSWBN9ITb1awdr4jL3zOEDcPMiT8waXEQRUn+qIKCzoj9ofjQfS4NvZUn
	 CRUDUmwfiKBqg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y] mptcp: pm: in-kernel: usable client side with C-flag
Date: Fri, 17 Oct 2025 09:57:09 +0200
Message-ID: <20251017075708.1455085-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101656-earthly-womanhood-2b05@gregkh>
References: <2025101656-earthly-womanhood-2b05@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7350; i=matttbe@kernel.org; h=from:subject; bh=MgPkShBhUBzMn0U3g5lyMB86eaWakWS8Qs+4rxY7XuE=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI+frv6+sG8Tx7fbvYuF7ppxpl+Uq0pl4H3od+WJ/mTY 5/+e5ff01HKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjCRFTkM/xOOrjWbaMfjYWbZ zT9z6qO2omki4Wvlp/W/Zy1W3bVemIvhN8vFJC6Nx6bqys4OoonNQteev52WIZTnY7477uSkhxf 3sQEA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit 4b1ff850e0c1aacc23e923ed22989b827b9808f9 upstream.

When servers set the C-flag in their MP_CAPABLE to tell clients not to
create subflows to the initial address and port, clients will likely not
use their other endpoints. That's because the in-kernel path-manager
uses the 'subflow' endpoints to create subflows only to the initial
address and port.

If the limits have not been modified to accept ADD_ADDR, the client
doesn't try to establish new subflows. If the limits accept ADD_ADDR,
the routing routes will be used to select the source IP.

The C-flag is typically set when the server is operating behind a legacy
Layer 4 load balancer, or using anycast IP address. Clients having their
different 'subflow' endpoints setup, don't end up creating multiple
subflows as expected, and causing some deployment issues.

A special case is then added here: when servers set the C-flag in the
MPC and directly sends an ADD_ADDR, this single ADD_ADDR is accepted.
The 'subflows' endpoints will then be used with this new remote IP and
port. This exception is only allowed when the ADD_ADDR is sent
immediately after the 3WHS, and makes the client switching to the 'fully
established' mode. After that, 'select_local_address()' will not be able
to find any subflows, because 'id_avail_bitmap' will be filled in
mptcp_pm_create_subflow_or_signal_addr(), when switching to 'fully
established' mode.

Fixes: df377be38725 ("mptcp: add deny_join_id0 in mptcp_options_received")
Cc: stable@vger.kernel.org
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/536
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250925-net-next-mptcp-c-flag-laminar-v1-1-ad126cc47c6b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflict in pm.c, because commit 498d7d8b75f1 ("mptcp: pm: remove
  '_nl' from mptcp_pm_nl_is_init_remote_addr") renamed an helper in the
  context, and it is not in this version. The same new code can be
  applied at the same place.
  Conflict in pm_kernel.c, because the modified code has been moved from
  pm_netlink.c to pm_kernel.c in commit 8617e85e04bd ("mptcp: pm: split
  in-kernel PM specific code"), which is not in this version. The
  resolution is easy: simply by applying the patch where 'pm_kernel.c'
  has been replaced 'pm_netlink.c'.
  Conflict in pm_netlink.c, because commit b83fbca1b4c9 ("mptcp: pm:
  reduce entries iterations on connect") is not in this version. Instead
  of using the 'locals' variable (struct mptcp_pm_local *) from the new
  version and embedding a "struct mptcp_addr_info", we can simply
  continue to use the 'addrs' variable (struct mptcp_addr_info *).
  Conflict in protocol.h, because commit af3dc0ad3167 ("mptcp: Remove
  unused declaration mptcp_sockopt_sync()") is not in this version and
  it removed one line in the context. The resolution is easy because the
  new function can still be added at the same place. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c         |  7 ++++--
 net/mptcp/pm_netlink.c | 52 +++++++++++++++++++++++++++++++++++++++++-
 net/mptcp/protocol.h   |  8 +++++++
 3 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 29c167e5fc02..ab7bdb653181 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -227,9 +227,12 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
 		} else {
 			__MPTCP_INC_STATS(sock_net((struct sock *)msk), MPTCP_MIB_ADDADDRDROP);
 		}
-	/* id0 should not have a different address */
+	/* - id0 should not have a different address
+	 * - special case for C-flag: linked to fill_local_addresses_vec()
+	 */
 	} else if ((addr->id == 0 && !mptcp_pm_nl_is_init_remote_addr(msk, addr)) ||
-		   (addr->id > 0 && !READ_ONCE(pm->accept_addr))) {
+		   (addr->id > 0 && !READ_ONCE(pm->accept_addr) &&
+		    !mptcp_pm_add_addr_c_flag_case(msk))) {
 		mptcp_pm_announce_addr(msk, addr, true);
 		mptcp_pm_add_addr_send_ack(msk);
 	} else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED)) {
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index de24989b05a6..9d2c38421f7a 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -675,10 +675,12 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 	struct mptcp_addr_info mpc_addr;
 	struct pm_nl_pernet *pernet;
 	unsigned int subflows_max;
+	bool c_flag_case;
 	int i = 0;
 
 	pernet = pm_nl_get_pernet_from_msk(msk);
 	subflows_max = mptcp_pm_get_subflows_max(msk);
+	c_flag_case = remote->id && mptcp_pm_add_addr_c_flag_case(msk);
 
 	mptcp_local_address((struct sock_common *)msk, &mpc_addr);
 
@@ -691,11 +693,26 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 			continue;
 
 		if (msk->pm.subflows < subflows_max) {
+			bool is_id0;
+
 			msk->pm.subflows++;
 			addrs[i] = entry->addr;
 
+			is_id0 = mptcp_addresses_equal(&entry->addr,
+						       &mpc_addr,
+						       entry->addr.port);
+
+			if (c_flag_case &&
+			    (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)) {
+				__clear_bit(addrs[i].id,
+					    msk->pm.id_avail_bitmap);
+
+				if (!is_id0)
+					msk->pm.local_addr_used++;
+			}
+
 			/* Special case for ID0: set the correct ID */
-			if (mptcp_addresses_equal(&entry->addr, &mpc_addr, entry->addr.port))
+			if (is_id0)
 				addrs[i].id = 0;
 
 			i++;
@@ -703,6 +720,39 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 	}
 	rcu_read_unlock();
 
+	/* Special case: peer sets the C flag, accept one ADD_ADDR if default
+	 * limits are used -- accepting no ADD_ADDR -- and use subflow endpoints
+	 */
+	if (!i && c_flag_case) {
+		unsigned int local_addr_max = mptcp_pm_get_local_addr_max(msk);
+
+		while (msk->pm.local_addr_used < local_addr_max &&
+		       msk->pm.subflows < subflows_max) {
+			struct mptcp_pm_addr_entry local;
+
+			if (!select_local_address(pernet, msk, &local))
+				break;
+
+			__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
+
+			if (!mptcp_pm_addr_families_match(sk, &local.addr,
+							  remote))
+				continue;
+
+			if (mptcp_addresses_equal(&local.addr, &mpc_addr,
+						  local.addr.port))
+				continue;
+
+			addrs[i] = local.addr;
+
+			msk->pm.local_addr_used++;
+			msk->pm.subflows++;
+			i++;
+		}
+
+		return i;
+	}
+
 	/* If the array is empty, fill in the single
 	 * 'IPADDRANY' local address
 	 */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c5f41cdb36c4..1f213706dfaa 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1080,6 +1080,14 @@ static inline void mptcp_pm_close_subflow(struct mptcp_sock *msk)
 	spin_unlock_bh(&msk->pm.lock);
 }
 
+static inline bool mptcp_pm_add_addr_c_flag_case(struct mptcp_sock *msk)
+{
+	return READ_ONCE(msk->pm.remote_deny_join_id0) &&
+	       msk->pm.local_addr_used == 0 &&
+	       mptcp_pm_get_add_addr_accept_max(msk) == 0 &&
+	       msk->pm.subflows < mptcp_pm_get_subflows_max(msk);
+}
+
 void mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk);
 void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk);
 
-- 
2.51.0



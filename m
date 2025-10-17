Return-Path: <stable+bounces-186309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DA78ABE8137
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 12:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7DFB04E8B4F
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 10:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF68824A3;
	Fri, 17 Oct 2025 10:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfvhDvHN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A789E1BC3F;
	Fri, 17 Oct 2025 10:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760697114; cv=none; b=JgGQKFICu7c5P5u4FAbvxJHNftdvfIqETCX3+DPx+a/KqfLf+g5dZ51P5+y/MzX0n2m6UFCqMzjHtbdsYn65fYfmK3B0FT875gH6ewZfWlyrXfJN/n/Q8dlq5z2OewsykZsBhtnYViEhoFke1vC3p8draEPR/TkP03d860NTYAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760697114; c=relaxed/simple;
	bh=AObnHHizVDtiX+m7JEtlC1hXHcbP31Gpjqx/xImk1o0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hJf4jzJdtgMtJcnnZTfSJPZZxDKaqvylnzbWTCHlOCvsgQUQKk0SaJAJpzxgDsv8g9NiLGjNX2KkdZM9rPMHHgPNrK88RPD8Rq5misSn4aWtwfl7KxSit5Q0vVyYR3hgiTNbJwgAaFZUcchUtBdfJQ2W/wkRO7tU5riZjfbvFTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qfvhDvHN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0107C4CEE7;
	Fri, 17 Oct 2025 10:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760697114;
	bh=AObnHHizVDtiX+m7JEtlC1hXHcbP31Gpjqx/xImk1o0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qfvhDvHN8orMHy+kEXvK7YAgOmjtEKj0CWGgIehuXuiFploknL9c3R8oL5Bmgjynp
	 JbxVnCHg5XaNHOO3GJzGstrSV+iCj5ouVlU+wez4k1iQf5zZUgo/vTNZP5Ri/HqfU2
	 RiEN9Hm7stvVo5X+p2PAEbXa47qkGaUhA8YlqI9m05H0+e1z0poY8tJ0H8c3cCbUB+
	 KnyxLiD/nqnMbzibyibfLpUtMXt7GyYwj7vMVExHzeX1dYWUBGJ5Ce6Xhp46uL/JTe
	 2Z1Zks3w7WC6z1hKF/LvZVwRgpkxLaJ5j9HlMSnXNaaJD4U7wb+N/MFyCxjnDbHMbB
	 548A+oDPMVknw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y] mptcp: pm: in-kernel: usable client side with C-flag
Date: Fri, 17 Oct 2025 12:31:28 +0200
Message-ID: <20251017103127.1891170-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101657-platform-jersey-adec@gregkh>
References: <2025101657-platform-jersey-adec@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8328; i=matttbe@kernel.org; h=from:subject; bh=AObnHHizVDtiX+m7JEtlC1hXHcbP31Gpjqx/xImk1o0=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI+STNwdxcqh2+v0L9u69JyaNrOtAvXb798cvJkyfKdR UvPbWR36ihlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZhI1XqG/9lqF9fJTv4z71Vp hLaTY/ykzQv7lETauq4f/avnLV8o6czIcJCV0yfn7A+NhTNlL64TmPTAhYOrm8Nq9Zn3jDXfU+f vYAMA
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
  Because commit b9d69db87fb7 ("mptcp: let the in-kernel PM use mixed
  IPv4 and IPv6 addresses") is not in this version, it is also required
  to pass an extra parameter to fill_local_addresses_vec(): struct
  mptcp_addr_info *remote, which is available from the caller side.
  Conflict in protocol.h, because commit af3dc0ad3167 ("mptcp: Remove
  unused declaration mptcp_sockopt_sync()") is not in this version and
  it removed one line in the context. The resolution is easy because the
  new function can still be added at the same place. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c         |  7 ++++--
 net/mptcp/pm_netlink.c | 55 ++++++++++++++++++++++++++++++++++++++++--
 net/mptcp/protocol.h   |  8 ++++++
 3 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 6392973b1fa7..f1a8ae7a5af4 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -225,9 +225,12 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
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
index 7e72862a6b54..614ddae9c0a5 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -671,6 +671,7 @@ static void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk)
  * and return the array size.
  */
 static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
+					     struct mptcp_addr_info *remote,
 					     struct mptcp_addr_info *addrs)
 {
 	struct sock *sk = (struct sock *)msk;
@@ -678,10 +679,12 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 	struct mptcp_addr_info mpc_addr;
 	struct pm_nl_pernet *pernet;
 	unsigned int subflows_max;
+	bool c_flag_case;
 	int i = 0;
 
 	pernet = pm_nl_get_pernet_from_msk(msk);
 	subflows_max = mptcp_pm_get_subflows_max(msk);
+	c_flag_case = remote->id && mptcp_pm_add_addr_c_flag_case(msk);
 
 	mptcp_local_address((struct sock_common *)msk, &mpc_addr);
 
@@ -701,11 +704,26 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 		}
 
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
@@ -713,6 +731,39 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
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
@@ -760,7 +811,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	/* connect to the specified remote address, using whatever
 	 * local address the routing configuration will pick.
 	 */
-	nr = fill_local_addresses_vec(msk, addrs);
+	nr = fill_local_addresses_vec(msk, &remote, addrs);
 
 	spin_unlock_bh(&msk->pm.lock);
 	for (i = 0; i < nr; i++)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e1637443203e..81507419c465 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -958,6 +958,14 @@ static inline void mptcp_pm_close_subflow(struct mptcp_sock *msk)
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



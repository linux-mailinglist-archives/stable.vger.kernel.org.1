Return-Path: <stable+bounces-186178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4721BE4B4D
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 18:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EE7F19C34F2
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 16:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B49534572B;
	Thu, 16 Oct 2025 16:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPaPVJeM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2614D345723;
	Thu, 16 Oct 2025 16:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633832; cv=none; b=nGm0TqWnrq3K3mjy6WtaE5KxlKpar7TrHHyxc3SgKkL2Grx/3mTa1G6SfNXMmCOtaT8WP/T2MoDSIIByize09Z3w7SwRLMib0+IX3OURx7N+d/YPnhVH5JbItJGPX1Cw74vFsZsNUuT8DK36g+GqGzMiJGqu16p/YVzniDZ8kU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633832; c=relaxed/simple;
	bh=9nG1qjjFGkF+bWx8cxC5XLBlNxY0JlebflUZ8fkywm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EgYj0E77gMUkLUZtAHLe2wyJV+kaNloV6ts7TwRICBJS8zx2eUzAJxaTSyEUtsyv/TZo0nbgp22CEWcbnzPGWEyA/JbF9lRHqdkyd8V4p0hbhjqk2NvwURyQ/U3Ot9Ic4bcjkr8OETzyyOER/NP5xPeRIV/H8WS2waZxq2fhfT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPaPVJeM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB4BC4CEFE;
	Thu, 16 Oct 2025 16:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760633831;
	bh=9nG1qjjFGkF+bWx8cxC5XLBlNxY0JlebflUZ8fkywm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BPaPVJeMDDiMn56MKmTwmcPNj3FfxwnTKH4cvu6aPu9GIK19kvYrJKmEafSSvbYOS
	 LAr+saaxEnl8ilxXCke+YwnAFoWvKDVoPSEhfmPHbpKE+ZExVgKHKx3kkb4XBoPGBn
	 eeEmQuR61SB6xBMCB31Uo/EHHZSQZ9XjXqeo9gv21jPv8h7JbeNxi7VwrUCz0hjDSl
	 SrLb1QBe0jro5mIAmEL7xBl6nyv2Yup27dqLuiRdvV2g3rXhHnYhoWvI9jR/08mrMr
	 39qEQo6Lyk9dU4Mz1nOKfSXP/x6U8/hIdO9Tfxta+oTeNi+CezWqx9kGss4c+9az2d
	 ISuTDg1l1N26Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12.y] mptcp: pm: in-kernel: usable client side with C-flag
Date: Thu, 16 Oct 2025 18:56:57 +0200
Message-ID: <20251016165656.940021-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101650-setback-proofs-9687@gregkh>
References: <2025101650-setback-proofs-9687@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6900; i=matttbe@kernel.org; h=from:subject; bh=9nG1qjjFGkF+bWx8cxC5XLBlNxY0JlebflUZ8fkywm8=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI+Kt8U+8NW8sflQffLebXvz20MM44/FF4pd6xpUbztg pKy4OaVHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABO5o8PwT+2hwPo/56/43DCZ knXyz9sfRoLMh4MiJtxfMEHZKWXysT8M/8xWx73bLceYbLx8j1Jt+tPlf1IbD2w9fW77FpYuGcc fZiwA
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
  has been replaced 'pm_netlink.c'. 'patch --merge' managed to apply
  this modified patch without creating any conflicts. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c         |  7 ++++--
 net/mptcp/pm_netlink.c | 50 +++++++++++++++++++++++++++++++++++++++++-
 net/mptcp/protocol.h   |  8 +++++++
 3 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 2c8815daf5b0..1b7541206a70 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -226,9 +226,12 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
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
index 463c2e7956d5..8d5406515c30 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -674,10 +674,12 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 	struct mptcp_addr_info mpc_addr;
 	struct pm_nl_pernet *pernet;
 	unsigned int subflows_max;
+	bool c_flag_case;
 	int i = 0;
 
 	pernet = pm_nl_get_pernet_from_msk(msk);
 	subflows_max = mptcp_pm_get_subflows_max(msk);
+	c_flag_case = remote->id && mptcp_pm_add_addr_c_flag_case(msk);
 
 	mptcp_local_address((struct sock_common *)msk, &mpc_addr);
 
@@ -690,12 +692,27 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 			continue;
 
 		if (msk->pm.subflows < subflows_max) {
+			bool is_id0;
+
 			locals[i].addr = entry->addr;
 			locals[i].flags = entry->flags;
 			locals[i].ifindex = entry->ifindex;
 
+			is_id0 = mptcp_addresses_equal(&locals[i].addr,
+						       &mpc_addr,
+						       locals[i].addr.port);
+
+			if (c_flag_case &&
+			    (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)) {
+				__clear_bit(locals[i].addr.id,
+					    msk->pm.id_avail_bitmap);
+
+				if (!is_id0)
+					msk->pm.local_addr_used++;
+			}
+
 			/* Special case for ID0: set the correct ID */
-			if (mptcp_addresses_equal(&locals[i].addr, &mpc_addr, locals[i].addr.port))
+			if (is_id0)
 				locals[i].addr.id = 0;
 
 			msk->pm.subflows++;
@@ -704,6 +721,37 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
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
+			struct mptcp_pm_local *local = &locals[i];
+
+			if (!select_local_address(pernet, msk, local))
+				break;
+
+			__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
+
+			if (!mptcp_pm_addr_families_match(sk, &local->addr,
+							  remote))
+				continue;
+
+			if (mptcp_addresses_equal(&local->addr, &mpc_addr,
+						  local->addr.port))
+				continue;
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
index 6f191b125978..9653fee227ab 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1172,6 +1172,14 @@ static inline void mptcp_pm_close_subflow(struct mptcp_sock *msk)
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
 void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk);
 
 static inline struct mptcp_ext *mptcp_get_ext(const struct sk_buff *skb)
-- 
2.51.0



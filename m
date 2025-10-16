Return-Path: <stable+bounces-186132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB71BE3ACC
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 15:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD25D5039EB
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 13:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1A83168F6;
	Thu, 16 Oct 2025 13:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wEd4dTHk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBDD1F1505
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 13:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760620973; cv=none; b=gLbFSr1FdGzY0lxV0pTHI6Kgg8KfgxHL8dZh4ws6q+V+PhjEfUaOLBNqjwD2/tdFK7kP5fptv6N+Kz3uwr0/KJ7r0nkvNkKxU1C50m+tPkBI43FrlOZ2omg2jhWcCubqFeL9dWVRCdEUvYahulMXNiKEuj1QKck8HeW2U6iUHMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760620973; c=relaxed/simple;
	bh=7qRUPWPdlKuhNBCS3N89xb/ht+DveNfdnm0JJBNuKJo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=N/iIqntXDL+NwOsWhqJYgGBHV+kTB6+9GMDWY58O2lkEkj7HcRdDyIWfibBGTKNaOeoFo9VseEOUKJng6ona2latzHi45wMjY/JWqHy+pQU1xvGzmlAlgNvX9AclZsBo5v/jZ6thqwLCwQcXANAIyMGrLpB8fLb/jiN7obxT5ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wEd4dTHk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5378EC4CEF1;
	Thu, 16 Oct 2025 13:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760620973;
	bh=7qRUPWPdlKuhNBCS3N89xb/ht+DveNfdnm0JJBNuKJo=;
	h=Subject:To:Cc:From:Date:From;
	b=wEd4dTHkT71ftLQuNqBIuypPMXRPJIq6uIvYJGsQrdhPK7xGX3rll6g8L0xfdzGM1
	 +Sa0jBL8VyLb/xxSOPYh79j/e6Od7RFFGi9sS2GFm1EGrl96++giyQnGAp77wtA6er
	 uOpLOjW0j5oVi1KZqqLn8coVi0TgE9BFe9ahT/zc=
Subject: FAILED: patch "[PATCH] mptcp: pm: in-kernel: usable client side with C-flag" failed to apply to 6.6-stable tree
To: matttbe@kernel.org,geliang@kernel.org,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 15:19:56 +0200
Message-ID: <2025101656-earthly-womanhood-2b05@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 4b1ff850e0c1aacc23e923ed22989b827b9808f9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101656-earthly-womanhood-2b05@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4b1ff850e0c1aacc23e923ed22989b827b9808f9 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 25 Sep 2025 12:32:36 +0200
Subject: [PATCH] mptcp: pm: in-kernel: usable client side with C-flag

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

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 204e1f61212e..584cab90aa6e 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -637,9 +637,12 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
 		} else {
 			__MPTCP_INC_STATS(sock_net((struct sock *)msk), MPTCP_MIB_ADDADDRDROP);
 		}
-	/* id0 should not have a different address */
+	/* - id0 should not have a different address
+	 * - special case for C-flag: linked to fill_local_addresses_vec()
+	 */
 	} else if ((addr->id == 0 && !mptcp_pm_is_init_remote_addr(msk, addr)) ||
-		   (addr->id > 0 && !READ_ONCE(pm->accept_addr))) {
+		   (addr->id > 0 && !READ_ONCE(pm->accept_addr) &&
+		    !mptcp_pm_add_addr_c_flag_case(msk))) {
 		mptcp_pm_announce_addr(msk, addr, true);
 		mptcp_pm_add_addr_send_ack(msk);
 	} else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED)) {
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 667803d72b64..8c46493a0835 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -389,10 +389,12 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 	struct mptcp_addr_info mpc_addr;
 	struct pm_nl_pernet *pernet;
 	unsigned int subflows_max;
+	bool c_flag_case;
 	int i = 0;
 
 	pernet = pm_nl_get_pernet_from_msk(msk);
 	subflows_max = mptcp_pm_get_subflows_max(msk);
+	c_flag_case = remote->id && mptcp_pm_add_addr_c_flag_case(msk);
 
 	mptcp_local_address((struct sock_common *)msk, &mpc_addr);
 
@@ -405,12 +407,27 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
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
@@ -419,6 +436,37 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
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
index a1787a1344ac..cbe54331e5c7 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1199,6 +1199,14 @@ static inline void mptcp_pm_close_subflow(struct mptcp_sock *msk)
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



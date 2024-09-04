Return-Path: <stable+bounces-73015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D411096B9B2
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 13:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04D6A1C20DFE
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 11:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521971CF7C0;
	Wed,  4 Sep 2024 11:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQHEBc0a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED4C126C01;
	Wed,  4 Sep 2024 11:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448240; cv=none; b=QU0r+DK/EkeWOjUT///Wd+rGwjWGEp1hWDWVGJh9kC/XFy3Ws9bxyoF1urUFV65v9oCIk+yinbb2wU1Cn4X39hMAOJzt+jXYuOgUCujsKyE+4RogRU9hpb4M7uvNN4No+zlUBw6si2eqqmoFM8DDdfr8r5Q+X55sX9LDCZOSGzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448240; c=relaxed/simple;
	bh=60UQ/qv3E4YaQme4Saw2IeaL/cRTmz0VTvWAsVq+B+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQvYHTyF2P4bnUYhAhejanLfkhkw4EtdoqkunhzmiueKqU8at0NhiYNufP6XFme+723s+4J2Vx/MnBm82DF5J1kTLJsor/X3umcoWggPzmgY3xaq7h7xhm9f9JzsJ9+R0Xy4Ae2dDdELU8tOAxCDRvOYUrJLjUdzXahKRYKBBNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQHEBc0a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08789C4CEC2;
	Wed,  4 Sep 2024 11:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725448239;
	bh=60UQ/qv3E4YaQme4Saw2IeaL/cRTmz0VTvWAsVq+B+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GQHEBc0ahddtRtMo/YrJ+zP7r23EuRq6lOmeQtKJK2NV7rbQ2KoEJ5zJSdK2uC1fF
	 rEpTukp5GmqfAHKNUYXaDzU4K8wBesD7hcNRzqJrp+6j862bbzBN5uA0Gi0oA//hVO
	 rRFKXIO9yGXoQG/HDzDYfa3wpZinakZpCRBvb3xRojk9L3Dx74t3ORUaSObJklSYPF
	 5mlEbZMVgTXaLLysFzd4T2THnGP6sfavrSeNwCghI1zW5d5nW+Zv+BpccAmcJ1a+j/
	 5ZwOGArVyFJ131NaHoeGwfdo8AKNsNVsU0AL4/l0XOTzq1VySKZedCCo4f7gXG7QM7
	 wis4xcrfb8HBw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.1.y 2/2] mptcp: pm: fix RM_ADDR ID for the initial subflow
Date: Wed,  4 Sep 2024 13:10:16 +0200
Message-ID: <20240904111014.4091498-4-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240904111014.4091498-3-matttbe@kernel.org>
References: <2024083045-mosaic-sniff-fe02@gregkh>
 <20240904111014.4091498-3-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5228; i=matttbe@kernel.org; h=from:subject; bh=60UQ/qv3E4YaQme4Saw2IeaL/cRTmz0VTvWAsVq+B+E=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2EAWUFsKAR4hOYPDQnDTyH4vxCYAh2VxVU7ey 8M2j/qlMjGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZthAFgAKCRD2t4JPQmmg c2W0EACD/gQDz9rmSayJBgJOC4qgNpquMJ0Km5c3N6EYE1KAVE9uYs9jGDDUOvRsKCAG/RmeYBi 7r9P+IITf6zaKObjOMRG18RKtULZn2nYoXvdAcBQ6WH2OFaMnlONz4sMrG10bPRZLLB0NdoOsil jKsXbfXHlOmn4f9Wv8UNJJrcOhxj2S2qq6q5Y25l2vHAzIpWIUxrGKaxQsTy9GicNxJqWQCTH58 KQoiMkEhqMZZ+6b6KXCq7wBiU9bl29Egippvlo/7u85sm9bNsiQVwBGuM0OnOezQm8iIxVFbwT7 orEjcyJjn737+1Tu/LxJJZ+Roqp51RGhtBMkXZfCJOJ6IXmIZbO58ywdC9ALN5uhO9DbR7X9PsE yZS2l7un4Ms2d6jP3EvJb0sevkd3PjDWl6SDuaR8OYYVicTYhsZhmzM6Hw1qVmY+x/5ZMz1/Smj //VA+StFf1hPGOfziq7IuE4AcoyR0ecUDun6ZtH4aRz7iA2GHi5YnsSbpduOZOS99m41n0uhjai y+Ahix/dsmCMavHw7R1WIm6uBnc9kYl5qxslZxaYTIOlo1DgouZPfr8zBaMIi+aG/Wb6zro35un XNVMw4kzzrQGGXMix4BzrfQGMyFHkw21rAAvz26MCtstGrB3jkVD/2EAfMie6HrvH2g/BoaHC/Y 4tC6Ss4N9vfTJPw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit 87b5896f3f7848130095656739b05881904e2697 upstream.

The initial subflow has a special local ID: 0. When an endpoint is being
deleted, it is then important to check if its address is not linked to
the initial subflow to send the right ID.

If there was an endpoint linked to the initial subflow, msk's
mpc_endpoint_id field will be set. We can then use this info when an
endpoint is being removed to see if it is linked to the initial subflow.

So now, the correct IDs are passed to mptcp_pm_nl_rm_addr_or_subflow(),
it is no longer needed to use mptcp_local_id_match().

Fixes: 3ad14f54bd74 ("mptcp: more accurate MPC endpoint tracking")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 46e61130a514..f001e1547402 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -826,11 +826,6 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 	return -EINVAL;
 }
 
-static bool mptcp_local_id_match(const struct mptcp_sock *msk, u8 local_id, u8 id)
-{
-	return local_id == id || (!local_id && msk->mpc_endpoint_id == id);
-}
-
 static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 					   const struct mptcp_rm_list *rm_list,
 					   enum linux_mptcp_mib_field rm_type)
@@ -867,7 +862,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 				continue;
 			if (rm_type == MPTCP_MIB_RMADDR && remote_id != rm_id)
 				continue;
-			if (rm_type == MPTCP_MIB_RMSUBFLOW && !mptcp_local_id_match(msk, id, rm_id))
+			if (rm_type == MPTCP_MIB_RMSUBFLOW && id != rm_id)
 				continue;
 
 			pr_debug(" -> %s rm_list_ids[%d]=%u local_id=%u remote_id=%u mpc_id=%u\n",
@@ -1501,6 +1496,12 @@ static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
 	return false;
 }
 
+static u8 mptcp_endp_get_local_id(struct mptcp_sock *msk,
+				  const struct mptcp_addr_info *addr)
+{
+	return msk->mpc_endpoint_id == addr->id ? 0 : addr->id;
+}
+
 static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 				      const struct mptcp_addr_info *addr,
 				      bool force)
@@ -1508,7 +1509,7 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 	struct mptcp_rm_list list = { .nr = 0 };
 	bool ret;
 
-	list.ids[list.nr++] = addr->id;
+	list.ids[list.nr++] = mptcp_endp_get_local_id(msk, addr);
 
 	ret = remove_anno_list_by_saddr(msk, addr);
 	if (ret || force) {
@@ -1535,14 +1536,12 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 						   const struct mptcp_pm_addr_entry *entry)
 {
 	const struct mptcp_addr_info *addr = &entry->addr;
-	struct mptcp_rm_list list = { .nr = 0 };
+	struct mptcp_rm_list list = { .nr = 1 };
 	long s_slot = 0, s_num = 0;
 	struct mptcp_sock *msk;
 
 	pr_debug("remove_id=%d\n", addr->id);
 
-	list.ids[list.nr++] = addr->id;
-
 	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
 		struct sock *sk = (struct sock *)msk;
 		bool remove_subflow;
@@ -1560,6 +1559,7 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow &&
 					  !(entry->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT));
 
+		list.ids[0] = mptcp_endp_get_local_id(msk, addr);
 		if (remove_subflow) {
 			spin_lock_bh(&msk->pm.lock);
 			mptcp_pm_nl_rm_subflow_received(msk, &list);
@@ -1668,6 +1668,7 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
+/* Called from the userspace PM only */
 void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
 {
 	struct mptcp_rm_list alist = { .nr = 0 };
@@ -1696,6 +1697,7 @@ void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
 	}
 }
 
+/* Called from the in-kernel PM only */
 static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					       struct list_head *rm_list)
 {
@@ -1705,11 +1707,11 @@ static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 	list_for_each_entry(entry, rm_list, list) {
 		if (slist.nr < MPTCP_RM_IDS_MAX &&
 		    lookup_subflow_by_saddr(&msk->conn_list, &entry->addr))
-			slist.ids[slist.nr++] = entry->addr.id;
+			slist.ids[slist.nr++] = mptcp_endp_get_local_id(msk, &entry->addr);
 
 		if (alist.nr < MPTCP_RM_IDS_MAX &&
 		    remove_anno_list_by_saddr(msk, &entry->addr))
-			alist.ids[alist.nr++] = entry->addr.id;
+			alist.ids[alist.nr++] = mptcp_endp_get_local_id(msk, &entry->addr);
 	}
 
 	spin_lock_bh(&msk->pm.lock);
@@ -1997,7 +1999,7 @@ static void mptcp_pm_nl_fullmesh(struct mptcp_sock *msk,
 {
 	struct mptcp_rm_list list = { .nr = 0 };
 
-	list.ids[list.nr++] = addr->id;
+	list.ids[list.nr++] = mptcp_endp_get_local_id(msk, addr);
 
 	spin_lock_bh(&msk->pm.lock);
 	mptcp_pm_nl_rm_subflow_received(msk, &list);
-- 
2.45.2



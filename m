Return-Path: <stable+bounces-73735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA44C96EE23
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 10:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 857B8283EEF
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 08:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5B915747A;
	Fri,  6 Sep 2024 08:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVTdLu1N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4A115624B;
	Fri,  6 Sep 2024 08:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725611540; cv=none; b=eHO27UWugKVlJmLckfZrB3+Cw+ZkdhuWTMXY1E0BAxRvgJE8pqqJfBDbQfqn/i8j4xrlg/usJFDx8t6+ttI+EYSw9UTPnRNdFU99y9WylMn+Z2l8NR0Fxmc+Hk65OesXgHRoh++aFtFX9yN+hGW/rxLwBvtCrYf8aSNX6G5CVCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725611540; c=relaxed/simple;
	bh=PtjllL95pepJhsbLp8A+NwkIx84YAYLPw+/6n1mRNe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WcNl6RW9vUYTeNjYZMerwn9KQEIvZcYX1bmaGsEdpKxnEVyjgtEa+7OWE7LQBFPSn125P0+VYKkTtfkT3QPzM1FaNalUtg4i8tQlG5hCEDC5wi6IwTLfm76EaDVMwP2nqn10wmHCpYNt6LxAHxVDn5+d3/cUxjyFoMyfm2dXkf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVTdLu1N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C09EC4CEC5;
	Fri,  6 Sep 2024 08:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725611540;
	bh=PtjllL95pepJhsbLp8A+NwkIx84YAYLPw+/6n1mRNe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZVTdLu1Nm3CpzHxgC7OofPnhyWcUFmg/gQWb8rGU3grr2mBXHduyG8g9N28DnX1eo
	 xvyJQIasja7UZKbX6jhSbcx3cmGVa99kh6J6XudHrXES5zqZYTgbBv8cWkiyDIMsJp
	 4npm55g3nTLnOATHyU9HkSeSLYhdTLYG/tsdrFNZaDLigUqIPQVWyANaRYJa/70kQ8
	 vTlres2yErDTPDFUXJv2kEWCXV9BqegmeVvpFWeZredUAuuxG9LJ7WbQ6b+7lDY3Xe
	 tRSCQulJSy3mNFm2VnZM5re6HL6bdIP4RgtJbBXtIAREX1/sqCzi5znlVoN2v3O8YH
	 K8XgPbbhvKWqg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y 2/2] mptcp: pm: avoid possible UaF when selecting endp
Date: Fri,  6 Sep 2024 10:31:53 +0200
Message-ID: <20240906083151.1768557-4-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240906083151.1768557-3-matttbe@kernel.org>
References: <2024082657-dealer-troubling-1332@gregkh>
 <20240906083151.1768557-3-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5612; i=matttbe@kernel.org; h=from:subject; bh=PtjllL95pepJhsbLp8A+NwkIx84YAYLPw+/6n1mRNe4=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2r33RQaZhdkPSsmN1r7hCL8631G7dLDBl982B kFGbr/qsneJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtq99wAKCRD2t4JPQmmg c1iyD/9EYHYWp2TDpjp/XoTlsy2bzT0iTrxiBHa+ksR4T3oYZXOiO0wdLBM9JN6AmbHc/UG0sFT PNGQ6Ozs/6HyZxIsNA0dJlScmjUU2BNfxHv81eyY8Wlr8BpxWEScKlvRvs0Ywer2Nldek7UZf6J +epIfkGYQu09gdLc8w0IqhsM0CdtZGNq30V6DWbwCw3yZfh5m35cFxJ8P01TlvlqWgOykAExVQh siBUV+wPE4AOXFQ5zbknTy84BhMCgb+dYj8HsYwZU+94A4XP3f4Z3CutGt7iBuVHtDAJUu2PvOW GlB4M62H48DGyI9900UNqNFNAo8hsT7xzLws3Mr+a8bUEKLO+qKOZqlQ0RZdSFgoXB7V7QJm6rV Hy0FWVBju/SagxeI6MEqQayUioYW8rQtPBcv2xEvdnO2bkEYrXBROiNqlksOVv7P0C2q0/pWwb3 hUTT8/6sv84cwOJyd2YNiZJDque2eyMPazq61SPSTX/luVFf69MncPysIku1Djgy40iXUUDVukm MmB08b+AOWfWKqebBh5zQWq7QMwyS1eNqKAjwyq1zGJLoGnEQmKTHnYhHex6sizyAiWBtTy0nbu uJy8JqhzZYow4M1vEz20pcc4EQuP87pxTLKGt079OOXiU45795JAXky6zYYIdCs6QtPxtLDRP2I 3wJKLiRob/5AsqQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit 48e50dcbcbaaf713d82bf2da5c16aeced94ad07d upstream.

select_local_address() and select_signal_address() both select an
endpoint entry from the list inside an RCU protected section, but return
a reference to it, to be read later on. If the entry is dereferenced
after the RCU unlock, reading info could cause a Use-after-Free.

A simple solution is to copy the required info while inside the RCU
protected section to avoid any risk of UaF later. The address ID might
need to be modified later to handle the ID0 case later, so a copy seems
OK to deal with.

Reported-by: Paolo Abeni <pabeni@redhat.com>
Closes: https://lore.kernel.org/45cd30d3-7710-491c-ae4d-a1368c00beb1@redhat.com
Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240819-net-mptcp-pm-reusing-id-v1-14-38035d40de5b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in pm_netlink.c, because quite a bit of new code has been
  added around since commit 86e39e04482b ("mptcp: keep track of local
  endpoint still available for each msk"). But the issue is still there.
  The conflicts have been resolved using the same way: by adding a new
  parameter to select_local_address() and select_signal_address(), and
  use it instead of the pointer they were previously returning. The code
  is simpler in this version, this conflict resolution looks safe. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 47 +++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 1a9f98c9c0ae..1e842e15f612 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -158,12 +158,14 @@ static bool lookup_subflow_by_daddr(const struct list_head *list,
 	return false;
 }
 
-static struct mptcp_pm_addr_entry *
+static bool
 select_local_address(const struct pm_nl_pernet *pernet,
-		     struct mptcp_sock *msk)
+		     struct mptcp_sock *msk,
+		     struct mptcp_pm_addr_entry *new_entry)
 {
 	const struct sock *sk = (const struct sock *)msk;
-	struct mptcp_pm_addr_entry *entry, *ret = NULL;
+	struct mptcp_pm_addr_entry *entry;
+	bool found = false;
 
 	msk_owned_by_me(msk);
 
@@ -187,18 +189,22 @@ select_local_address(const struct pm_nl_pernet *pernet,
 		 * pending join
 		 */
 		if (!lookup_subflow_by_saddr(&msk->conn_list, &entry->addr)) {
-			ret = entry;
+			*new_entry = *entry;
+			found = true;
 			break;
 		}
 	}
 	rcu_read_unlock();
-	return ret;
+
+	return found;
 }
 
-static struct mptcp_pm_addr_entry *
-select_signal_address(struct pm_nl_pernet *pernet, unsigned int pos)
+static bool
+select_signal_address(struct pm_nl_pernet *pernet, unsigned int pos,
+		      struct mptcp_pm_addr_entry *new_entry)
 {
-	struct mptcp_pm_addr_entry *entry, *ret = NULL;
+	struct mptcp_pm_addr_entry *entry;
+	bool found = false;
 	int i = 0;
 
 	rcu_read_lock();
@@ -211,12 +217,14 @@ select_signal_address(struct pm_nl_pernet *pernet, unsigned int pos)
 		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
 			continue;
 		if (i++ == pos) {
-			ret = entry;
+			*new_entry = *entry;
+			found = true;
 			break;
 		}
 	}
 	rcu_read_unlock();
-	return ret;
+
+	return found;
 }
 
 unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk)
@@ -474,7 +482,7 @@ __lookup_addr(struct pm_nl_pernet *pernet, struct mptcp_addr_info *info)
 static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 {
 	struct sock *sk = (struct sock *)msk;
-	struct mptcp_pm_addr_entry *local;
+	struct mptcp_pm_addr_entry local;
 	unsigned int add_addr_signal_max;
 	unsigned int local_addr_max;
 	struct pm_nl_pernet *pernet;
@@ -493,13 +501,11 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 	/* check first for announce */
 	if (msk->pm.add_addr_signaled < add_addr_signal_max) {
-		local = select_signal_address(pernet,
-					      msk->pm.add_addr_signaled);
-
-		if (local) {
-			if (mptcp_pm_alloc_anno_list(msk, local)) {
+		if (select_signal_address(pernet, msk->pm.add_addr_signaled,
+					  &local)) {
+			if (mptcp_pm_alloc_anno_list(msk, &local)) {
 				msk->pm.add_addr_signaled++;
-				mptcp_pm_announce_addr(msk, &local->addr, false);
+				mptcp_pm_announce_addr(msk, &local.addr, false);
 				mptcp_pm_nl_addr_send_ack(msk);
 			}
 		} else {
@@ -514,9 +520,8 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 	if (msk->pm.local_addr_used < local_addr_max &&
 	    msk->pm.subflows < subflows_max &&
 	    !READ_ONCE(msk->pm.remote_deny_join_id0)) {
-		local = select_local_address(pernet, msk);
-		if (local) {
-			bool fullmesh = !!(local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
+		if (select_local_address(pernet, msk, &local)) {
+			bool fullmesh = !!(local.flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
 			struct mptcp_addr_info addrs[MPTCP_PM_ADDR_MAX];
 			int i, nr;
 
@@ -525,7 +530,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 			nr = fill_remote_addresses_vec(msk, fullmesh, addrs);
 			spin_unlock_bh(&msk->pm.lock);
 			for (i = 0; i < nr; i++)
-				__mptcp_subflow_connect(sk, &local->addr, &addrs[i]);
+				__mptcp_subflow_connect(sk, &local.addr, &addrs[i]);
 			spin_lock_bh(&msk->pm.lock);
 			return;
 		}
-- 
2.45.2



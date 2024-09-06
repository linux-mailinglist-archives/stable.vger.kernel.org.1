Return-Path: <stable+bounces-73752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE02196EF03
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 11:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16DFAB208EB
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 09:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF4218892A;
	Fri,  6 Sep 2024 09:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RiHHA9+4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE09A1459FD;
	Fri,  6 Sep 2024 09:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725614549; cv=none; b=nIVwblUNYDB7dJRdxlYRdG9UdWIXd5FwK+N0VSKIXik7ABycjbB4ao8Y6Pq8OdbiRK+5aIo1rYH1EEkNMcVvx/MQBkgsnSZBEJUdF/BYnX+nxEO1B4mVHqePuPCzjFtWfQxIqX0gCdPK+P28QZKGT3YOSvtQgdOfaccvKSXaXf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725614549; c=relaxed/simple;
	bh=RFEywIVAJoTTG/a7ADoSCEliwGRzNjiGhHJjoveXyz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dIpR9OnYpVlzUGCI7mDyQ+xLzGmI2Btm73B2c2DxSNpQRIqbu5IpoE6IhEOa6oXzHrhPULqkgFATXkaR7QGK0JSOiHoHjK2orxj+hxxWTqjE4yEDMmm7QViyVSJeoFeOUOJdTRJIuYPo5pCKuWHd/G0PKhe1Z8odtLAmM9YImRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RiHHA9+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C3AC4CEC4;
	Fri,  6 Sep 2024 09:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725614548;
	bh=RFEywIVAJoTTG/a7ADoSCEliwGRzNjiGhHJjoveXyz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RiHHA9+48GKNAM966SUgKbu34JdXCyiQfGS0D1cKNeSfNDg5N5eitVm6ZTXxbbfJp
	 XGmcJ7HgR3hNyBFx/VLzMV4Wo/wVv+qO2gWgzwPZacBbO8tfET2gnE0iAAjbgFF/wg
	 EM5BRmW8l6rP8qKYjNF6cwZU4BM/2rCZK9MWpQB8S3IFXVdJOrY0+3atTkGiaGpUpu
	 AOtKx2aInwBsRVqQKECxnbCTWS3sxO+wsCTu3DzOS2bDR0btf5jP+i66mMzn2La7cQ
	 8bUPk1klADgDR+uKdk9F8oLiPRkSqTn0fV+4xUk58RcLO/SEUEefx5Fz3ssx3yFk/2
	 9BfhiQTyipTrA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10.y] mptcp: pm: avoid possible UaF when selecting endp
Date: Fri,  6 Sep 2024 11:22:23 +0200
Message-ID: <20240906092222.1930688-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024082658-pectin-freeness-1354@gregkh>
References: <2024082658-pectin-freeness-1354@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5433; i=matttbe@kernel.org; h=from:subject; bh=RFEywIVAJoTTG/a7ADoSCEliwGRzNjiGhHJjoveXyz8=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2snOYUu/8pNi+Q8otzaTZ189X4rO8xd/Po9ae Z4Rr76OXhWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtrJzgAKCRD2t4JPQmmg c3FpEACAHfJptqDBEeUK1Y7v3bmCF9v498fETVDW7PAbZpfpLB3YL0NglyUTivP1XpF97hxDxcE NQPBjsQQZh05d7xtGT1jW0n/hlawD/p7+GuIxz5VzY5GpnaxqaNZNiTsmiJv1Zh84pHrdoii7ck +S4OF/4axztDToOr1YBwApgW5Zq3ftHztRJTIZsHokm+kQGiRElt/6yXFWOIDzp8YrZFIV5IDag tU3amN5ND9L7lWi0mcTfX/iWsHJkh4p+nKMhKsqE8XgX4bLJ/IS2jOkIvdOeQKjxEOrlwtkWPdO G5DuWeEAC24Zs9g3lWpyQuxGm6JleCX1HQ5dUhq+V5DI8E3FBU7ppNop0oKyXOuhTt/Oxw7Lv54 79IsQZaGsiD9vJqtMq6bvugLAW+0vGTPBDTM1P4SHAROlgGslaX/tS06nJhVJDZqq1KkC5undF7 ZhfJ5vh9QPYr0jb6TVYYxs0YPC4/7UyqKMvXj8FTynqArDocLz2A+n680O7YPfcThWP+p9pEGhk TtMGrML3SiKcDE2fU57KN7eicpapMtfZe9KTM1UJ3GGwwpd16nR2fau4VzgFTOVr+FxXKhDVBq0 lBEVvd9g87UHlWB9OmMnZOOCbi/4WlEU1Nn7sevQIBMB8zwYcIvJlWahPDuneGPEhl7nGQnK4kP K2PfGudAQyHRg4Q==
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
  endpoint still available for each msk"), and commit 2843ff6f36db
  ("mptcp: remote addresses fullmesh"). But the issue is still there.
  The conflicts have been resolved using the same way: by adding a new
  parameter to select_local_address() and select_signal_address(), and
  use it instead of the pointer they were previously returning. The code
  is simpler in this version, this conflict resolution looks safe. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 45 +++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ca57d856d5df..a73135e720d3 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -127,11 +127,13 @@ static bool lookup_subflow_by_saddr(const struct list_head *list,
 	return false;
 }
 
-static struct mptcp_pm_addr_entry *
+static bool
 select_local_address(const struct pm_nl_pernet *pernet,
-		     struct mptcp_sock *msk)
+		     struct mptcp_sock *msk,
+		     struct mptcp_pm_addr_entry *new_entry)
 {
-	struct mptcp_pm_addr_entry *entry, *ret = NULL;
+	struct mptcp_pm_addr_entry *entry;
+	bool found = false;
 
 	rcu_read_lock();
 	spin_lock_bh(&msk->join_list_lock);
@@ -145,19 +147,23 @@ select_local_address(const struct pm_nl_pernet *pernet,
 		if (entry->addr.family == ((struct sock *)msk)->sk_family &&
 		    !lookup_subflow_by_saddr(&msk->conn_list, &entry->addr) &&
 		    !lookup_subflow_by_saddr(&msk->join_list, &entry->addr)) {
-			ret = entry;
+			*new_entry = *entry;
+			found = true;
 			break;
 		}
 	}
 	spin_unlock_bh(&msk->join_list_lock);
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
@@ -170,12 +176,14 @@ select_signal_address(struct pm_nl_pernet *pernet, unsigned int pos)
 		if (!(entry->addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
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
 
 static void check_work_pending(struct mptcp_sock *msk)
@@ -305,7 +313,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 {
 	struct mptcp_addr_info remote = { 0 };
 	struct sock *sk = (struct sock *)msk;
-	struct mptcp_pm_addr_entry *local;
+	struct mptcp_pm_addr_entry local;
 	struct pm_nl_pernet *pernet;
 
 	pernet = net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
@@ -317,13 +325,11 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 	/* check first for announce */
 	if (msk->pm.add_addr_signaled < msk->pm.add_addr_signal_max) {
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
 			}
 		} else {
 			/* pick failed, avoid fourther attempts later */
@@ -338,13 +344,12 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 	    msk->pm.subflows < msk->pm.subflows_max) {
 		remote_address((struct sock_common *)sk, &remote);
 
-		local = select_local_address(pernet, msk);
-		if (local) {
+		if (select_local_address(pernet, msk, &local)) {
 			msk->pm.local_addr_used++;
 			msk->pm.subflows++;
 			check_work_pending(msk);
 			spin_unlock_bh(&msk->pm.lock);
-			__mptcp_subflow_connect(sk, &local->addr, &remote);
+			__mptcp_subflow_connect(sk, &local.addr, &remote);
 			spin_lock_bh(&msk->pm.lock);
 			return;
 		}
-- 
2.45.2



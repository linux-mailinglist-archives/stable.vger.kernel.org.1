Return-Path: <stable+bounces-66129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F193694CCEB
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 11:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F797B210C3
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 09:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C50318FDC9;
	Fri,  9 Aug 2024 09:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acynIAkN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5978A18F2E8;
	Fri,  9 Aug 2024 09:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723194452; cv=none; b=KW7c+BPR8t5y9ptiz0MttXu80WvcInK5U+IrMtcuYV6HFd09ZO5nt9Cr8jzwYQO+yBSAE13nMyF70RpLTlkZA2eMMbmgSQC50jJ8iD73JVSXlj6RfZz5WPjB/f29gLwBtwhkBe7IhCEQYZtTD5YV2+kfeZMtUUSbG3qg6IESHYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723194452; c=relaxed/simple;
	bh=xBWzBSFdG8KJk5rTU4wu50DvoCH9o9EbKF3dLQmR2pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ExuI3xruwvge4tUZ3KFbpJmFmjWUi+dcrgdWIj+e5YecIaOo1RdbXXgnDcDqe0dQe+/bk1GKFKUJdK3Z9hj/03LwLvWgpdnijLX2kC01ACz5Zml8jWQKxvtkbh90w4Mnk8lDnPmhtpv/j0pgIi9BTvaneMFD93Ai+h97rZsxfhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acynIAkN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579B0C32782;
	Fri,  9 Aug 2024 09:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723194450;
	bh=xBWzBSFdG8KJk5rTU4wu50DvoCH9o9EbKF3dLQmR2pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=acynIAkNHTyHnDpkLJTVEM5k99O/O3jQflEKmIzjQQZLeY7e+Ul+zro8lizNG+xig
	 ssAHWj2aqfXtyrjStmwTr+rc1SPgPQiTjEcJDC/hXmL8pPaXtT62S/diIS2LSqo2QG
	 1e0lIiQ2I2Mup67S0NDju60a1x0kpJb41nBE8cMNRxGC6sxw5canSrC+18OZuzj0ji
	 SkHTTRL/uI57AqWKdgLTe6mIyrIZgnnOwLCis8yd/bOwgRCCML0shAA0UGzrOgSm2f
	 9DnlzYYDb0BtpAKH/ItldOcnXDFrTpIgmK6IwJ2S43Hz/bDmaQFHeOm0FB1TWF2Nr+
	 cz4SChZdGMHlA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH 5.15.y] mptcp: fix NL PM announced address accounting
Date: Fri,  9 Aug 2024 11:07:22 +0200
Message-ID: <20240809090721.2699120-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024080705-poise-profile-662a@gregkh>
References: <2024080705-poise-profile-662a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2664; i=matttbe@kernel.org; h=from:subject; bh=2LukJ3s7hfw3eKxVyR0NjZ3kjSWxZApEfio15UWPLWY=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmtdxJQsJHffHhhyouj3oKSQKwww7ZjfKqVM4sR c4kI0oHUFSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrXcSQAKCRD2t4JPQmmg c1TKEACRvgzVfaoCyuxPM/UrbuyQAS4StW32PbZH5c70Foy2I92QZrUBqqe1TJYgEyfGaFXQQ7F pjxVGCxvKxw5ZIbr1ct/7V5qOIwQW9ba7mNm2NUGHbFPfg6GtH2uiFFg0uASRSVxmX/BjkKr7Lc 6T6YqJhH42rqAr5CgxKA3nW8+KKfDtV/K35JPJ7fenbO10mlxmrgh9DQ+Vv4484UFUkCJAq9kjO jZZ43ccSDQE5Qv6HnUwaeKZOjpZ7+8YZ5GvjSpbtAEl/8z6z1SPwj1UxvV5oWjjwR8Dye8bKKjS dq2OUNzlxYfMiYb/UofF+9xJkIMaybpNNoxAWYO23rxsnkKd7JwRugynp0KChYsCUbqpVvtwPot GTQ/UNJuxoF6s6LQcTV+y6sBCIxfKn4vxjphaGOwKlby2RIaURdbuODhYMr123SWmBuOm1PBynM w9eUv2N+Y8Xakihvr4Y3dXC7JJm6mDnzwOmr8VOIrCHlVfBh/W5hZHtZny6SRRpEzm+3SIOdCui ija4DIGtsx+CawLpRezYE4xP+jZpZ8FgZHhkeCqjBOMrecx4w93ozJc5pl3vUNaESlA7UsQR5q0 Eoj1WQFk9cI3NcFWgsNsvPEPQSf8HoRsdO7aK3yD4no6w7PJ39/FSNbtSrk35qwcCP9FhCFT0/z m1Gf+Grd9yOww5Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

commit 4b317e0eb287bd30a1b329513531157c25e8b692 upstream.

Currently the per connection announced address counter is never
decreased. As a consequence, after connection establishment, if
the NL PM deletes an endpoint and adds a new/different one, no
additional subflow is created for the new endpoint even if the
current limits allow that.

Address the issue properly updating the signaled address counter
every time the NL PM removes such addresses.

Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
[ Conflicts in pm_netlink.c, because the commit 6fa0174a7c86 ("mptcp:
  more careful RM_ADDR generation") is not in this version. The
  conditions are slightly different, but the same fix can be applied:
  first checking the IDs, then removing the address. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 7b312aa03e6b..1d64c9fed39e 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1323,6 +1323,7 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 	ret = remove_anno_list_by_saddr(msk, addr);
 	if (ret || force) {
 		spin_lock_bh(&msk->pm.lock);
+		msk->pm.add_addr_signaled -= ret;
 		mptcp_pm_remove_addr(msk, &list);
 		spin_unlock_bh(&msk->pm.lock);
 	}
@@ -1462,19 +1463,20 @@ static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 	struct mptcp_pm_addr_entry *entry;
 
 	list_for_each_entry(entry, rm_list, list) {
-		if (lookup_subflow_by_saddr(&msk->conn_list, &entry->addr) &&
-		    alist.nr < MPTCP_RM_IDS_MAX &&
-		    slist.nr < MPTCP_RM_IDS_MAX) {
+		if (alist.nr < MPTCP_RM_IDS_MAX &&
+		    slist.nr < MPTCP_RM_IDS_MAX &&
+		    lookup_subflow_by_saddr(&msk->conn_list, &entry->addr)) {
 			alist.ids[alist.nr++] = entry->addr.id;
 			slist.ids[slist.nr++] = entry->addr.id;
-		} else if (remove_anno_list_by_saddr(msk, &entry->addr) &&
-			 alist.nr < MPTCP_RM_IDS_MAX) {
+		} else if (alist.nr < MPTCP_RM_IDS_MAX &&
+			   remove_anno_list_by_saddr(msk, &entry->addr)) {
 			alist.ids[alist.nr++] = entry->addr.id;
 		}
 	}
 
 	if (alist.nr) {
 		spin_lock_bh(&msk->pm.lock);
+		msk->pm.add_addr_signaled -= alist.nr;
 		mptcp_pm_remove_addr(msk, &alist);
 		spin_unlock_bh(&msk->pm.lock);
 	}
-- 
2.45.2



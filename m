Return-Path: <stable+bounces-66133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7A694CCF5
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 11:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC0471F219F2
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 09:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D674E18FDD9;
	Fri,  9 Aug 2024 09:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVRIuesn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909F8BA41;
	Fri,  9 Aug 2024 09:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723194566; cv=none; b=QfKzVk0KdjUZ8Ol0MvP94x9T/4eQXG/Xv6Om6XmBQZQzYEUuhH0xjy6SXrthBTk6RoPc4T4mEqyTjTh5faLgXolsJVFsUsyW276Z+0wlEkzGNne+GHpeRwmqSmhImmRxF5vkrplvO8SoP6Zfgoaht43T3e2gTm9duJD7rV5Z1oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723194566; c=relaxed/simple;
	bh=p/q++helSr5JUAYBoUBp6Q+TvmnD3wGZqrcbUVrIjYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yhy30wiP1Pb2OKASCCfl7r9d+sSEqCZqrUl/EWg7TijzEuL/ZJ43ujpR81KMCInHm1VbwPdyCAiWeMv8gU8w51M4paw2rVf8h9x6Yt/fFEpXQgClYW4sOrXkDTYBgJrz/R6rNpSgjFeEd1F7XEc6s2+bZhfsHtMEYpuocnPWmrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVRIuesn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37639C32782;
	Fri,  9 Aug 2024 09:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723194565;
	bh=p/q++helSr5JUAYBoUBp6Q+TvmnD3wGZqrcbUVrIjYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tVRIuesntyCZRorNIsOyJDjllvCuFOJ+F27m9OS8t0c/jPDxn3er4BaJBTHYdeeTZ
	 W3o2W1eo10gaiKS+FZfiDZBryUtqhqYrgzhX9RE4+tT89SDlG/snXRt9i0zHToHdEf
	 sjPBdMpY+Czp9Mpq2WB+rpmFW5fn3B1AdQB6JrO2aJVy7x9JUAM65mBRXz5Naj+v/m
	 ojVExtyWYKQDZto6P8F1kfVW7eTiw7c2F4+tw/7lAuxZdb5k7ScaVL4S9UNIUrvtFC
	 TnMdWuKhifpc6zTEnjRne4TQEySwP1vvzr+wy+TMBfHzIcq9YsHXsqhuxDbVbxCMVM
	 fLhG17UVj9Rxg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH 5.15.y 1/2] mptcp: export local_address
Date: Fri,  9 Aug 2024 11:09:13 +0200
Message-ID: <20240809090912.2701580-3-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024080728-steep-scallion-4de3@gregkh>
References: <2024080728-steep-scallion-4de3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4100; i=matttbe@kernel.org; h=from:subject; bh=8DJ/ugfXtJ8F7qCDsBAGcprx8tT27eAnP5Rjm3gZ1Qg=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmtdy43g4coynIy9qApy28fwvDlPtKbcB3nB5ho d5dLNDfUG2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrXcuAAKCRD2t4JPQmmg czStD/92yf2Kz6ZcyRSmd2PdxWLhJpvCyyi68asVV/HDjYsuJ+y4+dj6RR8x5deeWl0chXSi6tZ pVrQWU9RvnWqINk3RwkgC3rLA7pxkVdMuAfvEl5DIBK7JHmgHWmmqO1RDuvJkaAeh6PL1Gd44O5 5mu7ne5V93ZamTBwderx16KRM3Q1Vy7rNAxWgV23QCilBO++0bMtZFRhmBBeNlu1g2eQVv1Ckip 62t6aFsdLOZR6zp0mYKTMUWaCqGrNW81LYRSs8Cm5cTNUcLxjvI1fw/OHf3uFQT4MgrVgEIIfah kQ0M80xcs31GGw5TwQmR+JY632y0j7ahBwMk76rSOFcDL2US0wgF9FE6F+md+e5jSHVFnXI1faP u0Jdo5IEfPAYDtJ0DTgUi+HpN6PelaATcDLn1oW7WihY4/pZ4T1iS2qrYC6jfpysdKqWAdUg7Y9 VNvTp+xOSQFXt1o+lrVJKrW5oKVv/Hmz6EVCMKPU7hkQtuDmcOL8ngzuq7eDT+ZbgzyxIaDspGk R+Lkh1lLcuzvFtajAGJhJm+TProIpduLYRqde8f4AEU9VhQdbEjZ1LcByAz7EWfYNKc+IhzEmjy cozg8xCOWbaAapiKTGhix8yk4TckskUkrQj3JW87gtx2UUtA66DqdwcaHSQWMY1rRoOjK6KEqff qqzcz20yH+qHXlQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

commit dc886bce753cc2cf3c88ec5c7a6880a4e17d65ba upstream.

Rename local_address() with "mptcp_" prefix and export it in protocol.h.

This function will be re-used in the common PM code (pm.c) in the
following commit.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 6834097fc38c ("mptcp: pm: fix backup support in signal endpoints")
[ Conflicts in pm_netlink.c and protocol.h, because the context has
  changed in commit 4638de5aefe5 ("mptcp: handle local addrs announced
  by userspace PMs") which is not in this version. This commit is
  unrelated to this modification. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 15 +++++++--------
 net/mptcp/protocol.h   |  1 +
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 67ece399ef60..37e9ff9b99f6 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -97,8 +97,7 @@ static bool address_zero(const struct mptcp_addr_info *addr)
 	return addresses_equal(addr, &zero, true);
 }
 
-static void local_address(const struct sock_common *skc,
-			  struct mptcp_addr_info *addr)
+void mptcp_local_address(const struct sock_common *skc, struct mptcp_addr_info *addr)
 {
 	addr->family = skc->skc_family;
 	addr->port = htons(skc->skc_num);
@@ -133,7 +132,7 @@ static bool lookup_subflow_by_saddr(const struct list_head *list,
 	list_for_each_entry(subflow, list, node) {
 		skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
 
-		local_address(skc, &cur);
+		mptcp_local_address(skc, &cur);
 		if (addresses_equal(&cur, saddr, saddr->port))
 			return true;
 	}
@@ -286,7 +285,7 @@ bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk)
 	struct mptcp_addr_info saddr;
 	bool ret = false;
 
-	local_address((struct sock_common *)sk, &saddr);
+	mptcp_local_address((struct sock_common *)sk, &saddr);
 
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(entry, &msk->pm.anno_list, list) {
@@ -693,7 +692,7 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 		struct sock *sk = (struct sock *)msk;
 		struct mptcp_addr_info local;
 
-		local_address((struct sock_common *)ssk, &local);
+		mptcp_local_address((struct sock_common *)ssk, &local);
 		if (!addresses_equal(&local, addr, addr->port))
 			continue;
 
@@ -976,8 +975,8 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	/* The 0 ID mapping is defined by the first subflow, copied into the msk
 	 * addr
 	 */
-	local_address((struct sock_common *)msk, &msk_local);
-	local_address((struct sock_common *)skc, &skc_local);
+	mptcp_local_address((struct sock_common *)msk, &msk_local);
+	mptcp_local_address((struct sock_common *)skc, &skc_local);
 	if (addresses_equal(&msk_local, &skc_local, false))
 		return 0;
 
@@ -1388,7 +1387,7 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 		if (list_empty(&msk->conn_list))
 			goto next;
 
-		local_address((struct sock_common *)msk, &msk_local);
+		mptcp_local_address((struct sock_common *)msk, &msk_local);
 		if (!addresses_equal(&msk_local, addr, addr->port))
 			goto next;
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d2e68f5c6288..0f82d75e3d20 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -583,6 +583,7 @@ void mptcp_subflow_send_ack(struct sock *ssk);
 void mptcp_subflow_reset(struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
 struct socket *__mptcp_nmpc_socket(const struct mptcp_sock *msk);
+void mptcp_local_address(const struct sock_common *skc, struct mptcp_addr_info *addr);
 
 /* called with sk socket lock held */
 int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
-- 
2.45.2



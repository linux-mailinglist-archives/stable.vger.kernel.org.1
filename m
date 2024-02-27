Return-Path: <stable+bounces-25276-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0123869E7E
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 19:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D48D1F2C0AF
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 18:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31024F1E6;
	Tue, 27 Feb 2024 18:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUimdH9d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06E6487A5;
	Tue, 27 Feb 2024 18:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709056848; cv=none; b=GiWzOZaxk/U3ilWFfR2NOpqO0aAPy3gSZn6xUVgb1L4B/pYU58zMEyMZD6C+3qFi3uHCsriZE8MUjks/QYUxVDCzNQ7j2azQlZxifB5AD3CqtKu3H+FGF3otJyAkSPLQsi2ax0fmJlR4+20SRnhdoxDDvJYiR4rayoFd1T2t59U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709056848; c=relaxed/simple;
	bh=QL7m/S1rN3FxKliyw2MDsQQ2H3o6k+wOqm75hKDZF2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OPm367diKZekJqcMt3PtfZq4KmdAnh6kMOn0Hv1eqn0uWJ9bhrAb9hEqAQQTwIwy++aM+W674gOc1mj6vxBnsFqfa67TtF6DIIdhI+BhDVl9DOUSH89ZQ+0SwZIut48nSGEvbSsEy+5g843VTUyDo43O4Hc5VDywEDLc5oI1gD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUimdH9d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A26C433F1;
	Tue, 27 Feb 2024 18:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709056848;
	bh=QL7m/S1rN3FxKliyw2MDsQQ2H3o6k+wOqm75hKDZF2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kUimdH9d9OcIK75DjqtGjjfozWyVJZSh2Dtv59VTlcSyME6PIZpU+AMZr+VHQLYur
	 Q1Rczm/IC1AxE6Lx5GZ9ZAqt54+EmQ4s4LuWul0zV+2bPa53g815fN3id3g5DFHVqG
	 zvkcyKwupQWg0tYe52xHfI53R0N4jWR6D65DGJ+6pcZHVrrqGPO43Ky+sPN3f/hwyt
	 BWtQShw77RCn4IInZZtNhKdNLS2SX6Q+bBQ0XoZqWM85iC4P12JJyfgC4LmWGmdXlG
	 UAdeuPa5X6r7BYCgWToC/CU563P0R+07lpzbdEmSKPXOcHYawN9iA2lxlDrHRd/THy
	 0+8eNNfIVY4+Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH 6.1.y] mptcp: fix data races on remote_id
Date: Tue, 27 Feb 2024 19:00:34 +0100
Message-ID: <20240227180033.4028616-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024022642-overjoyed-retying-c027@gregkh>
References: <2024022642-overjoyed-retying-c027@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3735; i=matttbe@kernel.org; h=from:subject; bh=mPhQDX3LAZoVFsPW4pADjWEfZUchI9YG+5S9l3BSZv8=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl3iNBEApK7GMUpvlYUlvltTVcSCSqxc9skKjNh a4pXjEzWGCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZd4jQQAKCRD2t4JPQmmg c/hMD/98ZWMyNnt+b5mc3EKiccIdExYevFTNsomHZluubJwXXfEhAQJ05peTwtwbEFy5wrQvxKO +WihdSqVSLy/p/AOMcRubukqRUVIPi3OJXMUJmQ6/ErD2ETZTTwtqrF9Lt6luMBLvWL/m5tbuM8 1txwLjKbOAp9PfB5nV4mA38201tEYp/SCKfzI6G1EhwroidQvUY+3AvweJXzScExJdpzGP1HEM0 Dkjhz+ybjPkFkMEauTze4mS1ObmUGNjpS/hAJy547IP4JseetS2u8x8vnQivOgSgdS8qTOlaXXE sS6HY1nFVGBKqOxE38i6q5NYdNLrp2IlNojX4ZIhWFNSaWHTKg3bezn5uBeaOjcK3tuE5BpUmRT 46ZQRlK7qLLVeIOTQOXL91Of08FRlujQ4YTD86xYR1tzGxXIN2SCViyzbAGtW3r8eM0A32tLvcv 0Y/akxxfUx33gHZGARtRvlPi0mjwIXt2LMUPPZ/D4t91zpTSRBoyufoxwSreLbbv5zkOvDkuDEZ nJOEIFS5GYEEHrwSB2vf4scAt++co9D81amvRdUmoBcsQtBi5tVf4iCbpllirxpuK5t6GtovVj+ j9VtOCcZlnkdY7mgVCuS5scwB7fiF82ZK43iZqWa9r/5YDHLrSZXpndPC8pAL6RIGntWUlRchGO iZ9sQ26n2YGNVxw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

Similar to the previous patch, address the data race on
remote_id, adding the suitable ONCE annotations.

Fixes: bedee0b56113 ("mptcp: address lookup improvements")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit 967d3c27127e71a10ff5c083583a038606431b61)
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - no conflicts after having applied 'mptcp: fix data races on local_id'
---
 net/mptcp/pm_netlink.c | 8 ++++----
 net/mptcp/subflow.c    | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 3632f4830420..582d0c641ed1 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -449,7 +449,7 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk, bool fullm
 		mptcp_for_each_subflow(msk, subflow) {
 			ssk = mptcp_subflow_tcp_sock(subflow);
 			remote_address((struct sock_common *)ssk, &addrs[i]);
-			addrs[i].id = subflow->remote_id;
+			addrs[i].id = READ_ONCE(subflow->remote_id);
 			if (deny_id0 && !addrs[i].id)
 				continue;
 
@@ -798,18 +798,18 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 
 		mptcp_for_each_subflow_safe(msk, subflow, tmp) {
 			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+			u8 remote_id = READ_ONCE(subflow->remote_id);
 			int how = RCV_SHUTDOWN | SEND_SHUTDOWN;
 			u8 id = subflow_get_local_id(subflow);
 
-			if (rm_type == MPTCP_MIB_RMADDR && subflow->remote_id != rm_id)
+			if (rm_type == MPTCP_MIB_RMADDR && remote_id != rm_id)
 				continue;
 			if (rm_type == MPTCP_MIB_RMSUBFLOW && !mptcp_local_id_match(msk, id, rm_id))
 				continue;
 
 			pr_debug(" -> %s rm_list_ids[%d]=%u local_id=%u remote_id=%u mpc_id=%u",
 				 rm_type == MPTCP_MIB_RMADDR ? "address" : "subflow",
-				 i, rm_id, id, subflow->remote_id,
-				 msk->mpc_endpoint_id);
+				 i, rm_id, id, remote_id, msk->mpc_endpoint_id);
 			spin_unlock_bh(&msk->pm.lock);
 			mptcp_subflow_shutdown(sk, ssk, how);
 
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 83bc438b9825..891c2f4fed08 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -446,7 +446,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 		subflow->backup = mp_opt.backup;
 		subflow->thmac = mp_opt.thmac;
 		subflow->remote_nonce = mp_opt.nonce;
-		subflow->remote_id = mp_opt.join_id;
+		WRITE_ONCE(subflow->remote_id, mp_opt.join_id);
 		pr_debug("subflow=%p, thmac=%llu, remote_nonce=%u backup=%d",
 			 subflow, subflow->thmac, subflow->remote_nonce,
 			 subflow->backup);
@@ -1477,7 +1477,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	pr_debug("msk=%p remote_token=%u local_id=%d remote_id=%d", msk,
 		 remote_token, local_id, remote_id);
 	subflow->remote_token = remote_token;
-	subflow->remote_id = remote_id;
+	WRITE_ONCE(subflow->remote_id, remote_id);
 	subflow->request_join = 1;
 	subflow->request_bkup = !!(flags & MPTCP_PM_ADDR_FLAG_BACKUP);
 	mptcp_info2sockaddr(remote, &addr, ssk->sk_family);
@@ -1874,7 +1874,7 @@ static void subflow_ulp_clone(const struct request_sock *req,
 		new_ctx->mp_join = 1;
 		new_ctx->fully_established = 1;
 		new_ctx->backup = subflow_req->backup;
-		new_ctx->remote_id = subflow_req->remote_id;
+		WRITE_ONCE(new_ctx->remote_id, subflow_req->remote_id);
 		new_ctx->token = subflow_req->token;
 		new_ctx->thmac = subflow_req->thmac;
 
-- 
2.43.0



Return-Path: <stable+bounces-23765-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1F586835A
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 22:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1467D28D961
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 21:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A97131733;
	Mon, 26 Feb 2024 21:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nO5UjIK0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D16712F388;
	Mon, 26 Feb 2024 21:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708984436; cv=none; b=f4cIFQnl1kQIRG1yy565o/5HPs911W/vCrYvroRdZyms0w3EsP8Km8zWugPMX7iRT73cY2vQqnYBOpoYxVLHBDTavVotjLybBJTWETpmlt7czxcI3TD83n2mv8ThV9eX6MTc5zzza5YDhqt7Hw9neXDa9DCuqEZUBWzlE55ATDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708984436; c=relaxed/simple;
	bh=H0xqeMmUTlpvnqmg5ZbhO7nIJ1wIp8RfH0NtMWFhv8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LfwBg+OMUX93qR2N8fpKjSoszKlWlJLhmyrL9+KzsWX0FB6Mc4+oyb7BqF3ZO2WyN8YeT6+ojEKP+mOY98bQNTtnvJr7B0qQnm+0v2+Dg+D4S7UmRsd4HkPhJkGoQxr/wz4vNm/qPfzEagI89JIDlCsJei880H8vdw9B4tjac5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nO5UjIK0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9779C433F1;
	Mon, 26 Feb 2024 21:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708984435;
	bh=H0xqeMmUTlpvnqmg5ZbhO7nIJ1wIp8RfH0NtMWFhv8E=;
	h=From:To:Cc:Subject:Date:From;
	b=nO5UjIK0hLWO0j/EtmMTdb5JFO6LJQwPXKgFBDRNDYBXhEH8uG7RLtSwkrxFYynoc
	 TS/eNKiSBN14PUJKYusdsVDF43nq8AHvR73q1/oYaxFia5x4KK/P6BeifnUhlgIk8f
	 +6B1tz8RxRHQ8ZLdVP6IT2szRk+qKdbdUY8kMt8dcAJwIvPvBpjXewZTAcSH2OdWB9
	 GxFXMmAwMTlIlAHo3Sm3HmmAjUVTZrHGQt+tdrxmdTpPPknf0ayo/aPeD916oXEQVp
	 yfcg367P+UiawLUOKWgpk/WszoICUvnzi3/P24RJ5YhKNyDeIoECveU//Tv9RSvHwb
	 M44+VU8/Ut1pQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y] mptcp: userspace pm send RM_ADDR for ID 0
Date: Mon, 26 Feb 2024 22:53:41 +0100
Message-ID: <20240226215340.754643-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3044; i=matttbe@kernel.org; h=from:subject; bh=l7j+seLWv/Q8Ta7O5Ovz/FXvgptMfkEPDokjdLwaqPk=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl3Qhk7G2oOI0clT7nb2EE6j8S7qEztdGPp569Q 0bDp5y97mqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZd0IZAAKCRD2t4JPQmmg c8OKD/4z2HCtod8v6OElzmg0uXAOThn8mxCUbBhn4OEsgS2wIz/p2CKXr9EAT/788e2HlEltvXZ 4toXzEbRLvXI/MSzxfn+baywccDRf/Fgk4dNgjIhmQJI9JZ+OS/RgDZgV7KwAJ87TTJQ01LSElH EHXr1kOaycnOc3JvgnCWO2lNuBQowH8R9WECBq5QG5VMnOzLwOFp2hF1UYUTIEK5tvG3XEPaaOq eedw7UOeR3BJOy+b8TwHVjB6pVKe95YXrXcawFLMyP2Ddas3pjQCs6qzKUyE1Iem05CqbKuVlJG 3DJ+mBIMbxqY9lQU6x+EU5rtq5vRt8qjVrQl4BP8ESgm72ECTR8pPJ9RMcboMpsXmHEaH1grmCG eyHF7o8ik2g1jTGebgzaETA+3bEObuMmAbeh+99KpnNbzCEP23dHMQ3Ss+xnp+/MPxYVzcOg1pT Jw2ChP5hFglECRjd7QSp3mSnlqbIlxoRFP0c178CGIia4iXI7tPJwkhrgEnGwanO80OmttuZ9Zt U9/YeORP+BOzsD42BSFME32Mw86GXx0SAcqmtTgiYWbC+z3jOMB464U1p0BJAtGaXjKDlG8sw81 a5DiU23xTuDoC65sVq4aTvhcOdkm+qWKMplymTRej2Gu8dE+3ctxU1NSfLjGPKEt2tx3mCuVx// b7eeWWtcAq1gIpw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

This patch adds the ability to send RM_ADDR for local ID 0. Check
whether id 0 address is removed, if not, put id 0 into a removing
list, pass it to mptcp_pm_remove_addr() to remove id 0 address.

There is no reason not to allow the userspace to remove the initial
address (ID 0). This special case was not taken into account not
letting the userspace to delete all addresses as announced.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/379
Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
Link: https://lore.kernel.org/r/20231025-send-net-next-20231025-v1-3-db8f25f798eb@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 84c531f54ad9a124a924c9505d74e33d16965146)
Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - As mentioned in [1], the 'Fixes' tag has been accidentally dropped:
   [1] https://lore.kernel.org/stable/a7a3675a-4531-4559-bea2-c7689317764a@kernel.org/
 - Conflict in pm_userspace.c because the new helper function expected
   to be on top of mptcp_pm_nl_remove_doit() which has been recently
   renamed in commit 1e07938e29c5 ("net: mptcp: rename netlink handlers
   to mptcp_pm_nl_<blah>_{doit,dumpit}").
---
 net/mptcp/pm_userspace.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 3b34b7cf56c9..ecd166ce047d 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -220,6 +220,40 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk,
+						     struct genl_info *info)
+{
+	struct mptcp_rm_list list = { .nr = 0 };
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+	bool has_id_0 = false;
+	int err = -EINVAL;
+
+	lock_sock(sk);
+	mptcp_for_each_subflow(msk, subflow) {
+		if (subflow->local_id == 0) {
+			has_id_0 = true;
+			break;
+		}
+	}
+	if (!has_id_0) {
+		GENL_SET_ERR_MSG(info, "address with id 0 not found");
+		goto remove_err;
+	}
+
+	list.ids[list.nr++] = 0;
+
+	spin_lock_bh(&msk->pm.lock);
+	mptcp_pm_remove_addr(msk, &list);
+	spin_unlock_bh(&msk->pm.lock);
+
+	err = 0;
+
+remove_err:
+	release_sock(sk);
+	return err;
+}
+
 int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
@@ -251,6 +285,11 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 		goto remove_err;
 	}
 
+	if (id_val == 0) {
+		err = mptcp_userspace_pm_remove_id_zero_address(msk, info);
+		goto remove_err;
+	}
+
 	lock_sock((struct sock *)msk);
 
 	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-- 
2.43.0



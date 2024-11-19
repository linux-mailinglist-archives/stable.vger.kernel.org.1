Return-Path: <stable+bounces-93941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B189D21AC
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 09:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82AE1F22417
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 08:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBAA1B0F24;
	Tue, 19 Nov 2024 08:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cz+SnKpz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365ED198E6D;
	Tue, 19 Nov 2024 08:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732005369; cv=none; b=lKuwHPLzWB2edWbtc627OvPpVU+MbJ1i6cwwjRkQ5bzGHZhvwCmqcQ0LsP/WaV2oqFyCxsAtrMvHP2x/z5yFJ+iQFhbwWbJkp0mSXznzrk91EKE9YRuHK+OZJLJGzPIik6bZkoU7IG+OJDViybENq+acwEA332gogciWH9L1PIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732005369; c=relaxed/simple;
	bh=/15lH2bJJx8m56lJc0D3hesy+1WKaqPuHBeEP9sIy5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F8ebAhdBt8bL7jN/aYH9g6i5aU8D6i1cAhXloRgql8PgAThm8CxpfJLNf+s2qof/PoD4ZHpcFVcFS8E/lxyL6wr5D869Z+h0EoaM1IntcEbdGLvt9GwVGq5cA80b34xI8EuSH3I8IP344boin0WixaUL2Kd/Nz5GyKF7t1ij9T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cz+SnKpz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D63AC4CED1;
	Tue, 19 Nov 2024 08:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732005368;
	bh=/15lH2bJJx8m56lJc0D3hesy+1WKaqPuHBeEP9sIy5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cz+SnKpzAEUCsLEmGmt8LOzm5jRDWKkcSah1GwqKAdCI1rBlXyXAaRyPTQChxuaXe
	 q8FScICj14HQ5Mom2zMO253utAWSBGSfzN5GjXAzq71F95imaYhcZ7tug/qefAQ1Xh
	 Bp+tNdgw0eDk9Dl+otNcQfoP6p2jgEAkkKzQI43eYeTd7etRGS8xOj9f0C03xcLn1q
	 6x3MtEXKEqTpBwTMxC4XusJdj7M6O+Sfgh/UtBs3+AKPv85zlWKEQHnXpbPQi8N7pM
	 tXR50QPdSoefsW40SzmXY88uxVzdOfSvL9mVpXYCBO/jTeb/39dRAOHM4WqA3lRdf/
	 pwMzc8Ykiou7A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	sashal@kernel.org,
	Matthieu Baerts <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y 6/7] mptcp: drop lookup_by_id in lookup_addr
Date: Tue, 19 Nov 2024 09:35:54 +0100
Message-ID: <20241119083547.3234013-15-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241119083547.3234013-9-matttbe@kernel.org>
References: <20241119083547.3234013-9-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2956; i=matttbe@kernel.org; h=from:subject; bh=xlm5qZmphQDWhCVQKl29IglZRURRJ3MKIL7gFVz2pOM=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnPE3kFsZXe/P1WN/oeKuP0B4mcmjGoT3Kaas4O X4kIv7PyiOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZzxN5AAKCRD2t4JPQmmg c9aTD/9Xst4sIxQJ6epjSnbFgWZzIf2nbZvZDx1KrbpY5cuwXHcJb5mNSKtQIC5cfPzaE11vmr3 HdVg0BrXk56BbTx/jmq96JiLYbX5ADkpkW+g/P6fSFQu/G7ImDBbr98wc91104VL+LrccFOPbLE x6tPQL9sNEYZDVjflUNJ63DHWKhu9shyOGkWOZJyEDA/NpdP7T/PYYUTMbTofI5LMJ8aSDtOtx2 HZC9GIZpNy7ves28OMVFuGOrZ6DJf2BD2t/FbTrVYlSTSZSL8LdcAliC8Jd24ELCOtsxnclz/qE e/l3EJofJsBNH/ZITWO+DTzDZx4bi4Ou6oYQXu/Y38ISvr8VmxjPB8USeDKYpweR2VcLaQaUr92 MTftOvma5nQ7uXpBq7i/aOa+HUq7h+wznIaOGSJhDva8vVd/N0MbdU1IT95vWPmqO129dAUsH56 W8ZLSUg/pGrsv7WaoYXY6D4aCrV1Oa7dZGWRwGrV062RIv1t3/8Va87hGUIQGGXWJJ70xjx8R85 fKXVBvarce5qrprUoXLDta3HRhszVtXBVifVYIhvN13wDDK4aW3ZOgzoP4Rw8Vl7dt8bwu1uRjo hnTXWQw6Yokzlr7YyTbApi8kMlsJ3Hlv9Go60+cBi+LBg1hswJISpJjMIvq4iH2NM2zAKG7uayR t5H8tHdB/hZP4cQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

commit af250c27ea1c404e210fc3a308b20f772df584d6 upstream.

When the lookup_by_id parameter of __lookup_addr() is true, it's the same
as __lookup_addr_by_id(), it can be replaced by __lookup_addr_by_id()
directly. So drop this parameter, let __lookup_addr() only looks up address
on the local address list by comparing addresses in it, not address ids.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://lore.kernel.org/r/20240305-upstream-net-next-20240304-mptcp-misc-cleanup-v1-4-c436ba5e569b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: db3eab8110bc ("mptcp: pm: use _rcu variant under rcu_read_lock")
[ Conflicts in pm_netlink.c, because commit 6a42477fe449 ("mptcp: update
  set_flags interfaces") is not in this version, and causes too many
  conflicts when backporting it. The conflict is easy to resolve: addr
  is a pointer here here in mptcp_pm_nl_set_flags(), the rest of the
  code is the same. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 49e8156f5388..9b65d9360976 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -525,15 +525,12 @@ __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsigned int id)
 }
 
 static struct mptcp_pm_addr_entry *
-__lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info,
-	      bool lookup_by_id)
+__lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 {
 	struct mptcp_pm_addr_entry *entry;
 
 	list_for_each_entry(entry, &pernet->local_addr_list, list) {
-		if ((!lookup_by_id &&
-		     mptcp_addresses_equal(&entry->addr, info, entry->addr.port)) ||
-		    (lookup_by_id && entry->addr.id == info->id))
+		if (mptcp_addresses_equal(&entry->addr, info, entry->addr.port))
 			return entry;
 	}
 	return NULL;
@@ -564,7 +561,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 		mptcp_local_address((struct sock_common *)msk->first, &mpc_addr);
 		rcu_read_lock();
-		entry = __lookup_addr(pernet, &mpc_addr, false);
+		entry = __lookup_addr(pernet, &mpc_addr);
 		if (entry) {
 			__clear_bit(entry->addr.id, msk->pm.id_avail_bitmap);
 			msk->mpc_endpoint_id = entry->addr.id;
@@ -2081,7 +2078,8 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
 						    token, &addr, &remote, bkup);
 
 	spin_lock_bh(&pernet->lock);
-	entry = __lookup_addr(pernet, &addr.addr, lookup_by_id);
+	entry = lookup_by_id ? __lookup_addr_by_id(pernet, addr.addr.id) :
+			       __lookup_addr(pernet, &addr.addr);
 	if (!entry) {
 		spin_unlock_bh(&pernet->lock);
 		return -EINVAL;
-- 
2.45.2



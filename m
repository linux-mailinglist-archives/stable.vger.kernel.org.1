Return-Path: <stable+bounces-93823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDE89D180D
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 19:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B02CB238CF
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 18:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAE51E0DE5;
	Mon, 18 Nov 2024 18:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P07CW9CR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993201DED55;
	Mon, 18 Nov 2024 18:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731954466; cv=none; b=YYbV7nM9saJ+zFnpvL0doITPyuyj1xf4jgLiygxocVR3ltD7oxcJvxLGpsjVp7Lqw4K9Vrj6hPlz8FaSNtcqMmjfs+bboAj7sicA73OOCaa2kPwkgMT/1UnmB8TN1m7RONp2qzfMweGttL2pzsrXEhv2FlI9zH+nXoRm7Y2AOOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731954466; c=relaxed/simple;
	bh=puNfWVMS56Wr5LnT6SuKL2WgxBO/QWVLR6swiJFqYK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fp0CyzvWHxmAIw/2yfHB3CvZ7vmihn0hoJklAdD+ZnqS5hpqusYmiuJb1jgDqrjGfi89GBhqkeNlcLfflpbn54w9jOH2MNh8+MY2YdC/kSIoyHdpqk3KKtwgX7wVEOSYuQFzkm0Arj6HQOjV7Yz397CTFIOBY0gGB6t3sePykmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P07CW9CR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B65C4CECC;
	Mon, 18 Nov 2024 18:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731954466;
	bh=puNfWVMS56Wr5LnT6SuKL2WgxBO/QWVLR6swiJFqYK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P07CW9CROgo5VZJbb6FoM6wXcJTRgcxhAoBxmb53jDkTYwkykIh9KVz71QI8G2jZc
	 1aQZJnyHWfEV2neo4tObxXG2xrX7sSE1bGdnsctS9XcC84wmnVYuZv92pXZO79oeLc
	 29pc8npdc9akvLAg4ebJVp5+fve+BJrQF1JL8OnqWW1PE6IBcoW705431yBGf2nuiB
	 ZM3xdjXK9LHSDOGDltDpRI21bw22L71X5CGYfIR7wThaM70UvPRG634VbSnZ8sAaKn
	 ErnTyd6zMMBq0Ifp+/gAsDTw/e4PNMggefFkODOtSAiDOYw4CWHFJpKLnDEiQYqQRm
	 HH/o22U28swPg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	sashal@kernel.org,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH 6.6.y 2/6] mptcp: add userspace_pm_lookup_addr_by_id helper
Date: Mon, 18 Nov 2024 19:27:20 +0100
Message-ID: <20241118182718.3011097-10-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241118182718.3011097-8-matttbe@kernel.org>
References: <20241118182718.3011097-8-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2833; i=matttbe@kernel.org; h=from:subject; bh=Gez9/8bqtvjqsM0p3HrSnk53UVBnSeuwntb0Sblhfv0=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnO4cGQGNcOojrsRT3WhQ0NnOkjOD6CsEaijwri mM9i1AuscaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZzuHBgAKCRD2t4JPQmmg c3cPEADc0D2lGqemrxqcd+siWlBemT8jt4XM/3N+HWwyuehB7HsfNhsIGacYYVrd/7B6l2Jlzxf GfLs7AP1UCMzGdkdkhW1mxXpB/nhzGRVXSiAhC7evxKRB3PbXbUeUg01xyLxmgyDzn0cKEX+K5C DIxBmiQALjAwB0nopw8ceddL06puaXrVDDv8qkwarX8CUR8wOK1y0ILVehwC+W3yE0DNLp73WE9 8fiuJdn9V5wgON9/g8S13jGbfCd0nDPz1UU3abqstluSqqdgBJQ1XilLMLfLP23tpyfcdFdKP3X nPQ90IrhlKe+qfrDV7FZutfQ7kjGsj7y4xshOw6vkoeR3C9rgs67IV2suOlrO88tJK0WMjzVAg0 l+12Vx5UuHiOA8gAtilBKL6SKiUQ/TWeGnRexeljHCkGTzKi2Cr99FUTsD0pHx+4XhP0kGJl7Lc uFEkGkKfTiUF2JkFkxSDpw9uXgSbvMRSxlFk+X7W067UWAJJCs1tTgFnm76uu7RVgaiO6M1h1Dl 9VJYwFY9eZHxaEgmqTxTxqHMMf4DDJF/MMG3iwJHPArRl0G1Sv4W3XtFdV/st2NfszrUoUBHNnh Q79ayzMnK4yT7MQvReT+VTdP1D5cWoQHVEWVT9en1jdK6/lxZvcwo/262vUE0aSzuzJmY3DyHlO PfSBtFQsirdZlUw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

commit 06afe09091ee69dc7ab058b4be9917ae59cc81e5 upstream.

Corresponding __lookup_addr_by_id() helper in the in-kernel netlink PM,
this patch adds a new helper mptcp_userspace_pm_lookup_addr_by_id() to
lookup the address entry with the given id on the userspace pm local
address list.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: f642c5c4d528 ("mptcp: hold pm lock when deleting entry")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index eded0f9c0b6f..23e362c11801 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -107,19 +107,26 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 	return -EINVAL;
 }
 
+static struct mptcp_pm_addr_entry *
+mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
+{
+	struct mptcp_pm_addr_entry *entry;
+
+	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (entry->addr.id == id)
+			return entry;
+	}
+	return NULL;
+}
+
 int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 						   unsigned int id,
 						   u8 *flags, int *ifindex)
 {
-	struct mptcp_pm_addr_entry *entry, *match = NULL;
+	struct mptcp_pm_addr_entry *match;
 
 	spin_lock_bh(&msk->pm.lock);
-	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (id == entry->addr.id) {
-			match = entry;
-			break;
-		}
-	}
+	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
 	spin_unlock_bh(&msk->pm.lock);
 	if (match) {
 		*flags = match->flags;
@@ -280,7 +287,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
-	struct mptcp_pm_addr_entry *match = NULL;
+	struct mptcp_pm_addr_entry *match;
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
 	LIST_HEAD(free_list);
@@ -317,13 +324,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 
 	lock_sock(sk);
 
-	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (entry->addr.id == id_val) {
-			match = entry;
-			break;
-		}
-	}
-
+	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id_val);
 	if (!match) {
 		GENL_SET_ERR_MSG(info, "address with specified id not found");
 		release_sock(sk);
-- 
2.45.2



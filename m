Return-Path: <stable+bounces-23771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB411868363
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 22:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85C5A28E24F
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 21:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1963131E39;
	Mon, 26 Feb 2024 21:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEZFuIbZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B36A131E20;
	Mon, 26 Feb 2024 21:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708984601; cv=none; b=tdMbteCV94pB6LZYkF/gXAL3Gz1vW5ikOSI20DCNsx36Eqrb8BlmRroOvKdD9NIX2GAPOyt2xvCq3KY69DQxW6JMsdBWCQykR/L73nJN1wA3CZM7RDAk5ZpKeTnqMEoFzZD173yB5abPRYsoGnqsALPvRGrR0w7UpVAYIAttVjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708984601; c=relaxed/simple;
	bh=nB2HKnmBeBfpnQdYtTvIbSU3V3yCWPTtBcmJmgwo+ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYMhglkq1WHBoBkq/dvY+0wi7nHr1ANI8RFmVLt+HaaHw0EePtZnfb2GxHddVXr5WGEAjVKfh6dpao09pISw6dJmzjmMqfSOBLTEaO7b8lY9rTW0IzXlYL5kPW1MeUvLvmdPWdPphT7zxLdwwHxwQloUT9TiCK7hETVXgQG4R0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEZFuIbZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D5CC433C7;
	Mon, 26 Feb 2024 21:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708984600;
	bh=nB2HKnmBeBfpnQdYtTvIbSU3V3yCWPTtBcmJmgwo+ek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cEZFuIbZoSEBMUe+eJatdZH3jDNeOF5Yu5AoPwUlFIoMBqUvbtCC+V7oVIfq5AdyJ
	 XkctjXBhGR7mk7oQaicMhptLi5/qHB7cW/n5VfQ9br8oJR8mt/Dk8Sr3CIapKMBEad
	 CjfBHoG/1uBUOhDs6hpDKniP4OuFtzcb0zIj7i+uJJZnJHwxT345Mu7Zj1YdcfSzce
	 5rytcd1+6yAsE5Azpza7+gFZvMTo732+6ypAJl1gxnPZ+lqVhIQdl1ul6RkOaxFtED
	 WDyNBXVl8T8utPP2658vjR7U7NiRsYY/Bw4Xts60cLhRcUipDE6LCEPPFawgCci+gI
	 RcNyauXjkMSzQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Geliang Tang <tanggeliang@kylinos.cn>,
	Mat Martineau <martineau@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH 6.6.y] mptcp: add needs_id for netlink appending addr
Date: Mon, 26 Feb 2024 22:56:21 +0100
Message-ID: <20240226215620.757784-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024022654-senate-unleaded-7ae3@gregkh>
References: <2024022654-senate-unleaded-7ae3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3829; i=matttbe@kernel.org; h=from:subject; bh=zVBwJ0UGDvQ5z9JRWrzq3LiPMcMhI9baibfjMSxyYgs=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl3QkEuyntHwpinwJ9CjSA4bSrzBTKCNyfFJrtJ c3gs5jB0iuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZd0JBAAKCRD2t4JPQmmg c7XzD/9MdN6z7u00FmaB1P7QbirybCCyCi2FZDJVgRnCPMcD76eEvvNW84xiZoVWeELjntPQK6C NaOhfefM+EIJYqTbPLVlqanu23MJ7Sa3D6+dJRTlyyWvGVob4Z2KcSSGx0ZqwWvtFmwYhZPQl6R DS0psi1jYjhFV0KCvjun/bNz/uOFc2rU8PKR3TXEUgMIR/kfk7Eoax3o+oi2lNjoayupsSUO2V8 hq6EBEU+azyTxWQNZBrFMQFDjrOyNwrsTgPaYTUB2Sw8lVO/EHn+UNWdwQFpzGKlDya4qW4rroK P7uhj2JotlcJo/VcXSKvIAaiwU2GxRt+P40eQEGfg77Stha9909pswfbtTV4wNuqVJf/Rr3K3cR woEmKMF0nQ+FZPc2xaQS2wiT3cojsKFKFkj9Zlr9edyJVMipbkrDNBr0gRGn1epA50mdbL/EKZk u7cJiDw468HcMbnc+a8ZmFGE0lRBtRq+ik2I8FvzeVF/S5SnZ0OQWUyDIX+Ka15KajL1Saa//Qe IY2PxR07cGycFqdD9omZdkYrU1ZhVWL3UFhSHKXQFkvRa0/VPUs97PD+pSzSpxaQ/MtgnrbBH2p uwNC815dY0/Kcqrl/Dis3AOdmXYznTq525UtcujVq6hOBw0VU6uYCh14mUTRFa52xxcMIV8Rhx/ cVjYb3ckGJ6AyIA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Just the same as userspace PM, a new parameter needs_id is added for
in-kernel PM mptcp_pm_nl_append_new_local_addr() too.

Add a new helper mptcp_pm_has_addr_attr_id() to check whether an address
ID is set from PM or not.

In mptcp_pm_nl_get_local_id(), needs_id is always true, but in
mptcp_pm_nl_add_addr_doit(), pass mptcp_pm_has_addr_attr_id() to
needs_it.

Fixes: efd5a4c04e18 ("mptcp: add the address ID assignment bitmap")
Cc: stable@vger.kernel.org
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit 584f3894262634596532cf43a5e782e34a0ce374)
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - conflicts in pm_netlink.c because the new helper function expected to
   be on top of mptcp_pm_nl_add_addr_doit() which has been recently
   renamed in commit 1e07938e29c5 ("net: mptcp: rename netlink handlers
   to mptcp_pm_nl_<blah>_{doit,dumpit}").
 - use mptcp_pm_addr_policy instead of mptcp_pm_address_nl_policy, the
   new name after commit 1d0507f46843 ("net: mptcp: convert netlink from
   small_ops to ops").
---
 net/mptcp/pm_netlink.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index e504a1649da0..4dd47a1fb9aa 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -904,7 +904,8 @@ static void __mptcp_pm_release_addr_entry(struct mptcp_pm_addr_entry *entry)
 }
 
 static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
-					     struct mptcp_pm_addr_entry *entry)
+					     struct mptcp_pm_addr_entry *entry,
+					     bool needs_id)
 {
 	struct mptcp_pm_addr_entry *cur, *del_entry = NULL;
 	unsigned int addr_max;
@@ -952,7 +953,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		}
 	}
 
-	if (!entry->addr.id) {
+	if (!entry->addr.id && needs_id) {
 find_next:
 		entry->addr.id = find_next_zero_bit(pernet->id_bitmap,
 						    MPTCP_PM_MAX_ADDR_ID + 1,
@@ -963,7 +964,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		}
 	}
 
-	if (!entry->addr.id)
+	if (!entry->addr.id && needs_id)
 		goto out;
 
 	__set_bit(entry->addr.id, pernet->id_bitmap);
@@ -1095,7 +1096,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 	entry->ifindex = 0;
 	entry->flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
 	entry->lsk = NULL;
-	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
+	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, true);
 	if (ret < 0)
 		kfree(entry);
 
@@ -1311,6 +1312,18 @@ static int mptcp_nl_add_subflow_or_signal_addr(struct net *net)
 	return 0;
 }
 
+static bool mptcp_pm_has_addr_attr_id(const struct nlattr *attr,
+				      struct genl_info *info)
+{
+	struct nlattr *tb[MPTCP_PM_ADDR_ATTR_MAX + 1];
+
+	if (!nla_parse_nested_deprecated(tb, MPTCP_PM_ADDR_ATTR_MAX, attr,
+					 mptcp_pm_addr_policy, info->extack) &&
+	    tb[MPTCP_PM_ADDR_ATTR_ID])
+		return true;
+	return false;
+}
+
 static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
@@ -1352,7 +1365,8 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
 			goto out_free;
 		}
 	}
-	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
+	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry,
+						!mptcp_pm_has_addr_attr_id(attr, info));
 	if (ret < 0) {
 		GENL_SET_ERR_MSG_FMT(info, "too many addresses or duplicate one: %d", ret);
 		goto out_free;
-- 
2.43.0



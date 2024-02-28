Return-Path: <stable+bounces-25408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9A886B62A
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 18:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 848331F284C0
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 17:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872AA15DBAF;
	Wed, 28 Feb 2024 17:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dttrbc5R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E2B15A4A6;
	Wed, 28 Feb 2024 17:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709141862; cv=none; b=QzC3hCxTlMFTTYQV0ZKgiQ11VG+CY+e+LMBp5jF6E1dUD/Su7vCsB9oEQT1nkjWl4rGxaE9/RF/lcYBOBbVu5RSNuP04n6Y3REB6IJXVEk45qLUXXmoR+GUblwtTktr0JZxoMQJKSnk4drHbfeDPFhvSrgx4RavThAg2fRfpFMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709141862; c=relaxed/simple;
	bh=DOUUPgHf0MranEJRXLW71fXNx0rR1Unte6CenbNAFig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8WdS4oxg0CaIba4beiHyGtaRK/4+DnEtrC7E3oV9vk4KExxKHXz+v7VnX9pG+RBygOOHqUFN8g/P4u4Tq9SCpwMFXDPyp4ChQxnseeDaY6/wRTGj7Mv23Xz+QCaB29m1hBwtqgM9fUjF/gTdK1Wwr4bCXZ7EdNfCMkm3V7ZovY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dttrbc5R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A533AC433C7;
	Wed, 28 Feb 2024 17:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709141861;
	bh=DOUUPgHf0MranEJRXLW71fXNx0rR1Unte6CenbNAFig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dttrbc5RPvXUb4muTvUrwDaWMREdfeN4TFWV2Zrv9PlPOSZPbh74jc/Jz69dBVHly
	 Wn606cxzB2ztCXJo1HfWfxst6FtVrxWiew1NmICNIQZqYX1i4BFIvhZx5pn0+WvP2Q
	 4lZYFlrKsNau1EZSRId9lbRFp1DZCAjL/mPgoA3pgW+x4PJleCcXqZT6bqpFJL/w12
	 cxEcKIyqpB11Lj8/BuXO91j+q3dE3rIjA0fAQi0AoKCfsc2sWEQS8k8MQnNlL0+h6H
	 A6s0zTD6s1j07GU0BM5/vv7HUhf8nJoXHt5a1/UufJsMZgxVLI8qRIERu9wf5421Fb
	 9Un687zFu1t8g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Geliang Tang <tanggeliang@kylinos.cn>,
	Mat Martineau <martineau@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH 5.15.y 2/2] mptcp: add needs_id for netlink appending addr
Date: Wed, 28 Feb 2024 18:37:16 +0100
Message-ID: <20240228173714.262012-4-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240228173714.262012-3-matttbe@kernel.org>
References: <2024022732-wrought-cardiac-a27a@gregkh>
 <20240228173714.262012-3-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3537; i=matttbe@kernel.org; h=from:subject; bh=clILGqR2qC8WWu/V5O7pVk1vCEaeGwqdLSWaJoGeVHk=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl329KRe9EpmqlJAWMlSlrOwgKBB0mPkE7IrxRS erYfCS1SeqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZd9vSgAKCRD2t4JPQmmg cyEzD/419kjovw5Rt7Vogpuw9XhtS4ZxPT+0mISexWZH4hH42tOlstObybuhT9SvdhZdwtHzylB ftjChnRSKoPxW1V5Wy0TeWyasy+rRr36+psV6crekVnrn+2g/exew/Udiy2i6Fj8msu0pYtvpV7 kTNwL/6zq1Fo3JM7VhO89Bu22WynsIDECGQYfdc511vOt/SGjUTxaDNpW88M68FOCliuNd3y5Fh 4buBB1UaHfwznbr7Z4iXD0+yy57OwSsK1x0bKJpchpdQnTwngDbPAk9qzmGzXdYy+6SswtHCsEK ck/t3Kb6PHlJmd/ydENHIwSROAmnH2cy6U7fp6NpCAYwDdPbwgI0T0SeuV4O+RksfzHjKr1PF9J sZ8MwGR5xBVl2pYCOFr7gr2bntelIpx3DO+BqlvmGevFjM3sZySdv3yYSrTJYNV26c3AG82K6bU W+tZdN60tipeTUaFCnD22wuAnF81ZPxSW1db7ERwhpVJ7LGdRRgatL9ETQHTyz68jKjSD0ZVONq ePT2Fr4FOTd5kHaSM3VyCD55EpD7xQripeyYqiH8CFCiLN9iiQnzzvxSIrrJ34kKfzoWDD07S6D xo+BHGsxm7aLSnziRURPBEu8TIxqpyO4fn9iYgvudIKBwRsGO2f/1GjuUEtuARTF+gWzXjzsspB nlYKaCfPkDN//5Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

commit 584f3894262634596532cf43a5e782e34a0ce374 upstream.

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
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 - Notes:
   - no more conflicts after having backported 59060a47ca50 ("mptcp:
     clean up harmless false expressions") and taken the version from
     v6.1.
---
 net/mptcp/pm_netlink.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 6018d9641e0b0..651f2c158637c 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -823,7 +823,8 @@ static bool address_use_port(struct mptcp_pm_addr_entry *entry)
 }
 
 static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
-					     struct mptcp_pm_addr_entry *entry)
+					     struct mptcp_pm_addr_entry *entry,
+					     bool needs_id)
 {
 	struct mptcp_pm_addr_entry *cur;
 	unsigned int addr_max;
@@ -850,7 +851,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 			goto out;
 	}
 
-	if (!entry->addr.id) {
+	if (!entry->addr.id && needs_id) {
 find_next:
 		entry->addr.id = find_next_zero_bit(pernet->id_bitmap,
 						    MAX_ADDR_ID + 1,
@@ -861,7 +862,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		}
 	}
 
-	if (!entry->addr.id)
+	if (!entry->addr.id && needs_id)
 		goto out;
 
 	__set_bit(entry->addr.id, pernet->id_bitmap);
@@ -1001,7 +1002,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	entry->ifindex = 0;
 	entry->flags = 0;
 	entry->lsk = NULL;
-	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
+	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, true);
 	if (ret < 0)
 		kfree(entry);
 
@@ -1202,6 +1203,18 @@ static int mptcp_nl_add_subflow_or_signal_addr(struct net *net)
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
@@ -1228,7 +1241,8 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
 			return ret;
 		}
 	}
-	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
+	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry,
+						!mptcp_pm_has_addr_attr_id(attr, info));
 	if (ret < 0) {
 		GENL_SET_ERR_MSG(info, "too many addresses or duplicate one");
 		if (entry->lsk)
-- 
2.43.0



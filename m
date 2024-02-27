Return-Path: <stable+bounces-25045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F82E86977F
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 15:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D09781F24029
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFF31420DD;
	Tue, 27 Feb 2024 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hJ8PYRTm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD2413F016;
	Tue, 27 Feb 2024 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043702; cv=none; b=QiduEE9MXqLxK+xiSKLAOfJjowWiY0ilqH/rwIpH+OoeX36Cpp5eoq7yjkOY8/Kqd427ZbQB31kHQo+G8BozSa8GtfuIa2OeB/c6BtqVPtN2x1Op4ASJBmc75nbyb5RDPFs1MYFQSXelD7PtFCD1r4Wh8Zte5WdOksdndj6m214=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043702; c=relaxed/simple;
	bh=k7ckbAXJ9PE3jw9SjqoUTO95O8sZHk5tZu53OXOJHGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C3BhhWBFMpbKt18swy7G/nniStij0CT5tInti4q4D56xeUvc+SHg62xQWND+w6UN25ENiq4Gp4bBBZGMTnMn1qmNAlXI78PbL1+kreeqnkIu4a7MZWVS+71F4kZjkRU2isZKrrJ18dgm2h7tM8t1JmrcPPxKfQCSjWlvQHRtB6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hJ8PYRTm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1FBC433F1;
	Tue, 27 Feb 2024 14:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709043702;
	bh=k7ckbAXJ9PE3jw9SjqoUTO95O8sZHk5tZu53OXOJHGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hJ8PYRTmlLoE2SxLZzuDfNZLoxi3/eAwhu5bhIVnyUKWutObT0zsOUUEG/tm6oFBr
	 LBDWK3mMhfhQK5wZhkMWWJlxHACsGJSlo5KFSs/fFRPHAVBUX+HnR77GyqjtKhJpoU
	 dY6RAFljkfXUWvoF7US59wIusu+gxRHdiiyzhAIY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geliang Tang <tanggeliang@kylinos.cn>,
	Mat Martineau <martineau@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.1 191/195] mptcp: add needs_id for netlink appending addr
Date: Tue, 27 Feb 2024 14:27:32 +0100
Message-ID: <20240227131616.709399360@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131610.391465389@linuxfoundation.org>
References: <20240227131610.391465389@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

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
 net/mptcp/pm_netlink.c |   24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -900,7 +900,8 @@ static void __mptcp_pm_release_addr_entr
 }
 
 static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
-					     struct mptcp_pm_addr_entry *entry)
+					     struct mptcp_pm_addr_entry *entry,
+					     bool needs_id)
 {
 	struct mptcp_pm_addr_entry *cur, *del_entry = NULL;
 	unsigned int addr_max;
@@ -942,7 +943,7 @@ static int mptcp_pm_nl_append_new_local_
 		}
 	}
 
-	if (!entry->addr.id) {
+	if (!entry->addr.id && needs_id) {
 find_next:
 		entry->addr.id = find_next_zero_bit(pernet->id_bitmap,
 						    MPTCP_PM_MAX_ADDR_ID + 1,
@@ -953,7 +954,7 @@ find_next:
 		}
 	}
 
-	if (!entry->addr.id)
+	if (!entry->addr.id && needs_id)
 		goto out;
 
 	__set_bit(entry->addr.id, pernet->id_bitmap);
@@ -1095,7 +1096,7 @@ int mptcp_pm_nl_get_local_id(struct mptc
 	entry->ifindex = 0;
 	entry->flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
 	entry->lsk = NULL;
-	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
+	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, true);
 	if (ret < 0)
 		kfree(entry);
 
@@ -1311,6 +1312,18 @@ next:
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
@@ -1352,7 +1365,8 @@ static int mptcp_nl_cmd_add_addr(struct
 			goto out_free;
 		}
 	}
-	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
+	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry,
+						!mptcp_pm_has_addr_attr_id(attr, info));
 	if (ret < 0) {
 		GENL_SET_ERR_MSG(info, "too many addresses or duplicate one");
 		goto out_free;




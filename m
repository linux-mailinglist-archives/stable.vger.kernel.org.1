Return-Path: <stable+bounces-239846-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBRyA81b5mkwvQEAu9opvQ
	(envelope-from <stable+bounces-239846-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:01:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A0B4305F8
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2990E329360C
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2615E2236E3;
	Mon, 20 Apr 2026 16:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b7XprWVM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD80F342CBD;
	Mon, 20 Apr 2026 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776701365; cv=none; b=QsgDjbrz9Paze6WlTqGyAufZY9xLXC+auZOB3q2KIhtu24E6KRJGDwso1eSkKg7hTwGe41Sa0MCuwpAiS2kJjMxd3cKGZTp2QXk2PCoKMw3Fz0dBRo043u7EBfUStiyTuO1JSuJlrGNk2600YVljXkc68ZnZ89Mt+f/IeCP9D7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776701365; c=relaxed/simple;
	bh=+Y/QZmG+oVOHwrpB/gFj5QqycUmrD5kYP96wOfkvVZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CE0u4tXK+hSqkybip3Hl3TjupaFX9sJEKxddnoJ01NkKMD5Gnt23IM1meNpymegAP2FzapylpU6eSaWqcvlPHN3+B5J0WVw0nZ3lDeEQISoIKpmboAgIvdj+CiKnPS9HrhlL0IY0k+GvsXPBH6ydA3KhZOi7QeRqo3YYBgh3jhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b7XprWVM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7608DC2BCB8;
	Mon, 20 Apr 2026 16:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776701365;
	bh=+Y/QZmG+oVOHwrpB/gFj5QqycUmrD5kYP96wOfkvVZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b7XprWVM/uTNUOYELdTcFblok0pUGCxKXDQ8xdLaXZIE14nofvwJtF2T5yvfDzW6g
	 nQ29kkrfDAdarGx8WuZRiq7OCkFtjnA4tGylFb5acXJOGgi/rJ4Z8gP58n9MBz36Ge
	 dj6p9kHpFZAidqN3v/gyMg8qO1Uw93OOMqm92jHc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yiming Qian <yimingqian591@gmail.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 052/162] ipv4: nexthop: allocate skb dynamically in rtm_get_nexthop()
Date: Mon, 20 Apr 2026 17:41:24 +0200
Message-ID: <20260420153928.921683640@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153927.006696811@linuxfoundation.org>
References: <20260420153927.006696811@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,suse.de,google.com,nvidia.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-239846-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,suse.de:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 93A0B4305F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fernando Fernandez Mancera <fmancera@suse.de>

[ Upstream commit 14cf0cd35361f4e94824bf8a42f72713d7702a73 ]

When querying a nexthop object via RTM_GETNEXTHOP, the kernel currently
allocates a fixed-size skb using NLMSG_GOODSIZE. While sufficient for
single nexthops and small Equal-Cost Multi-Path groups, this fixed
allocation fails for large nexthop groups like 512 nexthops.

This results in the following warning splat:

 WARNING: net/ipv4/nexthop.c:3395 at rtm_get_nexthop+0x176/0x1c0, CPU#20: rep/4608
 [...]
 RIP: 0010:rtm_get_nexthop (net/ipv4/nexthop.c:3395)
 [...]
 Call Trace:
  <TASK>
  rtnetlink_rcv_msg (net/core/rtnetlink.c:6989)
  netlink_rcv_skb (net/netlink/af_netlink.c:2550)
  netlink_unicast (net/netlink/af_netlink.c:1319 net/netlink/af_netlink.c:1344)
  netlink_sendmsg (net/netlink/af_netlink.c:1894)
  ____sys_sendmsg (net/socket.c:721 net/socket.c:736 net/socket.c:2585)
  ___sys_sendmsg (net/socket.c:2641)
  __sys_sendmsg (net/socket.c:2671)
  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
  </TASK>

Fix this by allocating the size dynamically using nh_nlmsg_size() and
using nlmsg_new(), this is consistent with nexthop_notify() behavior. In
addition, adjust nh_nlmsg_size_grp() so it calculates the size needed
based on flags passed. While at it, also add the size of NHA_FDB for
nexthop group size calculation as it was missing too.

This cannot be reproduced via iproute2 as the group size is currently
limited and the command fails as follows:

addattr_l ERROR: message exceeded bound of 1048

Fixes: 430a049190de ("nexthop: Add support for nexthop groups")
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Closes: https://lore.kernel.org/netdev/CAL_bE8Li2h4KO+AQFXW4S6Yb_u5X4oSKnkywW+LPFjuErhqELA@mail.gmail.com/
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/20260402072613.25262-2-fmancera@suse.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/nexthop.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index fe4ebafb7da14..f1d499a3e2748 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -1006,16 +1006,32 @@ static size_t nh_nlmsg_size_grp_res(struct nh_group *nhg)
 		nla_total_size_64bit(8);/* NHA_RES_GROUP_UNBALANCED_TIME */
 }
 
-static size_t nh_nlmsg_size_grp(struct nexthop *nh)
+static size_t nh_nlmsg_size_grp(struct nexthop *nh, u32 op_flags)
 {
 	struct nh_group *nhg = rtnl_dereference(nh->nh_grp);
 	size_t sz = sizeof(struct nexthop_grp) * nhg->num_nh;
 	size_t tot = nla_total_size(sz) +
-		nla_total_size(2); /* NHA_GROUP_TYPE */
+		nla_total_size(2) +	/* NHA_GROUP_TYPE */
+		nla_total_size(0);	/* NHA_FDB */
 
 	if (nhg->resilient)
 		tot += nh_nlmsg_size_grp_res(nhg);
 
+	if (op_flags & NHA_OP_FLAG_DUMP_STATS) {
+		tot += nla_total_size(0) +	  /* NHA_GROUP_STATS */
+		       nla_total_size(4);	  /* NHA_HW_STATS_ENABLE */
+		tot += nhg->num_nh *
+		       (nla_total_size(0) +	  /* NHA_GROUP_STATS_ENTRY */
+			nla_total_size(4) +	  /* NHA_GROUP_STATS_ENTRY_ID */
+			nla_total_size_64bit(8)); /* NHA_GROUP_STATS_ENTRY_PACKETS */
+
+		if (op_flags & NHA_OP_FLAG_DUMP_HW_STATS) {
+			tot += nhg->num_nh *
+			       nla_total_size_64bit(8); /* NHA_GROUP_STATS_ENTRY_PACKETS_HW */
+			tot += nla_total_size(4);	/* NHA_HW_STATS_USED */
+		}
+	}
+
 	return tot;
 }
 
@@ -1050,14 +1066,14 @@ static size_t nh_nlmsg_size_single(struct nexthop *nh)
 	return sz;
 }
 
-static size_t nh_nlmsg_size(struct nexthop *nh)
+static size_t nh_nlmsg_size(struct nexthop *nh, u32 op_flags)
 {
 	size_t sz = NLMSG_ALIGN(sizeof(struct nhmsg));
 
 	sz += nla_total_size(4); /* NHA_ID */
 
 	if (nh->is_group)
-		sz += nh_nlmsg_size_grp(nh) +
+		sz += nh_nlmsg_size_grp(nh, op_flags) +
 		      nla_total_size(4) +	/* NHA_OP_FLAGS */
 		      0;
 	else
@@ -1073,7 +1089,7 @@ static void nexthop_notify(int event, struct nexthop *nh, struct nl_info *info)
 	struct sk_buff *skb;
 	int err = -ENOBUFS;
 
-	skb = nlmsg_new(nh_nlmsg_size(nh), gfp_any());
+	skb = nlmsg_new(nh_nlmsg_size(nh, 0), gfp_any());
 	if (!skb)
 		goto errout;
 
@@ -3333,15 +3349,15 @@ static int rtm_get_nexthop(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	if (err)
 		return err;
 
-	err = -ENOBUFS;
-	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
-	if (!skb)
-		goto out;
-
 	err = -ENOENT;
 	nh = nexthop_find_by_id(net, id);
 	if (!nh)
-		goto errout_free;
+		goto out;
+
+	err = -ENOBUFS;
+	skb = nlmsg_new(nh_nlmsg_size(nh, op_flags), GFP_KERNEL);
+	if (!skb)
+		goto out;
 
 	err = nh_fill_node(skb, nh, RTM_NEWNEXTHOP, NETLINK_CB(in_skb).portid,
 			   nlh->nlmsg_seq, 0, op_flags);
-- 
2.53.0





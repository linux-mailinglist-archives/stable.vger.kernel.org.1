Return-Path: <stable+bounces-63800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B85941AB5
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE4481F259BF
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D241448FA;
	Tue, 30 Jul 2024 16:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TdEZseAf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05C21A6166;
	Tue, 30 Jul 2024 16:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357993; cv=none; b=m2a5FA88f8rqbXNeu0XQbtgDfqkBMXzx6ozmtm/QHPPhir5dywaiqfmOm7dnWW5nDBH9t+9mlsMDuXyL7YMDpd9CT37ZN6aFD58XMvvYoFCSp1+Ja0WGnRNQg3N1F7Sya1gmcfEMi1DTxV+nWS0kMmbCTJmCUxnEJaeXSOlIuuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357993; c=relaxed/simple;
	bh=CdAUbs9p5WvtGUQUJrA76OMrXwKNN3uyT0XEEKGDEpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pVd4drYqryyYhKiecaZUSCSUM4mHXpWdPJqEmeb54pUTgVo5fMPgPpgB/Lj/lnBAULxZyQYKLxE4OBbFqQo4SwGmQ3QDm2lCZDgyioO7Y4wOlxNm88ZsBShT1AA8ZIKq7qtHlLl3DSuRCZ1ba5OR9xzywzRqRV9t1/vhCGBzH1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TdEZseAf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6B7C32782;
	Tue, 30 Jul 2024 16:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722357993;
	bh=CdAUbs9p5WvtGUQUJrA76OMrXwKNN3uyT0XEEKGDEpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TdEZseAfuQuFZWgev0DsZWlGseeFv2yCz24ibnqgLQqGt7+2YG7fo5grWsDkKcNZH
	 QJawxmLrkE72MZ0xDu6zd86MXPSRAUyTrrGVgBWjSDvZhIkY1mPQpPmkJshmmu6M8Z
	 PbmicRUngRIalnGQ4AMwhOiTA8UPfqVIeE3VoGbE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ido Schimmel <idosch@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Guillaume Nault <gnault@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 315/568] ipv4: Fix incorrect TOS in route get reply
Date: Tue, 30 Jul 2024 17:47:02 +0200
Message-ID: <20240730151652.182948879@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151639.792277039@linuxfoundation.org>
References: <20240730151639.792277039@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ido Schimmel <idosch@nvidia.com>

[ Upstream commit 338bb57e4c2a1c2c6fc92f9c0bd35be7587adca7 ]

The TOS value that is returned to user space in the route get reply is
the one with which the lookup was performed ('fl4->flowi4_tos'). This is
fine when the matched route is configured with a TOS as it would not
match if its TOS value did not match the one with which the lookup was
performed.

However, matching on TOS is only performed when the route's TOS is not
zero. It is therefore possible to have the kernel incorrectly return a
non-zero TOS:

 # ip link add name dummy1 up type dummy
 # ip address add 192.0.2.1/24 dev dummy1
 # ip route get 192.0.2.2 tos 0xfc
 192.0.2.2 tos 0x1c dev dummy1 src 192.0.2.1 uid 0
     cache

Fix by adding a DSCP field to the FIB result structure (inside an
existing 4 bytes hole), populating it in the route lookup and using it
when filling the route get reply.

Output after the patch:

 # ip link add name dummy1 up type dummy
 # ip address add 192.0.2.1/24 dev dummy1
 # ip route get 192.0.2.2 tos 0xfc
 192.0.2.2 dev dummy1 src 192.0.2.1 uid 0
     cache

Fixes: 1a00fee4ffb2 ("ipv4: Remove rt_key_{src,dst,tos} from struct rtable.")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Guillaume Nault <gnault@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/ip_fib.h |  1 +
 net/ipv4/fib_trie.c  |  1 +
 net/ipv4/route.c     | 14 +++++++-------
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index 15de07d365405..ca1700c2a5733 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -173,6 +173,7 @@ struct fib_result {
 	unsigned char		type;
 	unsigned char		scope;
 	u32			tclassid;
+	dscp_t			dscp;
 	struct fib_nh_common	*nhc;
 	struct fib_info		*fi;
 	struct fib_table	*table;
diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index 9bdfdab906fe0..77b97c48da5ea 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -1628,6 +1628,7 @@ int fib_table_lookup(struct fib_table *tb, const struct flowi4 *flp,
 			res->nhc = nhc;
 			res->type = fa->fa_type;
 			res->scope = fi->fib_scope;
+			res->dscp = fa->fa_dscp;
 			res->fi = fi;
 			res->table = tb;
 			res->fa_head = &n->leaf;
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 40b9c579c917e..810779d537bec 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2930,9 +2930,9 @@ EXPORT_SYMBOL_GPL(ip_route_output_tunnel);
 
 /* called with rcu_read_lock held */
 static int rt_fill_info(struct net *net, __be32 dst, __be32 src,
-			struct rtable *rt, u32 table_id, struct flowi4 *fl4,
-			struct sk_buff *skb, u32 portid, u32 seq,
-			unsigned int flags)
+			struct rtable *rt, u32 table_id, dscp_t dscp,
+			struct flowi4 *fl4, struct sk_buff *skb, u32 portid,
+			u32 seq, unsigned int flags)
 {
 	struct rtmsg *r;
 	struct nlmsghdr *nlh;
@@ -2948,7 +2948,7 @@ static int rt_fill_info(struct net *net, __be32 dst, __be32 src,
 	r->rtm_family	 = AF_INET;
 	r->rtm_dst_len	= 32;
 	r->rtm_src_len	= 0;
-	r->rtm_tos	= fl4 ? fl4->flowi4_tos : 0;
+	r->rtm_tos	= inet_dscp_to_dsfield(dscp);
 	r->rtm_table	= table_id < 256 ? table_id : RT_TABLE_COMPAT;
 	if (nla_put_u32(skb, RTA_TABLE, table_id))
 		goto nla_put_failure;
@@ -3098,7 +3098,7 @@ static int fnhe_dump_bucket(struct net *net, struct sk_buff *skb,
 				goto next;
 
 			err = rt_fill_info(net, fnhe->fnhe_daddr, 0, rt,
-					   table_id, NULL, skb,
+					   table_id, 0, NULL, skb,
 					   NETLINK_CB(cb->skb).portid,
 					   cb->nlh->nlmsg_seq, flags);
 			if (err)
@@ -3421,8 +3421,8 @@ static int inet_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		err = fib_dump_info(skb, NETLINK_CB(in_skb).portid,
 				    nlh->nlmsg_seq, RTM_NEWROUTE, &fri, 0);
 	} else {
-		err = rt_fill_info(net, dst, src, rt, table_id, &fl4, skb,
-				   NETLINK_CB(in_skb).portid,
+		err = rt_fill_info(net, dst, src, rt, table_id, res.dscp, &fl4,
+				   skb, NETLINK_CB(in_skb).portid,
 				   nlh->nlmsg_seq, 0);
 	}
 	if (err < 0)
-- 
2.43.0





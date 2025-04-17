Return-Path: <stable+bounces-133717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD823A92709
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD9E617293E
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294FB24BBFD;
	Thu, 17 Apr 2025 18:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lp3ZhegR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CF11A3178;
	Thu, 17 Apr 2025 18:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744913928; cv=none; b=MW1X+AIQcdx+K88ARFCvQ9AqCMQ1cwf9voSUU8v9ZNv4G8DmXWYHmVTKUswoADTKrXpQRbZMgwxlyEpeX0KQ185Vhr65E7qWQ6U1ghtfYHkiY3wsYqRIJWFjb98Q8Q2EG9dTX7PxCS2o/i6XWhMXuTC8I26fxH9DVkOBQvL1V6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744913928; c=relaxed/simple;
	bh=gxUjpb2gW7JALsj9pr19Q3t7o73J/I6M8XiJnzQ4OB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E4QSEwe5zHhR57avrvykEciwzBfj6D6bdBP0YhA/7N1O32uxNYz1+HU855aEHQClU6ucX5xWb7KjoftE3vktjHxO5C6D5NVFohVQfrZZss4WCIszkweuw8y1CF6Cx+OGxXEucqt0IzVPxc+vy2+5ksIURsBHv3pwezWto8B9DHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lp3ZhegR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 651C6C4CEE7;
	Thu, 17 Apr 2025 18:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744913928;
	bh=gxUjpb2gW7JALsj9pr19Q3t7o73J/I6M8XiJnzQ4OB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lp3ZhegRVTMtptce3nuh/tfkV1hz+0Qkk87ROjfFhhmZbxGeCO2+DzIzAevOsrIBZ
	 aLvU3/mBzRBaYRyfowT8LFE81tb+YYuCklxq+WzLFrJN5eOnRfOpaJRuBriTB24/gP
	 0P8J09VfyiXgu5u13W/+1mhudVrfGVi8V8ZjLZtU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Frode Nordahl <frode.nordahl@canonical.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 018/414] tc: Ensure we have enough buffer space when sending filter netlink notifications
Date: Thu, 17 Apr 2025 19:46:16 +0200
Message-ID: <20250417175112.134785817@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175111.386381660@linuxfoundation.org>
References: <20250417175111.386381660@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Toke Høiland-Jørgensen <toke@redhat.com>

[ Upstream commit 369609fc6272c2f6ad666ba4fd913f3baf32908f ]

The tfilter_notify() and tfilter_del_notify() functions assume that
NLMSG_GOODSIZE is always enough to dump the filter chain. This is not
always the case, which can lead to silent notify failures (because the
return code of tfilter_notify() is not always checked). In particular,
this can lead to NLM_F_ECHO not being honoured even though an action
succeeds, which forces userspace to create workarounds[0].

Fix this by increasing the message size if dumping the filter chain into
the allocated skb fails. Use the size of the incoming skb as a size hint
if set, so we can start at a larger value when appropriate.

To trigger this, run the following commands:

 # ip link add type veth
 # tc qdisc replace dev veth0 root handle 1: fq_codel
 # tc -echo filter add dev veth0 parent 1: u32 match u32 0 0 $(for i in $(seq 32); do echo action pedit munge ip dport set 22; done)

Before this fix, tc just returns:

Not a filter(cmd 2)

After the fix, we get the correct echo:

added filter dev veth0 parent 1: protocol all pref 49152 u32 chain 0 fh 800::800 order 2048 key ht 800 bkt 0 terminal flowid not_in_hw
  match 00000000/00000000 at 0
	action order 1:  pedit action pass keys 1
 	index 1 ref 1 bind 1
	key #0  at 20: val 00000016 mask ffff0000
[repeated 32 times]

[0] https://github.com/openvswitch/ovs/commit/106ef21860c935e5e0017a88bf42b94025c4e511

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Frode Nordahl <frode.nordahl@canonical.com>
Closes: https://bugs.launchpad.net/ubuntu/+source/openvswitch/+bug/2018500
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Link: https://patch.msgid.link/20250407105542.16601-1-toke@redhat.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/cls_api.c | 66 ++++++++++++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 21 deletions(-)

diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 4f648af8cfaaf..ecec0a1e1c1a0 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -2057,6 +2057,7 @@ static int tcf_fill_node(struct net *net, struct sk_buff *skb,
 	struct tcmsg *tcm;
 	struct nlmsghdr  *nlh;
 	unsigned char *b = skb_tail_pointer(skb);
+	int ret = -EMSGSIZE;
 
 	nlh = nlmsg_put(skb, portid, seq, event, sizeof(*tcm), flags);
 	if (!nlh)
@@ -2101,11 +2102,45 @@ static int tcf_fill_node(struct net *net, struct sk_buff *skb,
 
 	return skb->len;
 
+cls_op_not_supp:
+	ret = -EOPNOTSUPP;
 out_nlmsg_trim:
 nla_put_failure:
-cls_op_not_supp:
 	nlmsg_trim(skb, b);
-	return -1;
+	return ret;
+}
+
+static struct sk_buff *tfilter_notify_prep(struct net *net,
+					   struct sk_buff *oskb,
+					   struct nlmsghdr *n,
+					   struct tcf_proto *tp,
+					   struct tcf_block *block,
+					   struct Qdisc *q, u32 parent,
+					   void *fh, int event,
+					   u32 portid, bool rtnl_held,
+					   struct netlink_ext_ack *extack)
+{
+	unsigned int size = oskb ? max(NLMSG_GOODSIZE, oskb->len) : NLMSG_GOODSIZE;
+	struct sk_buff *skb;
+	int ret;
+
+retry:
+	skb = alloc_skb(size, GFP_KERNEL);
+	if (!skb)
+		return ERR_PTR(-ENOBUFS);
+
+	ret = tcf_fill_node(net, skb, tp, block, q, parent, fh, portid,
+			    n->nlmsg_seq, n->nlmsg_flags, event, false,
+			    rtnl_held, extack);
+	if (ret <= 0) {
+		kfree_skb(skb);
+		if (ret == -EMSGSIZE) {
+			size += NLMSG_GOODSIZE;
+			goto retry;
+		}
+		return ERR_PTR(-EINVAL);
+	}
+	return skb;
 }
 
 static int tfilter_notify(struct net *net, struct sk_buff *oskb,
@@ -2121,16 +2156,10 @@ static int tfilter_notify(struct net *net, struct sk_buff *oskb,
 	if (!unicast && !rtnl_notify_needed(net, n->nlmsg_flags, RTNLGRP_TC))
 		return 0;
 
-	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
-	if (!skb)
-		return -ENOBUFS;
-
-	if (tcf_fill_node(net, skb, tp, block, q, parent, fh, portid,
-			  n->nlmsg_seq, n->nlmsg_flags, event,
-			  false, rtnl_held, extack) <= 0) {
-		kfree_skb(skb);
-		return -EINVAL;
-	}
+	skb = tfilter_notify_prep(net, oskb, n, tp, block, q, parent, fh, event,
+				  portid, rtnl_held, extack);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
 
 	if (unicast)
 		err = rtnl_unicast(skb, net, portid);
@@ -2153,16 +2182,11 @@ static int tfilter_del_notify(struct net *net, struct sk_buff *oskb,
 	if (!rtnl_notify_needed(net, n->nlmsg_flags, RTNLGRP_TC))
 		return tp->ops->delete(tp, fh, last, rtnl_held, extack);
 
-	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
-	if (!skb)
-		return -ENOBUFS;
-
-	if (tcf_fill_node(net, skb, tp, block, q, parent, fh, portid,
-			  n->nlmsg_seq, n->nlmsg_flags, RTM_DELTFILTER,
-			  false, rtnl_held, extack) <= 0) {
+	skb = tfilter_notify_prep(net, oskb, n, tp, block, q, parent, fh,
+				  RTM_DELTFILTER, portid, rtnl_held, extack);
+	if (IS_ERR(skb)) {
 		NL_SET_ERR_MSG(extack, "Failed to build del event notification");
-		kfree_skb(skb);
-		return -EINVAL;
+		return PTR_ERR(skb);
 	}
 
 	err = tp->ops->delete(tp, fh, last, rtnl_held, extack);
-- 
2.39.5





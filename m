Return-Path: <stable+bounces-125452-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A192FA69164
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 15:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECBCC3AF88A
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AC022155E;
	Wed, 19 Mar 2025 14:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sPcGyGWi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D8A1C8618;
	Wed, 19 Mar 2025 14:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395197; cv=none; b=sa2b5StACNh0zSaV+S6PELRzFfp+s1XGQeEpYs9pB9qsQ47T88BRE3hDK/J0cn9BogERkIannh9aD+2gU9Aa5RslI6+x8J8E1VzcrOnzrpNOl2FzbU7xkYdcMQt6eD1BQQaojLTrWO1fB1MSD4Kffkzqs7S952PZr5CwXN/tC3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395197; c=relaxed/simple;
	bh=ihbKsClGsnSiALq3gkost3thQBqtx3EuOeR7Ts4bNJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DGZ+X4d7uCmAbCW2FzMX17xOZXo5dbnAYWcckGYjj8/tnuumg/33+Uh7NA4Y+05Twxmx4nr45bYXPtvH1uVJCX1WPFg8sbwFdfnSox23H3UnkJPw+C4mzDgaVNal7Sora8HoQ2lJ+y5I46Bq7AH7A8ewTgx5kQAzTKgxwiRFznY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sPcGyGWi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B11C4CEE4;
	Wed, 19 Mar 2025 14:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742395197;
	bh=ihbKsClGsnSiALq3gkost3thQBqtx3EuOeR7Ts4bNJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sPcGyGWiuGzHto/ps20ts4sV+FrDa7EO7TR70LypInbgKbYEatCvMPZ+zBxSM/5y7
	 QSF7aVDbh8rEmqJO9yR3jbt+jTi4ai0DtmumosL/TOLQfzwp3a4fj/89cMoCji74Ys
	 NttpeGYwVXH1NoQCd/2Ky+f2LfPMw7OMvj1hQUbs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ilya Maximets <i.maximets@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 032/166] net: openvswitch: remove misbehaving actions length check
Date: Wed, 19 Mar 2025 07:30:03 -0700
Message-ID: <20250319143020.859047462@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319143019.983527953@linuxfoundation.org>
References: <20250319143019.983527953@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Ilya Maximets <i.maximets@ovn.org>

[ Upstream commit a1e64addf3ff9257b45b78bc7d743781c3f41340 ]

The actions length check is unreliable and produces different results
depending on the initial length of the provided netlink attribute and
the composition of the actual actions inside of it.  For example, a
user can add 4088 empty clone() actions without triggering -EMSGSIZE,
on attempt to add 4089 such actions the operation will fail with the
-EMSGSIZE verdict.  However, if another 16 KB of other actions will
be *appended* to the previous 4089 clone() actions, the check passes
and the flow is successfully installed into the openvswitch datapath.

The reason for a such a weird behavior is the way memory is allocated.
When ovs_flow_cmd_new() is invoked, it calls ovs_nla_copy_actions(),
that in turn calls nla_alloc_flow_actions() with either the actual
length of the user-provided actions or the MAX_ACTIONS_BUFSIZE.  The
function adds the size of the sw_flow_actions structure and then the
actually allocated memory is rounded up to the closest power of two.

So, if the user-provided actions are larger than MAX_ACTIONS_BUFSIZE,
then MAX_ACTIONS_BUFSIZE + sizeof(*sfa) rounded up is 32K + 24 -> 64K.
Later, while copying individual actions, we look at ksize(), which is
64K, so this way the MAX_ACTIONS_BUFSIZE check is not actually
triggered and the user can easily allocate almost 64 KB of actions.

However, when the initial size is less than MAX_ACTIONS_BUFSIZE, but
the actions contain ones that require size increase while copying
(such as clone() or sample()), then the limit check will be performed
during the reserve_sfa_size() and the user will not be allowed to
create actions that yield more than 32 KB internally.

This is one part of the problem.  The other part is that it's not
actually possible for the userspace application to know beforehand
if the particular set of actions will be rejected or not.

Certain actions require more space in the internal representation,
e.g. an empty clone() takes 4 bytes in the action list passed in by
the user, but it takes 12 bytes in the internal representation due
to an extra nested attribute, and some actions require less space in
the internal representations, e.g. set(tunnel(..)) normally takes
64+ bytes in the action list provided by the user, but only needs to
store a single pointer in the internal implementation, since all the
data is stored in the tunnel_info structure instead.

And the action size limit is applied to the internal representation,
not to the action list passed by the user.  So, it's not possible for
the userpsace application to predict if the certain combination of
actions will be rejected or not, because it is not possible for it to
calculate how much space these actions will take in the internal
representation without knowing kernel internals.

All that is causing random failures in ovs-vswitchd in userspace and
inability to handle certain traffic patterns as a result.  For example,
it is reported that adding a bit more than a 1100 VMs in an OpenStack
setup breaks the network due to OVS not being able to handle ARP
traffic anymore in some cases (it tries to install a proper datapath
flow, but the kernel rejects it with -EMSGSIZE, even though the action
list isn't actually that large.)

Kernel behavior must be consistent and predictable in order for the
userspace application to use it in a reasonable way.  ovs-vswitchd has
a mechanism to re-direct parts of the traffic and partially handle it
in userspace if the required action list is oversized, but that doesn't
work properly if we can't actually tell if the action list is oversized
or not.

Solution for this is to check the size of the user-provided actions
instead of the internal representation.  This commit just removes the
check from the internal part because there is already an implicit size
check imposed by the netlink protocol.  The attribute can't be larger
than 64 KB.  Realistically, we could reduce the limit to 32 KB, but
we'll be risking to break some existing setups that rely on the fact
that it's possible to create nearly 64 KB action lists today.

Vast majority of flows in real setups are below 100-ish bytes.  So
removal of the limit will not change real memory consumption on the
system.  The absolutely worst case scenario is if someone adds a flow
with 64 KB of empty clone() actions.  That will yield a 192 KB in the
internal representation consuming 256 KB block of memory.  However,
that list of actions is not meaningful and also a no-op.  Real world
very large action lists (that can occur for a rare cases of BUM
traffic handling) are unlikely to contain a large number of clones and
will likely have a lot of tunnel attributes making the internal
representation comparable in size to the original action list.
So, it should be fine to just remove the limit.

Commit in the 'Fixes' tag is the first one that introduced the
difference between internal representation and the user-provided action
lists, but there were many more afterwards that lead to the situation
we have today.

Fixes: 7d5437c709de ("openvswitch: Add tunneling interface.")
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
Reviewed-by: Aaron Conole <aconole@redhat.com>
Link: https://patch.msgid.link/20250308004609.2881861-1-i.maximets@ovn.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/openvswitch/flow_netlink.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
index ebc5728aab4ea..9c13e14034d3b 100644
--- a/net/openvswitch/flow_netlink.c
+++ b/net/openvswitch/flow_netlink.c
@@ -2304,14 +2304,10 @@ int ovs_nla_put_mask(const struct sw_flow *flow, struct sk_buff *skb)
 				OVS_FLOW_ATTR_MASK, true, skb);
 }
 
-#define MAX_ACTIONS_BUFSIZE	(32 * 1024)
-
 static struct sw_flow_actions *nla_alloc_flow_actions(int size)
 {
 	struct sw_flow_actions *sfa;
 
-	WARN_ON_ONCE(size > MAX_ACTIONS_BUFSIZE);
-
 	sfa = kmalloc(kmalloc_size_roundup(sizeof(*sfa) + size), GFP_KERNEL);
 	if (!sfa)
 		return ERR_PTR(-ENOMEM);
@@ -2467,15 +2463,6 @@ static struct nlattr *reserve_sfa_size(struct sw_flow_actions **sfa,
 
 	new_acts_size = max(next_offset + req_size, ksize(*sfa) * 2);
 
-	if (new_acts_size > MAX_ACTIONS_BUFSIZE) {
-		if ((next_offset + req_size) > MAX_ACTIONS_BUFSIZE) {
-			OVS_NLERR(log, "Flow action size exceeds max %u",
-				  MAX_ACTIONS_BUFSIZE);
-			return ERR_PTR(-EMSGSIZE);
-		}
-		new_acts_size = MAX_ACTIONS_BUFSIZE;
-	}
-
 	acts = nla_alloc_flow_actions(new_acts_size);
 	if (IS_ERR(acts))
 		return (void *)acts;
@@ -3502,7 +3489,7 @@ int ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 	int err;
 	u32 mpls_label_count = 0;
 
-	*sfa = nla_alloc_flow_actions(min(nla_len(attr), MAX_ACTIONS_BUFSIZE));
+	*sfa = nla_alloc_flow_actions(nla_len(attr));
 	if (IS_ERR(*sfa))
 		return PTR_ERR(*sfa);
 
-- 
2.39.5





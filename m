Return-Path: <stable+bounces-150214-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A446ACB68A
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F23624A0CEB
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038DC22B8A1;
	Mon,  2 Jun 2025 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CmyVLX8O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D4422ACF2;
	Mon,  2 Jun 2025 14:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748876397; cv=none; b=WHMEf4W9t3KCWu4dfhmdpjqOwMv06988dL3b3Xm357X/o85JLHLTpHJIX/0rJJ9RU9YiH/aqZOqompVmDkCyE0VDZR9S1YPP/U5E4Cf2J/c5fs6DOHOIqCGQbEwv/jsoOFHc3IR9yynGy4fQhbXG28Fh/WohagGuhISV6Z79lQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748876397; c=relaxed/simple;
	bh=hxaIGH6wy37JI6z/BZoC1FGlu8kC1pg/DeY6xnCmHV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KouTDBuI5c4e0oQ7lmr27s1Np5xdjGyVCXi+Hjo6+UPXcqB5XTdJn8IaURv6Kycfud2iWaSZuuf55ygE8GVmLmwosbbwkEOwpjo6e8XTBQYyx5zq5dMvX8nmMNR92mtAU/2g2SeAx/vuxvTsSvjJvLAu5ZHNCva+ZBesCZ1R7Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CmyVLX8O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CBB6C4CEEB;
	Mon,  2 Jun 2025 14:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748876397;
	bh=hxaIGH6wy37JI6z/BZoC1FGlu8kC1pg/DeY6xnCmHV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CmyVLX8O0bUiARxTn2dLv87oghWLhorsJnhUgJuodpEO12W44OnxBovuCbxGHteFc
	 ypPA0c2J1jwhNncRhjVWxfI0Liih4SynYa8DZm0n3ed23yPo4+yCyClSx4yvrQzaAy
	 ZbIl5XKet6nNDLEF1cGvEEp6oUQLI5X7QqZHwUmo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 165/207] bridge: netfilter: Fix forwarding of fragmented packets
Date: Mon,  2 Jun 2025 15:48:57 +0200
Message-ID: <20250602134305.201021360@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134258.769974467@linuxfoundation.org>
References: <20250602134258.769974467@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ido Schimmel <idosch@nvidia.com>

[ Upstream commit 91b6dbced0ef1d680afdd69b14fc83d50ebafaf3 ]

When netfilter defrag hooks are loaded (due to the presence of conntrack
rules, for example), fragmented packets entering the bridge will be
defragged by the bridge's pre-routing hook (br_nf_pre_routing() ->
ipv4_conntrack_defrag()).

Later on, in the bridge's post-routing hook, the defragged packet will
be fragmented again. If the size of the largest fragment is larger than
what the kernel has determined as the destination MTU (using
ip_skb_dst_mtu()), the defragged packet will be dropped.

Before commit ac6627a28dbf ("net: ipv4: Consolidate ipv4_mtu and
ip_dst_mtu_maybe_forward"), ip_skb_dst_mtu() would return dst_mtu() as
the destination MTU. Assuming the dst entry attached to the packet is
the bridge's fake rtable one, this would simply be the bridge's MTU (see
fake_mtu()).

However, after above mentioned commit, ip_skb_dst_mtu() ends up
returning the route's MTU stored in the dst entry's metrics. Ideally, in
case the dst entry is the bridge's fake rtable one, this should be the
bridge's MTU as the bridge takes care of updating this metric when its
MTU changes (see br_change_mtu()).

Unfortunately, the last operation is a no-op given the metrics attached
to the fake rtable entry are marked as read-only. Therefore,
ip_skb_dst_mtu() ends up returning 1500 (the initial MTU value) and
defragged packets are dropped during fragmentation when dealing with
large fragments and high MTU (e.g., 9k).

Fix by moving the fake rtable entry's metrics to be per-bridge (in a
similar fashion to the fake rtable entry itself) and marking them as
writable, thereby allowing MTU changes to be reflected.

Fixes: 62fa8a846d7d ("net: Implement read-only protection and COW'ing of metrics.")
Fixes: 33eb9873a283 ("bridge: initialize fake_rtable metrics")
Reported-by: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
Closes: https://lore.kernel.org/netdev/PH0PR10MB4504888284FF4CBA648197D0ACB82@PH0PR10MB4504.namprd10.prod.outlook.com/
Tested-by: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://patch.msgid.link/20250515084848.727706-1-idosch@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bridge/br_nf_core.c | 7 ++-----
 net/bridge/br_private.h | 1 +
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/bridge/br_nf_core.c b/net/bridge/br_nf_core.c
index 8c69f0c95a8ed..b8c8deb87407d 100644
--- a/net/bridge/br_nf_core.c
+++ b/net/bridge/br_nf_core.c
@@ -65,17 +65,14 @@ static struct dst_ops fake_dst_ops = {
  * ipt_REJECT needs it.  Future netfilter modules might
  * require us to fill additional fields.
  */
-static const u32 br_dst_default_metrics[RTAX_MAX] = {
-	[RTAX_MTU - 1] = 1500,
-};
-
 void br_netfilter_rtable_init(struct net_bridge *br)
 {
 	struct rtable *rt = &br->fake_rtable;
 
 	atomic_set(&rt->dst.__refcnt, 1);
 	rt->dst.dev = br->dev;
-	dst_init_metrics(&rt->dst, br_dst_default_metrics, true);
+	dst_init_metrics(&rt->dst, br->metrics, false);
+	dst_metric_set(&rt->dst, RTAX_MTU, br->dev->mtu);
 	rt->dst.flags	= DST_NOXFRM | DST_FAKE_RTABLE;
 	rt->dst.ops = &fake_dst_ops;
 }
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index fe61d3b8d0cc2..1718168bd927e 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -466,6 +466,7 @@ struct net_bridge {
 		struct rtable		fake_rtable;
 		struct rt6_info		fake_rt6_info;
 	};
+	u32				metrics[RTAX_MAX];
 #endif
 	u16				group_fwd_mask;
 	u16				group_fwd_mask_required;
-- 
2.39.5





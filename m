Return-Path: <stable+bounces-94407-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8AE9D3D25
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 15:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ED98283A3A
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 14:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AA71C9DFB;
	Wed, 20 Nov 2024 14:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iw2hsF71"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557FC1C9DDB;
	Wed, 20 Nov 2024 14:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732111632; cv=none; b=uTusBdccSIg96YwUaWCAcLAxO7vWI2+jhggLVvSdxx8PWgpCQoOfn6hWixXdiyWtOcf2r9tZan8J8TTDhL1sUdX2EHjlTv89RuEEb5by0TDuTv1Pm6rcg6gTC9oPoZDqweCYrPNBmzyBETLxdf1yOfxiZv8mY/m0aBOd3ARFhQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732111632; c=relaxed/simple;
	bh=Ht1v6VZM0OpLQY36dqQ+vUEe14WDKDbfPqGqSliSrWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ATn+UEIL/fdnVx5ZKzKetA0vV0ATvKI75niRmH9Mc/o4lSllWbavsC4WzTjUUyR8JZHBKehR9SPIddTk4mCkyjAXIkGNqVSO/PYyO4PUz5727MOncrr/eOkSe54XeFNVjcMzcduO3CaobVCuEdmClAcG2GD1aNeaf7HKz5o3PtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iw2hsF71; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587F6C4CED6;
	Wed, 20 Nov 2024 14:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732111632;
	bh=Ht1v6VZM0OpLQY36dqQ+vUEe14WDKDbfPqGqSliSrWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iw2hsF71IyYUOKVKRLiQwMqAhXjhsiO2x78sTypdXxKJw5qftKvg0mkgZzcKErsXI
	 fHs/LBvz5EfAWcoXF8Bd3YrB0OMfZ5Zt7CrVTei77S8MVDfTIZ+BLd5zqVijoH+zp+
	 m6pmWstU6OCOvanM07FZGpAJGvzCdGxO0iDVjtBBKKpHGt0HFA+/OTEOxbC+l5sQhL
	 RIKGCGohLF5YkL1CDJnw8bvE6OG1fUFPOVt/tt9x3tScLTzi0Y+NHcooB/rut8xF1W
	 4vl0j7/MFPWwza1Jg5AAQe8IrLKq0xxlKXosnl0QMRiQZamYLciNbHrZUDolk9QX8W
	 GHaOXzAVzdooA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 6/6] ipmr: Fix access to mfc_cache_list without lock held
Date: Wed, 20 Nov 2024 09:06:36 -0500
Message-ID: <20241120140647.1768984-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120140647.1768984-1-sashal@kernel.org>
References: <20241120140647.1768984-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.62
Content-Transfer-Encoding: 8bit

From: Breno Leitao <leitao@debian.org>

[ Upstream commit e28acc9c1ccfcb24c08e020828f69d0a915b06ae ]

Accessing `mr_table->mfc_cache_list` is protected by an RCU lock. In the
following code flow, the RCU read lock is not held, causing the
following error when `RCU_PROVE` is not held. The same problem might
show up in the IPv6 code path.

	6.12.0-rc5-kbuilder-01145-gbac17284bdcb #33 Tainted: G            E    N
	-----------------------------
	net/ipv4/ipmr_base.c:313 RCU-list traversed in non-reader section!!

	rcu_scheduler_active = 2, debug_locks = 1
		   2 locks held by RetransmitAggre/3519:
		    #0: ffff88816188c6c0 (nlk_cb_mutex-ROUTE){+.+.}-{3:3}, at: __netlink_dump_start+0x8a/0x290
		    #1: ffffffff83fcf7a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_dumpit+0x6b/0x90

	stack backtrace:
		    lockdep_rcu_suspicious
		    mr_table_dump
		    ipmr_rtm_dumproute
		    rtnl_dump_all
		    rtnl_dumpit
		    netlink_dump
		    __netlink_dump_start
		    rtnetlink_rcv_msg
		    netlink_rcv_skb
		    netlink_unicast
		    netlink_sendmsg

This is not a problem per see, since the RTNL lock is held here, so, it
is safe to iterate in the list without the RCU read lock, as suggested
by Eric.

To alleviate the concern, modify the code to use
list_for_each_entry_rcu() with the RTNL-held argument.

The annotation will raise an error only if RTNL or RCU read lock are
missing during iteration, signaling a legitimate problem, otherwise it
will avoid this false positive.

This will solve the IPv6 case as well, since ip6mr_rtm_dumproute() calls
this function as well.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://patch.msgid.link/20241108-ipmr_rcu-v2-1-c718998e209b@debian.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ipmr_base.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ipmr_base.c b/net/ipv4/ipmr_base.c
index 271dc03fc6dbd..f0af12a2f70bc 100644
--- a/net/ipv4/ipmr_base.c
+++ b/net/ipv4/ipmr_base.c
@@ -310,7 +310,8 @@ int mr_table_dump(struct mr_table *mrt, struct sk_buff *skb,
 	if (filter->filter_set)
 		flags |= NLM_F_DUMP_FILTERED;
 
-	list_for_each_entry_rcu(mfc, &mrt->mfc_cache_list, list) {
+	list_for_each_entry_rcu(mfc, &mrt->mfc_cache_list, list,
+				lockdep_rtnl_is_held()) {
 		if (e < s_e)
 			goto next_entry;
 		if (filter->dev &&
-- 
2.43.0



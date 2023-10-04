Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562967B877D
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243800AbjJDSF6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243803AbjJDSF5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:05:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA56A7
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:05:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E459DC433C8;
        Wed,  4 Oct 2023 18:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442753;
        bh=uZBW+yV/9KdYaLzoPVbAP68MSK/UGlaFaS94kLz4j18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j8Gl0hHpji9u2kookZ4JFGA3S0ZBxPuJIsNuQhbqOIv9iyqRu53OpfTuBR4+kA568
         aJgjaCgAGhmAdwxss0l/hJ9CLYKqjfX7c7xzvk2gaF8p+1P+BgfSbsytfQP1hHLX92
         ycZXRZ8vWmz6oVW++xtMEDGPsCPzdY+B+zysSXFY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hangbin Liu <liuhangbin@gmail.com>,
        Ziyang Xuan <william.xuanziyang@huawei.com>,
        Jiri Pirko <jiri@nvidia.com>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 059/183] team: fix null-ptr-deref when team device type is changed
Date:   Wed,  4 Oct 2023 19:54:50 +0200
Message-ID: <20231004175206.372338324@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
References: <20231004175203.943277832@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ziyang Xuan <william.xuanziyang@huawei.com>

[ Upstream commit 492032760127251e5540a5716a70996bacf2a3fd ]

Get a null-ptr-deref bug as follows with reproducer [1].

BUG: kernel NULL pointer dereference, address: 0000000000000228
...
RIP: 0010:vlan_dev_hard_header+0x35/0x140 [8021q]
...
Call Trace:
 <TASK>
 ? __die+0x24/0x70
 ? page_fault_oops+0x82/0x150
 ? exc_page_fault+0x69/0x150
 ? asm_exc_page_fault+0x26/0x30
 ? vlan_dev_hard_header+0x35/0x140 [8021q]
 ? vlan_dev_hard_header+0x8e/0x140 [8021q]
 neigh_connected_output+0xb2/0x100
 ip6_finish_output2+0x1cb/0x520
 ? nf_hook_slow+0x43/0xc0
 ? ip6_mtu+0x46/0x80
 ip6_finish_output+0x2a/0xb0
 mld_sendpack+0x18f/0x250
 mld_ifc_work+0x39/0x160
 process_one_work+0x1e6/0x3f0
 worker_thread+0x4d/0x2f0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xe5/0x120
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x34/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1b/0x30

[1]
$ teamd -t team0 -d -c '{"runner": {"name": "loadbalance"}}'
$ ip link add name t-dummy type dummy
$ ip link add link t-dummy name t-dummy.100 type vlan id 100
$ ip link add name t-nlmon type nlmon
$ ip link set t-nlmon master team0
$ ip link set t-nlmon nomaster
$ ip link set t-dummy up
$ ip link set team0 up
$ ip link set t-dummy.100 down
$ ip link set t-dummy.100 master team0

When enslave a vlan device to team device and team device type is changed
from non-ether to ether, header_ops of team device is changed to
vlan_header_ops. That is incorrect and will trigger null-ptr-deref
for vlan->real_dev in vlan_dev_hard_header() because team device is not
a vlan device.

Cache eth_header_ops in team_setup(), then assign cached header_ops to
header_ops of team net device when its type is changed from non-ether
to ether to fix the bug.

Fixes: 1d76efe1577b ("team: add support for non-ethernet devices")
Suggested-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20230918123011.1884401-1-william.xuanziyang@huawei.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/team/team.c | 10 +++++++++-
 include/linux/if_team.h |  2 ++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index f99df92d211e2..44275094906c0 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -2122,7 +2122,12 @@ static const struct ethtool_ops team_ethtool_ops = {
 static void team_setup_by_port(struct net_device *dev,
 			       struct net_device *port_dev)
 {
-	dev->header_ops	= port_dev->header_ops;
+	struct team *team = netdev_priv(dev);
+
+	if (port_dev->type == ARPHRD_ETHER)
+		dev->header_ops	= team->header_ops_cache;
+	else
+		dev->header_ops	= port_dev->header_ops;
 	dev->type = port_dev->type;
 	dev->hard_header_len = port_dev->hard_header_len;
 	dev->needed_headroom = port_dev->needed_headroom;
@@ -2169,8 +2174,11 @@ static int team_dev_type_check_change(struct net_device *dev,
 
 static void team_setup(struct net_device *dev)
 {
+	struct team *team = netdev_priv(dev);
+
 	ether_setup(dev);
 	dev->max_mtu = ETH_MAX_MTU;
+	team->header_ops_cache = dev->header_ops;
 
 	dev->netdev_ops = &team_netdev_ops;
 	dev->ethtool_ops = &team_ethtool_ops;
diff --git a/include/linux/if_team.h b/include/linux/if_team.h
index 5dd1657947b75..762c77d13e7dd 100644
--- a/include/linux/if_team.h
+++ b/include/linux/if_team.h
@@ -189,6 +189,8 @@ struct team {
 	struct net_device *dev; /* associated netdevice */
 	struct team_pcpu_stats __percpu *pcpu_stats;
 
+	const struct header_ops *header_ops_cache;
+
 	struct mutex lock; /* used for overall locking, e.g. port lists write */
 
 	/*
-- 
2.40.1




Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAC670C850
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbjEVTiA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbjEVThq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:37:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A532510CB
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:37:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6222C629A0
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:37:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78537C433D2;
        Mon, 22 May 2023 19:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784243;
        bh=1kNWwNWk0DUW8a0f1nKHzTVEghcuh1tguqnPrlNdfCA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SYZg3BCT+fiR6GSKUiwMwx7Oen+4Tq9n68+lWEu8SzuwkoyAimbhNcnsJp/Pr6+Sr
         NYVgxh5mo710gV4aCg238MbQTquYr0YrdtkGy9ygcRQnWQFtDGGwPAJFfdNn1RkTPu
         Ak66GpePwykbTDPZ6p/gbMF0c9XS7U/BSXGsmYt8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Liang Li <liali@redhat.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 018/364] bonding: fix send_peer_notif overflow
Date:   Mon, 22 May 2023 20:05:23 +0100
Message-Id: <20230522190413.282740272@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 9949e2efb54eb3001cb2f6512ff3166dddbfb75d ]

Bonding send_peer_notif was defined as u8. Since commit 07a4ddec3ce9
("bonding: add an option to specify a delay between peer notifications").
the bond->send_peer_notif will be num_peer_notif multiplied by
peer_notif_delay, which is u8 * u32. This would cause the send_peer_notif
overflow easily. e.g.

  ip link add bond0 type bond mode 1 miimon 100 num_grat_arp 30 peer_notify_delay 1000

To fix the overflow, let's set the send_peer_notif to u32 and limit
peer_notif_delay to 300s.

Reported-by: Liang Li <liali@redhat.com>
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2090053
Fixes: 07a4ddec3ce9 ("bonding: add an option to specify a delay between peer notifications")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/bonding/bond_netlink.c | 7 ++++++-
 drivers/net/bonding/bond_options.c | 8 +++++++-
 include/net/bonding.h              | 2 +-
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index c2d080fc4fc4e..27cbe148f0db5 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -84,6 +84,11 @@ static int bond_fill_slave_info(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
+/* Limit the max delay range to 300s */
+static struct netlink_range_validation delay_range = {
+	.max = 300000,
+};
+
 static const struct nla_policy bond_policy[IFLA_BOND_MAX + 1] = {
 	[IFLA_BOND_MODE]		= { .type = NLA_U8 },
 	[IFLA_BOND_ACTIVE_SLAVE]	= { .type = NLA_U32 },
@@ -114,7 +119,7 @@ static const struct nla_policy bond_policy[IFLA_BOND_MAX + 1] = {
 	[IFLA_BOND_AD_ACTOR_SYSTEM]	= { .type = NLA_BINARY,
 					    .len  = ETH_ALEN },
 	[IFLA_BOND_TLB_DYNAMIC_LB]	= { .type = NLA_U8 },
-	[IFLA_BOND_PEER_NOTIF_DELAY]    = { .type = NLA_U32 },
+	[IFLA_BOND_PEER_NOTIF_DELAY]    = NLA_POLICY_FULL_RANGE(NLA_U32, &delay_range),
 	[IFLA_BOND_MISSED_MAX]		= { .type = NLA_U8 },
 	[IFLA_BOND_NS_IP6_TARGET]	= { .type = NLA_NESTED },
 };
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index f71d5517f8293..5310cb488f11d 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -169,6 +169,12 @@ static const struct bond_opt_value bond_num_peer_notif_tbl[] = {
 	{ NULL,      -1,  0}
 };
 
+static const struct bond_opt_value bond_peer_notif_delay_tbl[] = {
+	{ "off",     0,   0},
+	{ "maxval",  300000, BOND_VALFLAG_MAX},
+	{ NULL,      -1,  0}
+};
+
 static const struct bond_opt_value bond_primary_reselect_tbl[] = {
 	{ "always",  BOND_PRI_RESELECT_ALWAYS,  BOND_VALFLAG_DEFAULT},
 	{ "better",  BOND_PRI_RESELECT_BETTER,  0},
@@ -488,7 +494,7 @@ static const struct bond_option bond_opts[BOND_OPT_LAST] = {
 		.id = BOND_OPT_PEER_NOTIF_DELAY,
 		.name = "peer_notif_delay",
 		.desc = "Delay between each peer notification on failover event, in milliseconds",
-		.values = bond_intmax_tbl,
+		.values = bond_peer_notif_delay_tbl,
 		.set = bond_option_peer_notif_delay_set
 	}
 };
diff --git a/include/net/bonding.h b/include/net/bonding.h
index c3843239517d5..2d034e07b796c 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -233,7 +233,7 @@ struct bonding {
 	 */
 	spinlock_t mode_lock;
 	spinlock_t stats_lock;
-	u8	 send_peer_notif;
+	u32	 send_peer_notif;
 	u8       igmp_retrans;
 #ifdef CONFIG_PROC_FS
 	struct   proc_dir_entry *proc_entry;
-- 
2.39.2




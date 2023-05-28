Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5779713DA4
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjE1T1e (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjE1T1c (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:27:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF007B1
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:27:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF4FD61C4B
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:27:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8F3C4339B;
        Sun, 28 May 2023 19:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302047;
        bh=wsqbfBTK7uP9WtIes5oYrR6aF6HKY0IuQuQ73OSSdN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NM7TDDBsZW/Iv0Ug44oClHP+T3euvVAZBAnEs4UTopkPrcbOI1Rt5z/HRK386UZjt
         YKHjr8pJzhDqNR/2s6aFdf3Qgb6xY5vvO0SpXY2TUThuig1CqbHrpgPyEPl9keVHas
         ky2TuI1IvebTMWzKTBcMA2E/bcqApKmcfr1oF2qc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+60748c96cf5c6df8e581@syzkaller.appspotmail.com,
        Taehee Yoo <ap420073@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.4 140/161] net: fix stack overflow when LRO is disabled for virtual interfaces
Date:   Sun, 28 May 2023 20:11:04 +0100
Message-Id: <20230528190841.398196250@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190837.051205996@linuxfoundation.org>
References: <20230528190837.051205996@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Taehee Yoo <ap420073@gmail.com>

commit ae9b15fbe63447bc1d3bba3769f409d17ca6fdf6 upstream.

When the virtual interface's feature is updated, it synchronizes the
updated feature for its own lower interface.
This propagation logic should be worked as the iteration, not recursively.
But it works recursively due to the netdev notification unexpectedly.
This problem occurs when it disables LRO only for the team and bonding
interface type.

       team0
         |
  +------+------+-----+-----+
  |      |      |     |     |
team1  team2  team3  ...  team200

If team0's LRO feature is updated, it generates the NETDEV_FEAT_CHANGE
event to its own lower interfaces(team1 ~ team200).
It is worked by netdev_sync_lower_features().
So, the NETDEV_FEAT_CHANGE notification logic of each lower interface
work iteratively.
But generated NETDEV_FEAT_CHANGE event is also sent to the upper
interface too.
upper interface(team0) generates the NETDEV_FEAT_CHANGE event for its own
lower interfaces again.
lower and upper interfaces receive this event and generate this
event again and again.
So, the stack overflow occurs.

But it is not the infinite loop issue.
Because the netdev_sync_lower_features() updates features before
generating the NETDEV_FEAT_CHANGE event.
Already synchronized lower interfaces skip notification logic.
So, it is just the problem that iteration logic is changed to the
recursive unexpectedly due to the notification mechanism.

Reproducer:

ip link add team0 type team
ethtool -K team0 lro on
for i in {1..200}
do
        ip link add team$i master team0 type team
        ethtool -K team$i lro on
done

ethtool -K team0 lro off

In order to fix it, the notifier_ctx member of bonding/team is introduced.

Reported-by: syzbot+60748c96cf5c6df8e581@syzkaller.appspotmail.com
Fixes: fd867d51f889 ("net/core: generic support for disabling netdev features down stack")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://lore.kernel.org/r/20230517143010.3596250-1-ap420073@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/bonding/bond_main.c |    8 +++++++-
 drivers/net/team/team.c         |    7 ++++++-
 include/linux/if_team.h         |    1 +
 include/net/bonding.h           |    1 +
 4 files changed, 15 insertions(+), 2 deletions(-)

--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3239,7 +3239,11 @@ static int bond_slave_netdev_event(unsig
 		unblock_netpoll_tx();
 		break;
 	case NETDEV_FEAT_CHANGE:
-		bond_compute_features(bond);
+		if (!bond->notifier_ctx) {
+			bond->notifier_ctx = true;
+			bond_compute_features(bond);
+			bond->notifier_ctx = false;
+		}
 		break;
 	case NETDEV_RESEND_IGMP:
 		/* Propagate to master device */
@@ -4878,6 +4882,8 @@ static int bond_init(struct net_device *
 	if (!bond->wq)
 		return -ENOMEM;
 
+	bond->notifier_ctx = false;
+
 	spin_lock_init(&bond->stats_lock);
 	lockdep_register_key(&bond->stats_lock_key);
 	lockdep_set_class(&bond->stats_lock, &bond->stats_lock_key);
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -1624,6 +1624,7 @@ static int team_init(struct net_device *
 
 	team->dev = dev;
 	team_set_no_mode(team);
+	team->notifier_ctx = false;
 
 	team->pcpu_stats = netdev_alloc_pcpu_stats(struct team_pcpu_stats);
 	if (!team->pcpu_stats)
@@ -3015,7 +3016,11 @@ static int team_device_event(struct noti
 		team_del_slave(port->team->dev, dev);
 		break;
 	case NETDEV_FEAT_CHANGE:
-		team_compute_features(port->team);
+		if (!port->team->notifier_ctx) {
+			port->team->notifier_ctx = true;
+			team_compute_features(port->team);
+			port->team->notifier_ctx = false;
+		}
 		break;
 	case NETDEV_PRECHANGEMTU:
 		/* Forbid to change mtu of underlaying device */
--- a/include/linux/if_team.h
+++ b/include/linux/if_team.h
@@ -211,6 +211,7 @@ struct team {
 	bool queue_override_enabled;
 	struct list_head *qom_lists; /* array of queue override mapping lists */
 	bool port_mtu_change_allowed;
+	bool notifier_ctx;
 	struct {
 		unsigned int count;
 		unsigned int interval; /* in ms */
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -207,6 +207,7 @@ struct bonding {
 	struct   slave __rcu *primary_slave;
 	struct   bond_up_slave __rcu *usable_slaves; /* Array of usable slaves */
 	bool     force_primary;
+	bool     notifier_ctx;
 	s32      slave_cnt; /* never change this value outside the attach/detach wrappers */
 	int     (*recv_probe)(const struct sk_buff *, struct bonding *,
 			      struct slave *);



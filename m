Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1346713A81
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 18:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjE1QVd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 12:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjE1QVc (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 12:21:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586A8B9
        for <stable@vger.kernel.org>; Sun, 28 May 2023 09:21:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E435860B6A
        for <stable@vger.kernel.org>; Sun, 28 May 2023 16:21:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B71EC433D2;
        Sun, 28 May 2023 16:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685290890;
        bh=51ISIOxjTRyPQ8gwoWMMeKmrrVjlEc33XZhYMau4rgc=;
        h=Subject:To:Cc:From:Date:From;
        b=YHrgbW14TRZk56O+tnHQy6QmIMdVIkR/AznDeflLxmvUqkD2hlR/2a+sEqFlkyzCI
         ZXuvv5P9qdP2OoamD3bu+1qkJyU+B6xcYxiR9Y4irfN47vusHIJghv9S+IBHXXvwji
         siWlcZnl+0suZQuM65TdXU8oAihRk8XcD6tagRvo=
Subject: FAILED: patch "[PATCH] net: fix stack overflow when LRO is disabled for virtual" failed to apply to 4.14-stable tree
To:     ap420073@gmail.com, edumazet@google.com, kuba@kernel.org,
        razor@blackwall.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 28 May 2023 17:21:19 +0100
Message-ID: <2023052819-uptake-scorpion-a23a@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x ae9b15fbe63447bc1d3bba3769f409d17ca6fdf6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052819-uptake-scorpion-a23a@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

ae9b15fbe634 ("net: fix stack overflow when LRO is disabled for virtual interfaces")
0e400d602f46 ("bonding: fix NULL deref in bond_rr_gen_slave_id")
ad9bd8daf2f9 ("bonding: fix using uninitialized mode_lock")
f3b0a18bb6cb ("net: remove unnecessary variables and callback")
2bce1ebed17d ("macsec: fix refcnt leak in module exit routine")
089bca2caed0 ("bonding: use dynamic lockdep key instead of subclass")
ab92d68fc22f ("net: core: add generic lockdep keys")
76052d8c4f2d ("vlan: do not transfer link state in vlan bridge binding mode")
35a605db168c ("net/mlx5e: Offload TC e-switch rules with ingress VLAN device")
278748a95aa3 ("net/mlx5e: Offload TC e-switch rules with egress VLAN device")
b71b5837f871 ("packet: rework packet_pick_tx_queue() to use common code selection")
4bd97d51a5e6 ("net: dev: rename queue selection helpers.")
b473b0d23529 ("devlink: create a special NDO for getting the devlink instance")
4eceba17200c ("ethtool: add compat for flash update")
3ceb745baa4c ("devlink: fix condition for compat device info")
a655fe9f1948 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ae9b15fbe63447bc1d3bba3769f409d17ca6fdf6 Mon Sep 17 00:00:00 2001
From: Taehee Yoo <ap420073@gmail.com>
Date: Wed, 17 May 2023 14:30:10 +0000
Subject: [PATCH] net: fix stack overflow when LRO is disabled for virtual
 interfaces

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

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 3fed888629f7..edbaa1444f8e 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3947,7 +3947,11 @@ static int bond_slave_netdev_event(unsigned long event,
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
@@ -6342,6 +6346,8 @@ static int bond_init(struct net_device *bond_dev)
 	if (!bond->wq)
 		return -ENOMEM;
 
+	bond->notifier_ctx = false;
+
 	spin_lock_init(&bond->stats_lock);
 	netdev_lockdep_set_classes(bond_dev);
 
diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index d10606f257c4..555b0b1e9a78 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -1629,6 +1629,7 @@ static int team_init(struct net_device *dev)
 
 	team->dev = dev;
 	team_set_no_mode(team);
+	team->notifier_ctx = false;
 
 	team->pcpu_stats = netdev_alloc_pcpu_stats(struct team_pcpu_stats);
 	if (!team->pcpu_stats)
@@ -3022,7 +3023,11 @@ static int team_device_event(struct notifier_block *unused,
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
diff --git a/include/linux/if_team.h b/include/linux/if_team.h
index fc985e5c739d..8de6b6e67829 100644
--- a/include/linux/if_team.h
+++ b/include/linux/if_team.h
@@ -208,6 +208,7 @@ struct team {
 	bool queue_override_enabled;
 	struct list_head *qom_lists; /* array of queue override mapping lists */
 	bool port_mtu_change_allowed;
+	bool notifier_ctx;
 	struct {
 		unsigned int count;
 		unsigned int interval; /* in ms */
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 0efef2a952b7..59955ac33157 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -221,6 +221,7 @@ struct bonding {
 	struct   bond_up_slave __rcu *usable_slaves;
 	struct   bond_up_slave __rcu *all_slaves;
 	bool     force_primary;
+	bool     notifier_ctx;
 	s32      slave_cnt; /* never change this value outside the attach/detach wrappers */
 	int     (*recv_probe)(const struct sk_buff *, struct bonding *,
 			      struct slave *);


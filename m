Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDBD713F84
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjE1TqP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjE1TqO (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:46:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7209C
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:46:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5909B61F5E
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:46:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77CFDC433D2;
        Sun, 28 May 2023 19:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685303172;
        bh=K+Jf4sLfcZxlB9CwU/Xvo1hf2znIFFY9059nuJvwrtg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TNE4Zi3MfyCfF+cggrAZT8eho7daHs7ODV3PqCS7Sh7luD4lGF662sqJBB+4XLKMe
         uPPWAEb/DDeSTEv/UO/+tlq5TLJu+ifEpwTk9cPGX0r6CS5gID27F3rVn0bNvdmyKo
         9rpSGXYe1AkRb+/c2x4M0U5I5H/Da69c5g7fuI6w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+60748c96cf5c6df8e581@syzkaller.appspotmail.com,
        Taehee Yoo <ap420073@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10 184/211] net: fix stack overflow when LRO is disabled for virtual interfaces
Date:   Sun, 28 May 2023 20:11:45 +0100
Message-Id: <20230528190848.068823631@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190843.514829708@linuxfoundation.org>
References: <20230528190843.514829708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
@@ -3537,7 +3537,11 @@ static int bond_slave_netdev_event(unsig
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
@@ -5360,6 +5364,8 @@ static int bond_init(struct net_device *
 	if (!bond->wq)
 		return -ENOMEM;
 
+	bond->notifier_ctx = false;
+
 	spin_lock_init(&bond->stats_lock);
 	netdev_lockdep_set_classes(bond_dev);
 
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -1624,6 +1624,7 @@ static int team_init(struct net_device *
 
 	team->dev = dev;
 	team_set_no_mode(team);
+	team->notifier_ctx = false;
 
 	team->pcpu_stats = netdev_alloc_pcpu_stats(struct team_pcpu_stats);
 	if (!team->pcpu_stats)
@@ -3016,7 +3017,11 @@ static int team_device_event(struct noti
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
@@ -208,6 +208,7 @@ struct team {
 	bool queue_override_enabled;
 	struct list_head *qom_lists; /* array of queue override mapping lists */
 	bool port_mtu_change_allowed;
+	bool notifier_ctx;
 	struct {
 		unsigned int count;
 		unsigned int interval; /* in ms */
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -216,6 +216,7 @@ struct bonding {
 	struct   bond_up_slave __rcu *usable_slaves;
 	struct   bond_up_slave __rcu *all_slaves;
 	bool     force_primary;
+	bool     notifier_ctx;
 	s32      slave_cnt; /* never change this value outside the attach/detach wrappers */
 	int     (*recv_probe)(const struct sk_buff *, struct bonding *,
 			      struct slave *);



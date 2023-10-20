Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5BD37D1908
	for <lists+stable@lfdr.de>; Sat, 21 Oct 2023 00:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjJTWYH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 20 Oct 2023 18:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjJTWYH (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Oct 2023 18:24:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9904119E
        for <stable@vger.kernel.org>; Fri, 20 Oct 2023 15:24:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12681C433C8;
        Fri, 20 Oct 2023 22:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697840645;
        bh=lLHcXsU+O8nFAQWceIgRAhdaZ7vVlWgC6loMF3nYG3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bXrKS1UyTJ8L2nrnME6BuG6WTWe82sC39WmtIX0TC70FlOtkPeaoeDtydnESV+MnC
         nwq1vJG2pH6C9TjysKpH2rbnJYn+ythGwlBvvddn2EkByM3XkgQHUxtkDa7onqmMeh
         bDHS9CrJVgoq3Tt+NPoTHxuvabMAI0vzRw2t4OnmkhHKuY82LH5dniTXj+6iJ7bBtb
         YrH+BmW7wg6t3vcXRngrT+dYllLDixTqCxJ7MPk74F20eC1EZ3m9sGwh0S5rJx1wVv
         mgj2Yz9oXJqIBZFqPEjfFSbVlOCDoAFKoOcYKOLYUabCadYeRvkKuyDRQEM2wgNq5C
         sXvARQpCpmfzA==
From:   Jakub Kicinski <kuba@kernel.org>
To:     stable@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@nvidia.com>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.1.y] net: move altnames together with the netdevice
Date:   Fri, 20 Oct 2023 15:24:00 -0700
Message-ID: <20231020222401.3438686-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023102010-implicit-rectify-fa06@gregkh>
References: <2023102010-implicit-rectify-fa06@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

[ Upstream commit 8e15aee621618a3ee3abecaf1fd8c1428098b7ef ]

The altname nodes are currently not moved to the new netns
when netdevice itself moves:

  [ ~]# ip netns add test
  [ ~]# ip -netns test link add name eth0 type dummy
  [ ~]# ip -netns test link property add dev eth0 altname some-name
  [ ~]# ip -netns test link show dev some-name
  2: eth0: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
      link/ether 1e:67:ed:19:3d:24 brd ff:ff:ff:ff:ff:ff
      altname some-name
  [ ~]# ip -netns test link set dev eth0 netns 1
  [ ~]# ip link
  ...
  3: eth0: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
      link/ether 02:40:88:62:ec:b8 brd ff:ff:ff:ff:ff:ff
      altname some-name
  [ ~]# ip li show dev some-name
  Device "some-name" does not exist.

Remove them from the hash table when device is unlisted
and add back when listed again.

Fixes: 36fbf1e52bd3 ("net: rtnetlink: add linkprop commands to add and delete alternative ifnames")
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/core/dev.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 45ec18d8b0f6..fe8c46c46505 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -379,6 +379,7 @@ static void netdev_name_node_alt_flush(struct net_device *dev)
 /* Device list insertion */
 static void list_netdevice(struct net_device *dev)
 {
+	struct netdev_name_node *name_node;
 	struct net *net = dev_net(dev);
 
 	ASSERT_RTNL();
@@ -390,6 +391,9 @@ static void list_netdevice(struct net_device *dev)
 			   dev_index_hash(net, dev->ifindex));
 	write_unlock(&dev_base_lock);
 
+	netdev_for_each_altname(dev, name_node)
+		netdev_name_node_add(net, name_node);
+
 	dev_base_seq_inc(net);
 }
 
@@ -398,8 +402,13 @@ static void list_netdevice(struct net_device *dev)
  */
 static void unlist_netdevice(struct net_device *dev, bool lock)
 {
+	struct netdev_name_node *name_node;
+
 	ASSERT_RTNL();
 
+	netdev_for_each_altname(dev, name_node)
+		netdev_name_node_del(name_node);
+
 	/* Unlink dev from the device chain */
 	if (lock)
 		write_lock(&dev_base_lock);
@@ -10854,7 +10863,6 @@ void unregister_netdevice_many_notify(struct list_head *head,
 	synchronize_net();
 
 	list_for_each_entry(dev, head, unreg_list) {
-		struct netdev_name_node *name_node;
 		struct sk_buff *skb = NULL;
 
 		/* Shutdown queueing discipline. */
@@ -10882,9 +10890,6 @@ void unregister_netdevice_many_notify(struct list_head *head,
 		dev_uc_flush(dev);
 		dev_mc_flush(dev);
 
-		netdev_for_each_altname(dev, name_node)
-			netdev_name_node_del(name_node);
-		synchronize_rcu();
 		netdev_name_node_alt_flush(dev);
 		netdev_name_node_free(dev->name_node);
 
-- 
2.34.1


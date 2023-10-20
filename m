Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CDD7D1717
	for <lists+stable@lfdr.de>; Fri, 20 Oct 2023 22:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjJTUeS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 20 Oct 2023 16:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjJTUeR (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Oct 2023 16:34:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3431BF
        for <stable@vger.kernel.org>; Fri, 20 Oct 2023 13:34:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B01C433C8;
        Fri, 20 Oct 2023 20:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697834055;
        bh=X15sSUpZQpC4o2hvE4eFocQVh5rnsLIon31e2XvmXfQ=;
        h=Subject:To:Cc:From:Date:From;
        b=EHoiHD3mfyvt1yuAhFBwAJ7jwHsdfOFJz+fDsmahFYy/rjC4S527ms/+jIVPg8KV4
         8LX2NAXndOXmAp+p29VbT7LmW4fOYzft5I2Wy9VSV8AzmODM5HpoEd5vmnEVOi87W3
         7MKo/y/rP5Fr1QMSXDGV41+vsS4p0m9Gb8np52HQ=
Subject: FAILED: patch "[PATCH] net: move altnames together with the netdevice" failed to apply to 6.1-stable tree
To:     kuba@kernel.org, jiri@nvidia.com, pabeni@redhat.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 20 Oct 2023 22:34:10 +0200
Message-ID: <2023102010-implicit-rectify-fa06@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 8e15aee621618a3ee3abecaf1fd8c1428098b7ef
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102010-implicit-rectify-fa06@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8e15aee621618a3ee3abecaf1fd8c1428098b7ef Mon Sep 17 00:00:00 2001
From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 17 Oct 2023 18:38:16 -0700
Subject: [PATCH] net: move altnames together with the netdevice

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

diff --git a/net/core/dev.c b/net/core/dev.c
index 559705aeefe4..9f3f8930c691 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -381,6 +381,7 @@ static void netdev_name_node_alt_flush(struct net_device *dev)
 /* Device list insertion */
 static void list_netdevice(struct net_device *dev)
 {
+	struct netdev_name_node *name_node;
 	struct net *net = dev_net(dev);
 
 	ASSERT_RTNL();
@@ -391,6 +392,10 @@ static void list_netdevice(struct net_device *dev)
 	hlist_add_head_rcu(&dev->index_hlist,
 			   dev_index_hash(net, dev->ifindex));
 	write_unlock(&dev_base_lock);
+
+	netdev_for_each_altname(dev, name_node)
+		netdev_name_node_add(net, name_node);
+
 	/* We reserved the ifindex, this can't fail */
 	WARN_ON(xa_store(&net->dev_by_index, dev->ifindex, dev, GFP_KERNEL));
 
@@ -402,12 +407,16 @@ static void list_netdevice(struct net_device *dev)
  */
 static void unlist_netdevice(struct net_device *dev, bool lock)
 {
+	struct netdev_name_node *name_node;
 	struct net *net = dev_net(dev);
 
 	ASSERT_RTNL();
 
 	xa_erase(&net->dev_by_index, dev->ifindex);
 
+	netdev_for_each_altname(dev, name_node)
+		netdev_name_node_del(name_node);
+
 	/* Unlink dev from the device chain */
 	if (lock)
 		write_lock(&dev_base_lock);
@@ -10942,7 +10951,6 @@ void unregister_netdevice_many_notify(struct list_head *head,
 	synchronize_net();
 
 	list_for_each_entry(dev, head, unreg_list) {
-		struct netdev_name_node *name_node;
 		struct sk_buff *skb = NULL;
 
 		/* Shutdown queueing discipline. */
@@ -10970,9 +10978,6 @@ void unregister_netdevice_many_notify(struct list_head *head,
 		dev_uc_flush(dev);
 		dev_mc_flush(dev);
 
-		netdev_for_each_altname(dev, name_node)
-			netdev_name_node_del(name_node);
-		synchronize_rcu();
 		netdev_name_node_alt_flush(dev);
 		netdev_name_node_free(dev->name_node);
 


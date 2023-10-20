Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9155C7D17A1
	for <lists+stable@lfdr.de>; Fri, 20 Oct 2023 22:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjJTU40 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 20 Oct 2023 16:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjJTU40 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Oct 2023 16:56:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A00BF
        for <stable@vger.kernel.org>; Fri, 20 Oct 2023 13:56:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C117C433C9;
        Fri, 20 Oct 2023 20:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697835384;
        bh=o1s8Fl6AD1JNdApUUAnxX7uPBwMRG4OMv/kFOh0BWxg=;
        h=Subject:To:Cc:From:Date:From;
        b=iUlgQseKydT3tHzJagIZ4LJE8M3l2eq9Bp5kIMG03feJ5Sn/s7mx1x5D58OWs/Q/c
         ZCrBAwe0deG5/Gjm55W6vlhi+sfl+XyzY7s7IDECD3gHNMOj21yJkgshgLaJjIzprP
         CBX2aNSW+bYrWvC9ILrkx0mKjN886Sh/g5edFTX0=
Subject: FAILED: patch "[PATCH] net: avoid UAF on deleted altname" failed to apply to 5.10-stable tree
To:     kuba@kernel.org, jiri@nvidia.com, pabeni@redhat.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 20 Oct 2023 22:54:23 +0200
Message-ID: <2023102023-ignore-graveness-861d@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 1a83f4a7c156fa6bbd6b530e89fa3270bf3d9d1b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102023-ignore-graveness-861d@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1a83f4a7c156fa6bbd6b530e89fa3270bf3d9d1b Mon Sep 17 00:00:00 2001
From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 17 Oct 2023 18:38:15 -0700
Subject: [PATCH] net: avoid UAF on deleted altname

Altnames are accessed under RCU (dev_get_by_name_rcu())
but freed by kfree() with no synchronization point.

Each node has one or two allocations (node and a variable-size
name, sometimes the name is netdev->name). Adding rcu_heads
here is a bit tedious. Besides most code which unlists the names
already has rcu barriers - so take the simpler approach of adding
synchronize_rcu(). Note that the one on the unregistration path
(which matters more) is removed by the next fix.

Fixes: ff92741270bf ("net: introduce name_node struct to be used in hashlist")
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/net/core/dev.c b/net/core/dev.c
index ae557193b77c..559705aeefe4 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -345,7 +345,6 @@ int netdev_name_node_alt_create(struct net_device *dev, const char *name)
 static void __netdev_name_node_alt_destroy(struct netdev_name_node *name_node)
 {
 	list_del(&name_node->list);
-	netdev_name_node_del(name_node);
 	kfree(name_node->name);
 	netdev_name_node_free(name_node);
 }
@@ -364,6 +363,8 @@ int netdev_name_node_alt_destroy(struct net_device *dev, const char *name)
 	if (name_node == dev->name_node || name_node->dev != dev)
 		return -EINVAL;
 
+	netdev_name_node_del(name_node);
+	synchronize_rcu();
 	__netdev_name_node_alt_destroy(name_node);
 
 	return 0;
@@ -10941,6 +10942,7 @@ void unregister_netdevice_many_notify(struct list_head *head,
 	synchronize_net();
 
 	list_for_each_entry(dev, head, unreg_list) {
+		struct netdev_name_node *name_node;
 		struct sk_buff *skb = NULL;
 
 		/* Shutdown queueing discipline. */
@@ -10968,6 +10970,9 @@ void unregister_netdevice_many_notify(struct list_head *head,
 		dev_uc_flush(dev);
 		dev_mc_flush(dev);
 
+		netdev_for_each_altname(dev, name_node)
+			netdev_name_node_del(name_node);
+		synchronize_rcu();
 		netdev_name_node_alt_flush(dev);
 		netdev_name_node_free(dev->name_node);
 


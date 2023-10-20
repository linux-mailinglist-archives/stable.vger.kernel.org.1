Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7719A7D1714
	for <lists+stable@lfdr.de>; Fri, 20 Oct 2023 22:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjJTUeC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 20 Oct 2023 16:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjJTUeC (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Oct 2023 16:34:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792501BF
        for <stable@vger.kernel.org>; Fri, 20 Oct 2023 13:34:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97ED5C433C7;
        Fri, 20 Oct 2023 20:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697834040;
        bh=/Fknodc6SfBXMCdS6wjX/TVt0G8LMxyxAsSLnUVUFIk=;
        h=Subject:To:Cc:From:Date:From;
        b=BaKiheutTau+TU2u/8T+ZMBjIkYIQgbyqXBn2pxXPDtGJn/lU3jHoe8nIGanhadUz
         vo3mv8jdY+w11R0rSBbku4W2jM4DWCTkIrKeIzBhVEEbeDPEnf1IH+TS/g4PjbKYMN
         I173zx9C85eiIPkvDu8ty+uA4qPX0Cv7MUs0YQW4=
Subject: FAILED: patch "[PATCH] net: check for altname conflicts when changing netdev's netns" failed to apply to 5.10-stable tree
To:     kuba@kernel.org, jiri@nvidia.com, pabeni@redhat.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 20 Oct 2023 22:33:49 +0200
Message-ID: <2023102049-endanger-chief-b8ab@gregkh>
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
git cherry-pick -x 7663d522099ecc464512164e660bc771b2ff7b64
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102049-endanger-chief-b8ab@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7663d522099ecc464512164e660bc771b2ff7b64 Mon Sep 17 00:00:00 2001
From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 17 Oct 2023 18:38:14 -0700
Subject: [PATCH] net: check for altname conflicts when changing netdev's netns

It's currently possible to create an altname conflicting
with an altname or real name of another device by creating
it in another netns and moving it over:

 [ ~]$ ip link add dev eth0 type dummy

 [ ~]$ ip netns add test
 [ ~]$ ip -netns test link add dev ethX netns test type dummy
 [ ~]$ ip -netns test link property add dev ethX altname eth0
 [ ~]$ ip -netns test link set dev ethX netns 1

 [ ~]$ ip link
 ...
 3: eth0: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
     link/ether 02:40:88:62:ec:b8 brd ff:ff:ff:ff:ff:ff
 ...
 5: ethX: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
     link/ether 26:b7:28:78:38:0f brd ff:ff:ff:ff:ff:ff
     altname eth0

Create a macro for walking the altnames, this hopefully makes
it clearer that the list we walk contains only altnames.
Which is otherwise not entirely intuitive.

Fixes: 36fbf1e52bd3 ("net: rtnetlink: add linkprop commands to add and delete alternative ifnames")
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/net/core/dev.c b/net/core/dev.c
index f109ad34d660..ae557193b77c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1086,7 +1086,8 @@ static int __dev_alloc_name(struct net *net, const char *name, char *buf)
 
 		for_each_netdev(net, d) {
 			struct netdev_name_node *name_node;
-			list_for_each_entry(name_node, &d->name_node->list, list) {
+
+			netdev_for_each_altname(d, name_node) {
 				if (!sscanf(name_node->name, name, &i))
 					continue;
 				if (i < 0 || i >= max_netdevices)
@@ -11051,6 +11052,7 @@ EXPORT_SYMBOL(unregister_netdev);
 int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 			       const char *pat, int new_ifindex)
 {
+	struct netdev_name_node *name_node;
 	struct net *net_old = dev_net(dev);
 	char new_name[IFNAMSIZ] = {};
 	int err, new_nsid;
@@ -11083,6 +11085,11 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 		if (err < 0)
 			goto out;
 	}
+	/* Check that none of the altnames conflicts. */
+	err = -EEXIST;
+	netdev_for_each_altname(dev, name_node)
+		if (netdev_name_in_use(net, name_node->name))
+			goto out;
 
 	/* Check that new_ifindex isn't used yet. */
 	if (new_ifindex) {
diff --git a/net/core/dev.h b/net/core/dev.h
index e075e198092c..fa2e9c5c4122 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -62,6 +62,9 @@ struct netdev_name_node {
 int netdev_get_name(struct net *net, char *name, int ifindex);
 int dev_change_name(struct net_device *dev, const char *newname);
 
+#define netdev_for_each_altname(dev, namenode)				\
+	list_for_each_entry((namenode), &(dev)->name_node->list, list)
+
 int netdev_name_node_alt_create(struct net_device *dev, const char *name);
 int netdev_name_node_alt_destroy(struct net_device *dev, const char *name);
 


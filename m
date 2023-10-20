Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898967D1711
	for <lists+stable@lfdr.de>; Fri, 20 Oct 2023 22:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjJTUdn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 20 Oct 2023 16:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjJTUdm (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Oct 2023 16:33:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AADAD65
        for <stable@vger.kernel.org>; Fri, 20 Oct 2023 13:33:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D36C433C9;
        Fri, 20 Oct 2023 20:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697834020;
        bh=9vpQ60YZdXaQLWhXAKp5mQ7iR8Vr5qOxbEinHr1ZkNw=;
        h=Subject:To:Cc:From:Date:From;
        b=u2OTS+2+Dfd0GO96gmLlvMcJsiPSZVXN1adsQnWIjvUD75/ak6CCXh13I0icps5KJ
         sKCFp4B8niB7MkkOeVh5n9Ed7P7hTR9alTSZXfB6+bRkxmExMzqugPUCIWCb/Waamr
         DHXdeFdygzVxpa3ZsIUXdEIQGj/nNlxaLmWIeRUk=
Subject: FAILED: patch "[PATCH] net: fix ifname in netlink ntf during netns move" failed to apply to 4.14-stable tree
To:     kuba@kernel.org, jiri@nvidia.com, pabeni@redhat.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 20 Oct 2023 22:33:28 +0200
Message-ID: <2023102028-tartness-disown-ace1@gregkh>
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


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x 311cca40661f428b7aa114fb5af578cfdbe3e8b6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102028-tartness-disown-ace1@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 311cca40661f428b7aa114fb5af578cfdbe3e8b6 Mon Sep 17 00:00:00 2001
From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 17 Oct 2023 18:38:13 -0700
Subject: [PATCH] net: fix ifname in netlink ntf during netns move

dev_get_valid_name() overwrites the netdev's name on success.
This makes it hard to use in prepare-commit-like fashion,
where we do validation first, and "commit" to the change
later.

Factor out a helper which lets us save the new name to a buffer.
Use it to fix the problem of notification on netns move having
incorrect name:

 5: eth0: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN group default
     link/ether be:4d:58:f9:d5:40 brd ff:ff:ff:ff:ff:ff
 6: eth1: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN group default
     link/ether 1e:4a:34:36:e3:cd brd ff:ff:ff:ff:ff:ff

 [ ~]# ip link set dev eth0 netns 1 name eth1

ip monitor inside netns:
 Deleted inet eth0
 Deleted inet6 eth0
 Deleted 5: eth1: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN group default
     link/ether be:4d:58:f9:d5:40 brd ff:ff:ff:ff:ff:ff new-netnsid 0 new-ifindex 7

Name is reported as eth1 in old netns for ifindex 5, already renamed.

Fixes: d90310243fd7 ("net: device name allocation cleanups")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/net/core/dev.c b/net/core/dev.c
index 5aaf5753d4e4..f109ad34d660 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1123,6 +1123,26 @@ static int __dev_alloc_name(struct net *net, const char *name, char *buf)
 	return -ENFILE;
 }
 
+static int dev_prep_valid_name(struct net *net, struct net_device *dev,
+			       const char *want_name, char *out_name)
+{
+	int ret;
+
+	if (!dev_valid_name(want_name))
+		return -EINVAL;
+
+	if (strchr(want_name, '%')) {
+		ret = __dev_alloc_name(net, want_name, out_name);
+		return ret < 0 ? ret : 0;
+	} else if (netdev_name_in_use(net, want_name)) {
+		return -EEXIST;
+	} else if (out_name != want_name) {
+		strscpy(out_name, want_name, IFNAMSIZ);
+	}
+
+	return 0;
+}
+
 static int dev_alloc_name_ns(struct net *net,
 			     struct net_device *dev,
 			     const char *name)
@@ -1160,19 +1180,13 @@ EXPORT_SYMBOL(dev_alloc_name);
 static int dev_get_valid_name(struct net *net, struct net_device *dev,
 			      const char *name)
 {
-	BUG_ON(!net);
-
-	if (!dev_valid_name(name))
-		return -EINVAL;
-
-	if (strchr(name, '%'))
-		return dev_alloc_name_ns(net, dev, name);
-	else if (netdev_name_in_use(net, name))
-		return -EEXIST;
-	else if (dev->name != name)
-		strscpy(dev->name, name, IFNAMSIZ);
+	char buf[IFNAMSIZ];
+	int ret;
 
-	return 0;
+	ret = dev_prep_valid_name(net, dev, name, buf);
+	if (ret >= 0)
+		strscpy(dev->name, buf, IFNAMSIZ);
+	return ret;
 }
 
 /**
@@ -11038,6 +11052,7 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 			       const char *pat, int new_ifindex)
 {
 	struct net *net_old = dev_net(dev);
+	char new_name[IFNAMSIZ] = {};
 	int err, new_nsid;
 
 	ASSERT_RTNL();
@@ -11064,7 +11079,7 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 		/* We get here if we can't use the current device name */
 		if (!pat)
 			goto out;
-		err = dev_get_valid_name(net, dev, pat);
+		err = dev_prep_valid_name(net, dev, pat, new_name);
 		if (err < 0)
 			goto out;
 	}
@@ -11135,6 +11150,9 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 	kobject_uevent(&dev->dev.kobj, KOBJ_ADD);
 	netdev_adjacent_add_links(dev);
 
+	if (new_name[0]) /* Rename the netdev to prepared name */
+		strscpy(dev->name, new_name, IFNAMSIZ);
+
 	/* Fixup kobjects */
 	err = device_rename(&dev->dev, dev->name);
 	WARN_ON(err);


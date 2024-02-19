Return-Path: <stable+bounces-20712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C2D85AB74
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 19:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4D43284B7F
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C783F433BD;
	Mon, 19 Feb 2024 18:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yC+kJ6NO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8930E41C78
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 18:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708368580; cv=none; b=LTEkvphl67rcPvTItUKUAGzHuCzs9P/7M50SN6DnFgSLujps8WBb3GevBZG0fV6kZwrR7S2RzDQ9nSnPYBRM3Ga9+Z1lPy+yS8Hoj5ffyMUxJOnZEf/dpP5RWA77wgavf3SZbLNoZXhPrT0JANh8TRnfXTwbtltbi7GVIY5RtXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708368580; c=relaxed/simple;
	bh=91SkSUPIUMYiuLFwyUj/WK7DJ1jxB469ciKMoAj9RD4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oeEvbe+XHZrtlnoYh/ya+y7xORfDtcjvtbdI96/PUBAfpNK5A4Mdvh5OWrQYHcpRcdrj6wq+4EFsr9rUEfxmUjxuL0MSVXvbvhUd1HTK+iHMC34hoSp3cBFgKkuECdl8PT8Gz619D+edmTKMHSTNpRUDkdR4ysdLpm64ZquDGxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yC+kJ6NO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9811AC433C7;
	Mon, 19 Feb 2024 18:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708368580;
	bh=91SkSUPIUMYiuLFwyUj/WK7DJ1jxB469ciKMoAj9RD4=;
	h=Subject:To:Cc:From:Date:From;
	b=yC+kJ6NOg+B5OL6k86tKjgy5aYz6XDaBZTs7GdOjVh0tFU5mlKopkHNApfu4aTFpl
	 PAw4VANnZDizF7WDCzhUP7vhZxYn3itgwJLbIL9i4+7EnSE+rfyfma/xRfHHG978HO
	 GplhWS0ZdRd92VngiS5/a9DzVno2Bx808oqTvmwg=
Subject: FAILED: patch "[PATCH] hv_netvsc: Register VF in netvsc_probe if NET_DEVICE_REGISTER" failed to apply to 5.15-stable tree
To: shradhagupta@linux.microsoft.com,davem@davemloft.net,decui@microsoft.com,haiyangz@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 19:49:37 +0100
Message-ID: <2024021937-trace-hardly-10d8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 9cae43da9867412f8bd09aee5c8a8dc5e8dc3dc2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021937-trace-hardly-10d8@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

9cae43da9867 ("hv_netvsc: Register VF in netvsc_probe if NET_DEVICE_REGISTER missed")
c807d6cd089d ("hv_netvsc: Mark VF as slave before exposing it to user-mode")
365e1ececb29 ("hv_netvsc: Fix race between VF offering and VF association message from host")
c60882a4566a ("hv_netvsc: use netif_is_bond_master() instead of open code")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9cae43da9867412f8bd09aee5c8a8dc5e8dc3dc2 Mon Sep 17 00:00:00 2001
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
Date: Thu, 1 Feb 2024 20:40:38 -0800
Subject: [PATCH] hv_netvsc: Register VF in netvsc_probe if NET_DEVICE_REGISTER
 missed

If hv_netvsc driver is unloaded and reloaded, the NET_DEVICE_REGISTER
handler cannot perform VF register successfully as the register call
is received before netvsc_probe is finished. This is because we
register register_netdevice_notifier() very early( even before
vmbus_driver_register()).
To fix this, we try to register each such matching VF( if it is visible
as a netdevice) at the end of netvsc_probe.

Cc: stable@vger.kernel.org
Fixes: 85520856466e ("hv_netvsc: Fix race of register_netdevice_notifier and VF register")
Suggested-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 273bd8a20122..11831a1c9762 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -42,6 +42,10 @@
 #define LINKCHANGE_INT (2 * HZ)
 #define VF_TAKEOVER_INT (HZ / 10)
 
+/* Macros to define the context of vf registration */
+#define VF_REG_IN_PROBE		1
+#define VF_REG_IN_NOTIFIER	2
+
 static unsigned int ring_size __ro_after_init = 128;
 module_param(ring_size, uint, 0444);
 MODULE_PARM_DESC(ring_size, "Ring buffer size (# of 4K pages)");
@@ -2185,7 +2189,7 @@ static rx_handler_result_t netvsc_vf_handle_frame(struct sk_buff **pskb)
 }
 
 static int netvsc_vf_join(struct net_device *vf_netdev,
-			  struct net_device *ndev)
+			  struct net_device *ndev, int context)
 {
 	struct net_device_context *ndev_ctx = netdev_priv(ndev);
 	int ret;
@@ -2208,7 +2212,11 @@ static int netvsc_vf_join(struct net_device *vf_netdev,
 		goto upper_link_failed;
 	}
 
-	schedule_delayed_work(&ndev_ctx->vf_takeover, VF_TAKEOVER_INT);
+	/* If this registration is called from probe context vf_takeover
+	 * is taken care of later in probe itself.
+	 */
+	if (context == VF_REG_IN_NOTIFIER)
+		schedule_delayed_work(&ndev_ctx->vf_takeover, VF_TAKEOVER_INT);
 
 	call_netdevice_notifiers(NETDEV_JOIN, vf_netdev);
 
@@ -2346,7 +2354,7 @@ static int netvsc_prepare_bonding(struct net_device *vf_netdev)
 	return NOTIFY_DONE;
 }
 
-static int netvsc_register_vf(struct net_device *vf_netdev)
+static int netvsc_register_vf(struct net_device *vf_netdev, int context)
 {
 	struct net_device_context *net_device_ctx;
 	struct netvsc_device *netvsc_dev;
@@ -2386,7 +2394,7 @@ static int netvsc_register_vf(struct net_device *vf_netdev)
 
 	netdev_info(ndev, "VF registering: %s\n", vf_netdev->name);
 
-	if (netvsc_vf_join(vf_netdev, ndev) != 0)
+	if (netvsc_vf_join(vf_netdev, ndev, context) != 0)
 		return NOTIFY_DONE;
 
 	dev_hold(vf_netdev);
@@ -2484,10 +2492,31 @@ static int netvsc_unregister_vf(struct net_device *vf_netdev)
 	return NOTIFY_OK;
 }
 
+static int check_dev_is_matching_vf(struct net_device *event_ndev)
+{
+	/* Skip NetVSC interfaces */
+	if (event_ndev->netdev_ops == &device_ops)
+		return -ENODEV;
+
+	/* Avoid non-Ethernet type devices */
+	if (event_ndev->type != ARPHRD_ETHER)
+		return -ENODEV;
+
+	/* Avoid Vlan dev with same MAC registering as VF */
+	if (is_vlan_dev(event_ndev))
+		return -ENODEV;
+
+	/* Avoid Bonding master dev with same MAC registering as VF */
+	if (netif_is_bond_master(event_ndev))
+		return -ENODEV;
+
+	return 0;
+}
+
 static int netvsc_probe(struct hv_device *dev,
 			const struct hv_vmbus_device_id *dev_id)
 {
-	struct net_device *net = NULL;
+	struct net_device *net = NULL, *vf_netdev;
 	struct net_device_context *net_device_ctx;
 	struct netvsc_device_info *device_info = NULL;
 	struct netvsc_device *nvdev;
@@ -2599,6 +2628,30 @@ static int netvsc_probe(struct hv_device *dev,
 	}
 
 	list_add(&net_device_ctx->list, &netvsc_dev_list);
+
+	/* When the hv_netvsc driver is unloaded and reloaded, the
+	 * NET_DEVICE_REGISTER for the vf device is replayed before probe
+	 * is complete. This is because register_netdevice_notifier() gets
+	 * registered before vmbus_driver_register() so that callback func
+	 * is set before probe and we don't miss events like NETDEV_POST_INIT
+	 * So, in this section we try to register the matching vf device that
+	 * is present as a netdevice, knowing that its register call is not
+	 * processed in the netvsc_netdev_notifier(as probing is progress and
+	 * get_netvsc_byslot fails).
+	 */
+	for_each_netdev(dev_net(net), vf_netdev) {
+		ret = check_dev_is_matching_vf(vf_netdev);
+		if (ret != 0)
+			continue;
+
+		if (net != get_netvsc_byslot(vf_netdev))
+			continue;
+
+		netvsc_prepare_bonding(vf_netdev);
+		netvsc_register_vf(vf_netdev, VF_REG_IN_PROBE);
+		__netvsc_vf_setup(net, vf_netdev);
+		break;
+	}
 	rtnl_unlock();
 
 	netvsc_devinfo_put(device_info);
@@ -2754,28 +2807,17 @@ static int netvsc_netdev_event(struct notifier_block *this,
 			       unsigned long event, void *ptr)
 {
 	struct net_device *event_dev = netdev_notifier_info_to_dev(ptr);
+	int ret = 0;
 
-	/* Skip our own events */
-	if (event_dev->netdev_ops == &device_ops)
-		return NOTIFY_DONE;
-
-	/* Avoid non-Ethernet type devices */
-	if (event_dev->type != ARPHRD_ETHER)
-		return NOTIFY_DONE;
-
-	/* Avoid Vlan dev with same MAC registering as VF */
-	if (is_vlan_dev(event_dev))
-		return NOTIFY_DONE;
-
-	/* Avoid Bonding master dev with same MAC registering as VF */
-	if (netif_is_bond_master(event_dev))
+	ret = check_dev_is_matching_vf(event_dev);
+	if (ret != 0)
 		return NOTIFY_DONE;
 
 	switch (event) {
 	case NETDEV_POST_INIT:
 		return netvsc_prepare_bonding(event_dev);
 	case NETDEV_REGISTER:
-		return netvsc_register_vf(event_dev);
+		return netvsc_register_vf(event_dev, VF_REG_IN_NOTIFIER);
 	case NETDEV_UNREGISTER:
 		return netvsc_unregister_vf(event_dev);
 	case NETDEV_UP:



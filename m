Return-Path: <stable+bounces-3240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB1E7FF20F
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 15:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91C45B22031
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 14:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F23C4879F;
	Thu, 30 Nov 2023 14:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="soEleLsH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0E651C2A
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 14:34:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B6AC433C7;
	Thu, 30 Nov 2023 14:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701354899;
	bh=OmH6op77M965unIHssFeyFUUVVR4U/55amfHaXjg10c=;
	h=Subject:To:Cc:From:Date:From;
	b=soEleLsHFDsz7xE3tkUCcxM7UDlJvzDFi741Tf+GsTinAnBNhKwMAIf3Sf6DZ7twV
	 nml/JrAyBc+LoYpFPYAGRjg2lFYxlSEphyoD6QRPdNHySk8skufyfUlRd9/xoATRlC
	 A/u9j4allw2ueVqyT9gcAagSmE2194F7gpLnlnz8=
Subject: FAILED: patch "[PATCH] hv_netvsc: Mark VF as slave before exposing it to user-mode" failed to apply to 4.14-stable tree
To: longli@microsoft.com,decui@microsoft.com,haiyangz@microsoft.com,pabeni@redhat.com,stephen@networkplumber.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 30 Nov 2023 14:34:57 +0000
Message-ID: <2023113056-renounce-jawed-4cae@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x c807d6cd089d2f4951baa838081ec5ae3e2360f8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023113056-renounce-jawed-4cae@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

c807d6cd089d ("hv_netvsc: Mark VF as slave before exposing it to user-mode")
365e1ececb29 ("hv_netvsc: Fix race between VF offering and VF association message from host")
d0922bf79817 ("hv_netvsc: Add error handling while switching data path")
34b06a2eee44 ("hv_netvsc: Process NETDEV_GOING_DOWN on VF hot remove")
8b31f8c982b7 ("hv_netvsc: Wait for completion on request SWITCH_DATA_PATH")
4d18fcc95f50 ("hv_netvsc: Use vmbus_requestor to generate transaction IDs for VMBus hardening")
e8b7db38449a ("Drivers: hv: vmbus: Add vmbus_requestor data structure for VMBus hardening")
4907a43da831 ("Merge tag 'hyperv-next-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c807d6cd089d2f4951baa838081ec5ae3e2360f8 Mon Sep 17 00:00:00 2001
From: Long Li <longli@microsoft.com>
Date: Sun, 19 Nov 2023 08:23:43 -0800
Subject: [PATCH] hv_netvsc: Mark VF as slave before exposing it to user-mode

When a VF is being exposed form the kernel, it should be marked as "slave"
before exposing to the user-mode. The VF is not usable without netvsc
running as master. The user-mode should never see a VF without the "slave"
flag.

This commit moves the code of setting the slave flag to the time before
VF is exposed to user-mode.

Cc: stable@vger.kernel.org
Fixes: 0c195567a8f6 ("netvsc: transparent VF management")
Signed-off-by: Long Li <longli@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index b7dfd51f09e6..706ea5263e87 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2206,9 +2206,6 @@ static int netvsc_vf_join(struct net_device *vf_netdev,
 		goto upper_link_failed;
 	}
 
-	/* set slave flag before open to prevent IPv6 addrconf */
-	vf_netdev->flags |= IFF_SLAVE;
-
 	schedule_delayed_work(&ndev_ctx->vf_takeover, VF_TAKEOVER_INT);
 
 	call_netdevice_notifiers(NETDEV_JOIN, vf_netdev);
@@ -2315,16 +2312,18 @@ static struct net_device *get_netvsc_byslot(const struct net_device *vf_netdev)
 
 	}
 
-	/* Fallback path to check synthetic vf with
-	 * help of mac addr
+	/* Fallback path to check synthetic vf with help of mac addr.
+	 * Because this function can be called before vf_netdev is
+	 * initialized (NETDEV_POST_INIT) when its perm_addr has not been copied
+	 * from dev_addr, also try to match to its dev_addr.
+	 * Note: On Hyper-V and Azure, it's not possible to set a MAC address
+	 * on a VF that matches to the MAC of a unrelated NETVSC device.
 	 */
 	list_for_each_entry(ndev_ctx, &netvsc_dev_list, list) {
 		ndev = hv_get_drvdata(ndev_ctx->device_ctx);
-		if (ether_addr_equal(vf_netdev->perm_addr, ndev->perm_addr)) {
-			netdev_notice(vf_netdev,
-				      "falling back to mac addr based matching\n");
+		if (ether_addr_equal(vf_netdev->perm_addr, ndev->perm_addr) ||
+		    ether_addr_equal(vf_netdev->dev_addr, ndev->perm_addr))
 			return ndev;
-		}
 	}
 
 	netdev_notice(vf_netdev,
@@ -2332,6 +2331,19 @@ static struct net_device *get_netvsc_byslot(const struct net_device *vf_netdev)
 	return NULL;
 }
 
+static int netvsc_prepare_bonding(struct net_device *vf_netdev)
+{
+	struct net_device *ndev;
+
+	ndev = get_netvsc_byslot(vf_netdev);
+	if (!ndev)
+		return NOTIFY_DONE;
+
+	/* set slave flag before open to prevent IPv6 addrconf */
+	vf_netdev->flags |= IFF_SLAVE;
+	return NOTIFY_DONE;
+}
+
 static int netvsc_register_vf(struct net_device *vf_netdev)
 {
 	struct net_device_context *net_device_ctx;
@@ -2758,6 +2770,8 @@ static int netvsc_netdev_event(struct notifier_block *this,
 		return NOTIFY_DONE;
 
 	switch (event) {
+	case NETDEV_POST_INIT:
+		return netvsc_prepare_bonding(event_dev);
 	case NETDEV_REGISTER:
 		return netvsc_register_vf(event_dev);
 	case NETDEV_UNREGISTER:



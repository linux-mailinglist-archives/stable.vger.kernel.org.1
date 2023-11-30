Return-Path: <stable+bounces-3236-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE487FF205
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 15:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6127282699
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 14:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5869651008;
	Thu, 30 Nov 2023 14:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bNO/XZY/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B0E51032
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 14:34:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A39AC433C7;
	Thu, 30 Nov 2023 14:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701354865;
	bh=klNdWVqUFRx1rdko1GgnHkABn04ulKqQQ4ULVHwq4H4=;
	h=Subject:To:Cc:From:Date:From;
	b=bNO/XZY/yAuQ1enVuet1V13JZe0UamQvLIRdQAlgxeFdSfBOLFt1W+7TvqgNFaSlq
	 jVStr/OHHVjqaPQbK8ddfy1TypXPlcyDhn7/N/R79oNeht7o2tu2rSN8HeUf5UWdfZ
	 YAXgw2q+5xNwEnYwUM8gySuzVbyqxUM/08jrWeXE=
Subject: FAILED: patch "[PATCH] hv_netvsc: fix race of netvsc and VF register_netdevice" failed to apply to 5.4-stable tree
To: haiyangz@microsoft.com,decui@microsoft.com,horms@kernel.org,pabeni@redhat.com,wojciech.drewek@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 30 Nov 2023 14:34:19 +0000
Message-ID: <2023113019-tray-spool-bb95@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x d30fb712e52964f2cf9a9c14cf67078394044837
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023113019-tray-spool-bb95@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

d30fb712e529 ("hv_netvsc: fix race of netvsc and VF register_netdevice")
351e1581395f ("hv_netvsc: Add XDP support")
0efeea5fb153 ("hv_netvsc: Add the support of hibernation")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d30fb712e52964f2cf9a9c14cf67078394044837 Mon Sep 17 00:00:00 2001
From: Haiyang Zhang <haiyangz@microsoft.com>
Date: Sun, 19 Nov 2023 08:23:41 -0800
Subject: [PATCH] hv_netvsc: fix race of netvsc and VF register_netdevice

The rtnl lock also needs to be held before rndis_filter_device_add()
which advertises nvsp_2_vsc_capability / sriov bit, and triggers
VF NIC offering and registering. If VF NIC finished register_netdev()
earlier it may cause name based config failure.

To fix this issue, move the call to rtnl_lock() before
rndis_filter_device_add(), so VF will be registered later than netvsc
/ synthetic NIC, and gets a name numbered (ethX) after netvsc.

Cc: stable@vger.kernel.org
Fixes: e04e7a7bbd4b ("hv_netvsc: Fix a deadlock by getting rtnl lock earlier in netvsc_probe()")
Reported-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 3ba3c8fb28a5..5e528a76f5f5 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2531,15 +2531,6 @@ static int netvsc_probe(struct hv_device *dev,
 		goto devinfo_failed;
 	}
 
-	nvdev = rndis_filter_device_add(dev, device_info);
-	if (IS_ERR(nvdev)) {
-		ret = PTR_ERR(nvdev);
-		netdev_err(net, "unable to add netvsc device (ret %d)\n", ret);
-		goto rndis_failed;
-	}
-
-	eth_hw_addr_set(net, device_info->mac_adr);
-
 	/* We must get rtnl lock before scheduling nvdev->subchan_work,
 	 * otherwise netvsc_subchan_work() can get rtnl lock first and wait
 	 * all subchannels to show up, but that may not happen because
@@ -2547,9 +2538,23 @@ static int netvsc_probe(struct hv_device *dev,
 	 * -> ... -> device_add() -> ... -> __device_attach() can't get
 	 * the device lock, so all the subchannels can't be processed --
 	 * finally netvsc_subchan_work() hangs forever.
+	 *
+	 * The rtnl lock also needs to be held before rndis_filter_device_add()
+	 * which advertises nvsp_2_vsc_capability / sriov bit, and triggers
+	 * VF NIC offering and registering. If VF NIC finished register_netdev()
+	 * earlier it may cause name based config failure.
 	 */
 	rtnl_lock();
 
+	nvdev = rndis_filter_device_add(dev, device_info);
+	if (IS_ERR(nvdev)) {
+		ret = PTR_ERR(nvdev);
+		netdev_err(net, "unable to add netvsc device (ret %d)\n", ret);
+		goto rndis_failed;
+	}
+
+	eth_hw_addr_set(net, device_info->mac_adr);
+
 	if (nvdev->num_chn > 1)
 		schedule_work(&nvdev->subchan_work);
 
@@ -2586,9 +2591,9 @@ static int netvsc_probe(struct hv_device *dev,
 	return 0;
 
 register_failed:
-	rtnl_unlock();
 	rndis_filter_device_remove(dev, nvdev);
 rndis_failed:
+	rtnl_unlock();
 	netvsc_devinfo_put(device_info);
 devinfo_failed:
 	free_percpu(net_device_ctx->vf_stats);



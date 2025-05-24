Return-Path: <stable+bounces-146268-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF6BAC3045
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 17:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50EC21BA0955
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 15:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7199D1DE2D6;
	Sat, 24 May 2025 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Biiu12vy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D67F46447
	for <stable@vger.kernel.org>; Sat, 24 May 2025 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748101786; cv=none; b=Qb40XYYKe5j1Bv5ImZtU4Uw1xQ0n8415UI/lngoRlYzgYDDgMc1V5GBIro66qCx0n+nHZfgesoRoPVY1aknX40t4h9PHUcZsGDik8iEPduMegWGst5AAJH5XCEE33oaaR+fXKHNkpRI5yKTgLty5kD8ADd4XCZs8wLhT2jvfPnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748101786; c=relaxed/simple;
	bh=vk1D+/zuZrbF7bx+v5A646iQ43dWhsI+/CDzkPiCg1M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YkB8Ndj8W/TYqzMFaSLPvSeJSUNSnaGbL8QXLE6hTKeJUiI2xFII/BIDzLAc7QLxY6m3HP6CKgO+ViZky+WB74iBq0EU/ZqfvA1sfcuqCznslBtLrazbqiwV61HIYtxm/Wn66EjegZH1W8W9S5ZukikcJ1glngb8SE4cdrI2e7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Biiu12vy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F990C4CEE4;
	Sat, 24 May 2025 15:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748101786;
	bh=vk1D+/zuZrbF7bx+v5A646iQ43dWhsI+/CDzkPiCg1M=;
	h=Subject:To:Cc:From:Date:From;
	b=Biiu12vymIQgddgLqcnUR2+qesuvYu2q0+EFCHUdZ2geJLWqV8wz8fKUS4ztgtB8+
	 CnFN6+jEyc8UPnvS/m0TzQM+T29iiBICXG0CDWyMDRuovjUiWzp3nyaX0YvOllbs1e
	 ypY7EvhMeufoIm3TXlLn5COMjJypJlbXw8RlYOrI=
Subject: FAILED: patch "[PATCH] vmxnet3: update MTU after device quiesce" failed to apply to 5.4-stable tree
To: ronak.doshi@broadcom.com,guolin.yang@broadcom.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 24 May 2025 17:49:27 +0200
Message-ID: <2025052427-entrust-arousal-0ad5@gregkh>
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
git cherry-pick -x 43f0999af011fba646e015f0bb08b6c3002a0170
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025052427-entrust-arousal-0ad5@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 43f0999af011fba646e015f0bb08b6c3002a0170 Mon Sep 17 00:00:00 2001
From: Ronak Doshi <ronak.doshi@broadcom.com>
Date: Thu, 15 May 2025 19:04:56 +0000
Subject: [PATCH] vmxnet3: update MTU after device quiesce

Currently, when device mtu is updated, vmxnet3 updates netdev mtu, quiesces
the device and then reactivates it for the ESXi to know about the new mtu.
So, technically the OS stack can start using the new mtu before ESXi knows
about the new mtu.

This can lead to issues for TSO packets which use mss as per the new mtu
configured. This patch fixes this issue by moving the mtu write after
device quiesce.

Cc: stable@vger.kernel.org
Fixes: d1a890fa37f2 ("net: VMware virtual Ethernet NIC driver: vmxnet3")
Signed-off-by: Ronak Doshi <ronak.doshi@broadcom.com>
Acked-by: Guolin Yang <guolin.yang@broadcom.com>
Changes v1-> v2:
  Moved MTU write after destroy of rx rings
Link: https://patch.msgid.link/20250515190457.8597-1-ronak.doshi@broadcom.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 3df6aabc7e33..c676979c7ab9 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -3607,8 +3607,6 @@ vmxnet3_change_mtu(struct net_device *netdev, int new_mtu)
 	struct vmxnet3_adapter *adapter = netdev_priv(netdev);
 	int err = 0;
 
-	WRITE_ONCE(netdev->mtu, new_mtu);
-
 	/*
 	 * Reset_work may be in the middle of resetting the device, wait for its
 	 * completion.
@@ -3622,6 +3620,7 @@ vmxnet3_change_mtu(struct net_device *netdev, int new_mtu)
 
 		/* we need to re-create the rx queue based on the new mtu */
 		vmxnet3_rq_destroy_all(adapter);
+		WRITE_ONCE(netdev->mtu, new_mtu);
 		vmxnet3_adjust_rx_ring_size(adapter);
 		err = vmxnet3_rq_create_all(adapter);
 		if (err) {
@@ -3638,6 +3637,8 @@ vmxnet3_change_mtu(struct net_device *netdev, int new_mtu)
 				   "Closing it\n", err);
 			goto out;
 		}
+	} else {
+		WRITE_ONCE(netdev->mtu, new_mtu);
 	}
 
 out:



Return-Path: <stable+bounces-146264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E94EAAC3041
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 17:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAFDD17EC10
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 15:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C6F1DF24E;
	Sat, 24 May 2025 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T4zBLNt6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76B546447
	for <stable@vger.kernel.org>; Sat, 24 May 2025 15:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748101767; cv=none; b=EiZ3Wc94k7ezTzOew0D4s5UfmEiHhE0CFNl5WMnurWnuc4ZXbiHTV8Eqo7rsqHjdpi3mt2xYNsgcnLB5Bssj02uvih156a1OhrPjhZs9i3PQqr/mAC6aLvjhu/LeInyx1F2JeiMITa36nyWL6O4aVKZOwOTmS5cXdZTIU5ZTPp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748101767; c=relaxed/simple;
	bh=2PvrmCYsJ41zW97KbNTf6dRqHj5fttSsSqD1O5Jpb5o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TdPKP1Xve9wlaoQoY5Qza61rLHIGJlsy1sE2RkKDhFu4ILbB8gg5MV4Wvy+3Q6zL7EAKnGJ45Bnm4ihxpN6NUKfzhczrbq/fDkwgnyawuibX/wrSU1binknLFSlNP29bgFNTijBT7c+jGiH8kzYnzceyi9yKfd2HRaoqx7U5FFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T4zBLNt6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350F0C4CEE4;
	Sat, 24 May 2025 15:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748101767;
	bh=2PvrmCYsJ41zW97KbNTf6dRqHj5fttSsSqD1O5Jpb5o=;
	h=Subject:To:Cc:From:Date:From;
	b=T4zBLNt67La4KGONGIHJmNO74w5/E4VHZgh0LHS03Fw8UwTQ7xeyGTFmtQrnnisbe
	 JTH0G82rfsEU0fH7BI/7aMdUnCpKJ/fpSBMmI+x8KrFT/qqnLqyOo2E7eeZ8SWGJm4
	 KsI4iBW52NQWiCI0ew6JDj0SlcXAHJ+LwMMhzqjs=
Subject: FAILED: patch "[PATCH] vmxnet3: update MTU after device quiesce" failed to apply to 6.6-stable tree
To: ronak.doshi@broadcom.com,guolin.yang@broadcom.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 24 May 2025 17:49:24 +0200
Message-ID: <2025052424-banjo-exorcist-8407@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 43f0999af011fba646e015f0bb08b6c3002a0170
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025052424-banjo-exorcist-8407@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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



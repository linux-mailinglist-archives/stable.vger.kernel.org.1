Return-Path: <stable+bounces-146266-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AE4AC3044
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 17:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79C0B7AB02E
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 15:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D38A1E571A;
	Sat, 24 May 2025 15:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VFHx2LCI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D98346447
	for <stable@vger.kernel.org>; Sat, 24 May 2025 15:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748101781; cv=none; b=e+nkkTRb2Aok99xOQeTyT8HtwBMiTlsgDgtFs5LgxLq9EVXfTMi8bYHnfF7nYsep8HRUiTLVl/llYkTgZ8KbjeYM5Zs+NODUmHT97AYDrbP8UbPETAG6VrCjcXzecjsyopclsPn2NEf++Bn8v+kHfQY0w2B4Pi2edqjTJGIZCqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748101781; c=relaxed/simple;
	bh=OH1UAUfUhVIhbhlHj55SDIGuBVBG7aN3jm/2cnEcWoQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bUMOqSAm0eGSn5KTP5s7/C8LnGl8JgLwn8AsTUPG37+46XuVNdcnU4lXYpXKA7c0YaI2WwtswdldBUwZqCUTeCeGi4njt6ISVjgv/lH3azcNUAk6HLM64dDFizjRZ7ShVsQu3xgv/GW3qpkhLPSl50lutHXElk09P9OVfEcDcrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VFHx2LCI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 109EBC4CEE4;
	Sat, 24 May 2025 15:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748101779;
	bh=OH1UAUfUhVIhbhlHj55SDIGuBVBG7aN3jm/2cnEcWoQ=;
	h=Subject:To:Cc:From:Date:From;
	b=VFHx2LCItgvJiaABwZpwjk1rTHwRhawUgr2kchUuS3dByQTLIO5ZZPFxWzrRZ+dLh
	 iVU1/IcT1fP5msltZm6EgRg5pVPcMRtL2sxWrLgmhRIjw6rL1Qld/n2SmbgqWMAAZc
	 vuaRaElb9XuPWeltNujg1h+2x22CBlT3BBugYdKU=
Subject: FAILED: patch "[PATCH] vmxnet3: update MTU after device quiesce" failed to apply to 6.1-stable tree
To: ronak.doshi@broadcom.com,guolin.yang@broadcom.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 24 May 2025 17:49:25 +0200
Message-ID: <2025052425-willed-landline-ff5b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 43f0999af011fba646e015f0bb08b6c3002a0170
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025052425-willed-landline-ff5b@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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



Return-Path: <stable+bounces-179791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B612B7DCE3
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 437F01BC5AE8
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 07:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B282C1595;
	Wed, 17 Sep 2025 07:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SAQn6Wuk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEF52F25E9
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 07:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758095204; cv=none; b=Ptwwk99equfA//K/Vk8sWmLnG4TCBs9abQpXw15A3LHD8F7FAO8CG82m3Q2WKA0PmkXlv6XK38Z67iLDrwBAJPIrYUoar1z4y9NQiVOetnqd5HMXrv7huQGVqL30m1h226JgVKpJkkzL1GMFqCT7KMddzt/aI32elDRzgrSB+9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758095204; c=relaxed/simple;
	bh=d2rTZKy2nGXZqsoNGkeqj761u36PZsHYuwthBTkC81M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=F6aZiwQGuJGBaLfcFn4GqSFb6LJ+n+sO88Ur3qGODdjS8R4pmMKf2lmx0HRWVK8K1BC05BC1rzLg+7pObR2QQEAkAaIgix/b2RFhhx3VDrhsfs8CQjrSi86QY9KdkmgmnEKL0UTR/etinSn5dP+7AIjhBXjP42l1OKqwlreDm9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SAQn6Wuk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B8EC4CEF0;
	Wed, 17 Sep 2025 07:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758095203;
	bh=d2rTZKy2nGXZqsoNGkeqj761u36PZsHYuwthBTkC81M=;
	h=Subject:To:Cc:From:Date:From;
	b=SAQn6Wuk/fJJnikh8iKit4D75T+8aJoPAAXXaec6MGZ2CSV5DmYCLvDemzHCxNlQ6
	 3j6nvudw55de9FPCVnYPlDBQQqlXUbnU4Q7kFesEQNTrbdeLbxx3CIk5TIL5sx+plR
	 aqgYNum4KPUkO0oMdVn7p4uVsN6sQMFmigI5ZJQE=
Subject: FAILED: patch "[PATCH] phy: ti: omap-usb2: fix device leak at unbind" failed to apply to 5.15-stable tree
To: johan@kernel.org,rogerq@kernel.org,vkoul@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 17 Sep 2025 09:45:52 +0200
Message-ID: <2025091751-nuzzle-jolt-dcac@gregkh>
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
git cherry-pick -x 64961557efa1b98f375c0579779e7eeda1a02c42
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025091751-nuzzle-jolt-dcac@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 64961557efa1b98f375c0579779e7eeda1a02c42 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Thu, 24 Jul 2025 15:12:05 +0200
Subject: [PATCH] phy: ti: omap-usb2: fix device leak at unbind

Make sure to drop the reference to the control device taken by
of_find_device_by_node() during probe when the driver is unbound.

Fixes: 478b6c7436c2 ("usb: phy: omap-usb2: Don't use omap_get_control_dev()")
Cc: stable@vger.kernel.org	# 3.13
Cc: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20250724131206.2211-3-johan@kernel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>

diff --git a/drivers/phy/ti/phy-omap-usb2.c b/drivers/phy/ti/phy-omap-usb2.c
index c1a0ef979142..c444bb2530ca 100644
--- a/drivers/phy/ti/phy-omap-usb2.c
+++ b/drivers/phy/ti/phy-omap-usb2.c
@@ -363,6 +363,13 @@ static void omap_usb2_init_errata(struct omap_usb *phy)
 		phy->flags |= OMAP_USB2_DISABLE_CHRG_DET;
 }
 
+static void omap_usb2_put_device(void *_dev)
+{
+	struct device *dev = _dev;
+
+	put_device(dev);
+}
+
 static int omap_usb2_probe(struct platform_device *pdev)
 {
 	struct omap_usb	*phy;
@@ -373,6 +380,7 @@ static int omap_usb2_probe(struct platform_device *pdev)
 	struct device_node *control_node;
 	struct platform_device *control_pdev;
 	const struct usb_phy_data *phy_data;
+	int ret;
 
 	phy_data = device_get_match_data(&pdev->dev);
 	if (!phy_data)
@@ -423,6 +431,11 @@ static int omap_usb2_probe(struct platform_device *pdev)
 			return -EINVAL;
 		}
 		phy->control_dev = &control_pdev->dev;
+
+		ret = devm_add_action_or_reset(&pdev->dev, omap_usb2_put_device,
+					       phy->control_dev);
+		if (ret)
+			return ret;
 	} else {
 		if (of_property_read_u32_index(node,
 					       "syscon-phy-power", 1,



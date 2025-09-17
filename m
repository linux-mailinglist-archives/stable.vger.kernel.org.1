Return-Path: <stable+bounces-179790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 932DDB7DD80
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 956363B0602
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 07:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2202D7DFA;
	Wed, 17 Sep 2025 07:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NeUWS/pj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FABE274676
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 07:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758095200; cv=none; b=U3PBUZsGTnmuSHHWJOXuCORhlRff0cIL5BUHWQK+4hYc5W60Xu72cNzbuqgkPfoQMYp1mI31u6c682r6RBnC/2j87USqTQVMD678r0ZZvXHENv7NarzFBRAGTkYJrmWewkUewGsx8Ow+AsJMGAkloKytSICUK1JHAQlVWWcEcNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758095200; c=relaxed/simple;
	bh=3ssh4reG7Qjlfv9OJEPh0hI5UACN8YvWF/KzPMU/VYE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sVPIQujvmRtswffZqbVCtsDh4pqGu6I8MEMkEvBsustkD5XzDG0Y/V9eOViXSU8r0zE5x0fTFu5dx4iK0K01hfaHdG+1OYsJimJ7HGT8gFrmwgk5LcTy8xBH3CC6eYERhZNOtgyl/9QMGsowl/SzYF1ym3Te+JNiYLnXeAKWCsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NeUWS/pj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F08C4CEF0;
	Wed, 17 Sep 2025 07:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758095200;
	bh=3ssh4reG7Qjlfv9OJEPh0hI5UACN8YvWF/KzPMU/VYE=;
	h=Subject:To:Cc:From:Date:From;
	b=NeUWS/pj+5j32P6uNZxs2G97Q8hJ2VviAPFcM723Nb17gn4cIArppPFi2ug6nvQ0T
	 7PiNKfiIJ0o63l3uQ3h29/0rnNY3k+qObXgAF3AohvRYvuDmaazOgAWCw03jnuWWFu
	 Th5lDd889kokiMom/Q8VosKUyK/yvhh1J1U4bze8=
Subject: FAILED: patch "[PATCH] phy: ti: omap-usb2: fix device leak at unbind" failed to apply to 5.4-stable tree
To: johan@kernel.org,rogerq@kernel.org,vkoul@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 17 Sep 2025 09:45:52 +0200
Message-ID: <2025091752-dizziness-decorated-ee3a@gregkh>
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
git cherry-pick -x 64961557efa1b98f375c0579779e7eeda1a02c42
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025091752-dizziness-decorated-ee3a@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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



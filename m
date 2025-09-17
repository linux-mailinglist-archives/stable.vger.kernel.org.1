Return-Path: <stable+bounces-179788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 924B0B7D76A
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 740D37B52D9
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 07:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8215C2E2DFC;
	Wed, 17 Sep 2025 07:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="emOOhJUO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3F830217F
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 07:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758095194; cv=none; b=I8ObWfOvQ0TNHisXNzr3xQk5YU/WXQi/chAbb0z0tSy7zmElBDo1SAKIxEVhZ2Z4N3BHE29zfIah//IHKoYBvG2+R9cKD6Jj2xUJnT63t67tyorsy24i8/lu9I4U+c8+GiTfNz0bap7nxcNrwk7z98hxAmD99RdCr2uyqHOexeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758095194; c=relaxed/simple;
	bh=cFhy+L4ZXXfhvlPxqknFYrEcDAoS0TwBDrNGD3UK4wQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=k4Hb6hz3UmL+C2GPjUsFa2MqTJsXLAScGYNGg5las1++SkzXWvCpQN8q0lmi/5eqabyG0oisW48F3VdllUkMvLoUNOV7dU9LOnW4VxLTgtfaX70KrX6eiuf9YCn5wmPdAlAPHNlHadV+YFPsMApVQcmKJ2YV3ltGGoHB1AruuR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=emOOhJUO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67067C4CEF7;
	Wed, 17 Sep 2025 07:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758095193;
	bh=cFhy+L4ZXXfhvlPxqknFYrEcDAoS0TwBDrNGD3UK4wQ=;
	h=Subject:To:Cc:From:Date:From;
	b=emOOhJUOH1mwwUgW7U98UUZY5cfGoNEUcG4JtjOACNLUX9Z+AlWYGmciD6c95b0EC
	 ud3bNPZd0xzYjElVlc44YPhKMr8HfCM30XIzUciexeHRyqc3FPZ/MDwxzFe8R83I2z
	 HgCp9lMEBbO9wl9YwjBGGd0OkmdsS1+59jGYPnzI=
Subject: FAILED: patch "[PATCH] phy: ti: omap-usb2: fix device leak at unbind" failed to apply to 6.1-stable tree
To: johan@kernel.org,rogerq@kernel.org,vkoul@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 17 Sep 2025 09:45:51 +0200
Message-ID: <2025091751-geometry-screen-8bd7@gregkh>
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
git cherry-pick -x 64961557efa1b98f375c0579779e7eeda1a02c42
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025091751-geometry-screen-8bd7@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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



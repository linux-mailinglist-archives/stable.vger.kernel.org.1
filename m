Return-Path: <stable+bounces-105102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AADE79F5CC0
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 03:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 747B41890F97
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 02:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D6270831;
	Wed, 18 Dec 2024 02:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eML1yHbc"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977CC1F931;
	Wed, 18 Dec 2024 02:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734488460; cv=none; b=UlUq+9a7FfxzLuRYel6MUsAAS5sABoVz2B8pzz82oxtB4pLs3x9BE2ThAYLevT2RzOyHpUtMqOIbbhFI3Vcg4XCKZELZaAvWIldOQCypowWsEdVrQWzGywtg1iDJSvuJpldorVOvFHRA24pMGaCmQx/AEbiRV11DgT9+C/f0ARg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734488460; c=relaxed/simple;
	bh=S/nQy4ffuHxy7nkVeDLL5cjXYB5farjfjoBQdaPlIF8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T6mJ8t16LtFT/iAsJjjVI/KHmkyd4h9+eRYHAW7ImA8vzMnNpUkUmC++MoycfRihvLZKANQhtJBV4IdLSv2AfB1tlW0Inb0m0N5wgVtrmNHMNfNCiU6cxPfqua/fSwq9v3HaPGx2s9ljgb9fZlJ/jzO564RPCeDYEUQcpKnMOc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eML1yHbc; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=/stuI
	+j8ZgzgZ+HBFL0EjbA7t6ovZboYZ2POviazR8U=; b=eML1yHbcGbHfw8jcxpSq9
	bk7pMowd9cugBotP/egQ0HLtEeT55EJg1DPI4ZWzxuBlsHE+h0SeGrtKkyg9us/L
	I97VHwbh7UJObBxuoBLQ6slT/WbajOsjONBfgK4IRbeoFilvbg9UJEzjwhln4OMa
	nQi8ttvgLpH2MLeKLp08vI=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDn78c9MWJnoYImBQ--.25881S4;
	Wed, 18 Dec 2024 10:19:51 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: gregkh@linuxfoundation.org,
	stern@rowland.harvard.edu,
	christophe.jaillet@wanadoo.fr,
	stanley_chang@realtek.com,
	mka@chromium.org,
	oneukum@suse.com,
	quic_ugoswami@quicinc.com,
	make_ruc2021@163.com,
	javier.carrasco@wolfvision.net,
	kay.sievers@vrfy.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] usb: fix reference leak in usb_new_device()
Date: Wed, 18 Dec 2024 10:19:40 +0800
Message-Id: <20241218021940.2967550-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn78c9MWJnoYImBQ--.25881S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww45uw4DXF4UtF18Jw1xAFb_yoW8ZryrpF
	W8Jas8trWDWr17Cw1jvFy8Xa45Gw40ya4rGrySv3y29wnxXw4rKryrtryFqa48A393AF45
	Xa43Wa1FqryUWFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pimhF7UUUUU=
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/1tbizRK4C2dhnply6gACs3

When device_add(&udev->dev) failed, calling put_device() to explicitly
release udev->dev. And the routine which calls usb_new_device() does
not call put_device() when an error occurs. As comment of device_add()
says, 'if device_add() succeeds, you should call device_del() when you
want to get rid of it. If device_add() has not succeeded, use only
put_device() to drop the reference count'.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 9f8b17e643fe ("USB: make usbdevices export their device nodes instead of using a separate class")
Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
Changes in v2:
- modified the bug description to make it more clear;
- added the missed part of the patch.
---
 drivers/usb/core/hub.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 4b93c0bd1d4b..ddd572312296 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2651,6 +2651,7 @@ int usb_new_device(struct usb_device *udev)
 	err = device_add(&udev->dev);
 	if (err) {
 		dev_err(&udev->dev, "can't device_add, error %d\n", err);
+		put_device(&udev->dev);
 		goto fail;
 	}
 
@@ -2663,13 +2664,13 @@ int usb_new_device(struct usb_device *udev)
 		err = sysfs_create_link(&udev->dev.kobj,
 				&port_dev->dev.kobj, "port");
 		if (err)
-			goto fail;
+			goto out_del_dev;
 
 		err = sysfs_create_link(&port_dev->dev.kobj,
 				&udev->dev.kobj, "device");
 		if (err) {
 			sysfs_remove_link(&udev->dev.kobj, "port");
-			goto fail;
+			goto out_del_dev;
 		}
 
 		if (!test_and_set_bit(port1, hub->child_usage_bits))
@@ -2683,6 +2684,9 @@ int usb_new_device(struct usb_device *udev)
 	pm_runtime_put_sync_autosuspend(&udev->dev);
 	return err;
 
+out_del_dev:
+	device_del(&udev->dev);
+	put_device(&udev->dev);
 fail:
 	usb_set_device_state(udev, USB_STATE_NOTATTACHED);
 	pm_runtime_disable(&udev->dev);
-- 
2.25.1



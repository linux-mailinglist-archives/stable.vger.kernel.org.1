Return-Path: <stable+bounces-105123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E819F5F15
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 08:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5E4C188B319
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 07:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FAF158A1F;
	Wed, 18 Dec 2024 07:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MKvrA/Bm"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507E315666B;
	Wed, 18 Dec 2024 07:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734506131; cv=none; b=HmwMSZjDInYpi6Phsdx9FKWWYUYE33MfIp9bfjAOnwElV2kSi/oJ1LSUExR32yVt1RrV5/D6KVuoqt+4jIJLIc3Zi+m0CBNNbduoXVq2cM21D3YClMUr52JTWN73snhqS+uvnn/hKbETdpMBAaENihI4HKRsdfsruIBRprFmVLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734506131; c=relaxed/simple;
	bh=aluugiqXTkoRRG7seS29rNH3yJ+36BBE06UAvdhrWtw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TuGQbK2k0+QzXZ/kHweX6zXzT8Alrd7KjzcRyGownEPPEaH/j2j46ou5qSLzY3D9Anb75S69NhX+VZePy6gXhrM4CHAmddcDJPZRTXSTNVa4ParXPrpQQZ1kVHj23oNyu+9i7eKInDOFtCCj2+6R+mhV+8dttTy+UFBJJzH2xFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MKvrA/Bm; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=YUJkv
	boH8N2TDLKwm+M/QlVsztm9TDQx3DITEazuH1s=; b=MKvrA/Bm5R3alckiT0QZg
	unJAREDkhdN0pOW2aWh5Iz1Jq7wNx8MGLbC47w+iMK+4GpUzkC4lSRHD73q697fW
	j8ppxUC6N9oN2A29K6l9+1beggeRVYjg7YX453fmXB2cU+4hAlzv4Z/0FufxpzWJ
	g3mcvLq5v1Hd+X5uzCM79U=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDH5gMsdmJnY9NlBQ--.19120S4;
	Wed, 18 Dec 2024 15:13:57 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: gregkh@linuxfoundation.org,
	stern@rowland.harvard.edu,
	quic_ugoswami@quicinc.com,
	stanley_chang@realtek.com,
	make_ruc2021@163.com,
	christophe.jaillet@wanadoo.fr,
	oneukum@suse.com,
	javier.carrasco@wolfvision.net,
	kay.sievers@vrfy.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] usb: fix reference leak in usb_new_device()
Date: Wed, 18 Dec 2024 15:13:46 +0800
Message-Id: <20241218071346.2973980-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDH5gMsdmJnY9NlBQ--.19120S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF1DKrW8WFyDXr18CrWrAFb_yoW8Aw1Upr
	W8Ga98KrWDGr17Cw1jvFy8Xa45Ga10ya4rWFyfZw129w13X3yrKryrtry5ta48ArZ3AF4U
	XFW7WF4SqryUCFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pimhF7UUUUU=
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbBXwG5C2diPlkwfAABsD

When device_add(&udev->dev) succeeds and a later call fails,
usb_new_device() does not properly call device_del(). As comment of
device_add() says, 'if device_add() succeeds, you should call
device_del() when you want to get rid of it. If device_add() has not
succeeded, use only put_device() to drop the reference count'.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 9f8b17e643fe ("USB: make usbdevices export their device nodes instead of using a separate class")
Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
Changes in v3:
- modified the bug description according to the changes of the patch;
- removed redundant put_device() in patch v2 as suggestions.
Changes in v2:
- modified the bug description to make it more clear;
- added the missed part of the patch.
---
 drivers/usb/core/hub.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 4b93c0bd1d4b..21ac9b464696 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2663,13 +2663,13 @@ int usb_new_device(struct usb_device *udev)
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
@@ -2683,6 +2683,8 @@ int usb_new_device(struct usb_device *udev)
 	pm_runtime_put_sync_autosuspend(&udev->dev);
 	return err;
 
+out_del_dev:
+	device_del(&udev->dev);
 fail:
 	usb_set_device_state(udev, USB_STATE_NOTATTACHED);
 	pm_runtime_disable(&udev->dev);
-- 
2.25.1



Return-Path: <stable+bounces-191585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AEAC19622
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 10:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 48F794F3D68
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 09:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5FD326D4A;
	Wed, 29 Oct 2025 09:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiOeffo+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372362DECBA;
	Wed, 29 Oct 2025 09:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761730316; cv=none; b=q1jABh1JxKaxWaM9Y5LRq3oNXJeusOXsBQooEdPwU0ttLr6zQv0ISBI2cFhA14nkRZmAFmBeb2fhYbjUalDR8AGGhkFzFK+HApjON0GlAtz4Uyl0XoX5pBVPeos9Q9Zz2KC/D9YWzTVyhvIr66OR65Sj/deATtfoCgJ201pbuP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761730316; c=relaxed/simple;
	bh=871/U0Lxkh+lK9lbE2ySRMFli+uf3E3RW3COsyf1zys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AfbCaFmzkO9J3vmhke4fvq05m6vjIFC4LA7wMW1ZFxSKyKdPZtVzvdrwiUvTaUlK8rI7j6CZTyCu+cZHT7zJzhCJsKyk/cpGMXaT1gB45UKu/XBPHrUYNse/o0d7s4SXzVkk+Z9gQgaG0NQJtDLoHD9W4Ea15Jwqr3IykR3eD3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oiOeffo+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06E6C4CEF7;
	Wed, 29 Oct 2025 09:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761730315;
	bh=871/U0Lxkh+lK9lbE2ySRMFli+uf3E3RW3COsyf1zys=;
	h=From:To:Cc:Subject:Date:From;
	b=oiOeffo+smVeMQrMj3Dpbt40iY33yrao6WpIsI6JgOTPCxL33c3tztcy3vEnxgV23
	 lCC0CUudRYwl9THg9ZJtzHeBTfxErGaTyTgMRyFLv87T46n9RVKSHpYmQmuLcJDXeQ
	 HQFD8AbZp1zVDBQ1hFUXrCc3L9Zyk9NvUDrgDIPSEI3Xf5oEC/3VIObkhMWVkzo5Rp
	 +zDrUdSavQ45iHtHA16mvqFpdtrWSeGA6kwT67nXj+hCo6oQXq1B+t5nx3CV/CrM8n
	 kJRPbQo46gfWkmk3dJLY1fG1NdNBZtvsFFXf3wsliasmrGrU7UoPcyoGxJ91SRzjyj
	 TpdM3QIsiLIBA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vE2XB-000000007Xx-2KoI;
	Wed, 29 Oct 2025 10:32:02 +0100
From: Johan Hovold <johan@kernel.org>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Christian Gromm <christian.gromm@microchip.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Victoria Votokina <Victoria.Votokina@kaspersky.com>,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] most: usb: fix double free on late probe failure
Date: Wed, 29 Oct 2025 10:30:29 +0100
Message-ID: <20251029093029.28922-1-johan@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MOST subsystem has a non-standard registration function which frees
the interface on registration failures and on deregistration.

This unsurprisingly leads to bugs in the MOST drivers, and a couple of
recent changes turned a reference underflow and use-after-free in the
USB driver into several double free and a use-after-free on late probe
failures.

Fixes: 723de0f9171e ("staging: most: remove device from interface structure")
Fixes: 4b1270902609 ("most: usb: Fix use-after-free in hdm_disconnect")
Fixes: a8cc9e5fcb0e ("most: usb: hdm_probe: Fix calling put_device() before device initialization")
Cc: stable@vger.kernel.org
Cc: Christian Gromm <christian.gromm@microchip.com>
Cc: Victoria Votokina <Victoria.Votokina@kaspersky.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/most/most_usb.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/most/most_usb.c b/drivers/most/most_usb.c
index 10064d7b7249..41ee169f80c5 100644
--- a/drivers/most/most_usb.c
+++ b/drivers/most/most_usb.c
@@ -1058,7 +1058,7 @@ hdm_probe(struct usb_interface *interface, const struct usb_device_id *id)
 
 	ret = most_register_interface(&mdev->iface);
 	if (ret)
-		goto err_free_busy_urbs;
+		return ret;
 
 	mutex_lock(&mdev->io_mutex);
 	if (le16_to_cpu(usb_dev->descriptor.idProduct) == USB_DEV_ID_OS81118 ||
@@ -1068,8 +1068,7 @@ hdm_probe(struct usb_interface *interface, const struct usb_device_id *id)
 		if (!mdev->dci) {
 			mutex_unlock(&mdev->io_mutex);
 			most_deregister_interface(&mdev->iface);
-			ret = -ENOMEM;
-			goto err_free_busy_urbs;
+			return -ENOMEM;
 		}
 
 		mdev->dci->dev.init_name = "dci";
@@ -1078,18 +1077,15 @@ hdm_probe(struct usb_interface *interface, const struct usb_device_id *id)
 		mdev->dci->dev.release = release_dci;
 		if (device_register(&mdev->dci->dev)) {
 			mutex_unlock(&mdev->io_mutex);
+			put_device(&mdev->dci->dev);
 			most_deregister_interface(&mdev->iface);
-			ret = -ENOMEM;
-			goto err_free_dci;
+			return -ENOMEM;
 		}
 		mdev->dci->usb_device = mdev->usb_device;
 	}
 	mutex_unlock(&mdev->io_mutex);
 	return 0;
-err_free_dci:
-	put_device(&mdev->dci->dev);
-err_free_busy_urbs:
-	kfree(mdev->busy_urbs);
+
 err_free_ep_address:
 	kfree(mdev->ep_address);
 err_free_cap:
-- 
2.51.0



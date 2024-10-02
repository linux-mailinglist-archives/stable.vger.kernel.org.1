Return-Path: <stable+bounces-78705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 496CF98D48E
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F09311F22B06
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858AF1D0484;
	Wed,  2 Oct 2024 13:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C/0ReqjS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4348B1D043E;
	Wed,  2 Oct 2024 13:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727875289; cv=none; b=P61tut+W+EBBRR67N3UtwNTN4IWtI5HZ7wkD5D7WR4b5QVg61VvWOze28Jl387MkyVaPgVCgpnS0FzWpv5pf/NxEnUvjZhmsHP/ooSmVjhVlb5+WnqfFVoWFJUxdacf1OS8icIn05MssAagN/JhkLhvnxD4ye0FocJRlm0WIeHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727875289; c=relaxed/simple;
	bh=wh00VavmtydjUMSIp6t/L3Co92duIsDd22LcGU80zFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E3wQia9LsRix7k1cnr35foCnNePudU3a0mTG7t/JBUQw1HqfPqYvJS3aTBMkH15inkZ1uhsMBglnpTW6LbBxOz2Fs2aOhKOTUpS/7mTUUboiK3yT7nseWfO0TnMYXH4fkks1PINRP97FLd3i7r1h9qmxVBDDoDSMeSYIoTCGY1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C/0ReqjS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDE7C4CEC5;
	Wed,  2 Oct 2024 13:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727875289;
	bh=wh00VavmtydjUMSIp6t/L3Co92duIsDd22LcGU80zFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C/0ReqjSsUX3XLXryqkzON9eCBuU149EUiAb9S/XEtXA23d4JUVTUfzUzx/xUfRSE
	 8hVK9jCdaMItzj4RsoT0goCTaj+BJ7BhQYMPzZV8F0n4LypxNi4L0EOcoX0lBKWaVl
	 jsRrfgHGFyinDtrSjZ+SiFcXu3LZz+8/2arPcquI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>,
	Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 020/695] virtio: allow driver to disable the configure change notification
Date: Wed,  2 Oct 2024 14:50:18 +0200
Message-ID: <20241002125823.298770463@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125822.467776898@linuxfoundation.org>
References: <20241002125822.467776898@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Wang <jasowang@redhat.com>

[ Upstream commit 224de6f886f8184fd448700a6d78f216694de948 ]

Sometime, it would be useful to disable the configure change
notification from the driver. So this patch allows this by introducing
a variable config_change_driver_disabled and only allow the configure
change notification callback to be triggered when it is allowed by
both the virtio core and the driver. It is set to false by default to
hold the current semantic so we don't need to change any drivers.

The first user for this would be virtio-net.

Cc: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
Cc: Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
Link: https://patch.msgid.link/20240814052228.4654-3-jasowang@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: c392d6019398 ("virtio-net: synchronize probe with ndo_set_features")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/virtio/virtio.c | 39 ++++++++++++++++++++++++++++++++++++---
 include/linux/virtio.h  |  7 +++++++
 2 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 6b692b0fa578b..b9095751e43bb 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -127,10 +127,12 @@ static void __virtio_config_changed(struct virtio_device *dev)
 {
 	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
 
-	if (!dev->config_core_enabled)
+	if (!dev->config_core_enabled || dev->config_driver_disabled)
 		dev->config_change_pending = true;
-	else if (drv && drv->config_changed)
+	else if (drv && drv->config_changed) {
 		drv->config_changed(dev);
+		dev->config_change_pending = false;
+	}
 }
 
 void virtio_config_changed(struct virtio_device *dev)
@@ -143,6 +145,38 @@ void virtio_config_changed(struct virtio_device *dev)
 }
 EXPORT_SYMBOL_GPL(virtio_config_changed);
 
+/**
+ * virtio_config_driver_disable - disable config change reporting by drivers
+ * @dev: the device to reset
+ *
+ * This is only allowed to be called by a driver and disabling can't
+ * be nested.
+ */
+void virtio_config_driver_disable(struct virtio_device *dev)
+{
+	spin_lock_irq(&dev->config_lock);
+	dev->config_driver_disabled = true;
+	spin_unlock_irq(&dev->config_lock);
+}
+EXPORT_SYMBOL_GPL(virtio_config_driver_disable);
+
+/**
+ * virtio_config_driver_enable - enable config change reporting by drivers
+ * @dev: the device to reset
+ *
+ * This is only allowed to be called by a driver and enabling can't
+ * be nested.
+ */
+void virtio_config_driver_enable(struct virtio_device *dev)
+{
+	spin_lock_irq(&dev->config_lock);
+	dev->config_driver_disabled = false;
+	if (dev->config_change_pending)
+		__virtio_config_changed(dev);
+	spin_unlock_irq(&dev->config_lock);
+}
+EXPORT_SYMBOL_GPL(virtio_config_driver_enable);
+
 static void virtio_config_core_disable(struct virtio_device *dev)
 {
 	spin_lock_irq(&dev->config_lock);
@@ -156,7 +190,6 @@ static void virtio_config_core_enable(struct virtio_device *dev)
 	dev->config_core_enabled = true;
 	if (dev->config_change_pending)
 		__virtio_config_changed(dev);
-	dev->config_change_pending = false;
 	spin_unlock_irq(&dev->config_lock);
 }
 
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index de6d3cc176d96..306137a15d075 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -119,6 +119,8 @@ struct virtio_admin_cmd {
  * @index: unique position on the virtio bus
  * @failed: saved value for VIRTIO_CONFIG_S_FAILED bit (for restore)
  * @config_core_enabled: configuration change reporting enabled by core
+ * @config_driver_disabled: configuration change reporting disabled by
+ *                          a driver
  * @config_change_pending: configuration change reported while disabled
  * @config_lock: protects configuration change reporting
  * @vqs_list_lock: protects @vqs.
@@ -136,6 +138,7 @@ struct virtio_device {
 	int index;
 	bool failed;
 	bool config_core_enabled;
+	bool config_driver_disabled;
 	bool config_change_pending;
 	spinlock_t config_lock;
 	spinlock_t vqs_list_lock;
@@ -166,6 +169,10 @@ void __virtqueue_break(struct virtqueue *_vq);
 void __virtqueue_unbreak(struct virtqueue *_vq);
 
 void virtio_config_changed(struct virtio_device *dev);
+
+void virtio_config_driver_disable(struct virtio_device *dev);
+void virtio_config_driver_enable(struct virtio_device *dev);
+
 #ifdef CONFIG_PM_SLEEP
 int virtio_device_freeze(struct virtio_device *dev);
 int virtio_device_restore(struct virtio_device *dev);
-- 
2.43.0





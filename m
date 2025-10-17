Return-Path: <stable+bounces-187337-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DA460BEA16D
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8570D35B7E5
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9076B330B39;
	Fri, 17 Oct 2025 15:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WE6nggGy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F9F330B00
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 15:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715788; cv=none; b=ExUgsLunmRfBT96+Xit5VfZ0vnP8sfCAQRYnZTWD1Dyx/hIGxB8wJXzKQCnzJyMlLCF5m9Zi0RWgUaKck47ozsCUSmfZ2ITZibT3LopZHr1qyyqm6pfVm3oFavbEu7OrVZeJd65g/b8TZhuoyYQMO3+r+lYiY17fMCAKXvkqUwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715788; c=relaxed/simple;
	bh=ussppoN27W2ahKlLtGNq+H0bGisTYSBYaskbm4Wz3LY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hhK5OyKxFn0E4Ux44fivAgyEm9jwf4oWeWx3VHsutOOoukzZVvNRSaUYORIUWgmlDzng2pPUoogxTlUYiznm9oeXWy9ZW3pggdd7juubHfSfZzvau1+O+AyUNQxPoV4mMU6/ciMLDKupHJqlZU6ZYngzd/lLp0C30mSKDmcVXG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WE6nggGy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F88C4CEE7;
	Fri, 17 Oct 2025 15:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760715787;
	bh=ussppoN27W2ahKlLtGNq+H0bGisTYSBYaskbm4Wz3LY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WE6nggGyUi21VzwKZ6aHWkqJWfKuT+z/T+FX/7pwbnePSU/ZQbR8wNl0jjRdVsibq
	 taWWwDg+ZH8URa4p0IMbOlCkhzvJrQ/0zfPi8WAJ3GoW5sE+pbKHSKJLM9pMGWI5D5
	 clUKuSQqX5k9rPaKeiP367oylajGsI4bavMs5Z5i76a5mEBz1LovXkaHlZsClZvfI/
	 4khB/g+w9iFhIRia9awaBt5FTK0+Jm+gQZoQFb+mx2JQpRLyChrS+PaLchDTBEfQIq
	 ARnwUrIbQLChX5MmCPDngGeNmTB5eIXi26XGvUoaA2htJ2ig8+r08UHBw5foUKZOVf
	 lAKcQpBXljAJg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: keliu <liuke94@huawei.com>,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] media: rc: Directly use ida_free()
Date: Fri, 17 Oct 2025 11:43:03 -0400
Message-ID: <20251017154304.4038374-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101607-boring-luminance-9766@gregkh>
References: <2025101607-boring-luminance-9766@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: keliu <liuke94@huawei.com>

[ Upstream commit cd54ff938091d890edf78e6555ec30c63dcd2eb5 ]

Use ida_alloc() and ida_free() instead of the deprecated
ida_simple_get() and ida_simple_remove().

Signed-off-by: keliu <liuke94@huawei.com>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Stable-dep-of: 4f4098c57e13 ("media: lirc: Fix error handling in lirc_register()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/lirc_dev.c | 6 +++---
 drivers/media/rc/rc-main.c  | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/rc/lirc_dev.c b/drivers/media/rc/lirc_dev.c
index 54f4a7cd88f43..37933c5af5f72 100644
--- a/drivers/media/rc/lirc_dev.c
+++ b/drivers/media/rc/lirc_dev.c
@@ -732,7 +732,7 @@ int lirc_register(struct rc_dev *dev)
 	const char *rx_type, *tx_type;
 	int err, minor;
 
-	minor = ida_simple_get(&lirc_ida, 0, RC_DEV_MAX, GFP_KERNEL);
+	minor = ida_alloc_max(&lirc_ida, RC_DEV_MAX - 1, GFP_KERNEL);
 	if (minor < 0)
 		return minor;
 
@@ -777,7 +777,7 @@ int lirc_register(struct rc_dev *dev)
 	return 0;
 
 out_ida:
-	ida_simple_remove(&lirc_ida, minor);
+	ida_free(&lirc_ida, minor);
 	return err;
 }
 
@@ -795,7 +795,7 @@ void lirc_unregister(struct rc_dev *dev)
 	spin_unlock_irqrestore(&dev->lirc_fh_lock, flags);
 
 	cdev_device_del(&dev->lirc_cdev, &dev->lirc_dev);
-	ida_simple_remove(&lirc_ida, MINOR(dev->lirc_dev.devt));
+	ida_free(&lirc_ida, MINOR(dev->lirc_dev.devt));
 }
 
 int __init lirc_dev_init(void)
diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c
index b90438a71c800..923cc1acda942 100644
--- a/drivers/media/rc/rc-main.c
+++ b/drivers/media/rc/rc-main.c
@@ -1897,7 +1897,7 @@ int rc_register_device(struct rc_dev *dev)
 	if (!dev)
 		return -EINVAL;
 
-	minor = ida_simple_get(&rc_ida, 0, RC_DEV_MAX, GFP_KERNEL);
+	minor = ida_alloc_max(&rc_ida, RC_DEV_MAX - 1, GFP_KERNEL);
 	if (minor < 0)
 		return minor;
 
@@ -1980,7 +1980,7 @@ int rc_register_device(struct rc_dev *dev)
 out_raw:
 	ir_raw_event_free(dev);
 out_minor:
-	ida_simple_remove(&rc_ida, minor);
+	ida_free(&rc_ida, minor);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(rc_register_device);
@@ -2040,7 +2040,7 @@ void rc_unregister_device(struct rc_dev *dev)
 
 	device_del(&dev->dev);
 
-	ida_simple_remove(&rc_ida, dev->minor);
+	ida_free(&rc_ida, dev->minor);
 
 	if (!dev->managed_alloc)
 		rc_free_device(dev);
-- 
2.51.0



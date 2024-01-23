Return-Path: <stable+bounces-14393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 461398380C1
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F384628CD39
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887C1133999;
	Tue, 23 Jan 2024 01:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qz/vkYLQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471B7133435;
	Tue, 23 Jan 2024 01:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705971880; cv=none; b=EwSX4MuruBSCWa7wmbE76y+HV7N2euaLMA7Z62Smo8NVZ4Ap4p0xtaYOBWb1p67fORCm+TBYJ3kpCug5x0XQNc/D/P3uKZq1G9kuZCKD17lmN8XqwmmCas0LDui5K/PBsOyqdtYavyrtYfv+82Jv4t01wsxNhdojr2f2WwaOMpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705971880; c=relaxed/simple;
	bh=oOC1RBp8TRcxF7GrV82qCazfF6olbEhd2lIwhyIb5ZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+ku0FAW6rCKl0b7OPKpWaNoN85S9Cd+d/swBm8perqzIjOC6xNBf/Tcur3w7LETNRyEu5OpO3UyWKNNvRf7C+/8qZJc+SI+mjGr4QMz/WBc5Y/IS2/Qz7X4ZKgCK86uSNISW610N7LRcSl+niNPnLRfnSkE78e87K8/cBOpWQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qz/vkYLQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23DBC433F1;
	Tue, 23 Jan 2024 01:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705971879;
	bh=oOC1RBp8TRcxF7GrV82qCazfF6olbEhd2lIwhyIb5ZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qz/vkYLQZydHj4ILLRwJxWYGdC494z0IjGRw96HTZ6hbE5g8Z6AzGKZj+PFoMAj3n
	 vqPdBkpFk9iw0Uy559OsyD+TPVRgaeg+xOLMl/AJXLoAoGknVfmujarCbUQsOQnGES
	 s+WfFCKS6tiFtgGtvvcRBunOisH37hSsQX6viTW8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alan Stern <stern@rowland.harvard.edu>,
	Douglas Anderson <dianders@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 340/417] usb: core: Allow subclassed USB drivers to override usb_choose_configuration()
Date: Mon, 22 Jan 2024 15:58:28 -0800
Message-ID: <20240122235803.576580466@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235751.480367507@linuxfoundation.org>
References: <20240122235751.480367507@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit a87b8e3be926af0fc3b9b1af42b1127bd1ff077c ]

For some USB devices we might want to do something different for
usb_choose_configuration(). One example here is the r8152 driver where
we want to end up using the vendor driver with the preferred
interface.

The r8152 driver tried to make things work by implementing a USB
generic_subclass driver and then overriding the normal config
selection after it happened. This is less than ideal and also caused
breakage if someone deauthorized and re-authorized the USB device
because the USB core ended up going back to it's default logic for
choosing the best config. I made an attempt to fix this [1] but it was
a bit ugly.

Let's do this better and allow USB generic_subclass drivers to
override usb_choose_configuration().

[1] https://lore.kernel.org/r/20231130154337.1.Ie00e07f07f87149c9ce0b27ae4e26991d307e14b@changeid

Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/r/20231201102946.v2.2.Iade5fa31997f1a0ca3e1dec0591633b02471df12@changeid
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: aa4f2b3e418e ("r8152: Choose our USB config with choose_configuration() rather than probe()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/core/generic.c | 7 +++++++
 include/linux/usb.h        | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/usb/core/generic.c b/drivers/usb/core/generic.c
index 740342a2812a..dcb897158228 100644
--- a/drivers/usb/core/generic.c
+++ b/drivers/usb/core/generic.c
@@ -59,10 +59,17 @@ int usb_choose_configuration(struct usb_device *udev)
 	int num_configs;
 	int insufficient_power = 0;
 	struct usb_host_config *c, *best;
+	struct usb_device_driver *udriver = to_usb_device_driver(udev->dev.driver);
 
 	if (usb_device_is_owned(udev))
 		return 0;
 
+	if (udriver->choose_configuration) {
+		i = udriver->choose_configuration(udev);
+		if (i >= 0)
+			return i;
+	}
+
 	best = NULL;
 	c = udev->config;
 	num_configs = udev->descriptor.bNumConfigurations;
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 3ce7b052a19f..08b1d6fbcd3c 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1234,6 +1234,9 @@ struct usb_driver {
  *	module is being unloaded.
  * @suspend: Called when the device is going to be suspended by the system.
  * @resume: Called when the device is being resumed by the system.
+ * @choose_configuration: If non-NULL, called instead of the default
+ *	usb_choose_configuration(). If this returns an error then we'll go
+ *	on to call the normal usb_choose_configuration().
  * @dev_groups: Attributes attached to the device that will be created once it
  *	is bound to the driver.
  * @drvwrap: Driver-model core structure wrapper.
@@ -1257,6 +1260,9 @@ struct usb_device_driver {
 
 	int (*suspend) (struct usb_device *udev, pm_message_t message);
 	int (*resume) (struct usb_device *udev, pm_message_t message);
+
+	int (*choose_configuration) (struct usb_device *udev);
+
 	const struct attribute_group **dev_groups;
 	struct usbdrv_wrap drvwrap;
 	const struct usb_device_id *id_table;
-- 
2.43.0





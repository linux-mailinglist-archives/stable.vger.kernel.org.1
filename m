Return-Path: <stable+bounces-192025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C06BEC28F86
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 14:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4F49E3472AD
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 13:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E05136672;
	Sun,  2 Nov 2025 13:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YASyBs7c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC2925557
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 13:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762090791; cv=none; b=KbHMOME4gXuoeHKCfbWlH+bnVp2hpat1pd545vn5HK9krEFddd2dL8pSBw0tzcxaJ2eUOq7uVjfKO28Ucjciv+jxtzAHmg+algAJ5uFVk40XBWbZAm5MsvJYGIUEXLGAbN4wxBHAPp8uH58BZ2YkaZ76nfukQQ9ejpmSu6YTtZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762090791; c=relaxed/simple;
	bh=bRsILxkOao+kZSxv7pKsLsJ1k0x12HNCxll8V83yzrI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=T09dBaLyQJ/BM3OrDzTImV8wivWm1PoQB6LXpAYc7eUz7fBDCs/RcPofnDwdEi+G76wCKoac+MlKFQn12nltz+63JfreOysN9epdZGiJ+bUepJWcG7DfEV+mKVMHshlGznpPqN43s5YYEqsVohZufNskakDUbm+k05FIYz45af0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YASyBs7c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61704C4CEF7;
	Sun,  2 Nov 2025 13:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762090791;
	bh=bRsILxkOao+kZSxv7pKsLsJ1k0x12HNCxll8V83yzrI=;
	h=Subject:To:Cc:From:Date:From;
	b=YASyBs7c3bU283x1Z8v+zZcAmLmHNyOt5NjcZjgjt9HbnGnr8KV3kIFKa/DoIIYsj
	 Oi3wO9FrExshgYSYNbTPHoC6ecen2pXHJShdCxDyz04nz1X1HExPPUj0dgNNXeZ7Un
	 RC/THTeqnCcmxYGJhsKSHv1zW2zZnqn3L8qxfH/A=
Subject: FAILED: patch "[PATCH] ACPI: fan: Use platform device for devres-related actions" failed to apply to 6.12-stable tree
To: W_Armin@gmx.de,rafael.j.wysocki@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 02 Nov 2025 22:39:48 +0900
Message-ID: <2025110248-reflex-facebook-1ab2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x d91a1d129b63614fa4c2e45e60918409ce36db7e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025110248-reflex-facebook-1ab2@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d91a1d129b63614fa4c2e45e60918409ce36db7e Mon Sep 17 00:00:00 2001
From: Armin Wolf <W_Armin@gmx.de>
Date: Wed, 8 Oct 2025 01:41:46 +0200
Subject: [PATCH] ACPI: fan: Use platform device for devres-related actions

Device-managed resources are cleaned up when the driver unbinds from
the underlying device. In our case this is the platform device as this
driver is a platform driver. Registering device-managed resources on
the associated ACPI device will thus result in a resource leak when
this driver unbinds.

Ensure that any device-managed resources are only registered on the
platform device to ensure that they are cleaned up during removal.

Fixes: 35c50d853adc ("ACPI: fan: Add hwmon support")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Cc: 6.11+ <stable@vger.kernel.org> # 6.11+
Link: https://patch.msgid.link/20251007234149.2769-4-W_Armin@gmx.de
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
index d39bb6fd1326..bedbab0e8e4e 100644
--- a/drivers/acpi/fan.h
+++ b/drivers/acpi/fan.h
@@ -65,9 +65,9 @@ int acpi_fan_create_attributes(struct acpi_device *device);
 void acpi_fan_delete_attributes(struct acpi_device *device);
 
 #if IS_REACHABLE(CONFIG_HWMON)
-int devm_acpi_fan_create_hwmon(struct acpi_device *device);
+int devm_acpi_fan_create_hwmon(struct device *dev);
 #else
-static inline int devm_acpi_fan_create_hwmon(struct acpi_device *device) { return 0; };
+static inline int devm_acpi_fan_create_hwmon(struct device *dev) { return 0; };
 #endif
 
 #endif
diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index ea2c646c470c..46e7fe7a506d 100644
--- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -347,7 +347,7 @@ static int acpi_fan_probe(struct platform_device *pdev)
 	}
 
 	if (fan->has_fst) {
-		result = devm_acpi_fan_create_hwmon(device);
+		result = devm_acpi_fan_create_hwmon(&pdev->dev);
 		if (result)
 			return result;
 
diff --git a/drivers/acpi/fan_hwmon.c b/drivers/acpi/fan_hwmon.c
index 4209a9923efc..4b2c2007f2d7 100644
--- a/drivers/acpi/fan_hwmon.c
+++ b/drivers/acpi/fan_hwmon.c
@@ -166,12 +166,12 @@ static const struct hwmon_chip_info acpi_fan_hwmon_chip_info = {
 	.info = acpi_fan_hwmon_info,
 };
 
-int devm_acpi_fan_create_hwmon(struct acpi_device *device)
+int devm_acpi_fan_create_hwmon(struct device *dev)
 {
-	struct acpi_fan *fan = acpi_driver_data(device);
+	struct acpi_fan *fan = dev_get_drvdata(dev);
 	struct device *hdev;
 
-	hdev = devm_hwmon_device_register_with_info(&device->dev, "acpi_fan", fan,
-						    &acpi_fan_hwmon_chip_info, NULL);
+	hdev = devm_hwmon_device_register_with_info(dev, "acpi_fan", fan, &acpi_fan_hwmon_chip_info,
+						    NULL);
 	return PTR_ERR_OR_ZERO(hdev);
 }



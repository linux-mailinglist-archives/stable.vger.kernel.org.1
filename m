Return-Path: <stable+bounces-192061-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A14C2906A
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 15:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26C283B0A6A
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 14:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744111D798E;
	Sun,  2 Nov 2025 14:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WncRa5V7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3121A14A62B
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 14:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762094118; cv=none; b=Be0NR3J5ra7dpTWtKL9DIpTgcJUI3+V6RFhVfHISFUgxqrEwNmw1y622tvirOf6/gvOpJC7qV8+w9f6A9/ZRVELCyMc+nvs2aOmyMKrEzCIILZsfKinkbwXgT+xzz5nfEm5u6W4KHUJrp5I6GehrrBYWUj68QWvRLYw+B971284=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762094118; c=relaxed/simple;
	bh=mJkAa6suZt7pDwjuU1k8pBOQa5KjILTW/JHj58OKXYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jhgBAsQg4JP6T2XZfKaEPvslbii2jkAGxUlqecxffCJ5eIZNdAp6yCwNa4xaBsO6gPjVgmCLlGLqWp1MmWz3KulDo++M+YXPUNLwUphc+oJzAIfZYsLAs2hArcWobyy9LQZJPcCbBXqkHRdedDignXhytIw9bl8odZd+A7Uva9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WncRa5V7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42848C4CEFD;
	Sun,  2 Nov 2025 14:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762094117;
	bh=mJkAa6suZt7pDwjuU1k8pBOQa5KjILTW/JHj58OKXYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WncRa5V7/J6I0I/4fm6F4ustGn51ToDXqY1agUtBoRurutzq48sDqVUCF8cKAr/f4
	 2VsHKNPoU9r5gaHTf2IMRqS/5jgVtE5icUXstLzGl5+hO9LF6TnJ7pR0PBFzRh6KKA
	 LmuwygQ6h+gFdDL6GjRdct2J/4xt6Sitv5qm5YXqdEKWgNN2WL/edIhTG2k9/mZJS/
	 zagjx9OP3R0uoHITt1yPm1FOjFjeW11Z3tLqYRhPMCUQ7jZ7IUJ91scaUeCLV9VUhW
	 7IVcCrbf73dXCJH/0jR/OFowpCin2G405OLZxophClVpHv4IjoJdLhKI5+IXOw1AC8
	 y4TPIoAUNkwDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] ACPI: fan: Use platform device for devres-related actions
Date: Sun,  2 Nov 2025 09:35:14 -0500
Message-ID: <20251102143514.3449278-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251102143514.3449278-1-sashal@kernel.org>
References: <2025110248-reflex-facebook-1ab2@gregkh>
 <20251102143514.3449278-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit d91a1d129b63614fa4c2e45e60918409ce36db7e ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/fan.h       | 4 ++--
 drivers/acpi/fan_core.c  | 2 +-
 drivers/acpi/fan_hwmon.c | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
index a7e39a29d4c89..c022b16d90647 100644
--- a/drivers/acpi/fan.h
+++ b/drivers/acpi/fan.h
@@ -62,9 +62,9 @@ int acpi_fan_create_attributes(struct acpi_device *device);
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
index f5f3091d5ca84..fd2563362142c 100644
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
index e8d90605106ef..cba1f096d9717 100644
--- a/drivers/acpi/fan_hwmon.c
+++ b/drivers/acpi/fan_hwmon.c
@@ -167,12 +167,12 @@ static const struct hwmon_chip_info acpi_fan_hwmon_chip_info = {
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
-- 
2.51.0



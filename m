Return-Path: <stable+bounces-204361-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA11ECEC211
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 16:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CAF283006464
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 15:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA4B4315A;
	Wed, 31 Dec 2025 15:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+RoWO3R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04F43A1E7E
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 15:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767193262; cv=none; b=fsHhT6f5glB/Lfx/v2MZ6+uFzSLvoyw63Sdr0uhh7+OWDchxY1YCd5groWK2ate7jRr+jzOUPyYKCpz0smhMlrpLCk2XqoeyCATSEzZa0TFzdmg6Fp0kjQqqdmlpmtO16WnTyyZWmDuqBSU4LrodazX4RuHaZfwfFZW4gk9e1nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767193262; c=relaxed/simple;
	bh=xEgLX8f11gMMx6UZCXhDc8sTgwR861ngstiLqaZvMaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eL7yIMxoByBXjyFOKCmK4xqy/uc0mJwfErVwIKcd40oydVZnLz85wd8Emw3fJk9KH40StVYhfGJYrOUy72zSgcv2E6ij7uNMO6QsvykRghqyXmE3jjNtD1uRlr4tKHlVNYYIhYkLnH0DdUCnxQCxhw8UGQrdIXis9B1lL/OCDO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+RoWO3R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3D3C113D0;
	Wed, 31 Dec 2025 15:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767193262;
	bh=xEgLX8f11gMMx6UZCXhDc8sTgwR861ngstiLqaZvMaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U+RoWO3RKrEHg5fIqWnr+e6Yq+rBGsGF43xvUyLGldm4e8+ho6V2cg+F5cNEdaZcb
	 Y1/J8y6L0FhqTx4a+6vePFivYnfO+cWcj0iH6bQdEil7SEkwFTaerYnXrYP+R5GyZs
	 13DjnDxz/MgP3i9LEIDzBgmNa9673Tk5u0rDFKvxquF5vQXONRi/rf67PcoYeIuahR
	 wyKSwtrlaxaTdu0bKUDoNSSx1hKNAnXk6aO157neU64PI8lXN9kUUPIfJToQS78KTT
	 cweYYUf9gko7rZ4KWJUMBmagokciw1EPyM1ex0+mFwWDHn+MuwMgWS+PWKtKu53cbV
	 0TZ1k3Bspmsig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Askar Safin <safinaskar@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] gpiolib: acpi: Add quirk for Dell Precision 7780
Date: Wed, 31 Dec 2025 10:00:59 -0500
Message-ID: <20251231150059.3101892-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122946-phonebook-gusty-03ac@gregkh>
References: <2025122946-phonebook-gusty-03ac@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Askar Safin <safinaskar@gmail.com>

[ Upstream commit 2d967310c49ed93ac11cef408a55ddf15c3dd52e ]

Dell Precision 7780 often wakes up on its own from suspend. Sometimes
wake up happens immediately (i. e. within 7 seconds), sometimes it happens
after, say, 30 minutes.

Fixes: 1796f808e4bb ("HID: i2c-hid: acpi: Stop setting wakeup_capable")
Link: https://lore.kernel.org/linux-i2c/197ae95ffd8.dc819e60457077.7692120488609091556@zohomail.com/
Cc: stable@vger.kernel.org
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Askar Safin <safinaskar@gmail.com>
Link: https://lore.kernel.org/r/20251206180414.3183334-2-safinaskar@gmail.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
[ adapted quirk entry location from gpiolib-acpi-quirks.c to gpiolib-acpi.c ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpiolib-acpi.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 8ddd5e8341a0..86de8740c0d4 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1720,6 +1720,28 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
 			.ignore_interrupt = "AMDI0030:00@11",
 		},
 	},
+	{
+		/*
+		 * Spurious wakeups, likely from touchpad controller
+		 * Dell Precision 7780
+		 * Found in BIOS 1.24.1
+		 *
+		 * Found in touchpad firmware, installed by Dell Touchpad Firmware Update Utility version 1160.4196.9, A01
+		 * ( Dell-Touchpad-Firmware-Update-Utility_VYGNN_WIN64_1160.4196.9_A00.EXE ),
+		 * released on 11 Jul 2024
+		 *
+		 * https://lore.kernel.org/linux-i2c/197ae95ffd8.dc819e60457077.7692120488609091556@zohomail.com/
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_FAMILY, "Precision"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Precision 7780"),
+			DMI_MATCH(DMI_BOARD_NAME, "0C6JVW"),
+		},
+		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
+			.ignore_wake = "VEN_0488:00@355",
+		},
+	},
 	{} /* Terminating entry */
 };
 
-- 
2.51.0



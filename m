Return-Path: <stable+bounces-204355-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AF9CEC161
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 15:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D2593011479
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 14:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8602269B01;
	Wed, 31 Dec 2025 14:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGx5bO+v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B8525F78F
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 14:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767191546; cv=none; b=haOpK01pJi7p5jaIUWQoQbTaZA2VJTWZSTxljxUg0ut828qp/OljD1ftvVaM9dF42et/61xTSfiGMaC2jV68sYxosUKlWMOtgCq2Q3zeWdIO38YO07E9x6eFQptvO3EW3udy9PmopPIkOinQ6hVDfbAOKzMlE0Yk0Hmf8+P1PEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767191546; c=relaxed/simple;
	bh=UsgsaU8GaEPwoiKlY0qyvGMtBK5bwT+yN0qh7h7NNhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fWAHZlYK1N20wMtn1wAWuXhTgNdEPlTLPfxYf1WsTWJUeDO4DtzX6hE1H0LOJnX98U0HI8bdMdXmSlDAGy8DZvwqRxgW7NvIP6UvhZ1Nqp/nKXxAQB/1PG3906S1gVZgF1plr43VMl5tDzC8/vOabLMK4/UsqQg8MB4MM1OJF/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGx5bO+v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2772C116B1;
	Wed, 31 Dec 2025 14:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767191546;
	bh=UsgsaU8GaEPwoiKlY0qyvGMtBK5bwT+yN0qh7h7NNhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iGx5bO+vKN6QWIDLZAHZDqdTfxIZ2TaRPePHpotj82lsrr7sQxGrYz9E1SdtAJgXW
	 04KGPchIqVgFFgHqF6xoICiDQacfjVsDc9VAI/UbuyO1r0LYs7wHWci0VtMWTstmZ4
	 MGM9GRqECj6J7KMZZUECqrubjocn8JMCWFVQgpcIU/HfX0dr+IZEYTE2Z9CqapAMrF
	 29WDHEB1eF+zOZTYiU0aVZiu/q6BCOsPQ/mVPY5iBAIwAwDWYB8kQtBrHmc0Vx/hR3
	 NDakjL+mI7SVQC04an6XJRF9kwfB+aOvC0Y9oqdPIqbOUKjPbADS+ug0QLROimrzrX
	 bbD2B2gwRSXIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Askar Safin <safinaskar@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 7/7] gpiolib: acpi: Add quirk for Dell Precision 7780
Date: Wed, 31 Dec 2025 09:32:18 -0500
Message-ID: <20251231143218.3042757-7-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251231143218.3042757-1-sashal@kernel.org>
References: <2025122946-rotunda-passenger-2915@gregkh>
 <20251231143218.3042757-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpiolib-acpi-quirks.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi-quirks.c b/drivers/gpio/gpiolib-acpi-quirks.c
index bfb04e67c4bc..2c20bda54a6d 100644
--- a/drivers/gpio/gpiolib-acpi-quirks.c
+++ b/drivers/gpio/gpiolib-acpi-quirks.c
@@ -358,6 +358,28 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
 			.ignore_wake = "ASCP1A00:00@8",
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



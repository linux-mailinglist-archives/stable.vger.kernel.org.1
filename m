Return-Path: <stable+bounces-203631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A683BCE71AA
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 705CC302A399
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 14:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E689532F741;
	Mon, 29 Dec 2025 14:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Sz0c2tHE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A811832ED56
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 14:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767018897; cv=none; b=Io//urGnRCCk+96+XkbnbA4xHVO045fE5WNeANbaPEO5cVhSSbK/fLbMsriaVIQisxLK5PIhX3vvRJ7dJBwzVBVRAuXzrRW6SxaVkwXZMOGJ1HOgEBXc7mKScCxDluv2zOe5NN/KN8u+0h+WkUrRDpgX7MPWMXgHFTkyGu48q+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767018897; c=relaxed/simple;
	bh=DsU3VlwIZ9RP/KcYOKkDs/4sXqyr4JN2uzN6hgiU0O0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VFwq7kzWEmWU4WdisRjRpfTs4UwRKDCkMaxMBQr5fDDEDpcDAoGHT4cShZFYueKsgCwXy+WjCo2F+v5aZfvTbwO9oLZ3aGDZ4z+8Ddwqa/ve5u8qcFL9KVB0juQj67UWUN7Yw2BkE6MjxFv9dZL/YqPdfRHNOq+/ygqtWziS19Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Sz0c2tHE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5285C4CEF7;
	Mon, 29 Dec 2025 14:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767018897;
	bh=DsU3VlwIZ9RP/KcYOKkDs/4sXqyr4JN2uzN6hgiU0O0=;
	h=Subject:To:Cc:From:Date:From;
	b=Sz0c2tHErLnuiZEYZdSi1cYXp41GK9wQgbNbvoZ6BrFbvemK/kh2ML6FBmWMde6Z0
	 Ge1BeaLe0pY6WJFBna/SAxgUe0FfMYeKLcXP+VzYEkQsQ4VKcUROnWRCBfjk1pKuNo
	 7qhGJiGiJNytFbocvA690EWsPUnWJZhdHZ+3Ygaw=
Subject: FAILED: patch "[PATCH] gpiolib: acpi: Add quirk for Dell Precision 7780" failed to apply to 6.6-stable tree
To: safinaskar@gmail.com,andriy.shevchenko@linux.intel.com,bartosz.golaszewski@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 15:34:46 +0100
Message-ID: <2025122946-phonebook-gusty-03ac@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 2d967310c49ed93ac11cef408a55ddf15c3dd52e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122946-phonebook-gusty-03ac@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2d967310c49ed93ac11cef408a55ddf15c3dd52e Mon Sep 17 00:00:00 2001
From: Askar Safin <safinaskar@gmail.com>
Date: Sat, 6 Dec 2025 18:04:13 +0000
Subject: [PATCH] gpiolib: acpi: Add quirk for Dell Precision 7780

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

diff --git a/drivers/gpio/gpiolib-acpi-quirks.c b/drivers/gpio/gpiolib-acpi-quirks.c
index 7b95d1b03361..a0116f004975 100644
--- a/drivers/gpio/gpiolib-acpi-quirks.c
+++ b/drivers/gpio/gpiolib-acpi-quirks.c
@@ -370,6 +370,28 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
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
 



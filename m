Return-Path: <stable+bounces-204353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D42CEC155
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 15:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 944823005AA3
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 14:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3695525F78F;
	Wed, 31 Dec 2025 14:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqpcY/6c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0F61BD035
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 14:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767191545; cv=none; b=oIp07DpXjpCtcCAXx2TjHwF2A7OL4vxSDmbio2kVYkrV16BM+MARnit0DJLoqn+ul2gaYDcPZYQaBpNLcurPK7w3TLlB9t/NvsAQXx94MF5v0LLcNpqSE8VpR8SnhmGB9Epv1mHqypuNDtJ2ZuWUgKzhrfrvvLpnz5j8RAfXq/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767191545; c=relaxed/simple;
	bh=sYeg7jw2fMl6BeSley3INr0POxjO0lybPnFV6DcKDu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ci/CFP8tvXo/iWzAAA1kHvz0pNge64tAhlufKxPOol5quEwxJbfyix0bJAUNYhckSSGciFsWiIlzrcfQm4CvlUaJ4p5s1RnzEDcqRcEdRRGrCfwidjV4oW1O1uVDhRF8jRYgt1i8H+suHd2zqqRwHXbLAJYsXZQMn6ByoMxVcac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqpcY/6c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2676C19421;
	Wed, 31 Dec 2025 14:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767191544;
	bh=sYeg7jw2fMl6BeSley3INr0POxjO0lybPnFV6DcKDu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZqpcY/6cRjmhxjoFmbs94tekfMm9eqhLcQZgW4k3LCMZVIEtV3Ze58ChUk8glOr8R
	 zvnBoqCBzfr8GyGtNkXensYR6v9jufbVjUzhKriEnG1qpSt/6Xt4QXbLDWvNb044TV
	 PlnIwQGmQJCfLU8ezh339OK32mDOpnNatUZSuUqzq3rnOZDWlFc0IwX5IPQjB0VHHp
	 LrA8nK23zwoCCvfe7WOJ4uxWDxcI5qJyYXIaek2Io6kWmNtOGSrE3ya0+b8pfg15fP
	 FmSZvXC36UYBZKzeUs1GUTwl1Erg9+UeQYM7OjRFsmkJq1TJI+xXfz4quNDZkNocBL
	 3iqtaVY3l1fWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 5/7] gpiolib: acpi: Add a quirk for Acer Nitro V15
Date: Wed, 31 Dec 2025 09:32:16 -0500
Message-ID: <20251231143218.3042757-5-sashal@kernel.org>
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

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 9ab29ed505557bd106e292184fa4917955eb8e6e ]

It is reported that on Acer Nitro V15 suspend only works properly if the
keyboard backlight is turned off. In looking through the issue Acer Nitro
V15 has a GPIO (#8) specified in _AEI but it has no matching notify device
in _EVT. The values for GPIO #8 change as keyboard backlight is turned on
and off.

This makes it seem that GPIO #8 is actually supposed to be solely for
keyboard backlight.  Turning off the interrupt for this GPIO fixes the issue.
Add a quirk that does just that.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4169
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Acked-by: Mika Westerberg <westeri@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Stable-dep-of: 2d967310c49e ("gpiolib: acpi: Add quirk for Dell Precision 7780")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpiolib-acpi-quirks.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi-quirks.c b/drivers/gpio/gpiolib-acpi-quirks.c
index 219667315b2c..c13545dce349 100644
--- a/drivers/gpio/gpiolib-acpi-quirks.c
+++ b/drivers/gpio/gpiolib-acpi-quirks.c
@@ -331,6 +331,19 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
 			.ignore_interrupt = "AMDI0030:00@11",
 		},
 	},
+	{
+		/*
+		 * Wakeup only works when keyboard backlight is turned off
+		 * https://gitlab.freedesktop.org/drm/amd/-/issues/4169
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_FAMILY, "Acer Nitro V 15"),
+		},
+		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
+			.ignore_interrupt = "AMDI0030:00@8",
+		},
+	},
 	{} /* Terminating entry */
 };
 
-- 
2.51.0



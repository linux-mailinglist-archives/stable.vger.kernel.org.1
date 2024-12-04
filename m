Return-Path: <stable+bounces-98600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1AF9E48DF
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B75B316A83E
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3066F20764E;
	Wed,  4 Dec 2024 23:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enzcSQ4R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94C5206F02;
	Wed,  4 Dec 2024 23:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354768; cv=none; b=p3ZZ9C0SmGtOBprONkQijf60ccvMdhz7SxqMzDPS9LnlZvhJARizX2zRXDQa5Ee4gLaPaisxa+45dSOEgjhSgf7qBJsIpwR5uffWcTQLwA+5T5npIiYGWdiAq2rYONguwXNhz0gUNBAJzYCejEsUvCZ9px0mXHslUQDAEZPthfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354768; c=relaxed/simple;
	bh=AmcnS98K5CV7Zi9qPcqk5ONcDG/eEZa5NnlUOdBArkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HprBjWJpK7kdmXWJNefaB0ysEcR0UYuWXAPaV9SyBHJ1dXNmHzifBwlUlmqMhUnBqJUgN0jRmfRQjicRJPo78yNTxopnvTDDA6iHTU2d4P+WiTNjFCYfcxX5agh7h8qTyMyc2XF+yhexaJF5RFvr9A37QldIfr8Ye8ABleJZ2Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enzcSQ4R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9044C4CECD;
	Wed,  4 Dec 2024 23:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354768;
	bh=AmcnS98K5CV7Zi9qPcqk5ONcDG/eEZa5NnlUOdBArkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=enzcSQ4RMvsgJIko9bjAK4mN2vx2MXdXPKoQ4h1qV8A+8Tmb5p3lv05bDq0DSJEQ5
	 3m+Ok6SAziIFEuthGQ8NwLW1STr3q7x5scC1vsKkQMMeruonfws7BbX0HM2hUZUvWa
	 YYKXv00uHmro1bQVjQfCAtv8rBQtnw9yetKHlLDpU9NwbfUMln0CLpZpBCtCDdWGNu
	 xh/w+zyXplFwDN8Ng0LiDyTe1q7khU6JIZB8MiMfn8V9tXvz0c7lsQ9gYRoEMC0i1I
	 VeZXpx30cgAgH4QHMeFqyNcAGT34bTqjbXhHpmO0zeo/IMgzoiyWlyHPxis9l3lD2u
	 zawTof84ellMw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	tony.luck@intel.com,
	mario.limonciello@amd.com,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 2/3] ACPI: x86: Clean up Asus entries in acpi_quirk_skip_dmi_ids[]
Date: Wed,  4 Dec 2024 17:14:38 -0500
Message-ID: <20241204221445.2247192-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204221445.2247192-1-sashal@kernel.org>
References: <20241204221445.2247192-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit bd8aa15848f5f21951cd0b0d01510b3ad1f777d4 ]

The Asus entries in the acpi_quirk_skip_dmi_ids[] table are the only
entries without a comment which model they apply to. Add these comments.

The Asus TF103C entry also is in the wrong place for what is supposed to
be an alphabetically sorted list. Move it up so that the list is properly
sorted and add a comment that the list is alphabetically sorted.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://patch.msgid.link/20241116095825.11660-2-hdegoede@redhat.com
[ rjw: Changelog and subject edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/x86/utils.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 159ac2b19672d..a53fe120348eb 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -287,6 +287,7 @@ static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
 	/*
 	 * 2. Devices which also have the skip i2c/serdev quirks and which
 	 *    need the x86-android-tablets module to properly work.
+	 *    Sorted alphabetically.
 	 */
 #if IS_ENABLED(CONFIG_X86_ANDROID_TABLETS)
 	{
@@ -312,6 +313,7 @@ static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
 					ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS),
 	},
 	{
+		/* Asus ME176C tablet */
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ME176C"),
@@ -322,23 +324,24 @@ static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
 					ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS),
 	},
 	{
-		/* Lenovo Yoga Book X90F/L */
+		/* Asus TF103C transformer 2-in-1 */
 		.matches = {
-			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
-			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "CHERRYVIEW D1 PLATFORM"),
-			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "YETI-11"),
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TF103C"),
 		},
 		.driver_data = (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
-					ACPI_QUIRK_UART1_SKIP |
 					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY |
 					ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS),
 	},
 	{
+		/* Lenovo Yoga Book X90F/L */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "TF103C"),
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "CHERRYVIEW D1 PLATFORM"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "YETI-11"),
 		},
 		.driver_data = (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
+					ACPI_QUIRK_UART1_SKIP |
 					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY |
 					ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS),
 	},
-- 
2.43.0



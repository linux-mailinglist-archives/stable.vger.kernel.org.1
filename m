Return-Path: <stable+bounces-127169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C91A0A7694A
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 17:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B360B16C393
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 15:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1610C22A7EF;
	Mon, 31 Mar 2025 14:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+2uzKjK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EA022A7EA;
	Mon, 31 Mar 2025 14:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432847; cv=none; b=MHMubc8NeW/WpmAyFJqia92trs3dZJZFUehaRwuOZUOOAq0IlSRjM2NxpCeQMP8W7VZwD5qERr/w0h0n9seYXiScAc100Ynql5w9KCRmvO9v0KBTWsqJXiN89skBZl4HhvJzembr1aDCD2mfix6Y8fZX2NY5jnZjRkk5BLwRAK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432847; c=relaxed/simple;
	bh=03GUPkvN3fUyT8jFdqABYHvz3SIz3uQ7nifCo28OzFA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XJsPt07vQKrDUuxVSE07wNT+07xZf9Dvd5hiy3gEjibo2USXnzQ8ckCI6i7/FTivGctCw/FZ09oVIcsBzJC/Z0DuBMeNomZiXAUs0aE3pRR5gAyYolG8620E23gVpsbx5BTT63BIKkLv4XKMVwPNcpT7q9emITMBSgvvUN1vTBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+2uzKjK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25601C4CEE3;
	Mon, 31 Mar 2025 14:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743432847;
	bh=03GUPkvN3fUyT8jFdqABYHvz3SIz3uQ7nifCo28OzFA=;
	h=From:To:Cc:Subject:Date:From;
	b=i+2uzKjKJd90xAWFxN+dKD4nG+0kc942kwvPkxhuo6NupY8dwncoP4sq5fG0xx7yg
	 8zKd8E3omo1xnqgoiH8hXWgFjEXSeuSBA6f0qdM9tRrFvEv4zI7F9sNbiQ8gm8h6t6
	 R2TLeeSoUCqdcKw9oCRcSZPUMf2Uj+yGgOGTr8j44zyngBhVqZQ+RGxBbYPt/tQqdb
	 1xEF4W5Tps13pkk0ABE+dEom80VToNOqHAWerLz2I23QxxFTa7sjDypz89lNHmEuKp
	 73K3gg2ExHF91CqyuRBfUyv9XrjYPJDIdvpId+Eni0kqwBxRE/RNacAz8tZEXkxXs2
	 zlecPY83iluYg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Schaefer <dhs@frame.work>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	linux@frame.work,
	"Dustin L . Howett" <dustin@howett.net>,
	Sasha Levin <sashal@kernel.org>,
	bleung@chromium.org,
	chrome-platform@lists.linux.dev
Subject: [PATCH AUTOSEL 6.13 01/24] platform/chrome: cros_ec_lpc: Match on Framework ACPI device
Date: Mon, 31 Mar 2025 10:53:41 -0400
Message-Id: <20250331145404.1705141-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
Content-Transfer-Encoding: 8bit

From: Daniel Schaefer <dhs@frame.work>

[ Upstream commit d83c45aeec9b223fe6db4175e9d1c4f5699cc37a ]

Load the cros_ec_lpc driver based on a Framework FRMWC004 ACPI device,
which mirrors GOOG0004, but also applies npcx quirks for Framework
systems.

Matching on ACPI will let us avoid having to change the SMBIOS match
rules again and again.

Cc: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: linux@frame.work
Cc: Dustin L. Howett <dustin@howett.net>
Signed-off-by: Daniel Schaefer <dhs@frame.work>
Link: https://lore.kernel.org/r/20250128181329.8070-1-dhs@frame.work
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/chrome/cros_ec_lpc.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 8470b7f2b1358..7924b79f84f1f 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -30,6 +30,7 @@
 
 #define DRV_NAME "cros_ec_lpcs"
 #define ACPI_DRV_NAME "GOOG0004"
+#define FRMW_ACPI_DRV_NAME "FRMWC004"
 
 /* True if ACPI device is present */
 static bool cros_ec_lpc_acpi_device_found;
@@ -460,7 +461,7 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
 	acpi_status status;
 	struct cros_ec_device *ec_dev;
 	struct cros_ec_lpc *ec_lpc;
-	struct lpc_driver_data *driver_data;
+	const struct lpc_driver_data *driver_data;
 	u8 buf[2] = {};
 	int irq, ret;
 	u32 quirks;
@@ -472,6 +473,9 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
 	ec_lpc->mmio_memory_base = EC_LPC_ADDR_MEMMAP;
 
 	driver_data = platform_get_drvdata(pdev);
+	if (!driver_data)
+		driver_data = acpi_device_get_match_data(dev);
+
 	if (driver_data) {
 		quirks = driver_data->quirks;
 
@@ -625,12 +629,6 @@ static void cros_ec_lpc_remove(struct platform_device *pdev)
 	cros_ec_unregister(ec_dev);
 }
 
-static const struct acpi_device_id cros_ec_lpc_acpi_device_ids[] = {
-	{ ACPI_DRV_NAME, 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(acpi, cros_ec_lpc_acpi_device_ids);
-
 static const struct lpc_driver_data framework_laptop_npcx_lpc_driver_data __initconst = {
 	.quirks = CROS_EC_LPC_QUIRK_REMAP_MEMORY,
 	.quirk_mmio_memory_base = 0xE00,
@@ -642,6 +640,13 @@ static const struct lpc_driver_data framework_laptop_mec_lpc_driver_data __initc
 	.quirk_aml_mutex_name = "ECMT",
 };
 
+static const struct acpi_device_id cros_ec_lpc_acpi_device_ids[] = {
+	{ ACPI_DRV_NAME, 0 },
+	{ FRMW_ACPI_DRV_NAME, (kernel_ulong_t)&framework_laptop_npcx_lpc_driver_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, cros_ec_lpc_acpi_device_ids);
+
 static const struct dmi_system_id cros_ec_lpc_dmi_table[] __initconst = {
 	{
 		/*
@@ -795,7 +800,8 @@ static int __init cros_ec_lpc_init(void)
 	int ret;
 	const struct dmi_system_id *dmi_match;
 
-	cros_ec_lpc_acpi_device_found = !!cros_ec_lpc_get_device(ACPI_DRV_NAME);
+	cros_ec_lpc_acpi_device_found = !!cros_ec_lpc_get_device(ACPI_DRV_NAME) ||
+		!!cros_ec_lpc_get_device(FRMW_ACPI_DRV_NAME);
 
 	dmi_match = dmi_first_match(cros_ec_lpc_dmi_table);
 
-- 
2.39.5



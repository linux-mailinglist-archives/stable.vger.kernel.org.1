Return-Path: <stable+bounces-127142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D62A7692C
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 17:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D580188731D
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 14:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1481E5705;
	Mon, 31 Mar 2025 14:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLUwUQyF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91371E260A;
	Mon, 31 Mar 2025 14:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432767; cv=none; b=Nxf3umjGSicFLSdR3qYXr/OMP6brXP8H7zJoR09X4cuXWtQvIhkrNcsca9VHQRljLXMzU2v2ZbBVmdgC0qOI5IamqNg8AAQBwx/oFKNsS5M7R85Jyq4d5Z4J4+0zS6QTnb8t02LyjkCWRwEeICRpOKZpw08RWnL4VveA5GvBqgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432767; c=relaxed/simple;
	bh=PHTS/WBwjTKYlMdCIAb1qBrBV5xna69lqUPWK3NIU3I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LP3L/nE8taoRrZxWXo0N2iIErcmHMCpAX3BEKh/tbNObC8A9Lzdi/oSqmBzSgEZJr8Su0puKdR09RbLOw091qHK6LfILQ94CSOvQYy5SgMmMBSkrGEmDeLTCcaxO7cjjKm3n0RNFy2btEv6fDXpl1s3pxy7noREvgaxuJNMxtwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLUwUQyF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95409C4CEE3;
	Mon, 31 Mar 2025 14:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743432767;
	bh=PHTS/WBwjTKYlMdCIAb1qBrBV5xna69lqUPWK3NIU3I=;
	h=From:To:Cc:Subject:Date:From;
	b=dLUwUQyFXWAmVwI1sjPLADc6RCr/s5sz4Emwroh5B2CnWtyKy+qMswNKAyS0+fnJU
	 n1peNmtHrGAKmZ16thmkWzufIMkuRaNSG1EARVc3EGWbvonap6s+fFvTAuZnT3bsHo
	 yw2FRggh/nqxbNxdCccET7gWUNJXnh2a3Vfbq6/ua9AGRRgLc5omxAjx7WW9wZP0mI
	 smvZVoLjUfBb7RxGJJKu6ALTSx2ng6+1dQMKTEPZN39SEXi87BnLaN/A8El3DR7i3M
	 EecxQhkqaBdS/ZPFU/ekotHrSlhqvLws9D4eqU7UJ5GtLD2oNtmGadf/NiGPGiBsOt
	 Ekq68N6Grd9lQ==
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
Subject: [PATCH AUTOSEL 6.14 01/27] platform/chrome: cros_ec_lpc: Match on Framework ACPI device
Date: Mon, 31 Mar 2025 10:52:19 -0400
Message-Id: <20250331145245.1704714-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
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
index 5a2f1d98b3501..be319949b9415 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -30,6 +30,7 @@
 
 #define DRV_NAME "cros_ec_lpcs"
 #define ACPI_DRV_NAME "GOOG0004"
+#define FRMW_ACPI_DRV_NAME "FRMWC004"
 
 /* True if ACPI device is present */
 static bool cros_ec_lpc_acpi_device_found;
@@ -514,7 +515,7 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
 	acpi_status status;
 	struct cros_ec_device *ec_dev;
 	struct cros_ec_lpc *ec_lpc;
-	struct lpc_driver_data *driver_data;
+	const struct lpc_driver_data *driver_data;
 	u8 buf[2] = {};
 	int irq, ret;
 	u32 quirks;
@@ -526,6 +527,9 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
 	ec_lpc->mmio_memory_base = EC_LPC_ADDR_MEMMAP;
 
 	driver_data = platform_get_drvdata(pdev);
+	if (!driver_data)
+		driver_data = acpi_device_get_match_data(dev);
+
 	if (driver_data) {
 		quirks = driver_data->quirks;
 
@@ -696,12 +700,6 @@ static void cros_ec_lpc_remove(struct platform_device *pdev)
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
@@ -713,6 +711,13 @@ static const struct lpc_driver_data framework_laptop_mec_lpc_driver_data __initc
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
@@ -866,7 +871,8 @@ static int __init cros_ec_lpc_init(void)
 	int ret;
 	const struct dmi_system_id *dmi_match;
 
-	cros_ec_lpc_acpi_device_found = !!cros_ec_lpc_get_device(ACPI_DRV_NAME);
+	cros_ec_lpc_acpi_device_found = !!cros_ec_lpc_get_device(ACPI_DRV_NAME) ||
+		!!cros_ec_lpc_get_device(FRMW_ACPI_DRV_NAME);
 
 	dmi_match = dmi_first_match(cros_ec_lpc_dmi_table);
 
-- 
2.39.5



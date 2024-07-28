Return-Path: <stable+bounces-61986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE7593E1AF
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 02:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 513251F2173C
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 00:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B205A2574B;
	Sun, 28 Jul 2024 00:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qe+UlxsF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A43A2C80;
	Sun, 28 Jul 2024 00:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722127673; cv=none; b=W1+UkakLxsGoCAR2OODb1xdtd2v61SH3Nju/2F82u7OBnx2mvYP2nEqfd003IqOmQ4f8dOqvXHKqwpq3bt0yTl86Bq/2c7tVc9zHWLMVAW0LXeEOsbSN+92/DnJbK5Qsm8c5Ze33mVkcqWcIoMiF6dXk37PqvFA70deB/+osreg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722127673; c=relaxed/simple;
	bh=WPtZtrMFhL/pI8aihGmlerhhr2GtDKr2gXIaZgt7oyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m3lIYoFTHFI2jgvEzaeeu+MuDAO78BhkLHDuCVg3kNHlKGROH33EF5e9RDhRvfzmptfUVaMyp0nUrcWfRJDc7ZOUJ11+M5k7c59iylhIV3nPZhhiKKrIsVH18kx2k63nw52e3f0VeZzC3l62vnfXc1VEJWrFaVVwMqEntxN7ypQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qe+UlxsF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9133C4AF0E;
	Sun, 28 Jul 2024 00:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722127672;
	bh=WPtZtrMFhL/pI8aihGmlerhhr2GtDKr2gXIaZgt7oyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qe+UlxsFfMCjJaMcZDnotzigrSzUdm8whaAsHeGi0pYL6riyt6jbGrKzEzIwJ7tHA
	 X1Ij7q6nQxjOhrLSssjmUqC+vtNWsIjaiof2EUdsC/bUZhYUOxYTc5zlKdDcuIKtnu
	 mO4vI+zvhGyM5ImGoKIMiDkqHlmXcmEI9XxatF+teD+Nbwwhszu/ZVu9S5089ygy5r
	 4EGak8oRO1AmO13YLjn6M+EGf//p240YCMwetFsZiaz+uRMdi6L4gpPM2P86KEhhQo
	 5QKpejZkZ7bJOtuLGjq9noA6qk6ywQVgG+ITbqTi4tA3D8o0XQtjnnuDjNW67cNxS7
	 eYfRdI3JrohHA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ben Walsh <ben@jubnut.com>,
	"Dustin L . Howett" <dustin@howett.net>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	bleung@chromium.org,
	chrome-platform@lists.linux.dev
Subject: [PATCH AUTOSEL 6.10 06/16] platform/chrome: cros_ec_lpc: Add a new quirk for ACPI id
Date: Sat, 27 Jul 2024 20:47:23 -0400
Message-ID: <20240728004739.1698541-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728004739.1698541-1-sashal@kernel.org>
References: <20240728004739.1698541-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Ben Walsh <ben@jubnut.com>

[ Upstream commit 040159e0912c31fe959d8671f9700bda105ab63a ]

Framework Laptops' ACPI exposes the EC with id "PNP0C09". But
"PNP0C09" is part of the ACPI standard; there are lots of computers
with EC chips with this id, and most of them don't support the cros_ec
protocol.

The driver could find the ACPI device by having "PNP0C09" in the
acpi_match_table, but this would match devices which don't support the
cros_ec protocol. Instead, add a new quirk "CROS_EC_LPC_QUIRK_ACPI_ID"
which allows the id to be specified. This quirk is applied after the
DMI check shows that the device is supported.

Tested-by: Dustin L. Howett <dustin@howett.net>
Signed-off-by: Ben Walsh <ben@jubnut.com>
Link: https://lore.kernel.org/r/20240605063351.14836-4-ben@jubnut.com
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/chrome/cros_ec_lpc.c | 50 ++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index ddfbfec44f4cc..43e0914256a3c 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -39,6 +39,11 @@ static bool cros_ec_lpc_acpi_device_found;
  * be used as the base port for EC mapped memory.
  */
 #define CROS_EC_LPC_QUIRK_REMAP_MEMORY              BIT(0)
+/*
+ * Indicates that lpc_driver_data.quirk_acpi_id should be used to find
+ * the ACPI device.
+ */
+#define CROS_EC_LPC_QUIRK_ACPI_ID                   BIT(1)
 
 /**
  * struct lpc_driver_data - driver data attached to a DMI device ID to indicate
@@ -46,10 +51,12 @@ static bool cros_ec_lpc_acpi_device_found;
  * @quirks: a bitfield composed of quirks from CROS_EC_LPC_QUIRK_*
  * @quirk_mmio_memory_base: The first I/O port addressing EC mapped memory (used
  *                          when quirk ...REMAP_MEMORY is set.)
+ * @quirk_acpi_id: An ACPI HID to be used to find the ACPI device.
  */
 struct lpc_driver_data {
 	u32 quirks;
 	u16 quirk_mmio_memory_base;
+	const char *quirk_acpi_id;
 };
 
 /**
@@ -374,6 +381,26 @@ static void cros_ec_lpc_acpi_notify(acpi_handle device, u32 value, void *data)
 		pm_system_wakeup();
 }
 
+static acpi_status cros_ec_lpc_parse_device(acpi_handle handle, u32 level,
+					    void *context, void **retval)
+{
+	*(struct acpi_device **)context = acpi_fetch_acpi_dev(handle);
+	return AE_CTRL_TERMINATE;
+}
+
+static struct acpi_device *cros_ec_lpc_get_device(const char *id)
+{
+	struct acpi_device *adev = NULL;
+	acpi_status status = acpi_get_devices(id, cros_ec_lpc_parse_device,
+					      &adev, NULL);
+	if (ACPI_FAILURE(status)) {
+		pr_warn(DRV_NAME ": Looking for %s failed\n", id);
+		return NULL;
+	}
+
+	return adev;
+}
+
 static int cros_ec_lpc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -401,6 +428,16 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
 
 		if (quirks & CROS_EC_LPC_QUIRK_REMAP_MEMORY)
 			ec_lpc->mmio_memory_base = driver_data->quirk_mmio_memory_base;
+
+		if (quirks & CROS_EC_LPC_QUIRK_ACPI_ID) {
+			adev = cros_ec_lpc_get_device(driver_data->quirk_acpi_id);
+			if (!adev) {
+				dev_err(dev, "failed to get ACPI device '%s'",
+					driver_data->quirk_acpi_id);
+				return -ENODEV;
+			}
+			ACPI_COMPANION_SET(dev, adev);
+		}
 	}
 
 	/*
@@ -661,23 +698,12 @@ static struct platform_device cros_ec_lpc_device = {
 	.name = DRV_NAME
 };
 
-static acpi_status cros_ec_lpc_parse_device(acpi_handle handle, u32 level,
-					    void *context, void **retval)
-{
-	*(bool *)context = true;
-	return AE_CTRL_TERMINATE;
-}
-
 static int __init cros_ec_lpc_init(void)
 {
 	int ret;
-	acpi_status status;
 	const struct dmi_system_id *dmi_match;
 
-	status = acpi_get_devices(ACPI_DRV_NAME, cros_ec_lpc_parse_device,
-				  &cros_ec_lpc_acpi_device_found, NULL);
-	if (ACPI_FAILURE(status))
-		pr_warn(DRV_NAME ": Looking for %s failed\n", ACPI_DRV_NAME);
+	cros_ec_lpc_acpi_device_found = !!cros_ec_lpc_get_device(ACPI_DRV_NAME);
 
 	dmi_match = dmi_first_match(cros_ec_lpc_dmi_table);
 
-- 
2.43.0



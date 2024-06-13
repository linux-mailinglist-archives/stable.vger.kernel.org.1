Return-Path: <stable+bounces-50777-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D670906C9A
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 13:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC416B2136C
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 11:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC8F144D27;
	Thu, 13 Jun 2024 11:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YXUbOkWo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E75145338;
	Thu, 13 Jun 2024 11:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279355; cv=none; b=Vu9wzvZpeLyTsv+4B3ZCKCEXNMSYuOrjnxqdvT8GcA+DuuwSmpvuvhOl41eFl7rePA67zCA6Qd82CRtCNTbT4Mn7TpAjPIi4HHXimU5+Y+IquhJhUo2zx+/5CgapWK5RTvFlTC59MTuyUe/6xNRoMgZ5asemGJozQIsJREYhTIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279355; c=relaxed/simple;
	bh=IC8TmWHf7MFcl3cxkc3ETWVGKbyZRCZJNi0EY7GOgYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FVcbnffK4cSbBYm5jP13le4gcxXla36yvfjMTbsbpfZC2naOfP2LgHI4yKa1tRZUDnf15R5krE8rMogKJAXG6Z7Uj2cJdBIDKY82Xr/bHEhoFgGiBMK0Iy7Rl2T74vhWsmc81RyMO4Z9C4NCpcYq15zleprnmnPfXYOD56R67aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YXUbOkWo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC12C2BBFC;
	Thu, 13 Jun 2024 11:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718279354;
	bh=IC8TmWHf7MFcl3cxkc3ETWVGKbyZRCZJNi0EY7GOgYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YXUbOkWoZMcPaBQoV8HMRlz8cYUxUtvojDE9vBJU446G/1XsALWoMbiOftqI2zCB5
	 WRKgYJ5lEhUZEdAgiKbt9M3JLJEBjfCiloBjwnmjAQAiYe4o6ymPgUwR3ops5JpfTQ
	 d097P53eYPUiTxgf9oSEe4MZyh2gEargyOCvMxaA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Shevchenko <andy@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.9 047/157] mmc: sdhci-acpi: Fix Lenovo Yoga Tablet 2 Pro 1380 sdcard slot not working
Date: Thu, 13 Jun 2024 13:32:52 +0200
Message-ID: <20240613113229.246050208@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113227.389465891@linuxfoundation.org>
References: <20240613113227.389465891@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit f3521d7cbaefff19cc656325787ed797e5f6a955 upstream.

The Lenovo Yoga Tablet 2 Pro 1380 sdcard slot has an active high cd pin
and a broken wp pin which always reports the card being write-protected.

Add a DMI quirk to address both issues.

Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240410191639.526324-5-hdegoede@redhat.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/sdhci-acpi.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -80,6 +80,7 @@ struct sdhci_acpi_host {
 enum {
 	DMI_QUIRK_RESET_SD_SIGNAL_VOLT_ON_SUSP			= BIT(0),
 	DMI_QUIRK_SD_NO_WRITE_PROTECT				= BIT(1),
+	DMI_QUIRK_SD_CD_ACTIVE_HIGH				= BIT(2),
 };
 
 static inline void *sdhci_acpi_priv(struct sdhci_acpi_host *c)
@@ -749,6 +750,26 @@ static const struct dmi_system_id sdhci_
 	},
 	{
 		/*
+		 * Lenovo Yoga Tablet 2 Pro 1380F/L (13" Android version) this
+		 * has broken WP reporting and an inverted CD signal.
+		 * Note this has more or less the same BIOS as the Lenovo Yoga
+		 * Tablet 2 830F/L or 1050F/L (8" and 10" Android), but unlike
+		 * the 830 / 1050 models which share the same mainboard this
+		 * model has a different mainboard and the inverted CD and
+		 * broken WP are unique to this board.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Intel Corp."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "VALLEYVIEW C0 PLATFORM"),
+			DMI_MATCH(DMI_BOARD_NAME, "BYT-T FFD8"),
+			/* Full match so as to NOT match the 830/1050 BIOS */
+			DMI_MATCH(DMI_BIOS_VERSION, "BLADE_21.X64.0005.R00.1504101516"),
+		},
+		.driver_data = (void *)(DMI_QUIRK_SD_NO_WRITE_PROTECT |
+					DMI_QUIRK_SD_CD_ACTIVE_HIGH),
+	},
+	{
+		/*
 		 * The Toshiba WT8-B's microSD slot always reports the card being
 		 * write-protected.
 		 */
@@ -867,6 +888,9 @@ static int sdhci_acpi_probe(struct platf
 	if (sdhci_acpi_flag(c, SDHCI_ACPI_SD_CD)) {
 		bool v = sdhci_acpi_flag(c, SDHCI_ACPI_SD_CD_OVERRIDE_LEVEL);
 
+		if (quirks & DMI_QUIRK_SD_CD_ACTIVE_HIGH)
+			host->mmc->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
+
 		err = mmc_gpiod_request_cd(host->mmc, NULL, 0, v, 0);
 		if (err) {
 			if (err == -EPROBE_DEFER)




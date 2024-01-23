Return-Path: <stable+bounces-13525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A94CA837C75
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AD881F27C28
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1793433AE;
	Tue, 23 Jan 2024 00:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pBUY7qAw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF3433097;
	Tue, 23 Jan 2024 00:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969626; cv=none; b=HTa7Ij9izoU4jn+QG5IWwBLWtbdG1sQDtl5Aw1hdOiMWnioJ4rAsOH9SjeDJrfFRXcZhS4jhA13AXUraiKyQ4B1TsxqoGkB+32monYELVyQCcRyTmu2vtCAGdi30XZXDS2xYA47IwzaGI/pgxQQlIvgP93vzDupHQ5ypFZgObPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969626; c=relaxed/simple;
	bh=nGQNSTrYnprGBqoy/9SUVzVTAbDf5k0pLJjfvATqGUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mbMEVqVqJeV3yufOapFd0CCHMg2T53kz+vMCuvkHR3PU8bd9LnKqmdQA+bANnIDTDfDzg4vEIYu29jWjSeGUPLbnGQ5rMOMbnt/8YMJtmBVsbhf8tmgSwSnGQCEqxGdt/yxRaloX6N61tk6l/GwCA15ckcsLRI2j0mMGW/LKQ3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pBUY7qAw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6C2C433C7;
	Tue, 23 Jan 2024 00:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969626;
	bh=nGQNSTrYnprGBqoy/9SUVzVTAbDf5k0pLJjfvATqGUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pBUY7qAwvHf1Jx/vDmQSAnlAUT4MJk3/eCeptpIan12ApIU4CkEgkb6siIogCn9zh
	 AtAC42lPWjwjr/HgLZ0gE3EcsDMM6UKjVsl1tKXsIF5FeHtJOxODazl93T7JFHQFQQ
	 ZfL3B9udTNbKr0EHycydEZ4WXeJ+dqXdPSqtHH5M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Emil Velikov <emil.velikov@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 343/641] ASoC: amd: vangogh: Drop conflicting ACPI-based probing
Date: Mon, 22 Jan 2024 15:54:07 -0800
Message-ID: <20240122235828.657876424@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

[ Upstream commit ddd1ee12a8fb6e4d6f86eddeba64c135eee56623 ]

The Vangogh machine driver variant based on the MAX98388 amplifier, as
found on Valve's Steam Deck OLED, relies on probing via an ACPI match
table.  This worked fine until commit 197b1f7f0df1 ("ASoC: amd: Add new
dmi entries to config entry") enabled SOF support for the target machine
(i.e. Galileo product), causing the sound card to enter the deferred
probe state indefinitely:

$ cat /sys/kernel/debug/devices_deferred
AMDI8821:00	acp5x_mach: Register card (acp5x-max98388) failed

The issue is related to commit e89f45edb747 ("ASoC: amd: vangogh: Add
check for acp config flags in vangogh platform"), which tries to
mitigate potential conflicts between SOF and generic ACP Vangogh
drivers, due to sharing the PCI device IDs.

However, the solution is effective only if the machine driver is
directly probed by pci-acp5x through platform_device_register_full().

Hence, remove the conflicting ACPI based probing and rely exclusively on
DMI quirks for sound card setup.

Fixes: dba22efd0d17 ("ASoC: amd: vangogh: Add support for NAU8821/MAX98388 variant")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Reviewed-by: Emil Velikov <emil.velikov@collabora.com>
Link: https://msgid.link/r/20231209203229.878730-2-cristian.ciocaltea@collabora.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/vangogh/acp5x-mach.c | 35 +++++++++++-------------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/sound/soc/amd/vangogh/acp5x-mach.c b/sound/soc/amd/vangogh/acp5x-mach.c
index de4b478a983d..7878e061ecb9 100644
--- a/sound/soc/amd/vangogh/acp5x-mach.c
+++ b/sound/soc/amd/vangogh/acp5x-mach.c
@@ -439,7 +439,15 @@ static const struct dmi_system_id acp5x_vg_quirk_table[] = {
 		.matches = {
 			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Valve"),
 			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Jupiter"),
-		}
+		},
+		.driver_data = (void *)&acp5x_8821_35l41_card,
+	},
+	{
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Valve"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Galileo"),
+		},
+		.driver_data = (void *)&acp5x_8821_98388_card,
 	},
 	{}
 };
@@ -452,25 +460,15 @@ static int acp5x_probe(struct platform_device *pdev)
 	struct snd_soc_card *card;
 	int ret;
 
-	card = (struct snd_soc_card *)device_get_match_data(dev);
-	if (!card) {
-		/*
-		 * This is normally the result of directly probing the driver
-		 * in pci-acp5x through platform_device_register_full(), which
-		 * is necessary for the CS35L41 variant, as it doesn't support
-		 * ACPI probing and relies on DMI quirks.
-		 */
-		dmi_id = dmi_first_match(acp5x_vg_quirk_table);
-		if (!dmi_id)
-			return -ENODEV;
-
-		card = &acp5x_8821_35l41_card;
-	}
+	dmi_id = dmi_first_match(acp5x_vg_quirk_table);
+	if (!dmi_id || !dmi_id->driver_data)
+		return -ENODEV;
 
 	machine = devm_kzalloc(dev, sizeof(*machine), GFP_KERNEL);
 	if (!machine)
 		return -ENOMEM;
 
+	card = dmi_id->driver_data;
 	card->dev = dev;
 	platform_set_drvdata(pdev, card);
 	snd_soc_card_set_drvdata(card, machine);
@@ -482,17 +480,10 @@ static int acp5x_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct acpi_device_id acp5x_acpi_match[] = {
-	{ "AMDI8821", (kernel_ulong_t)&acp5x_8821_98388_card },
-	{},
-};
-MODULE_DEVICE_TABLE(acpi, acp5x_acpi_match);
-
 static struct platform_driver acp5x_mach_driver = {
 	.driver = {
 		.name = DRV_NAME,
 		.pm = &snd_soc_pm_ops,
-		.acpi_match_table = acp5x_acpi_match,
 	},
 	.probe = acp5x_probe,
 };
-- 
2.43.0





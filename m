Return-Path: <stable+bounces-152008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8291BAD1AD1
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 11:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B56A188CECE
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 09:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4D82512C8;
	Mon,  9 Jun 2025 09:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="DYax6Ykf"
X-Original-To: stable@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6329024EF88;
	Mon,  9 Jun 2025 09:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749461997; cv=none; b=iFe6f+XgKdh/6kv3b9YE0DqEL8xIYVYOMOtlYL9Igz9er8Y3a4yCz/sjZlTL1uGnLZa6H8/jurOiHH2/X7VI9oCk20WDcM29fWNYmQcFV0u6dvg4jo7MJeKnc+3eLUPlbUXH57yiUTq54BAF6Au15A46UHI8Wi8O1RHio9q3VJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749461997; c=relaxed/simple;
	bh=EfGgIkuaur2I5vqNhBQyEsrKXUnkdiiRff/Ou7A9Smk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Bs23Cb9zuoYRSAJY3vwwRTOhIvkMmtlZMLKR2IitM/QEZVrN+zpUF2Olp+yZN6mTVxvv6C0/kMDYyW6qLI9r8oDim5HDarxdO1Nup3els/YTwQSolyOyJsBDEh8ReIPM/FCxcpF19cgOLeM0KOQRylbLhEN0RkL8KVWC7JidIVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=DYax6Ykf; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1749461993;
	bh=EfGgIkuaur2I5vqNhBQyEsrKXUnkdiiRff/Ou7A9Smk=;
	h=From:Date:Subject:To:Cc:From;
	b=DYax6Ykfp4NShJegEoPDQFgxw8UAI2qG8IQ07G34K2cfhnzcIVkuWXpPM3uj2pvm0
	 LsbY9lgXojV00EepYA29CdvLPIA3IZTa5R0bwf5heLs/ZPs5LSyfJX/aY2MINcyQRA
	 SW+qWBU617CIvE3nyh9D+GFp3upoiCksDqGu/X3s=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 09 Jun 2025 11:39:35 +0200
Subject: [PATCH v2] mfd: cros_ec: Separate charge-control probing from
 USB-PD
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250609-cros-ec-mfd-chctl-probe-v2-1-33b236a7b7bc@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIANarRmgC/4WNQQ6CMBBFr0Jm7RhapEZX3sOwKMPUNlFKOhU1h
 LtbuYDL95L//gLCKbDAuVog8RwkxLGA3lVA3o43xjAUBl3rtm61QkpRkAkfbkDylO84pdgzmoM
 1jaUTKVNDWU+JXXhv5WtX2AfJMX22o1n97P/mrFCh4d5xYw07e7y8OIgI+affj5yhW9f1CykbJ
 W3DAAAA
X-Change-ID: 20250521-cros-ec-mfd-chctl-probe-64a63ac9c160
To: Lee Jones <lee@kernel.org>, Benson Leung <bleung@chromium.org>, 
 Guenter Roeck <groeck@chromium.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Tom Vincent <linux@tlvince.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749461993; l=2534;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=EfGgIkuaur2I5vqNhBQyEsrKXUnkdiiRff/Ou7A9Smk=;
 b=wsJn4sPhXWyjJ78TeS1erDeOTb4hTGTVHtLf+dxmvjC4niSJft/j7CsYZd35pn2/kJfcxVHm/
 OMoEYxX3ep+CDKPQtgALPNH87wyDPmUCu9YrBe3iQ4YgyV6ozimapQQ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The charge-control subsystem in the ChromeOS EC is not strictly tied to
its USB-PD subsystem.
Since commit 7613bc0d116a ("mfd: cros_ec: Don't load charger with UCSI")
the presence of EC_FEATURE_UCSI_PPM would inhibit the probing of the
charge-control driver.
Furthermore recent versions of the EC firmware in Framework laptops
hard-disable EC_FEATURE_USB_PD to avoid probing cros-usbpd-charger,
which then also breaks cros-charge-control.

Instead use the dedicated EC_FEATURE_CHARGER.

Link: https://github.com/FrameworkComputer/EmbeddedController/commit/1d7bcf1d50137c8c01969eb65880bc83e424597e
Fixes: 555b5fcdb844 ("mfd: cros_ec: Register charge control subdevice")
Cc: stable@vger.kernel.org
Tested-by: Tom Vincent <linux@tlvince.com>
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Rebase onto v6.16-rc1
- Pick up tested-by from Tom
- Also Cc stable@
- Link to v1: https://lore.kernel.org/r/20250521-cros-ec-mfd-chctl-probe-v1-1-6ebfe3a6efa7@weissschuh.net
---
 drivers/mfd/cros_ec_dev.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 9f84a52b48d6a8994d23edba999398684303ee64..dc80a272726bb16b58253418999021cd56dfd975 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -87,7 +87,6 @@ static const struct mfd_cell cros_ec_sensorhub_cells[] = {
 };
 
 static const struct mfd_cell cros_usbpd_charger_cells[] = {
-	{ .name = "cros-charge-control", },
 	{ .name = "cros-usbpd-charger", },
 	{ .name = "cros-usbpd-logger", },
 };
@@ -112,6 +111,10 @@ static const struct mfd_cell cros_ec_ucsi_cells[] = {
 	{ .name = "cros_ec_ucsi", },
 };
 
+static const struct mfd_cell cros_ec_charge_control_cells[] = {
+	{ .name = "cros-charge-control", },
+};
+
 static const struct cros_feature_to_cells cros_subdevices[] = {
 	{
 		.id		= EC_FEATURE_CEC,
@@ -148,6 +151,11 @@ static const struct cros_feature_to_cells cros_subdevices[] = {
 		.mfd_cells	= cros_ec_keyboard_leds_cells,
 		.num_cells	= ARRAY_SIZE(cros_ec_keyboard_leds_cells),
 	},
+	{
+		.id		= EC_FEATURE_CHARGER,
+		.mfd_cells	= cros_ec_charge_control_cells,
+		.num_cells	= ARRAY_SIZE(cros_ec_charge_control_cells),
+	},
 };
 
 static const struct mfd_cell cros_ec_platform_cells[] = {

---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250521-cros-ec-mfd-chctl-probe-64a63ac9c160

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>



Return-Path: <stable+bounces-180857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A712B8E9D8
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 02:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0D6D7AB3F5
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 00:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CFB23CB;
	Mon, 22 Sep 2025 00:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNhn81Vx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D979800
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 00:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758499601; cv=none; b=TmebUqov7IdBYVMMgs72QebjkBDpy9jZoAMy9XjkJ9Dmsqnrp7SGYlAw/KQ5bp+l67kif6KR20WfOiDC9fSfAYZCSJhFZWtgcj+BGZTnlOJpzBioV3RprzCki4jwK5NYHzTr2ujyWo5pxLcUxr0wFcaPUXiYO9f2sRZu49cd4yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758499601; c=relaxed/simple;
	bh=XouJ6O1G6ZSvMQwFa7wkigVRDoR32BtWV0QXd0gOb6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YlCYA281iw8fjQvyH7M4uOTtrVtfyol26VDjTD9GNs59SuOeGzo8wzs4MSsWG7CQOs+zMtW4mLrg0tweEGCrlqB4RFBoaLO3oT3/BiPdUkqBsa13BEizKvoMQLXcTIZ3inecoUaMzB9X6fPw3rgLtrFInL0mmHHiXtbVUw7pwM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNhn81Vx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DC9C4CEE7;
	Mon, 22 Sep 2025 00:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758499600;
	bh=XouJ6O1G6ZSvMQwFa7wkigVRDoR32BtWV0QXd0gOb6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qNhn81VxitK715cuv2Jcj+ZmdQ8wPKt/wY0VuZqTSd5Kti4wkZmaTyeVNS7aibYhB
	 0gyxUrcGV4PR9P4AGusn1tQPD/6ER1+thIRRGPL1jN0dDeUTBErChS1pPGgyzCiCaS
	 l5B4U/sOzJhv8y30xga8kHnJGogaG52HVFKyGu6nx69TQohBdmZcKvy+dU7evdlYnh
	 K4GDuI4tbK6PNVEvZiE3qdJ32CIPnozrrmchHq/dvBAbYFHxRsNMpd7lE/JXiwVj6r
	 vlGYHLBa9zmlmD3BCxb7ldXKOCJOyoLJbxKZaieF0p5fVoDCCu6gPP0QYHMJQ5eeej
	 JdlzAmW6+STVw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y 1/2] net: rfkill: gpio: add DT support
Date: Sun, 21 Sep 2025 20:06:36 -0400
Message-ID: <20250922000637.3095532-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025092157-imagines-darkroom-e5c5@gregkh>
References: <2025092157-imagines-darkroom-e5c5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Philipp Zabel <p.zabel@pengutronix.de>

[ Upstream commit d64c732dfc9edcd57feb693c23162117737e426b ]

Allow probing rfkill-gpio via device tree. This hooks up the already
existing support that was started in commit 262c91ee5e52 ("net:
rfkill: gpio: prepare for DT and ACPI support") via the "rfkill-gpio"
compatible, with the "name" and "type" properties renamed to "label"
and "radio-type", respectively, in the device tree case.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Link: https://lore.kernel.org/r/20230102-rfkill-gpio-dt-v2-2-d1b83758c16d@pengutronix.de
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Stable-dep-of: b6f56a44e4c1 ("net: rfkill: gpio: Fix crash due to dereferencering uninitialized pointer")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rfkill/rfkill-gpio.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
index 2df5bf240b64a..ecfb766c47d08 100644
--- a/net/rfkill/rfkill-gpio.c
+++ b/net/rfkill/rfkill-gpio.c
@@ -79,6 +79,8 @@ static int rfkill_gpio_probe(struct platform_device *pdev)
 {
 	struct rfkill_gpio_data *rfkill;
 	struct gpio_desc *gpio;
+	const char *name_property;
+	const char *type_property;
 	const char *type_name;
 	int ret;
 
@@ -86,8 +88,15 @@ static int rfkill_gpio_probe(struct platform_device *pdev)
 	if (!rfkill)
 		return -ENOMEM;
 
-	device_property_read_string(&pdev->dev, "name", &rfkill->name);
-	device_property_read_string(&pdev->dev, "type", &type_name);
+	if (dev_of_node(&pdev->dev)) {
+		name_property = "label";
+		type_property = "radio-type";
+	} else {
+		name_property = "name";
+		type_property = "type";
+	}
+	device_property_read_string(&pdev->dev, name_property, &rfkill->name);
+	device_property_read_string(&pdev->dev, type_property, &type_name);
 
 	if (!rfkill->name)
 		rfkill->name = dev_name(&pdev->dev);
@@ -169,12 +178,19 @@ static const struct acpi_device_id rfkill_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, rfkill_acpi_match);
 #endif
 
+static const struct of_device_id rfkill_of_match[] __maybe_unused = {
+	{ .compatible = "rfkill-gpio", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, rfkill_of_match);
+
 static struct platform_driver rfkill_gpio_driver = {
 	.probe = rfkill_gpio_probe,
 	.remove = rfkill_gpio_remove,
 	.driver = {
 		.name = "rfkill_gpio",
 		.acpi_match_table = ACPI_PTR(rfkill_acpi_match),
+		.of_match_table = of_match_ptr(rfkill_of_match),
 	},
 };
 
-- 
2.51.0



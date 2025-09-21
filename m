Return-Path: <stable+bounces-180853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCB2B8E99E
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 01:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 976CF3B4BB1
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 23:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78C825394A;
	Sun, 21 Sep 2025 23:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mO3nB53E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E4E2472AA
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 23:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758497832; cv=none; b=sR+YMKbVEDL5oCLZbWr7mXXPN5U+lPiXIfGj5LdQ+h3eQNnhjRkBnjuW6G8MIvbb3Fub9qRFx+B4IivkLaqtLvPnqJVI0XCMFnZifGyor6UsuqMyKxPwKn/IlZUr1sZukWNKaMq6D99Dt+lcN7cROsgVt77BoOZFPtTcgEiBzXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758497832; c=relaxed/simple;
	bh=XouJ6O1G6ZSvMQwFa7wkigVRDoR32BtWV0QXd0gOb6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oMbQCN5cIeeI/ZiR6icIiJQJRD5GOx/bhnqASZTdQXkT1GE9fGKPB0gaYZAsafkN+1JCr9/lknB4hmX91nrB7kWfEGb75AvGCNTVtjK1HN4kFTf5QFgZ9IbvAUFs0hbochxvUSjUCsU4Nro5UeRS43qKyo92KeaT6F280p50Gnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mO3nB53E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823C4C4CEE7;
	Sun, 21 Sep 2025 23:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758497832;
	bh=XouJ6O1G6ZSvMQwFa7wkigVRDoR32BtWV0QXd0gOb6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mO3nB53ElcOV7Cqg8584ZWyny2Pp2cnBSu0v3OlwH55JeYEBRWfMfZCR6DvcwHhCf
	 4BbPXjemsaAdu3qYtqm7xPSBdUhVofz8l579aZhILSVdB44dFT4ivEp54aKPNI/m6O
	 NF83DnJzyZhMVQu7oKpMSKECyBQZ2E2FCNldqUFaX77K7LhowXulI2qYftSoHEjoYc
	 mlax7Q8kIXQ8Sng78twI3JXXmIn05OOsoI5TfH7J/GPr564Obu7sDGe8gS4aeXuQbE
	 /aFo3Ltr85XOv/Hci+c+anjga9JXbqAFlrXw85tmK+8IikbXYIzp3FgI0RKXBQvFQ+
	 gjS+d3V4IbBfQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] net: rfkill: gpio: add DT support
Date: Sun, 21 Sep 2025 19:37:08 -0400
Message-ID: <20250921233709.3086047-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025092155-familiar-divisible-9535@gregkh>
References: <2025092155-familiar-divisible-9535@gregkh>
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



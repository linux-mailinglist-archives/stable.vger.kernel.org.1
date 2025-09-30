Return-Path: <stable+bounces-182520-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A14DBADAB1
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 17:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 556854A58CB
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 15:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8A52FFDE6;
	Tue, 30 Sep 2025 15:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L7j0K9IS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7992C2F39C0;
	Tue, 30 Sep 2025 15:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759245213; cv=none; b=XEOI0V+oN+mfj2mW9mo/OURz00oH5/Zx3GFTts+CC1O8tYTbkSOZ0ODiHmF0ecSMEi94zgRdX7BIz6fZ4XcjzXJgOsG8kwpPnZ5G+17kv7atKFeuNvk3JEVB4jNA30tbti8sK6RP6gKq8+H2H1FjK8r65i09gZJNzuEmCb9kvL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759245213; c=relaxed/simple;
	bh=a7j42ENqMam+iWTn10cZCSZ8+PGnZCCuNB9k/WoWCG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KGl1uMpg8MZhBVTWGsz+2EDXBfTJQD3Q/lTHXhXAF43Y0+B3F0FNnPw+bQXCTUz14qd9NK9sIBaC7e1FjOVEp00P2er8YM8/dIw+yl5P6qZNc4uSL4tfKbRVnnzYtyxjx1182yvEL4Wz1qcPPYjsxEKqcTEilMC5cBdQT0MsXJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L7j0K9IS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7BFC4CEF0;
	Tue, 30 Sep 2025 15:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759245213;
	bh=a7j42ENqMam+iWTn10cZCSZ8+PGnZCCuNB9k/WoWCG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L7j0K9IS6WesQlHF3ee0FNLAL3fkAVPsXE4x846D9HhU/EQWSuIgJqklriImNo7wF
	 nWlOD7/Z8ojviAYdPzG7v+4iA8v46GuX68AQ7azyYyoxevkmOuvlqBY26s4cAMvEEj
	 mvQqBeM7GBtBHd22mVjaOp9u4BIvbgcV5p4JCCBA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 101/151] net: rfkill: gpio: add DT support
Date: Tue, 30 Sep 2025 16:47:11 +0200
Message-ID: <20250930143831.623700142@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930143827.587035735@linuxfoundation.org>
References: <20250930143827.587035735@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rfkill/rfkill-gpio.c |   20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

--- a/net/rfkill/rfkill-gpio.c
+++ b/net/rfkill/rfkill-gpio.c
@@ -79,6 +79,8 @@ static int rfkill_gpio_probe(struct plat
 {
 	struct rfkill_gpio_data *rfkill;
 	struct gpio_desc *gpio;
+	const char *name_property;
+	const char *type_property;
 	const char *type_name;
 	int ret;
 
@@ -86,8 +88,15 @@ static int rfkill_gpio_probe(struct plat
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
@@ -169,12 +178,19 @@ static const struct acpi_device_id rfkil
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
 




Return-Path: <stable+bounces-46213-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EA58CF36E
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 11:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB97C1F210BA
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 09:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDA543145;
	Sun, 26 May 2024 09:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBTJEzBq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2A84AEF8;
	Sun, 26 May 2024 09:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716716560; cv=none; b=BO5Ukmxje4B+pbUjRhjqJIGyI0CyvTO8gSkm0xO8k++TKN75VwhP32SpArQf6rDe10kOasl2dS5rQA7DZ5rImALLJ0p1FLqrYsx4wgHA1jaura2qguoTBK2JUqPKnA4S0RmcxxviK3qOX1SSJM1PXtkRGvtkBsx9GLZt/iQIUug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716716560; c=relaxed/simple;
	bh=af/ol9iL4gMIhU2wLPXuPquFvHSnfZuzbvNlF9lJ1ZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TxvBbU3y8vbtDATY/8X6F41lISCmSOdw/PEoM/+h4WFHWyprMl+XL3QOtOrzkH+ONMwJCL+DgeGF1+FcAKYo3+Dr6qHv0xprnuYouHxnT0kg2YWi4whe/olGIbBb791KTjLbERL2riI00nMGGhfnWB564YkhFNzp/F4coWSbuY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBTJEzBq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9130CC2BD10;
	Sun, 26 May 2024 09:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716716560;
	bh=af/ol9iL4gMIhU2wLPXuPquFvHSnfZuzbvNlF9lJ1ZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rBTJEzBq8XA6o9DSo5dDRngOOxOJ8dbEwR/B88tY07Wq99AOaeQkF1cEc+isBHXlO
	 NRH3sBc0MUnybI5uEn4MPR5wqr9cslUxZ6Zca2DMK3PNAOZKv9AXlCUpFXgnWLifWC
	 D36FUROPRRwowJQdWRhit8VM3kHSHjdMyOAg8tAgf5xY+ngyGvcUc37dKd6phvGDqv
	 RIpQTXsUJiPDo2Zk6lrwcheLHoQfG1/qZc573Z8VLMDCUnmjcT9Tt9yb/UJ/QPf4f6
	 6pGCFtRyMNv4l0i76NGQlMI5oan4e9B5RLwfolQxnJIIj/ki4KZFBARaCVD1Q+IH8j
	 /r0/BCISfvfEg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	chrome-platform@lists.linux.dev
Subject: [PATCH AUTOSEL 6.8 10/14] platform/chrome: cros_usbpd_logger: provide ID table for avoiding fallback match
Date: Sun, 26 May 2024 05:42:15 -0400
Message-ID: <20240526094224.3412675-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240526094224.3412675-1-sashal@kernel.org>
References: <20240526094224.3412675-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.10
Content-Transfer-Encoding: 8bit

From: Tzung-Bi Shih <tzungbi@kernel.org>

[ Upstream commit e0e59c5335a0a038058a080474c34fe04debff33 ]

Instead of using fallback driver name match, provide ID table[1] for the
primary match.

[1]: https://elixir.bootlin.com/linux/v6.8/source/drivers/base/platform.c#L1353

Reviewed-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Link: https://lore.kernel.org/r/20240329075630.2069474-7-tzungbi@kernel.org
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/chrome/cros_usbpd_logger.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_usbpd_logger.c b/drivers/platform/chrome/cros_usbpd_logger.c
index f618757f8b321..930c2f47269f6 100644
--- a/drivers/platform/chrome/cros_usbpd_logger.c
+++ b/drivers/platform/chrome/cros_usbpd_logger.c
@@ -7,6 +7,7 @@
 
 #include <linux/ktime.h>
 #include <linux/math64.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
@@ -249,6 +250,12 @@ static int __maybe_unused cros_usbpd_logger_suspend(struct device *dev)
 static SIMPLE_DEV_PM_OPS(cros_usbpd_logger_pm_ops, cros_usbpd_logger_suspend,
 			 cros_usbpd_logger_resume);
 
+static const struct platform_device_id cros_usbpd_logger_id[] = {
+	{ DRV_NAME, 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, cros_usbpd_logger_id);
+
 static struct platform_driver cros_usbpd_logger_driver = {
 	.driver = {
 		.name = DRV_NAME,
@@ -256,10 +263,10 @@ static struct platform_driver cros_usbpd_logger_driver = {
 	},
 	.probe = cros_usbpd_logger_probe,
 	.remove_new = cros_usbpd_logger_remove,
+	.id_table = cros_usbpd_logger_id,
 };
 
 module_platform_driver(cros_usbpd_logger_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Logging driver for ChromeOS EC USBPD Charger.");
-MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.43.0



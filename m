Return-Path: <stable+bounces-46198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E38C88CF347
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 11:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A041D281E56
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 09:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FE421101;
	Sun, 26 May 2024 09:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPVcVC8L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF75F20B02;
	Sun, 26 May 2024 09:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716716529; cv=none; b=oCphnj8DMqtg4gyY9MKUo1WKmk6El2uQjibXztoBFhpWUYh7PNwn4BI5hbqW3nCVh7/+7pI3jCoakvVXgwGhSk/ZcYDM4/gKQ7QujYv5HGFsMypM3bLLvvrr82ExCLxRoOADz5XCi5MgYCPBxQcBoTALU9vF3ltOfgwtjRZT10Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716716529; c=relaxed/simple;
	bh=af/ol9iL4gMIhU2wLPXuPquFvHSnfZuzbvNlF9lJ1ZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VO8YEUlKxEpOwj9FS4e5+c7rjaWX0eGCY0zR8khfeSE75thlqwBOvXa5EH6AtOXOUf9ntPkgJjZZi9Fp6QD/SVQuV1Q/U8EGIsPTqdpF6hDJ/sgQ6mEvONCltcnc78SnBpzvnZFyj1nT82GRPOh7KL292tYg89XA1WYNXy+uQAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPVcVC8L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1298C32781;
	Sun, 26 May 2024 09:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716716528;
	bh=af/ol9iL4gMIhU2wLPXuPquFvHSnfZuzbvNlF9lJ1ZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OPVcVC8LtOzuK/gIEVhCldNm9mIpQRz9hSRoIpPohYGaV7q12Bo6DBxRE2V6JaFR9
	 g4fpP+4R64JSYKfen3ls4ezI4JPDm+JH7D9fl/q2pkwUeu5G6zUUOED99y8Ly4p2De
	 e9dxz8ry/oFs3q2fY2/imA/QmM3VLEV+SZ18Kh52M8p4Vb2C4twLmFGze5sDQWnEGe
	 HEVluyheznLvn9b5la+KuSer9AyZRDBbiqUVBuf67KtoBBqQtqUrbQjYsfu+m2I7h0
	 pUnVZwJes45nTG3YS6eV3J/NTmf8NF0d/cbU6QMoCU76mW01xAfSn9yBNAKmgOomQi
	 O6URJdd+fpXfg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	chrome-platform@lists.linux.dev
Subject: [PATCH AUTOSEL 6.9 10/15] platform/chrome: cros_usbpd_logger: provide ID table for avoiding fallback match
Date: Sun, 26 May 2024 05:41:42 -0400
Message-ID: <20240526094152.3412316-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240526094152.3412316-1-sashal@kernel.org>
References: <20240526094152.3412316-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.1
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



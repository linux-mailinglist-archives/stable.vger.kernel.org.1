Return-Path: <stable+bounces-5399-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CDE80CBC3
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA7D81F2162B
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C6847799;
	Mon, 11 Dec 2023 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uIFoBYX4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E624776B;
	Mon, 11 Dec 2023 13:53:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD7FC43397;
	Mon, 11 Dec 2023 13:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702302838;
	bh=LNKZe5oxRmmzhRFo7D0uuBgWzkAugDhWnM6qObpwv1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uIFoBYX457j/0DUIE57Az4fRFDFNjArDjKV/wveUcujSXQIP+WdR6+rOoQw6J65Qo
	 vRPIfdV6qyS0JXb6Jx+Af4bu24Uqadc/2AdEB96MhT+cfQvxQaO+IAKR+cCpEL3Hkz
	 x8cjZb0X5nk95aYKC0R4rHGhIx8DpdrtABRbhMwamAbd48y2XEnYJo/Cz6kYIms06Z
	 jJK6UZGxh9oNj82rb+XNwIGSmUHtbNVWhuV8zNZT5QQJ+yHA8okZQC7ha9S8oS3y8r
	 k/EmZuaO+wOtyOGHPG8EI0LCLrz4FYMGY4uqrnryMjTziIVi4AM9FW63I/RPQDR17W
	 PH2yvegunyD8Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	wilken.gottwalt@posteo.net,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 44/47] hwmon: (corsair-psu) Fix probe when built-in
Date: Mon, 11 Dec 2023 08:50:45 -0500
Message-ID: <20231211135147.380223-44-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135147.380223-1-sashal@kernel.org>
References: <20231211135147.380223-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.5
Content-Transfer-Encoding: 8bit

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit 307004e8b254ad28e150b63f299ab9caa4bc7c3e ]

It seems that when the driver is built-in, the HID bus is
initialized after the driver is loaded, which whould cause
module_hid_driver() to fail.
Fix this by registering the driver after the HID bus using
late_initcall() in accordance with other hwmon HID drivers.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Link: https://lore.kernel.org/r/20231207210723.222552-1-W_Armin@gmx.de
[groeck: Dropped "compile tested" comment; the patch has been tested
 but the tester did not provide a Tested-by: tag]
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/corsair-psu.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
index 904890598c116..2c7c92272fe39 100644
--- a/drivers/hwmon/corsair-psu.c
+++ b/drivers/hwmon/corsair-psu.c
@@ -899,7 +899,23 @@ static struct hid_driver corsairpsu_driver = {
 	.reset_resume	= corsairpsu_resume,
 #endif
 };
-module_hid_driver(corsairpsu_driver);
+
+static int __init corsair_init(void)
+{
+	return hid_register_driver(&corsairpsu_driver);
+}
+
+static void __exit corsair_exit(void)
+{
+	hid_unregister_driver(&corsairpsu_driver);
+}
+
+/*
+ * With module_init() the driver would load before the HID bus when
+ * built-in, so use late_initcall() instead.
+ */
+late_initcall(corsair_init);
+module_exit(corsair_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Wilken Gottwalt <wilken.gottwalt@posteo.net>");
-- 
2.42.0



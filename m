Return-Path: <stable+bounces-5451-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 979F780CC66
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 15:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53309280D1B
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6346482C6;
	Mon, 11 Dec 2023 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NL+KGM28"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C28E1F60B;
	Mon, 11 Dec 2023 14:00:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AEEAC433C9;
	Mon, 11 Dec 2023 14:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702303234;
	bh=V0LlhXdpNiG0pJ5YJinIlfbudaIGy8VzuK3rddu039Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NL+KGM28eUDxSiO4IGCnl2sO5JA/cY4jq3qSgEIFHJwV4towevdpa/NUJWqKpdCDW
	 Itwg3bMH12YvM3I2sdMDwc3aKCYx+4XVNk7HiyizH9EGr0g2pJeLUyJsjqRQ7nAs+r
	 35DkOg8PwuCjE9/w7moX3bHPQQdHE4ZukDw5syS2lodfw67JY8zRn6K74QiPz2R9hQ
	 /CDUQqMKV2Pc0BjrG4aq6WLRsbOihN6pUOema4LWVJSj4RAr9ZSWwmMMVmSX5arlkz
	 4zX8AO9mM1+HOFBpOyHWJeRDso9l/xRUQrteZjzHqhfViY/hHbysgUR/AtgFC9xsnX
	 6qrk9Mq0b16hg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	wilken.gottwalt@posteo.net,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 19/19] hwmon: (corsair-psu) Fix probe when built-in
Date: Mon, 11 Dec 2023 08:57:53 -0500
Message-ID: <20231211135908.385694-19-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135908.385694-1-sashal@kernel.org>
References: <20231211135908.385694-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.142
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
index 14389fd7afb89..ae983e715110e 100644
--- a/drivers/hwmon/corsair-psu.c
+++ b/drivers/hwmon/corsair-psu.c
@@ -808,7 +808,23 @@ static struct hid_driver corsairpsu_driver = {
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



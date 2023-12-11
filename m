Return-Path: <stable+bounces-5530-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 142F480D53F
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5D602819F9
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE6C4F212;
	Mon, 11 Dec 2023 18:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BUFgdLqR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0404F213;
	Mon, 11 Dec 2023 18:21:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4073BC433C8;
	Mon, 11 Dec 2023 18:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702318910;
	bh=su7h+v6tuDEX0Yji2SiyaeLYFxAIYPUTxorqXFpYUw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BUFgdLqR7LQQc3Av00LaybNlCNFLmJxfjaCNRrJ2dQR+m/4gL5m8Z+Oznb0/QICSD
	 QMl6n9S+xCsqs82VnePYiPFS3+cvyXI1qqUvsyU9LEAFybwynei1JmMteeArEJrCGQ
	 nVpgGEiyGm8pHlJ1+vb2CD9aOohNJwFBpoqAXgyU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	urbinek@gmail.com,
	Armin Wolf <W_Armin@gmx.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 07/25] hwmon: (acpi_power_meter) Fix 4.29 MW bug
Date: Mon, 11 Dec 2023 19:20:58 +0100
Message-ID: <20231211182008.966908134@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182008.665944227@linuxfoundation.org>
References: <20231211182008.665944227@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit 1fefca6c57fb928d2131ff365270cbf863d89c88 ]

The ACPI specification says:

"If an error occurs while obtaining the meter reading or if the value
is not available then an Integer with all bits set is returned"

Since the "integer" is 32 bits in case of the ACPI power meter,
userspace will get a power reading of 2^32 * 1000 miliwatts (~4.29 MW)
in case of such an error. This was discovered due to a lm_sensors
bugreport (https://github.com/lm-sensors/lm-sensors/issues/460).
Fix this by returning -ENODATA instead.

Tested-by: <urbinek@gmail.com>
Fixes: de584afa5e18 ("hwmon driver for ACPI 4.0 power meters")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Link: https://lore.kernel.org/r/20231124182747.13956-1-W_Armin@gmx.de
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/acpi_power_meter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index e40d8907853bf..1d1f68a895080 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -45,6 +45,7 @@ ACPI_MODULE_NAME(ACPI_POWER_METER_NAME);
 #define POWER_METER_CAN_NOTIFY	(1 << 3)
 #define POWER_METER_IS_BATTERY	(1 << 8)
 #define UNKNOWN_HYSTERESIS	0xFFFFFFFF
+#define UNKNOWN_POWER		0xFFFFFFFF
 
 #define METER_NOTIFY_CONFIG	0x80
 #define METER_NOTIFY_TRIP	0x81
@@ -356,6 +357,9 @@ static ssize_t show_power(struct device *dev,
 	update_meter(resource);
 	mutex_unlock(&resource->lock);
 
+	if (resource->power == UNKNOWN_POWER)
+		return -ENODATA;
+
 	return sprintf(buf, "%llu\n", resource->power * 1000);
 }
 
-- 
2.42.0





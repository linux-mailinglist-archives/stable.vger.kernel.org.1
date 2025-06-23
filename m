Return-Path: <stable+bounces-157254-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E08AE5325
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E63E4448CE
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BFC225417;
	Mon, 23 Jun 2025 21:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QzwfQcuF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23E4221DA8;
	Mon, 23 Jun 2025 21:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750715418; cv=none; b=Kmy2s/pN0AMG+WG4lYjwt9snbMPKe2PiglBZ8msl+d4j4s9cmEwgdK15VZbHWI0jeR0UQEVLVzKi5cXQ7qSrEHwevIAkr8xoie7a7XhM5yuObQhYWnG3ztap7LGAKz0VEDO0ba58TIDdb9ufOD3qz5Pm6DLfcn+BPVLZVieG4zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750715418; c=relaxed/simple;
	bh=QMbEfUajuUWUdOUl3jRE0Jjlu6P0UwO6zolXIWS1yC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kc8EQApF5cDxiIxYfmJ/d5bBs3jYfLd7/6PpYCPvhIHLhet2mCkClpeiT47DkS+PILz47vJpyYt1sfcwYbRmwGt8A36jWhi+kM+FWzW77R6kzrHFvdwGiFS+W2jRLzAjpmNTERj+UBxSerJHUMXtsLGsyV0QWkVH6UKhCJAzJ9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QzwfQcuF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B554C4CEED;
	Mon, 23 Jun 2025 21:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750715418;
	bh=QMbEfUajuUWUdOUl3jRE0Jjlu6P0UwO6zolXIWS1yC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QzwfQcuFrO9O/DMQvfs4m0CgHhuTdJDcLj29JlcmmgCIaC8oa/GBO3Mhgdhvae6cQ
	 LCtbcdtUPGtcYhvoKLz/RlSrXJM6kTKaXLHJw0PD3hIWNnZs9lmeYPWSqy/KnmrtAp
	 MFFwnD5VtHNfEsLnAofX6RL8X9rhYMzfu04dj5fI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Jerry Lv <Jerry.Lv@axis.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 181/414] power: supply: bq27xxx: Retrieve again when busy
Date: Mon, 23 Jun 2025 15:05:18 +0200
Message-ID: <20250623130646.550819710@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130642.015559452@linuxfoundation.org>
References: <20250623130642.015559452@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jerry Lv <Jerry.Lv@axis.com>

[ Upstream commit f16d9fb6cf03fdbdefa41a8b32ba1e57afb7ae3d ]

Multiple applications may access the battery gauge at the same time, so
the gauge may be busy and EBUSY will be returned. The driver will set a
flag to record the EBUSY state, and this flag will be kept until the next
periodic update. When this flag is set, bq27xxx_battery_get_property()
will just return ENODEV until the flag is updated.

Even if the gauge was busy during the last accessing attempt, returning
ENODEV is not ideal, and can cause confusion in the applications layer.

Instead, retry accessing the I2C to update the flag is as expected, for
the gauge typically recovers from busy state within a few milliseconds.
If still failed to access the gauge, the real error code would be returned
instead of ENODEV (as suggested by Pali Rohár).

Reviewed-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Jerry Lv <Jerry.Lv@axis.com>
Link: https://lore.kernel.org/r/20250415-foo-fix-v2-1-5b45a395e4cc@axis.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/bq27xxx_battery.c     |  2 +-
 drivers/power/supply/bq27xxx_battery_i2c.c | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 1a20c775489c7..871f03d160c53 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -2062,7 +2062,7 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 	mutex_unlock(&di->lock);
 
 	if (psp != POWER_SUPPLY_PROP_PRESENT && di->cache.flags < 0)
-		return -ENODEV;
+		return di->cache.flags;
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index ba0d22d904295..868e95f0887e1 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -6,6 +6,7 @@
  *	Andrew F. Davis <afd@ti.com>
  */
 
+#include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
@@ -31,6 +32,7 @@ static int bq27xxx_battery_i2c_read(struct bq27xxx_device_info *di, u8 reg,
 	struct i2c_msg msg[2];
 	u8 data[2];
 	int ret;
+	int retry = 0;
 
 	if (!client->adapter)
 		return -ENODEV;
@@ -47,7 +49,16 @@ static int bq27xxx_battery_i2c_read(struct bq27xxx_device_info *di, u8 reg,
 	else
 		msg[1].len = 2;
 
-	ret = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
+	do {
+		ret = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
+		if (ret == -EBUSY && ++retry < 3) {
+			/* sleep 10 milliseconds when busy */
+			usleep_range(10000, 11000);
+			continue;
+		}
+		break;
+	} while (1);
+
 	if (ret < 0)
 		return ret;
 
-- 
2.39.5





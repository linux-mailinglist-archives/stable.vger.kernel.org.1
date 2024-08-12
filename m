Return-Path: <stable+bounces-66990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 794BF94F368
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E6701F216B6
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A014D18454D;
	Mon, 12 Aug 2024 16:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0Z31KbGX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE402C1A5;
	Mon, 12 Aug 2024 16:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723479438; cv=none; b=UeVBNUZxs36sFP/yHVKhB0mIXGeC9HJLOqTNmNGpQdsnlqBTwcf60qO1kChFO7EIdcn5aH3KSIXZfXQE0v95aYB1GiAdnY1Jp4YCqJT+9eYg67QffTU959XVZlJ3B+sefax8QDqCRRObHyu5WqG9DNU163yuudgmqgNF/hPIVwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723479438; c=relaxed/simple;
	bh=b0WZLUhvIyRVJwCH7V+vJwnBPRj/TCiZuMUSSbcpQ+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IMK9tL7mML//vt0lyKmXn4goyPli0qcu3aFcYCFUlh6kR5n8xEsFrYAuiUKq3nFg8yhiVFxatZKjANTcnTmrAEvBncicBmLnGfMhCKzMeKAShrlFZpMlzfZ+lWLrxp8Byke8aT/MvSyk2ugQ/lwagBuTg5zGGtW7xx3YceanHcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0Z31KbGX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF45C32782;
	Mon, 12 Aug 2024 16:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723479438;
	bh=b0WZLUhvIyRVJwCH7V+vJwnBPRj/TCiZuMUSSbcpQ+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0Z31KbGXTs7JBRrgRFijKk0THSeVEBJ9CgJd4BKShhCxnLlNH/fkxzGgFoPqUbzhM
	 VljwoiITAhQXiPIBQxY85DlQSDRriVeOrGRkgZdeFHLMRhegSOP45Vcsp0cNfzFPyA
	 dHxaf0T4EK29Hf+DDtG9LiXwjA+1NM27f+Vxj+cU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guenter Roeck <linux@roeck-us.net>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 087/189] i2c: smbus: Improve handling of stuck alerts
Date: Mon, 12 Aug 2024 18:02:23 +0200
Message-ID: <20240812160135.491903805@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812160132.135168257@linuxfoundation.org>
References: <20240812160132.135168257@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 37c526f00bc1c4f847fc800085f8f009d2e11be6 ]

The following messages were observed while testing alert functionality
on systems with multiple I2C devices on a single bus if alert was active
on more than one chip.

smbus_alert 3-000c: SMBALERT# from dev 0x0c, flag 0
smbus_alert 3-000c: no driver alert()!

and:

smbus_alert 3-000c: SMBALERT# from dev 0x28, flag 0

Once it starts, this message repeats forever at high rate. There is no
device at any of the reported addresses.

Analysis shows that this is seen if multiple devices have the alert pin
active. Apparently some devices do not support SMBus arbitration correctly.
They keep sending address bits after detecting an address collision and
handle the collision not at all or too late.
Specifically, address 0x0c is seen with ADT7461A at address 0x4c and
ADM1021 at address 0x18 if alert is active on both chips. Address 0x28 is
seen with ADT7483 at address 0x2a and ADT7461 at address 0x4c if alert is
active on both chips.

Once the system is in bad state (alert is set by more than one chip),
it often only recovers by power cycling.

To reduce the impact of this problem, abort the endless loop in
smbus_alert() if the same address is read more than once and not
handled by a driver.

Fixes: b5527a7766f0 ("i2c: Add SMBus alert support")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
[wsa: it also fixed an interrupt storm in one of my experiments]
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
[wsa: rebased, moved a comment as well, improved the 'invalid' value]
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-smbus.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
index 138c3f5e0093a..6097fa6b5b4b3 100644
--- a/drivers/i2c/i2c-smbus.c
+++ b/drivers/i2c/i2c-smbus.c
@@ -34,6 +34,7 @@ static int smbus_do_alert(struct device *dev, void *addrp)
 	struct i2c_client *client = i2c_verify_client(dev);
 	struct alert_data *data = addrp;
 	struct i2c_driver *driver;
+	int ret;
 
 	if (!client || client->addr != data->addr)
 		return 0;
@@ -47,16 +48,21 @@ static int smbus_do_alert(struct device *dev, void *addrp)
 	device_lock(dev);
 	if (client->dev.driver) {
 		driver = to_i2c_driver(client->dev.driver);
-		if (driver->alert)
+		if (driver->alert) {
+			/* Stop iterating after we find the device */
 			driver->alert(client, data->type, data->data);
-		else
+			ret = -EBUSY;
+		} else {
 			dev_warn(&client->dev, "no driver alert()!\n");
-	} else
+			ret = -EOPNOTSUPP;
+		}
+	} else {
 		dev_dbg(&client->dev, "alert with no driver\n");
+		ret = -ENODEV;
+	}
 	device_unlock(dev);
 
-	/* Stop iterating after we find the device */
-	return -EBUSY;
+	return ret;
 }
 
 /*
@@ -67,6 +73,7 @@ static irqreturn_t smbus_alert(int irq, void *d)
 {
 	struct i2c_smbus_alert *alert = d;
 	struct i2c_client *ara;
+	unsigned short prev_addr = I2C_CLIENT_END; /* Not a valid address */
 
 	ara = alert->ara;
 
@@ -94,8 +101,19 @@ static irqreturn_t smbus_alert(int irq, void *d)
 			data.addr, data.data);
 
 		/* Notify driver for the device which issued the alert */
-		device_for_each_child(&ara->adapter->dev, &data,
-				      smbus_do_alert);
+		status = device_for_each_child(&ara->adapter->dev, &data,
+					       smbus_do_alert);
+		/*
+		 * If we read the same address more than once, and the alert
+		 * was not handled by a driver, it won't do any good to repeat
+		 * the loop because it will never terminate.
+		 * Bail out in this case.
+		 * Note: This assumes that a driver with alert handler handles
+		 * the alert properly and clears it if necessary.
+		 */
+		if (data.addr == prev_addr && status != -EBUSY)
+			break;
+		prev_addr = data.addr;
 	}
 
 	return IRQ_HANDLED;
-- 
2.43.0





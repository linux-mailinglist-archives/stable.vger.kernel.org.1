Return-Path: <stable+bounces-67283-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 236D194F4B7
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C14701F21469
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2545F18756A;
	Mon, 12 Aug 2024 16:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="azfuR9uN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A95183CD4;
	Mon, 12 Aug 2024 16:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723480420; cv=none; b=YBMKRs5C5rp1oMI2J6J/EPXCXsP/QwebqlqdEDb71naQ0UHkGYNo+v0ez6oqNmVRTVL/j5H+tRDYdzKwVu+DPBh1IFQjVMpWIoq0WHvRKZYd/B3h07+O+gBZ+5raPTs0f9AG6TKfKCGtPRd9HxVHEiNA2k6iyIn04hKlTjznNVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723480420; c=relaxed/simple;
	bh=MC+RuV24PDiKljHC3mVMfgwZgiTsAIk961Z5/NZEDFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZgDGVdoBNAt6ptddGOCC9h+VQPOO+9krNqjQiKyKLhRaK0qB8Qg5upCNny9746/e2Ivz7DXfPrR5qyI1A4Bc3qJTuDtmrmVrfe0ua/5d/fyXiqHqKsbKWq4/AZN4GdHLvGENEuUArnQXK8z0YZ/KgbaB36qTrMm31mmvcEAF//o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=azfuR9uN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCEA9C32782;
	Mon, 12 Aug 2024 16:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723480420;
	bh=MC+RuV24PDiKljHC3mVMfgwZgiTsAIk961Z5/NZEDFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=azfuR9uNHq15k//TfCk75AWzEXj+4UKZS9W83sXqCxtp2U7/Q6jzkblL4riQxYyb8
	 2IQsoV+4cOKQaxucEqTjnxnSNvxgz/YVeduDXrkzZrPmlOLGwtLA0Q8byZsHghkq4D
	 9cvZlA4EN9WzNYGG/PY1aDVR6YRkrdZ6+18n47Qc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guenter Roeck <linux@roeck-us.net>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 149/263] i2c: smbus: Send alert notifications to all devices if source not found
Date: Mon, 12 Aug 2024 18:02:30 +0200
Message-ID: <20240812160152.252335768@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812160146.517184156@linuxfoundation.org>
References: <20240812160146.517184156@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit f6c29f710c1ff2590109f83be3e212b86c01e0f3 ]

If a SMBus alert is received and the originating device is not found,
the reason may be that the address reported on the SMBus alert address
is corrupted, for example because multiple devices asserted alert and
do not correctly implement SMBus arbitration.

If this happens, call alert handlers on all devices connected to the
given I2C bus, in the hope that this cleans up the situation.

This change reliably fixed the problem on a system with multiple devices
on a single bus. Example log where the device on address 0x18 (ADM1021)
and on address 0x4c (ADT7461A) both had the alert line asserted:

smbus_alert 3-000c: SMBALERT# from dev 0x0c, flag 0
smbus_alert 3-000c: no driver alert()!
smbus_alert 3-000c: SMBALERT# from dev 0x0c, flag 0
smbus_alert 3-000c: no driver alert()!
lm90 3-0018: temp1 out of range, please check!
lm90 3-0018: Disabling ALERT#
lm90 3-0029: Everything OK
lm90 3-002a: Everything OK
lm90 3-004c: temp1 out of range, please check!
lm90 3-004c: temp2 out of range, please check!
lm90 3-004c: Disabling ALERT#

Fixes: b5527a7766f0 ("i2c: Add SMBus alert support")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
[wsa: fixed a typo in the commit message]
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-smbus.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
index 1b4057e1bab09..25bc7b8d98f0d 100644
--- a/drivers/i2c/i2c-smbus.c
+++ b/drivers/i2c/i2c-smbus.c
@@ -65,6 +65,32 @@ static int smbus_do_alert(struct device *dev, void *addrp)
 	return ret;
 }
 
+/* Same as above, but call back all drivers with alert handler */
+
+static int smbus_do_alert_force(struct device *dev, void *addrp)
+{
+	struct i2c_client *client = i2c_verify_client(dev);
+	struct alert_data *data = addrp;
+	struct i2c_driver *driver;
+
+	if (!client || (client->flags & I2C_CLIENT_TEN))
+		return 0;
+
+	/*
+	 * Drivers should either disable alerts, or provide at least
+	 * a minimal handler. Lock so the driver won't change.
+	 */
+	device_lock(dev);
+	if (client->dev.driver) {
+		driver = to_i2c_driver(client->dev.driver);
+		if (driver->alert)
+			driver->alert(client, data->type, data->data);
+	}
+	device_unlock(dev);
+
+	return 0;
+}
+
 /*
  * The alert IRQ handler needs to hand work off to a task which can issue
  * SMBus calls, because those sleeping calls can't be made in IRQ context.
@@ -106,13 +132,19 @@ static irqreturn_t smbus_alert(int irq, void *d)
 		/*
 		 * If we read the same address more than once, and the alert
 		 * was not handled by a driver, it won't do any good to repeat
-		 * the loop because it will never terminate.
-		 * Bail out in this case.
+		 * the loop because it will never terminate. Try again, this
+		 * time calling the alert handlers of all devices connected to
+		 * the bus, and abort the loop afterwards. If this helps, we
+		 * are all set. If it doesn't, there is nothing else we can do,
+		 * so we might as well abort the loop.
 		 * Note: This assumes that a driver with alert handler handles
 		 * the alert properly and clears it if necessary.
 		 */
-		if (data.addr == prev_addr && status != -EBUSY)
+		if (data.addr == prev_addr && status != -EBUSY) {
+			device_for_each_child(&ara->adapter->dev, &data,
+					      smbus_do_alert_force);
 			break;
+		}
 		prev_addr = data.addr;
 	}
 
-- 
2.43.0





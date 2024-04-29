Return-Path: <stable+bounces-41746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D39DD8B5DAC
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 17:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C97A1C21CDB
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 15:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DC2127E3F;
	Mon, 29 Apr 2024 15:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CKxtKCbT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="45FlEKfV"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3022127E1E
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 15:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714404349; cv=none; b=C12lwySJpaBxygRnSBOIFJPPRVIKX2MkxlcpP6wGVccDAC6qWEyxLqr3Qd7f5j7NU4+bPGeAv74avRlGaBD16jVKqWGWAUMUSfxWNB1nFZT6azxocTsK/PujCHN1Hk5jDZS9X4JNB9AXK2rUl92HpwrH3Q4Im0lWmLNmwq8jP6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714404349; c=relaxed/simple;
	bh=cPbEV8uadshxfnPNvXNipABDQJ0Tu9njMXiOnVOVd4k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PuuQIJZBG/H1dTH+B3m0oPXZtf9f1OU/YjQt68c7Kt9pzNnyBcOF2lJN6xSRz3OilSbifvWQFKd5OapKs4DdLjb17n3ZJNwI2sZciEMgmdIIrWQw2ZryW5qTvjVDD4dYaJHqefAViATn5KdcOSnFjaiQTvO4wNXG5d1mKcL2JuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CKxtKCbT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=45FlEKfV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714404345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ruEBNWojs5DSZqzc2DFaDePAehmBFXj5N4Ab1fABYM=;
	b=CKxtKCbTBDbvrc3pv5CmEa9zg6HNFwQKpKczBA53LjVZnQiB0FGxnwme3Upz70lYLcwfTT
	YkHeCzfUIq9Z8NxsOmvg3Q3auCvMfOqSCCOTTOYzaBPYP1oFl8vi0vcyB8XLo/hoKbQvuz
	MMgHYY+JvT74RK2AmCtNNuxgH1PgOfz6xRotb+Xd9ji2bEDAp4HlgySiraoQWHvQFy2+pj
	yCM5FfWvTDS+2LJ9h1byft4DtAi+f1LJhhuA9GMRCM8PbjgXODa/HwGalwTIrJsDuUPAwe
	oEl6ijJax3eY80DTnyS4W32MvkdhHyGj/N/84oZtNwdAzsne5YGAaCLqMAr+WA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714404345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ruEBNWojs5DSZqzc2DFaDePAehmBFXj5N4Ab1fABYM=;
	b=45FlEKfV3FW0A34lTOlnMTzbg0U+b7egwFGucejMlOTFiZKYW0ZkUeSVy01DgL+Rw+l/CS
	XcQLbiZeREIUTIDg==
To: stable@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Eva Kurchatova <nyandarknessgirl@gmail.com>,
	Jiri Kosina <jkosina@suse.com>
Subject: [PATCH 5.15.y, 5.10.y, 5.4.y, 4.19.y] HID: i2c-hid: remove I2C_HID_READ_PENDING flag to prevent lock-up
Date: Mon, 29 Apr 2024 17:25:15 +0200
Message-Id: <20240429152514.652751-1-namcao@linutronix.de>
In-Reply-To: <2024042952-germless-unguarded-1be2@gregkh>
References: <2024042952-germless-unguarded-1be2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 9c0f59e47a90c54d0153f8ddc0f80d7a36207d0e upstream.

The flag I2C_HID_READ_PENDING is used to serialize I2C operations.
However, this is not necessary, because I2C core already has its own
locking for that.

More importantly, this flag can cause a lock-up: if the flag is set in
i2c_hid_xfer() and an interrupt happens, the interrupt handler
(i2c_hid_irq) will check this flag and return immediately without doing
anything, then the interrupt handler will be invoked again in an
infinite loop.

Since interrupt handler is an RT task, it takes over the CPU and the
flag-clearing task never gets scheduled, thus we have a lock-up.

Delete this unnecessary flag.

Reported-and-tested-by: Eva Kurchatova <nyandarknessgirl@gmail.com>
Closes: https://lore.kernel.org/r/CA+eeCSPUDpUg76ZO8dszSbAGn+UHjcyv8F1J-CUPVARAzEtW9w@mail.gmail.com
Fixes: 4a200c3b9a40 ("HID: i2c-hid: introduce HID over i2c specification implementation")
Cc: <stable@vger.kernel.org>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
[apply to v4.19 -> v5.15]
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 7c61bb9291e4..f8c56810d260 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -51,7 +51,6 @@
 /* flags */
 #define I2C_HID_STARTED		0
 #define I2C_HID_RESET_PENDING	1
-#define I2C_HID_READ_PENDING	2
 
 #define I2C_HID_PWR_ON		0x00
 #define I2C_HID_PWR_SLEEP	0x01
@@ -251,7 +250,6 @@ static int __i2c_hid_command(struct i2c_client *client,
 		msg[1].len = data_len;
 		msg[1].buf = buf_recv;
 		msg_num = 2;
-		set_bit(I2C_HID_READ_PENDING, &ihid->flags);
 	}
 
 	if (wait)
@@ -259,9 +257,6 @@ static int __i2c_hid_command(struct i2c_client *client,
 
 	ret = i2c_transfer(client->adapter, msg, msg_num);
 
-	if (data_len > 0)
-		clear_bit(I2C_HID_READ_PENDING, &ihid->flags);
-
 	if (ret != msg_num)
 		return ret < 0 ? ret : -EIO;
 
@@ -533,9 +528,6 @@ static irqreturn_t i2c_hid_irq(int irq, void *dev_id)
 {
 	struct i2c_hid *ihid = dev_id;
 
-	if (test_bit(I2C_HID_READ_PENDING, &ihid->flags))
-		return IRQ_HANDLED;
-
 	i2c_hid_get_input(ihid);
 
 	return IRQ_HANDLED;
-- 
2.39.2



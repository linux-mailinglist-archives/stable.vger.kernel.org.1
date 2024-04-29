Return-Path: <stable+bounces-41663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B8E8B5687
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 13:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E91E2283BCE
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 11:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80B740872;
	Mon, 29 Apr 2024 11:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kQbWT420"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984BE3FBBD
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 11:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390025; cv=none; b=ccOGvKcJSxPJLWDUoHbEIFu7FlFh0Gemfc0fAJ4mJ60ulD407PlDFYOfE52m4Uf49MeS3VHTzctO5/48dCvASUQ9V8UqkqdmFzjc9GmKCJEgL3B5p+KYkZgB22Rm+RYYP1gNqRRpCYEkMAQ8zbkeuEY5ItRxLtnzuFo2OcLW1Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390025; c=relaxed/simple;
	bh=kLN8gwCxuESPuwYu1C6sOTNjwGJJK6KdNUokvcrXBhw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WPO0BesenvSLPrgIvA+81gRdiGesk+bvOA7XOCVxCoCwwiw8wKMq4UvbmPnLNcMruJ4FaWNQPno3tXh4L6XVRMfJWf0cmSDpcoL7AJ0y4ajT9nzhkFh24EoLvQEJaqJJ2XZFdg0hv85x7yKkrdDlRBf6uGMWML3nyO+alnkjbCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kQbWT420; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08AAAC113CD;
	Mon, 29 Apr 2024 11:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714390025;
	bh=kLN8gwCxuESPuwYu1C6sOTNjwGJJK6KdNUokvcrXBhw=;
	h=Subject:To:Cc:From:Date:From;
	b=kQbWT420zMGb+cQDoUTsri1tNmZ6oWvZekYPBmuqP9EK1m0rdCO9rAIkyfFJ1Wrpn
	 vAtMnG+/jtpLc9hlHqXYpa3Ics30Ci5EDO8W/v82ybG8+vgbsD0vOCfUFxy8Sa2vIy
	 JYbxpQVfLK2LBMlNqx9JMJTHEtsSSTqISb8Ckw5M=
Subject: FAILED: patch "[PATCH] HID: i2c-hid: remove I2C_HID_READ_PENDING flag to prevent" failed to apply to 4.19-stable tree
To: namcao@linutronix.de,jkosina@suse.com,nyandarknessgirl@gmail.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Apr 2024 13:26:55 +0200
Message-ID: <2024042955-boxer-slinky-3da2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 9c0f59e47a90c54d0153f8ddc0f80d7a36207d0e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042955-boxer-slinky-3da2@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

9c0f59e47a90 ("HID: i2c-hid: remove I2C_HID_READ_PENDING flag to prevent lock-up")
dbe0dd5fd2e0 ("HID: i2c-hid: explicitly code setting and sending reports")
b26fc3161b78 ("HID: i2c-hid: refactor reset command")
d34c6105499b ("HID: i2c-hid: use "struct i2c_hid" as argument in most calls")
a5e5e03e9476 ("HID: i2c-hid: fix GET/SET_REPORT for unnumbered reports")
cf5b2fb012c0 ("HID: i2c-hid: fix handling numbered reports with IDs of 15 and above")
ca66a6770bd9 ("HID: i2c-hid: Skip ELAN power-on command after reset")
b33752c30023 ("HID: i2c-hid: Reorganize so ACPI and OF are separate modules")
19a0b6d79c97 ("Merge branch 'for-5.11/i2c-hid' into for-linus")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9c0f59e47a90c54d0153f8ddc0f80d7a36207d0e Mon Sep 17 00:00:00 2001
From: Nam Cao <namcao@linutronix.de>
Date: Mon, 18 Mar 2024 11:59:02 +0100
Subject: [PATCH] HID: i2c-hid: remove I2C_HID_READ_PENDING flag to prevent
 lock-up

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

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 2df1ab3c31cc..1c86c97688e9 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -64,7 +64,6 @@
 /* flags */
 #define I2C_HID_STARTED		0
 #define I2C_HID_RESET_PENDING	1
-#define I2C_HID_READ_PENDING	2
 
 #define I2C_HID_PWR_ON		0x00
 #define I2C_HID_PWR_SLEEP	0x01
@@ -190,15 +189,10 @@ static int i2c_hid_xfer(struct i2c_hid *ihid,
 		msgs[n].len = recv_len;
 		msgs[n].buf = recv_buf;
 		n++;
-
-		set_bit(I2C_HID_READ_PENDING, &ihid->flags);
 	}
 
 	ret = i2c_transfer(client->adapter, msgs, n);
 
-	if (recv_len)
-		clear_bit(I2C_HID_READ_PENDING, &ihid->flags);
-
 	if (ret != n)
 		return ret < 0 ? ret : -EIO;
 
@@ -556,9 +550,6 @@ static irqreturn_t i2c_hid_irq(int irq, void *dev_id)
 {
 	struct i2c_hid *ihid = dev_id;
 
-	if (test_bit(I2C_HID_READ_PENDING, &ihid->flags))
-		return IRQ_HANDLED;
-
 	i2c_hid_get_input(ihid);
 
 	return IRQ_HANDLED;



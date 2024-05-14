Return-Path: <stable+bounces-43964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B65E8C5075
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDCC51F21CD9
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4832C13D618;
	Tue, 14 May 2024 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VMBldPNC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0778969D2F;
	Tue, 14 May 2024 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715683383; cv=none; b=qgDcWKdbMpo+JDl0NWdhu2IU/7fF74NH+3ckrsd+HvIhc991Mj8PvZI6On139gEdKSt5Dr/Jld9l3wxGPR0n2ok0wehn+Pd5m0tABv8vpbh6ORaEFkGm57Yohqg86/T0NmR5XRq8ZfEDYiVKd88LVO5rw69c+tMox/nmNfzj04Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715683383; c=relaxed/simple;
	bh=YG4X9v1pXkxrJTsM9Ffv9az7asZf5T7P220SMM72SlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IhS3YMl3PDM13Rnl9wd263Vo8MVZ11JppN9Cr0W9tZZznzl7OcSZKtRBAQaL3OQZRhE8mlE/kl09x0CpotvFlsW7IIQa4l0DvjhR0gXruVbEscmd46Ib8jTTHS9+u1EygCvv5pX3i+I04Z0QwWKkycetolFKJ1VKjCivkuDF/4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VMBldPNC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0988C2BD10;
	Tue, 14 May 2024 10:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715683382;
	bh=YG4X9v1pXkxrJTsM9Ffv9az7asZf5T7P220SMM72SlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VMBldPNCdX7UQCcubgOAkHoxekhz1lR/7XAk3iG/yIfLngb1USI3TTQZm5i4d1k4w
	 ZXuLNQXdOUQkujW59Mnk8xJXllEhW0nHd/ZR0i8uh126QguQJVtXQwnOvcOyktPZlH
	 NnLlG/nOS2p3BICBJ/z6NVC708oeiNzXMN4XHHkY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aleksa Savic <savicaleksa83@gmail.com>,
	Marius Zachmann <mail@mariuszachmann.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 207/336] hwmon: (corsair-cpro) Use a separate buffer for sending commands
Date: Tue, 14 May 2024 12:16:51 +0200
Message-ID: <20240514101046.419965530@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101038.595152603@linuxfoundation.org>
References: <20240514101038.595152603@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aleksa Savic <savicaleksa83@gmail.com>

[ Upstream commit e0cd85dc666cb08e1bd313d560cb4eff4d04219e ]

Introduce cmd_buffer, a separate buffer for storing only
the command that is sent to the device. Before this separation,
the existing buffer was shared for both the command and the
report received in ccp_raw_event(), which was copied into it.

However, because of hidraw, the raw event parsing may be triggered
in the middle of sending a command, resulting in outputting gibberish
to the device. Using a separate buffer resolves this.

Fixes: 40c3a4454225 ("hwmon: add Corsair Commander Pro driver")
Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
Acked-by: Marius Zachmann <mail@mariuszachmann.de>
Link: https://lore.kernel.org/r/20240504092504.24158-2-savicaleksa83@gmail.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/corsair-cpro.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/corsair-cpro.c b/drivers/hwmon/corsair-cpro.c
index a284a02839fbb..8d85f66f81435 100644
--- a/drivers/hwmon/corsair-cpro.c
+++ b/drivers/hwmon/corsair-cpro.c
@@ -79,6 +79,7 @@ struct ccp_device {
 	struct device *hwmon_dev;
 	struct completion wait_input_report;
 	struct mutex mutex; /* whenever buffer is used, lock before send_usb_cmd */
+	u8 *cmd_buffer;
 	u8 *buffer;
 	int target[6];
 	DECLARE_BITMAP(temp_cnct, NUM_TEMP_SENSORS);
@@ -111,15 +112,15 @@ static int send_usb_cmd(struct ccp_device *ccp, u8 command, u8 byte1, u8 byte2,
 	unsigned long t;
 	int ret;
 
-	memset(ccp->buffer, 0x00, OUT_BUFFER_SIZE);
-	ccp->buffer[0] = command;
-	ccp->buffer[1] = byte1;
-	ccp->buffer[2] = byte2;
-	ccp->buffer[3] = byte3;
+	memset(ccp->cmd_buffer, 0x00, OUT_BUFFER_SIZE);
+	ccp->cmd_buffer[0] = command;
+	ccp->cmd_buffer[1] = byte1;
+	ccp->cmd_buffer[2] = byte2;
+	ccp->cmd_buffer[3] = byte3;
 
 	reinit_completion(&ccp->wait_input_report);
 
-	ret = hid_hw_output_report(ccp->hdev, ccp->buffer, OUT_BUFFER_SIZE);
+	ret = hid_hw_output_report(ccp->hdev, ccp->cmd_buffer, OUT_BUFFER_SIZE);
 	if (ret < 0)
 		return ret;
 
@@ -492,7 +493,11 @@ static int ccp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (!ccp)
 		return -ENOMEM;
 
-	ccp->buffer = devm_kmalloc(&hdev->dev, OUT_BUFFER_SIZE, GFP_KERNEL);
+	ccp->cmd_buffer = devm_kmalloc(&hdev->dev, OUT_BUFFER_SIZE, GFP_KERNEL);
+	if (!ccp->cmd_buffer)
+		return -ENOMEM;
+
+	ccp->buffer = devm_kmalloc(&hdev->dev, IN_BUFFER_SIZE, GFP_KERNEL);
 	if (!ccp->buffer)
 		return -ENOMEM;
 
-- 
2.43.0





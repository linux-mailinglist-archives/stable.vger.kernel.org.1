Return-Path: <stable+bounces-85924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE5699EAD1
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 14:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9515C2827F1
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 12:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423D01C07E0;
	Tue, 15 Oct 2024 12:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VTam9BiU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35CA1C07C2;
	Tue, 15 Oct 2024 12:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728997167; cv=none; b=bKtoVEfkW78LQctf1wZqIKJZEDOMiMFIUMJJpxMV1wkeTwi8P+UxHTlJcb7aLTcsQtF1gNz60l1vK17RHxotHtCiQXWzajWsQ5VcGfo0u793RehiHACmkOBciiXcOEMHq8IqvqbZtaEVXHwAJNYKZWjGRT3jqsKdJZa2GGFLyzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728997167; c=relaxed/simple;
	bh=fuacM4WrYO9fLOxMbu3RyWLCbVLBvOTwoZAWj2lI1jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ifu1H0y50MGtQJYEgA4B7n/ws5I98j8e96ApqEPTy5ARt189Dpy9P0+ZmUG4+OdAhzOInKm1s6JSfZi22iejMdYAYLkLbT42kVsh27XT236mvxmWWmNh+dQzcgEBUwFZjc2W1dpUGTXqKc8yypHiNziiv9MVJwQTLf+QcNO2ZLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VTam9BiU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C66C4CEC6;
	Tue, 15 Oct 2024 12:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728997166;
	bh=fuacM4WrYO9fLOxMbu3RyWLCbVLBvOTwoZAWj2lI1jw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VTam9BiU94HTB+/4FZ8wlC8zY8YV29RmtEWDqn1H6Ef/LkSVvmMJ2CRwjdl8K3DMB
	 AH9PQPymg8tl4ri//d/ysU32E7372eqX4B6Z3JFGhzYfk+jKRYbC7KwzWqv5g3pDBg
	 bKANQoEo9EFE9qf9XhH0GlYXl16U3mdOjGEaIIFU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 106/518] hwmon: (max16065) Fix alarm attributes
Date: Tue, 15 Oct 2024 14:40:10 +0200
Message-ID: <20241015123921.092157545@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015123916.821186887@linuxfoundation.org>
References: <20241015123916.821186887@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 119abf7d1815f098f7f91ae7abc84324a19943d7 ]

Chips reporting overcurrent alarms report it in the second alarm register.
That means the second alarm register has to be read, even if the chip only
supports 8 or fewer ADC channels.

MAX16067 and MAX16068 report undervoltage and overvoltage alarms in
separate registers. Fold register contents together to report both with
the existing alarm attribute. This requires actually storing the chip type
in struct max16065_data. Rename the variable 'chip' to match the variable
name used in the probe function.

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
Fixes: f5bae2642e3d ("hwmon: Driver for MAX16065 System Manager and compatibles")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/max16065.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/max16065.c b/drivers/hwmon/max16065.c
index 072f22f85dc0c..b4c519e52fffe 100644
--- a/drivers/hwmon/max16065.c
+++ b/drivers/hwmon/max16065.c
@@ -79,7 +79,7 @@ static const bool max16065_have_current[] = {
 };
 
 struct max16065_data {
-	enum chips type;
+	enum chips chip;
 	struct i2c_client *client;
 	const struct attribute_group *groups[4];
 	struct mutex update_lock;
@@ -162,10 +162,17 @@ static struct max16065_data *max16065_update_device(struct device *dev)
 						     MAX16065_CURR_SENSE);
 		}
 
-		for (i = 0; i < DIV_ROUND_UP(data->num_adc, 8); i++)
+		for (i = 0; i < 2; i++)
 			data->fault[i]
 			  = i2c_smbus_read_byte_data(client, MAX16065_FAULT(i));
 
+		/*
+		 * MAX16067 and MAX16068 have separate undervoltage and
+		 * overvoltage alarm bits. Squash them together.
+		 */
+		if (data->chip == max16067 || data->chip == max16068)
+			data->fault[0] |= data->fault[1];
+
 		data->last_updated = jiffies;
 		data->valid = 1;
 	}
@@ -514,6 +521,7 @@ static int max16065_probe(struct i2c_client *client)
 	if (unlikely(!data))
 		return -ENOMEM;
 
+	data->chip = chip;
 	data->client = client;
 	mutex_init(&data->update_lock);
 
-- 
2.43.0





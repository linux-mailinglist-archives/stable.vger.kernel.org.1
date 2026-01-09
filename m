Return-Path: <stable+bounces-206829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C973D0958E
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 13:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDEF430E1E2F
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 12:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C173335A925;
	Fri,  9 Jan 2026 12:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K6b/tcdP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8474033D50F;
	Fri,  9 Jan 2026 12:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767960317; cv=none; b=p41XMfAiBV5cZcD2UURmFrF4kwGCftWODNXmZ7wkWTHrj7gTWO1Mugngab3aql7UxYB+6EwHcT1WKesFv6upkuAuq6hCRDfKqhf6SWkUpviGmSszXlSvKf57NBzYdJPZhb44FBIZq//VT62gNw+Do8YaQV1fSQP9F2vuwE2qq8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767960317; c=relaxed/simple;
	bh=NHJAL0kyyFZNMac4IxKbC1qWWCkVTcK2kVMnBi76uNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n/TtYLuV0WuF23Q5etFvkdORUFzEHda756A0VbMzSnsSkMCN+th5Q8qJyHKVSldS6CIwlR9RHkw8i2qSuL67dW8akumkhQJd1VFTDhoNKfyVy2eDeo+1TIvseuYg/B28KoIyOzgsbPkfCBuoaMlAmTkVMoimWelwydQkYKi0dmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K6b/tcdP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D9EC4CEF1;
	Fri,  9 Jan 2026 12:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767960317;
	bh=NHJAL0kyyFZNMac4IxKbC1qWWCkVTcK2kVMnBi76uNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K6b/tcdPCjGHE7z/Yqaz6iu2Zc4Y4lnbScUYwTR9aK7LyUsd3tXqL40dR8pEI1Inn
	 l9Y0De7JfuGcRzqiGFmNziurIw5jirs9P0A4rhtpi+Lq6+FDM++PpJ6QwlArkVUwQT
	 I8TkPIWvavn5Fa4LCCpBSrZC2Egub2y4DSbvZ0Dk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexey Simakov <bigalex934@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 362/737] hwmon: (tmp401) fix overflow caused by default conversion rate value
Date: Fri,  9 Jan 2026 12:38:21 +0100
Message-ID: <20260109112147.613087425@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109112133.973195406@linuxfoundation.org>
References: <20260109112133.973195406@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Alexey Simakov <bigalex934@gmail.com>

[ Upstream commit 82f2aab35a1ab2e1460de06ef04c726460aed51c ]

The driver computes conversion intervals using the formula:

    interval = (1 << (7 - rate)) * 125ms

where 'rate' is the sensor's conversion rate register value. According to
the datasheet, the power-on reset value of this register is 0x8, which
could be assigned to the register, after handling i2c general call.
Using this default value causes a result greater than the bit width of
left operand and an undefined behaviour in the calculation above, since
shifting by values larger than the bit width is undefined behaviour as
per C language standard.

Limit the maximum usable 'rate' value to 7 to prevent undefined
behaviour in calculations.

Found by Linux Verification Center (linuxtesting.org) with Svace.

Note (groeck):
    This does not matter in practice unless someone overwrites the chip
    configuration from outside the driver while the driver is loaded.
    The conversion time register is initialized with a value of 5 (500ms)
    when the driver is loaded, and the driver never writes a bad value.

Fixes: ca53e7640de7 ("hwmon: (tmp401) Convert to _info API")
Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
Link: https://lore.kernel.org/r/20251211164342.6291-1-bigalex934@gmail.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/tmp401.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
index 91f2314568cf..5cc932ef0460 100644
--- a/drivers/hwmon/tmp401.c
+++ b/drivers/hwmon/tmp401.c
@@ -408,7 +408,7 @@ static int tmp401_chip_read(struct device *dev, u32 attr, int channel, long *val
 		ret = regmap_read(data->regmap, TMP401_CONVERSION_RATE, &regval);
 		if (ret < 0)
 			return ret;
-		*val = (1 << (7 - regval)) * 125;
+		*val = (1 << (7 - min(regval, 7))) * 125;
 		break;
 	case hwmon_chip_temp_reset_history:
 		*val = 0;
-- 
2.51.0





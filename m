Return-Path: <stable+bounces-107188-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FD7A02A9E
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8B96164E9F
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8907D155325;
	Mon,  6 Jan 2025 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="luFXdb1N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404C01791F4;
	Mon,  6 Jan 2025 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177718; cv=none; b=pbc86WFa/VKXlNU+G7TArf9qB/QMsolntv6VYgeTlUjjwdbyM9TcbWYGTy7x78EPBWjmg8ICM8mO46xoA+H2hXoG1A/vPjBKlHn4Xyuy5nEF+Qv/UTw8H43XOJDDEEquqNUPjKF8mToFt4uKsCFL2HxfeD48qoQs3JViJ9pQsiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177718; c=relaxed/simple;
	bh=s9pXtHeRUo7p4twRy8M6hl7CqM4fgUE0aDq+TY9rDes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rftU6b/obp2KerD6Vdct05sUHxATDGLMkGN32dNCbxlHplfCg5lMVX8OKt/A9WbarpX50oYsUF3Fg0q4j9NENmSCbhDc0u+oT3PSU0GEAeGAjK2ctntnWDQkqWhhY4rbtjY458LbVMFvgTVJPBv+L0VF6EnrpXppR8xQTjy78Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=luFXdb1N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C44C4CED2;
	Mon,  6 Jan 2025 15:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736177718;
	bh=s9pXtHeRUo7p4twRy8M6hl7CqM4fgUE0aDq+TY9rDes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=luFXdb1Nxocx3KD/s51JcEzJtk4WNqTaJT1ly86ivG4ffr2d/uA7BdEChXA6GjoVj
	 TRZWIj+t1Y58jOZkuVIodvbxYEB8mB+dSI4MocekWLtym202AtQS0QyuSk2dVhBxmt
	 v+/kPEOdUDIUjYTTL0T/YZIxxjVTt7UyR1UlohJI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tristram Ha <tristram.ha@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 033/156] net: dsa: microchip: Fix KSZ9477 set_ageing_time function
Date: Mon,  6 Jan 2025 16:15:19 +0100
Message-ID: <20250106151142.985272106@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106151141.738050441@linuxfoundation.org>
References: <20250106151141.738050441@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tristram Ha <tristram.ha@microchip.com>

[ Upstream commit 262bfba8ab820641c8cfbbf03b86d6c00242c078 ]

The aging count is not a simple 11-bit value but comprises a 3-bit
multiplier and an 8-bit second count.  The code tries to use the
original multiplier which is 4 as the second count is still 300 seconds
by default.

Fixes: 2c119d9982b1 ("net: dsa: microchip: add the support for set_ageing_time")
Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20241218020224.70590-2-Tristram.Ha@microchip.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/microchip/ksz9477.c     | 47 +++++++++++++++++++------
 drivers/net/dsa/microchip/ksz9477_reg.h |  4 +--
 2 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 0ba658a72d8f..22556d339d6e 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -2,7 +2,7 @@
 /*
  * Microchip KSZ9477 switch driver main logic
  *
- * Copyright (C) 2017-2019 Microchip Technology Inc.
+ * Copyright (C) 2017-2024 Microchip Technology Inc.
  */
 
 #include <linux/kernel.h>
@@ -983,26 +983,51 @@ void ksz9477_get_caps(struct ksz_device *dev, int port,
 int ksz9477_set_ageing_time(struct ksz_device *dev, unsigned int msecs)
 {
 	u32 secs = msecs / 1000;
-	u8 value;
-	u8 data;
+	u8 data, mult, value;
+	u32 max_val;
 	int ret;
 
-	value = FIELD_GET(SW_AGE_PERIOD_7_0_M, secs);
+#define MAX_TIMER_VAL	((1 << 8) - 1)
 
-	ret = ksz_write8(dev, REG_SW_LUE_CTRL_3, value);
-	if (ret < 0)
-		return ret;
+	/* The aging timer comprises a 3-bit multiplier and an 8-bit second
+	 * value.  Either of them cannot be zero.  The maximum timer is then
+	 * 7 * 255 = 1785 seconds.
+	 */
+	if (!secs)
+		secs = 1;
 
-	data = FIELD_GET(SW_AGE_PERIOD_10_8_M, secs);
+	/* Return error if too large. */
+	else if (secs > 7 * MAX_TIMER_VAL)
+		return -EINVAL;
 
 	ret = ksz_read8(dev, REG_SW_LUE_CTRL_0, &value);
 	if (ret < 0)
 		return ret;
 
-	value &= ~SW_AGE_CNT_M;
-	value |= FIELD_PREP(SW_AGE_CNT_M, data);
+	/* Check whether there is need to update the multiplier. */
+	mult = FIELD_GET(SW_AGE_CNT_M, value);
+	max_val = MAX_TIMER_VAL;
+	if (mult > 0) {
+		/* Try to use the same multiplier already in the register as
+		 * the hardware default uses multiplier 4 and 75 seconds for
+		 * 300 seconds.
+		 */
+		max_val = DIV_ROUND_UP(secs, mult);
+		if (max_val > MAX_TIMER_VAL || max_val * mult != secs)
+			max_val = MAX_TIMER_VAL;
+	}
+
+	data = DIV_ROUND_UP(secs, max_val);
+	if (mult != data) {
+		value &= ~SW_AGE_CNT_M;
+		value |= FIELD_PREP(SW_AGE_CNT_M, data);
+		ret = ksz_write8(dev, REG_SW_LUE_CTRL_0, value);
+		if (ret < 0)
+			return ret;
+	}
 
-	return ksz_write8(dev, REG_SW_LUE_CTRL_0, value);
+	value = DIV_ROUND_UP(secs, data);
+	return ksz_write8(dev, REG_SW_LUE_CTRL_3, value);
 }
 
 void ksz9477_port_queue_split(struct ksz_device *dev, int port)
diff --git a/drivers/net/dsa/microchip/ksz9477_reg.h b/drivers/net/dsa/microchip/ksz9477_reg.h
index 04235c22bf40..ff579920078e 100644
--- a/drivers/net/dsa/microchip/ksz9477_reg.h
+++ b/drivers/net/dsa/microchip/ksz9477_reg.h
@@ -2,7 +2,7 @@
 /*
  * Microchip KSZ9477 register definitions
  *
- * Copyright (C) 2017-2018 Microchip Technology Inc.
+ * Copyright (C) 2017-2024 Microchip Technology Inc.
  */
 
 #ifndef __KSZ9477_REGS_H
@@ -165,8 +165,6 @@
 #define SW_VLAN_ENABLE			BIT(7)
 #define SW_DROP_INVALID_VID		BIT(6)
 #define SW_AGE_CNT_M			GENMASK(5, 3)
-#define SW_AGE_CNT_S			3
-#define SW_AGE_PERIOD_10_8_M		GENMASK(10, 8)
 #define SW_RESV_MCAST_ENABLE		BIT(2)
 #define SW_HASH_OPTION_M		0x03
 #define SW_HASH_OPTION_CRC		1
-- 
2.39.5





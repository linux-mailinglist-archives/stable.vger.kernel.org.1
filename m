Return-Path: <stable+bounces-194585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F29C518C6
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 11:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80EAE3A2ACB
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 09:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0062FFFA2;
	Wed, 12 Nov 2025 09:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wbzMQ6JZ"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5A92FE568;
	Wed, 12 Nov 2025 09:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940738; cv=none; b=uxPRTwRYEt9TlVVQbnggsFyzT+heUOzeb64gQ8wRi86y2YBGdUA9qCk9Gb7xuj12qqlIo3IpHb6RAouTaLA6UgHXgLl7hzs+QBqowOwK9jzQig8+XgaBYHlMYTNvOfIr+E9QHeGmUF0hsyj8320HvvBPYiFxHvUMGmcgIjczd80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940738; c=relaxed/simple;
	bh=mLuzNV/tT6gKT4g9bK/Ute2cqhVefOMDFTraOTFzmw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rVFBaeiTAOA8YkErNLuYBtRkH9ZkPkvMKtOLh2ToFVEQScq7ORx/u4vmxKmlgjHX6ilwoGhD1taZmD2tVpQfEtvmUSSEP75N1v72sz/QvE8ZKdHMlxRpr27W+BPa5okpxdQcKAp2UO/+iiLPNR9gK6Ao2oL186EQYopebtWpfTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wbzMQ6JZ; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 63793C0F55F;
	Wed, 12 Nov 2025 09:45:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 042216070B;
	Wed, 12 Nov 2025 09:45:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E452210371996;
	Wed, 12 Nov 2025 10:45:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762940732; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=SrgPhVYzot3NWRz/WiAinbX7Yf1I2w+dgr+AbFgHKVg=;
	b=wbzMQ6JZ7XI74M+GM70CbsbX3EpysLrVhfq1oHKbuy3qplQNT+ulzIHG8hriS+HKZgKDwu
	oE9u61uqJEdDVPTr3V4K7t5KmFTJKxQrDxWWmNStCDfiLBi26Axq5VruZuwcQ5M7hyAd7n
	FVbilEFYI9dDszjqjbwwPiPyrRwTUz3F/8KwcfryNwzIbbrwQXMBs0I/izhMimRTMnawaW
	DwaS3bsANnhwwbcEL77DvvzKlyMYonb5PpkLxisnSCM6/wmHECRQ7m+okb9AJ3DFEcu04L
	OiVVLgehOMetVoSW3faJzLcR25GDVPEC3+nt4E3XhL8S0lYaswCswS3TYtvvZg==
From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Date: Wed, 12 Nov 2025 10:45:24 +0100
Subject: [PATCH v3 1/2] mfd: tps65219: Implement LOCK register handling for
 TPS65214
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-fix_tps65219-v3-1-e49bab4c01ce@bootlin.com>
References: <20251112-fix_tps65219-v3-0-e49bab4c01ce@bootlin.com>
In-Reply-To: <20251112-fix_tps65219-v3-0-e49bab4c01ce@bootlin.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Lee Jones <lee@kernel.org>, Shree Ramamoorthy <s-ramamoorthy@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Andrew Davis <afd@ti.com>, Bajjuri Praneeth <praneeth@ti.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-omap@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The TPS65214 PMIC variant has a LOCK_REG register that prevents writes to
nearly all registers.

Implement custom regmap operations that automatically unlock before writes
and re-lock afterwards for TPS65214, while leaving other chip variants
unaffected.

The implementation follows the regmap-i2c design pattern.

Cc: stable@vger.kernel.org
Fixes: 7947219ab1a2d ("mfd: tps65219: Add support for TI TPS65214 PMIC")
Reviewed-by: Shree Ramamoorthy <s-ramamoorthy@ti.com>
Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
---

Changes in v3:
- Removed unused variable.

Changes in v2:
- Setup a custom regmap_bus only for the TPS65214 instead of checking
  the chip_id every time reg_write is called.
---
 drivers/mfd/tps65219.c       | 49 +++++++++++++++++++++++++++++++++++++++++++-
 include/linux/mfd/tps65219.h |  2 ++
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/tps65219.c b/drivers/mfd/tps65219.c
index 65a952555218d..d31e808faab1f 100644
--- a/drivers/mfd/tps65219.c
+++ b/drivers/mfd/tps65219.c
@@ -473,6 +473,48 @@ static const struct tps65219_chip_data chip_info_table[] = {
 	},
 };
 
+static int tps65214_reg_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct i2c_client *i2c = context;
+	int ret;
+
+	if (val > 0xff || reg > 0xff)
+		return -EINVAL;
+
+	ret = i2c_smbus_write_byte_data(i2c, TPS65214_REG_LOCK,
+					TPS65214_LOCK_ACCESS_CMD);
+	if (ret)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(i2c, reg, val);
+	if (ret)
+		return ret;
+
+	return i2c_smbus_write_byte_data(i2c, TPS65214_REG_LOCK, 0);
+}
+
+static int tps65214_reg_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct i2c_client *i2c = context;
+	int ret;
+
+	if (reg > 0xff)
+		return -EINVAL;
+
+	ret = i2c_smbus_read_byte_data(i2c, reg);
+	if (ret < 0)
+		return ret;
+
+	*val = ret;
+
+	return 0;
+}
+
+static const struct regmap_bus tps65214_regmap_bus = {
+	.reg_write = tps65214_reg_write,
+	.reg_read = tps65214_reg_read,
+};
+
 static int tps65219_probe(struct i2c_client *client)
 {
 	struct tps65219 *tps;
@@ -491,7 +533,12 @@ static int tps65219_probe(struct i2c_client *client)
 	chip_id = (uintptr_t)i2c_get_match_data(client);
 	pmic = &chip_info_table[chip_id];
 
-	tps->regmap = devm_regmap_init_i2c(client, &tps65219_regmap_config);
+	if (chip_id == TPS65214)
+		tps->regmap = devm_regmap_init(&client->dev,
+					       &tps65214_regmap_bus, client,
+					       &tps65219_regmap_config);
+	else
+		tps->regmap = devm_regmap_init_i2c(client, &tps65219_regmap_config);
 	if (IS_ERR(tps->regmap)) {
 		ret = PTR_ERR(tps->regmap);
 		dev_err(tps->dev, "Failed to allocate register map: %d\n", ret);
diff --git a/include/linux/mfd/tps65219.h b/include/linux/mfd/tps65219.h
index 55234e771ba73..198ee319dd1db 100644
--- a/include/linux/mfd/tps65219.h
+++ b/include/linux/mfd/tps65219.h
@@ -149,6 +149,8 @@ enum pmic_id {
 #define TPS65215_ENABLE_LDO2_EN_MASK                    BIT(5)
 #define TPS65214_ENABLE_LDO1_EN_MASK			BIT(5)
 #define TPS65219_ENABLE_LDO4_EN_MASK			BIT(6)
+/* Register Lock */
+#define TPS65214_LOCK_ACCESS_CMD			0x5a
 /* power ON-OFF sequence slot */
 #define TPS65219_BUCKS_LDOS_SEQUENCE_OFF_SLOT_MASK	GENMASK(3, 0)
 #define TPS65219_BUCKS_LDOS_SEQUENCE_ON_SLOT_MASK	GENMASK(7, 4)

-- 
2.43.0



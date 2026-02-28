Return-Path: <stable+bounces-220741-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJb1OBpAo2kR+wQAu9opvQ
	(envelope-from <stable+bounces-220741-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:20:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC751C6DE1
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF4AD308E302
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D99401D53;
	Sat, 28 Feb 2026 17:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTTZGol4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B398A401D4A;
	Sat, 28 Feb 2026 17:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300621; cv=none; b=oDfiB+i3WNC8fCXSdU9MwXuH+aM4lnsNbtfWyDSFhxVzTqn/fgSGdGhPpctGPetjQcmzQl+4Hq9onyUYxZtXeGxffM/ipcGfy0/Gi5Iupqj0FWIZyTq5ORaWABaotHjsVT1gTtLyETvF/V7O8g7pW6XsbINdmofXxTTi3bawz9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300621; c=relaxed/simple;
	bh=VYxZee+WZHv8VmJp6p+SGQWMaZCd5KJAiLp5Is6OUJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YzAH1N73hHdDPdiRWHApz5j0+0Z8nSvcIlIciHr85JOBzeCeAISb8pr+qnagje8pNRTZts7zPBhvjQph9jZFzu3Lhi/RUfclDscd8L346Q9XYKfZ++2BPwYjuo7Qfu1gaL1sfZqi/ZcWQBO20I4jlB/FpudVXM0J0t2vfZpsW00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTTZGol4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E82B4C19424;
	Sat, 28 Feb 2026 17:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300621;
	bh=VYxZee+WZHv8VmJp6p+SGQWMaZCd5KJAiLp5Is6OUJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KTTZGol40J3lgEgVxM+L/U/iguYgke3B6zdL0Id70wrRMZn2LGU+Ea8SyRw6nbH2N
	 REQ+59+Rt+z0XwkTjGcwKe1b+MBoykEiUhBm84PhS+Fr0gblAwrg0JU1buV+Zg3Z5n
	 9mEshIZi8qhLhYoxhQw/JiVy4/76JIkkR+JtgwkRr+tXhArb3zjnotWS0PzJ8x5uCR
	 h03QwJPr2VkFiw2fQZOV0G78mMrCR+iFV2DI6r+eOL4qDpS5h3UdPK2xfeJVkhtXrx
	 InzhktB2pJzDurTWGHEJJRbOLF2m39gFDR5LCvoP2d52oZb6bYyrSEYxNJalX8rJ/w
	 QSknwFftRYgmg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
	Andrew Davis <afd@ti.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 662/844] mfd: tps65219: Implement LOCK register handling for TPS65214
Date: Sat, 28 Feb 2026 12:29:35 -0500
Message-ID: <20260228173244.1509663-663-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220741-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ti.com:url,ti.com:email,bootlin.com:email]
X-Rspamd-Queue-Id: 4AC751C6DE1
X-Rspamd-Action: no action

From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>

[ Upstream commit d3fcf276b501a82d4504fd5b1ed40249546530d1 ]

The TPS65214 PMIC variant has a LOCK_REG register that prevents writes to
nearly all registers when locked. Unlock the registers at probe time and
leave them unlocked permanently.

This approach is justified because:
- Register locking is very uncommon in typical system operation
- No code path is expected to lock the registers during runtime
- Adding a custom regmap write function would add overhead to every
  register write, including voltage changes triggered by CPU OPP
  transitions from the cpufreq governor which could happen quite
  frequently

Cc: stable@vger.kernel.org
Fixes: 7947219ab1a2d ("mfd: tps65219: Add support for TI TPS65214 PMIC")
Reviewed-by: Andrew Davis <afd@ti.com>
Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
Link: https://patch.msgid.link/20251218-fix_tps65219-v5-1-8bb511417f3a@bootlin.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/tps65219.c       | 9 +++++++++
 include/linux/mfd/tps65219.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/mfd/tps65219.c b/drivers/mfd/tps65219.c
index 65a952555218d..7275dcdb7c44f 100644
--- a/drivers/mfd/tps65219.c
+++ b/drivers/mfd/tps65219.c
@@ -498,6 +498,15 @@ static int tps65219_probe(struct i2c_client *client)
 		return ret;
 	}
 
+	if (chip_id == TPS65214) {
+		ret = i2c_smbus_write_byte_data(client, TPS65214_REG_LOCK,
+						TPS65214_LOCK_ACCESS_CMD);
+		if (ret) {
+			dev_err(tps->dev, "Failed to unlock registers %d\n", ret);
+			return ret;
+		}
+	}
+
 	ret = devm_regmap_add_irq_chip(tps->dev, tps->regmap, client->irq,
 				       IRQF_ONESHOT, 0, pmic->irq_chip,
 				       &tps->irq_data);
diff --git a/include/linux/mfd/tps65219.h b/include/linux/mfd/tps65219.h
index 55234e771ba73..3abf937191d0c 100644
--- a/include/linux/mfd/tps65219.h
+++ b/include/linux/mfd/tps65219.h
@@ -149,6 +149,8 @@ enum pmic_id {
 #define TPS65215_ENABLE_LDO2_EN_MASK                    BIT(5)
 #define TPS65214_ENABLE_LDO1_EN_MASK			BIT(5)
 #define TPS65219_ENABLE_LDO4_EN_MASK			BIT(6)
+/* Register Unlock */
+#define TPS65214_LOCK_ACCESS_CMD			0x5a
 /* power ON-OFF sequence slot */
 #define TPS65219_BUCKS_LDOS_SEQUENCE_OFF_SLOT_MASK	GENMASK(3, 0)
 #define TPS65219_BUCKS_LDOS_SEQUENCE_ON_SLOT_MASK	GENMASK(7, 4)
-- 
2.51.0



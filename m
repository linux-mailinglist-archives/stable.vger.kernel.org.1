Return-Path: <stable+bounces-103347-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E365C9EF797
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 951E0175D33
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02ED6215762;
	Thu, 12 Dec 2024 17:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1KMahb+R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EFD2144C4;
	Thu, 12 Dec 2024 17:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024293; cv=none; b=Afzn28FktOGbLkZq5slRVoH44Ata8eDBHMdFEZ9rhuPyw7i0OQbi+Pe28xKI0Fzjp2LN3a8DQTOqNw19EQfB+c0A1lL+LsQ9Q8nXRxgTdnEwKwe0m9YRXOHaKYd4wvSq69os04dWKLoyk4gk3gGGPoKjDNaZvVRP5Q9b7/g+FoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024293; c=relaxed/simple;
	bh=JhsuspRia1wMrPX4D3vQYbphmH5zft5PW1poOhWKNpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s43kv+ScALNJNJyTXBzjRnJlXqSHoKZ3Y+x83Pl0BopLylXuiinC+bINzKljZtezm7RqBXMPfdVYdY4UZ652B9DiTywf8NfqVhFQQ3Pe94y6FpRfzdYxW8CtmQ6h25XZO48bOSm2vi5v/IaiGRGWdT9atYTVyiGSt0N30eytKDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1KMahb+R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D99C4CECE;
	Thu, 12 Dec 2024 17:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734024293;
	bh=JhsuspRia1wMrPX4D3vQYbphmH5zft5PW1poOhWKNpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1KMahb+RSUPMQ3jhPOJ8RXQOJPeZG0i0xd1ww1BYJg03UOGI+9pZlNvnTU4B3Zke8
	 1TzDnLkhHR6xIYx2v6hAUJUo98SalP4gKvHeZUJ24fY+bJtUOvgAlzy5aWb39w4Q+F
	 5h8xTeEmvx52pHmT/U+T+C0l9FX/ScymgOgWG06M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hermes Zhang <chenhuiz@axis.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 218/459] power: supply: bq27xxx: Support CHARGE_NOW for bq27z561/bq28z610/bq34z100
Date: Thu, 12 Dec 2024 15:59:16 +0100
Message-ID: <20241212144302.183803337@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144253.511169641@linuxfoundation.org>
References: <20241212144253.511169641@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hermes Zhang <chenhuiz@axis.com>

[ Upstream commit 3ed510f06e12f8876c20474766cc2f101a41174f ]

Currently REG_NAC (nominal available capacity) is mapped to
power-supply's CHARGE_NOW property. Some chips do not have
REG_NAC and do not expose CHARGE_NOW at the moment. Some
bq27xxx chips also have another register REG_RM (remaining
capacity). The difference between REG_NAC and REG_RM is load
compensation.

This patch adds register information for REG_RM for all
supported fuel gauges. On systems having REG_NAC it is
ignored, so behaviour does not change. On systems without
REG_NAC, REG_RM will be used to provide CHARGE_NOW
functionality.

As a result there are three more chips exposing CHARGE_NOW:
bq27z561, bq28z610 and bq34z100

Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Stable-dep-of: 34f99d3b706a ("power: supply: bq27xxx: Fix registers of bq27426")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/bq27xxx_battery.c | 35 +++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 0673e0fe0ffbd..21f6df21c3cc4 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -110,6 +110,7 @@ enum bq27xxx_reg_index {
 	BQ27XXX_REG_TTES,	/* Time-to-Empty Standby */
 	BQ27XXX_REG_TTECP,	/* Time-to-Empty at Constant Power */
 	BQ27XXX_REG_NAC,	/* Nominal Available Capacity */
+	BQ27XXX_REG_RC,		/* Remaining Capacity */
 	BQ27XXX_REG_FCC,	/* Full Charge Capacity */
 	BQ27XXX_REG_CYCT,	/* Cycle Count */
 	BQ27XXX_REG_AE,		/* Available Energy */
@@ -145,6 +146,7 @@ static u8
 		[BQ27XXX_REG_TTES] = 0x1c,
 		[BQ27XXX_REG_TTECP] = 0x26,
 		[BQ27XXX_REG_NAC] = 0x0c,
+		[BQ27XXX_REG_RC] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_FCC] = 0x12,
 		[BQ27XXX_REG_CYCT] = 0x2a,
 		[BQ27XXX_REG_AE] = 0x22,
@@ -169,6 +171,7 @@ static u8
 		[BQ27XXX_REG_TTES] = 0x1c,
 		[BQ27XXX_REG_TTECP] = 0x26,
 		[BQ27XXX_REG_NAC] = 0x0c,
+		[BQ27XXX_REG_RC] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_FCC] = 0x12,
 		[BQ27XXX_REG_CYCT] = 0x2a,
 		[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
@@ -193,6 +196,7 @@ static u8
 		[BQ27XXX_REG_TTES] = 0x1a,
 		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_NAC] = 0x0c,
+		[BQ27XXX_REG_RC] = 0x10,
 		[BQ27XXX_REG_FCC] = 0x12,
 		[BQ27XXX_REG_CYCT] = 0x2a,
 		[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
@@ -215,6 +219,7 @@ static u8
 		[BQ27XXX_REG_TTES] = 0x1c,
 		[BQ27XXX_REG_TTECP] = 0x26,
 		[BQ27XXX_REG_NAC] = 0x0c,
+		[BQ27XXX_REG_RC] = 0x10,
 		[BQ27XXX_REG_FCC] = 0x12,
 		[BQ27XXX_REG_CYCT] = 0x2a,
 		[BQ27XXX_REG_AE] = 0x22,
@@ -237,6 +242,7 @@ static u8
 		[BQ27XXX_REG_TTES] = 0x1a,
 		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_NAC] = 0x0c,
+		[BQ27XXX_REG_RC] = 0x10,
 		[BQ27XXX_REG_FCC] = 0x12,
 		[BQ27XXX_REG_CYCT] = 0x1e,
 		[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
@@ -257,6 +263,7 @@ static u8
 		[BQ27XXX_REG_TTES] = 0x1c,
 		[BQ27XXX_REG_TTECP] = 0x26,
 		[BQ27XXX_REG_NAC] = 0x0c,
+		[BQ27XXX_REG_RC] = 0x10,
 		[BQ27XXX_REG_FCC] = 0x12,
 		[BQ27XXX_REG_CYCT] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_AE] = 0x22,
@@ -277,6 +284,7 @@ static u8
 		[BQ27XXX_REG_TTES] = 0x1c,
 		[BQ27XXX_REG_TTECP] = 0x26,
 		[BQ27XXX_REG_NAC] = 0x0c,
+		[BQ27XXX_REG_RC] = 0x10,
 		[BQ27XXX_REG_FCC] = 0x12,
 		[BQ27XXX_REG_CYCT] = 0x2a,
 		[BQ27XXX_REG_AE] = 0x22,
@@ -297,6 +305,7 @@ static u8
 		[BQ27XXX_REG_TTES] = 0x1c,
 		[BQ27XXX_REG_TTECP] = 0x26,
 		[BQ27XXX_REG_NAC] = 0x0c,
+		[BQ27XXX_REG_RC] = 0x10,
 		[BQ27XXX_REG_FCC] = 0x12,
 		[BQ27XXX_REG_CYCT] = 0x2a,
 		[BQ27XXX_REG_AE] = 0x22,
@@ -317,6 +326,7 @@ static u8
 		[BQ27XXX_REG_TTES] = 0x1c,
 		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_NAC] = 0x0c,
+		[BQ27XXX_REG_RC] = 0x10,
 		[BQ27XXX_REG_FCC] = 0x12,
 		[BQ27XXX_REG_CYCT] = 0x1e,
 		[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
@@ -337,6 +347,7 @@ static u8
 		[BQ27XXX_REG_TTES] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_NAC] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_RC] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_FCC] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_CYCT] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
@@ -361,6 +372,7 @@ static u8
 		[BQ27XXX_REG_TTES] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_NAC] = 0x0c,
+		[BQ27XXX_REG_RC] = 0x10,
 		[BQ27XXX_REG_FCC] = 0x12,
 		[BQ27XXX_REG_CYCT] = 0x2a,
 		[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
@@ -382,6 +394,7 @@ static u8
 		[BQ27XXX_REG_TTES] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_NAC] = 0x0c,
+		[BQ27XXX_REG_RC] = 0x10,
 		[BQ27XXX_REG_FCC] = 0x12,
 		[BQ27XXX_REG_CYCT] = 0x2a,
 		[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
@@ -405,6 +418,7 @@ static u8
 		[BQ27XXX_REG_TTES] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_NAC] = 0x0c,
+		[BQ27XXX_REG_RC] = 0x10,
 		[BQ27XXX_REG_FCC] = 0x12,
 		[BQ27XXX_REG_CYCT] = 0x2a,
 		[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
@@ -425,6 +439,7 @@ static u8
 		[BQ27XXX_REG_TTES] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_NAC] = 0x08,
+		[BQ27XXX_REG_RC] = 0x0c,
 		[BQ27XXX_REG_FCC] = 0x0e,
 		[BQ27XXX_REG_CYCT] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
@@ -450,6 +465,7 @@ static u8
 		[BQ27XXX_REG_TTES] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_NAC] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_RC] = 0x10,
 		[BQ27XXX_REG_FCC] = 0x12,
 		[BQ27XXX_REG_CYCT] = 0x2a,
 		[BQ27XXX_REG_AE] = 0x22,
@@ -470,6 +486,7 @@ static u8
 		[BQ27XXX_REG_TTES] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_NAC] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_RC] = 0x10,
 		[BQ27XXX_REG_FCC] = 0x12,
 		[BQ27XXX_REG_CYCT] = 0x2a,
 		[BQ27XXX_REG_AE] = 0x22,
@@ -490,6 +507,7 @@ static u8
 		[BQ27XXX_REG_TTES] = 0x1e,
 		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_NAC] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_RC] = 0x04,
 		[BQ27XXX_REG_FCC] = 0x06,
 		[BQ27XXX_REG_CYCT] = 0x2c,
 		[BQ27XXX_REG_AE] = 0x24,
@@ -745,6 +763,7 @@ static enum power_supply_property bq27z561_props[] = {
 	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
 	POWER_SUPPLY_PROP_TECHNOLOGY,
 	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_CHARGE_NOW,
 	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
 	POWER_SUPPLY_PROP_CYCLE_COUNT,
 	POWER_SUPPLY_PROP_POWER_AVG,
@@ -764,6 +783,7 @@ static enum power_supply_property bq28z610_props[] = {
 	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
 	POWER_SUPPLY_PROP_TECHNOLOGY,
 	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_CHARGE_NOW,
 	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
 	POWER_SUPPLY_PROP_CYCLE_COUNT,
 	POWER_SUPPLY_PROP_POWER_AVG,
@@ -784,6 +804,7 @@ static enum power_supply_property bq34z100_props[] = {
 	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
 	POWER_SUPPLY_PROP_TECHNOLOGY,
 	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_CHARGE_NOW,
 	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
 	POWER_SUPPLY_PROP_CYCLE_COUNT,
 	POWER_SUPPLY_PROP_ENERGY_NOW,
@@ -1508,6 +1529,15 @@ static inline int bq27xxx_battery_read_nac(struct bq27xxx_device_info *di)
 	return bq27xxx_battery_read_charge(di, BQ27XXX_REG_NAC);
 }
 
+/*
+ * Return the battery Remaining Capacity in µAh
+ * Or < 0 if something fails.
+ */
+static inline int bq27xxx_battery_read_rc(struct bq27xxx_device_info *di)
+{
+	return bq27xxx_battery_read_charge(di, BQ27XXX_REG_RC);
+}
+
 /*
  * Return the battery Full Charge Capacity in µAh
  * Or < 0 if something fails.
@@ -1979,7 +2009,10 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 			val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_NOW:
-		ret = bq27xxx_simple_value(bq27xxx_battery_read_nac(di), val);
+		if (di->regs[BQ27XXX_REG_NAC] != INVALID_REG_ADDR)
+			ret = bq27xxx_simple_value(bq27xxx_battery_read_nac(di), val);
+		else
+			ret = bq27xxx_simple_value(bq27xxx_battery_read_rc(di), val);
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL:
 		ret = bq27xxx_simple_value(di->cache.charge_full, val);
-- 
2.43.0





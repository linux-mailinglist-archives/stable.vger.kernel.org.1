Return-Path: <stable+bounces-234551-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGzdEl6j1mlqGwgAu9opvQ
	(envelope-from <stable+bounces-234551-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:50:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CADF83C1B4A
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 865D83181072
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077393624B0;
	Wed,  8 Apr 2026 18:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ieWTkPld"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5FB26FA5A;
	Wed,  8 Apr 2026 18:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673152; cv=none; b=VWoaX9nvCA/TEtX2fIvxK5+twv0RLIQmjioCQgxE8WnMB9PaAUroPhbspuBmUdIM7ZnTBk5zPFuEgB9KfOV3cFHDYUyW6e8x/JKV6uSK7BwsMH35BkOyVULDpgY7HsWzoaRIPvLd1ZUTP/8viWYipJdWvMxm5djaR+oR1eL+Tm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673152; c=relaxed/simple;
	bh=wxVv2DUTbcDYBSWySEKnSsMd9MUNKcBECwHaWrkTu30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IaOkDlhxd2HrE6YCJvoiOIro/tL12hgZhciatwvDVN/yqBrdQhhT7pqFg6MxhXS2SsdJF+Dp+6eo7alX9FlQyfanlIxLC3hdyjtMsKfhm3iM1IEYhYvqA/nhdq4Iu8vTqLbpb9Ry3e0ys1rgUl8WsJ3XjYG8e4CtqUaiF6PT8WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ieWTkPld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54894C19421;
	Wed,  8 Apr 2026 18:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673152;
	bh=wxVv2DUTbcDYBSWySEKnSsMd9MUNKcBECwHaWrkTu30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ieWTkPld/u/P3QZOPb4eSRwK659BTxwPwERs6SzodfcibvNZ5q989OIs9g8dNxUJu
	 M0v8LW8IcxAdH3CaGWokCp2MHOiqKFguZnJGnYZvOpCAEEH/yA8PVTfCpfmc7P/cL5
	 /TwgqaAj6QK97rmgpyFXfQJW1d/e0/Gf1HNFg2EE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Corey Hickey <bugfood-c@fatooh.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 122/277] hwmon: (asus-ec-sensors) Fix T_Sensor for PRIME X670E-PRO WIFI
Date: Wed,  8 Apr 2026 20:01:47 +0200
Message-ID: <20260408175938.429083044@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.836769063@linuxfoundation.org>
References: <20260408175933.836769063@linuxfoundation.org>
User-Agent: quilt/0.69
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-234551-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,roeck-us.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fatooh.org:email]
X-Rspamd-Queue-Id: CADF83C1B4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Corey Hickey <bugfood-c@fatooh.org>

[ Upstream commit cffff6df669a438ecac506dadd49a53d4475a796 ]

On the Asus PRIME X670E-PRO WIFI, the driver reports a constant value of
zero for T_Sensor. On this board, the register for T_Sensor is at a
different address, as found by experimentation and confirmed by
comparison to an independent temperature reading.

* sensor disconnected: -62.0°C
* ambient temperature: +22.0°C
* held between fingers: +30.0°C

Introduce SENSOR_TEMP_T_SENSOR_ALT1 to support the PRIME X670E-PRO WIFI
without causing a regression for other 600-series boards

Fixes: e0444758dd1b ("hwmon: (asus-ec-sensors) add PRIME X670E-PRO WIFI")
Signed-off-by: Corey Hickey <bugfood-c@fatooh.org>
Link: https://lore.kernel.org/r/20260331215414.368785-1-bugfood-ml@fatooh.org
[groeck: Fixed typo, updated Fixes: reference]
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/asus-ec-sensors.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 34a8f6b834c97..95c50d3a788ce 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -111,6 +111,8 @@ enum ec_sensors {
 	ec_sensor_temp_mb,
 	/* "T_Sensor" temperature sensor reading [℃] */
 	ec_sensor_temp_t_sensor,
+	/* like ec_sensor_temp_t_sensor, but at an alternate address [℃] */
+	ec_sensor_temp_t_sensor_alt1,
 	/* VRM temperature [℃] */
 	ec_sensor_temp_vrm,
 	/* CPU Core voltage [mV] */
@@ -156,6 +158,7 @@ enum ec_sensors {
 #define SENSOR_TEMP_CPU_PACKAGE BIT(ec_sensor_temp_cpu_package)
 #define SENSOR_TEMP_MB BIT(ec_sensor_temp_mb)
 #define SENSOR_TEMP_T_SENSOR BIT(ec_sensor_temp_t_sensor)
+#define SENSOR_TEMP_T_SENSOR_ALT1 BIT(ec_sensor_temp_t_sensor_alt1)
 #define SENSOR_TEMP_VRM BIT(ec_sensor_temp_vrm)
 #define SENSOR_IN_CPU_CORE BIT(ec_sensor_in_cpu_core)
 #define SENSOR_FAN_CPU_OPT BIT(ec_sensor_fan_cpu_opt)
@@ -272,6 +275,8 @@ static const struct ec_sensor_info sensors_family_amd_600[] = {
 		EC_SENSOR("VRM", hwmon_temp, 1, 0x00, 0x33),
 	[ec_sensor_temp_t_sensor] =
 		EC_SENSOR("T_Sensor", hwmon_temp, 1, 0x00, 0x36),
+	[ec_sensor_temp_t_sensor_alt1] =
+		EC_SENSOR("T_Sensor", hwmon_temp, 1, 0x00, 0x37),
 	[ec_sensor_fan_cpu_opt] =
 		EC_SENSOR("CPU_Opt", hwmon_fan, 2, 0x00, 0xb0),
 	[ec_sensor_temp_water_in] =
@@ -489,7 +494,7 @@ static const struct ec_board_info board_info_prime_x570_pro = {
 static const struct ec_board_info board_info_prime_x670e_pro_wifi = {
 	.sensors = SENSOR_TEMP_CPU | SENSOR_TEMP_CPU_PACKAGE |
 		SENSOR_TEMP_MB | SENSOR_TEMP_VRM |
-		SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CPU_OPT,
+		SENSOR_TEMP_T_SENSOR_ALT1 | SENSOR_FAN_CPU_OPT,
 	.mutex_path = ACPI_GLOBAL_LOCK_PSEUDO_PATH,
 	.family = family_amd_600_series,
 };
-- 
2.53.0





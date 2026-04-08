Return-Path: <stable+bounces-235104-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKW1Ghml1ml9GwgAu9opvQ
	(envelope-from <stable+bounces-235104-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:57:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C633C20F8
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DF7E73014A29
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB9535C1B5;
	Wed,  8 Apr 2026 18:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="He+POoke"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B052B32A3FD;
	Wed,  8 Apr 2026 18:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674579; cv=none; b=LE0FuPqPj3HkPhdfz6jfzwaHy66l7XdbacnF1u7I0/IS96VxDwcoH0mBVDNobbzPVpZUwU1Udia4czk3tggXWLdYToS1BIe2QK9VgSRX/rnQdhTsvbUaObA71RC+ZhpaoDhl6ILiLYchO5xWe0r6gFnO4/Oea1AfxzJp8mXbjU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674579; c=relaxed/simple;
	bh=tEJ3H+qVDeMJysnmZdDJ9EY8dyAbEB6I7yd7a2Gw4KU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FpUV9nJz6P+7l+TFZcGw2aufExfaauU3IVlsZDJ2ndWMtln3siOB1vSUBpiKJWZ1LkqNgfH80OW7koFBnr9c0aCFSKOgzSQCoPwS5p19INa8MkA/w6K0TwQHQWISjrK3ax1S3B4/h2k0lVW5+8nBL4IrXVwfcdjejpIi9F09aRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=He+POoke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465E1C19421;
	Wed,  8 Apr 2026 18:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674579;
	bh=tEJ3H+qVDeMJysnmZdDJ9EY8dyAbEB6I7yd7a2Gw4KU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=He+POokehLBwC7zuH5aosIjzBtqLr+rlOd6GzSE8g+i6yH5KgnccD7SVc7RBiKTJL
	 4Hra7bTNYn3fNQEPJ0TvBTW2qzhtDEJYQQBe6/Hcx9ytnAwYK2g94sC+71sQikfqRE
	 ySdjSW1rg1STOyjyZsxkY2OLjcZdTmUbLqBUX4QM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Corey Hickey <bugfood-c@fatooh.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 153/311] hwmon: (asus-ec-sensors) Fix T_Sensor for PRIME X670E-PRO WIFI
Date: Wed,  8 Apr 2026 20:02:33 +0200
Message-ID: <20260408175945.120748269@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235104-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,fatooh.org:email,roeck-us.net:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 94C633C20F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

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
index a1445799e23d8..b685d9954df43 100644
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
 	/* VRM east (right) temperature [℃] */
@@ -160,6 +162,7 @@ enum ec_sensors {
 #define SENSOR_TEMP_CPU_PACKAGE BIT(ec_sensor_temp_cpu_package)
 #define SENSOR_TEMP_MB BIT(ec_sensor_temp_mb)
 #define SENSOR_TEMP_T_SENSOR BIT(ec_sensor_temp_t_sensor)
+#define SENSOR_TEMP_T_SENSOR_ALT1 BIT(ec_sensor_temp_t_sensor_alt1)
 #define SENSOR_TEMP_VRM BIT(ec_sensor_temp_vrm)
 #define SENSOR_TEMP_VRME BIT(ec_sensor_temp_vrme)
 #define SENSOR_TEMP_VRMW BIT(ec_sensor_temp_vrmw)
@@ -279,6 +282,8 @@ static const struct ec_sensor_info sensors_family_amd_600[] = {
 		EC_SENSOR("VRM", hwmon_temp, 1, 0x00, 0x33),
 	[ec_sensor_temp_t_sensor] =
 		EC_SENSOR("T_Sensor", hwmon_temp, 1, 0x00, 0x36),
+	[ec_sensor_temp_t_sensor_alt1] =
+		EC_SENSOR("T_Sensor", hwmon_temp, 1, 0x00, 0x37),
 	[ec_sensor_fan_cpu_opt] =
 		EC_SENSOR("CPU_Opt", hwmon_fan, 2, 0x00, 0xb0),
 	[ec_sensor_temp_water_in] =
@@ -509,7 +514,7 @@ static const struct ec_board_info board_info_prime_x570_pro = {
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





Return-Path: <stable+bounces-257267-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOUdEc8ZG2oq/QgAu9opvQ
	(envelope-from <stable+bounces-257267-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:09:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0ACD60F015
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B40B3054534
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428F4352027;
	Sat, 30 May 2026 17:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="itZVSOIh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F7C3438AE;
	Sat, 30 May 2026 17:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780160404; cv=none; b=YOWHptkL6P+EzX7YYwOMJJoRkF0i+1e9T+FoGDrESurB+IZlDKhnDyBQk5SF1sdBTWaFzryhgxW/sgHOrCt6v9+N0cHGalP35yrZW8sHVTqk/HmUOn5CW2aMaf8QgRpSowgZmKM2ndZMBcXe8RUdfrcebr9PSWw5xAy9dAzEvPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780160404; c=relaxed/simple;
	bh=ToCEmxvHduGNHNZ5qo7LGQFUh/8jYaEIXMrXfGdZCeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j388hXqgIYzBUxkuzTV38ijtGrRk4MuFSXEQneKbZS9W/+bnptRXEzrQiRyOf4u+9caOLwpWLW4Vv2QqBtZTnIrZOwpCbcA9a+Qp2Np4rVUhd++iAhaOsDkR5sQc/FSIkXrxWJS26GMUInKqHKPG7bQhLZQC9VxhL2S297Lswq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=itZVSOIh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07AF71F00893;
	Sat, 30 May 2026 17:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780160402;
	bh=xuDXPGkxxp5O8VEAAXyWJ/MdfnTeTwa2cTF/mSsJwAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=itZVSOIh3N8nby1ghSaP13omrbcb4e2kX7ZvgYjV3OA3jM2YC2GDyY8mmAiGMTaDD
	 9cIgOamE2C2wBXlhp7LWQBOMokQ47RQI3uWnfJA+AYpUD+Mpy2+VgAafj96rQ2T1Hi
	 jrVrTDLJFwsz7GICsy4b6w/LCnH+njOqg8vmOIYQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sanman Pradhan <psanman@juniper.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 6.1 328/969] hwmon: (ltc2992) Clamp threshold writes to hardware range
Date: Sat, 30 May 2026 17:57:32 +0200
Message-ID: <20260530160309.445519220@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257267-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A0ACD60F015
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sanman Pradhan <psanman@juniper.net>

commit d6cc7c99bf1f73eda7d565d224d791d16239bb41 upstream.

ltc2992_set_voltage(), ltc2992_set_current(), and ltc2992_set_power()
do not validate the user-supplied value before converting it to a
register value. This can result in:

1. Negative input values wrapping to large positive register values.
   For power, the negative long is implicitly cast to u64 in
   mul_u64_u32_div(), producing an incorrect value. For voltage and
   current, the negative converted value wraps when passed to
   ltc2992_write_reg() as a u32.

2. Intermediate arithmetic exceeding the range representable in u64 on
   64-bit platforms. In ltc2992_set_voltage(), (u64)val * 1000 can
   exceed U64_MAX when val is a large positive long. In
   ltc2992_set_current(), (u64)val * r_sense_uohm can overflow
   similarly. In ltc2992_set_power(), the computed value may not fit
   in u64.

3. Register values exceeding the hardware field width. Voltage and
   current threshold registers are 12-bit (stored left-justified in
   16 bits), and power threshold registers are 24-bit. Without
   clamping, bits above the field width are truncated in
   ltc2992_write_reg().

Fix by clamping negative values to zero, clamping positive values to
the rounded hardware-representable maximum (the value returned by the
read path for a full-scale register) to prevent intermediate overflow,
and clamping the converted register value to the hardware field width
before writing. The existing conversion formula and rounding behavior
are preserved.

In the power write path, cancel the factor of 1000 from both the
numerator (r_sense_uohm * 1000) and the denominator
(VADC_UV_LSB * IADC_NANOV_LSB) to also eliminate a u32 overflow of
r_sense_uohm * 1000 when r_sense_uohm exceeds about 4.29 ohms.

Fixes: b0bd407e94b03 ("hwmon: (ltc2992) Add support")
Cc: stable@vger.kernel.org
Signed-off-by: Sanman Pradhan <psanman@juniper.net>
Link: https://lore.kernel.org/r/20260416215904.101969-2-sanman.pradhan@hpe.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/ltc2992.c |   35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

--- a/drivers/hwmon/ltc2992.c
+++ b/drivers/hwmon/ltc2992.c
@@ -421,10 +421,16 @@ static int ltc2992_get_voltage(struct lt
 
 static int ltc2992_set_voltage(struct ltc2992_state *st, u32 reg, u32 scale, long val)
 {
-	val = DIV_ROUND_CLOSEST(val * 1000, scale);
-	val = val << 4;
+	u32 reg_val;
+	long vmax;
+
+	vmax = DIV_ROUND_CLOSEST_ULL(0xFFFULL * scale, 1000);
+	val = max(val, 0L);
+	val = min(val, vmax);
+	reg_val = min(DIV_ROUND_CLOSEST_ULL((u64)val * 1000, scale),
+		      0xFFFULL) << 4;
 
-	return ltc2992_write_reg(st, reg, 2, val);
+	return ltc2992_write_reg(st, reg, 2, reg_val);
 }
 
 static int ltc2992_read_gpio_alarm(struct ltc2992_state *st, int nr_gpio, u32 attr, long *val)
@@ -549,9 +555,15 @@ static int ltc2992_get_current(struct lt
 static int ltc2992_set_current(struct ltc2992_state *st, u32 reg, u32 channel, long val)
 {
 	u32 reg_val;
+	long cmax;
 
-	reg_val = DIV_ROUND_CLOSEST(val * st->r_sense_uohm[channel], LTC2992_IADC_NANOV_LSB);
-	reg_val = reg_val << 4;
+	cmax = DIV_ROUND_CLOSEST_ULL(0xFFFULL * LTC2992_IADC_NANOV_LSB,
+				     st->r_sense_uohm[channel]);
+	val = max(val, 0L);
+	val = min(val, cmax);
+	reg_val = min(DIV_ROUND_CLOSEST_ULL((u64)val * st->r_sense_uohm[channel],
+					    LTC2992_IADC_NANOV_LSB),
+		      0xFFFULL) << 4;
 
 	return ltc2992_write_reg(st, reg, 2, reg_val);
 }
@@ -624,9 +636,18 @@ static int ltc2992_get_power(struct ltc2
 static int ltc2992_set_power(struct ltc2992_state *st, u32 reg, u32 channel, long val)
 {
 	u32 reg_val;
+	u64 pmax, uval;
 
-	reg_val = mul_u64_u32_div(val, st->r_sense_uohm[channel] * 1000,
-				  LTC2992_VADC_UV_LSB * LTC2992_IADC_NANOV_LSB);
+	uval = max(val, 0L);
+	pmax = mul_u64_u32_div(0xFFFFFFULL,
+			       LTC2992_VADC_UV_LSB / 1000 *
+			       LTC2992_IADC_NANOV_LSB,
+			       st->r_sense_uohm[channel]);
+	uval = min(uval, pmax);
+	reg_val = min(mul_u64_u32_div(uval, st->r_sense_uohm[channel],
+				      LTC2992_VADC_UV_LSB / 1000 *
+				      LTC2992_IADC_NANOV_LSB),
+		      0xFFFFFFULL);
 
 	return ltc2992_write_reg(st, reg, 3, reg_val);
 }




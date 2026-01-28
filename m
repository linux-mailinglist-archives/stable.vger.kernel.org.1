Return-Path: <stable+bounces-212198-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHD1BEk2emnn4gEAu9opvQ
	(envelope-from <stable+bounces-212198-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:16:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F76A55B0
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B99F30DC794
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286342EA754;
	Wed, 28 Jan 2026 15:38:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDE02DE1E4
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614715; cv=none; b=MY1cUys5kMS7YcYFpcPQezFByvQ8HdU6IpVMf+orzOXaKed8WHJwvNg7HcBa/NHDhhL6LE8ShuoUomXfb107gbW+tf4gF4WXhe1jMlGB99mMUJV7GZbkQJD8Jvbw4t3nf1kHCYj/N1gsxXUnPfXylDCqQeRdp/WcElwCFwCRQLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614715; c=relaxed/simple;
	bh=RHOU9dUVe54OGDF08RNJXpmM7veA3wiGV0eWtzH1qJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rYRCSclPgFF/XdnJMQ6kSmqNTv08EjqX4425IcB0Wx6XYV4zgR3tWTH10yMlMVfk0NZYjEI30iUjz41YBdHy28nehNUODHtBif2c98Ex7Jq84+tP741cFwR16UwXFpGUMPJfyxH5axYphMDGzsHqd5UkV1ciLCqMBNghhtR2iIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vl7cg-0003op-Nh; Wed, 28 Jan 2026 16:38:26 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vl7cg-002wSK-2P;
	Wed, 28 Jan 2026 16:38:26 +0100
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vl7cf-0000000FR9k-4BYT;
	Wed, 28 Jan 2026 16:38:25 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	stable@vger.kernel.org,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: [PATCH v3 1/8] iio: dac: ds4424: fix -128 rejection and refactor raw access
Date: Wed, 28 Jan 2026 16:38:17 +0100
Message-ID: <20260128153824.3679187-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260128153824.3679187-1-o.rempel@pengutronix.de>
References: <20260128153824.3679187-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-212198-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	FROM_NEQ_ENVFROM(0.00)[o.rempel@pengutronix.de,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:mid,pengutronix.de:email]
X-Rspamd-Queue-Id: A2F76A55B0
X-Rspamd-Action: no action

The DS442x DAC uses sign-magnitude encoding, so -128 cannot be represented.
Previously, passing -128 resulted in a truncated value that programmed 0mA.

Fix this by validating the input against the 7-bit magnitude limit.
Additionally, refactor the raw access logic to use symmetrical bitwise
operations, replacing the union structure.

Fixes: d632a2bd8ffc ("iio: dac: ds4422/ds4424 dac driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v3:
- Remove "Rebase on top of regmap" note as this is now patch 1/8.
- Add #include <linux/bits.h>
- Clarify 0mA sink/source behavior in comments
- Remove redundant blank line in write_raw
changes v2:
- Replace S8_MIN/MAX checks with abs() > DS4424_DAC_MASK to enforce the
  correct [-127, 127] physical range.
- Refactor read_raw/write_raw to use symmetrical bitwise operations,
  removing the custom bitfield union.
- Rebase on top of regmap port
---
 drivers/iio/dac/ds4424.c | 55 +++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 34 deletions(-)

diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c
index a8198ba4f98a..596ff5999271 100644
--- a/drivers/iio/dac/ds4424.c
+++ b/drivers/iio/dac/ds4424.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2017 Maxim Integrated
  */
 
+#include <linux/bits.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/i2c.h>
@@ -19,9 +20,10 @@
 #define DS4422_MAX_DAC_CHANNELS		2
 #define DS4424_MAX_DAC_CHANNELS		4
 
+#define DS4424_DAC_MASK			GENMASK(6, 0)
+#define DS4424_DAC_SOURCE		BIT(7)
+
 #define DS4424_DAC_ADDR(chan)   ((chan) + 0xf8)
-#define DS4424_SOURCE_I		1
-#define DS4424_SINK_I		0
 
 #define DS4424_CHANNEL(chan) { \
 	.type = IIO_CURRENT, \
@@ -31,22 +33,6 @@
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
 }
 
-/*
- * DS4424 DAC control register 8 bits
- * [7]		0: to sink; 1: to source
- * [6:0]	steps to sink/source
- * bit[7] looks like a sign bit, but the value of the register is
- * not a two's complement code considering the bit[6:0] is a absolute
- * distance from the zero point.
- */
-union ds4424_raw_data {
-	struct {
-		u8 dx:7;
-		u8 source_bit:1;
-	};
-	u8 bits;
-};
-
 enum ds4424_device_ids {
 	ID_DS4422,
 	ID_DS4424,
@@ -108,21 +94,21 @@ static int ds4424_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2, long mask)
 {
-	union ds4424_raw_data raw;
-	int ret;
+	int ret, regval;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = ds4424_get_value(indio_dev, val, chan->channel);
+		ret = ds4424_get_value(indio_dev, &regval, chan->channel);
 		if (ret < 0) {
 			pr_err("%s : ds4424_get_value returned %d\n",
 							__func__, ret);
 			return ret;
 		}
-		raw.bits = *val;
-		*val = raw.dx;
-		if (raw.source_bit == DS4424_SINK_I)
+
+		*val = regval & DS4424_DAC_MASK;
+		if (!(regval & DS4424_DAC_SOURCE))
 			*val = -*val;
+
 		return IIO_VAL_INT;
 
 	default:
@@ -134,25 +120,26 @@ static int ds4424_write_raw(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan,
 			     int val, int val2, long mask)
 {
-	union ds4424_raw_data raw;
+	unsigned int abs_val;
 
 	if (val2 != 0)
 		return -EINVAL;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		if (val < S8_MIN || val > S8_MAX)
+		abs_val = abs(val);
+		if (abs_val > DS4424_DAC_MASK)
 			return -EINVAL;
 
-		if (val > 0) {
-			raw.source_bit = DS4424_SOURCE_I;
-			raw.dx = val;
-		} else {
-			raw.source_bit = DS4424_SINK_I;
-			raw.dx = -val;
-		}
+		/*
+		 * Currents exiting the IC (Source) are positive. 0 is a valid
+		 * value for no current flow; the direction bit (Source vs Sink)
+		 * is treated as don't-care by the hardware at 0.
+		 */
+		if (val > 0)
+			abs_val |= DS4424_DAC_SOURCE;
 
-		return ds4424_set_value(indio_dev, raw.bits, chan);
+		return ds4424_set_value(indio_dev, abs_val, chan);
 
 	default:
 		return -EINVAL;
-- 
2.47.3



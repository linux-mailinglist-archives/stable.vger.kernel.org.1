Return-Path: <stable+bounces-260570-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6WylBIfVIWqqPQEAu9opvQ
	(envelope-from <stable+bounces-260570-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 21:44:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8108B642FF4
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 21:44:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CfFod3C4;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260570-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260570-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2EFAC30156FD
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 19:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F973B635C;
	Thu,  4 Jun 2026 19:40:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24601374726
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 19:40:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780602022; cv=none; b=nVO5A3N57mXBnHm7ZyGJEG1ueOalheW6EMDS02M0w3U1xamDtZ1rLxv155Dzblmd2HFD7S8SSygckJZ2Lda0VoaYhJbuRxDkmQzAiPX8v4vP339O7v9ULfJKkvkC7QW2+cdH7gs1v52j6Em4xtT1yRSdd2aBRQK8lp85EDNtmKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780602022; c=relaxed/simple;
	bh=icIiErIbXwBk8a9LJi4OQeoBAcL2+6xcjLaF4XaSpZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nk26EWJMBlBuclN2Ov4+PnbYDnwr3uX066hIqL0yOcff10oJqsRCBPmzhfxfL+mZXAoIj5BHJ6ewVBVsBpaSnw+Q0SqfdPn/FgLEVqFp+m71OgsD9USF31GRzNqCMtKzIp6P09OHkQA0d42e9w0KyMYfHhQDguH8HL0u1lTf5Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfFod3C4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346E81F00893;
	Thu,  4 Jun 2026 19:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780602020;
	bh=1DOfbqcaZAQG835xNFqWJTzxly/2gbJt1Cp5/j2XxCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CfFod3C4oP8pnZnmq3CNOYfg/FPZpyb6IOdd+3WJbon3Y1RnfJX7pUbGk3gPnCzru
	 4hcmRrpaiMmTW5NRaQ3rKrkZ0kE7dtZ4YIewrWDeJPpZy2E9EgRahq6xXgcKGBFoQ+
	 jyaGw1N+TZCiDhMTgRdI+VHkJL2Hlt8adBGtyhsFACpcTJ6d4CCVNfgVUDmnOV+v0X
	 Rm4UmYeazQqO8Uw66avujo0a+w4Cxc8WFhZVPAlISIHwuRqfh0tCAhpF1zcEauacS4
	 jM0Xgke0ZtvcL8az1uF8lgbDTTDI/dJ+q7fGFgrFImfdbpf260L6p5WC77VqmdX7Vi
	 6aeQqWF9i3jDQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	David Lechner <dlechner@baylibre.com>,
	Tomasz Duszynski <tomasz.duszynski@octakon.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] iio: chemical: scd30: Use guard(mutex) to allow early returns
Date: Thu,  4 Jun 2026 15:40:16 -0400
Message-ID: <20260604194017.889785-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060457-coastal-washable-cab4@gregkh>
References: <2026060457-coastal-washable-cab4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260570-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:Jonathan.Cameron@huawei.com,m:dlechner@baylibre.com,m:tomasz.duszynski@octakon.com,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,baylibre.com:email,vger.kernel.org:from_smtp,octakon.com:email,huawei.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8108B642FF4

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

[ Upstream commit 5feb5532870fbced5d6f450b8061a33f461b88ca ]

Auto cleanup based release of the lock allows for simpler code flow in a
few functions with large multiplexing style switch statements and no
common operations following the switch.

Suggested-by: David Lechner <dlechner@baylibre.com>
Cc: Tomasz Duszynski <tomasz.duszynski@octakon.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Link: https://patch.msgid.link/20250209180624.701140-3-jic23@kernel.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: 5aba4f94b225 ("iio: chemical: scd30: fix division by zero in write_raw")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/chemical/scd30_core.c | 63 ++++++++++++++-----------------
 1 file changed, 28 insertions(+), 35 deletions(-)

diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index 9fe6bbe9ee041b..a0a1f89deba913 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2020 Tomasz Duszynski <tomasz.duszynski@octakon.com>
  */
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -198,112 +199,104 @@ static int scd30_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const
 			  int *val, int *val2, long mask)
 {
 	struct scd30_state *state = iio_priv(indio_dev);
-	int ret = -EINVAL;
+	int ret;
 	u16 tmp;
 
-	mutex_lock(&state->lock);
+	guard(mutex)(&state->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 	case IIO_CHAN_INFO_PROCESSED:
 		if (chan->output) {
 			*val = state->pressure_comp;
-			ret = IIO_VAL_INT;
-			break;
+			return IIO_VAL_INT;
 		}
 
 		ret = iio_device_claim_direct_mode(indio_dev);
 		if (ret)
-			break;
+			return ret;
 
 		ret = scd30_read(state);
 		if (ret) {
 			iio_device_release_direct_mode(indio_dev);
-			break;
+			return ret;
 		}
 
 		*val = state->meas[chan->address];
 		iio_device_release_direct_mode(indio_dev);
-		ret = IIO_VAL_INT;
-		break;
+		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
 		*val2 = 1;
-		ret = IIO_VAL_INT_PLUS_MICRO;
-		break;
+		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		ret = scd30_command_read(state, CMD_MEAS_INTERVAL, &tmp);
 		if (ret)
-			break;
+			return ret;
 
 		*val = 0;
 		*val2 = 1000000000 / tmp;
-		ret = IIO_VAL_INT_PLUS_NANO;
-		break;
+		return IIO_VAL_INT_PLUS_NANO;
 	case IIO_CHAN_INFO_CALIBBIAS:
 		ret = scd30_command_read(state, CMD_TEMP_OFFSET, &tmp);
 		if (ret)
-			break;
+			return ret;
 
 		*val = tmp;
-		ret = IIO_VAL_INT;
-		break;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
 	}
-	mutex_unlock(&state->lock);
-
-	return ret;
 }
 
 static int scd30_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
 			   int val, int val2, long mask)
 {
 	struct scd30_state *state = iio_priv(indio_dev);
-	int ret = -EINVAL;
+	int ret;
 
-	mutex_lock(&state->lock);
+	guard(mutex)(&state->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		if (val)
-			break;
+			return -EINVAL;
 
 		val = 1000000000 / val2;
 		if (val < SCD30_MEAS_INTERVAL_MIN_S || val > SCD30_MEAS_INTERVAL_MAX_S)
-			break;
+			return -EINVAL;
 
 		ret = scd30_command_write(state, CMD_MEAS_INTERVAL, val);
 		if (ret)
-			break;
+			return ret;
 
 		state->meas_interval = val;
-		break;
+		return 0;
 	case IIO_CHAN_INFO_RAW:
 		switch (chan->type) {
 		case IIO_PRESSURE:
 			if (val < SCD30_PRESSURE_COMP_MIN_MBAR ||
 			    val > SCD30_PRESSURE_COMP_MAX_MBAR)
-				break;
+				return -EINVAL;
 
 			ret = scd30_command_write(state, CMD_START_MEAS, val);
 			if (ret)
-				break;
+				return ret;
 
 			state->pressure_comp = val;
-			break;
+			return 0;
 		default:
-			break;
+			return -EINVAL;
 		}
-		break;
 	case IIO_CHAN_INFO_CALIBBIAS:
 		if (val < 0 || val > SCD30_TEMP_OFFSET_MAX)
-			break;
+			return -EINVAL;
 		/*
 		 * Manufacturer does not explicitly specify min/max sensible
 		 * values hence check is omitted for simplicity.
 		 */
-		ret = scd30_command_write(state, CMD_TEMP_OFFSET / 10, val);
+		return scd30_command_write(state, CMD_TEMP_OFFSET / 10, val);
+	default:
+		return -EINVAL;
 	}
-	mutex_unlock(&state->lock);
-
-	return ret;
 }
 
 static int scd30_write_raw_get_fmt(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
-- 
2.53.0



Return-Path: <stable+bounces-227365-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DewC0xCvGlHwAIAu9opvQ
	(envelope-from <stable+bounces-227365-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 19:37:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 841122D11FF
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 19:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC813303EC39
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 18:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C888630B53F;
	Thu, 19 Mar 2026 18:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3YITBUe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE612ECEA0
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 18:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773945281; cv=none; b=NTqYr14+XMWWjXM4is1wESIt6TCesbbDH17zHT103tqr+G33My9g/cqGj4rGPXDIMVxVI7CfnRHotBiLXwLhlrN2owiMsfNeEqounOkPTUouzg0hxsnb7cOVz3ZUcbvaaLirA+hWclUR9Zwtqhct359VOfdZAum3WFzxOk9X9ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773945281; c=relaxed/simple;
	bh=uHLzCrNV98T2wg0l1wFvnZ/sd9adxkeUWIlvrpkQq+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KIqfoDKoybZsxpt4hukLWJqVUkPKsAjnPiST/S0e6+n/zlvzrouGUyYgR1TBVsWoWJanQoPBGlmTznyoxnbmpBjtMU8TR5VNbnyg2Rn/M7P1wHA0sWS/U7Lx0IVWmFOuzHhPv95feHGwFwEQZMsSwliCyKYdROd3N4FG3Xu6Kt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3YITBUe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5F8C19424;
	Thu, 19 Mar 2026 18:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773945281;
	bh=uHLzCrNV98T2wg0l1wFvnZ/sd9adxkeUWIlvrpkQq+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i3YITBUeq/GuZb56JeZkVIgGKZ/Bk8oMoI16D7HSgi+BFXstNs5NHQOgVaevPysNV
	 Sp+FyzbDX01c0lCHofTPKKqbULnBOQ7Dw1UXC5+xvl4+NARShiyP7OMgbYCTSzXHHO
	 B8u7SepYgJekRYoeqi9OtFPGGChe+sZxy3l+a4uqR4WDsUCdzU36rgc3iz60XUu8Pq
	 liJ+0rEQJMYV9o6RohTuhyoGZKKX5FhUAvbY7PWFYJ7J0VaVTmNrdC2+3Q5qPfP0mv
	 7gSWYZbBHjl1xK+3pf5uPxugRXCXzWDCwHugdIlimgVn+kWbt8j/gztP4MKTI73qob
	 qqn7RGVgBuXHQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] iio: light: Remove redundant pm_runtime_mark_last_busy() calls
Date: Thu, 19 Mar 2026 14:34:37 -0400
Message-ID: <20260319183438.2928887-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031706-gentile-unbalance-017b@gregkh>
References: <2026031706-gentile-unbalance-017b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227365-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.974];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,intel.com:email,huawei.com:email]
X-Rspamd-Queue-Id: 841122D11FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sakari Ailus <sakari.ailus@linux.intel.com>

[ Upstream commit e15f23dd5305d123b571aeee56415d9e90f06ca4 ]

pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
pm_runtime_mark_last_busy().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://patch.msgid.link/20250825135401.1765847-9-sakari.ailus@linux.intel.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: dd72e6c3cdea ("iio: light: bh1780: fix PM runtime leak on error path")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/light/apds9306.c   |  2 --
 drivers/iio/light/apds9960.c   |  1 -
 drivers/iio/light/bh1780.c     |  1 -
 drivers/iio/light/gp2ap002.c   |  2 --
 drivers/iio/light/isl29028.c   | 11 +++--------
 drivers/iio/light/ltrf216a.c   |  1 -
 drivers/iio/light/pa12203001.c | 11 +++--------
 drivers/iio/light/rpr0521.c    |  6 ++----
 drivers/iio/light/tsl2583.c    | 12 +++---------
 drivers/iio/light/tsl2591.c    |  2 --
 drivers/iio/light/us5182d.c    | 12 +++---------
 drivers/iio/light/vcnl4000.c   | 11 +++--------
 drivers/iio/light/vcnl4035.c   | 11 +++--------
 13 files changed, 20 insertions(+), 63 deletions(-)

diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
index 7f9d6cac8adb7..d99e2d6265357 100644
--- a/drivers/iio/light/apds9306.c
+++ b/drivers/iio/light/apds9306.c
@@ -537,7 +537,6 @@ static int apds9306_read_data(struct apds9306_data *data, int *val, int reg)
 
 	*val = get_unaligned_le24(&buff);
 
-	pm_runtime_mark_last_busy(data->dev);
 	pm_runtime_put_autosuspend(data->dev);
 
 	return 0;
@@ -1118,7 +1117,6 @@ static int apds9306_write_event_config(struct iio_dev *indio_dev,
 			if (ret)
 				return ret;
 
-			pm_runtime_mark_last_busy(data->dev);
 			pm_runtime_put_autosuspend(data->dev);
 
 			return 0;
diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
index 3c14e4c30805e..55bc3d14c66a2 100644
--- a/drivers/iio/light/apds9960.c
+++ b/drivers/iio/light/apds9960.c
@@ -496,7 +496,6 @@ static int apds9960_set_power_state(struct apds9960_data *data, bool on)
 			usleep_range(data->als_adc_int_us,
 				     APDS9960_MAX_INT_TIME_IN_US);
 	} else {
-		pm_runtime_mark_last_busy(dev);
 		ret = pm_runtime_put_autosuspend(dev);
 	}
 
diff --git a/drivers/iio/light/bh1780.c b/drivers/iio/light/bh1780.c
index 475f44954f611..604eeb48ebc48 100644
--- a/drivers/iio/light/bh1780.c
+++ b/drivers/iio/light/bh1780.c
@@ -111,7 +111,6 @@ static int bh1780_read_raw(struct iio_dev *indio_dev,
 			value = bh1780_read_word(bh1780, BH1780_REG_DLOW);
 			if (value < 0)
 				return value;
-			pm_runtime_mark_last_busy(&bh1780->client->dev);
 			pm_runtime_put_autosuspend(&bh1780->client->dev);
 			*val = value;
 
diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
index f8b1d7dd6f5fc..adf8f1d4eb07a 100644
--- a/drivers/iio/light/gp2ap002.c
+++ b/drivers/iio/light/gp2ap002.c
@@ -271,7 +271,6 @@ static int gp2ap002_read_raw(struct iio_dev *indio_dev,
 	}
 
 out:
-	pm_runtime_mark_last_busy(gp2ap002->dev);
 	pm_runtime_put_autosuspend(gp2ap002->dev);
 
 	return ret;
@@ -353,7 +352,6 @@ static int gp2ap002_write_event_config(struct iio_dev *indio_dev,
 		pm_runtime_get_sync(gp2ap002->dev);
 		gp2ap002->enabled = true;
 	} else {
-		pm_runtime_mark_last_busy(gp2ap002->dev);
 		pm_runtime_put_autosuspend(gp2ap002->dev);
 		gp2ap002->enabled = false;
 	}
diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
index 95bfb3ffa519a..5695552341d84 100644
--- a/drivers/iio/light/isl29028.c
+++ b/drivers/iio/light/isl29028.c
@@ -336,16 +336,11 @@ static int isl29028_ir_get(struct isl29028_chip *chip, int *ir_data)
 static int isl29028_set_pm_runtime_busy(struct isl29028_chip *chip, bool on)
 {
 	struct device *dev = regmap_get_device(chip->regmap);
-	int ret;
 
-	if (on) {
-		ret = pm_runtime_resume_and_get(dev);
-	} else {
-		pm_runtime_mark_last_busy(dev);
-		ret = pm_runtime_put_autosuspend(dev);
-	}
+	if (on)
+		return pm_runtime_resume_and_get(dev);
 
-	return ret;
+	return pm_runtime_put_autosuspend(dev);
 }
 
 /* Channel IO */
diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
index 37eecff571b96..8c4f8017630e2 100644
--- a/drivers/iio/light/ltrf216a.c
+++ b/drivers/iio/light/ltrf216a.c
@@ -208,7 +208,6 @@ static int ltrf216a_set_power_state(struct ltrf216a_data *data, bool on)
 			return ret;
 		}
 	} else {
-		pm_runtime_mark_last_busy(dev);
 		pm_runtime_put_autosuspend(dev);
 	}
 
diff --git a/drivers/iio/light/pa12203001.c b/drivers/iio/light/pa12203001.c
index b920bf82c1021..68802d714a848 100644
--- a/drivers/iio/light/pa12203001.c
+++ b/drivers/iio/light/pa12203001.c
@@ -185,15 +185,10 @@ static int pa12203001_set_power_state(struct pa12203001_data *data, bool on,
 		mutex_unlock(&data->lock);
 	}
 
-	if (on) {
-		ret = pm_runtime_resume_and_get(&data->client->dev);
+	if (on)
+		return pm_runtime_resume_and_get(&data->client->dev);
 
-	} else {
-		pm_runtime_mark_last_busy(&data->client->dev);
-		ret = pm_runtime_put_autosuspend(&data->client->dev);
-	}
-
-	return ret;
+	return pm_runtime_put_autosuspend(&data->client->dev);
 
 err:
 	mutex_unlock(&data->lock);
diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index 0a5408c12cc0e..69f55bae4d4bb 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -359,12 +359,10 @@ static int rpr0521_set_power_state(struct rpr0521_data *data, bool on,
 	 * Note: If either measurement is re-enabled before _suspend(),
 	 * both stay enabled until _suspend().
 	 */
-	if (on) {
+	if (on)
 		ret = pm_runtime_resume_and_get(&data->client->dev);
-	} else {
-		pm_runtime_mark_last_busy(&data->client->dev);
+	else
 		ret = pm_runtime_put_autosuspend(&data->client->dev);
-	}
 	if (ret < 0) {
 		dev_err(&data->client->dev,
 			"Failed: rpr0521_set_power_state for %d, ret %d\n",
diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
index 02ad11611b9c5..0cad4a62a16a2 100644
--- a/drivers/iio/light/tsl2583.c
+++ b/drivers/iio/light/tsl2583.c
@@ -641,16 +641,10 @@ static const struct iio_chan_spec tsl2583_channels[] = {
 
 static int tsl2583_set_pm_runtime_busy(struct tsl2583_chip *chip, bool on)
 {
-	int ret;
+	if (on)
+		return pm_runtime_resume_and_get(&chip->client->dev);
 
-	if (on) {
-		ret = pm_runtime_resume_and_get(&chip->client->dev);
-	} else {
-		pm_runtime_mark_last_busy(&chip->client->dev);
-		ret = pm_runtime_put_autosuspend(&chip->client->dev);
-	}
-
-	return ret;
+	return pm_runtime_put_autosuspend(&chip->client->dev);
 }
 
 static int tsl2583_read_raw(struct iio_dev *indio_dev,
diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
index 850c2465992fa..bae39246cca98 100644
--- a/drivers/iio/light/tsl2591.c
+++ b/drivers/iio/light/tsl2591.c
@@ -772,7 +772,6 @@ static int tsl2591_read_raw(struct iio_dev *indio_dev,
 err_unlock:
 	mutex_unlock(&chip->als_mutex);
 
-	pm_runtime_mark_last_busy(&client->dev);
 	pm_runtime_put_autosuspend(&client->dev);
 
 	return ret;
@@ -995,7 +994,6 @@ static int tsl2591_write_event_config(struct iio_dev *indio_dev,
 		pm_runtime_get_sync(&client->dev);
 	} else if (!state && chip->events_enabled) {
 		chip->events_enabled = false;
-		pm_runtime_mark_last_busy(&client->dev);
 		pm_runtime_put_autosuspend(&client->dev);
 	}
 
diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
index de6967ac3b0b3..0dd4d14664a59 100644
--- a/drivers/iio/light/us5182d.c
+++ b/drivers/iio/light/us5182d.c
@@ -361,19 +361,13 @@ static int us5182d_shutdown_en(struct us5182d_data *data, u8 state)
 
 static int us5182d_set_power_state(struct us5182d_data *data, bool on)
 {
-	int ret;
-
 	if (data->power_mode == US5182D_ONESHOT)
 		return 0;
 
-	if (on) {
-		ret = pm_runtime_resume_and_get(&data->client->dev);
-	} else {
-		pm_runtime_mark_last_busy(&data->client->dev);
-		ret = pm_runtime_put_autosuspend(&data->client->dev);
-	}
+	if (on)
+		return pm_runtime_resume_and_get(&data->client->dev);
 
-	return ret;
+	return pm_runtime_put_autosuspend(&data->client->dev);
 }
 
 static int us5182d_read_value(struct us5182d_data *data,
diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 4e3641ff2ed44..88fcca676bf3a 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -576,16 +576,11 @@ static bool vcnl4010_is_in_periodic_mode(struct vcnl4000_data *data)
 static int vcnl4000_set_pm_runtime_state(struct vcnl4000_data *data, bool on)
 {
 	struct device *dev = &data->client->dev;
-	int ret;
 
-	if (on) {
-		ret = pm_runtime_resume_and_get(dev);
-	} else {
-		pm_runtime_mark_last_busy(dev);
-		ret = pm_runtime_put_autosuspend(dev);
-	}
+	if (on)
+		return pm_runtime_resume_and_get(dev);
 
-	return ret;
+	return pm_runtime_put_autosuspend(dev);
 }
 
 static int vcnl4040_read_als_it(struct vcnl4000_data *data, int *val, int *val2)
diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
index 67c94be020189..599e8ff8307de 100644
--- a/drivers/iio/light/vcnl4035.c
+++ b/drivers/iio/light/vcnl4035.c
@@ -143,17 +143,12 @@ static const struct iio_trigger_ops vcnl4035_trigger_ops = {
 
 static int vcnl4035_set_pm_runtime_state(struct vcnl4035_data *data, bool on)
 {
-	int ret;
 	struct device *dev = &data->client->dev;
 
-	if (on) {
-		ret = pm_runtime_resume_and_get(dev);
-	} else {
-		pm_runtime_mark_last_busy(dev);
-		ret = pm_runtime_put_autosuspend(dev);
-	}
+	if (on)
+		return pm_runtime_resume_and_get(dev);
 
-	return ret;
+	return pm_runtime_put_autosuspend(dev);
 }
 
 /*
-- 
2.51.0



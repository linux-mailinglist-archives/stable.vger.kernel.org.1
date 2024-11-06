Return-Path: <stable+bounces-91086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 611F29BEC5F
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 932AF1C23AA6
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018071FBCB9;
	Wed,  6 Nov 2024 12:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WsmYxS61"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B225A1FBCAE;
	Wed,  6 Nov 2024 12:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730897699; cv=none; b=atDalmZGKGbLETzsOtD9MWTApu6LZoKAgQDh+0kypYMmy15BHVJvXwOFEc7cWdj3JKJc4rbGpUg4nW0wI0+mZh6BhCjsRaz6xZu9WFB46Go766eiG4LSfkERK+Kd3TtfoI3W9V26EWWtuwECo5ZHTVJW7Jvt/t+ZyVXZW4E3ZdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730897699; c=relaxed/simple;
	bh=3cm+Va+MyqIZyZdhfuUf4bH066YPiaiNSI4czWicQWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RHAybjrhHqIs9U9YBMuHYSEBPvPADwxI9EeQCxYAXxf1WcxkBcWG0Mm08LB2ltB3d1WaQCshDxXjgcuXBlL3jVfKi/UjF/BqYBav6GXsMkYuNmEnyVEkfeExgfhPZUOmFImCjSEa3qK9VdqdZN5b5XFrSZyXJouNObGlsZpFMp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WsmYxS61; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B15C4CECD;
	Wed,  6 Nov 2024 12:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730897699;
	bh=3cm+Va+MyqIZyZdhfuUf4bH066YPiaiNSI4czWicQWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WsmYxS61s8xQSyyZx6eNX/cKLjYYbZ/oEUsnOfQYSQ+reHRPwaPPom4fT3lBGyEyd
	 U0x97Yo8sarkEeezQY4ivEl55+4ukybpUrLOvVe0NBWlSF2Ln/bfIjuSfty+w1kSox
	 sCEZFS/Wzc+KkYKB32Q1qv8SoRKl/b8aDq1bbrwk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Li Zetao <lizetao1@huawei.com>,
	Oliver Graute <oliver.graute@kococonnector.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 114/151] Input: edt-ft5x06 - fix regmap leak when probe fails
Date: Wed,  6 Nov 2024 13:05:02 +0100
Message-ID: <20241106120312.005175424@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120308.841299741@linuxfoundation.org>
References: <20241106120308.841299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit bffdf9d7e51a7be8eeaac2ccf9e54a5fde01ff65 ]

The driver neglects to free the instance of I2C regmap constructed at
the beginning of the edt_ft5x06_ts_probe() method when probe fails.
Additionally edt_ft5x06_ts_remove() is freeing the regmap too early,
before the rest of the device resources that are managed by devm are
released.

Fix this by installing a custom devm action that will ensure that the
regmap is released at the right time during normal teardown as well as
in case of probe failure.

Note that devm_regmap_init_i2c() could not be used because the driver
may replace the original regmap with a regmap specific for M06 devices
in the middle of the probe, and using devm_regmap_init_i2c() would
result in releasing the M06 regmap too early.

Reported-by: Li Zetao <lizetao1@huawei.com>
Fixes: 9dfd9708ffba ("Input: edt-ft5x06 - convert to use regmap API")
Cc: stable@vger.kernel.org
Reviewed-by: Oliver Graute <oliver.graute@kococonnector.com>
Link: https://lore.kernel.org/r/ZxL6rIlVlgsAu-Jv@google.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/touchscreen/edt-ft5x06.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 457d53337fbb3..a365577a19945 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -1124,6 +1124,14 @@ static void edt_ft5x06_ts_set_regs(struct edt_ft5x06_ts_data *tsdata)
 	}
 }
 
+static void edt_ft5x06_exit_regmap(void *arg)
+{
+	struct edt_ft5x06_ts_data *data = arg;
+
+	if (!IS_ERR_OR_NULL(data->regmap))
+		regmap_exit(data->regmap);
+}
+
 static void edt_ft5x06_disable_regulators(void *arg)
 {
 	struct edt_ft5x06_ts_data *data = arg;
@@ -1157,6 +1165,16 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client)
 		return PTR_ERR(tsdata->regmap);
 	}
 
+	/*
+	 * We are not using devm_regmap_init_i2c() and instead install a
+	 * custom action because we may replace regmap with M06-specific one
+	 * and we need to make sure that it will not be released too early.
+	 */
+	error = devm_add_action_or_reset(&client->dev, edt_ft5x06_exit_regmap,
+					 tsdata);
+	if (error)
+		return error;
+
 	chip_data = device_get_match_data(&client->dev);
 	if (!chip_data)
 		chip_data = (const struct edt_i2c_chip_data *)id->driver_data;
@@ -1354,7 +1372,6 @@ static void edt_ft5x06_ts_remove(struct i2c_client *client)
 	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(client);
 
 	edt_ft5x06_ts_teardown_debugfs(tsdata);
-	regmap_exit(tsdata->regmap);
 }
 
 static int edt_ft5x06_ts_suspend(struct device *dev)
-- 
2.43.0





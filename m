Return-Path: <stable+bounces-163574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED32B0C3A4
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 13:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74F573AD21F
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 11:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609EA2C326E;
	Mon, 21 Jul 2025 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="PD6GxXRf"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5C52C08C5
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 11:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753098571; cv=none; b=e8yq4vLALEJObuwTSmcya4o/8t2HoueUt7MHD1xi8NUPa9CEctMH5soob26KSkODxjYzKNGysrjju6CsCXnWcXDMoU1DES8qMaJLN9qmswhqnJVq1ouJGHZ54YKJ0f63b+Z4cUlZ3Mg6JekL9W6xX/JJjLWck4AFc/GES4NkmRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753098571; c=relaxed/simple;
	bh=26Vi0tVxcswoLW7/C45kh/1CsdMwFo1iIAVi2uk/bSw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nsR1pbcYxsBf23zF5/277DOcZY2gq8CXCiCRDLd8DwOeQgZexr8prp7GigQFwoXmvRgiMLNx2OIQKev+aqMWw3SLLncQL1RUBnj8RacC9H3UoIb3/kOtgOVo5hsTJB3N/E9/oZcpWpeYIFOKK37DwREt70yu8YnjnIupYZqLPnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=PD6GxXRf; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7493d4e0d01so164104b3a.1
        for <stable@vger.kernel.org>; Mon, 21 Jul 2025 04:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1753098568; x=1753703368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMHN4pL/heYdhV9cpldNIeULzRjuRe5A91AClaLz19E=;
        b=PD6GxXRfeUD3H3BDjmad9z7oWbIpPcX1ToDzDtgxYSDUaGfvGD10DN6ai1t2Bdk/Am
         +l0JYdnhsXZaHtbl3PM8fz2kI9ZqFX3mmK92skh3+qXQCqtDSZU+nEvOVQFnMR9opdDU
         zIctGu6wkMxxbAvIQoUyCetaFd3r8E/9XP3Fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753098568; x=1753703368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mMHN4pL/heYdhV9cpldNIeULzRjuRe5A91AClaLz19E=;
        b=FsCoMPk+1pxUpUmZjXRVoFqJvNqUT+8D8sh+Fa465fdguaVnGvCbV/b43LtY8XUq9Y
         WOhxpWEB0auNGHVzxHW4xc8diwO4g54zFx/z02XjNe3ZFGGbWjnVIde5QAEqCPsHRWDr
         09wm5nyhWOOhJttjpTrBUwiSow0P8TjaaM/qfnk9sE6yFWz0W8t9jGqS/rj5GzTF8XKx
         jmAL8ONnw+N4Q3nfm3wz/uv5I1YjlGCx99yZ7gCPFdmztcVu1yPfL3KN5ULtVV6pYXP6
         LcACRqz263OfTem0zV/35bvo1PFOAJP3ItIADTsRkTNXikdE/goYrZYt1BmXmQr194jU
         d3iQ==
X-Gm-Message-State: AOJu0YzXl9eSkcEUKK31DMdDik27c6/0bsVEo4f93xrwOWd/E4lQqPif
	Wk+Y08/zt70BYd2A515WXF5Dp+nfD61VPLMLtUnPtueSpRPSUx7Bh8coVynaHYzx/bMFFB3zHAY
	33dcTGjQ=
X-Gm-Gg: ASbGncupqMA8idYNGFmRUYuym4dmMkvBUNiuFTCwWcxq7MJb25UMG2S43sqvxjjT9Tx
	9GMzslKG1c97M9Nph3UqcLuVzrlU2TzNCzz+xAnzKEtgJDzOpqwWRpLgUtRLe/QLRzoFCYRzK7M
	a7g6siKfS5JRR2qp4CEc8w3PMV3OtKN6AMxh3EKVytg0oBYiWYl2YQSZzneVjc6W6jRjL+SBvBu
	YObSA/BQ0FO7fRdjXqVPo05U0mzAa/4cdBqAPwUBJiCKlht0NxsG8XSy8vyI/700DjMJlMYH9GC
	qP9BXpKNcaGMUjK84p0A/9sf097ldAsZPI1A3cL1Hwl8Y1+f//j2AavFcoeo/J/Nu04eGB/jbMS
	s0Cv4ucS5Dm2tl4a44z+MdgDTiEB4ZmyRYw==
X-Google-Smtp-Source: AGHT+IELjcDQbgdIyG10eniJYDRD1u+0prgfXSA9QZ5WSnomSRHV8HbteUbN8VzOlR+IBjhKJC9zTQ==
X-Received: by 2002:a05:6a00:6807:b0:748:3089:5265 with SMTP id d2e1a72fcca58-756eb0972d0mr8184364b3a.5.1753098568370;
        Mon, 21 Jul 2025 04:49:28 -0700 (PDT)
Received: from shubhamPC.mvista.com ([182.74.28.237])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb76d5d8sm5572140b3a.112.2025.07.21.04.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 04:49:28 -0700 (PDT)
From: skulkarni@mvista.com
To: stable@vger.kernel.org
Cc: Minghao Chi <chi.minghao@zte.com.cn>,
	Zeal Robot <zealci@zte.com.cn>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Shubham Kulkarni <skulkarni@mvista.com>
Subject: [PATCH 5.4.y 2/3] power: supply: bq24190_charger: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date: Mon, 21 Jul 2025 17:18:45 +0530
Message-Id: <20250721114846.1360952-3-skulkarni@mvista.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250721114846.1360952-1-skulkarni@mvista.com>
References: <20250721114846.1360952-1-skulkarni@mvista.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Minghao Chi <chi.minghao@zte.com.cn>

[ Upstream commit d96a89407e5f682d1cb22569d91784506c784863 ]

Using pm_runtime_resume_and_get is more appropriate
for simplifing code

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
[ skulkarni: Minor changes in hunk #3/12 wrt the mainline commit ]
Stable-dep-of: 47c29d692129 ("power: supply: bq24190: Fix use after free bug in bq24190_remove due to race condition")
Signed-off-by: Shubham Kulkarni <skulkarni@mvista.com>
---
 drivers/power/supply/bq24190_charger.c | 63 +++++++++-----------------
 1 file changed, 21 insertions(+), 42 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 446b6f13dc8a..0107b43ff554 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -448,11 +448,9 @@ static ssize_t bq24190_sysfs_show(struct device *dev,
 	if (!info)
 		return -EINVAL;
 
-	ret = pm_runtime_get_sync(bdi->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(bdi->dev);
+	ret = pm_runtime_resume_and_get(bdi->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = bq24190_read_mask(bdi, info->reg, info->mask, info->shift, &v);
 	if (ret)
@@ -483,11 +481,9 @@ static ssize_t bq24190_sysfs_store(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	ret = pm_runtime_get_sync(bdi->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(bdi->dev);
+	ret = pm_runtime_resume_and_get(bdi->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = bq24190_write_mask(bdi, info->reg, info->mask, info->shift, v);
 	if (ret)
@@ -506,10 +502,9 @@ static int bq24190_set_charge_mode(struct regulator_dev *dev, u8 val)
 	struct bq24190_dev_info *bdi = rdev_get_drvdata(dev);
 	int ret;
 
-	ret = pm_runtime_get_sync(bdi->dev);
+	ret = pm_runtime_resume_and_get(bdi->dev);
 	if (ret < 0) {
 		dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", ret);
-		pm_runtime_put_noidle(bdi->dev);
 		return ret;
 	}
 
@@ -539,10 +534,9 @@ static int bq24190_vbus_is_enabled(struct regulator_dev *dev)
 	int ret;
 	u8 val;
 
-	ret = pm_runtime_get_sync(bdi->dev);
+	ret = pm_runtime_resume_and_get(bdi->dev);
 	if (ret < 0) {
 		dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", ret);
-		pm_runtime_put_noidle(bdi->dev);
 		return ret;
 	}
 
@@ -1083,11 +1077,9 @@ static int bq24190_charger_get_property(struct power_supply *psy,
 
 	dev_dbg(bdi->dev, "prop: %d\n", psp);
 
-	ret = pm_runtime_get_sync(bdi->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(bdi->dev);
+	ret = pm_runtime_resume_and_get(bdi->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_CHARGE_TYPE:
@@ -1157,11 +1149,9 @@ static int bq24190_charger_set_property(struct power_supply *psy,
 
 	dev_dbg(bdi->dev, "prop: %d\n", psp);
 
-	ret = pm_runtime_get_sync(bdi->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(bdi->dev);
+	ret = pm_runtime_resume_and_get(bdi->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_ONLINE:
@@ -1431,11 +1421,9 @@ static int bq24190_battery_get_property(struct power_supply *psy,
 	dev_warn(bdi->dev, "warning: /sys/class/power_supply/bq24190-battery is deprecated\n");
 	dev_dbg(bdi->dev, "prop: %d\n", psp);
 
-	ret = pm_runtime_get_sync(bdi->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(bdi->dev);
+	ret = pm_runtime_resume_and_get(bdi->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
@@ -1479,11 +1467,9 @@ static int bq24190_battery_set_property(struct power_supply *psy,
 	dev_warn(bdi->dev, "warning: /sys/class/power_supply/bq24190-battery is deprecated\n");
 	dev_dbg(bdi->dev, "prop: %d\n", psp);
 
-	ret = pm_runtime_get_sync(bdi->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(bdi->dev);
+	ret = pm_runtime_resume_and_get(bdi->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_ONLINE:
@@ -1637,10 +1623,9 @@ static irqreturn_t bq24190_irq_handler_thread(int irq, void *data)
 	int error;
 
 	bdi->irq_event = true;
-	error = pm_runtime_get_sync(bdi->dev);
+	error = pm_runtime_resume_and_get(bdi->dev);
 	if (error < 0) {
 		dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", error);
-		pm_runtime_put_noidle(bdi->dev);
 		return IRQ_NONE;
 	}
 	bq24190_check_status(bdi);
@@ -1860,11 +1845,9 @@ static int bq24190_remove(struct i2c_client *client)
 	struct bq24190_dev_info *bdi = i2c_get_clientdata(client);
 	int error;
 
-	error = pm_runtime_get_sync(bdi->dev);
-	if (error < 0) {
+	error = pm_runtime_resume_and_get(bdi->dev);
+	if (error < 0)
 		dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", error);
-		pm_runtime_put_noidle(bdi->dev);
-	}
 
 	bq24190_register_reset(bdi);
 	if (bdi->battery)
@@ -1913,11 +1896,9 @@ static __maybe_unused int bq24190_pm_suspend(struct device *dev)
 	struct bq24190_dev_info *bdi = i2c_get_clientdata(client);
 	int error;
 
-	error = pm_runtime_get_sync(bdi->dev);
-	if (error < 0) {
+	error = pm_runtime_resume_and_get(bdi->dev);
+	if (error < 0)
 		dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", error);
-		pm_runtime_put_noidle(bdi->dev);
-	}
 
 	bq24190_register_reset(bdi);
 
@@ -1938,11 +1919,9 @@ static __maybe_unused int bq24190_pm_resume(struct device *dev)
 	bdi->f_reg = 0;
 	bdi->ss_reg = BQ24190_REG_SS_VBUS_STAT_MASK; /* impossible state */
 
-	error = pm_runtime_get_sync(bdi->dev);
-	if (error < 0) {
+	error = pm_runtime_resume_and_get(bdi->dev);
+	if (error < 0)
 		dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", error);
-		pm_runtime_put_noidle(bdi->dev);
-	}
 
 	bq24190_register_reset(bdi);
 	bq24190_set_config(bdi);
-- 
2.25.1



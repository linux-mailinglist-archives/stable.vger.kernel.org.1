Return-Path: <stable+bounces-197585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DB1C9200B
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 13:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F389B34B0C7
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 12:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7834632AAD2;
	Fri, 28 Nov 2025 12:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfULMyxG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E3930FF39
	for <stable@vger.kernel.org>; Fri, 28 Nov 2025 12:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764333535; cv=none; b=koF/HGXbuXDRP8I+lAHB/koJpSPKkASo28ei2aHNUSQIqjG6sHH0D0r8Cu67hfTmAUKvyQlI7JFmXlFF48P3JtV1N6ey7BVh1F/adZJFVQ7bCRj0j8G1s93c3jDqx15HDBpum5zy+//+j80HrF7WohcPnWpS1oRMgaQNkBtMG/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764333535; c=relaxed/simple;
	bh=/oucUdI4s6hMDaFfL69cWC2kmdkZHo8+wo/d7zs3NQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=epw18pyQ6237ETmoR1BKVUO70vU/YrZukqMkLb+Y7WQ6lqrDnAa4wXnehVe/3bZkAOqdbv1+/DZ2euoKcvGy6wUfy/cwlr5NIx+xYXM4q1QpS2NwbNjvzjiK0UpYNZOLqSttkXgojmOUCtL6WHSvRtgh3iYUYCiep4XBGzGtqNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfULMyxG; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7bc248dc16aso1506930b3a.0
        for <stable@vger.kernel.org>; Fri, 28 Nov 2025 04:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764333524; x=1764938324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+gmGE0zgXdosAgPn5zQUUbQPBAhgt9HdrlUFjfdvA8k=;
        b=OfULMyxGJCjnnRtkfIsLQG3xnIOBARjYNVF2vmJ/q1ZR5CuhY+rhqoTGM0SrFWG7z5
         n4SOKS8Z6p4e29LGB3pR0yPxitVRVaEjnZdwiFpswd/7LuYo4ccogq+dvKoqDNdAA2Bm
         Qxok9JQoebCwfposwjpUDdo1t7CxJXhf2MlPFIVDIANmoibbXQC7oUSiaKB25W9PCuPo
         eVmiO3Pvy2+CVavwsKyUNJuus45PJ3si8ZEIwbgMSdCiQQvb5+3cGGU4h2vLSjfgxc8V
         evu/kiXj43n2J06QIWog+kxTLapRjbJqyP9XQamqN8r+AEkq968O0c9QlSTDJajd6kgE
         nn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764333524; x=1764938324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gmGE0zgXdosAgPn5zQUUbQPBAhgt9HdrlUFjfdvA8k=;
        b=Tw8yDhUwqtJjo9fWVjOCZtKd/vCfzE54QSrGkXxKwc0EzSVt9mFajDh+o3V94RfEec
         BlRHzzcd2UN3GeCMKaPwupnOjnX63D20+vH+6xhKX0KtVt815n+bZjY6i1C+V+Mj542a
         hqsTezkcDVjpQUnXnHFtusv6O66Bw5H5FtvMR57kiz8csnA5R693TsivgmPlGrXAKqha
         79/lNk6guUj9qXsd+Zr+y1v8oPOPRHL8KMIG+kF9B3fHNQRh8y/3UWUsFm/wXq9ZzL59
         B+CYJc6KkBpXOdK/MVKUXv3bSlF3NPO7SJ0Wc+6sboq+B8t74FBwOPaRAqvlz6tSoYZI
         5qOg==
X-Forwarded-Encrypted: i=1; AJvYcCVN95S3j3X534udAr7EVutwtxEQ+xtaw5vvyerxqIa0XS2qXK/A2qmNqFFRl0Z/xVJbrrVpfFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJC5DWp8XtRe8oVS26xJXlRX6srjCZZXrYh3fUm7/RwMYDlDfT
	7jj0TgDo9E+Y3pdwxK7nkNRWFb5SR5S79oLEK5UKrPduTiYyFqh9Neyk
X-Gm-Gg: ASbGnct/ubuYXjWpTEkFkhSTYrRELJFt2aKZ9sM9yX2FzA1yoSyOK84KAqGzKkpjF1b
	qFDBN36IRkI0Mf9Pzig61wG/oMVF9bzzSvQgPHd2zg5hLsWtC7+eBfIIJHQh50XpZ2kybKv9L0n
	pfHnV8A9ma/xx300Q9LsgP91J3S3JdLWnsmatvkSUyZs0kezSskcfxJbOT/rBlQGmdzxYB2yE5O
	uIx1y6TTLvdW+D1mInUllMElMfCSRET29M8SGeAb8+22ImVEWsSE6oZUKEbg3/5mYwwfMv1PLcF
	ht5klKvBdg2feI7MCgBcN2aXIdAwNioguotm5uzPuJoqXsvArNQ4QK/Uk4yox4TPvsQJXLsnY8V
	sI7rl9TSqSY53QL+gIdIWHKRqIni3BY8JlnIFGsHh8c/jbyj8seFvTyUGtM6WVMUU6jHSR9J8YD
	eP0Iv84QufM/QjJeHnj0ySaJHN24V07TjZHg8WBdasss73HfHyxpMheFcWLgzm78haTD81
X-Google-Smtp-Source: AGHT+IFYP75h55aKp41FxpTw5WUWy2Up5lb2YKqkFZzaSewuv7Yc1W4fIprqoqs4MCOOfVoM2+dg6w==
X-Received: by 2002:a05:7022:2487:b0:119:e56b:98a1 with SMTP id a92af1059eb24-11cb3ecc3f2mr10394654c88.8.1764333524073;
        Fri, 28 Nov 2025 04:38:44 -0800 (PST)
Received: from 2045L.localdomain (7.sub-75-221-66.myvzw.com. [75.221.66.7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcae73bedsm18301241c88.0.2025.11.28.04.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 04:38:43 -0800 (PST)
From: Gui-Dong Han <hanguidong02@gmail.com>
To: linux@roeck-us.net
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Gui-Dong Han <hanguidong02@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] hwmon: (w83l786ng) Convert macros to functions to avoid TOCTOU
Date: Fri, 28 Nov 2025 20:38:16 +0800
Message-ID: <20251128123816.3670-1-hanguidong02@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The macros FAN_FROM_REG and TEMP_FROM_REG evaluate their arguments
multiple times. When used in lockless contexts involving shared driver
data, this causes Time-of-Check to Time-of-Use (TOCTOU) race
conditions.

Convert the macros to static functions. This guarantees that arguments
are evaluated only once (pass-by-value), preventing the race
conditions.

Adhere to the principle of minimal changes by only converting macros
that evaluate arguments multiple times and are used in lockless
contexts.

Link: https://lore.kernel.org/all/CALbr=LYJ_ehtp53HXEVkSpYoub+XYSTU8Rg=o1xxMJ8=5z8B-g@mail.gmail.com/
Fixes: 85f03bccd6e0 ("hwmon: Add support for Winbond W83L786NG/NR")
Cc: stable@vger.kernel.org
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
---
Based on the discussion in the link, I will submit a series of patches to
address TOCTOU issues in the hwmon subsystem by converting macros to
functions or adjusting locking where appropriate.
---
 drivers/hwmon/w83l786ng.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/w83l786ng.c b/drivers/hwmon/w83l786ng.c
index 9b81bd406e05..1d9109ca1585 100644
--- a/drivers/hwmon/w83l786ng.c
+++ b/drivers/hwmon/w83l786ng.c
@@ -76,15 +76,25 @@ FAN_TO_REG(long rpm, int div)
 	return clamp_val((1350000 + rpm * div / 2) / (rpm * div), 1, 254);
 }
 
-#define FAN_FROM_REG(val, div)	((val) == 0   ? -1 : \
-				((val) == 255 ? 0 : \
-				1350000 / ((val) * (div))))
+static int fan_from_reg(int val, int div)
+{
+	if (val == 0)
+		return -1;
+	if (val == 255)
+		return 0;
+	return 1350000 / (val * div);
+}
 
 /* for temp */
 #define TEMP_TO_REG(val)	(clamp_val(((val) < 0 ? (val) + 0x100 * 1000 \
 						      : (val)) / 1000, 0, 0xff))
-#define TEMP_FROM_REG(val)	(((val) & 0x80 ? \
-				  (val) - 0x100 : (val)) * 1000)
+
+static int temp_from_reg(int val)
+{
+	if (val & 0x80)
+		return (val - 0x100) * 1000;
+	return val * 1000;
+}
 
 /*
  * The analog voltage inputs have 8mV LSB. Since the sysfs output is
@@ -280,7 +290,7 @@ static ssize_t show_##reg(struct device *dev, struct device_attribute *attr, \
 	int nr = to_sensor_dev_attr(attr)->index; \
 	struct w83l786ng_data *data = w83l786ng_update_device(dev); \
 	return sprintf(buf, "%d\n", \
-		FAN_FROM_REG(data->reg[nr], DIV_FROM_REG(data->fan_div[nr]))); \
+		fan_from_reg(data->reg[nr], DIV_FROM_REG(data->fan_div[nr]))); \
 }
 
 show_fan_reg(fan);
@@ -347,7 +357,7 @@ store_fan_div(struct device *dev, struct device_attribute *attr,
 
 	/* Save fan_min */
 	mutex_lock(&data->update_lock);
-	min = FAN_FROM_REG(data->fan_min[nr], DIV_FROM_REG(data->fan_div[nr]));
+	min = fan_from_reg(data->fan_min[nr], DIV_FROM_REG(data->fan_div[nr]));
 
 	data->fan_div[nr] = DIV_TO_REG(val);
 
@@ -409,7 +419,7 @@ show_temp(struct device *dev, struct device_attribute *attr, char *buf)
 	int nr = sensor_attr->nr;
 	int index = sensor_attr->index;
 	struct w83l786ng_data *data = w83l786ng_update_device(dev);
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[nr][index]));
+	return sprintf(buf, "%d\n", temp_from_reg(data->temp[nr][index]));
 }
 
 static ssize_t
-- 
2.43.0



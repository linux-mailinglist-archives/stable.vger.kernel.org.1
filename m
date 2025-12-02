Return-Path: <stable+bounces-198124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E92CC9C87A
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 19:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D79E234A310
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 18:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0552D0C92;
	Tue,  2 Dec 2025 18:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+VJYKqr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E162C326B
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 18:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764698494; cv=none; b=RN5U1/rVfUTktnCelvWe5GG8et7T2LFvoC+rwxtv7qjWCP43w0TbMMv480IuJvngXPwBY/76LUBpuKjYp/cEA4aCFeBt8rSSIk94+9svWgfA6M1P8YSSXBg24Qsj56eD2wno8NYuyVeJu4RJK4+DuaIVM7m+kZQMK3wl9bjAj/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764698494; c=relaxed/simple;
	bh=F1BYdqfeNttcmB+PT/07KtZha4LYAw0W6s2or81VV2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XBy1k6rqzShsamwyIgXLbFCMNHmmoRpoiZmn03hxsuQfny89ubZktAF6F28tcyjGLtjhVyNFCjYBsxH7Jha/9f/SAXcBW3Hl9zyM7oaOB15LdvnCvWOr8UZC5laSWffhQkdkJqDuKs4Yzzr/gQ2genKAaRVoghnAkclSHxkxbSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+VJYKqr; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3437c093ef5so6057216a91.0
        for <stable@vger.kernel.org>; Tue, 02 Dec 2025 10:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764698492; x=1765303292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KXMEK6nb6BLzAA8eKfAM1xGhDShdGjdUjCMLODpDUpQ=;
        b=e+VJYKqr5Czato8snJD6WoQvhuLNk9ZYmnLkH8TJN/iVXByvW1/TlZBPIfV3YV6RdU
         qFkl9o/gPxNwoVd34vC1GfEc0Fm3VcVyapmie84KZaARtwNsSKOTtweQArOwcdQjy0BA
         66LniapeeMoKYfBg6WPAhPEWYWW0k7A9/MVjerFpiK7Vwmn0zRWT2ZtyIGXjS7PuwGDm
         imm+rqBWxI5it1aw6uUo8vRallrzxncMLhYdAymnoqIFunVUXV6zpdDAl6h2TowpNO0Y
         q3yebNV67XaRlz8EWZ/6Q/aq2HH01pb2pN/vpOIXfne6tSIJGiMSiv7gy1UK6PyQV8Iy
         oJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764698492; x=1765303292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXMEK6nb6BLzAA8eKfAM1xGhDShdGjdUjCMLODpDUpQ=;
        b=XF8NiW1OpDavKstXj1D+s1CGSRB03k39EoUFNDYGgNpjDFPV3+1tnU15I/GY7Bj2KN
         WDcZ3Cft0Khu24EAtnb4M9YEgKdf9YV6OkLv/A/4lGWIDbkXlTPqvDZhRCyB4gAvV+lM
         FehrxKZQJwVoF4VbJWAB4OFkM/LT3jonAHy6+k4OOMURfo+EOHucDUieNZGq/vMuK5gU
         DgGYRL8mes/P1m781OfmI2g6UGDFfpOT4qCZS7JbPdfgDAQdYuUCE+UzJ7D5Iq+2jJ/D
         ZV5UeYLYpJemKtb9E4N/5esSXDEsyxx4cumiNONnfjSBJkbDn8S1h7VTNRcV5qmkJP/r
         X1hA==
X-Forwarded-Encrypted: i=1; AJvYcCUJqCsCTiIzw6nG47isRXXkqt0FvhEsczUCZbxSOBtH4pKcxOHaK9nAOkLyaPayXHyTHSgf+UM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTnyuzaCkwSoLn90leHmvk5hUH8BQPvZmO//gIuwwZFdXUnuuF
	Mp/kzZ+5duZD1F5TUMTNr2qXCnwqkR7goWOSKbZLKWphBGbM5OYKJW+N
X-Gm-Gg: ASbGncvPbd8q3/K0SMENCN5M8PS7oDd1eyE0cJtsavvzkut5ua7YsHleLC1WRQdWpyh
	oOuG/XQPjAHTO4FxhYGMoe7OcHdcrnyQ3THH5p90WjDveAeHPKmMXK6V0Y5EHyVGJbBz+gPQ+RQ
	bEfZZ6yzmP81TIcAr9uQP/BeSWjfhpkbAmDaRVDi2iJyF2Em3C+5m+Fp8QqEscAf3WAy7KuhfNb
	iAL2z1XsX8pDQh98+mhciPO7vNDn9pS8HTQrAHEOpRw/IqnP/G1IeBUzHEOZDSPWJv/kxNAmikt
	vN8674C3/9O8uR75fBLYtZ9vkp5b6ydHUX4xKNstenbag25ub0or2YqmZ5LDuYMtwe3g9SnBnVy
	TqoShm7jMEd49sWQlh97KbLBETox3Ilno2y7lRUp0BIiJpafnQKZ3jUDsB/Yu8hDc1hQdGTgvQx
	lR0RbzPMtcExmK0juQALFYvRhWDE/FecwqvezTscrqi1yU5N+cNEqbPYfjxKjz5XZ7SjiVb4lQf
	HxtOQaP9KK+6+B6rQCQDwCe8t2ut1YhegD8dcr8B9xR8/3coBXY6274EhHO
X-Google-Smtp-Source: AGHT+IEnZ9k6iLEMpgmt2GBlILolxEm6kDtzH7Uz0lXhL4SkSaNalSklDUGz9sCCEUsxCh2UqqswOw==
X-Received: by 2002:a17:90b:1d49:b0:340:ff7d:c2e with SMTP id 98e67ed59e1d1-349108255femr280047a91.29.1764698491596;
        Tue, 02 Dec 2025 10:01:31 -0800 (PST)
Received: from 2045D.localdomain (191.sub-75-229-198.myvzw.com. [75.229.198.191])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3491041244dsm126910a91.2.2025.12.02.10.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 10:01:31 -0800 (PST)
From: Gui-Dong Han <hanguidong02@gmail.com>
To: m.hulsman@tudelft.nl,
	linux@roeck-us.net
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gui-Dong Han <hanguidong02@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] hwmon: (w83791d) Convert macros to functions to avoid TOCTOU
Date: Wed,  3 Dec 2025 02:01:05 +0800
Message-ID: <20251202180105.12842-1-hanguidong02@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The macro FAN_FROM_REG evaluates its arguments multiple times. When used
in lockless contexts involving shared driver data, this leads to
Time-of-Check to Time-of-Use (TOCTOU) race conditions, potentially
causing divide-by-zero errors.

Convert the macro to a static function. This guarantees that arguments
are evaluated only once (pass-by-value), preventing the race
conditions.

Additionally, in store_fan_div, move the calculation of the minimum
limit inside the update lock. This ensures that the read-modify-write
sequence operates on consistent data.

Adhere to the principle of minimal changes by only converting macros
that evaluate arguments multiple times and are used in lockless
contexts.

Link: https://lore.kernel.org/all/CALbr=LYJ_ehtp53HXEVkSpYoub+XYSTU8Rg=o1xxMJ8=5z8B-g@mail.gmail.com/
Fixes: 9873964d6eb2 ("[PATCH] HWMON: w83791d: New hardware monitoring driver for the Winbond W83791D") 
Cc: stable@vger.kernel.org
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
---
Based on the discussion in the link, I will submit a series of patches to
address TOCTOU issues in the hwmon subsystem by converting macros to
functions or adjusting locking where appropriate.
---
 drivers/hwmon/w83791d.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/w83791d.c b/drivers/hwmon/w83791d.c
index ace854b370a0..996e36951f9d 100644
--- a/drivers/hwmon/w83791d.c
+++ b/drivers/hwmon/w83791d.c
@@ -218,9 +218,14 @@ static u8 fan_to_reg(long rpm, int div)
 	return clamp_val((1350000 + rpm * div / 2) / (rpm * div), 1, 254);
 }
 
-#define FAN_FROM_REG(val, div)	((val) == 0 ? -1 : \
-				((val) == 255 ? 0 : \
-					1350000 / ((val) * (div))))
+static int fan_from_reg(int val, int div)
+{
+	if (val == 0)
+		return -1;
+	if (val == 255)
+		return 0;
+	return 1350000 / (val * div);
+}
 
 /* for temp1 which is 8-bit resolution, LSB = 1 degree Celsius */
 #define TEMP1_FROM_REG(val)	((val) * 1000)
@@ -521,7 +526,7 @@ static ssize_t show_##reg(struct device *dev, struct device_attribute *attr, \
 	struct w83791d_data *data = w83791d_update_device(dev); \
 	int nr = sensor_attr->index; \
 	return sprintf(buf, "%d\n", \
-		FAN_FROM_REG(data->reg[nr], DIV_FROM_REG(data->fan_div[nr]))); \
+		fan_from_reg(data->reg[nr], DIV_FROM_REG(data->fan_div[nr]))); \
 }
 
 show_fan_reg(fan);
@@ -585,10 +590,10 @@ static ssize_t store_fan_div(struct device *dev, struct device_attribute *attr,
 	if (err)
 		return err;
 
+	mutex_lock(&data->update_lock);
 	/* Save fan_min */
-	min = FAN_FROM_REG(data->fan_min[nr], DIV_FROM_REG(data->fan_div[nr]));
+	min = fan_from_reg(data->fan_min[nr], DIV_FROM_REG(data->fan_div[nr]));
 
-	mutex_lock(&data->update_lock);
 	data->fan_div[nr] = div_to_reg(nr, val);
 
 	switch (nr) {
-- 
2.43.0



Return-Path: <stable+bounces-178823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7289DB481D5
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 03:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 616113AD8F6
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 01:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033AE1E1C1A;
	Mon,  8 Sep 2025 01:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDjCd2oo"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492EC1CEADB;
	Mon,  8 Sep 2025 01:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757293785; cv=none; b=Q9WB8tfzXaQ0Q7C7cYaqFPOpkhEk9Weq/3+GZxdvCmkHs6BRbtVKAI+TVONxLv2uFxX09gO+7+Dg85LSiB61XxqkUvmH23v+cti7kGeze7jeE5/fP8mnGokw06M5lKv2aNQSSMASJYV5DLqno4ipYfkPAlN0aVaMUApkN47Dm/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757293785; c=relaxed/simple;
	bh=dGQ/XIBwYpp2dUZOSs040vn9kCdE0Yd7RTF3XUbuNik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=otu/T8bCXg5zJWW5tZ+lz3bkjhnrKico3W0BhqJRiOZLMwLZHAUERQrdQIeZkD3Ws9/T+OmD7lTRJ7qwDR25Pmcz0n9MTOQvhu+KWxEZ615y3Dglsn+BGI/sAUXJI4iZQFxUOzuo/w+bFHc4b46raezrwSeKg2bND1NhHbswoBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDjCd2oo; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-54487445158so1248965e0c.3;
        Sun, 07 Sep 2025 18:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757293783; x=1757898583; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jFAtSLeQXvoX7ygN7mDBGNxV6kcUMwUBBQ6PHOfSo4Y=;
        b=VDjCd2ooJKTIIKWOpyWqvBd+aC9NbC47lHDCLma65cymOyurWtJOfxwW1HQNJQ9NOm
         yqSTw2qf/g+rd7G7MDx4L+viJhPQJcip1ylkVYVk0r/Y/z9qxm4enVfkMxddM1JnJN9r
         LYCbXwZZCWnpk5u4LoJCbMcyA0IVbIb30fJMcmAFZMTLd5Lin3tOfv75OxbkHSGZwaxG
         U2eSD017gCLFF1iYWdcyEv9uDax4UGxW/uTl+t9UbC7tcmFtQYJPk+TF8jd6s+wxRvGV
         HimXRBXVDoP3J7vlrn+EhJG4FJaBXQ/ChyEFDgtrPJI/aBOVjbxUkLC8zcVrCHhM18yr
         jJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757293783; x=1757898583;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jFAtSLeQXvoX7ygN7mDBGNxV6kcUMwUBBQ6PHOfSo4Y=;
        b=ELQtJIsOZ6eLl2drIWUpeNSEpW81AFrtYzr1VQcKvJ1/RArXrZ8cg+tWZDdO8Iu+iM
         5r5A9Epk3Sy7UwIkrSljSeCd3V3liz2uhuaqMy27Eq/gY7LGjd65husSumDdKB0XA0Bt
         P5yqwCiVA6aL0gkXhjeaHsCCvtHcumgxHzAt6RUOqfT8ybXcYlTQUBxA4VcVFzi1uNDw
         wvwSGrejYGUs6z8hgPvzX+wZ71z2AsUqq22d7Ca0a5rkI5zmwD0N1fsSj/kDIqwwTX/w
         OyAyqmwbJIdQhETfQzdJrbr5sNs3tpmFJv5HRUtmmcL9gnh7odjhTBXh3fH/5OCuktym
         iPug==
X-Forwarded-Encrypted: i=1; AJvYcCU2szhhRf4F0bvY/YsgyEQhzsJkRPte9/to4Zt5yuIXsU1fAq1HefhgZbRs2sVexUkt5YTHXDSLl6Wlias8@vger.kernel.org, AJvYcCUJFwowMBPaU1tgZGbMa+tqPOYpuGUOIk/c3EGhf7Vgog0PlOFZmEgZQR2ChSlgIG4M0tuG2/Gx8GRE@vger.kernel.org, AJvYcCUu+lUeGEJZuet/Myz7GhqiqUhvjZvzTnG/5gXMwTZYAS+N/iAZUbgHFxuaiAqUmjhIBBLXRCX8+FKM@vger.kernel.org, AJvYcCX8xN7Rt0V2zwfmpWqfxHOXuDA/yuD7v+nMf1iKk1wA084Pfvlzt+gGoU85DgOvNNyEaCRV8SJ7q8uNz0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZBmeZeIaxxHAMC/dTcPK84GU4UZAuz35d4N+kHtW5bx8xhRvo
	Zts/OJ0fDh+22N/aaStb+0M4a8ejEs8m3vjOBxggEpiqZ7tSYBz6D1l/Ah6xNA==
X-Gm-Gg: ASbGnctdvTJKkzT+2Ig+ZBqw0+VBIi+CgI904JiklNZURXGQIY5JqMR4HafEVrrq8h1
	eMpjrlyESfqoH1a/6CF1GNu8CU9LzdrmyfTo3OBMvtOBYrG1xlEtw6Ktv8aCF1G2S4MMSYtibAj
	ec+eLeCS0lI0OEhgG3viwWRqD0bhtFfNHy0fbW1tDtOXGKVJbMm0tPHmbao2JC6M499vCcadHr6
	0cT5TccOvOf5n6YkbuXxwIudY76W3oHFjA2pdw5pRYHGNKCJpCwwCIz2eFQtfRLawnija6Zfrj/
	K4KLcIDEar3Rt4h5Rihl1d+BG3DPP/vdYj6WwTIAXe9ke6vA+XhNgArRF/WtgPnseIcotM2RbNt
	phEkTT/I4hXuKUqUy3WyToULd
X-Google-Smtp-Source: AGHT+IEmqp7aUGmwKTRGWCB7jMEyo8Kzkuxp4xeNH0A5o+79t5L6yRRJegr9TOT9l73T/Cqjer/y9A==
X-Received: by 2002:a05:6122:a1d:b0:543:a319:7394 with SMTP id 71dfb90a1353d-5473803d00fmr1568396e0c.16.1757293783201;
        Sun, 07 Sep 2025 18:09:43 -0700 (PDT)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-544b1933316sm9152572e0c.9.2025.09.07.18.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 18:09:42 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sun, 07 Sep 2025 20:09:12 -0500
Subject: [PATCH v2 3/4] hwmon: (sht21) Add devicetree support
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250907-sht2x-v2-3-1c7dc90abf8e@gmail.com>
References: <20250907-sht2x-v2-0-1c7dc90abf8e@gmail.com>
In-Reply-To: <20250907-sht2x-v2-0-1c7dc90abf8e@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: stable@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=961; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=dGQ/XIBwYpp2dUZOSs040vn9kCdE0Yd7RTF3XUbuNik=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDBn7dC5sLMzWFttTd1q/mflAQVNL/3tp67w5f5K/Hdn8v
 r536/JpHaUsDGJcDLJiiiztCYu+PYrKe+t3IPQ+zBxWJpAhDFycAjAR+yZGhobsmUemtrJMWf1m
 /iXL9FmJdjKMNfP0DA7c6rjQpPTEagkjQ6PdsgvXNsQfnstzaubUwN5Dlj3rEy9dPiTu+fUh6/q
 q07wA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Add DT support for sht2x chips.

Cc: stable@vger.kernel.org
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/hwmon/sht21.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/sht21.c b/drivers/hwmon/sht21.c
index 97d71e3361e9d7f0512880149ba6479601b2fc0c..2c2d3afba5155f951096210e2f4b3214def3b000 100644
--- a/drivers/hwmon/sht21.c
+++ b/drivers/hwmon/sht21.c
@@ -282,8 +282,18 @@ static const struct i2c_device_id sht21_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, sht21_id);
 
+static const struct of_device_id sht21_of_match[] = {
+	{ .compatible = "sensirion,sht20" },
+	{ .compatible = "sensirion,sht21" },
+	{ .compatible = "sensirion,sht25" },
+	{ }
+};
+
 static struct i2c_driver sht21_driver = {
-	.driver.name = "sht21",
+	.driver = {
+		.name = "sht21",
+		.of_match_table = sht21_of_match,
+	},
 	.probe       = sht21_probe,
 	.id_table    = sht21_id,
 };

-- 
2.51.0



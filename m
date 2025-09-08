Return-Path: <stable+bounces-178822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E91B481D3
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 03:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F23118934EA
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 01:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C96E1D6195;
	Mon,  8 Sep 2025 01:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="engPMFD2"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72F01AA1F4;
	Mon,  8 Sep 2025 01:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757293784; cv=none; b=NqO/7EfF2RJyptop1ZHw/YLlvvtCMvCAPSzwA7wiABhv2uyKWyiNNmm1D8S0TyRjLzSInn08VCP3VJaBbF5DO9Ac74k3s2U/GCsdjdBi8c+9E63JN5oovj4ptDkWyfc0E07ya+U3/CLYowwNmp//Z7YRMG54n8LF/KPoqQFHPWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757293784; c=relaxed/simple;
	bh=NZkFzo5aPv2rTH7kJl2L0wKYUaktGBbost8xMkEezhk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RB57f4ZwYptBLiWBQmTYgwYfo6Ozrrc1DXHDSJtZd2hr2b59gM36q3I6BJc+a4CMXlY5urkYGpk/7hzk/b9KMzmXwLC240CymsSM6unQdR5Qjd/Bv5IW+eTa+KBx+o3JIEG2jY+1lLJORLGEHFp4TKxL578ZXgjWTaY3pf1c5+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=engPMFD2; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-53b174ca9bdso2795593e0c.2;
        Sun, 07 Sep 2025 18:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757293781; x=1757898581; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PA65BDbtmlsgxVBJHU42suro+nRDzo+5rIF0+47d4KI=;
        b=engPMFD24d6Y2DOLxZfgBAukuUvjKUhI8KpBMfXsnLBYgWydcJWqnrXQJfR2vD+Znr
         kFbf1TBfG8p0lZWROgbM515c8DCXkG7c7Rk/zes6Amj2U5puyqWCnG6JiBt0ypVV3H75
         IKLlRDak7w0U7zadKU2DbLc8elEpK4Ymbzr9b3jAG+ky8GY02/KoRNJcO0UmJUSn51EB
         AFDk+E4H5686JpYurdfOHQHZoy/Z55XwppPlynXcwWj0EECQlDXc0X6gq23yITMj9uR/
         8vliTHu2jbQY8V8wHVKVTll9wQNocdKo38QCxwGGUzgj7qiWKJrDcpT5nVWkY6MbA9lP
         d/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757293781; x=1757898581;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PA65BDbtmlsgxVBJHU42suro+nRDzo+5rIF0+47d4KI=;
        b=RJmNVSNaIKKJuUX/oKOyRwJPX30V9rYr7/JiW8B6wv6RZi0GXFC6h0ZrGxJYBnZlN2
         uPGvfIQzN+Zc0OLyB0sN74v/bfxbJKj2FGuCShh6M2F5RPpCx6/LlkpioxFQETyNoLNy
         3tfXfEeLJT50mnaRZtZliCbV+BThSUTuCP6Fd5fP0Eo1BheQ2I5l5zZ6cH1xqVib0p11
         i/G5Dbt2K/07Llm1Usp0jW9GIUPV41IgzNCNip633sAjmYqBJNxGaixlWWvzDmWvWngD
         1jRnXOKkBoiUvhjzdbc7kv+eTk1rDgylR1N0eu6vT++inZhL2TpInUdwdg0tF+tNIkWy
         fnCA==
X-Forwarded-Encrypted: i=1; AJvYcCV9S4yBKeoc3mGipN+kikfJsYfn4enuOU3Y4FSgv5lD2EMGBP7pXPmS67O9AZ8vsJ/0bohv6YF0D+fQ@vger.kernel.org, AJvYcCVbfktId70/heHanw9iOoB2csVLCLgZVt5F/iylIjPvZhRDX3Hrtm6BCyKrdHFbTwI9aykbX+mdjD3B@vger.kernel.org, AJvYcCX+8f62Hyn14iBfaxy+xDHguPd7vQBSFZynu66XiobAHuj0JbP4SKRW+Firt3j+mh76q4Un7B8RJBT7Je2W@vger.kernel.org, AJvYcCX5kS9iCDk84se5N5yJrJcMMeNNG2MgtA6gXPXXZwJNgC+742oIRZ0qqhQpSMIvNuqd4QRKCa52pGzWuOo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydpa6Wf7+hTrKiAkxTWilVc+XdmGDpXxn9Pgc47cZ8+QmfM+6m
	ECbHpzxc/vzIpygzHDPsaHOa1UZ9YVXIMM63TFwWSh93E+xbxZ/IACLH
X-Gm-Gg: ASbGncswTe9PSUTL6SZG4/752SugzgVSamK0N8tnh1Q+xSWQdcynMbRJFa8cvsVdp3h
	WP5mPqGykLn/mAMwXzOoFPATe1F8silm+IAUxW6+hEyP5ZfUQGr3c4VCANQFKQE+c3RD0A/Gyho
	mjDA5ZA2Z0FnnSJTDKYmrIThr8OgkdInznQsQ1CBHJfQPkDyhGwT95NoAwHtuw+ScK4GMPO9wpO
	ug+65gk97RPnrybLqlz86nChCgXEpcRHO8cjBWDHujUJPxlR8bqM73KLNIRedAdX8Ym1MRm3/pX
	LZ9EeTgNUkzhAR7rg1TjSxKae5flqqkOfEfAEWKLrhyF4cDpRneovPZsGafiFmq2f/PDXgwA6/8
	2mps3+c5WKU03IXddo4e1Qy0gH+DeMo4HSFg=
X-Google-Smtp-Source: AGHT+IF3DoKd0yn1Op198dbyAdh7xAPk+DVuaFg2+qlFyCmPi1qO50yJ2OVfSP8DADjyue1ROPxmjQ==
X-Received: by 2002:a05:6122:2a09:b0:53c:7ecb:2f40 with SMTP id 71dfb90a1353d-5473a3ae7d3mr1626685e0c.2.1757293781549;
        Sun, 07 Sep 2025 18:09:41 -0700 (PDT)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-544b1933316sm9152572e0c.9.2025.09.07.18.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 18:09:41 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sun, 07 Sep 2025 20:09:11 -0500
Subject: [PATCH v2 2/4] hwmon: (sht21) Add support for SHT20, SHT25 chips
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250907-sht2x-v2-2-1c7dc90abf8e@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2066; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=NZkFzo5aPv2rTH7kJl2L0wKYUaktGBbost8xMkEezhk=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDBn7dC484rnXt7yJ54dnWEdzndDbvNg5x/fl3yovSS1Kf
 lGj9GBWRykLgxgXg6yYIkt7wqJvj6Ly3vodCL0PM4eVCWQIAxenAEykYBsjwwHbdg3HDXPOPl6T
 tvZp0vGzzN/WHWDfp1kmaGb9tcZpyy5GhllXugPcWGYlzple43rgacXezVmljNz+z+0mrH4nZfn
 zFjcA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

All sht2x chips share the same communication protocol so add support for
them.

Cc: stable@vger.kernel.org
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 Documentation/hwmon/sht21.rst | 10 ++++++++++
 drivers/hwmon/Kconfig         |  4 ++--
 drivers/hwmon/sht21.c         |  2 ++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/hwmon/sht21.rst b/Documentation/hwmon/sht21.rst
index 9f66cd51b45dc4b89ce757d2209445478de046cd..d20e8a460ba6c7c8452bcdce68a1fce963413640 100644
--- a/Documentation/hwmon/sht21.rst
+++ b/Documentation/hwmon/sht21.rst
@@ -3,6 +3,16 @@ Kernel driver sht21
 
 Supported chips:
 
+  * Sensirion SHT20
+
+    Prefix: 'sht20'
+
+    Addresses scanned: none
+
+    Datasheet: Publicly available at the Sensirion website
+
+    https://www.sensirion.com/file/datasheet_sht20
+
   * Sensirion SHT21
 
     Prefix: 'sht21'
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 9d28fcf7cd2a6f9e2f54694a717bd85ff4047b46..90dc8051418689e7a92293df15ce35cd822c77ff 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1930,8 +1930,8 @@ config SENSORS_SHT21
 	tristate "Sensiron humidity and temperature sensors. SHT21 and compat."
 	depends on I2C
 	help
-	  If you say yes here you get support for the Sensiron SHT21, SHT25
-	  humidity and temperature sensors.
+	  If you say yes here you get support for the Sensiron SHT20, SHT21,
+	  SHT25 humidity and temperature sensors.
 
 	  This driver can also be built as a module. If so, the module
 	  will be called sht21.
diff --git a/drivers/hwmon/sht21.c b/drivers/hwmon/sht21.c
index 97327313529b467ed89d8f6b06c2d78efd54efbf..97d71e3361e9d7f0512880149ba6479601b2fc0c 100644
--- a/drivers/hwmon/sht21.c
+++ b/drivers/hwmon/sht21.c
@@ -275,7 +275,9 @@ static int sht21_probe(struct i2c_client *client)
 
 /* Device ID table */
 static const struct i2c_device_id sht21_id[] = {
+	{ "sht20" },
 	{ "sht21" },
+	{ "sht25" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, sht21_id);

-- 
2.51.0



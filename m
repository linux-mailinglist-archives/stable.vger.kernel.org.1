Return-Path: <stable+bounces-178831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3412CB48230
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 03:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9AEB17E37E
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 01:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA9A1F873B;
	Mon,  8 Sep 2025 01:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgkreDJv"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6251EA7EC;
	Mon,  8 Sep 2025 01:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757295241; cv=none; b=uR4pAbit3LzuwN0zFDpHJcrT8FcY78nY1kvE2LzZ9WPYz3xVOYOajRlTVpjcXXDObPDEz7ce9xrpmow4587V9574qXojXRkIfbb0u971YAyD320o7PDGzz2z9w7Kk7bprvnlcu7Tt4r27KFHXMaU/8SKwkOi9MVmHo8S9Np79FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757295241; c=relaxed/simple;
	bh=Yxllc0HNGsZAqslznr4FCwhn7CrBxbqhAVxVqmwATjw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bBey/V/Sx9z5Fjtm2WblgFV358hraEirI3wY6SlZ031irZFe86PAs/wCsiT2RB9OGA+CUec/IwCul1k2PmLqHOJFRH8JTk6It1hu6CmfkyqAPFXB65TPhXoMFOo+TnoZSTVeWoeD2RJaxOhVgOd3LiB3fGidNMM5YIJ+PH50Euw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgkreDJv; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5449fc0a7f1so3437872e0c.0;
        Sun, 07 Sep 2025 18:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757295239; x=1757900039; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HjMMUbYRuK7mPw9ueXvM3AzsGk0tkHKfqDV4juVQUEA=;
        b=XgkreDJvbNa/ku1aYrQ0zqAtOmNmO0jitQ0NiF1CmIlapMCL4tDK5tS8+sYl6Hu4BW
         ApnAbEm2NkT7wgoC6GiymKf6wFXN6vZUb6xkw6suQkqTY/sXiEydvJ/Fz3Po3Q60aWVg
         n7LAuNUARvt0xt5BqvX9s31CyQIe1qlF/AYZ1GeHQowP8i9ihJbLHMFzaMiPGSH51zBe
         Zv1lhdTqBLJ5RDigsKCjooh9frkJmCgyfs5zHBxy5gjs9bTPsS/9MhvLrBfavXhHG4VQ
         kV/bh4QdTQ3Py7kqc6V8U57lRJI1J2q6ycV6HEjyC4d4tIK/FMhW+RZoRGZPyYoXGCrS
         6BvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757295239; x=1757900039;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HjMMUbYRuK7mPw9ueXvM3AzsGk0tkHKfqDV4juVQUEA=;
        b=Mt1J4VuKo5LLVnNQLOO1tMzXiw61D36blI8H1nIVqmhpnhKGFRAqK1gzwLcRmd3FGY
         4dFmkS97P6ONVeE8F2H3tShWXSdSz970a/TJaPVIXFnXDolP7fLKZgdBJTTGgrFW4wvv
         I+2sYrG3funng/aOfpG1EOk1DjbCVC9zGyzmcLKDew0DLWXqGvZj27gqGoLQxGt/80br
         IQL7KmWWEluqrCt+pR82lRlbo4qHerop1Z2iTYyDLGKzCO6A8PsU84VbIDYoM5mAPhFe
         E3rxhJopX6SMxqLYWACdIbSJuCi+2O4Pl97wcTucRXqEwJaUf363E2SBLfN4k1F1m4I7
         FrFw==
X-Forwarded-Encrypted: i=1; AJvYcCUq6Lea58mvYfULzoaP1cXOt+c8/kvJ/YyQJsphUXZ/p+gIGb4XOmnT+8SR86jUacyC98x4lbF9HVYN@vger.kernel.org, AJvYcCVfdEstzEzdQ0DtCcLCcFNrU2nAM7YMgJ2MXmimSd+8hWX4YEVn3T/vJJtXK9Dx8+msr/HnTXJN@vger.kernel.org, AJvYcCWd+EyOzs9PLQ/mvMcZrFVF3Bc2mW25PQWzTf2Q++fSJL+YE7qCTqypcEWMLpA39ryPStMGwvNlUx4F@vger.kernel.org, AJvYcCX1OEU/YfyNf9C+bOGovv7Do6NjYpjDLDCXCWj8TXgaXQRiZACSBo5nBezFmZmvTLf3Y99Y+rJw12CfLUG3@vger.kernel.org
X-Gm-Message-State: AOJu0YzMMBcFBb6OAv5V9gtb0/1r0w80QOPrDecj9BHkSkrjtHpFY0de
	zSffF221FfHhIDnJI2cAkoQ165LRdiGOmbghhFyxYn6DRYmRncsr9irh
X-Gm-Gg: ASbGncsI2bEASlT/KfSSx3otNloQjyaNx2vE7Dhkz+mQ8s0udU9df200MJU9F/hZGx8
	STdarNwWfXawP/SeKNtYKSFyZe2YqrQbxrLdxHm7AQtNGSnWO2dkb9xL3RatLLqcMHZh+WIJTDu
	N0/HgSb/xyiCTWrjwXnivki+qS0zu08Jw7lBJtmKgQ59j3ieTC56/fik4vk2UUyH/1mk5FSJwe3
	+Q+NUvsUznYsAFgZn0AxRI11u36LO/wxdVTE5GyjVvQOUESkatS7xrG49PWhuJOmzDNaKTvac8b
	oBABHAaIpG+L096+twHV52NF/esDqIuVqaLCqPR0suLgIcd0AqYtJRzYuZIeUuh0yRLX6gUt82o
	ZnKINVMeKLpFk5RimNOi0Q+fl
X-Google-Smtp-Source: AGHT+IECfgwD7Ke2yFro8s2FPgAUhtv3pW8OtdESpKGB1qPZxDwONMgXr/B7kczpxFR/D4+0wQK94w==
X-Received: by 2002:a05:6122:2508:b0:539:44bc:7904 with SMTP id 71dfb90a1353d-5473a9c8e10mr1599861e0c.5.1757295238832;
        Sun, 07 Sep 2025 18:33:58 -0700 (PDT)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-899c47af508sm5857494241.11.2025.09.07.18.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 18:33:58 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sun, 07 Sep 2025 20:33:50 -0500
Subject: [PATCH v3 3/4] hwmon: (sht21) Add devicetree support
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250907-sht2x-v3-3-bf846bd1534b@gmail.com>
References: <20250907-sht2x-v3-0-bf846bd1534b@gmail.com>
In-Reply-To: <20250907-sht2x-v3-0-bf846bd1534b@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Kurt Borja <kuurtb@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1005; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=Yxllc0HNGsZAqslznr4FCwhn7CrBxbqhAVxVqmwATjw=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDBn7jOrz7NpL8g55b1t8t5h1q8hWXx67NMUQmS2vSx43W
 2kauPJ1lLIwiHExyIopsrQnLPr2KCrvrd+B0Pswc1iZQIYwcHEKwES2nmb4X1nxYdUywS9haZv1
 HpoGZqQz/1EyNbZakyGgs+ttpdOmXEaGaWzfLnHt3XCy5LmA/3d3hsh7F+vvFlv28CyaXXJVelE
 qFwA=
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Add DT support for sht2x chips.

Cc: stable@vger.kernel.org
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/hwmon/sht21.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/sht21.c b/drivers/hwmon/sht21.c
index 97d71e3361e9d7f0512880149ba6479601b2fc0c..627d35070a420ab9e51634bdc5cf5e3de3853326 100644
--- a/drivers/hwmon/sht21.c
+++ b/drivers/hwmon/sht21.c
@@ -282,8 +282,19 @@ static const struct i2c_device_id sht21_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, sht21_id);
 
+static const struct of_device_id sht21_of_match[] = {
+	{ .compatible = "sensirion,sht20" },
+	{ .compatible = "sensirion,sht21" },
+	{ .compatible = "sensirion,sht25" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sht21_of_match);
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



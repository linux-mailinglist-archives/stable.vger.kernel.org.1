Return-Path: <stable+bounces-178830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37596B4822B
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 03:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21961189D680
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 01:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063F71E7C2D;
	Mon,  8 Sep 2025 01:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nl89GZr3"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBB51DF73C;
	Mon,  8 Sep 2025 01:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757295239; cv=none; b=cAGXXh/xLh+gAI9qTYa5eJMxPiZ5rvWlhUafQKq+AGOk3OzOssAjvi5tUyw42Qux7mc6IZNYABPakv/GTlMklvwaL2fTDVnipeFWc/TnCums0mxCNTajyrBHPCUHY9CTVheGCOs0Piv1gIi4hEVl9F1LrG27kQdUIJacp8ENb88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757295239; c=relaxed/simple;
	bh=NZkFzo5aPv2rTH7kJl2L0wKYUaktGBbost8xMkEezhk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EV3WmY5+DNi0WdhoWiqwmAaeC2kdZdSYeqVBDTJ4W0FCPseRI3lY81HjwvIbQe90qBCOc0XDKTwGrgvYn36WFTC37gAIl3qGy2lP76I9oLO+UE5l/7NKbKZl7LF12Et1QJEn6FBxr3oJ5MkTnY+b5dXMIPqKD4o+ZRAuQtsL+g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nl89GZr3; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-544ba00733aso2738395e0c.1;
        Sun, 07 Sep 2025 18:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757295237; x=1757900037; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PA65BDbtmlsgxVBJHU42suro+nRDzo+5rIF0+47d4KI=;
        b=nl89GZr34rdckViYY1gRzKnUXBMx75JDjl+1IpKjfwLhaMJtQbWrCbA3gmQN1arhNW
         JG3TDR9N3wuW6OSR8NvILeTrOxikrK/AoKPTqPXS1xrAgT4xDeQg0k0wGnYnFdrIXLz/
         ci1J7bkrrwCCTns0U50wzJsRXxXFabJ6V+LjDj7fuHUCER4vYtazEa1/bJYTmsEVd0BX
         idxed69xrrsfRfkU+42IZxqi56sXpzi0ZWtbzctAAp7RRhIgs6FB5Gxvo2PbbJ8sjMsv
         AVs9hKijIfUYrW1PopbUZLhYvktWHLrzl9DMbSKuj9ob3jnA60PivcYxgeokakcjpFAR
         OULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757295237; x=1757900037;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PA65BDbtmlsgxVBJHU42suro+nRDzo+5rIF0+47d4KI=;
        b=fdfM5FI94oeT4UU1I9IbGw/hv3FzLRDlIf+6a46K77lzM7jaxoyD9/kSa9vaheBj8o
         fcf4UNT06R2i+gZy/Co422/DPBNEIKlwPIZbvxhb43w04AvEma/rT337UaKTqbAO8fAG
         v1HjBKfiL9Gd9K5Qp+9b19Xlg9cii3Ql3jVojLhsCWIlPz8pzGoa3fAq8MC7elmBhUUU
         kt4+016RZNBFb5i+6nr+QNhHu14CJ9iSnJXsGVWDdX1MvfZtiX899wZPI4duCp1jsFPU
         zhwLatrliJ5T++gztOZCgBc/KbCxSvR5o0mlH3IYzgI7V7QBoSqXpC7pvEFQyJ0QOYEa
         aK9w==
X-Forwarded-Encrypted: i=1; AJvYcCUcjcR2Mvb7F0FWHqzQSwJH2wR26yMdqxzII8S0uhYbdWIkMfB7y6Cr2+KKiONQik1lHIt/GBAB6OHk@vger.kernel.org, AJvYcCUo+FgYCJo09BtmNLoYwER2+Phr8qJzVCEBpCP/ka0VXSAUASHrMsWflKJVsNU5AU2vK3jeQbQ2PnmGamXW@vger.kernel.org, AJvYcCWFTIkjt6mJwpBaEENZm28DL4BeZ4ScoGiUqyLN1VtTqubp++RckDN5aUeXekPUSK9aezTS5CZL0pau@vger.kernel.org, AJvYcCXPqOaXnyQ1Oi8sqRADonJOPd2k9RbJSvGaydMmjxDdGldau9m0ac4LEhTq0rDIjCw3dfpzMfGP@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0PpC8XeA8jKBaQpSnoLmre3tJg0yYq8pdmymM6JM0zPx02PMX
	HuD+GzDYaIlO933Y/uTygKy4ej1lgt57WszJ3UHn3s4m1QcaqzCIae+i
X-Gm-Gg: ASbGncuatdA5KzmBHx9PDmjEqJS2JWp/zYyg+9hXRZtTeD0kW48Bw4PBRY2N0yJz9de
	QHVvUxQq/awEE2FJ59QzD/FhuPIKKiYHpDa3C7m8InkT29A6ydcBasu9nvw+KUveXfVqcs414ZK
	jEtw6T25yxd33yyr8aWFWDz4LL5+8Hc+AhGHahaYsiEH11T7us86m4E2vOWz9AK7qT9QmRem6zl
	qCcVUj7yXcd8n7Kc3Ko36mflu0bylpTCZhDJo4zlJZgl9SFAYpDVxUQ8blEE04IY2cme2DiaDp2
	Ocjk2Oqewxv+eFtjy9AMdVcL3Q0+Lyzf3N/yQ4qEr5J/7qoGRk6ObHjRsGBwUmvoRdBfjnklaf8
	Zhajitmiz2NgJHlxRvpLmJR6qWQq7xaq3Q80=
X-Google-Smtp-Source: AGHT+IHBB/S5eZWs0eKJkwt+YrQpxbpx8AGe0AMbxqKbyJ7VUSTdvFj5kv+1L1hvGLvvSRdAadjtRA==
X-Received: by 2002:a05:6102:6889:b0:52e:68:770a with SMTP id ada2fe7eead31-53d231f73d9mr1241965137.24.1757295237026;
        Sun, 07 Sep 2025 18:33:57 -0700 (PDT)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-899c47af508sm5857494241.11.2025.09.07.18.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 18:33:56 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sun, 07 Sep 2025 20:33:49 -0500
Subject: [PATCH v3 2/4] hwmon: (sht21) Add support for SHT20, SHT25 chips
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250907-sht2x-v3-2-bf846bd1534b@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2066; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=NZkFzo5aPv2rTH7kJl2L0wKYUaktGBbost8xMkEezhk=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDBn7jOqrhWb0O0zf5fO5xl848r/v8orEE3JrVqawTufet
 v/946r4jlIWBjEuBlkxRZb2hEXfHkXlvfU7EHofZg4rE8gQBi5OAZjItSUM/z3/7DlVFx4jvn1y
 J/8L6ytPFu/9GNZl/JErqe7z2hUeYZ8Z/nvdVVzkXqNgc6jX3z3ydqf1ss7KtrkdzakdO2ebHl3
 ByQkA
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



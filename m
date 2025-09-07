Return-Path: <stable+bounces-178808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C6EB480B4
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 00:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9765718942EC
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7112285060;
	Sun,  7 Sep 2025 22:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W75HvBF1"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECA8221557;
	Sun,  7 Sep 2025 22:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757282796; cv=none; b=IyT5qlEOB8cYn6/3us67q/7PY/rFwZlFZzZtUVvOt9DD3vdHLsQLKxCyXybgAAUd3J/Wu1Ay2XWHxH9sSmGGRMz8s6H/OpafyAIB+lGqt/n1uGqgHGNI/eYIzpMpryLpc/9DQYPLLDtsISy/sD/9uscKIT7KbMyvm3q7HAirq6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757282796; c=relaxed/simple;
	bh=kyQ3oIkdtBEZOj8d68PXpwGLQawQtGLLGO7GVnMsfBY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZKJnWgv/fRuYlmR0fbq72oJrk+eZLSkj6cnnr3OaQ57hK3AO8+oTEU/OqPGxVNtlWHlWjSDKySf1hxl/TfYfVEQqIFWiTKhorJ9GT0FriE8sT37gkbAMZ5vfNdOzKnoLxi2Q4mwGLyJuAmqFUomU3bUP3g3eSF8Psh1UAGZcz+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W75HvBF1; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-544a2cf582dso2826710e0c.3;
        Sun, 07 Sep 2025 15:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757282794; x=1757887594; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KQ8eBJpgmu6wHk/aBZ/9SlUnR4gczOLoJJ3AIzHw4Eg=;
        b=W75HvBF1e4SsErh0q+gUrP4tMf2lxX7gW6ozRce1j/5ZXkTFlbO1yu7rP6Lj6PJNLv
         qI74vKnkJxixol0+VYXmyl2kD05xfQ3SBuN1AqoBfBQ2zv2bRAg4kKuYhd5Dc9Crvo4j
         IzJ2y43cF+fjPK13ibhycDLD2Utvhl8xg9F6hIFjHEVt86qzTzn4PYrGQ++tNlYQ/1hM
         0wD+3Et1OALI0javhK1ZX3M34r3CejsXJkkURhPH1p2vsDGprUKy/7nEWTL6C8EDpJCT
         lOnPS/+aUIJm52PqI2qq/E8PsnyWmDH0fOL9p3C4T5fckFKAcO9K0Idl/MOPxFehth5R
         eumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757282794; x=1757887594;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQ8eBJpgmu6wHk/aBZ/9SlUnR4gczOLoJJ3AIzHw4Eg=;
        b=EYev1PIp4OpkrvCvO99eoCSrQ6i8fWHsZlcsbZw3+DBfjK8tT+zD1LHpF6K4lUn+Ni
         4w5gqySA6XqQBsMDMmYrw7rtsUDbhPImGs3CHb5Ki3jjFJvOPaDSBkl2Utfk741ICXgj
         J3F7yGwSZHefEcJwWA6wGHVV4K1SReHq/vYwLYNIZtq/KvWVKsOPANVzIkaFWVzdtSZk
         z0uaZpiBdNNrUs4WHwGfTBDinqIeCy9QixGwhBlIORe+IcClQnm81AXtyQD2O6g6ppeN
         fqhwy5HBtIDJjp9HBUT0tHvyrfLGrIHh3pnDKqd2B+xuyAkXC7kTozqinaVjGNwolsF4
         ymKA==
X-Forwarded-Encrypted: i=1; AJvYcCUaHvWZVL/lEDEp7FjrhvPHWivw/W6/DfF1MuYZlsZm/1Wx1z7jMcd4rshaShoCMbBRiqYnobPrj9/0lvY=@vger.kernel.org, AJvYcCUzxpfMDneFip4lPFqsLmL3sNhgKgfkWnwR+8O/0iXzpF6mZQrS1eJXxtTqgqHBa/e/6QNBgL9abjA4@vger.kernel.org, AJvYcCWwY7j/HkRrvWRdwC7PG2Fl0Yjl9w+c7Xy67fVIjkiO0131ZaYpTBxjXLYRHA7SE0VuwqG6smdSbwA0@vger.kernel.org, AJvYcCXeIVkKEQsJRgja3ydmtocNWHqGQjhKV5dK4Xu/O/ijfS7Y9FZEHXdeL2lYrMSR0sI4t3eJFvuNj31s6yvq@vger.kernel.org
X-Gm-Message-State: AOJu0Yz92WXtPwDjuMXAxE/Yuf7eG5RcBDlHHk48fuaMcyPauSr33nK0
	QCciqKK6sX1++nQ08byvglS4k4s+jB6XahY6m4ljP5/zuyWj1R0v21es
X-Gm-Gg: ASbGncs4npG/Ka2iQsic+WAarYazw12adJrPNume99N65sERBGaVwGsG/G/sl5LhRAF
	H88LW0ilM7IZoOcd1LB7N0R2byg9X0qQj+jeUiSzQAKNEp+GxLxdGgCsZoC4LSXF5Vc/oFYuLzr
	lgEWjB7qc1xhhkkeTEpB/Ewn5In8DBRLxUE5Knp7ft7pId68YNquBrdLEFuVN7IVWbB07SPLVeB
	5v9FgWmEXOM2dbB1X8yoDWIP1BmTLSRENqvwTzoIwgImWPmQPYz4Rr1FoKWQlS0lg7Lv0nDZA/P
	IPM/QMS5wlJnZWSPB1UnuXmJILvbuPmimEgNReKIrpk9K+ggBbkMN9G+rzwAY/80INfKqwmmthX
	buX+Uw2Y8yZsHBgUVcv0ZHA4aYYPzrLes8WY=
X-Google-Smtp-Source: AGHT+IFUInZp6RcUlDJXwgoXgHvmrmPQcSwCOYmbTQiQaCzoZjTEQt9Fo17vm83I17BEPj2LOuT6tA==
X-Received: by 2002:a05:6122:658b:b0:544:4ee5:1334 with SMTP id 71dfb90a1353d-5472a006752mr1575803e0c.2.1757282793899;
        Sun, 07 Sep 2025 15:06:33 -0700 (PDT)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5449ed5a91esm10397004e0c.20.2025.09.07.15.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 15:06:33 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sun, 07 Sep 2025 17:06:15 -0500
Subject: [PATCH 1/3] hwmon: (sht21) Add support for all sht2x chips
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250907-sht2x-v1-1-fd56843b1b43@gmail.com>
References: <20250907-sht2x-v1-0-fd56843b1b43@gmail.com>
In-Reply-To: <20250907-sht2x-v1-0-fd56843b1b43@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: stable@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1347; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=kyQ3oIkdtBEZOj8d68PXpwGLQawQtGLLGO7GVnMsfBY=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDBn7GJ9qfd4dXKfzNEms7PHZc6tWd8fEWnfdWeedKa41T
 ++gwNpjHaUsDGJcDLJiiiztCYu+PYrKe+t3IPQ+zBxWJpAhDFycAjCR9WsZ/od1r0vfJvaZQfit
 zifNavb/y6eVWjmELqpZpCv355OJrBAjw0mx6lRtrTm3rBXOzDzD+0X+1YumSBanX4tzjqeFJiu
 eYwAA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

All sht2x chips share the same communication protocol so add support for
them.

Cc: stable@vger.kernel.org
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 Documentation/hwmon/sht21.rst | 11 +++++++++++
 drivers/hwmon/sht21.c         |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/hwmon/sht21.rst b/Documentation/hwmon/sht21.rst
index 1bccc8e8aac8d3532ec17dcdbc6a172102877085..65f85ca68ecac1cba6ad23f783fd648305c40927 100644
--- a/Documentation/hwmon/sht21.rst
+++ b/Documentation/hwmon/sht21.rst
@@ -2,6 +2,17 @@ Kernel driver sht21
 ===================
 
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
+
 
   * Sensirion SHT21
 
diff --git a/drivers/hwmon/sht21.c b/drivers/hwmon/sht21.c
index 97327313529b467ed89d8f6b06c2d78efd54efbf..a2748659edc262dac9d87771f849a4fc0a29d981 100644
--- a/drivers/hwmon/sht21.c
+++ b/drivers/hwmon/sht21.c
@@ -275,7 +275,10 @@ static int sht21_probe(struct i2c_client *client)
 
 /* Device ID table */
 static const struct i2c_device_id sht21_id[] = {
+	{ "sht20" },
 	{ "sht21" },
+	{ "sht25" },
+	{ "sht2x" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, sht21_id);

-- 
2.51.0



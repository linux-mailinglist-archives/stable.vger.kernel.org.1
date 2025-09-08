Return-Path: <stable+bounces-178829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B171FB48222
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 03:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2CEB189D606
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 01:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BF41C863B;
	Mon,  8 Sep 2025 01:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOPWNdQX"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC8D2110;
	Mon,  8 Sep 2025 01:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757295236; cv=none; b=TdZ/yx3p2nJadPRgRyE6HDAEzXVF7TRalWbxLXV7IiJx2k0n84fdqYG5AeCSRZ1EivkDFLmz7rCu6OhJSs6Xgpvt5HJz7F0IDGf5aHbOXC4CAmu2zXQ+4S0WQwxP6CYqdVgOaotTsC4fPxqtsnnPoF4HcsOyoQDiWCdOtXNQQQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757295236; c=relaxed/simple;
	bh=YoAO1z36zJJAlvhzCFjfqGcjiMS5PkDaNuF3hZI2ioE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hE0ODKKGYfeIm1LlROUGU37pxkertzDJFhvYqTNuk0a1JdJ8HvtFE0QQx1O+WTkyWSP32VLxYduPWv1xstB74yXZFQZQ6w+e+fUtfTwtdPwmd8Iu+jxPXN2JsQwRlMBLCEinXmlowEXMZmGNKmDknBBOeZwJCRR+Y4/RB2ZS19w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOPWNdQX; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-89018ec3597so2591721241.0;
        Sun, 07 Sep 2025 18:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757295233; x=1757900033; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lyb+xqdQ1ZLHkMXEjseYFTuvjJs5m04tJ0UGSEAV0xU=;
        b=KOPWNdQX6hNEb494fXfT+TcpYoo94VJgZ/hutZb/kopDb54xRABlApUBa5pgfgMYnj
         +CqYMI2b3BXpLIox7u2Gy4F41s/yocJf6MimnIkbp44Frv31SClvGqsiuZ1kC0UeU7+C
         nPgyesYEPaktAuM2wMa4evMEdMpd2tM+E3Nzi7ixeJ/TElCb1sQEECYzhQ3dNuupQMM+
         YPRVa1wFVLq5E0i5gjIhwJvAGOAEpNyW4snKdcwDqryyavd5hw4R3Wru8iDw+YWdoJrh
         hqy4UGOMCWn5tMXrGOE42bZucwJXxTeqDUCWeIhV099xvWxLqgoDkakuE5ER+789vs48
         dXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757295233; x=1757900033;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lyb+xqdQ1ZLHkMXEjseYFTuvjJs5m04tJ0UGSEAV0xU=;
        b=u48NLombM4HvH7E/gdRe60mS3v0IRXXcH9n61+Sj6IDicu6F7yYVdJJos7p3nQXSjO
         fM/Nrbp+BjLEmTeTZCqMoy4ptU5n6fTfxaSrrOHxXgNjB/t3Xj/6X7RgU54jAQszOpNz
         xgwjIse2JBUNUt6+keskX7GXKhDlHzf3iCw3ZfUYpwDbmXcdC7V+6H3eCWSS4U5G5Pjd
         N8aL98pkR/Ih9HDtbYboGpxpATPFXExxOXY62gMwn285CS7LgPTGUvbRZzOQhE3qFXUF
         65Xe3l8TxQmKZ6D0YjO7bj1QZhtyGi6IY6paf90iSDMRir2WCSphYBnlOswMmdbtGrV8
         HtpA==
X-Forwarded-Encrypted: i=1; AJvYcCUbhAUiOr2ezc8pGKOW2mG6RupGX3/DEvFKMjdBG4KYyxNjCpPRizap3TxCmHNGCN2L1V47eF//96Fl@vger.kernel.org, AJvYcCVmM4UsFAIjoweYOkTJYJOjJXoAXtLK9iw2dMkaf5FZXn3hXbHlGXWfNmiTxdySz58EEgMW4dlB/Nq29Cvh@vger.kernel.org, AJvYcCWKumQUbi+iLibff4v7cvjY+9JIn5QP5++fdBBh80X1YjY54tM86nV+dFRifikO1bw9lpFRHDZX@vger.kernel.org, AJvYcCX7SAiw9irW067h5twEnp6hTQwncjSeCxIVj74IMoUFG7T4TNfEaNI4D8Qql7FhMu4sJ1esR13bWbWC@vger.kernel.org
X-Gm-Message-State: AOJu0YytIRfraciHlJuESfSPdPWOhkXFo+pvBmdiCpvTS6Na99jwkTfC
	VL5A45faUiupplxMILVya4W8TPk7mmND0SiR12okfzTSoGwAYBgdJAIo
X-Gm-Gg: ASbGncu7+pJf5JUutH13lJxLeceQN0TWj9NL5SquECuzVrXdJlGAs89HtddKKKuS3oh
	VMWdaWHMMU8Hp6VDvLOlvkLGOaNKSLGojYUquy2ab3nW/Jv2GUVAy7IujgWsrb0eU3EYXMniGG4
	afK5s0FGZJqTeBmGxQVYXThPMyaP524sBCJlPHjl6UCoSzXOPgiJkSjOQMtozdKcUCS47l5NQSl
	qR3OF+BeN2/UcqsyCzxHSR28+I4MSa4ALEUJKWgqJ2GhM1/LQS/NFGp5PPH8q2agVuuzk7XRbiq
	gI4KvpDTOVd0aJ2sRjWHWL+Nb5NgnPhRE1fadvIWdAsimzCcdXq7hPJ7cczxAHHhLL72Lelq2PM
	ID02boUoYdyKWgUfWF0hVzJgVCwbaNR99KGk=
X-Google-Smtp-Source: AGHT+IHX41sPtEHEp5BJiWmtzND4msRXUjhcBMqFszHIDxYIjOCtoU/g8BeBIWYv/Wd4pq3yNhzyIA==
X-Received: by 2002:a05:6102:3e04:b0:538:dc93:e3c4 with SMTP id ada2fe7eead31-53d21db6e24mr1986596137.16.1757295233495;
        Sun, 07 Sep 2025 18:33:53 -0700 (PDT)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-899c47af508sm5857494241.11.2025.09.07.18.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 18:33:53 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH v3 0/4] hwmon: (sht21) Add devicetree support
Date: Sun, 07 Sep 2025 20:33:47 -0500
Message-Id: <20250907-sht2x-v3-0-bf846bd1534b@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHsyvmgC/22MQQ6DIBQFr2L+ujSAotJV79F0AQj6kyoGDLEx3
 r3oqmm6nJc3s0G0AW2EW7FBsAkj+ilDeSnADGrqLcEuM3DKBZW0IXFY+EqkljXjQlHjBOTvHKz
 D9ew8npkHjIsP7zOb2LH+FhIjlLhO1G1Vaqar8t6PCl9X40c4Con/tXi2mGk6I6nSrrXf1r7vH
 xZD+LzQAAAA
X-Change-ID: 20250907-sht2x-9b96125a0cf5
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Kurt Borja <kuurtb@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1313; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=YoAO1z36zJJAlvhzCFjfqGcjiMS5PkDaNuF3hZI2ioE=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDBn7jOpvMoWGz7eWXDhBYZkl2/Ymz+iqvMuvnsZv2hJ8+
 5NER+mejlIWBjEuBlkxRZb2hEXfHkXlvfU7EHofZg4rE8gQBi5OAZhIDAPD/zxzLy9RFrk2prqC
 V45b99vOS7RbclhosrFGscSzhPj/CkAVdS2df652lOse9nk8OcvVZvraLnnrNVc/JVdP07+yuJo
 LAA==
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Hi all,

The sht21 driver actually supports all i2c sht2x chips so add support
for those names and additionally add DT support.

Tested for sht20 and verified against the datasheet for sht25.

Thanks!

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
Changes in v3:
- Add MODULE_DEVICE_TABLE() (I forgot, sorry for the noise!)
- Link to v2: https://lore.kernel.org/r/20250907-sht2x-v2-0-1c7dc90abf8e@gmail.com

Changes in v2:
- Add a documentation cleanup patch
- Add entry for each chip instead of sht2x placeholder
- Update Kconfig too
- Link to v1: https://lore.kernel.org/r/20250907-sht2x-v1-0-fd56843b1b43@gmail.com

---
Kurt Borja (4):
      hwmon: (sht21) Documentation cleanup
      hwmon: (sht21) Add support for SHT20, SHT25 chips
      hwmon: (sht21) Add devicetree support
      dt-bindings: trivial-devices: Add sht2x sensors

 .../devicetree/bindings/trivial-devices.yaml       |  3 +++
 Documentation/hwmon/sht21.rst                      | 26 +++++++++++++---------
 drivers/hwmon/Kconfig                              |  4 ++--
 drivers/hwmon/sht21.c                              | 15 ++++++++++++-
 4 files changed, 34 insertions(+), 14 deletions(-)
---
base-commit: b236920731dd90c3fba8c227aa0c4dee5351a639
change-id: 20250907-sht2x-9b96125a0cf5
-- 
 ~ Kurt



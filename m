Return-Path: <stable+bounces-178821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B04E4B481CB
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 03:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B68D16FBB7
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 01:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CFB1C860F;
	Mon,  8 Sep 2025 01:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kA9+0/kD"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DACD1A9F8E;
	Mon,  8 Sep 2025 01:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757293783; cv=none; b=fqNB5U3xpPTmXWyWm11e1G7qNmgmY2GUDnvE/MD/DN3wUNJcNi+S7JT+EGbOz4Twp/gnCeYRcGnYHbWa57kvWFFMRcozvdlf8jSbYxwgH8oUJfyH/7ICaq6Rp/LDqIbNEkNA1FnSubiO2xj2Z8KbM3FB67JMm/1F7GsQ/ZrrpP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757293783; c=relaxed/simple;
	bh=UEw4F4LkD49VKclwQjDUiuUfQ+Jf1njAT51SLNuYO2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r4XyR+tRdpFLLZcLwZkVpbjWe6ATYAjmV5Xjz78Fdh71MqGJw0NVJgp9L4yQ5J9jydCJDc3sKkcdSsCSPrjJFopZ2pbKr1qW9NzB2xsLuZvfmoa+R8gr0941EYFWdx1WJ3calCrMUgVm8v40vrMVj79HYscolW10eA947OLJZvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kA9+0/kD; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-544a2cf582dso2888674e0c.3;
        Sun, 07 Sep 2025 18:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757293780; x=1757898580; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pIrWIgaPrpXvy15ltxr3y1zTh70BAC5HdpbmwVt7Qmg=;
        b=kA9+0/kDSVeYFL7+pJ6Xo9iyM+H0YWqrR2rI/xCDP4JOFqtqO7+PlXmRsNz39pSHq2
         6txndIadX9kDelAwYAAlD5Ld7TqvtIHWTHozbF05iAlSmrrNhZAkzJ0+Pr4tj8eA9vN6
         mpqygcPrADDnLpVUAV+7CMqn8WO3T5y4Z9wPwPU5pUDEEqFvMiKTP7CDcjm+d3WLVx+7
         i8OQN/mIJBTokYUgKTXNLXphgzTGYrPlQ2/GlnxW1fmsx5/QAIocCbS+c88AQKmgIzBU
         Dn7IexSpbOhpbtjrLde4NUFyTg0/wDBXItHmedQE0rElGbjWp4CwOWXxQG9D3whh1mHb
         Vxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757293780; x=1757898580;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pIrWIgaPrpXvy15ltxr3y1zTh70BAC5HdpbmwVt7Qmg=;
        b=PtfnVe8HyrfdhS/tS2vgQtXH5dzSOBOf7oz/NHq0qwObPX2QpPI+FCoUQjv82rKmYY
         CglUeMLF2kYCFEI/ajFMnIeG0nwUnsn0Kp6r/Uuuz2nwwMVM0ekAOy8yjc9fya6eo6Q6
         aj5xqffIDknW1td4UbXSAdCDXaCQkkdqaK2832XKoKFRs/BKp79MGcZE6K2sOezmZZzA
         WWeDuyDTw882injI23n8G+ydTOBH4s+gX9K3zPH8XsanSZbFkzPQvwckM9ciXaY0a9E/
         EOIeoqD5U2op3EW79oalqhMqlTOztkUOPa+K6WPmtszzbmdRfOh7OmilcWLLZTkGcRRU
         RwNw==
X-Forwarded-Encrypted: i=1; AJvYcCUypUfwoAoMVyk+gA9UAyxY9oRgLn90vksHprXo8xgzbGiVjNgtWyuXtq0R0GWiV9yN/lXdd3K7nkKqaTg=@vger.kernel.org, AJvYcCWLyI0+ekLL3wCOW4HSAsJogY+hxSlw5fZBynP8YUqoILoUgwNvhU/IXl4jIY+QYcGOYthu34NX0/qCfnW2@vger.kernel.org, AJvYcCWSpQXoreq2qK6Tr1K4SkU6SWjvagQ21E0Xt4oHt6KFqpl+TPlNTJOPqPOwn7Ke1oPupAn6DSuVUQ9J@vger.kernel.org, AJvYcCXTXHJ56x3JR37ETZHEsQ1JqcEjjlNufGfS84htRhIIW//2DGiwkIJN48BvBSoUHhyOQ19EvbjAjfjH@vger.kernel.org
X-Gm-Message-State: AOJu0YywK3K4ks52xmg70mW4ImD+cNRSqKNk38vGktbleoZmBwHH/GH7
	gG0kwzpQxGWH/w5rQlmmtUPihwXazZRSIkwlYsB98eplUtlv18xOVJ3I
X-Gm-Gg: ASbGncumhgu4+6QntcXRPVtdx7GKtlw6N/27HS+02719CZvo7k9wxwJ1GfqGtfsTzJw
	x4adMwnFgtups48rlZfZwSMAxvL8Qw5ei/3HbmJ3XXxuAWq6L1TSaLC5rNmLeK+xMy5VDz8oGlv
	zc5qQxfseUZ8hco3LEKinLfEiZThGBWkLyh1pfaIUAuG9rMUjp75BszXfNt9ZgJGepk8+gPEo/p
	na4BDJvoWZchQWg38sEHq6nauVLuiZ+VNObEZik/PPLT/Yyox9PiqVnuXsvQiCA+WtovlK9dLDs
	uAVWWD+Gm5J9f93RQ8N1ex0bO3Clp1TVGlnaP0PrLXDHiGWokDhyFMUnbHoGEjk+gaC3mc7CxpV
	inTkTT6woFn12LM5wIk89zc3MjIpEI9zneuA=
X-Google-Smtp-Source: AGHT+IFLe/2K4ACAEqfFMhgCmcmRGPPUKBGS0LXWMg90a1ZfG+u0y+dCU9/E+f1eSQ7/wN6jJISEsw==
X-Received: by 2002:a05:6122:4f98:b0:542:9c0b:c5be with SMTP id 71dfb90a1353d-5472abed0cdmr1663661e0c.7.1757293779910;
        Sun, 07 Sep 2025 18:09:39 -0700 (PDT)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-544b1933316sm9152572e0c.9.2025.09.07.18.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 18:09:39 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sun, 07 Sep 2025 20:09:10 -0500
Subject: [PATCH v2 1/4] hwmon: (sht21) Documentation cleanup
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250907-sht2x-v2-1-1c7dc90abf8e@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1311; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=UEw4F4LkD49VKclwQjDUiuUfQ+Jf1njAT51SLNuYO2c=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDBn7dC5UrJ7nurlkuqjjTl85jydiQkzclypOmfFNn8yaW
 TBP6PPMjlIWBjEuBlkxRZb2hEXfHkXlvfU7EHofZg4rE8gQBi5OAZiIRDzDX6ErXXe7zQovxP2p
 vL2vz3+a1J0jUqkHbk9OmizVcfH69LuMDI/UP3OlfQ/eULV+4yWuvFm5PGEFdb+3zCou/LXGvub
 EN0YA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Drop extra empty lines and organize sysfs entries in a table.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 Documentation/hwmon/sht21.rst | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/Documentation/hwmon/sht21.rst b/Documentation/hwmon/sht21.rst
index 1bccc8e8aac8d3532ec17dcdbc6a172102877085..9f66cd51b45dc4b89ce757d2209445478de046cd 100644
--- a/Documentation/hwmon/sht21.rst
+++ b/Documentation/hwmon/sht21.rst
@@ -13,8 +13,6 @@ Supported chips:
 
     https://www.sensirion.com/file/datasheet_sht21
 
-
-
   * Sensirion SHT25
 
     Prefix: 'sht25'
@@ -25,8 +23,6 @@ Supported chips:
 
     https://www.sensirion.com/file/datasheet_sht25
 
-
-
 Author:
 
   Urs Fleisch <urs.fleisch@sensirion.com>
@@ -47,13 +43,11 @@ in the board setup code.
 sysfs-Interface
 ---------------
 
-temp1_input
-	- temperature input
-
-humidity1_input
-	- humidity input
-eic
-	- Electronic Identification Code
+=================== ============================================================
+temp1_input         Temperature input
+humidity1_input     Humidity input
+eic                 Electronic Identification Code
+=================== ============================================================
 
 Notes
 -----

-- 
2.51.0



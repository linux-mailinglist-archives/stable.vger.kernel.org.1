Return-Path: <stable+bounces-151938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA44AD131B
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 17:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4CFF3A1018
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 15:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FBE54769;
	Sun,  8 Jun 2025 15:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0LO+FAzK"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175F04C9D
	for <stable@vger.kernel.org>; Sun,  8 Jun 2025 15:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749397898; cv=none; b=LUCLS7WWNHJibOE/09LQ1EbFYjiOQl/QawiIe1S9HDTtNOp0GfAQVU2TEMSOtTtjFO9MWfoJlXksswYm43QHBC2+LnTv5GRQju88k8J9QcHwy9Hc7dp1rY5F0Q8pwmcygFGORFCL0QQ6cMPf870byNOUENCAGTo/Xr7DPY2E+n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749397898; c=relaxed/simple;
	bh=WvMib+F4JY0LapSvcjduBB71FbNnantAzeQB5eq40lU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KIAQrOAYC3KjZRzE4QgP2jzxVsAwbFBXn16OuLi1H751MLa4PKDIeFsiftc12B3SfDZ83Zym4FZZcVl/mvq9s//ahwS9UmuSr54ZAeih9XAgSmL3wLAmixjItyeQuTDTCuQ6yV//Q5pw6OTGHpL0nge7ZilHNFmQ8B62WHNxE/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0LO+FAzK; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-72c3b863b8eso2756777a34.2
        for <stable@vger.kernel.org>; Sun, 08 Jun 2025 08:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749397893; x=1750002693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8VMYoHY4sNBZjqEJYZBjtM4v+Y4/u4HuAOC1Rz2XuCU=;
        b=0LO+FAzKw7BNLB68a/uGNYbca3Y4hr7yz3CPtlyi/MdsZnonyxYAnWgXFmB2GrVm/g
         XOrCSc9HphufkcXlDoSsCX4HqdUAFEuXvLmy782JPiJBZv7yUIixOCzjlxmQYFVpI/PT
         NkhamYmgSpUpzlJ4P5FBbsaclHMTlyNQHWz3weSOPxRhEiebkMe2fknYqgR1wRe+bdxC
         21NNf2M5yHQIBdBtnGe1pNw/m0em7Bek/C/nVxcRcA0XUbb4xC299AvGy8l/bHcSWW75
         SsPIBJ47gcPf0J5DZ7HXx2hyoILimFhbDAmM+JNfeHZFCC4ppEaftTap+SRYDZ2rBwin
         7GRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749397893; x=1750002693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8VMYoHY4sNBZjqEJYZBjtM4v+Y4/u4HuAOC1Rz2XuCU=;
        b=Skab8EK4+nNqTbSDSdNFUbAp4VwJvEKzTRWR5J1UzHmPK0plV/qc+4QtdIS7fKUGew
         tMvSjadnc+y2NnPZYNbQlOyoaT15mOyoCuFTa/Nx1SNNzTxHXD87ap2IsfS+xcnRj8BI
         niAJdM16spJrtmQIchAQofrhVsQHXA8fE6qpftM4+Hgdqk8sOYMqpsWNM4ZOmCv+/ENF
         TCgdaDz+RzUcxEVeVapPNa21sDE4pDYHoFao2kjnTvx1uOXViZltoARE3s1stCPCKKfa
         Ee44wQLbJYf+U0vAkuzIolCMxU+dk1l97OiHiCMa70T8Ime8tJ09GX71KSaMh0Dk8nwt
         8ukg==
X-Gm-Message-State: AOJu0YzQQO9mJZagZh7yQ6RF6sj4biXyep6U7UJi+ZX9FrgAlDbjds/9
	dXweFTRMd9+tJBExV2+cHvG8QK7Scjz5mJ5PxmXk9UZTu+OLx5QSseaakTjtm8Y048u21IqXJqF
	exRxf
X-Gm-Gg: ASbGncsKqQtW7QB3R76BbQmzM6gu7o2FHeZonpI1JLaQgMbYF+yPToBn43SbSYaDGZo
	EeCLL6NeLP2ybco3+MBCVQs1jTiyp0FdnlSvLfO/twsiyL6KqagEpoMR2SC/Vux+Cb/mlwJB1B/
	ExYCZr4prrCOIMz/6G/4+RPq1qkA8nQZmzyeyo/fuTZkU/21A651FbsheK1sz78Hi1dGa25Ok5i
	oMElx2EbyrDjn2GJ7h+sVkGll4tZ41hqpM+5JIPfPWOe3zOi7BLqxZKuzushviHO/soOy/YxlZO
	dcRRC3nIpyjwr4C3yo4LKIeexjGLhTgNkG/rLq7jX1M9+S41FxPgRnL4JMws9wnN
X-Google-Smtp-Source: AGHT+IH+xtwii8Am45EvgyZTMSwL7g41ySV37fATdJwEagBmlH4ql52HExxM0k5OndB91CtBmWcLFw==
X-Received: by 2002:a05:6830:6602:b0:735:b29a:cac1 with SMTP id 46e09a7af769-73888db3365mr6137626a34.1.1749397892710;
        Sun, 08 Jun 2025 08:51:32 -0700 (PDT)
Received: from freyr.lan ([2600:8803:e7e4:1d00:cc9e:10a2:b77d:5d2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7388a05068esm1188664a34.33.2025.06.08.08.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 08:51:32 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: stable@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Subject: [PATCH 6.12.y] dt-bindings: pwm: adi,axi-pwmgen: Fix clocks
Date: Sun,  8 Jun 2025 10:50:50 -0500
Message-ID: <20250608155050.1517661-1-dlechner@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025060734-elated-juvenile-da5c@gregkh>
References: <2025060734-elated-juvenile-da5c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix a shortcoming in the bindings that doesn't allow for a separate
external clock.

The AXI PWMGEN IP block has a compile option ASYNC_CLK_EN that allows
the use of an external clock for the PWM output separate from the AXI
clock that runs the peripheral.

This was missed in the original bindings and so users were writing dts
files where the one and only clock specified would be the external
clock, if there was one, incorrectly missing the separate AXI clock.

The correct bindings are that the AXI clock is always required and the
external clock is optional (must be given only when HDL compile option
ASYNC_CLK_EN=1).

Fixes: 1edf2c2a2841 ("dt-bindings: pwm: Add AXI PWM generator")
Cc: stable@vger.kernel.org
Signed-off-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20250529-pwm-axi-pwmgen-add-external-clock-v3-2-5d8809a7da91@baylibre.com
Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
(cherry picked from commit e683131e64f71e957ca77743cb3d313646157329)
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 .../devicetree/bindings/pwm/adi,axi-pwmgen.yaml     | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml b/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
index ec6115d3796b..f4eb851b2bc8 100644
--- a/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
+++ b/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
@@ -30,11 +30,19 @@ properties:
     const: 2
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: axi
+      - const: ext
 
 required:
   - reg
   - clocks
+  - clock-names
 
 unevaluatedProperties: false
 
@@ -43,6 +51,7 @@ examples:
     pwm@44b00000 {
        compatible = "adi,axi-pwmgen-2.00.a";
        reg = <0x44b00000 0x1000>;
-       clocks = <&spi_clk>;
+       clocks = <&fpga_clk>, <&spi_clk>;
+       clock-names = "axi", "ext";
        #pwm-cells = <2>;
     };
-- 
2.43.0



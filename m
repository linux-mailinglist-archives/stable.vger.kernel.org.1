Return-Path: <stable+bounces-94498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A659D4812
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 08:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A7131F21FDF
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 07:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83B51C7B8D;
	Thu, 21 Nov 2024 07:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nigauri-org.20230601.gappssmtp.com header.i=@nigauri-org.20230601.gappssmtp.com header.b="nPnFPFsC"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9B01865EF
	for <stable@vger.kernel.org>; Thu, 21 Nov 2024 07:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732173212; cv=none; b=oYWpEnkik82Wyqp0EoPLbYwEA8fGUNwJkuHgCuIs2oG/yQld2QaIHNXFiwFMLMYynR7yH/Kck1dHkFlSr36CPTNZcAKKHjQO7BEFo4jQQqwrOYb6HAc5Ze4eOZdQxyOPbBJ0QWMY55OsCg3vEvk+mieVynyb+aw4E8JYTfK0s1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732173212; c=relaxed/simple;
	bh=EJF/0GRK8gCHAuxzBGfX3/SDOj+YnZQWV+rfBX8YA5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jRaRnyVKat7T5fLoYB+YahzuolgLkjHqn9HIXLAcY0r3gi/hKea041rI1ogOTAFb+oku/LrpiEQKYPqnaGU6AhNCorHpyTmOyZMl8HoneirmXkP9u5cBPAKw3n4+4ETtyHYkEoCaQkrBLZxuodZCZUrnmIIL3ewCpVYOyheG08U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org; spf=none smtp.mailfrom=nigauri.org; dkim=pass (2048-bit key) header.d=nigauri-org.20230601.gappssmtp.com header.i=@nigauri-org.20230601.gappssmtp.com header.b=nPnFPFsC; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nigauri.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2128383b86eso5227655ad.2
        for <stable@vger.kernel.org>; Wed, 20 Nov 2024 23:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20230601.gappssmtp.com; s=20230601; t=1732173209; x=1732778009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LFNrZw48YC7Nd4NK6Qt7/KlvAITIs4SoN8m0X5EQI9c=;
        b=nPnFPFsC+J/+hF4W+Ru3h7KjpefhxfDMNTwHu5V9v1RCK0piQ5jpRsTb/lva8JqZal
         3aMuggZHm/XNwjj2Fs/QaLjV68Z7TqyMIzMUIlDjMEfGCNm+twoxwiTpT1D3iFI91p8W
         3117VlGLI7jfHBT4MDPmopG0RGnTzsi8jQTTc+Lf8tuFAI5sdGS3fETWSsC3UjcuoeEP
         V8goeAmZ9MlB/4Tpjw5wovJ/feYLml4AQc7/rKMW5NjuASl2BWEEB+cziRfBWuporld4
         /Cj3rwNm2GvSyGwVpjZYjb7kEtVk6Ilfem94BakfOXpC9udtXC+McmaH/Bn4WKffvB69
         jYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732173209; x=1732778009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LFNrZw48YC7Nd4NK6Qt7/KlvAITIs4SoN8m0X5EQI9c=;
        b=cLU6P6ydQ1FdC/0sVBGxH+UXxueep0XRNiOthDx6FlSovAway72C/0APfHHobcqyIM
         ztXn/i15xVVNGLqqZ0Z9XFf20tUY77Jyk1TE+DLkcY0Cjcj9OA0k/LVBVMu9vVmpv1Jh
         4bjRImdCxw7E846OPPjIo5rdFyLMTQmSBMR37Uhlx16mI/rh41RUbW10QxzdTAAHAxU3
         sR36sJKmS2DcrEaxN7u6T2XcS+rl3Z2HezKZ4u9oXG7xaKWdtgTB7fu1DBqQLy2dTEzB
         M098p2/YZT/JadAwJ5yGoz7DpCZd+WOutKI+pgmbVpf6mS6wkv5XeL0ioDC5UzfFzXvy
         hjCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwM5s4lR8O70IRIweB6ZGUPGzUwDjjrGYIXdcG2FNyN0JWbV5kU0oztO0zENpXNCGWkuTjzD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6M0vr3w3vQZ0bh22www72HaL7CH7bC9Ujb3IeBQDDaWbV0HzL
	HIG09aMI4mUBQXK6WGxZG+B/T0tTD7ovXPQCyv7SBFeyK06k3xoPAIJhq8L1
X-Gm-Gg: ASbGnctw45jvGYZUKgHAWgIGuUAhrD6b/sJDC5zbWbDUIJ3f0bTZYksZdnUjZT5ttkC
	WvRK6Myo1pydWAAadikbWbx9Cl44jAEZ4QH8/Une22kpnwEXV+Xj9lQ7ds8pzLnZ5aMDXhfypiN
	ar8BrqjuDbYAGENR6BY6yRbym7CWwfXvcX9KyFJr/IZUeEGdMBvikt2Xx0YdusOVWVOWGt2mImG
	Dz7YheYldk1eDQilLfM+byvtFUxNl5mo/W0CzGp1T9i/VXyK1w=
X-Google-Smtp-Source: AGHT+IGLelbtxaQE3NcbOHx4mUq3l9XVdB1+aGkET78P0R+07B/6hdLZ5zog+84Wtv0TlE5OHYP81g==
X-Received: by 2002:a17:902:f707:b0:20c:5b80:930f with SMTP id d9443c01a7336-2126c0b946bmr72891265ad.12.1732173209619;
        Wed, 20 Nov 2024 23:13:29 -0800 (PST)
Received: from localhost ([2405:6581:5360:1800:b535:6545:798f:8db5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-212883fee10sm6709725ad.264.2024.11.20.23.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 23:13:29 -0800 (PST)
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
To: dinguyen@kernel.org,
	robh+dt@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: [PATCH v2] ARM: dts: socfpga: sodia: Fix mdio bus probe and PHY address
Date: Thu, 21 Nov 2024 16:13:25 +0900
Message-ID: <20241121071325.2148854-1-iwamatsu@nigauri.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On SoCFPGA/Sodia board, mdio bus cannot be probed, so the PHY cannot be
found and the network device does not work.

```
stmmaceth ff702000.ethernet eth0: __stmmac_open: Cannot attach to PHY (error: -19)
```

To probe the mdio bus, add "snps,dwmac-mdio" as compatible string of the
mdio bus. Also the PHY address connected to this board is 4. Therefore,
change to 4.

Cc: stable@vger.kernel.org # 6.3+
Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 v2: Update commit message from 'ID' to 'address'.
     Drop Fixes tag, because that commit is not the cause.

 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_sodia.dts | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_sodia.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_sodia.dts
index ce0d6514eeb571..e4794ccb8e413f 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_sodia.dts
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_sodia.dts
@@ -66,8 +66,10 @@ &gmac1 {
 	mdio0 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		phy0: ethernet-phy@0 {
-			reg = <0>;
+		compatible = "snps,dwmac-mdio";
+
+		phy0: ethernet-phy@4 {
+			reg = <4>;
 			rxd0-skew-ps = <0>;
 			rxd1-skew-ps = <0>;
 			rxd2-skew-ps = <0>;
-- 
2.45.2



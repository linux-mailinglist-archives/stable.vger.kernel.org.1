Return-Path: <stable+bounces-147944-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB07AC681E
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 13:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BD571BC55A4
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 11:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77E727AC54;
	Wed, 28 May 2025 11:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqO5PhzB"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C9B27A139;
	Wed, 28 May 2025 11:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748430481; cv=none; b=i4N0NrLxGL9cz8ohGiqvFZQGXAOCytZAlpILo9GRw6O0sIRT5FuYbm1pC0uOM6Xgs7/B6udwolFmyC8TqIjJ0ynSgHdXzRf0TSAHAjPWW/zpOuKkcQVXCQUf2w3zwq1LpclGlpDZDPCzWEfY7UL2TUvoflgTKntzsUom6ycEZlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748430481; c=relaxed/simple;
	bh=R1Eh8RWRdVlzRqbFs9zMJ1Ckr8QstB1hZzkYJUC8K+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EnpL5x2RSmZMUBDkjuJahLMi5/FpEpyEldzgL74dIiB5eh4owT0s1kcq6QKStuOZJTpVVm0JHxoFLowwdQZw46Bz6MYlmV3NotTOPkHt05akLyPSzAQ7z11ZkkvdSrLOlf9QMM9oq8z8boj2P6B2nUYN63CCQ4nBbVySPfkFymo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqO5PhzB; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac34257295dso862230666b.2;
        Wed, 28 May 2025 04:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748430478; x=1749035278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0d9IobXiw91z9fWsL1fagf4MsIBeTY/sxiexdnW7zM=;
        b=QqO5PhzB4fOP6WymG77V6rQj1dIKhtDHPM0s+pB4s6J/ymWPFlra1HOgX3/FjQaJwn
         V7u9XHEZB082s6g9cYwylOOd9X98dE6mxFGBe68X9jRYOCLGFdF74cm5+69bU+fg3IF2
         IVqgQbDvcRJWO37rK9JPqVTbNlmGuyDCTV6YuOziJMFTF4zvxBKaJ/OS/Jqhke5AvnVE
         XYSFD2NqLGTYtRWdCaR5QoRl/qytU2iR4By0tp7SWtDNjpOsyg07Z/73z92WxiAiEY/Y
         Ut8ytzrEl8knt9a0LpWbAeVWowk/pZDaKMNbw/ZdhEHMvVT+nZ+Boifqdo4QHhPvIBKi
         Hyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748430478; x=1749035278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y0d9IobXiw91z9fWsL1fagf4MsIBeTY/sxiexdnW7zM=;
        b=jCnZIzCpaefnNhMfqF4TOBQlD6THenY5F7/6hVW3VihQ6vl9TOfxTKGrIY93nby8Ag
         s8RgspB43Wr+hfytAkNSOWfi3kPffGSWvqbkvXICasJeIoz/JEpDIvngYwKk3cOqfKY3
         O4+oV1p+ncRfwyxhMjS2qWvxDny/yr3J8KAO83IkZdd7d2h7Bbl9IKykPw9Wv8JPBpyu
         /xtZxdNq0LdJUH188EVh9DUPimAhnkSSI1ou6ywb+H6W66L5ePC9+p2COvD2d3K3qtBn
         YtDp3eaQ3iXiSuRdg/oU+3oXswdtKlv2c7Gwf6TPO1MARX5E1U8Vx0iZvHMqzDTkW+vq
         yuQA==
X-Forwarded-Encrypted: i=1; AJvYcCV0qLidIPmOBN3LjG0GJqeYiEciPC/9c1TyN2UJvkzNJ6TU2MHPNmwagXh2uLdw1/i44eqEB01i@vger.kernel.org, AJvYcCVZ0dPiq2dF5d3VDW0RBYJ73fSdqpWpGQ0R6agdCBfp54Yn/cuBIHmhl0ZcHhRmhYx6wIcaXeyH0nVb@vger.kernel.org, AJvYcCWItNOLnrkyK9o2Ob0pETkp4NyL7qwfoWp2RWOHtqig8gHb+VzX0Hh1cm6Hoj3xyVPOJ/EsZfsB01MGSTmA@vger.kernel.org
X-Gm-Message-State: AOJu0YwNQPNL0cjhGA3v+kT+cFL5K3x5plyAPF/D6mHmIvDOvWuLs3MY
	PtppMf42LrP8GWHL46Wmu0pu4keOJO/Jm0XbBCelZ/AVrdYbKUcbH9Gs
X-Gm-Gg: ASbGncvc/lME3aAIBld3psDO6KqKyU7R3jEGv2fUirD04YcNA2Xj+YN5ctgBSolvE29
	EFUX2fdjhXiORtb0VAIHv8wqCjG0w/HCtAxGPyoXiEg726jXv5ldrOyuLYUe3KT/nJ1bmLKArgw
	R5Ywx/qWF/ibcKZLZXbtd34c829sT7sznwsSQOYFvdwIJznoLe+eBSFfJgLRTJUtan3PMwkrRXe
	OTL/D0u9fuBzV8SRJk9aujMslwPysWNRSEJ5GYwCzqZ4joIdnmYdE7ATaxvB+dGdh0DxI8dtQkP
	j0LW6HpXqGt0YbatZF1sunlsVYAjQ9au7Mo1LgqxUykn3MrjtAOHCiEm58mZhvvd1PqWuSGO
X-Google-Smtp-Source: AGHT+IEtyhnn9NHAemtfJzTKjrsDVohoBEwPwSRjHx8mSKQZYwXz0JyxONi4zbTF+2+ejSAk/iafmA==
X-Received: by 2002:a17:907:7f17:b0:ad5:2137:cc9e with SMTP id a640c23a62f3a-ad85b120246mr1545273566b.3.1748430477700;
        Wed, 28 May 2025 04:07:57 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:aac:705d:5a2:70b0:c9d3:7010])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6051d5d9765sm626908a12.8.2025.05.28.04.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 04:07:57 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1] arm64: dts: ti: k3-am62-verdin: Enable pull-ups on I2C buses
Date: Wed, 28 May 2025 13:07:37 +0200
Message-ID: <20250528110741.262336-1-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Enable internal bias pull-ups on the SoC-side I2C buses that do not have
external pull resistors populated on the SoM. This ensures proper
default line levels.

Cc: stable@vger.kernel.org
Fixes: 316b80246b16 ("arm64: dts: ti: add verdin am62")
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
index 1ea8f64b1b3b..bc2289d74774 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
@@ -507,16 +507,16 @@ AM62X_IOPAD(0x01ec, PIN_INPUT_PULLUP, 0) /* (A17) I2C1_SDA */ /* SODIMM 12 */
 	/* Verdin I2C_2_DSI */
 	pinctrl_i2c2: main-i2c2-default-pins {
 		pinctrl-single,pins = <
-			AM62X_IOPAD(0x00b0, PIN_INPUT, 1) /* (K22) GPMC0_CSn2.I2C2_SCL */ /* SODIMM 55 */
-			AM62X_IOPAD(0x00b4, PIN_INPUT, 1) /* (K24) GPMC0_CSn3.I2C2_SDA */ /* SODIMM 53 */
+			AM62X_IOPAD(0x00b0, PIN_INPUT_PULLUP, 1) /* (K22) GPMC0_CSn2.I2C2_SCL */ /* SODIMM 55 */
+			AM62X_IOPAD(0x00b4, PIN_INPUT_PULLUP, 1) /* (K24) GPMC0_CSn3.I2C2_SDA */ /* SODIMM 53 */
 		>;
 	};
 
 	/* Verdin I2C_4_CSI */
 	pinctrl_i2c3: main-i2c3-default-pins {
 		pinctrl-single,pins = <
-			AM62X_IOPAD(0x01d0, PIN_INPUT, 2) /* (A15) UART0_CTSn.I2C3_SCL */ /* SODIMM 95 */
-			AM62X_IOPAD(0x01d4, PIN_INPUT, 2) /* (B15) UART0_RTSn.I2C3_SDA */ /* SODIMM 93 */
+			AM62X_IOPAD(0x01d0, PIN_INPUT_PULLUP, 2) /* (A15) UART0_CTSn.I2C3_SCL */ /* SODIMM 95 */
+			AM62X_IOPAD(0x01d4, PIN_INPUT_PULLUP, 2) /* (B15) UART0_RTSn.I2C3_SDA */ /* SODIMM 93 */
 		>;
 	};
 
@@ -786,8 +786,8 @@ AM62X_MCU_IOPAD(0x0010, PIN_INPUT, 7) /* (C9) MCU_SPI0_D1.MCU_GPIO0_4 */ /* SODI
 	/* Verdin I2C_3_HDMI */
 	pinctrl_mcu_i2c0: mcu-i2c0-default-pins {
 		pinctrl-single,pins = <
-			AM62X_MCU_IOPAD(0x0044, PIN_INPUT, 0) /*  (A8) MCU_I2C0_SCL */ /* SODIMM 59 */
-			AM62X_MCU_IOPAD(0x0048, PIN_INPUT, 0) /* (D10) MCU_I2C0_SDA */ /* SODIMM 57 */
+			AM62X_MCU_IOPAD(0x0044, PIN_INPUT_PULLUP, 0) /*  (A8) MCU_I2C0_SCL */ /* SODIMM 59 */
+			AM62X_MCU_IOPAD(0x0048, PIN_INPUT_PULLUP, 0) /* (D10) MCU_I2C0_SDA */ /* SODIMM 57 */
 		>;
 	};
 
-- 
2.43.0



Return-Path: <stable+bounces-203483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 319D6CE65A0
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 11:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C6ED301766E
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 10:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F852868A7;
	Mon, 29 Dec 2025 10:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PM6RWlZh"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE1D26CE34
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 10:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767003149; cv=none; b=B7N07P598tk+xY72YTxVg0w0mS+1MpiAlKHSCxk3ZdVPa6h6aC9xT0gos6IOwYTqI22np7TIYD+kyRLW1qk/RT0UIfd9vQ9nsc1iYHMfsoCPuAdRKlY9l6vXjK/Rj73ji2Kl7VXrvH5RL66OxINAYoTjSMwnOWsSkt+fh9Xk61M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767003149; c=relaxed/simple;
	bh=kx/5/gOv+LNdWrQToOMBSk2+QPj07MLFLi9t/6wsj9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=smsXRCAyxYIR3kwfN4X54iH/ji/Ub5ryIUU36hLbN/8RaCE+v1NmC12xXutzhiv1mueD27VQtGWWTtb4th0GxO392Jxd4RCeRrgkNb7LkR91dxC+fWB5GHUOxJkVe5qNcZ/v2k0b8Rol36YWX2ibToEstZ4wlv8y1yUY8yhA9do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PM6RWlZh; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-47bdbc90dcaso55741095e9.1
        for <stable@vger.kernel.org>; Mon, 29 Dec 2025 02:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767003146; x=1767607946; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hmvq8IpMPngxZJ89oRl/9976MSq6MvT7IIFrbZGP6LM=;
        b=PM6RWlZhURa6CUNEkW/ThGoGtt52JmiCJFQBBzkqz/mrKxnZmvyUyw/WKV7JhDI/6E
         BHDF/hvxtXyNn+2h286aO1T7HXANgD8vjINs7Jgt2PwLVBe6ErVkFfbPM18AfyZYasDh
         068GVv9TjiOWKI3zh8AUjBw3apomJ0ztzZOYKtreEBULaJB1k0HgMPh8niMm0Nz4ibEi
         t4ZES7YPsJSsmxleEtXYgAa3LPJLoayV919fiz93940n7LydmLGs2A04/os5l2cgNEOF
         ArUvlcBEMVoQ5so1tBAx7hd7oAPZRadWHLG5XkQasaJlqkhzHlWnAV2d+vPT87baCWXs
         ImQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767003146; x=1767607946;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hmvq8IpMPngxZJ89oRl/9976MSq6MvT7IIFrbZGP6LM=;
        b=EY+HP3R9f/ho9I5Bo9qaOiZCmjxjd0yohprfXmzANJlb+9OVan/1Sx8uuWacDtqV/T
         6fhV1ZO5KYrw3dv/HMeru0e0S0/vVVWS6sLtAHVxhCflewqk1l54j/L/vJyL9AAppFvv
         HlfePeNkUAesQmkF6d0T86zU+IKhz4hO4AdDN45lqrujbQkrBdL2yG/TN4EkAWx0x0HV
         KYoZvd7vm+YXn5KSmzaD/EXJ8fKGO/iBg3fhZrL382VC19fXJ2TTLfhIQP2AkhPE49be
         k0GR0N+Gb/jpZjimQf6w3LOHDGjL5mcg3JjwRP2WjoTvtocorDayjoyz8s4kq/vYv3lX
         HKmQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8IWwNsNtdzPjqX7WwIpVtxgmYcYF2aBmWX7fV1shKWWvBdXbUK7fq8xsfkgeg4aFxCTdkC4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6MlcjEcy6gpY1XqgibvOpJIWCQR6Gk+fnnL/AJg8AwYpbh7Fx
	cyktmf0TBAeFRJzyrGuU7dDBFR1gs6CE8gjVAEDauydj58y3DDHBoOF2
X-Gm-Gg: AY/fxX5RzX3bGKe7EAvVn//UdV8KTVj46K5Y3ISUSgcz5YUoOPmap4JVDq/pYZtZH+V
	UUY2gtJ56I57FY0Yna6lDUzVc1HoUcB4Soqrs8bVuedl81bTeUUNeb3VnKyBv/SJLJpe//I1A4B
	XwaIKPaiMt9Er10BI75kjDAnhOWqKlaNC3E6lWciHv5RL8muDE6Qmg9bl9Md6rcKMo235iq2Cp1
	2J/5ywMVgJj6tU3GQiLF8fleVqzdjUG2ot3vKke6Rpfv6Vh7UFrHq8jnEk2zMVMcFxh3PchbF3H
	c6Ts53/W6nnP06xgU3A/PyVMWOvEwTMSwsoYuZUJL849A6nt4NFX0IlHrjsBeMXdH1EIhI3/gHi
	iol/omMLoJZmUM7K8tFQ8+WiFgectNG8vjXNiqqvBk6lYY/VpXZKcLbgo9SisL93dys2qVFHUCs
	hXbBkHRO+hZXdvc5F1qvHJT4wcNrWYyMrTdwcqCtjos8vcuitepzata5/87J8r
X-Google-Smtp-Source: AGHT+IFAiAe+PhS2idEv0Ey0iDrFQE5elTI+8IG4cgjiYqs9uTdQ4Loam7NpxEwNgCGYGm4L7lRjHQ==
X-Received: by 2002:a05:600c:1d1d:b0:477:9dc1:b706 with SMTP id 5b1f17b1804b1-47d19576d2cmr308387215e9.19.1767003145527;
        Mon, 29 Dec 2025 02:12:25 -0800 (PST)
Received: from alchark-surface.localdomain (bba-94-59-45-246.alshamil.net.ae. [94.59.45.246])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d583f42dasm19840735e9.6.2025.12.29.02.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 02:12:25 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 29 Dec 2025 14:11:59 +0400
Subject: [PATCH 2/7] arm64: dts: rockchip: Configure MCLK for analog sound
 on NanoPi M5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251229-rk3576-sound-v1-2-2f59ef0d19b1@gmail.com>
References: <20251229-rk3576-sound-v1-0-2f59ef0d19b1@gmail.com>
In-Reply-To: <20251229-rk3576-sound-v1-0-2f59ef0d19b1@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 John Clark <inindev@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alexey Charkov <alchark@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1919; i=alchark@gmail.com;
 h=from:subject:message-id; bh=kx/5/gOv+LNdWrQToOMBSk2+QPj07MLFLi9t/6wsj9I=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQGhTCKJ9zceEbqxZ/308R56qbLu/Ra14Txnm7u0bLLq
 2y6xZrVMZGFQYyLwVJMkWXutyW2U434Zu3y8PgKM4eVCWSItEgDAxCwMPDlJuaVGukY6ZlqG+oZ
 GuoY6xgxcHEKwFSfUWT4wy8fvvBDn9NR65JzTw3m7Ar2a3y/fg+HZYS43d3Za85M+8/wT+nqtWu
 pwToNs8I/tjzh+vay0GnLrlszBc92pK9K+TBxCisA
X-Developer-Key: i=alchark@gmail.com; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

NanoPi M5 derives its analog sound signal from SAI2 in M0 pin mode, so the
MCLK pin should be configured accordingly for the sound codec to get its
I2S signal from the SoC. Request the required pin config.

The clock itself should also be CLK_SAI2_MCLKOUT_TO_IO for the sound to
work (otherwise there is only silence out of the audio out jack).

Fixes: 96cbdfdd3ac2 ("arm64: dts: rockchip: Add FriendlyElec NanoPi M5 support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3576-nanopi-m5.dts | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-nanopi-m5.dts b/arch/arm64/boot/dts/rockchip/rk3576-nanopi-m5.dts
index 37184913f918..bb2cc2814b83 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-nanopi-m5.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-nanopi-m5.dts
@@ -201,6 +201,7 @@ sound {
 		pinctrl-names = "default";
 		pinctrl-0 = <&hp_det_l>;
 
+		simple-audio-card,bitclock-master = <&masterdai>;
 		simple-audio-card,format = "i2s";
 		simple-audio-card,hp-det-gpios = <&gpio2 RK_PD6 GPIO_ACTIVE_LOW>;
 		simple-audio-card,mclk-fs = <256>;
@@ -218,8 +219,9 @@ simple-audio-card,codec {
 			sound-dai = <&rt5616>;
 		};
 
-		simple-audio-card,cpu {
+		masterdai: simple-audio-card,cpu {
 			sound-dai = <&sai2>;
+			system-clock-frequency = <12288000>;
 		};
 	};
 };
@@ -727,10 +729,12 @@ &i2c5 {
 	rt5616: audio-codec@1b {
 		compatible = "realtek,rt5616";
 		reg = <0x1b>;
-		assigned-clocks = <&cru CLK_SAI2_MCLKOUT>;
+		assigned-clocks = <&cru CLK_SAI2_MCLKOUT_TO_IO>;
 		assigned-clock-rates = <12288000>;
-		clocks = <&cru CLK_SAI2_MCLKOUT>;
+		clocks = <&cru CLK_SAI2_MCLKOUT_TO_IO>;
 		clock-names = "mclk";
+		pinctrl-0 = <&sai2m0_mclk>;
+		pinctrl-names = "default";
 		#sound-dai-cells = <0>;
 	};
 };

-- 
2.51.2



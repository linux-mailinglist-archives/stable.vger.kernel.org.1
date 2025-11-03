Return-Path: <stable+bounces-192169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E450C2AEEE
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 11:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78D6418890EE
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 10:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D872FC013;
	Mon,  3 Nov 2025 10:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVRBuVGr"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0702FBE08
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 10:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762164652; cv=none; b=EZ2cWFxA6DbBCVVLOsJDSB+ZxIXE0gyLRflgimkOesypT4i6LiFNrze0WuOGCDUpijJHe+7i3bZEUzAH1YdPd3D52KfM7Ku2j3ejp8SvEAfrUeYH4RcvpyTCT2L8YPlQGoF8cUg5Q1pLkIk7Tyd81PI0DMitvZn6hPProM8L5nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762164652; c=relaxed/simple;
	bh=YZ0ojGYt3eCDO/HUdW0nz88xzXZshjZON5FlPoSKhHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rD7kOuEie9mlQTZgt9eEza/0t1zhsfI5nlohLrBzZzdvZhgoQqjqzxRhbI8PHckntTsdBb68PA/r5KthBbcJ/3M4kjK51laz96qgYYVfPhLoTqHODwYmd2aDXdEx7EzewHipINsXwGJ9bQLLy+soLWG4MJQ1cmgssusubli+AG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVRBuVGr; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so783011566b.3
        for <stable@vger.kernel.org>; Mon, 03 Nov 2025 02:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762164649; x=1762769449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zV61ssPxcQ80Vn+xuEZISQ1ICnJDQBimD7YTtlxO9tk=;
        b=PVRBuVGrCo6+wB6+92zX4VJMgPZg8Ywd/lAhbQjKEZNzQTuGgykh+Aywe7s2m36Vae
         qUVteaNnnqddaXNLTttHHBgVFuKIg3ub9ZjJ5i1zJt8BZ4FJndCrbg2jifKRQcUdaFk/
         7lB5q4yvd8viX+nx2fhYYBETx5sXuK0eN3We/HTRkdbkHItybm5Ze3cZmH4ECD6qlYDf
         mWQ3XSNOgruuAeppE1NjIvmaRjsFgGiQry/vamuDy1im5KzSkOR4ndUyh/W1o+5rYv7v
         BM1SBVNVTjOysmnXbT7AQPzApJiT0y3mIoRc//C1P/BRuz/EobplVbBHBWtwlrJtGpaD
         QXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762164649; x=1762769449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zV61ssPxcQ80Vn+xuEZISQ1ICnJDQBimD7YTtlxO9tk=;
        b=sr8tTxarsiNZTRsJO/0YMjJBPilO0GbZqBzq/kspIxtnlLi1/hw5vfHN/K1Ih9yOBN
         eexJ3E7SmLnUg9wz/wh2Ha/ZrgqmrOxLQuPMWi9MxCG4VfjvJMY05MbcbvAkhsv0H5Wb
         +1vwOJ+wagi4Ryjyj6dTG1LzRDD8zJVzhOX/pBK+GeIHPyJtrYM3JmeYXN+v+6f641GW
         vEuynOrK4mikluHJpmgOgWt5RL103Vsp/Cp+wa4dwWnsviF2lSIpwCbEaJ+dEPGok6is
         O98IYgkHqrlTAG9UVLhABXvEIGF90X+40XmBM/4IzzwHmA8AQkalV5pFVKdeTzLs7YNR
         C5NQ==
X-Gm-Message-State: AOJu0YzUrwcBv+2FoNcVVc7hhNeUlwvzWuXpOmZ0tKs99wKSwhOQ55pX
	JE6RLnfzWz580Lpsu+v5zLT6P7HYpTQYxESGYbie82QUo0xafEjdHreu
X-Gm-Gg: ASbGncvszn/9DF70XgrXCLXXOMOtNHbgiic72leD1ztUpjUCiQKSCb+KG89onN1iwSz
	xS9Dl85AKozISFHMR9Xyolu9eEaMCndDyUimlaVmwozxbeG9uuOVhdqqliReD6v9GfQpwQ+CO0j
	ec0bdsW4Yq0Ao/9bb84fCrpNsI4AMvit3A7S2FBXQaWAVh1Z8pV/LGciVYgUL1Ubxw/KjeHiaTT
	2FDFkhqun5UbdtUi7u/NBmDp/OYOGiJFXtlxiV78YPieXrBfJsMCNBpqveYFPyPXqvjGIpzF/l+
	TsWgfGpqvI3W4u5OCPxsWlafBzi26/RyAdHjjRm5bOwOcJTTdTLHT+VsGevjCTpZs4c5TCOFpj0
	5OpJ5FgU7bOlq2y5wztZe0edo1dkunntvgTqva3BpIjm1/BfKAsVscizHzx8ZUPvDMJAU9UoY4V
	W87UEiFwhBVa3/5K133R7+u5E8t4wUfn9dSpoZGYUYa5F85CLOeTKNew==
X-Google-Smtp-Source: AGHT+IFp+T/Nu357ftkE83jIAMW9+xcbhTQBIaVYYeJtQz1ee/caz6rCsgqFAGPZlpwzilmbvSJQ7g==
X-Received: by 2002:a17:907:2d25:b0:b3e:5f20:88ad with SMTP id a640c23a62f3a-b70701c3f34mr1227300566b.28.1762164649077;
        Mon, 03 Nov 2025 02:10:49 -0800 (PST)
Received: from EPUAKYIW02F7.. (pool185-5-253-81.as6723.net. [185.5.253.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b718f8b52fdsm66758666b.18.2025.11.03.02.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 02:10:48 -0800 (PST)
From: Mykola Kvach <xakep.amatop@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Michael Riesch <michael.riesch@collabora.com>,
	Johan Jonker <jbx6244@gmail.com>,
	Muhammed Efe Cetin <efectn@6tel.net>,
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2] arm64: dts: rockchip: orangepi-5: fix PCIe 3.3V regulator voltage
Date: Mon,  3 Nov 2025 12:08:14 +0200
Message-ID: <9232ae8cc8e7eb4f986734c8820f44b7989b9dae.1762161839.git.xakep.amatop@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251024173830.49211-1-xakep.amatop@gmail.com>
References: <20251024173830.49211-1-xakep.amatop@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vcc3v3_pcie20 fixed regulator powers the PCIe device-side 3.3V rail
for pcie2x1l2 via vpcie3v3-supply. The DTS mistakenly set its
regulator-min/max-microvolt to 1800000 (1.8 V). Correct both to 3300000
(3.3 V) to match the rail name, the PCIe/M.2 power requirement, and the
actual hardware wiring on Orange Pi 5.

Fixes: b6bc755d806e ("arm64: dts: rockchip: Add Orange Pi 5")
Signed-off-by: Mykola Kvach <xakep.amatop@gmail.com>
Reviewed-by: Michael Riesch <michael.riesch@collabora.com>
---
Changes in v2:
- add Fixes tag and Cc stable list as requested during review.
---
 arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
index ad6d04793b0a..83b9b6645a1e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
@@ -14,8 +14,8 @@ vcc3v3_pcie20: regulator-vcc3v3-pcie20 {
 		gpios = <&gpio0 RK_PC5 GPIO_ACTIVE_HIGH>;
 		regulator-name = "vcc3v3_pcie20";
 		regulator-boot-on;
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
 		startup-delay-us = <50000>;
 		vin-supply = <&vcc5v0_sys>;
 	};
--
2.43.0



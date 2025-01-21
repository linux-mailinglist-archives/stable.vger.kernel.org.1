Return-Path: <stable+bounces-109611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BF8A17E1F
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 13:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68A453A3F19
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 12:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E476F1F239A;
	Tue, 21 Jan 2025 12:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="XpLvY1dk"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A6F1F2376
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 12:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737464181; cv=none; b=ODunl+2vk6W96r/XGJvb/EAta7B/3vSON8UFFemkQXIN58hT1yWdyZRP/ftkAmAhdJVSq29cBHg1TtWOLfle1Rm7o70mzxpdo2r/o46Cn0ai+o9qmYBevRw43czlAu5alzzcOL+hBNHcReiY9xcfRbE9oNlZoUdfTtfec343oO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737464181; c=relaxed/simple;
	bh=zkCwi5FnK5wPCkeA+FruP2G2sZBycMp67B53czYr/6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EpvczdEH/5yN7ZdLgtIl+h3E8wGsvO3cFC6dvFzwHG3XAMwUF0YixeyLsmUmA/i2bl8lHkVbl6rH/Uj7rYQx5jJS9ATELPTVdKozNgjkB3r1BxIac7LwL0Z/YU5Rttnr47bh3+NKKIZsKqnrrix0T7I5OVM3POtrP7yboeURe10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thaumatec.com; spf=pass smtp.mailfrom=thaumatec.com; dkim=pass (2048-bit key) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b=XpLvY1dk; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thaumatec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thaumatec.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d3f28881d6so8184738a12.1
        for <stable@vger.kernel.org>; Tue, 21 Jan 2025 04:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1737464178; x=1738068978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RiSS1nYpUCNiSeYMCfYpcAR25/sptrb9q7TkmxVtubc=;
        b=XpLvY1dk2L5JB0bcHjksR5QgHP1TWAL0Rpg1CZsLqGmpoK1nNbDrgOwPyuqSShn8MO
         GPhHAExIYl9VYszhRja4X0PXJLXaN+kWJByCxiYbJhZDJvKmsaQ2z1Vh+cL1x5v/+Xrk
         9ei5ZaTRZOa72EYGzx+c4Q1h8xwbbN/Wpu5pQJAnDNM2kPVd9Y5fAl4uLIUlncPgq8+W
         Wl8lzBnn72LCtFkw8MdVXGSILgayIFC/XfyaDtw/7+8EwNPAtwkjlHTfP+ydHzMAIfz8
         s5DHGsK2yI1Zmtkt0ho6P7ViRvmwazjJwehimtRINSe0JiLozsiWdZ5xW0MwyD2zQWXO
         4Fug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737464178; x=1738068978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RiSS1nYpUCNiSeYMCfYpcAR25/sptrb9q7TkmxVtubc=;
        b=J5IHAuu2lvnK2dRhZzYFSpucxWzd5X7gYjiG6O2IEU+Wq3wwAgjhq1vczMIC+022Vg
         Qhte8RgfZ4l08C8AZm7NFF9X5ne2O1r9/2YPFqkIbjiAWWGJ1W3DY2tcrtBVekLoxVNt
         tpNfKfnv00qbJszPt4vGE2S2ssAp0j5PNWB09Aaa8RD2N1WNTRI0E8+73khlwI3/7e1T
         /hlo51CdqIqFqYgkERXfp4ck+R0sNa7imPUhe1vvdrEr9z3OxfuP+mXU+g/R7z6cNovl
         rDMHoIqj/qPevpr+DuHSpCxL+YybP/nKVpgk2Xow05Itbat11NuF5Vv9a5eAuT9MEPWn
         BbOw==
X-Forwarded-Encrypted: i=1; AJvYcCWL3wJ/leqYzYlvCgnr5llmt5BzFnNwDTAVLx1laYas/ZKkYDjD2eaZrxMwiE9CdHq+acGy9rE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTsH5M9D+0IPmk5Lld98kUoPPEb+donOntzQwOEZWorSnt+64N
	Qa6vetuiFMMu0lCVICgA36Qs6XWso74Ua/E82GMJHCmin/jnVjJL8vHQHzc1w94=
X-Gm-Gg: ASbGncsEYuq/G+ayRNUifQZFakcVkZFbJA5aaHKK8PHl0RTkOoMtJm/Hv8s8T0LGRcC
	FpobewrEYlzpzUACkWybQJoT1XS3b5btWG1GOyO2He4DZon7ZNV0aEdekcuB0ntKqSy0O3o0via
	2lXMvYqphMA0GTJqnHYTwHGuAMHXwu9uTC3f2Fh5g6oVcT8vQJFCTEynOvRgH/Yx3hA6FeGb3cY
	F7AYQLXUBaQIKVGGitdwnF+LnOj/nSqLxdhM6woYjN78QFVQBs5mjVTYe176JO+GpxCQ0sEyH0P
	MGAX0T0SeaEDuwFMOJsuPPQEDw==
X-Google-Smtp-Source: AGHT+IGNUrQ1owGiuycreL+ecfL6xNDC4NN9qxkE8FnFn4B+VO++Fb989ERQC0artIbK2G1crar2zw==
X-Received: by 2002:a50:9357:0:b0:5db:e91a:6baf with SMTP id 4fb4d7f45d1cf-5dbe91a6ce3mr1051424a12.14.1737464178063;
        Tue, 21 Jan 2025 04:56:18 -0800 (PST)
Received: from lczechowski-Latitude-5440.. ([78.9.4.190])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384ce0529sm740943866b.43.2025.01.21.04.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 04:56:17 -0800 (PST)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
To: linux-arm-kernel@lists.infradead.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: quentin.schulz@cherry.de,
	Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] arm64: dts: rockchip: Move uart5 pin configuration to SoM dtsi
Date: Tue, 21 Jan 2025 13:56:03 +0100
Message-ID: <20250121125604.3115235-2-lukasz.czechowski@thaumatec.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250121125604.3115235-1-lukasz.czechowski@thaumatec.com>
References: <20250121125604.3115235-1-lukasz.czechowski@thaumatec.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the PX30-uQ7 (Ringneck) SoM, the hardware CTS and RTS pins for
uart5 cannot be used for the UART CTS/RTS, because they are already
allocated for different purposes. CTS pin is routed to SUS_S3#
signal, while RTS pin is used internally and is not available on
Q7 connector. Move definition of the pinctrl-0 property from
px30-ringneck-haikou.dts to px30-ringneck.dtsi.

This commit is a dependency to next commit in the patch series,
that disables DMA for uart5.

Cc: stable@vger.kernel.org
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
---
 arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts | 1 -
 arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi       | 4 ++++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
index e4517f47d519c..eb9470a00e549 100644
--- a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
@@ -226,7 +226,6 @@ &uart0 {
 };
 
 &uart5 {
-	pinctrl-0 = <&uart5_xfer>;
 	rts-gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi b/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
index ae050cc6cd050..2c87005c89bd3 100644
--- a/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
@@ -396,6 +396,10 @@ &u2phy_host {
 	status = "okay";
 };
 
+&uart5 {
+	pinctrl-0 = <&uart5_xfer>;
+};
+
 /* Mule UCAN */
 &usb_host0_ehci {
 	status = "okay";
-- 
2.43.0



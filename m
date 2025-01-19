Return-Path: <stable+bounces-109480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52726A160F5
	for <lists+stable@lfdr.de>; Sun, 19 Jan 2025 10:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9D161885D83
	for <lists+stable@lfdr.de>; Sun, 19 Jan 2025 09:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF5E199230;
	Sun, 19 Jan 2025 09:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCc+e2YY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C1D7FD;
	Sun, 19 Jan 2025 09:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737277970; cv=none; b=NasSoL8KyrB/0EjdcFzg82V/rnm9xAVagdp3hH5xAzzqd4OoTmEXOt8SqGoImY1311Prmqj9Hk+nJ4XrNJfx4e+9C6dguWbxUzWf4TkMEC+Rer5Qx3tfmGGxqJGvjJvlFypgCj7YWKvy+LdnkxMlfwLt46gy3sZh5WwitfN/e20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737277970; c=relaxed/simple;
	bh=rWIAg2E7HdQfOSTncbOmmI31v9VOG1Vwse2gfzsko+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RUK6Ups6G88ns8TMrKi48CYsTAI5TY4AUbPQopdbSNRmmaB8/fAoojQPhB78AIsh/oYxjoeL9PDonBKig/OlFLaqds0OzU6Nxg+/1/tXBrf6I5FoZRLeewshxZhNyP9kEELMv9cvUuGcY/HrjkOwl1yhvNAlIKLJROPZqs5/izo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCc+e2YY; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2166f1e589cso86799975ad.3;
        Sun, 19 Jan 2025 01:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737277968; x=1737882768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LhA2NVlEKfcVBvBTCiVY32y/xH4Hrx8Ejnf1JnnZLNA=;
        b=SCc+e2YYdnBLQz1S/iuHhZ9sux1tXwcdjRogn1FkVgbQ3tdlENN2vnC/iFs65ZBRAx
         0r/ZUv6gsMRfoKUJgGLRmUtCzzZcfk2kVmGMCxKrGCI87bxihSXOYVSkgZ93n+3LPQiP
         lxAlMrXsGfbjw8olR5Of8WFGH/LiecIfMnLDWpbaiDjILn0Cn4s9iFISk/rQI+PkPeav
         QikOQblM/DIjAVCc9skl8QUipbgXmgLGiswUGGpNHqrecC5vxgzas3lKwUZRPhaUUcM0
         d9g0nleAXQpiJUIBOoAakSdPxlZNnCZP/Z3v4wx6+ViMUdI/GI32JLsK4G+nMEJ5si1f
         yKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737277968; x=1737882768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LhA2NVlEKfcVBvBTCiVY32y/xH4Hrx8Ejnf1JnnZLNA=;
        b=ChWn/ChJnaV7hniYJl1S6dSO6g6/aqQ63ZLBWbfsctZ3+ZzegbYtCPHxIMg2/P0YSL
         46bteLb/EsVUYyV1jRryp3H2bjktwTE6JEGrltdGnCn+ruwirra3oP5k3V5tA4Z87rv1
         S6TX+wvSfXvxmshNDOyhIFzSoBiwLq5IQUJHI9/H3fYRyYdJpVH0ZTeQUfeytBA9TQ6r
         gEUV96v6NioVwWKBy1I0sgr3NPmuL7h3aMd71X/lWwVIIqLaak1HwVmyohnnNnJ36iWV
         SqJA6KrC0jQ8VxqK+tBvhOpjUfaodSjNhqao4PeGeC6QBmAJEnK83CbuKZ0RdJ7EHTjQ
         6QUg==
X-Forwarded-Encrypted: i=1; AJvYcCUba3oMF7sGjHrFfvSr/DLkYJiBYJ529YcN7tA0VgyTQtoyJ8rrJ3ji8MwxFtyjoilcalQg53gm@vger.kernel.org, AJvYcCV8bLcW5lQwV+ns/PCJIGyto5ZzEA4ci6XsQbHCy72XEaSPKhMbZnva36p7BRygGyG+YS5H4eH+ns4g43A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcYQU/pDs65a379DtcD96S+dg3z0OCX6gnOwAL8K+gmuJ6xgCC
	XGR2/62lHRWvA9tZHVAEFQhnKOcVLNlqdTz5BjqUCYUTJPhjhnNw
X-Gm-Gg: ASbGncvu5TXC3hFeBnzKjIZDVTwL8WVLijzVhJRfd5fyfAhjyWGZXoEn49IVeFlVBIv
	lVB8KEy7YWrv3eZnC8y9bWEOYwTX4t8JMURPZUaP9QiKZnPGDU8Z6R0M2U3M1YzpFP6tvWKiehm
	sEnWJdOFDSg2ffGl6IA69yuK/Yj/YcUKKvQdYGS3jk1EoR45f36+ODUGPqC1nrDwNLXTEAW2dua
	rrX5addzbhc/urWVVqbIcufzYno+G2D2j16oWX+VntvUOVTYN0OeVNp3paW+4Og8n9UW9b+
X-Google-Smtp-Source: AGHT+IEMR4GkrqPducHUzdmvKmp45CrEQ0781699gN42PINXS9mQr93hcVS3Xb9IhAYhNezJgIlYkw==
X-Received: by 2002:a05:6a00:2d19:b0:72a:8bb6:2963 with SMTP id d2e1a72fcca58-72dafa44141mr12644220b3a.13.1737277967594;
        Sun, 19 Jan 2025 01:12:47 -0800 (PST)
Received: from CNSZTL-DEB.lan ([2408:8362:245d:4738:bc4b:53ff:fead:2725])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab849e1bsm4872907b3a.80.2025.01.19.01.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 01:12:47 -0800 (PST)
From: Tianling Shen <cnsztl@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Tianling Shen <cnsztl@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Jonas Karlman <jonas@kwiboo.se>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: change eth phy mode to rgmii-id for orangepi r1 plus lts
Date: Sun, 19 Jan 2025 17:11:54 +0800
Message-ID: <20250119091154.1110762-1-cnsztl@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In general the delay should be added by the PHY instead of the MAC,
and this improves network stability on some boards which seem to
need different delay.

Fixes: 387b3bbac5ea ("arm64: dts: rockchip: Add Xunlong OrangePi R1 Plus LTS")
Cc: stable@vger.kernel.org # 6.6+
Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts | 3 +--
 arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts     | 1 +
 arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi    | 1 -
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
index 67c246ad8b8c..ec2ce894da1f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
@@ -17,8 +17,7 @@ / {
 
 &gmac2io {
 	phy-handle = <&yt8531c>;
-	tx_delay = <0x19>;
-	rx_delay = <0x05>;
+	phy-mode = "rgmii-id";
 	status = "okay";
 
 	mdio {
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts
index 324a8e951f7e..846b931e16d2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts
@@ -15,6 +15,7 @@ / {
 
 &gmac2io {
 	phy-handle = <&rtl8211e>;
+	phy-mode = "rgmii";
 	tx_delay = <0x24>;
 	rx_delay = <0x18>;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi
index 4f193704e5dc..09508e324a28 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi
@@ -109,7 +109,6 @@ &gmac2io {
 	assigned-clocks = <&cru SCLK_MAC2IO>, <&cru SCLK_MAC2IO_EXT>;
 	assigned-clock-parents = <&gmac_clk>, <&gmac_clk>;
 	clock_in_out = "input";
-	phy-mode = "rgmii";
 	phy-supply = <&vcc_io>;
 	pinctrl-0 = <&rgmiim1_pins>;
 	pinctrl-names = "default";
-- 
2.48.1



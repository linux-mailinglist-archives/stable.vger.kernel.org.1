Return-Path: <stable+bounces-63217-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3662294183E
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55A97B29724
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB2E18E056;
	Tue, 30 Jul 2024 16:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M9bqtFkP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CD718E044;
	Tue, 30 Jul 2024 16:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356104; cv=none; b=UNteWB5OZsERryNpMkS1AjecnbIHvNbM7WrRGtqA5CPEsNpxoqxcatIdAHJ0KDJ2t2HYKn00M1iBBbIeh/HdSTAr+vUpyhk95z7qMKsjxaxN2Yf3RQRkRtY6OnsAhymXC/0Q9FWCiMLD8MCIdi9ClkGH7KEdLKuqN3t3O2/50lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356104; c=relaxed/simple;
	bh=W+G/rtZ3CM9If/VANW+RtUIWHlucI9HPljsT1RykWTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bnN/e3KwGkDZTg6L319I3D/gCtBAPn0bipJZtLXVk1LadDyv5XCpVt7R74fJo+Y/7xlfG3QZ0G+eAeXWv+pZ1/FrEAhZ6GVPhOZVgmoVvQtU4dY/S7TuGzY7+HqviabF50erAo56yCpdYZN+Ngy3mYuvA3baEh7D+2OAgM5PR2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M9bqtFkP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28AAC32782;
	Tue, 30 Jul 2024 16:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722356104;
	bh=W+G/rtZ3CM9If/VANW+RtUIWHlucI9HPljsT1RykWTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M9bqtFkPG3tIVlbGjW9abyRld0GZBCh40BDTppnTG+8N6NQ7hbE2qWH65Gg1lRHS0
	 uspYXffXZNGKULXix+RscEI1WgAAhfzSb2tZpLcI9iBeDNVOWJKbNxs6xhiSbUkQiM
	 f69h4JVFyZoJfi06SkHVnjjQPq9pYcRWFOxXjxRM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 096/568] arm64: dts: rockchip: fix regulator name for Lunzn Fastrhino R6xS
Date: Tue, 30 Jul 2024 17:43:23 +0200
Message-ID: <20240730151643.628777575@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151639.792277039@linuxfoundation.org>
References: <20240730151639.792277039@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chukun Pan <amadeus@jmu.edu.cn>

[ Upstream commit 2dad31528de9ea8b05245ce6ac4f76ebf8dae947 ]

Make the regulator name the same as those marked by schematics.

Fixes: c79dab407afd ("arm64: dts: rockchip: Add Lunzn Fastrhino R66S")
Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
Link: https://lore.kernel.org/r/20240630150010.55729-2-amadeus@jmu.edu.cn
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi
index 89e84e3a92629..93987c8740f7b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi
@@ -39,9 +39,9 @@ status_led: led-status {
 		};
 	};
 
-	dc_12v: dc-12v-regulator {
+	vcc12v_dcin: vcc12v-dcin-regulator {
 		compatible = "regulator-fixed";
-		regulator-name = "dc_12v";
+		regulator-name = "vcc12v_dcin";
 		regulator-always-on;
 		regulator-boot-on;
 		regulator-min-microvolt = <12000000>;
@@ -65,7 +65,7 @@ vcc3v3_sys: vcc3v3-sys-regulator {
 		regulator-boot-on;
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-		vin-supply = <&dc_12v>;
+		vin-supply = <&vcc12v_dcin>;
 	};
 
 	vcc5v0_sys: vcc5v0-sys-regulator {
@@ -75,7 +75,7 @@ vcc5v0_sys: vcc5v0-sys-regulator {
 		regulator-boot-on;
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
-		vin-supply = <&dc_12v>;
+		vin-supply = <&vcc12v_dcin>;
 	};
 
 	vcc5v0_usb_host: vcc5v0-usb-host-regulator {
-- 
2.43.0





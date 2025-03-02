Return-Path: <stable+bounces-120023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FC3A4B42D
	for <lists+stable@lfdr.de>; Sun,  2 Mar 2025 19:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 822677A5B97
	for <lists+stable@lfdr.de>; Sun,  2 Mar 2025 18:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C031EB9F2;
	Sun,  2 Mar 2025 18:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="HUYGW807"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAA71AAA23;
	Sun,  2 Mar 2025 18:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740941303; cv=none; b=CGc3ZRKmCwYng35niUOkwkE6qCf49ubh8UXM8JMVxqRMOAkt5Y4nQg8AgUZ8qrF0zeU73Ai+pGF1EgO0VPyatv8Vocul7dJBZjP2z1ZSQKd9MeQIfRw4GRyyZ8YDgACJbXxv+nPNWX4f4u2RaS+uX5B++9Taus4BlP+jhY2H+LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740941303; c=relaxed/simple;
	bh=G2nSvWURltzPwdYi2WoWm1f+0VeSDH2i0H1mz1cOZrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ftQ3Ud/r7GA593pVwCLFMA8ufKl8I2FGlIpKFQwTWmTivcxNhsQzH4Dmb0lrD/AyYKmSMTtoSRRhSL39itdJQrNumN1DXgNFXJbZsLPXrpE8m/35P7TEhqohJgiWMsypQ/9mN6zaLV9Jh88bDCbte/fZvMELCGRtIZAEfwo2N0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=HUYGW807; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1740941293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5gQcmtYRJ6ZBHGuG3ItZvKIEimpluYI6lauZf8aMldM=;
	b=HUYGW807T4tqTNe8WFbayXXrWnHqGZwm0xvJeJJ97W21KmzfpUIL8q56xt8ETuvwDXfpHa
	HzqUDkM0TbRXfnE+WJWMrmNg/fpJT/zZxXWju8a/C7plyQhovZzAoW9mHKBqr++sQb0Lj2
	Ig1XHeR9kwmQHIGvTuWdIVG6sCHUnzi+OvRMq7pY6BULOS3s9cHBoRVXbpRqbYMi4FJyEF
	2tnrSlBwpFwMSevXUTzZuL+1khukgSp37yturt7o0SJSn6XtlKPd7vOTkCmUfYNf1bq0Xx
	9FGJIYuG1C7AB8q2GkLziYQGRYnmF41ePW9KxadYWXM+83TgRW35VdYVKkhVrA==
To: linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	didi.debian@cknow.org,
	chris@z9.de,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] arm64: dts: rockchip: Add avdd HDMI supplies to RockPro64 board dtsi
Date: Sun,  2 Mar 2025 19:48:03 +0100
Message-Id: <df3d7e8fe74ed5e727e085b18c395260537bb5ac.1740941097.git.dsimic@manjaro.org>
In-Reply-To: <cover.1740941097.git.dsimic@manjaro.org>
References: <cover.1740941097.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Add missing "avdd-0v9-supply" and "avdd-1v8-supply" properties to the "hdmi"
node in the Pine64 RockPro64 board dtsi file.  To achieve this, also add the
associated "vcca_0v9" regulator that produces the 0.9 V supply, [1][2] which
hasn't been defined previously in the board dtsi file.

This also eliminates the following warnings from the kernel log:

  dwhdmi-rockchip ff940000.hdmi: supply avdd-0v9 not found, using dummy regulator
  dwhdmi-rockchip ff940000.hdmi: supply avdd-1v8 not found, using dummy regulator

There are no functional changes to the way board works with these additions,
because the "vcc1v8_dvp" and "vcca_0v9" regulators are always enabled, [1][2]
but these additions improve the accuracy of hardware description.

These changes apply to the both supported hardware revisions of the Pine64
RockPro64, i.e. to the production-run revisions 2.0 and 2.1. [1][2]

[1] https://files.pine64.org/doc/rockpro64/rockpro64_v21-SCH.pdf
[2] https://files.pine64.org/doc/rockpro64/rockpro64_v20-SCH.pdf

Fixes: e4f3fb490967 ("arm64: dts: rockchip: add initial dts support for Rockpro64")
Cc: stable@vger.kernel.org
Suggested-by: Diederik de Haas <didi.debian@cknow.org>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
index 69a9d6170649..47dc198706c8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
@@ -227,6 +227,16 @@ vcc5v0_usb: regulator-vcc5v0-usb {
 		vin-supply = <&vcc12v_dcin>;
 	};
 
+	vcca_0v9: regulator-vcca-0v9 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcca_0v9";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <900000>;
+		regulator-max-microvolt = <900000>;
+		vin-supply = <&vcc3v3_sys>;
+	};
+
 	vdd_log: regulator-vdd-log {
 		compatible = "pwm-regulator";
 		pwms = <&pwm2 0 25000 1>;
@@ -312,6 +322,8 @@ &gmac {
 };
 
 &hdmi {
+	avdd-0v9-supply = <&vcca_0v9>;
+	avdd-1v8-supply = <&vcc1v8_dvp>;
 	ddc-i2c-bus = <&i2c3>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&hdmi_cec>;


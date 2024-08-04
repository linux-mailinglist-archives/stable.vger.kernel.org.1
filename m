Return-Path: <stable+bounces-65353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 747DB94709C
	for <lists+stable@lfdr.de>; Sun,  4 Aug 2024 23:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1991F211DC
	for <lists+stable@lfdr.de>; Sun,  4 Aug 2024 21:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACDA139D19;
	Sun,  4 Aug 2024 21:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="lnh110nc"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885DFAD59;
	Sun,  4 Aug 2024 21:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722805839; cv=none; b=dA5QhwixYIi99eMV/ukAs+nVszECsgjD7AgL+y7GjmVMd9RkpK7hqUr++XJrkCzC1LEkwHAQXgfaGTPMtOfa4n1TW0D+gu26ekTRxe4gMTmbOCFhbjZYZLjGV199rOKYtblG1Ffkqd+FxzJDQkSnzHkrWqwlifCn1fhplYPIaX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722805839; c=relaxed/simple;
	bh=gvIldV/MwE6QL2XcTICooby7hyDNnCaFeBumi4E0PDM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KA5wn+Tu+7Ro8FRlFQe58vj0L844tGbT2spMn5GJkNCgj7SOBNHI5IiyUq0zdtR7Nmf1GoUO5Irvk/CWv5oB/1kiBUGB/UDSRKM2U8CxKIQZT1GgjHH3Q8kzieXgb3STZi61eAi6F9D66hZAsVgA2bSLbUpTUkZEOxu1pjfVke4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=lnh110nc; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1722805830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SFovGr+fAr2Hx5+n3cI/uIkQLPLP3RaKmyAIKcx+Ff0=;
	b=lnh110nc5YV/uqJx/EM74czCz30oSKI93LK3om2Llgl/TT66Oy/9lzj1h9a8UpVeWXF6Z5
	tFPC/MAup6HJDs/rZdZSdyw5n7HCoZdyb5zw6oqDTMtoEL+XnugtSKDzD57uhrQQm5YxnG
	eNac+SQSLrOuEgGy9wgtYcfGgfaCwcL+gOSFc+Y19QQ16mYvNehNL1bqxSuTZHjMdbY8SX
	AethNfr5DTkDQKm9yteHc/IHOVnOsYuI/wBH3GYkVIhbDwnxQHgxdjU5FEK8uOeOTCgY20
	+pKGj0diOE7x+IdImC7ngrfLvsQpeHNwXgr4oVrpJ6Tpeq1zNfxx1FdN4ChmBA==
To: linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Nikola Radojevic <nikola@radojevic.rs>
Subject: [PATCH] arm64: dts: rockchip: Raise Pinebook Pro's panel backlight PWM frequency
Date: Sun,  4 Aug 2024 23:10:24 +0200
Message-Id: <2a23b6cfd8c0513e5b233b4006ee3d3ed09b824f.1722805655.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Increase the frequency of the PWM signal that drives the LED backlight of
the Pinebook Pro's panel, from about 1.35 KHz (which equals to the PWM
period of 740,740 ns), to exactly 8 kHz (which equals to the PWM period of
125,000 ns).  Using a higher PWM frequency for the panel backlight, which
reduces the flicker, can only be beneficial to the end users' eyes.

On top of that, increasing the backlight PWM signal frequency reportedly
eliminates the buzzing emitted from the Pinebook Pro's built-in speakers
when certain backlight levels are set, which cause some weird interference
with some of the components of the Pinebook Pro's audio chain.

The old value for the backlight PWM period, i.e. 740,740 ns, is pretty much
an arbitrary value that was selected during the very early bring-up of the
Pinebook Pro, only because that value seemed to minimize horizontal line
distortion on the display, which resulted from the old X.org drivers causing
screen tearing when dragging windows around.  That's no longer an issue, so
there are no reasons to stick with the old PWM period value.

The lower and the upper backlight PWM frequency limits for the Pinebook Pro's
panel, according to its datasheet, are 200 Hz and 10 kHz, respectively. [1]
These changes still leave some headroom, which may have some positive effects
on the lifetime expectancy of the panel's backlight LEDs.

[1] https://files.pine64.org/doc/datasheet/PinebookPro/NV140FHM-N49_Rev.P0_20160804_201710235838.pdf

Fixes: 5a65505a6988 ("arm64: dts: rockchip: Add initial support for Pinebook Pro")
Cc: stable@vger.kernel.org
Reported-by: Nikola Radojevic <nikola@radojevic.rs>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
index 294eb2de263d..b3f76cc2d6e1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
@@ -32,7 +32,7 @@ chosen {
 	backlight: edp-backlight {
 		compatible = "pwm-backlight";
 		power-supply = <&vcc_12v>;
-		pwms = <&pwm0 0 740740 0>;
+		pwms = <&pwm0 0 125000 0>;
 	};
 
 	bat: battery {


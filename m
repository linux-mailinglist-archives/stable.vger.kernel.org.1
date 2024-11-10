Return-Path: <stable+bounces-92050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1819C343C
	for <lists+stable@lfdr.de>; Sun, 10 Nov 2024 19:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D54472811DA
	for <lists+stable@lfdr.de>; Sun, 10 Nov 2024 18:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7041F13C690;
	Sun, 10 Nov 2024 18:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="CCJKo2cW"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648DF1C6A3;
	Sun, 10 Nov 2024 18:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731264280; cv=none; b=ufUEDI1qkdoqFqS4+QnjhVjG0ej09/4EOMjTT8+G5gI8es14ItInIov0FSzgbfl+8257V6NEmgupFi+sctXDbVH0fTPshgLMI9IlEDWqDahAxIAQgBkqEIcxep0nWEUW92/0JXb+n+2ESf0/uAimtSlaafc7zcRLL8NrL7F6dbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731264280; c=relaxed/simple;
	bh=4DPPfyk5xcDCf169kuJcfoSFcqIk8wwFT07QI+IzsMg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=faojolV1mEaZl+QT/7jUwLfC2ISp+Wb3V3RtjSi4PR1wcclw/4AVQlTrW7nQZqT4HpbN9Yu+e1etwJ1vJcNwC3pjBi6dhk/SUgMC1exE3xz/Ay/39C0y7b2IVVYYAtKIPM4NaFJGGhLP9e9uENCpRhZX1J3hEjT+mjJYWtgn83A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=CCJKo2cW; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1731264275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X6EGSkrXWrC2versQkLjecqlYEVZvqpe//AxlHQPJPQ=;
	b=CCJKo2cWjI4Mxc4eGn3IUgNYzhD53NPu8INSky9AsCs5fEs+ftNK/ZXkAtInhwlVQ4VzW5
	oomFijPvRBOuL0HLmU9WkXoGx7JqEMbKoXbYI4GszQ8ToisntDvgB0IAkt0QtJRIRmRO0K
	xLLbDV2kctwiu7JV01v5pt9/e0s9Jy8gSnndcFIzLEbatVKmLozM4WE99KOdJnGcZxuCi8
	ARQmYbuvWX0sDmcHlO04bs+Sz4SGJOmLY0aWjOVp5zG7Drvwb78JL1LwX3J8RSGcJvGHhR
	5JBsoGFz1IuJrvOHJ3z4Sm7p2MAi8weGEGFPOlTkb38B0hLV9MJTt5lDx/q8qg==
To: linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: Fix vdd_gpu voltage constraints on PinePhone Pro
Date: Sun, 10 Nov 2024 19:44:31 +0100
Message-Id: <0718feb8e95344a0b615f61e6d909f6e105e3bf9.1731264205.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

The regulator-{min,max}-microvolt values for the vdd_gpu regulator in the
PinePhone Pro device dts file are too restrictive, which prevents the highest
GPU OPP from being used, slowing the GPU down unnecessarily.  Let's fix that
by making the regulator-{min,max}-microvolt values less strict, using the
voltage range that the Silergy SYR838 chip used for the vdd_gpu regulator is
actually capable of producing. [1][2]

This also eliminates the following error messages from the kernel log:

  core: _opp_supported_by_regulators: OPP minuV: 1100000 maxuV: 1150000, not supported by regulator
  panfrost ff9a0000.gpu: _opp_add: OPP not supported by regulators (800000000)

These changes to the regulator-{min,max}-microvolt values make the PinePhone
Pro device dts consistent with the dts files for other Rockchip RK3399-based
boards and devices.  It's possible to be more strict here, by specifying the
regulator-{min,max}-microvolt values that don't go outside of what the GPU
actually may use, as the consumer of the vdd_gpu regulator, but those changes
are left for a later directory-wide regulator cleanup.

[1] https://files.pine64.org/doc/PinePhonePro/PinephonePro-Schematic-V1.0-20211127.pdf
[2] https://www.t-firefly.com/download/Firefly-RK3399/docs/Chip%20Specifications/DC-DC_SYR837_838.pdf

Fixes: 78a21c7d5952 ("arm64: dts: rockchip: Add initial support for Pine64 PinePhone Pro")
Cc: stable@vger.kernel.org
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
index 1a44582a49fb..956d64f5b271 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
@@ -410,8 +410,8 @@ vdd_gpu: regulator@41 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&vsel2_pin>;
 		regulator-name = "vdd_gpu";
-		regulator-min-microvolt = <875000>;
-		regulator-max-microvolt = <975000>;
+		regulator-min-microvolt = <712500>;
+		regulator-max-microvolt = <1500000>;
 		regulator-ramp-delay = <1000>;
 		regulator-always-on;
 		regulator-boot-on;


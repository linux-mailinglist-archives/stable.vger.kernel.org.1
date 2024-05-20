Return-Path: <stable+bounces-45457-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FD28CA12D
	for <lists+stable@lfdr.de>; Mon, 20 May 2024 19:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC27DB218D1
	for <lists+stable@lfdr.de>; Mon, 20 May 2024 17:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5F3137C2A;
	Mon, 20 May 2024 17:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="LuU/fEMP"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECF653E13;
	Mon, 20 May 2024 17:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716225640; cv=none; b=QpvEbEgvsY0yfKsafXjIPuZu8uXeYNLTh3WaLkkPNt/wWVCQ5DVIGMez2vFEUVRUVbBj7uM9faHO7ofF7SAFcDYunzNWuOf4U3IfiOfzNJXP3AI/fG6xKIQd/T+9+6zwId3Tk/WkEV9svd3cX2Ga30F/5sO3i/DX7O8cHlf3zaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716225640; c=relaxed/simple;
	bh=ujOZdM12m2SkEuErdLg31UfXALUkOK8fYQRRZe+CGPo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a63vvnYNAPjHErnZgEGQg8mAH8uQSP4n7XYdo0B6EYuljDCPASut4n1Q99ZRQsZ7hscvEHt04tPByXecsjAHBYAnBeTHaZokqtHgwwRQvqYe+f7asFiz8QBDcHESY5gCSUCCPnUkrll+IiVGsg3x+tB4AFk2ZbDZkegzgSV92j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=LuU/fEMP; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716225634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M5mdKrQZ6Ky+oql5N4jU0irfjSORSwfq+zI30MiBIko=;
	b=LuU/fEMPZL0GHan6Z1Z0f2BpKu+NaY/w0OmOAbO9PaNcTiGPihIk+jEt/FfcthR7H3nL49
	x0+z0UXxgVjOsQ4RV0z7dVY7wGEnxexYc38rqFz+VW8Q0eiaW30/JLEPmHl3CDuf1HQyEO
	vQWrQpGOneFSwbcwMw5LlRhcEP625t/+cISm+aHJxTkkqXMI8YQW3FfrJbZ/mK4k/ld1Az
	mbK/ui3vFhOZ7TavIMGZZARU9c1zlI1CAE3K66gHAQFECNsbCdWbfmMZfbBijvGrfDJyp6
	U0+HQ8NnpQ2MyISitkaJU2fd9duUnbjUApV4peHrnyaDa9IoRvxzApTeaBgvEw==
To: linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	robh+dt@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Diederik de Haas <didi.debian@cknow.org>
Subject: [PATCH] arm64: dts: rockchip: Fix the DCDC_REG2 minimum voltage on Quartz64 Model B
Date: Mon, 20 May 2024 19:20:28 +0200
Message-Id: <e70742ea2df432bf57b3f7de542d81ca22b0da2f.1716225483.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Correct the specified regulator-min-microvolt value for the buck DCDC_REG2
regulator, which is part of the Rockchip RK809 PMIC, in the Pine64 Quartz64
Model B board dts.  According to the RK809 datasheet, version 1.01, this
regulator is capable of producing voltages as low as 0.5 V on its output,
instead of going down to 0.9 V only, which is additionally confirmed by the
regulator-min-microvolt values found in the board dts files for the other
supported boards that use the same RK809 PMIC.

This allows the DVFS to clock the GPU on the Quartz64 Model B below 700 MHz,
all the way down to 200 MHz, which saves some power and reduces the amount of
generated heat a bit, improving the thermal headroom and possibly improving
the bursty CPU and GPU performance on this board.

This also eliminates the following warnings in the kernel log:

  core: _opp_supported_by_regulators: OPP minuV: 825000 maxuV: 825000, not supported by regulator
  panfrost fde60000.gpu: _opp_add: OPP not supported by regulators (200000000)
  core: _opp_supported_by_regulators: OPP minuV: 825000 maxuV: 825000, not supported by regulator
  panfrost fde60000.gpu: _opp_add: OPP not supported by regulators (300000000)
  core: _opp_supported_by_regulators: OPP minuV: 825000 maxuV: 825000, not supported by regulator
  panfrost fde60000.gpu: _opp_add: OPP not supported by regulators (400000000)
  core: _opp_supported_by_regulators: OPP minuV: 825000 maxuV: 825000, not supported by regulator
  panfrost fde60000.gpu: _opp_add: OPP not supported by regulators (600000000)

Fixes: dcc8c66bef79 ("arm64: dts: rockchip: add Pine64 Quartz64-B device tree")
Cc: stable@vger.kernel.org
Reported-By: Diederik de Haas <didi.debian@cknow.org>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
index 26322a358d91..b908ce006c26 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
@@ -289,7 +289,7 @@ vdd_gpu: DCDC_REG2 {
 				regulator-name = "vdd_gpu";
 				regulator-always-on;
 				regulator-boot-on;
-				regulator-min-microvolt = <900000>;
+				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
 				regulator-ramp-delay = <6001>;
 


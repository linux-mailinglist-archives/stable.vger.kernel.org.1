Return-Path: <stable+bounces-114284-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA52FA2CA6E
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 18:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D1521687F7
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 17:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52C6199E8D;
	Fri,  7 Feb 2025 17:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bXEOx/MH"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF3B18E050;
	Fri,  7 Feb 2025 17:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738950106; cv=none; b=io/l0hnwz9wvkO/Av/nYiE+URl8CPSLtlJ/sj+j/6oLt47IMr/d4I3GAzhqzrrAqnvBfoV8H6owC7/hJRPJwWEZVRHNNjGC7S4JCvPskp/GQXGz+tAJ3FgG+BdMo46/+l12jesXOeni6ey9e7F1aPb7CLxRlaQvn/T5aFpfIHlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738950106; c=relaxed/simple;
	bh=gt6tOFngHm78d/hp3pS3kUPBsTjqkKCK6t6jGboTc54=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=f+uzCq4g61zFORN+9ENmNCCXOToarH+9w2nnilHpoQ6pLrGzgYIC6OOz07NgEUbD5dpssg8P4O/NllvbRTL0a7X0YtETAnLN229L49LQOHUHRZYj1ElqbPwvbmcU0sBbmAf803KDWhbDaFjALdmaSYqbQOZAEQjCUeLliXHGYfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bXEOx/MH; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1738950102;
	bh=gt6tOFngHm78d/hp3pS3kUPBsTjqkKCK6t6jGboTc54=;
	h=From:Date:Subject:To:Cc:From;
	b=bXEOx/MHPCuwaFB3A2Twmd8u6znm+0tGgUhhzmh9uzYGjaXB9gQ3CEvOZMFFka3Hj
	 4cmg+btcIpUG45tv1Ln1rkA7ldl1nJbETO1rHKsmjiBy7XHpxPARsolUk1tw5za+li
	 GnE5wYbtOJc8NU27T+HpYdgQ4mjU+w9/nnVxVKmSDknYJEA/bis8BzT3PpDK0+I03x
	 hcaPaWigjIk5e8C8EA8avIzJHF23wI//md21gk6GLudKV1V0jsmvSoe6UMv6W5xukA
	 eCg80pBZGGZnJa2Ek9Pwr4S32HtdGtICZtttWLEa0S1PYz6Bel66hBJWj8qf/ydsy3
	 x8inU3vDae/yg==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1002])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 346D717E02AF;
	Fri,  7 Feb 2025 18:41:38 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Fri, 07 Feb 2025 14:41:24 -0300
Subject: [PATCH v2] arm64: dts: mediatek: mt8188: Assign apll1 clock as
 parent to avoid hang
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250207-mt8188-afe-fix-hang-disabled-apll1-clk-v2-1-a636d844c272@collabora.com>
X-B4-Tracking: v=1; b=H4sIAMNFpmcC/5WNSwqDMBRFtyIZ95W8KE3oqPsoDvKzPhqNJBJax
 L03uoMOz+Vwz8ayT+QzuzcbS75QpjhXEJeG2VHPLw/kKjPBRYeCtzCtCpUCPXgY6AOHA46yNsE
 70EsICDa8wbQWUSphjR5YPVuSr/oZevaVR8prTN+zW/BY/04UBAQurXNS3rhqu4eNIWgTk77aO
 LF+3/cf2tTWM+AAAAA=
X-Change-ID: 20241203-mt8188-afe-fix-hang-disabled-apll1-clk-b3c11782cbaf
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Fei Shao <fshao@chromium.org>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 =?utf-8?q?Trevor_Wu_=28=E5=90=B3=E6=96=87=E8=89=AF=29?= <Trevor.Wu@mediatek.com>, 
 Chen-Yu Tsai <wenst@chromium.org>, devicetree@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.2

Certain registers in the AFE IO space require the apll1 clock to be
enabled in order to be read, otherwise the machine hangs (registers like
0x280, 0x410 (AFE_GAIN1_CON0) and 0x830 (AFE_CONN0_5)). During AFE
driver probe, when initializing the regmap for the AFE IO space those
registers are read, resulting in a hang during boot.

This has been observed on the Genio 700 EVK, Genio 510 EVK and
MT8188-Geralt-Ciri Chromebook, all of which are based on the MT8188 SoC.

Assign CLK_TOP_APLL1_D4 as the parent for CLK_TOP_A1SYS_HP, which is
enabled during register read and write, to make sure the apll1 is
enabled during register operations and prevent the MT8188 machines from
hanging during boot.

Cc: stable@vger.kernel.org
Fixes: 4dbec3a59a71 ("arm64: dts: mediatek: mt8188: Add audio support")
Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
Changes in v2:
- Changed patch from explicitly enabling apll1 clock in the driver to
  assigning apll1_d4 as the parent for the a1sys_hp clock in the
  mt8188.dtsi
- Link to v1: https://lore.kernel.org/r/20241203-mt8188-afe-fix-hang-disabled-apll1-clk-v1-1-07cdd7760834@collabora.com
---
 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index 5d78f51c6183c15018986df2c76e6fdc1f9f43b4..6352c9bd436550dce66435f23653ebcb43ccf0cd 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -1392,7 +1392,7 @@ afe: audio-controller@10b10000 {
 			compatible = "mediatek,mt8188-afe";
 			reg = <0 0x10b10000 0 0x10000>;
 			assigned-clocks = <&topckgen CLK_TOP_A1SYS_HP>;
-			assigned-clock-parents =  <&clk26m>;
+			assigned-clock-parents = <&topckgen CLK_TOP_APLL1_D4>;
 			clocks = <&clk26m>,
 				 <&apmixedsys CLK_APMIXED_APLL1>,
 				 <&apmixedsys CLK_APMIXED_APLL2>,

---
base-commit: ed58d103e6da15a442ff87567898768dc3a66987
change-id: 20241203-mt8188-afe-fix-hang-disabled-apll1-clk-b3c11782cbaf

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>



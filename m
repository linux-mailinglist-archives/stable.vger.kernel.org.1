Return-Path: <stable+bounces-6713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E808129A5
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 08:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1DD21F210FF
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 07:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE5D14F62;
	Thu, 14 Dec 2023 07:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="segCU/dy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E7212E6B;
	Thu, 14 Dec 2023 07:43:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA32CC433C9;
	Thu, 14 Dec 2023 07:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702539819;
	bh=Sc0pqUtVynzYzW0IftIloM3hEVD+unGr2FUCTQzhLy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=segCU/dyx/0xze9h4ZDo4dEJjHirIemXGin/5vpbxKyqw3lvHyo87C2zJEqCgizUA
	 mhcXfSzuRQTz3H2Bts5osXxIORZeHgJaNn9+SCcjDnF+YbwQOhg9srT41ShKaG2PpR
	 3imCZeFfgsnFtM8iRhBq9pAYxQe/u+/ng0edJM85xKiQx4gd6Zak64vDcshzVANmnY
	 ZIuL+gjUZdp7Cy4yQepmO3JYhJVWOxotNUYMu588HUMgbRJSMoECrPm54YWTsqxaF8
	 YWR6r/Q2iJBalL+JhqK0fRX6KeTlW4BRXFg+E8Tw/pX9tMv7AId78AKuOV9DVCSLVP
	 FhPz067eN4lSA==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rDgNf-0002s8-0p;
	Thu, 14 Dec 2023 08:43:39 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org,
	Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH 2/3] arm64: dts: qcom: sdm670: fix USB SS wakeup
Date: Thu, 14 Dec 2023 08:43:18 +0100
Message-ID: <20231214074319.11023-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231214074319.11023-1-johan+linaro@kernel.org>
References: <20231214074319.11023-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The USB SS PHY interrupt needs to be provided by the PDC interrupt
controller in order to be able to wake the system up from low-power
states.

Fixes: 07c8ded6e373 ("arm64: dts: qcom: add sdm670 and pixel 3a device trees")
Cc: stable@vger.kernel.org      # 6.2
Cc: Richard Acayan <mailingradian@gmail.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sdm670.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm670.dtsi b/arch/arm64/boot/dts/qcom/sdm670.dtsi
index fe4067c012a0..730c8351bcaa 100644
--- a/arch/arm64/boot/dts/qcom/sdm670.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm670.dtsi
@@ -1296,7 +1296,7 @@ usb_1: usb@a6f8800 {
 			assigned-clock-rates = <19200000>, <150000000>;
 
 			interrupts-extended = <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
-					      <&intc GIC_SPI 486 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 6 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 8 IRQ_TYPE_EDGE_BOTH>,
 					      <&pdc 9 IRQ_TYPE_EDGE_BOTH>;
 			interrupt-names = "hs_phy_irq", "ss_phy_irq",
-- 
2.41.0



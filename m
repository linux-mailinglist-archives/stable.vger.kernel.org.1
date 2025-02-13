Return-Path: <stable+bounces-115923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BF0A34677
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 16:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3A823B13E5
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0322A1CF;
	Thu, 13 Feb 2025 15:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="142Hrf5f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4971226B0A5;
	Thu, 13 Feb 2025 15:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739459727; cv=none; b=hbTn/9dRLualySVy8GyKcpyhBDBQrFzmuH1liAfOl7OqGf+Lx4b0LRAAgVQvmRLCw34/nrUP+AoUBajogn7pSBjDSbkrJv8wEpmiR2MpTEqj/jEO1bNqE/Dh3wBpYwx0cOKmM3VNmXs8zoofMLX5JdemomwElsPuyk/iXxuSHEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739459727; c=relaxed/simple;
	bh=Gv5wcYTR9arZtzaU9LyRA0+az+QHMJ661JO+emecJKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GMGi3kZK4TO8GTyjY/Ui1UE3LQXGiCU9j05ePLR1IYcO2sOvIXmLAvSfnZCiDkvOBJNRFN7XtxrQLx4oYeOpPWvdU9rMWkrJN0ZacXMhzRR/m/jZ73AAi9H6CNg2ILD9VSDhqB5fAS23RUMm8a+tLMCI5fvffhXMtrbGAzMTN7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=142Hrf5f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE0EC4CED1;
	Thu, 13 Feb 2025 15:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739459727;
	bh=Gv5wcYTR9arZtzaU9LyRA0+az+QHMJ661JO+emecJKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=142Hrf5f/sTksNlPyCoudtfh/kj/hTjZY1UX1hV0u+hXRUkGRZz6dyzBx3wqBg2rC
	 S0oMOBW8qkAmrsZqeO3A9ibb2xRPNrNIPJGTXmCZ1EEWONADdBxxc1THi9o32ac9n9
	 KrOd3a3HqAD1LyLsY7iGea3sqUEjEPakIpSsCjIY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 6.13 314/443] arm64: dts: qcom: sm8450: Fix CDSP memory length
Date: Thu, 13 Feb 2025 15:27:59 +0100
Message-ID: <20250213142452.735241294@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213142440.609878115@linuxfoundation.org>
References: <20250213142440.609878115@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

commit 3751fe2cba2a9fba2204ef62102bc4bb027cec7b upstream.

The address space in CDSP PAS (Peripheral Authentication Service)
remoteproc node should point to the QDSP PUB address space
(QDSP6...SS_PUB) which has a length of 0x10000.  Value of 0x1400000 was
copied from older DTS, but it does not look accurate at all.

This should have no functional impact on Linux users, because PAS loader
does not use this address space at all.

Fixes: 1172729576fb ("arm64: dts: qcom: sm8450: Add remoteproc enablers and instances")
Cc: stable@vger.kernel.org
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20241213-dts-qcom-cdsp-mpss-base-address-v3-5-2e0036fccd8d@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2800,7 +2800,7 @@
 
 		remoteproc_cdsp: remoteproc@32300000 {
 			compatible = "qcom,sm8450-cdsp-pas";
-			reg = <0 0x32300000 0 0x1400000>;
+			reg = <0 0x32300000 0 0x10000>;
 
 			interrupts-extended = <&intc GIC_SPI 578 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_cdsp_in 0 IRQ_TYPE_EDGE_RISING>,




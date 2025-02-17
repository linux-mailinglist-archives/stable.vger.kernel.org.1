Return-Path: <stable+bounces-116228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3B0A347C4
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 16:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07A29161583
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB321531DB;
	Thu, 13 Feb 2025 15:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2WQg15vG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CCA26B098;
	Thu, 13 Feb 2025 15:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739460762; cv=none; b=rr6c8+t+0AHGLLMjkLoAfrayovG+GaQ4lyQocWOmSs+yWAZ3ljvdH335euRXGy4YVvFpTuiF5eAlCHFxOtlIIO/qB4EMXVqlwUPmy66RHKeSnHLcZvbgUrSITzsBXEZ6sEx5aWbv67m2hfy4PXjWuCaPfIf8AKbdreq+Z0Q78/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739460762; c=relaxed/simple;
	bh=o+AVKgkQl6J76IS+Nc0eoXnCZmLmQamb0fSKb1UQuGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UgE63TANEMuBKX4yL9u4+4MGeSOAbNn9lTYS2m3tLpVu/1zAu6eQCO0ouHG3XOrN5Ij6sgR/ESZwrWvF8SwO1CdOgIPQXd2r74lli2OicrQFFMUfDHYR0oSugAFF76TyX/6FitCq9oYoCRFoymcjT5Bu/41H2Gwq0M6jKWVuo2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2WQg15vG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1A3C4CED1;
	Thu, 13 Feb 2025 15:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739460762;
	bh=o+AVKgkQl6J76IS+Nc0eoXnCZmLmQamb0fSKb1UQuGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2WQg15vGyyWJBQoYUkNUXpLVLujPltQzE00l/bdzDxARNbbq582ENyGJIGxJ4JTuN
	 6PibNLkTqrRSbu/nfd0XC1hIWAzMsqRwr6wgX6GESnogGknGBn8/bLuzLoS6Mpsrhe
	 EC1HVV6p/+zdmatsWN2WZZlmnH8+4iLbYZI88pvs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 6.6 173/273] arm64: dts: qcom: sm6115: Fix CDSP memory length
Date: Thu, 13 Feb 2025 15:29:05 +0100
Message-ID: <20250213142414.168422846@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213142407.354217048@linuxfoundation.org>
References: <20250213142407.354217048@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

commit 846f49c3f01680f4af3043bf5b7abc9cf71bb42d upstream.

The address space in MPSS/Modem PAS (Peripheral Authentication Service)
remoteproc node should point to the QDSP PUB address space
(QDSP6...SS_PUB) which has a length of 0x4040.  Value of 0x100000 covers
entire Touring/CDSP memory block seems to big here.

This should have no functional impact on Linux users, because PAS loader
does not use this address space at all.

Cc: stable@vger.kernel.org
Fixes: 96ce9227fdbc ("arm64: dts: qcom: sm6115: Add remoteproc nodes")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20241213-dts-qcom-cdsp-mpss-base-address-v3-22-2e0036fccd8d@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -2384,7 +2384,7 @@
 
 		remoteproc_cdsp: remoteproc@b300000 {
 			compatible = "qcom,sm6115-cdsp-pas";
-			reg = <0x0 0x0b300000 0x0 0x100000>;
+			reg = <0x0 0x0b300000 0x0 0x4040>;
 
 			interrupts-extended = <&intc GIC_SPI 265 IRQ_TYPE_EDGE_RISING>,
 					      <&cdsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,




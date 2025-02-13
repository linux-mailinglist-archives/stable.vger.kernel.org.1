Return-Path: <stable+bounces-115450-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B74A343D6
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F15AF163D1A
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 14:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF680266181;
	Thu, 13 Feb 2025 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oRc+vu75"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE422222D3;
	Thu, 13 Feb 2025 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739458096; cv=none; b=MMbhlsvIHwwklAaY4QbhIEQM9kA954J/N2i9j+b+9HppTn4J2hhtiyJUGabB41bHa52EaCD+4UkeduR+Y9wMxMSAtt8VTXeu7rDew6CvJNoGN1TfriVL6fyknis9gLw/yRHYp3JGhF/Wq8MOl9aHBNMBqFRoUe6lo+znMAXGzYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739458096; c=relaxed/simple;
	bh=aG7XGZ/jeQFK7XGhL8C1EfeGpAhpzp7uxxasfUGd1TE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eGnjVVSXPK7lOBMvU9r+QKPTA3Sh97FmFUqDfZWick2c4ebBvwOxRpUXeuIZvdbpCZ5MfjW5LBAvVMlA+dSEtpWY/mgGIamEx09pMylrK2zbFS1jyoxFoyvAoGbxqe83SW1K6tmzTgPO7YOpvOuv+mybjwvA++srr138Rnn3908=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oRc+vu75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC24C4CED1;
	Thu, 13 Feb 2025 14:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739458096;
	bh=aG7XGZ/jeQFK7XGhL8C1EfeGpAhpzp7uxxasfUGd1TE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oRc+vu75xRKUYqdgAV1xk2Oq/gd/YTXFE0OIG1q98hFrCGCi550A1CEgvL6bzD/Mk
	 Y+IW8tvs7eOO1/+3ezTTejYE400A0gN8s04zutZ56j5nSn+6DzawgKoSPtRYLlsO7z
	 PnApKQ22VygLC1W+HtdbbbiC2aclEoaSBoukqNc8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 6.12 269/422] arm64: dts: qcom: sdx75: Fix MPSS memory length
Date: Thu, 13 Feb 2025 15:26:58 +0100
Message-ID: <20250213142446.923293628@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213142436.408121546@linuxfoundation.org>
References: <20250213142436.408121546@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

commit 9a27f0e1869e992e4107e2af8ec348e1a3b9d4d5 upstream.

The address space in MPSS/Modem PAS (Peripheral Authentication Service)
remoteproc node should point to the QDSP PUB address space
(QDSP6...SS_PUB) which has a length of 0x10000.  Value of 0x4040 was
copied from older DTS, but it grew since then.

This should have no functional impact on Linux users, because PAS loader
does not use this address space at all.

Cc: stable@vger.kernel.org
Fixes: 41c72f36b286 ("arm64: dts: qcom: sdx75: Add remoteproc node")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20241213-dts-qcom-cdsp-mpss-base-address-v3-20-2e0036fccd8d@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/qcom/sdx75.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdx75.dtsi b/arch/arm64/boot/dts/qcom/sdx75.dtsi
index 06d956f5cd4e..b0a8a0fe5f39 100644
--- a/arch/arm64/boot/dts/qcom/sdx75.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdx75.dtsi
@@ -893,7 +893,7 @@ tcsr: syscon@1fc0000 {
 
 		remoteproc_mpss: remoteproc@4080000 {
 			compatible = "qcom,sdx75-mpss-pas";
-			reg = <0 0x04080000 0 0x4040>;
+			reg = <0 0x04080000 0 0x10000>;
 
 			interrupts-extended = <&intc GIC_SPI 250 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_modem_in 0 IRQ_TYPE_EDGE_RISING>,
-- 
2.48.1





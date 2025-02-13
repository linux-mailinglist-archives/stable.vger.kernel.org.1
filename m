Return-Path: <stable+bounces-115436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A35FEA343E3
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DA2A1892DA0
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 14:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CD526980D;
	Thu, 13 Feb 2025 14:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BitIxG1e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B87245027;
	Thu, 13 Feb 2025 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739458049; cv=none; b=Acj3l0Tpfl6BgwsYZTNnZYkg7TyE20bkO7xpL1bJR+kfDbQyGhTFzrySz03sEFq+H9jZmQJQyWvdF8WKlkeVKuOwltaZt5I+NO7nxrcveZbWuq7YIfOnUyukkQgyzP53lO+vFCNkVVLgt4aOjOwPS8BDgjqlSo/OS0XOTO0X+go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739458049; c=relaxed/simple;
	bh=SMF8U4yAxKnNaDM2XXIYcGEhLWVh7jPPlKrDJ+l/OlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FvQMc8CIJt7eqdQ3BfwD+QgaFBX/95e5Sr/WFLORdMh7FdV+k95OZm+Pa9ATE1ATES7vds0/urJl6SxB7UfQ4qYUvxhfZpTos6UDnYdeDUWC6MQcTtnGv/MzRCTtAAQ+oKslVn8Y1QVhGmDDt70nM4r+6ZmrU+MLdGcehIWxUaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BitIxG1e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3CCC4CEF2;
	Thu, 13 Feb 2025 14:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739458048;
	bh=SMF8U4yAxKnNaDM2XXIYcGEhLWVh7jPPlKrDJ+l/OlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BitIxG1e2/McxasO0VHgLAO3deLJQtpuDS9CCECINbcKl35ckmuxsD8+CigSVOQzv
	 SkpkCM6O/a+Y7OF28GplaLSXl3GNgafiztIGxD+VNhLo6TEl3P3iMaTjWQgJIKc3L3
	 LhUvoZhx9jk7MefEJOAYZ4DkpwCMPfrke+D7NbUc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 6.12 286/422] arm64: dts: qcom: sm8450: Fix MPSS memory length
Date: Thu, 13 Feb 2025 15:27:15 +0100
Message-ID: <20250213142447.581217362@linuxfoundation.org>
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

commit fa6442e87ab7c4a58c0b5fc64aab1aacc8034712 upstream.

The address space in MPSS/Modem PAS (Peripheral Authentication Service)
remoteproc node should point to the QDSP PUB address space
(QDSP6...SS_PUB) which has a length of 0x10000.  Value of 0x4040 was
copied from older DTS, but it grew since then.

This should have no functional impact on Linux users, because PAS loader
does not use this address space at all.

Fixes: 1172729576fb ("arm64: dts: qcom: sm8450: Add remoteproc enablers and instances")
Cc: stable@vger.kernel.org
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20241213-dts-qcom-cdsp-mpss-base-address-v3-6-2e0036fccd8d@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2903,7 +2903,7 @@
 
 		remoteproc_mpss: remoteproc@4080000 {
 			compatible = "qcom,sm8450-mpss-pas";
-			reg = <0x0 0x04080000 0x0 0x4040>;
+			reg = <0x0 0x04080000 0x0 0x10000>;
 
 			interrupts-extended = <&intc GIC_SPI 264 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_modem_in 0 IRQ_TYPE_EDGE_RISING>,




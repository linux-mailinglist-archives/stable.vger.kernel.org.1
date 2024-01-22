Return-Path: <stable+bounces-14854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E95838344
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84D93B24AE0
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C6450258;
	Tue, 23 Jan 2024 01:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xScfH2BX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488F85FDC1;
	Tue, 23 Jan 2024 01:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974655; cv=none; b=FYusYCvZOcq4eFbCyoGLw71cfdRDV3OldjTHEwDeJ/tmrtxdz5q0KyiARFs5Y3GcyJvrer2Nc87KdcX9n3NFCXvjnJowWX3PvOjZr4EBSZiOc1QJt2TFOxpFMS/xuJAUoYLcpSm+1bhCyril+z854ocM9QajtiY7wmqsopXz2a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974655; c=relaxed/simple;
	bh=jO3SLANhpaiCmfMyo3dTifB+vCZOMGw/sSUpVNUBkss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IOLw95l5UPghr/Vm3Gwn6HgKjsaYojAnMp6JzI/DInDsgYfNLQkwEhLh2hynLRcc9+bvwnU02KW6zCrgWbZ9j7+6QyNR8spt/Hs7RHbkqpPel51JPDd2NbKKuQ9khrXddwafFRYzJSECZIDRwGr4HUC8NzdQznvM9VrRqzXD2pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xScfH2BX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4DCC43399;
	Tue, 23 Jan 2024 01:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705974655;
	bh=jO3SLANhpaiCmfMyo3dTifB+vCZOMGw/sSUpVNUBkss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xScfH2BXD59CwULs1DGnMWRZgGQi6vMF5iR77jMmRvw94vesgZhO+oPi0ZpVRmpRC
	 BxbRFcx9MPa6mq3w1S9GhRKoNb9P17nk/jlrqwOxcVhwkjmn1Rqf0mHFBM645p2Bso
	 qSf3Gy4Z20NcfRE9AYo0OVxETRi6CCLrRMr0FxIk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 109/583] arm64: dts: qcom: sm8550: correct TX Soundwire clock
Date: Mon, 22 Jan 2024 15:52:40 -0800
Message-ID: <20240122235815.503165991@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
User-Agent: quilt/0.67
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

[ Upstream commit ead0f132fc494b46fcd94788456f9b264fd631bb ]

The TX Soundwire controller should take clock from TX macro codec, not
VA macro codec clock, otherwise the clock stays disabled.  This looks
like a copy-paste issue, because the SC8280xp code uses here correctly
clock from TX macro.  The VA macro clock is already consumed by TX macro
codec, thus it won't be disabled by this change.

Fixes: 61b006389bb7 ("arm64: dts: qcom: sm8550: add Soundwire controllers")
Reported-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/r/20231129140537.161720-2-krzysztof.kozlowski@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index d115960bdeec..52c0c1730702 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -2178,7 +2178,7 @@ swr2: soundwire-controller@6d30000 {
 			interrupts = <GIC_SPI 496 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 520 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "core", "wakeup";
-			clocks = <&lpass_vamacro>;
+			clocks = <&lpass_txmacro>;
 			clock-names = "iface";
 			label = "TX";
 
-- 
2.43.0





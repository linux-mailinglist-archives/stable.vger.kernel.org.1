Return-Path: <stable+bounces-164614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5574B10CB8
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 16:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDC571C243A1
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 14:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044972C3773;
	Thu, 24 Jul 2025 14:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHxJKqcf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B7B2C2ACE
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 14:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753366169; cv=none; b=F4J824ZvjOzD1fgrb4WbtPBIOG9qDqfG3cRKg8F3Zun7wv+0lKL508QpO1yeZZgTcegw3a/y82HZQERbFVJoc1jWpT6MaoxpIOHT8lkcA6D/ifZo1qS81Teh+NczOMz9JsXv1+kBC96+EAsqwUxfcx5AK1kY3NdIKPQSdMDARVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753366169; c=relaxed/simple;
	bh=5ZBfrtmQTISoCtlECx5yMWCiuJv8lY+fvUdsiwbAEkg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WekQWPyVbK1ztDiSn0+zz1Li/wOBpnqynmgfZ3jY9Ra6M3gKwoyFLuIgM0xHtlE9EfZWtG/8x9Ad5XJvwZChSTRMb4Kwi2pphH6r06a296bPGnD9YFk4g0sSkJMyh+WFtVF2X4aTx2Y5HVBoazDIjPeOWQPb+g57YVxdd4HCv8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHxJKqcf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6BEFC4CEED;
	Thu, 24 Jul 2025 14:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753366169;
	bh=5ZBfrtmQTISoCtlECx5yMWCiuJv8lY+fvUdsiwbAEkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LHxJKqcf8rPX6eGQnfeoxT7b6P77OV/ZqJJe/dUZO1Wv+q/TXQyQsJtzkmMK6T3fC
	 GkdIpC5dKwoEyk7+Y6+cP0WUsz/MeCU1SGk7TET2Xm8bS4/UrDkyE29I21+xL57ZSf
	 gtyKtIOcwO6wtqPB5Rv8UqCFyECL8KDyxNeTtoT0/3aGlFV7MxsHzzEeQbjOm1Sysl
	 Y0dpiWcS94vWMQAr0aTGrniLH02h0qDV3H1BgQc+MJ0tkQ7wpzBY1vdaJErMrsVq84
	 EEG+34h8TDw8uqW55Fh5UJ8ZcX3BeFlwmUika2uUWI31QHr9Q1sKcAuVMcKGVaMwAH
	 pWhb3jKmusCxg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Stephan Gerhold <stephan.gerhold@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] arm64: dts: qcom: x1-crd: Fix vreg_l2j_1p2 voltage
Date: Thu, 24 Jul 2025 10:09:23 -0400
Message-Id: <20250724140923.1305618-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025060236-resale-proactive-e484@gregkh>
References: <2025060236-resale-proactive-e484@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stephan Gerhold <stephan.gerhold@linaro.org>

[ Upstream commit 5ce920e6a8db40e4b094c0d863cbd19fdcfbbb7a ]

In the ACPI DSDT table, PPP_RESOURCE_ID_LDO2_J is configured with 1256000
uV instead of the 1200000 uV we have currently in the device tree. Use the
same for consistency and correctness.

Cc: stable@vger.kernel.org
Fixes: bd50b1f5b6f3 ("arm64: dts: qcom: x1e80100: Add Compute Reference Device")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20250423-x1e-vreg-l2j-voltage-v1-1-24b6a2043025@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
[ Change x1e80100-crd.dts instead ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
index 2a504a449b0bb..e5d0d7d898c38 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
@@ -659,8 +659,8 @@ vreg_l1j_0p8: ldo1 {
 
 		vreg_l2j_1p2: ldo2 {
 			regulator-name = "vreg_l2j_1p2";
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1200000>;
+			regulator-min-microvolt = <1256000>;
+			regulator-max-microvolt = <1256000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
-- 
2.39.5



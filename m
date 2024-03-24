Return-Path: <stable+bounces-28877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E2A888105
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 00:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CCAA281800
	for <lists+stable@lfdr.de>; Sun, 24 Mar 2024 23:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924F814198B;
	Sun, 24 Mar 2024 22:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3jHMzxh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EAC140E58;
	Sun, 24 Mar 2024 22:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319854; cv=none; b=GZ3qKwcFIGpZFCJT3jXxXp6bKGfQ/kjiZ2NU7bRJykmavskA8WOZS+3BuQVstf+DwRUoT4tgEj8hY+27Xj/9k9KhFxTAmvn1xfiSSZU5GWLcL2055d8Lt6HuqWhWoUgccksKzeKaY+kX1Wybd7UyFLST9lWxo5vUxU4DezChX+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319854; c=relaxed/simple;
	bh=3dyTJT4nnoaVRgAZyeo0M/RmlnJNy3l+FyeWtIk1zoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=auw24PSA4XITlpnsjlWf2lDmAIiyzAhkfoTs1QmpakLuLqyQVSNddilN/IAEVlulCWLaZnKxnww2A5fqNu/zr/cNYfwht/fwEQ/qve8FLvgyGgFhzSfqAYXedRfD0s4EBgNRS6DNFnEsbJVy8Id6pDlIcJrquRMIKAlpncPCif4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3jHMzxh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DBF2C43399;
	Sun, 24 Mar 2024 22:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319854;
	bh=3dyTJT4nnoaVRgAZyeo0M/RmlnJNy3l+FyeWtIk1zoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K3jHMzxh6q6/wP4x9N+XEr1ux1ke74uhS7Wo35hAQuE81gP0VRXALwHDEeVU50Ggp
	 OaLrsYrtiWecb/2aqN2IArnOy5b40R2BCU8bHUHNgcXQFliqVK9OxEnNIrP9vuFwQP
	 Ly40pD5FaV7TVUYumdsb6FbiFTw/vwgpx71W7Xorxc9X48ygKp5pPMA3JovYA/B5cE
	 wGCEbt+IRW9XFxiWQIMFUlpCoA8R8qCZXQiH6RT110ZsmXhIIjo6heo5pfb0VCb4Mk
	 ug5G1LoxPFLR5XFnGCyzUfbm3lQO1Olt5RxWq/XCf4v0R/1LIF6wwma6yeT6WUMVJr
	 ut6b+lmwO1qjA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 157/715] arm64: dts: qcom: sm8650: Fix UFS PHY clocks
Date: Sun, 24 Mar 2024 18:25:36 -0400
Message-ID: <20240324223455.1342824-158-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

[ Upstream commit 0f9b8054bb4abd7b4686cc66b85f71fec9160136 ]

QMP PHY used in SM8650 requires 3 clocks:

* ref - 19.2MHz reference clock from RPMh
* ref_aux - Auxiliary reference clock from GCC
* qref - QREF clock from TCSR

Fixes: 10e024671295 ("arm64: dts: qcom: sm8650: add interconnect dependent device nodes")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20240131-ufs-phy-clock-v3-17-58a49d2f4605@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 2df77123a8c7b..bad0eb84549fe 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -2448,10 +2448,12 @@ ufs_mem_phy: phy@1d80000 {
 			compatible = "qcom,sm8650-qmp-ufs-phy";
 			reg = <0 0x01d80000 0 0x2000>;
 
-			clocks = <&tcsr TCSR_UFS_CLKREF_EN>,
-				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
+				 <&tcsr TCSR_UFS_CLKREF_EN>;
 			clock-names = "ref",
-				      "ref_aux";
+				      "ref_aux",
+				      "qref";
 
 			resets = <&ufs_mem_hc 0>;
 			reset-names = "ufsphy";
-- 
2.43.0



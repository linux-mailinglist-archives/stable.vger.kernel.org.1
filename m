Return-Path: <stable+bounces-73220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C46796D3D8
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 11:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30A211F22BD8
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 09:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECF3198E90;
	Thu,  5 Sep 2024 09:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UxPXwH4t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA46198845;
	Thu,  5 Sep 2024 09:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725529527; cv=none; b=Ntyxy3xWcNhzQnBadLMzrUz364GXU1H+PH7FaZFb7tfDWK5MXRbKUWH1dSotqLXkT2GWlY5XVo1vCfC+bxcUha1FHdJeF5Wd2AqLwucvks1/jLAy06LVzZQC8F7uGsnGY1mUDFMmGq/kblHEFqsVI5WACHyZINFFE61s8YxMmSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725529527; c=relaxed/simple;
	bh=MyfO/IxzAwslfSo+d3IMl3wfcGidLcNBCeUir1GqKIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LXcn4cfDZODr6ydTaOVwUz/gvvfLcXfathjz0B5a/VtzQVQXfUFxva/UoPvwq/c7nNp5XNQRC5Zx/YxwSYDr7p44I5IwHYdeTKupa5lw7m7VSPtlVsv4/mcCOTW+8mAxUPSs4aqil7j6men3t1GOhyA43zF2fc3i3CmsixBeqSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UxPXwH4t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827DFC4CEC3;
	Thu,  5 Sep 2024 09:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725529527;
	bh=MyfO/IxzAwslfSo+d3IMl3wfcGidLcNBCeUir1GqKIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UxPXwH4tyhj9BpJMMJvIuCe9LtysctXmUdj2dau3Vhd2RVwHgM5CoHkQA1IKa83NG
	 sVhqs7uxchnI1pQlsGn5oPouRGL4Gxv9a6kjLVqVoyixfAy+Yu4XiOGpUqT33OLLlv
	 ljIAgmq3ZZkwIE0pxGFDjZGRtYtinp2731gSYZCc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 030/184] arm64: dts: qcom: x1e80100-crd: fix up PCIe6a pinctrl node
Date: Thu,  5 Sep 2024 11:39:03 +0200
Message-ID: <20240905093733.423401014@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905093732.239411633@linuxfoundation.org>
References: <20240905093732.239411633@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan+linaro@kernel.org>

[ Upstream commit 6e3902c499544291ac4fd1a1bb69f2e9037a0e86 ]

The PCIe6a pinctrl node appears to have been copied from the sc8280xp
CRD dts, which has the NVMe on pcie2a and uses some funny indentation.

Fix up the node name to match the x1e80100 use and label and use only
tabs for indentation.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20240722094249.26471-5-johan+linaro@kernel.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Stable-dep-of: 42b33ad18846 ("arm64: dts: qcom: x1e80100-crd: fix missing PCIe4 gpios")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
index 0d47c75e2ad8c..4096bb1ee4d3a 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
@@ -833,7 +833,7 @@
 		bias-disable;
 	};
 
-	pcie6a_default: pcie2a-default-state {
+	pcie6a_default: pcie6a-default-state {
 		clkreq-n-pins {
 			pins = "gpio153";
 			function = "pcie6a_clk";
@@ -849,11 +849,11 @@
 		};
 
 		wake-n-pins {
-		       pins = "gpio154";
-		       function = "gpio";
-		       drive-strength = <2>;
-		       bias-pull-up;
-	       };
+			pins = "gpio154";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
 	};
 
 	tpad_default: tpad-default-state {
-- 
2.43.0





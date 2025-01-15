Return-Path: <stable+bounces-108906-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE19A120DE
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 11:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6D333AA148
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 10:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5198E248BCB;
	Wed, 15 Jan 2025 10:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KpsIhaly"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5C9248BA1;
	Wed, 15 Jan 2025 10:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736938202; cv=none; b=QYzIX4V0+85rfe+S8FVfkgOyUoehomZKe1OUsSq+hEYZ9gq4xLNchWHhpmVbGBEj9UoESmsDtjmrzd+TM8tYaZe7oRdTJYlxTSYVdyLDXsEZbSCWpbJEPd9jPUdjGmh7eQBHsZ9BBaK/XDx9KtRNEY1LHTrM7YPvutY9Ybzr2mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736938202; c=relaxed/simple;
	bh=7TZvfXOAElq5rtv9oTjZceoE/wXjK+HNS4HavBr/Dx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJ7GHBbAeUJIm60/7TZ8Lp/vgEjAfNXYGrdCj+kmCzo9/UymFzvpjtRPOY2EpH4acsvOOy8jUfNuON1D/YxIoB9HjglbzG2K5dxahcVW8TOY/JgattR5HCq4ClVs9O7xUvdRztk7XR8jvNoYlRG35CiYiBh+HCSSNbZzPNeZm0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KpsIhaly; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23939C4CEDF;
	Wed, 15 Jan 2025 10:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736938201;
	bh=7TZvfXOAElq5rtv9oTjZceoE/wXjK+HNS4HavBr/Dx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KpsIhalyV0tzPgv5imprMAMfoQut9PFDz2Vqc4v9hn7i2S1uHDOBj59w1r72LV3RP
	 1xJnW2tgfWd1+KsDMBYuA+Bn5jAMrLcqG8n6aPVokSVlUVGBinDQO7PxerCcG42RQI
	 Ug5Cgek3Erbe7eSlAKxX3+FDhxVCNZDx5Q+8zOAw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 6.12 113/189] arm64: dts: qcom: sa8775p: Fix the size of addr_space regions
Date: Wed, 15 Jan 2025 11:36:49 +0100
Message-ID: <20250115103610.965645139@linuxfoundation.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250115103606.357764746@linuxfoundation.org>
References: <20250115103606.357764746@linuxfoundation.org>
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

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

commit e60b14f47d779edc38bc1f14d2c995d477cec6f9 upstream.

For both the controller instances, size of the 'addr_space' region should
be 0x1fe00000 as per the hardware memory layout.

Otherwise, endpoint drivers cannot request even reasonable BAR size of 1MB.

Cc: stable@vger.kernel.org # 6.11
Fixes: c5f5de8434ec ("arm64: dts: qcom: sa8775p: Add ep pcie1 controller node")
Fixes: 1924f5518224 ("arm64: dts: qcom: sa8775p: Add ep pcie0 controller node")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20241128145147.145618-1-manivannan.sadhasivam@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -5587,7 +5587,7 @@
 		      <0x0 0x40000000 0x0 0xf20>,
 		      <0x0 0x40000f20 0x0 0xa8>,
 		      <0x0 0x40001000 0x0 0x4000>,
-		      <0x0 0x40200000 0x0 0x100000>,
+		      <0x0 0x40200000 0x0 0x1fe00000>,
 		      <0x0 0x01c03000 0x0 0x1000>,
 		      <0x0 0x40005000 0x0 0x2000>;
 		reg-names = "parf", "dbi", "elbi", "atu", "addr_space",
@@ -5744,7 +5744,7 @@
 		      <0x0 0x60000000 0x0 0xf20>,
 		      <0x0 0x60000f20 0x0 0xa8>,
 		      <0x0 0x60001000 0x0 0x4000>,
-		      <0x0 0x60200000 0x0 0x100000>,
+		      <0x0 0x60200000 0x0 0x1fe00000>,
 		      <0x0 0x01c13000 0x0 0x1000>,
 		      <0x0 0x60005000 0x0 0x2000>;
 		reg-names = "parf", "dbi", "elbi", "atu", "addr_space",




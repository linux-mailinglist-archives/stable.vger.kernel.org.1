Return-Path: <stable+bounces-186217-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF18BE5C09
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 01:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E93F4E4C06
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 23:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D1025C70D;
	Thu, 16 Oct 2025 23:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rsrH5u3e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9FF49659
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 23:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760655669; cv=none; b=anS8MpH8Gb1Vvw9Lfga+jq9/wpe9IpTVgzycnDEvhDCk7xNarQvgYz4iJpHt+klUv4nf8sB9dn5l+ZKh1bi8ePj6qwHIJ8lYhbwIMvhJwrKxYU1nsWM/85inCrqF9edI4Ix+9QpEQGqT2HBfM8kJQbSPQ6fw1v32y23EtpMcB0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760655669; c=relaxed/simple;
	bh=2a3OVGv5ZYPsdcyxmpgXLrP4P5nj5597wSX/wBW/ORI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=up32Ut2PDv2Z+VEpodVkMzeWUD1/J9J/saR0O40LiwotrzQqS0c06Z7sWm/GvhgiS9jd7StZ5ZCZl2SV9uSRb3KQUBfWgxE5vwCFEnXyqKp00CTn8Ml6TBmvMVhWQDTleEaABflbfoiFf1TnxjZW78lliF10V2dXS/qV2vbEXTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rsrH5u3e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2235C4CEF1;
	Thu, 16 Oct 2025 23:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760655669;
	bh=2a3OVGv5ZYPsdcyxmpgXLrP4P5nj5597wSX/wBW/ORI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rsrH5u3e//Cf7Axtf4i9kLxRGio/OiRic+X3QW/5HfcStTNEHmDvdmBUiaaKI+6MH
	 Dn30jtEx7KdtIeqdpWPEo+g+bzzbS3cWaocmlJUgG5nzYit2T37VlA35ZEJ49AH2Ea
	 RNoQrZ+oHmdE14AToS63e32x3dHn/DRQZte4GiNYL04OawdeuCQczK+8KbI/sXWaUi
	 pQwSX6bvC1XqM2ClD1R1Ts7NVFNQxHhjiZgMfgHIjgX2q8ETDsFsn0TAMBnk5w+aUU
	 noTBLyQLzbpYbHz67XLb8EJdNyr76ghg1I/SC+qXWzHNJHbYbOUGNXx7Og2ioTyblx
	 z2oNCiiSxddGg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Stephan Gerhold <stephan.gerhold@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] arm64: dts: qcom: sdm845: Fix slimbam num-channels/ees
Date: Thu, 16 Oct 2025 19:01:06 -0400
Message-ID: <20251016230106.3454355-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101653-gray-unbroken-db61@gregkh>
References: <2025101653-gray-unbroken-db61@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stephan Gerhold <stephan.gerhold@linaro.org>

[ Upstream commit 316294bb6695a43a9181973ecd4e6fb3e576a9f7 ]

Reading the hardware registers of the &slimbam on RB3 reveals that the BAM
supports only 23 pipes (channels) and supports 4 EEs instead of 2. This
hasn't caused problems so far since nothing is using the extra channels,
but attempting to use them would lead to crashes.

The bam_dma driver might warn in the future if the num-channels in the DT
are wrong, so correct the properties in the DT to avoid future regressions.

Cc: stable@vger.kernel.org
Fixes: 27ca1de07dc3 ("arm64: dts: qcom: sdm845: add slimbus nodes")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20250821-sdm845-slimbam-channels-v1-1-498f7d46b9ee@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 69212445d22c9..c00b5712959d3 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -4839,11 +4839,11 @@ slimbam: dma-controller@17184000 {
 			compatible = "qcom,bam-v1.7.0";
 			qcom,controlled-remotely;
 			reg = <0 0x17184000 0 0x2a000>;
-			num-channels  = <31>;
+			num-channels = <23>;
 			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
 			qcom,ee = <1>;
-			qcom,num-ees = <2>;
+			qcom,num-ees = <4>;
 			iommus = <&apps_smmu 0x1806 0x0>;
 		};
 
-- 
2.51.0



Return-Path: <stable+bounces-186221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0438FBE5DC1
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 02:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B63A4405C59
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 00:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2331C2BD;
	Fri, 17 Oct 2025 00:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5MQpUeg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB603208
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 00:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760659867; cv=none; b=sL+tDBmuQF+KpD9t9mH6rbXBVIfA+dX1JqoVysAMysnqJBgdXzKQPRyiljdwwletHdlyzp4w1q+zZVgygz5MHhdstn/RasoNB2opeOh1JkU2rGr4Vw9LLZA424GfF4M4Zq0/DpD4kJcR4yPqO1ZP2d7Mc1lAbq9p8dmT4pbTJaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760659867; c=relaxed/simple;
	bh=zUiMqPo81Qrg1s61sUYVHbTXfdbpWEJSeOnsH3GF/kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P5A7BdxfoOqjd3AngsYSDbkpQ2qeuqf40XgZxLTvc79LgnztI8vd/rMXa+h20Uvv7Fb9PAi6+OgFTiyoQrlA819vmjwW1IErZ8GmCJERy3kOReBkNN4qZRAVJj4euO9S/jqWqMqB/WPidmquOaLojxF7DXvgUNtBuA7rEex3zwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5MQpUeg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8A5C4CEF1;
	Fri, 17 Oct 2025 00:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760659865;
	bh=zUiMqPo81Qrg1s61sUYVHbTXfdbpWEJSeOnsH3GF/kk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a5MQpUeg5bhEF6Uy2RbJDqsDN2gHoH0jBgmssjy8ZEMeoXGAE3hVzMw9r6CGHFwW+
	 9c3kjkm3t5oTGztXOWMJ4b1IJj73uP/SBEKgrO+31Cn+QGJ621cs+2qWe8rLgUelxZ
	 WLky3RqMdxxMP0s8foLHjTRi4TQGeRp+VzCqQLxHD6mbOaFvf+oY/qCV58398+fVCw
	 97MOwSjzU+ZZxIibnaCSD6UHdvEBMDWfz5Dl2Kt2tP5R44Z+sYPwOVaeD2Lp7Ff0Y/
	 d95jc3Y55ICbJy6NtOBCe4g0OSFXuK8KsAN//h53k77xZna4gyW9rGwHK103OMiFQj
	 Dbz20xF/0hxDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Stephan Gerhold <stephan.gerhold@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] arm64: dts: qcom: sdm845: Fix slimbam num-channels/ees
Date: Thu, 16 Oct 2025 20:11:02 -0400
Message-ID: <20251017001102.3477703-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101653-armory-oxygen-af78@gregkh>
References: <2025101653-armory-oxygen-af78@gregkh>
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
index da48ae60155af..4422392fb60e0 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -4492,11 +4492,11 @@ slimbam: dma@17184000 {
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



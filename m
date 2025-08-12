Return-Path: <stable+bounces-168816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 466B9B236E3
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 119E07BC07C
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9211B26FA77;
	Tue, 12 Aug 2025 19:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cIIDiLQg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C5F3D994;
	Tue, 12 Aug 2025 19:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755025429; cv=none; b=WdvTiGVGzXXRpM7sVRp6LAe/bZTNiQhCnuMfG9sy9WhMigXRx8emae1YBsfW9oCOJYzF0X/VMBWdNgbkjL3VIIIZ+tDdNp8bsyEY+fGTBC5yGSmDAETlC01rqJ9OgZrqd5pE3QdfBkRLAvBeR+E20rcpvRvXsjwuoxSVd00XCIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755025429; c=relaxed/simple;
	bh=bxBr6Av/C46/Yaymnl0flCI3iSwDkcO+44xlcKHkwBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ABQuYFGxIauKVReNKC5K72upuDE8K+sZpWD7v4oGKVbiMlBjTIj1Yo740PsFMButUC1rWl1YifszjZoka426o95tu/X/OOPP8emkc8mJzlPSv73MwF0bJkEDP4dON/oD+66Dnn257RNPXMW3UEdYIkWy5nVBOrBeIJoB3NyXYww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cIIDiLQg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9645C4CEF0;
	Tue, 12 Aug 2025 19:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755025429;
	bh=bxBr6Av/C46/Yaymnl0flCI3iSwDkcO+44xlcKHkwBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cIIDiLQg6qAzLtaHEe3KYYWtXs/5UPupyiX4RGiUOE/7icxaSlaNc8nuxCszxCwvl
	 /yQ+A85w9TRO80C+kOxnWjkc7WoBIQqSjJRa1KDz8TPfKB1XA+r/Qgp4xwoHuQW66S
	 Ir6ZuAgBKrgEjyWcAEKpguvwzz7fbytb3cKIwSw0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 037/480] arm64: dts: qcom: sdm845: Expand IMEM region
Date: Tue, 12 Aug 2025 19:44:05 +0200
Message-ID: <20250812174358.933125337@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812174357.281828096@linuxfoundation.org>
References: <20250812174357.281828096@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

[ Upstream commit 81a4a7de3d4031e77b5796479ef21aefb0862807 ]

We need more than what is currently described, expand the region to its
actual boundaries.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Fixes: 948f6161c6ab ("arm64: dts: qcom: sdm845: Add IMEM and PIL info region")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20250523-topic-ipa_mem_dts-v1-2-f7aa94fac1ab@oss.qualcomm.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index d0314cdf0b92..0e6ec2c54c24 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -5078,18 +5078,18 @@ spmi_bus: spmi@c440000 {
 			#interrupt-cells = <4>;
 		};
 
-		sram@146bf000 {
+		sram@14680000 {
 			compatible = "qcom,sdm845-imem", "syscon", "simple-mfd";
-			reg = <0 0x146bf000 0 0x1000>;
+			reg = <0 0x14680000 0 0x40000>;
 
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-			ranges = <0 0 0x146bf000 0x1000>;
+			ranges = <0 0 0x14680000 0x40000>;
 
-			pil-reloc@94c {
+			pil-reloc@3f94c {
 				compatible = "qcom,pil-reloc-info";
-				reg = <0x94c 0xc8>;
+				reg = <0x3f94c 0xc8>;
 			};
 		};
 
-- 
2.39.5





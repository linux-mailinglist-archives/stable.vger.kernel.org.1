Return-Path: <stable+bounces-167789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9A9B23202
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98328582C2D
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A062FE59D;
	Tue, 12 Aug 2025 18:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R/ooQ2eM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A032FE594;
	Tue, 12 Aug 2025 18:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021996; cv=none; b=SkV0BZlAWkXqVlas0SJvSq9e6u2e9whABR0cODqa7z3jYp6dFHz1tHJX6XSzlaj+Fku/woTofqdKk/NrAAy402C9jjACtrmKpAaQNzkK4tcq4xkfUFe1QBotcmD2aWfPRB9KqLen+0G3gztnkVNh6Xb9/XwZQM9dp7HFu26M8q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021996; c=relaxed/simple;
	bh=1zJwioIk4E8LTfMnWTqnxS0juL3E+EKrQgm1e0KIFxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=prgHqvVtj5S2goA61XSSP18aPkFVhAfkoGBM5kQJJDVFABBJ2TgLIxz40/b7Zn4MnK/kXag2Bc5jjW28m+mlpr9z2muV4RGfCJx55bj5/XuiGn73f+SWpo7RJPLG2/WfTNp7qtTGcUmtWIqPdxBmCvkLClv5AvuFa8UUxDZkgoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R/ooQ2eM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E7BC4AF0B;
	Tue, 12 Aug 2025 18:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755021996;
	bh=1zJwioIk4E8LTfMnWTqnxS0juL3E+EKrQgm1e0KIFxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R/ooQ2eM/jKOl3TwDU4OWJ6e1+frJpSBZ8OCiYDUhOZzq6904QJ4rkjJOjpqXxj0n
	 TjbR6k5o17UhPI+kp31S7B2tcAMRmp7N7xE7kAHflhQESViTpocxDZRYXtLZnuaBli
	 9Xf8TWCJmEBJCqQCAJXKZbj3+f61AO5bq/VchRDk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 024/369] arm64: dts: qcom: sdm845: Expand IMEM region
Date: Tue, 12 Aug 2025 19:25:21 +0200
Message-ID: <20250812173015.650886732@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173014.736537091@linuxfoundation.org>
References: <20250812173014.736537091@linuxfoundation.org>
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
index 0a0cef9dfcc4..9bf7a405a964 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -5074,18 +5074,18 @@ spmi_bus: spmi@c440000 {
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





Return-Path: <stable+bounces-11515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B727982F843
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 21:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 503D428653A
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 20:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98B112FF62;
	Tue, 16 Jan 2024 19:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttetgnPT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFD824B3A;
	Tue, 16 Jan 2024 19:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434674; cv=none; b=OEyrrMzKu5IOmcpG2TN5Fayxs/9U5AblzIjZI4lrdCNzwHsAGuQQqb3LgzTfjdeNrpSPbHQoO5e/DoHY0aGvDw3/gzh7ZiDBtpUsJmUwjRUKAy3beRFsiXdq04q7x4TnbUUzv2ypfrzrUEzlsJCZ59+7UKMY0jIErcM3jdHfuY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434674; c=relaxed/simple;
	bh=DJqFzKM/R5qbhMH3cy3CmNVVhKcvkd7lZ//PRyOG2k4=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=QSwMPefqIK7jvwxevMNEWvz0FfIKx5bs4/wkabaxKeoXI3azX6d9qJXYuIkkYCDVMIUiz/b/3fw6ZTPEaUrPKtCN5XAooLju5HfZAlcECd9KFZmJ4nNLQngbDtwMHBfG755kWiPJewgCSQu/J8m8FPZhyrJMnxlyWSO2tVfy498=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttetgnPT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3BC6C433C7;
	Tue, 16 Jan 2024 19:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434674;
	bh=DJqFzKM/R5qbhMH3cy3CmNVVhKcvkd7lZ//PRyOG2k4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ttetgnPT0H64wwdvPfbUMSQS5iF4bF0RCA75Erct8TXfKUDfYh7m/0Qcj7PjGB4i4
	 Wk/1ey+pBgdTXfXrKG80D9bVAGXJV21XMNztd9mVtIq2yuIXDbKLGk+nGetOtyyXa2
	 tNUyPDBdUUQIe3afE0SAFDEo334CAoZcREbrh9V0tH9AHdJ5QqxGmOFl0uhUEY19vi
	 Aw+gLSAhZvPbciXPvUExCiCCk+m31ewG6v+79BCkIIS71RFnal/TecCBAsAcZkvIoJ
	 BGLbCnoG/shurW0n+yPC8ly5lglcc8KFqEzJroKl1zcZWKQHRO+9hoP/iYwCoD6TR6
	 UBqNELBy4DVhQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	konrad.dybcio@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 045/104] arm64: dts: qcom: sm8450: fix soundwire controllers node name
Date: Tue, 16 Jan 2024 14:46:11 -0500
Message-ID: <20240116194908.253437-45-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Neil Armstrong <neil.armstrong@linaro.org>

[ Upstream commit 11fcb81373de52eeb1d3ff135a8d24a4b18978d3 ]

Fix the following dt bindings check:
arch/arm64/boot/dts/qcom/sm8450-hdk.dtb: soundwire-controller@31f0000: $nodename:0: 'soundwire-controller@31f0000' does not match '^soundwire(@.*)?$'
        from schema $id: http://devicetree.org/schemas/soundwire/qcom,soundwire.yaml#

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20231106-topic-sm8450-upstream-soundwire-bindings-fix-v1-1-41d4844a5a7d@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 2a60cf8bd891..cb4b38cfe21a 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2176,7 +2176,7 @@ wsa2macro: codec@31e0000 {
 			#sound-dai-cells = <1>;
 		};
 
-		swr4: soundwire-controller@31f0000 {
+		swr4: soundwire@31f0000 {
 			compatible = "qcom,soundwire-v1.7.0";
 			reg = <0 0x031f0000 0 0x2000>;
 			interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>;
@@ -2224,7 +2224,7 @@ rxmacro: codec@3200000 {
 			#sound-dai-cells = <1>;
 		};
 
-		swr1: soundwire-controller@3210000 {
+		swr1: soundwire@3210000 {
 			compatible = "qcom,soundwire-v1.7.0";
 			reg = <0 0x03210000 0 0x2000>;
 			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
@@ -2291,7 +2291,7 @@ wsamacro: codec@3240000 {
 			#sound-dai-cells = <1>;
 		};
 
-		swr0: soundwire-controller@3250000 {
+		swr0: soundwire@3250000 {
 			compatible = "qcom,soundwire-v1.7.0";
 			reg = <0 0x03250000 0 0x2000>;
 			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
@@ -2318,7 +2318,7 @@ swr0: soundwire-controller@3250000 {
 			status = "disabled";
 		};
 
-		swr2: soundwire-controller@33b0000 {
+		swr2: soundwire@33b0000 {
 			compatible = "qcom,soundwire-v1.7.0";
 			reg = <0 0x033b0000 0 0x2000>;
 			interrupts = <GIC_SPI 496 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.43.0



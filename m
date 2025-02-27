Return-Path: <stable+bounces-119812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0DDA4776B
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 09:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A10A6188EC0D
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 08:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E887822541B;
	Thu, 27 Feb 2025 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P02N0mbm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9299A22157B;
	Thu, 27 Feb 2025 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740644100; cv=none; b=ROG5AGcOmhFhatypE8Ssqrz033Y9NgkZ45kPzoxxCeGPeuZe/RUBAZi8dtXALvxVUd7mevBauAuXMKOs5P03NKp+GnFtQAh9KXA3QpDoqVGp4+a+f3NKQMkYcKj7hisM3i5dQqp8BcQ/5Xt4NRAJUFUpH4uwGWlMYWYB9FyYSfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740644100; c=relaxed/simple;
	bh=8e7exXZgzGTVByoLGTTX3FgBXNxQNlNPpA8s+LIlgI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qUK4FYWhKWyjdSsj4dlKvYWGpASuHSmoCOaYBVcFItSLQ6lhgvcaYkOfa20JbtdOl+k2BOZILbVAoTsMtGwxIw99YqEnab2JhqBuSgNvmOXpyzI/4a5n3LL2xTfARumIUtb3H5tlK7Vwv3hVuU8lAPoR56GxNWDNC3ANLGu1sno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P02N0mbm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B92C4AF0E;
	Thu, 27 Feb 2025 08:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740644100;
	bh=8e7exXZgzGTVByoLGTTX3FgBXNxQNlNPpA8s+LIlgI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P02N0mbmLJ2JqMSLZip2DwJkHv+gwmlQ7yPQaweLeGBQMKvMOFjYwi+EN42uq1dtj
	 +4ffrYmPj435MDjbzjmH/Z2mQWk3KZRYPxyDFXEFBbrlTAnzl3t266qY/NfdTVYEsX
	 oGRatc0Olt/9WgY6SMAD2FpRWJx5Nz/gRuab8p5yB/3T2lCFGhRF93Sf+KQAF5F/TH
	 qZpdrHR6rIDpByLuvhxivTcz212n2b1sgx/v+y/8vm/+GjzqNu5XwvEohGvUXNWSqt
	 SI3/qx+8EczC1k4dkna+dukVjb75jeX7Iaorfds2Mud3krLFbAiVzKOTqbmU8rUfB3
	 WxO75GXmDy9og==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1tnZ33-000000006mW-2koS;
	Thu, 27 Feb 2025 09:15:13 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org,
	Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH 3/8] arm64: dts: qcom: x1e001de-devkit: mark l12b and l15b always-on
Date: Thu, 27 Feb 2025 09:13:52 +0100
Message-ID: <20250227081357.25971-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250227081357.25971-1-johan+linaro@kernel.org>
References: <20250227081357.25971-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The l12b and l15b supplies are used by components that are not (fully)
described (and some never will be) and must never be disabled.

Mark the regulators as always-on to prevent them from being disabled,
for example, when consumers probe defer or suspend.

Fixes: 7b8a31e82b87 ("arm64: dts: qcom: Add X1E001DE Snapdragon Devkit for Windows")
Cc: stable@vger.kernel.org	# 6.14
Cc: Sibi Sankar <quic_sibis@quicinc.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/x1e001de-devkit.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
index 5e3970b26e2f..f92bda2d34f2 100644
--- a/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
+++ b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
@@ -507,6 +507,7 @@ vreg_l12b_1p2: ldo12 {
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
 		};
 
 		vreg_l13b_3p0: ldo13 {
@@ -528,6 +529,7 @@ vreg_l15b_1p8: ldo15 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
 		};
 
 		vreg_l16b_2p9: ldo16 {
-- 
2.45.3



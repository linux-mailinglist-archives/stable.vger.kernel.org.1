Return-Path: <stable+bounces-119813-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4151CA4776D
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 09:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77CCC3AEF40
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 08:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1022E225A23;
	Thu, 27 Feb 2025 08:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMazhgSU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CDB222577;
	Thu, 27 Feb 2025 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740644100; cv=none; b=WWbmVPQZOlLmgQYzBBgWbTJ5ie1uiHxyRHWuz4AUe8jt1LXfv2bQFXorZyhWdw4+YTgyBlhJZ1kUP2Xdcwan3uSJ0zFGqwG2W1SEHRxHlSkwHMTKgVQSfx9dWfz+MuEpw8BqHKCOBg4nGz43dM4YDUa7p2rVzmtXA0QJ+Hi0jjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740644100; c=relaxed/simple;
	bh=KqexUO++zWHuSeR207dXs3f7DtWzieO4ZJF6UByDO7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NpaACUHSVaOSxXKf4SElWTIWY0KPoWG4WRA+BfFKnfM12MVtTpVvUz2/JB5aYELjT1Tt42yW0oVk7a6wUFGJgBKQjG72jih7bSyDTXx14/fJHL9vvgMEl+FGAtcUFKAiG0L8RIN7S2rdyk3geS2zXIwVYKWSnCH/CvYKb6ONGFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMazhgSU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795A7C4CEF7;
	Thu, 27 Feb 2025 08:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740644100;
	bh=KqexUO++zWHuSeR207dXs3f7DtWzieO4ZJF6UByDO7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AMazhgSU/u4F8S72mqHRpTaImobl3/VVHANb1T/Ih1T/p2EEzogMj8He8V3AEN3zD
	 0bANhdO5d6GbOmNTh/l4WL3JS82uz+88ywfQY8x0B1VzDo0aePMS92SsLV6uhhu4xz
	 iWm6M8gTotLLYs7HMdqrtMZlCkQbPZ6A0Vsumb3/ufsosG3fWsQ0Cy7bMaeddcizee
	 8KBHDziiNdhmD9BN/D2yTQuIuc4L6K6eNeyf+8ho41LC1+0QgN1oFjuRtWIs5bZ6hn
	 1d7BUzAHytzQUxV1nXnqoY/KJBqE3JI7nHqESCBeAcAL7WBCi+zzHQIDcvlZ1h/3DV
	 Mq5swIe+QJQZQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1tnZ34-000000006mj-00vq;
	Thu, 27 Feb 2025 09:15:14 +0100
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
	Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: [PATCH 7/8] arm64: dts: qcom: x1e80100-qcp: mark l12b and l15b always-on
Date: Thu, 27 Feb 2025 09:13:56 +0100
Message-ID: <20250227081357.25971-8-johan+linaro@kernel.org>
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

Fixes: af16b00578a7 ("arm64: dts: qcom: Add base X1E80100 dtsi and the QCP dts")
Cc: stable@vger.kernel.org	# 6.8
Cc: Rajendra Nayak <quic_rjendra@quicinc.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
index ec594628304a..8f366bf61bbd 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
@@ -437,6 +437,7 @@ vreg_l12b_1p2: ldo12 {
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
 		};
 
 		vreg_l13b_3p0: ldo13 {
@@ -458,6 +459,7 @@ vreg_l15b_1p8: ldo15 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
 		};
 
 		vreg_l16b_2p9: ldo16 {
-- 
2.45.3



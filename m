Return-Path: <stable+bounces-119815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DEBA47777
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 09:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BE9216D54F
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 08:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48121226868;
	Thu, 27 Feb 2025 08:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbspQbqL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C34224B05;
	Thu, 27 Feb 2025 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740644100; cv=none; b=WIMgsoyWqKeq9U7FmlrtxI+bBkPKLbgHWz1vhsx5B5GXl/RMWuKrSvmlNDRaUvprMg54JZ7SJHnapYHyOaYYLxHewvfV/blIfxmcNrjatlz//sFZj4bvwvYJw0W8uCc6p8Snl0KAA+MXL3fEmnipJ/OnITtMBYWd9FenqP/Cr64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740644100; c=relaxed/simple;
	bh=JCo+sXKSHDz8HEVbOnF+KvLq0jr6fSndq2qiFxS5ixo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sFm7tNWtFNCwTiBU92x4jU7fyJfgMb7eIKycODcR31VedSNIz1GA8L4XYJNv1ZD9gNL5umcImrJdGzRn4DwIA002TzpMIVB1wgWuwwi1gqfFcXqsV+eQ5BlzHZ70yfdMnmKMSiHOpppZT/EHwz5ioSD113gD8MZaiTvy1h8ih+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbspQbqL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC5DC4AF19;
	Thu, 27 Feb 2025 08:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740644100;
	bh=JCo+sXKSHDz8HEVbOnF+KvLq0jr6fSndq2qiFxS5ixo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kbspQbqLimMo5R6dkMMojBO8RdDwnOwvMV6sklOFdEH7aZvS1AXmEQJ3HcR4tL9mU
	 vmcokEFKjhMiKeCjt8bn5km5SM9lrTP2KRHi0nrQ6iSPaSsk+grIYtP8scEz73UYVQ
	 tpkvVXk34Gs0/278bCBXYZs7/AjT9noVnp8G4Xj8v6u+pSLXTWBXlDD6GGQ8Qcq7aw
	 jHRdSFCXPx6VEBW43s9iNJZ5JcnlR6Bt1jqLbzNM2LU6LQCcgGnAjH8GeCUhNpZlJf
	 2c3MMoXxEMal4pCoIdgsxwMpXRP4PLr5kxpoe1JVXjzUHl4qVXV2GTd9VkV76hLaHX
	 s5CaAH1oBDW7A==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1tnZ33-000000006mg-3phw;
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
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 6/8] arm64: dts: qcom: x1e80100-yoga-slim7x: mark l12b and l15b always-on
Date: Thu, 27 Feb 2025 09:13:55 +0100
Message-ID: <20250227081357.25971-7-johan+linaro@kernel.org>
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

Fixes: 45247fe17db2 ("arm64: dts: qcom: x1e80100: add Lenovo Thinkpad Yoga slim 7x devicetree")
Cc: stable@vger.kernel.org	# 6.11
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
index a3d53f2ba2c3..9d4ba9728355 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
@@ -290,6 +290,7 @@ vreg_l12b_1p2: ldo12 {
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
 		};
 
 		vreg_l14b_3p0: ldo14 {
@@ -304,8 +305,8 @@ vreg_l15b_1p8: ldo15 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
 		};
-
 	};
 
 	regulators-1 {
-- 
2.45.3



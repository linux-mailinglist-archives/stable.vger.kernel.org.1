Return-Path: <stable+bounces-164529-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA0BB0FE72
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 03:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D087587408
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 01:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7E6139D1B;
	Thu, 24 Jul 2025 01:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPwWJLIc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281893207
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 01:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753321784; cv=none; b=MPgvDXiF6te7ZvrgrMl77bWxXTP5QQ0ZTFyIRMjEFZ0rNqC2BqIv6ulAw01UMreEKyGb3fv5vp2UmLck93i2oY331TV5E2TSw5LLUqMv763DSiq5mbHzNfQb7JBO5VCzhPThuDrq4mo2abnPOV0JaOvaLEtXn7jFywtHDEvNCiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753321784; c=relaxed/simple;
	bh=ha5kXzXGNAuZ6ivbBu+w83dsAGPI3lHIhZud0hNKHCE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IUFmFGiNJ5btgf+sz/WRZErTkI87dz2SCYxPl5qc0xnPvbWRw5VkrZrc3wLSZcyjijQ8qYw5Re+snKELL51ctztEYe70Ft9zOAW1kMfAzzlHQLhMuF8KiXfPRpex9LV9PWm6y1P/CWHG7FGQmJYbzVQEXxiWixwLJqv0JdmbupQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPwWJLIc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBAC1C4CEE7;
	Thu, 24 Jul 2025 01:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753321783;
	bh=ha5kXzXGNAuZ6ivbBu+w83dsAGPI3lHIhZud0hNKHCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aPwWJLIcqWwq3IiYlAthya4EbJyYlYK8vGRQb+8S3MwJllywv5ptLeoVe9bDYca18
	 4Y08uXlw8cC1b1Iphlq0is6PzveR+zbcgBG7qw2zLh+8AfIKTshR3unm5usTGu+CxE
	 pXiDAhiUbzVho/W5aXZVKseTiIomrNK0amVTAGFA+BGpdKdtpPTFgvdaBNSNlHSXtd
	 HmsF5kU7wxjfvt+8uX2uqMGS1868cW+5GbRb/6GOFNbcKiCcO2Sw1GnXjVJA3ZTfxc
	 oa9pE1KHwjis3bjEyIwIz8jRP9oQUE+/eshaGKS8hbU3hqidVKIpL3chp3CBz/4MKH
	 3+TupjNhJHebw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] arm64: dts: qcom: x1e78100-t14s: mark l12b and l15b always-on
Date: Wed, 23 Jul 2025 21:49:38 -0400
Message-Id: <20250724014938.1251643-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025060255-dislike-elaborate-1e0f@gregkh>
References: <2025060255-dislike-elaborate-1e0f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan+linaro@kernel.org>

[ Upstream commit 673fa129e558c5f1196adb27d97ac90ddfe4f19c ]

The l12b and l15b supplies are used by components that are not (fully)
described (and some never will be) and must never be disabled.

Mark the regulators as always-on to prevent them from being disabled,
for example, when consumers probe defer or suspend.

Fixes: 7d1cbe2f4985 ("arm64: dts: qcom: Add X1E78100 ThinkPad T14s Gen 6")
Cc: stable@vger.kernel.org	# 6.12
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20250314145440.11371-3-johan+linaro@kernel.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
[ applied changes to .dts file instead of .dtsi ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
index b1fa8f3558b3f..02ae736a2205d 100644
--- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
+++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
@@ -232,6 +232,7 @@ vreg_l12b_1p2: ldo12 {
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
 		};
 
 		vreg_l13b_3p0: ldo13 {
@@ -253,6 +254,7 @@ vreg_l15b_1p8: ldo15 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
 		};
 
 		vreg_l17b_2p5: ldo17 {
-- 
2.39.5



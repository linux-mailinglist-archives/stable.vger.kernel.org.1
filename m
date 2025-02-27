Return-Path: <stable+bounces-119811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB4EA4776C
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 09:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 145D4188EC72
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 08:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D07225760;
	Thu, 27 Feb 2025 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyXqFHvx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9293F2206BE;
	Thu, 27 Feb 2025 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740644100; cv=none; b=h77aT2ujxDEE8th3lFE61Nt1MIAhUtMk61R7TUhZB9oHzNNlTaGT0cTSj7o2xpjdecB0f7mLw++TZUTtq1fLpt+7LLke1MdLFs41tWoUkLgvnMbZtJfnyueagbNXM7mIHdgGE8/ipMs/QVfHLEjmaA32m/+GArA0naEi6EgDR6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740644100; c=relaxed/simple;
	bh=w+fxQNcEvc77dz9SybWo7UMq9e9nlth52edr2bW+Op4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S6xIrlvSEu9JApVjQICjsXTvnSX9lWGRkD+Hy/3BqBDuIxG5OGP1O6rF9wN0vn3K7QX8TKiNr2+RocF+mmAAyDguN/keHP0uM51488ri3HoIpq3lw5h0wt8qKR49ZIpjOROoBHbNw3+NDwRV39sfJq7yR3i3BX9twQ0InCIItQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyXqFHvx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE63C4CEE7;
	Thu, 27 Feb 2025 08:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740644100;
	bh=w+fxQNcEvc77dz9SybWo7UMq9e9nlth52edr2bW+Op4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GyXqFHvxwAES0HCr4fN3njdmx7bLlChjFPem1s4fYa7h7YJQKwssc/VwPrxqmmVYC
	 jVQ4YNMbWPeapbW02wt4AVUlI1Sv25r4UctAJdTj6yMHy6WM7ospSVH2s+07gEqX25
	 q2ZDgvb6Q9OHg1y2E2DM7N9ZLuSZ3i9azW2tSEuXDGBcbWZPvTszpcdJx/SxXH/GLT
	 ncLccRPYvpQm8I5y5Kdtbzl1cuLP4EydX7tzfwp6rjP/hBrA37E6h0RezGzIUAduSU
	 FVr8X188fe2yq/Vs3X/vNZ7dA55GqzZXFFQKahOXKHg2F+jFtOW2huE/GDp7L6eIAr
	 Nzb5E3s05AuRg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1tnZ33-000000006mZ-35PJ;
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
	Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Subject: [PATCH 4/8] arm64: dts: qcom: x1e80100-dell-xps13-9345: mark l12b and l15b always-on
Date: Thu, 27 Feb 2025 09:13:53 +0100
Message-ID: <20250227081357.25971-5-johan+linaro@kernel.org>
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

Note that these supplies currently have no consumers described in
mainline.

Fixes: f5b788d0e8cd ("arm64: dts: qcom: Add support for X1-based Dell XPS 13 9345")
Cc: stable@vger.kernel.org	# 6.13
Cc: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts b/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
index 86e87f03b0ec..90f588ed7d63 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
@@ -359,6 +359,7 @@ vreg_l12b_1p2: ldo12 {
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
 		};
 
 		vreg_l13b_3p0: ldo13 {
@@ -380,6 +381,7 @@ vreg_l15b_1p8: ldo15 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
 		};
 
 		vreg_l17b_2p5: ldo17 {
-- 
2.45.3



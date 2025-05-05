Return-Path: <stable+bounces-140702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3545AAAAC9
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D294B1889736
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707663991CC;
	Mon,  5 May 2025 23:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKwvCZ2I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3356037DBF8;
	Mon,  5 May 2025 23:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486003; cv=none; b=LBw+5GB8LO0OdhTAgt292hPiLpNQzST/GZZ7S2juga/oCFCgMe+PjWXP2PA0u6XZ7U2gEw2SMSW8jYz0EhltPLBjsJrFM9hbMteulTY8T+vi5ownGoHus3+tHW8f5aa4vSP19bf3C/IJhoUJT0IYZJUgVlMBPRinsIV+iwhePLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486003; c=relaxed/simple;
	bh=lNVuyu1hHYA+gw9a2IYrOKY7y1zFOLxI253RlG6F4Is=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ud48/dw/TYvAbD9CrgchnjPqcf0Rd+gBwhhcPXFDSTRKYB/kPHqcgRsmHOmZfdJ6ZTeL72OqRMMumLGCa7zEaK9ZQ0WOMSAYoJZjYw+YsHDQJ8grqQbWxjsTqT402r4we5J9eDJbWLCRFFn4UxoUCD/Sx1MqgZLyGy+xh7bFax0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKwvCZ2I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B650C4CEEE;
	Mon,  5 May 2025 23:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486002;
	bh=lNVuyu1hHYA+gw9a2IYrOKY7y1zFOLxI253RlG6F4Is=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EKwvCZ2IExumgHE090Kn9yThNoyHwCQ3xyNmEv98mUzTzuaO+2Br3f9JHrxmIhQeh
	 bgDEBpnimiWLBD88zoeO453WHe2/hHKNE1gWzKNNXmyhHe8PNGBr++qkr9sGjTCTbN
	 EjkpBC5VPxH09/HGfGhpKGmE9IEP9ejfvjYC1RFo2Uytl1bc7CXJOpXdgzK4xaZZV1
	 pd7WS2CV3YGSZIjjxpEYAk4iq4u4LeA26nzOxulIHORlRSowCygD6jROiRx4d2olCX
	 lvsxUvcYdCk+nS1shQ6KzGuXyPs9DicAcN/kjQOvN81rI6GgPry0UgcUGr98ui275T
	 I7mxOxuflj+QQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	thierry.reding@gmail.com,
	jonathanh@nvidia.com,
	tmn505@gmail.com,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 104/294] arm64: tegra: p2597: Fix gpio for vdd-1v8-dis regulator
Date: Mon,  5 May 2025 18:53:24 -0400
Message-Id: <20250505225634.2688578-104-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>

[ Upstream commit f34621f31e3be81456c903287f7e4c0609829e29 ]

According to the board schematics the enable pin of this regulator is
connected to gpio line #9 of the first instance of the TCA9539
GPIO expander, so adjust it.

Signed-off-by: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
Link: https://lore.kernel.org/r/20250224-diogo-gpio_exp-v1-1-80fb84ac48c6@tecnico.ulisboa.pt
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
index b4a1108c2dd74..0639f5ce1bd9e 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
@@ -1635,7 +1635,7 @@ vdd_1v8_dis: regulator-vdd-1v8-dis {
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
 		regulator-always-on;
-		gpio = <&exp1 14 GPIO_ACTIVE_HIGH>;
+		gpio = <&exp1 9 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 		vin-supply = <&vdd_1v8>;
 	};
-- 
2.39.5



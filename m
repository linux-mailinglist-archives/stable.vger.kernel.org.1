Return-Path: <stable+bounces-201640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65285CC25B7
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3A159302C70F
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 11:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBE234D4C0;
	Tue, 16 Dec 2025 11:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PvgK7XgC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD95D34D3B8;
	Tue, 16 Dec 2025 11:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765885305; cv=none; b=qHA3F4nDvXBVDA+i6M/RpEFbiyKvyRsT8to1cq8veGaqe4OaTAPq+khNOUwFwuO12mMO2bBEVd1evRagbaN6ggWW1AO7I7NtVgqVOQ7zwnK2sXqe3LZxcWwND4XSphF3dtEVL5uQrJwynRX60Ts5wy2Ss0isuLEPlouXwmaDpd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765885305; c=relaxed/simple;
	bh=UQSx2RLzo/BMvMGicWMS08D7S1LMfnNH4EYpfAnBwwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dBkaQ45+w5JC3bLY7aBTR3nu5xsmJ5gw1V6t6bkvpkLjpgP8Yjc2oh8v+0j2rehhDAxqxzO2hqrVpBvJ6nnV35HKdNsNP/JpGyYoicfXm4X/lMPVf2EY7Rp+57E0VRglpt9p1tOKyg+jWOiddHCuApeKliqaJ8onZfbYqk0/Hdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PvgK7XgC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C29C4CEF1;
	Tue, 16 Dec 2025 11:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765885305;
	bh=UQSx2RLzo/BMvMGicWMS08D7S1LMfnNH4EYpfAnBwwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PvgK7XgCM5EVadx76/YiwSEpYgTcGXim7JvVwHl6pHGg7/u2dRBhxuFX9X1Vk8zsf
	 16W8FRgGLVPei/NSvDGDpKFqUtUVI8SAiJOBMrlEEKDwxmHXC1ZRE+z1146MM1BwUc
	 /S1zBJRPfvzqdQB+KQS3h4am35QkP6vNPb7DKHhc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Griffin <peter.griffin@linaro.org>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 066/507] arm64: dts: exynos: gs101: fix sysreg_apm reg property
Date: Tue, 16 Dec 2025 12:08:27 +0100
Message-ID: <20251216111347.935123947@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111345.522190956@linuxfoundation.org>
References: <20251216111345.522190956@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Griffin <peter.griffin@linaro.org>

[ Upstream commit 4348c22a4f15dbef1314f1a353d7f053b24e9ace ]

Both the start address and size are incorrect for the apm_sysreg DT
node. Update to match the TRM (rather than how it was defined
downstream).

Fixes: ea89fdf24fd9 ("arm64: dts: exynos: google: Add initial Google gs101 SoC support")
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Reviewed-by: André Draszik <andre.draszik@linaro.org>
Link: https://patch.msgid.link/20251013-automatic-clocks-v1-5-72851ee00300@linaro.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index c0f8c25861a9d..668de6b2b9def 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -1401,9 +1401,9 @@ cmu_apm: clock-controller@17400000 {
 			clock-names = "oscclk";
 		};
 
-		sysreg_apm: syscon@174204e0 {
+		sysreg_apm: syscon@17420000 {
 			compatible = "google,gs101-apm-sysreg", "syscon";
-			reg = <0x174204e0 0x1000>;
+			reg = <0x17420000 0x10000>;
 		};
 
 		pmu_system_controller: system-controller@17460000 {
-- 
2.51.0





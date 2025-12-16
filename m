Return-Path: <stable+bounces-201236-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3728BCC228F
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A30B304FEB8
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 11:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCCA2459D7;
	Tue, 16 Dec 2025 11:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h2jX2jKC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED47A3358A8;
	Tue, 16 Dec 2025 11:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765883979; cv=none; b=JmqnJzT2X49M1ivZFWG84CCCiZA6yJGoyRCH13PB+jWLUk8QgQ4+kTDIkhn661OOJwakBnVBaH32jU9KrKq0UnX0bU4PRwg9jUX4h7AtRoy0OXAH1VSfa6Fgpsv0X6aiPi2/Jrz7WGvWOIFypKeJatRVwZPI2B3DvZaIrhyrS6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765883979; c=relaxed/simple;
	bh=fDQ/pU1dSh0CXqtWww+Qvn4tvPQJlKvd+M9bi8cQkpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CaUG28axs95EZazRnAI2ibgNVK7o/LiW3Gh+Bx8XP/I/2tE2hyAphLNFiuOpG5n2LRsccyWNc9MWmizDtfvCXkHnXx8Fz3Eziq0vtjACKfE8honj19civ3cfwNc9TH+1orVLbVPIjfGtxCTg2RRsUn/FBJkRuA15pgsRi82REyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h2jX2jKC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD82C4CEF1;
	Tue, 16 Dec 2025 11:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765883978;
	bh=fDQ/pU1dSh0CXqtWww+Qvn4tvPQJlKvd+M9bi8cQkpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h2jX2jKCY/RMl5Em+bcHA07SJY3QF5ZyiEu8Oc/d31G5MYpPyzqkAa2Hd9XsQBqSl
	 OXeOe7PyMeUS/S0x7Rmoaiun5QForbT7/EiG5GXUVUzgk11zlH8ieKFiHG2UlyEQh4
	 MA99B07yQVVoTuq32xk8T/rWjyIUZmmIKntzpwYE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Griffin <peter.griffin@linaro.org>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 055/354] arm64: dts: exynos: gs101: fix sysreg_apm reg property
Date: Tue, 16 Dec 2025 12:10:22 +0100
Message-ID: <20251216111322.911770314@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111320.896758933@linuxfoundation.org>
References: <20251216111320.896758933@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

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
index a509a59def428..d03987cc4370c 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -1390,9 +1390,9 @@ cmu_apm: clock-controller@17400000 {
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





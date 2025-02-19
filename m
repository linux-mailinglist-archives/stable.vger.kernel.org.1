Return-Path: <stable+bounces-117805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45040A3B84B
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07408189B741
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD081DE4D2;
	Wed, 19 Feb 2025 09:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ou0ShF1k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0BF1BEF77;
	Wed, 19 Feb 2025 09:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739956391; cv=none; b=aB3k3J0yqgB8FSnCfUmt0D7OVijdH7HCf8NfPPB9ebxRu043iq5sOvvzghe5PufCfqoTC1gmU3Jsnal/B20k01RBUIkf8TJ72j6mqys09zWqvkUF1BL456BNlyR4vhdjVEqWUOXHAK79/l4en3EHN8+URNdWxkSpA28QFYv6CCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739956391; c=relaxed/simple;
	bh=a3vXUz9op5r581uWknflMkGN2Hq6zMd3WLe8TnRMFgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=twc6PxWKJoBg15gs3C+MUD21O6J3bf9fsatYcNw92Z+IZ22IRwzjEu4ICuAk7Hxj0eOSHQhgqlmTL+O+i66DxzCu1uFyrpr6LFm5uqVDSMTErKk0M+vltxKQ4R8jPVtwLaRTcASFXcJRqapGst22SSPDWx0D7a0tp4y84zm1lJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ou0ShF1k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44398C4CED1;
	Wed, 19 Feb 2025 09:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739956391;
	bh=a3vXUz9op5r581uWknflMkGN2Hq6zMd3WLe8TnRMFgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ou0ShF1knPjz73Jcza8TMFxmu5Tukdd+97aFQTa8N0PCASLvGMhRnIfQI6lLvo7tU
	 6TwOm37fbm7DnCN6Duv2iGR5BpcgAnQdTkbBB6fOWYc2xWuh8hWHbe74OPtenlCz3U
	 jWrzezH+LddY6ZmbB6EpLC/6RxqRuHfe+5jHAzI8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 163/578] arm64: dts: qcom: sm8450: correct sleep clock frequency
Date: Wed, 19 Feb 2025 09:22:47 +0100
Message-ID: <20250219082659.381907988@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082652.891560343@linuxfoundation.org>
References: <20250219082652.891560343@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit c375ff3b887abf376607d4769c1114c5e3b6ea72 ]

The SM8450 platform uses PMK8350 to provide sleep clock. According to the
documentation, that clock has 32.7645 kHz frequency. Correct the sleep
clock definition.

Fixes: 5188049c9b36 ("arm64: dts: qcom: Add base SM8450 DTSI")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20241224-fix-board-clocks-v3-15-e9b08fbeadd3@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index aa0977af9411a..46f2e67ce6236 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -33,7 +33,7 @@
 		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
-			clock-frequency = <32000>;
+			clock-frequency = <32764>;
 		};
 	};
 
-- 
2.39.5





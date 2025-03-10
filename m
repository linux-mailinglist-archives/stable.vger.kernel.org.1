Return-Path: <stable+bounces-122595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 519C1A5A05F
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F139B1889B47
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7836722D7A6;
	Mon, 10 Mar 2025 17:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H3t5i5bD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364AB22DFF3;
	Mon, 10 Mar 2025 17:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741628945; cv=none; b=buNpuHTCjOoXaS87n7u5PWzgEOJXSVxF1MNoVXrRElSPU5yDZQ5sn/PXD4+nZ1bQqLpenJ9K8n4JvyJSESnYTCLPcywrENx3jCIvMOnFtm9jXWiyzWoHm2Wkrsvbo8sjvcO9y9dlpc/B0dw9g8d+y43gplla2AHyg7K5sn50NcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741628945; c=relaxed/simple;
	bh=TEGzRw8DtqOM5n+sXBfiX4Jvr0OhWo+jKRuX4HNmPyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kqM/9D2ItO6ljQiQQJJesPNYx8qaYal3xMm/9OuKfHpxxA4hyKHckeXw8Ezay+p16Od1UJYF8gf4//OZLFdzunJaC0N8eYmb+6idndqTlE7aALcdTaLo4mUJa4F6AWCLZgqugKfzsDcy2FHWhKpeF+bRy6PmUwNGIVQiz9UOBgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H3t5i5bD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE04CC4CEE5;
	Mon, 10 Mar 2025 17:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741628945;
	bh=TEGzRw8DtqOM5n+sXBfiX4Jvr0OhWo+jKRuX4HNmPyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H3t5i5bDuMJeIJ0ILb9oxQCsa46H5rnu6/M5qF73kIydlPBUrsJVKncixCs0R/MRv
	 5zdGggsA4lypbsdsMfPMZZhPJefGdKH+0hfl6NS+DPVNoxWkP0TGXJuY8vZmXY/ti+
	 lOsDLmVHyRI1rsG2lp96q6MMhmgggclPaFwge8Nc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 124/620] arm64: dts: qcom: sm8350: correct sleep clock frequency
Date: Mon, 10 Mar 2025 17:59:30 +0100
Message-ID: <20250310170550.495166868@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170545.553361750@linuxfoundation.org>
References: <20250310170545.553361750@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit f4cc8c75cfc5d06084a31da2ff67e477565f0cae ]

The SM8350 platform uses PMK8350 to provide sleep clock. According to the
documentation, that clock has 32.7645 kHz frequency. Correct the sleep
clock definition.

Fixes: b7e8f433a673 ("arm64: dts: qcom: Add basic devicetree support for SM8350 SoC")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20241224-fix-board-clocks-v3-14-e9b08fbeadd3@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 8506dc841c869..f873c9b50db2c 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -32,7 +32,7 @@
 
 		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
-			clock-frequency = <32000>;
+			clock-frequency = <32764>;
 			#clock-cells = <0>;
 		};
 
-- 
2.39.5





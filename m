Return-Path: <stable+bounces-13897-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6E5837EAE
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6976B23A72
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9EF6FB3;
	Tue, 23 Jan 2024 00:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vzx/d/cy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C14F4BAA4;
	Tue, 23 Jan 2024 00:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970698; cv=none; b=da3/n5qpI/ZgVzbLiDCG5aW+E3HytJ1x8BvDlktcJzPq6E8dfAUe7RH3LTwI2vSjrXbMTDOl4qtx07KOg8WXvaOnIFjgSwQG0286lhC3Pz2NWmZDlkDcnIRy0OQhOQiJH5iYMs9FJ2ust1N/wMiam4+ZGoXKzvIRaAoXb+ode8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970698; c=relaxed/simple;
	bh=Iq16Xh9kUMMM678SEWYpuFGsR70AqLcq3yxJI2hHMu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k3w2nQLzn6IeGHWkDMPmu3iMrTWdvyg3r5yJW0RQ8aoWr8WmJ//Cj/83Ybukt/rTuQt/74txDWUc037gmDDTCqv13vRt2z6QF476pZPn4EnLc+WGzgUU0Ske026bz1eHRQ4sRVQeG+doOsF7LoGgwLqdx0lTzDG5IqizFVx3xyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vzx/d/cy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89EDCC43390;
	Tue, 23 Jan 2024 00:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705970696;
	bh=Iq16Xh9kUMMM678SEWYpuFGsR70AqLcq3yxJI2hHMu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vzx/d/cy9QKuxLX9bEamggxSUKji+xa13EirETIDMFZfhwQQoLha5p1/4427LSnZU
	 cj7ZURlpaXRwhCczrMM2fQB3msk9B+LtanRw95nMsEdkTd2kNvOCJGri4BIi0/U4b3
	 rtUb6cUebAGtTVmUOXZ0Mb40KCbHlUdodIir9x44=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guenter Roeck <linux@roeck-us.net>,
	Stephen Boyd <swboyd@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 088/417] arm64: dts: qcom: sdm845: Make watchdog bark interrupt edge triggered
Date: Mon, 22 Jan 2024 15:54:16 -0800
Message-ID: <20240122235754.748283740@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235751.480367507@linuxfoundation.org>
References: <20240122235751.480367507@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit 263b348499454f38d36b9442c3cf9279c571bb54 ]

As described in the patch ("arm64: dts: qcom: sc7180: Make watchdog
bark interrupt edge triggered"), the Qualcomm watchdog timer's bark
interrupt should be configured as edge triggered. Make the change.

Fixes: 36c436b03c58 ("arm64: dts: qcom: sdm845: Add watchdog bark interrupt")
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Link: https://lore.kernel.org/r/20231106144335.v2.3.I16675ebe5517c68453a1bd7f4334ff885f806c03@changeid
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 52c9f5639f8a..1e6841902900 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -5019,7 +5019,7 @@ watchdog@17980000 {
 			compatible = "qcom,apss-wdt-sdm845", "qcom,kpss-wdt";
 			reg = <0 0x17980000 0 0x1000>;
 			clocks = <&sleep_clk>;
-			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_EDGE_RISING>;
 		};
 
 		apss_shared: mailbox@17990000 {
-- 
2.43.0





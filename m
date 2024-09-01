Return-Path: <stable+bounces-71890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D23A8967836
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F6601C20D4F
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EAA183CAF;
	Sun,  1 Sep 2024 16:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zb9Gd3IX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DA644C97;
	Sun,  1 Sep 2024 16:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725208154; cv=none; b=NZ8uIHPF6DPO3XJAGa1jnXS2d3w6YLzL33fOHprf0q6LS1qZFRKVVAFU+0huN9vi7TsrAukJt4ToqLz/NWl1JhJmXy/cvvGYuwktWYvzVFfl0A9b10suPso93scKzoZoXSIf9JCJpbcOcn4K5mbeotoTMc79/q1UGtJ0bkHgFZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725208154; c=relaxed/simple;
	bh=/iEEeBRmaPaPsgIYN0VXZVo5IH6/1FOP1+XuQ0RVt0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R0NUEF14cld4+7h7jkyAgBEJUjIyq1ovkKTPNKdl2YVd5fPDdrNfobvgbCxg/bLP2TVbfVrkDfeMJXxxntRSz7fvevQl/jspVradTcDJS40ZbEWFcW1OMEaGpuT7zo9SlSve9ywNHw1SavHugbge2rK7FWcPxrKfPJ5F2hQZxrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zb9Gd3IX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C441C4CEC3;
	Sun,  1 Sep 2024 16:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725208154;
	bh=/iEEeBRmaPaPsgIYN0VXZVo5IH6/1FOP1+XuQ0RVt0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zb9Gd3IX3i3kD1ddu+Elu5j7kDCF20UDzf93w+8kmWsFEVs0WieTsHelqxTWHOpcv
	 M1RGzy0e2aYRdI90c/63mnw4P6fBN07/WlMlaK6u7CkAVuWNysA6OQ5hmeaNAzMw9l
	 /ZkAYhWfJt1FsEkXu2tTvezkitsxrUo2lPD5QUl4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 89/93] arm64: dts: imx93: update default value for snps,clk-csr
Date: Sun,  1 Sep 2024 18:17:16 +0200
Message-ID: <20240901160811.083243728@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160807.346406833@linuxfoundation.org>
References: <20240901160807.346406833@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shenwei Wang <shenwei.wang@nxp.com>

[ Upstream commit 109f256285dd6a5f8c3bd0d80d39b2ccd4fe314e ]

For the i.MX93 SoC, the default clock rate for the IP of STMMAC EQOS is
312.5 MHz. According to the following mapping table from the i.MX93
reference manual, this clock rate corresponds to a CSR value of 6.

 0000: CSR clock = 60-100 MHz; MDC clock = CSR clock/42
 0001: CSR clock = 100-150 MHz; MDC clock = CSR clock/62
 0010: CSR clock = 20-35 MHz; MDC clock = CSR clock/16
 0011: CSR clock = 35-60 MHz; MDC clock = CSR clock/26
 0100: CSR clock = 150-250 MHz; MDC clock = CSR clock/102
 0101: CSR clock = 250-300 MHz; MDC clock = CSR clock/124
 0110: CSR clock = 300-500 MHz; MDC clock = CSR clock/204
 0111: CSR clock = 500-800 MHz; MDC clock = CSR clock/324

Fixes: f2d03ba997cb ("arm64: dts: imx93: reorder device nodes")
Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 8ca5c7b6fbf03..35155b009dd24 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -809,7 +809,7 @@
 							 <&clk IMX93_CLK_SYS_PLL_PFD0_DIV2>;
 				assigned-clock-rates = <100000000>, <250000000>;
 				intf_mode = <&wakeupmix_gpr 0x28>;
-				snps,clk-csr = <0>;
+				snps,clk-csr = <6>;
 				nvmem-cells = <&eth_mac2>;
 				nvmem-cell-names = "mac-address";
 				status = "disabled";
-- 
2.43.0





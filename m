Return-Path: <stable+bounces-164187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B13B0DE19
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 16:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A670188DE18
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 14:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08A92EF2A2;
	Tue, 22 Jul 2025 14:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x1EH8uwF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B15A2EF2AB;
	Tue, 22 Jul 2025 14:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193533; cv=none; b=tN7JTAPnYBnAvR+rsRC8SY9kW5Afa0HnR3U9PcgFidDsU7c5MdIp7fUo+mtFfHgFfXcCvnjqONHgeSuGFGrYKJjZWbymerCZxYvPfObb72sudT0TWLKaPgrW9vR/GM3Tz49bh+xmPoIcHiCd6Db5O5rwJvE7spoDd3DUv5AKGc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193533; c=relaxed/simple;
	bh=T8htSP4ij5ViPvNTr/tKvPr5uQhvnN0P8qkaB9T0v0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3b8dmyF9YEmFwpfCaD+YfsiKzi635Rj97hPb4tDiV9bTAgQmpyoM6H+yZWUPabssgrt0XkxeaIrzc7BaJvch8eKJVbFIFrpAAbbUE9YAj9jUP6/5Sga6QP+LmbrYHSjr0oDSCHdSXYvE9OdoUcRQdlnvTfyCELvI7X8vFDac3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x1EH8uwF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD28FC4CEEB;
	Tue, 22 Jul 2025 14:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753193533;
	bh=T8htSP4ij5ViPvNTr/tKvPr5uQhvnN0P8qkaB9T0v0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=x1EH8uwFPTZNiIHBDQR7+uqFknGr/OOsavWmsOUSc9gZnLi7Ln0/rn8zyMDXrjgl4
	 kA345Zu41o3ze6rmiRmmkNwWLhHtASrmq23ps61cSN/a6ps8Em/sbZbyQJSGqtXOLR
	 7tb091yPx2ECDyp3mGqm6Mxctobnqnc0Xge0bRKI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Peng Fan <peng.fan@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 104/187] arm64: dts: imx95: Correct the DMA interrupter number of pcie0_ep
Date: Tue, 22 Jul 2025 15:44:34 +0200
Message-ID: <20250722134349.640493594@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722134345.761035548@linuxfoundation.org>
References: <20250722134345.761035548@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Zhu <hongxing.zhu@nxp.com>

[ Upstream commit 61f1065272ea3721c20c4c0a6877d346b0e237c3 ]

Correct the DMA interrupter number of pcie0_ep from 317 to 311.

Fixes: 3b1d5deb29ff ("arm64: dts: imx95: add pcie[0,1] and pcie-ep[0,1] support")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 59f057ba6fa7f..7ad9adfb26533 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1678,7 +1678,7 @@
 			      <0x9 0 1 0>;
 			reg-names = "dbi","atu", "dbi2", "app", "dma", "addr_space";
 			num-lanes = <1>;
-			interrupts = <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "dma";
 			clocks = <&scmi_clk IMX95_CLK_HSIO>,
 				 <&scmi_clk IMX95_CLK_HSIOPLL>,
-- 
2.39.5





Return-Path: <stable+bounces-184464-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F56BD4519
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 17:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13838422A16
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F107C3090D7;
	Mon, 13 Oct 2025 14:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CyUKzTY6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86333090CC;
	Mon, 13 Oct 2025 14:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367511; cv=none; b=D+knd1w5Bb7Pd/KHAZmUW/Yuab25rgxG9PyPj7kvsNAhUUai2NIqpxAM6cZqTP+xec3gVeefKRYo7c7yg/UdbEAQ/O243X/Casn1Pxjdo8idTdyBhGSoCMt6tb11InksQti1I9O9zUTQVntE2Ewr6ppQloJabUzwYzV4Y/Nyc/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367511; c=relaxed/simple;
	bh=VC4cNFj/BvMiMQy3lxUh4kQnN5K9KB0Tq7Ag584OQ1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aquzSFt2Zaa3HkEO4pYPNze7QCwENCGJ2tgzp1vpanHkq8zfrpnuv5jzc3tfx0HxqPheG2yN4q7N0VPXQkIBUx/y2FSPLTCPooTapNYcKo3yQfrxpcw++O8g94l8BVVSmMhhB2Li+e+440mbfLoigo4dGB4nugABC41fB4V6ehI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CyUKzTY6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3299CC4CEFE;
	Mon, 13 Oct 2025 14:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760367511;
	bh=VC4cNFj/BvMiMQy3lxUh4kQnN5K9KB0Tq7Ag584OQ1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CyUKzTY6jxcJq3uYisKCxDEphPvDfwCytOrgKL38BwFfbgGvrcnLKMCD+nTKa/jBT
	 nBObl1W9M3Nokj6HdtKwdhK62VjdeRMiHPhYdFLZCV4y0NEnYBge9vw1TlzoK+7Tky
	 cWX1quO0O1SBn2Xmx3ApJYEmj6VifAllUrH8bt/Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guoqing Jiang <guoqing.jiang@canonical.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 038/196] arm64: dts: mediatek: mt8195: Remove suspend-breaking reset from pcie0
Date: Mon, 13 Oct 2025 16:43:49 +0200
Message-ID: <20251013144316.580391438@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144315.184275491@linuxfoundation.org>
References: <20251013144315.184275491@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Guoqing Jiang <guoqing.jiang@canonical.com>

[ Upstream commit 3374b5fb26b300809ecd6aed9f414987dd17c313 ]

When test suspend resume with 6.8 based kernel, system can't resume
and I got below error which can be also reproduced with 6.16 rc6+
kernel.

mtk-pcie-gen3 112f0000.pcie: PCIe link down, current LTSSM state: detect.quiet (0x0)
mtk-pcie-gen3 112f0000.pcie: PM: dpm_run_callback(): genpd_resume_noirq returns -110
mtk-pcie-gen3 112f0000.pcie: PM: failed to resume noirq: error -110

After investigation, looks pcie0 has the same problem as pcie1 as
decribed in commit 3d7fdd8e38aa ("arm64: dts: mediatek: mt8195:
Remove suspend-breaking reset from pcie1").

Fixes: ecc0af6a3fe6 ("arm64: dts: mt8195: Add pcie and pcie phy nodes")
Signed-off-by: Guoqing Jiang <guoqing.jiang@canonical.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Macpaul Lin <macpaul.lin@mediatek.com>
Link: https://lore.kernel.org/r/20250721095959.57703-1-guoqing.jiang@canonical.com
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 22604d3abde3b..4b701afe995e2 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -1524,9 +1524,6 @@ pcie0: pcie@112f0000 {
 
 			power-domains = <&spm MT8195_POWER_DOMAIN_PCIE_MAC_P0>;
 
-			resets = <&infracfg_ao MT8195_INFRA_RST2_PCIE_P0_SWRST>;
-			reset-names = "mac";
-
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0 0 0 1 &pcie_intc0 0>,
-- 
2.51.0





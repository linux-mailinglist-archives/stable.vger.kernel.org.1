Return-Path: <stable+bounces-57250-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 004AA925BE5
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A858B290147
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0753194A77;
	Wed,  3 Jul 2024 10:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GZG2PDkr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F65B191F82;
	Wed,  3 Jul 2024 10:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720004312; cv=none; b=nCk4znUxxnSwKO1i2t9zzEcaQlWGbNLs8NhYUzXp44+0FhHDAVZVq/WA6/EINzBWx90dOVL5y3eeSQlzcOBXwTGehBu7HfXB+zS/OD3nUUVV4SssF5s25vOorLjbQ21hBihX1/O7H4W9p1f1bAWXnMBbDJ+F5lAlfwLN8cwjMoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720004312; c=relaxed/simple;
	bh=IFdK4f6wcZDCIuo03u1E9Fpy4pi/13m3X8+Ixshm15s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CbmmdpPJxzZnTqj+AEbfd6S7oWyO8YHQu8PYshiPtoGf2qCKDuCyg8j2HNz6KHdPp4rDabBKab0tcUJ6mKOCaEYfzQ0zmt5Ob+1xVoyMjwPGJmHN0iMopPLwrsanVKAtck4xB4fzwTMMr828cWWpSRlWWEWPmhxrl1kn4iyxzm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GZG2PDkr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB16C2BD10;
	Wed,  3 Jul 2024 10:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720004312;
	bh=IFdK4f6wcZDCIuo03u1E9Fpy4pi/13m3X8+Ixshm15s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GZG2PDkrb1o9iRDGSunFd8NWaXliLihgCQhb3No4XVHaOnAa0PD2sEzP3qMRgpFJD
	 Z9bLJXW1cr+YQFvqfEjcYakJYCAxOZAd36QvehCQQT1fzJuvkG1J70C4W+8xpXBphe
	 AkDDp0f1MoKHHR5dEi6aRXuO92/ePx/P+VfKFzkw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alex Bee <knaerzche@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 189/189] arm64: dts: rockchip: Add sound-dai-cells for RK3368
Date: Wed,  3 Jul 2024 12:40:50 +0200
Message-ID: <20240703102848.606421867@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102841.492044697@linuxfoundation.org>
References: <20240703102841.492044697@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Bee <knaerzche@gmail.com>

[ Upstream commit 8d7ec44aa5d1eb94a30319074762a1740440cdc8 ]

Add the missing #sound-dai-cells for RK3368's I2S and S/PDIF controllers.

Fixes: f7d89dfe1e31 ("arm64: dts: rockchip: add i2s nodes support for RK3368 SoCs")
Fixes: 0328d68ea76d ("arm64: dts: rockchip: add rk3368 spdif node")
Signed-off-by: Alex Bee <knaerzche@gmail.com>
Link: https://lore.kernel.org/r/20240623090116.670607-4-knaerzche@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index fd86188010b29..45f40cfaca4fa 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -686,6 +686,7 @@
 		dma-names = "tx";
 		pinctrl-names = "default";
 		pinctrl-0 = <&spdif_tx>;
+		#sound-dai-cells = <0>;
 		status = "disabled";
 	};
 
@@ -697,6 +698,7 @@
 		clocks = <&cru SCLK_I2S_2CH>, <&cru HCLK_I2S_2CH>;
 		dmas = <&dmac_bus 6>, <&dmac_bus 7>;
 		dma-names = "tx", "rx";
+		#sound-dai-cells = <0>;
 		status = "disabled";
 	};
 
@@ -710,6 +712,7 @@
 		dma-names = "tx", "rx";
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s_8ch_bus>;
+		#sound-dai-cells = <0>;
 		status = "disabled";
 	};
 
-- 
2.43.0





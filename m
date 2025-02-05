Return-Path: <stable+bounces-113003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACE6A28F7A
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14CEE1881CF2
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E25C14B959;
	Wed,  5 Feb 2025 14:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dXaMpOgc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293D214B080;
	Wed,  5 Feb 2025 14:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738765494; cv=none; b=OLQb8WHeApUDFJgnps4rBR4Jq5udpVUWCavCyNU+YWhSY/dkLGPzHR1iGxi0yxs4lopDrDclPnkzrwbiH0Ydt/wjr3zUgON6FYLShAFJnqizQr0Am3dR1y8nBrCrSFnWA/hVFR5dbE8vigAN4DiIv3IkXFf3nq9S9t4igOzbIEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738765494; c=relaxed/simple;
	bh=wpiuAH4y89GQq36jqc39oqi608EYdZQQ7KsWdHPrrlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGLzTr06oUE7YCwqW5BCa3zwMP94fzF9K+jy7kBc0JJgX8SI9wml0JuNTnuOiezF7nmbjF15AZX302fnX1lKJqpIQohawKmgBWcVcrnOf/Xm6hXXqQeg9zUVcQwTbuf8BEDABmckqTSn/y8pKcY716y9FWZDB3IEL4zXg8Jcl38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dXaMpOgc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A328C4CED1;
	Wed,  5 Feb 2025 14:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738765494;
	bh=wpiuAH4y89GQq36jqc39oqi608EYdZQQ7KsWdHPrrlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dXaMpOgcdaybMPOWoNaeFZrtzbl/zLJv2mxoSMv7NVlhoZB7/zoE9s5QUd5qBKIqX
	 TEAqI/07eGLC+WeOTMIB2MS6Jn7rUJhOYNXISj82MPoegyQVC1NDPGWiHvCMNwkdhw
	 VZyuN1eZFwUJqa3og1sARcPh3FWgEJx1NiZZrQdw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Akhil R <akhilrajeev@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 272/393] arm64: tegra: Fix DMA ID for SPI2
Date: Wed,  5 Feb 2025 14:43:11 +0100
Message-ID: <20250205134430.718524178@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134420.279368572@linuxfoundation.org>
References: <20250205134420.279368572@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Akhil R <akhilrajeev@nvidia.com>

[ Upstream commit 346bf459db26325c09ed841fdfd6678de1b1cb3a ]

DMA ID for SPI2 is '16'. Update the incorrect value in the devicetree.

Fixes: bb9667d8187b ("arm64: tegra: Add SPI device tree nodes for Tegra234")
Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Link: https://lore.kernel.org/r/20241206105201.53596-1-akhilrajeev@nvidia.com
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index ac69eacf8a6ba..be30072fb7471 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -1794,7 +1794,7 @@
 			assigned-clock-parents = <&bpmp TEGRA234_CLK_PLLP_OUT0>;
 			resets = <&bpmp TEGRA234_RESET_SPI2>;
 			reset-names = "spi";
-			dmas = <&gpcdma 19>, <&gpcdma 19>;
+			dmas = <&gpcdma 16>, <&gpcdma 16>;
 			dma-names = "rx", "tx";
 			dma-coherent;
 			status = "disabled";
-- 
2.39.5





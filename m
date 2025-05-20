Return-Path: <stable+bounces-145331-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4D7ABDAFD
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 16:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7133B7A6464
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 14:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947FFEEDE;
	Tue, 20 May 2025 14:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NOy+kxsc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E0E2F37;
	Tue, 20 May 2025 14:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747749864; cv=none; b=eQY2LYmccpf6PjvbZqVVYix1ex6D6FfO7y6Cy1gzMYBHdW+zrtb4e6kqsC3Bk2Cfdv5ZAvHXSaXV9Wpfc/9YocvYkypjHLDL9wJsaYs/P83hhBfbVvrcXbpjXfCUp47mzvR4yhc1zke/IFw5K/TCsZQxHNNIJAhbHcovEUiyJxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747749864; c=relaxed/simple;
	bh=4pML+GInZwV1W22sl4nWjH8979wokNU7qPWCb0rgVxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rs3Lgeqdo7UA/MGlXirqnrZiRo+T5sua3Gieqn6mApLFEnBAbKQ/+n4xl0bla1TeDSzTHUcJZu6Yc4BslHKO0rc/Z2D7JFTMwj1KAghzxzW1fBEovWUPtizxSVoqmeuD3Y4XuqxeGjXFHrJ2Ja67FzpP1uzmm4X6rZqDVxt3qY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NOy+kxsc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC2EC4CEEA;
	Tue, 20 May 2025 14:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747749863;
	bh=4pML+GInZwV1W22sl4nWjH8979wokNU7qPWCb0rgVxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NOy+kxscIBxRNaVlctwCJJYNz7+I6fL5JpXOGwuFpFvLt+q/uqOMeEHSavHMBeQ99
	 R0+1+1fu6ZRTGdaLGpjw9lpUhNRPXTVVCVnUPDi2GN4r5K6pma8sNy1rrUC0RBx9mb
	 p7ucjPnHPRSWtrIy9NiXrUXw4FaYQPWB4g1kan88=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bo-Cun Chen <bc-bocun.chen@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 053/117] net: ethernet: mtk_eth_soc: fix typo for declaration MT7988 ESW capability
Date: Tue, 20 May 2025 15:50:18 +0200
Message-ID: <20250520125806.098172903@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520125803.981048184@linuxfoundation.org>
References: <20250520125803.981048184@linuxfoundation.org>
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

From: Bo-Cun Chen <bc-bocun.chen@mediatek.com>

[ Upstream commit 1bdea6fad6fb985ff13828373c48e337c4e939f9 ]

Since MTK_ESW_BIT is a bit number rather than a bitmap, it causes
MTK_HAS_CAPS to produce incorrect results. This leads to the ETH
driver not declaring MAC capabilities correctly for the MT7988 ESW.

Fixes: 445eb6448ed3 ("net: ethernet: mtk_eth_soc: add basic support for MT7988 SoC")
Signed-off-by: Bo-Cun Chen <bc-bocun.chen@mediatek.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Link: https://patch.msgid.link/b8b37f409d1280fad9c4d32521e6207f63cd3213.1747110258.git.daniel@makrotopia.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index c6ccfbd422657..cb8efc952dfda 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -4628,7 +4628,7 @@ static int mtk_add_mac(struct mtk_eth *eth, struct device_node *np)
 	}
 
 	if (mtk_is_netsys_v3_or_greater(mac->hw) &&
-	    MTK_HAS_CAPS(mac->hw->soc->caps, MTK_ESW_BIT) &&
+	    MTK_HAS_CAPS(mac->hw->soc->caps, MTK_ESW) &&
 	    id == MTK_GMAC1_ID) {
 		mac->phylink_config.mac_capabilities = MAC_ASYM_PAUSE |
 						       MAC_SYM_PAUSE |
-- 
2.39.5





Return-Path: <stable+bounces-153523-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EB5ADD4E6
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 329891942D68
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A4C2EA15E;
	Tue, 17 Jun 2025 16:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fLsEbl3A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CB62EA153;
	Tue, 17 Jun 2025 16:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176239; cv=none; b=WDlA+aaEx8bLmXoQ3RjPyE6jK/9O1CfOAdt3YyseXCWaA9pl1qXwBHIHKxbDkWXL5rVf2PDwk2WBealZgvU/USK69GU+cKyXw/DQwIx2ezIvIYdeF6bp2guxooAZAbQc1rLpg1MhehNOmuLYlC3tBLSYnlpp6jEyl3N8Qa3tm6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176239; c=relaxed/simple;
	bh=OtKSSFWWLKchrSjvwi9W1ggxwiS3bDvhXvYP5Aaer2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kjqzM8hyB8PXeYCQf2y9yivFtfB+vf+T/5ltIdcHwTT1vAdO9QQdD5YoI6ppoqM43H/lZjB7qZWVVTt7RvHjAHn2ywObAMOV1ACnGgpWuHN4IQkAJSD8E4T08KEPOxOKuanctqryqN/msRPhtRWvSExpq9/kvkcBlhuWnC+l44E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fLsEbl3A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8501BC4CEE3;
	Tue, 17 Jun 2025 16:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750176239;
	bh=OtKSSFWWLKchrSjvwi9W1ggxwiS3bDvhXvYP5Aaer2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fLsEbl3AFeANCWqufDTrF58d0mEt52abtl1flmN4dDTVO0z8XAb9O/7UcDZNUxQ6a
	 Uaq5A6zDtrOKX1og+CY/HmjzalGp1BSHqlicf2QExayVjBDsl7zCwCYKXnwi973qnc
	 gTL/O82MmPNou7l6q+JzJvQxayurDglMz5tU39pE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yanqing Wang <ot_yanqing.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Biao Huang <biao.huang@mediatek.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 246/356] driver: net: ethernet: mtk_star_emac: fix suspend/resume issue
Date: Tue, 17 Jun 2025 17:26:01 +0200
Message-ID: <20250617152348.110023845@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152338.212798615@linuxfoundation.org>
References: <20250617152338.212798615@linuxfoundation.org>
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

From: Yanqing Wang <ot_yanqing.wang@mediatek.com>

[ Upstream commit ba99c627aac85bc746fb4a6e2d79edb3ad100326 ]

Identify the cause of the suspend/resume hang: netif_carrier_off()
is called during link state changes and becomes stuck while
executing linkwatch_work().

To resolve this issue, call netif_device_detach() during the Ethernet
suspend process to temporarily detach the network device from the
kernel and prevent the suspend/resume hang.

Fixes: 8c7bd5a454ff ("net: ethernet: mtk-star-emac: new driver")
Signed-off-by: Yanqing Wang <ot_yanqing.wang@mediatek.com>
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Signed-off-by: Biao Huang <biao.huang@mediatek.com>
Link: https://patch.msgid.link/20250528075351.593068-1-macpaul.lin@mediatek.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mediatek/mtk_star_emac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/mediatek/mtk_star_emac.c b/drivers/net/ethernet/mediatek/mtk_star_emac.c
index c2ab87828d858..5eb7a97e7eb17 100644
--- a/drivers/net/ethernet/mediatek/mtk_star_emac.c
+++ b/drivers/net/ethernet/mediatek/mtk_star_emac.c
@@ -1468,6 +1468,8 @@ static __maybe_unused int mtk_star_suspend(struct device *dev)
 	if (netif_running(ndev))
 		mtk_star_disable(ndev);
 
+	netif_device_detach(ndev);
+
 	clk_bulk_disable_unprepare(MTK_STAR_NCLKS, priv->clks);
 
 	return 0;
@@ -1492,6 +1494,8 @@ static __maybe_unused int mtk_star_resume(struct device *dev)
 			clk_bulk_disable_unprepare(MTK_STAR_NCLKS, priv->clks);
 	}
 
+	netif_device_attach(ndev);
+
 	return ret;
 }
 
-- 
2.39.5





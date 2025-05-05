Return-Path: <stable+bounces-139790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DABFAA9FA5
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B7B81A82563
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF8E2857F0;
	Mon,  5 May 2025 22:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0i+0pGl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AF02853FC;
	Mon,  5 May 2025 22:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483342; cv=none; b=Tx1IM48+ZP1Ywl3/LeP9ZBYyBfspId6sRCRXLzdm00jjb+qR/0NTj+jvNoBZdsEzLhRRFkEOgZCFfGk8matFFdM8UraIO+shFnITuQEJ6juYG4D37JkhWSznO8jrIC/+aDoEmc+hMBKADf2+3KX4+l+8x8iaJgaiI3yZ1zMrcVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483342; c=relaxed/simple;
	bh=46rfAidHetS8cBL29WXOKNNYtOLFJa/GrAJQc/Fxh7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EzQE9vPjwoiHOslF7O8S0pMl/o6O17wVLWLJqCBuxzFMqW4m+PY9fQEEHfR+H3KfnS8+taFaeLi/0PZaTxq4Vw8OqEdde5f27/grYXaqTF5kducNkezwgQTbWhI9ovWoGuBD+K79LeiMVAkDpsPnqhqkkBTvqmDxlp5B0WM4Hm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0i+0pGl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B574C4CEE4;
	Mon,  5 May 2025 22:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483341;
	bh=46rfAidHetS8cBL29WXOKNNYtOLFJa/GrAJQc/Fxh7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G0i+0pGloDIEGN49GFcOTBHbIJoYk8lTCwO4fH0iXZ0+lp7RXpJrEWc3kcmqhYfpD
	 h/XI9BtStxjvLHmTWcXZy25b8FIDqhMxQImQVBTa8r/Wzpq0i5wbK8dlwBBwXOur3b
	 soLOdA9M0tqHr+9lSrWe9pXXqceo9mEvHHscWxoMY8jzwcPTKhlNJEKUW0ZlGceRXt
	 LGB/eGGftNIxassEbdc8rmRoyMLur87gRzJpwxOcF3MVvidFogxFH5oOeFgBF/IAaj
	 iubY81ha5Oo9CceUBbxTJX68mkL2XGsZmtqqrkYrVmWZrWZBQGCO5rbSQPZlRIkTcx
	 Z11OqKMaC2fyQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sean Wang <sean.wang@mediatek.com>,
	Pedro Tsai <pedro.tsai@mediatek.com>,
	Felix Freimann <felix.freimann@mediatek.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-bluetooth@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 043/642] Bluetooth: btmtksdio: Prevent enabling interrupts after IRQ handler removal
Date: Mon,  5 May 2025 18:04:19 -0400
Message-Id: <20250505221419.2672473-43-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

[ Upstream commit 6ac4233afb9a389a7629b7f812395d1d1eca5a83 ]

Ensure interrupts are not re-enabled when the IRQ handler has already been
removed. This prevents unexpected IRQ handler execution due to stale or
unhandled interrupts.

Modify btmtksdio_txrx_work to check if bdev->func->irq_handler exists
before calling sdio_writel to enable interrupts.

Co-developed-by: Pedro Tsai <pedro.tsai@mediatek.com>
Signed-off-by: Pedro Tsai <pedro.tsai@mediatek.com>
Co-developed-by: Felix Freimann <felix.freimann@mediatek.com>
Signed-off-by: Felix Freimann <felix.freimann@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btmtksdio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index bd5464bde174f..edd5eead1e93b 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -610,7 +610,8 @@ static void btmtksdio_txrx_work(struct work_struct *work)
 	} while (int_status || time_is_before_jiffies(txrx_timeout));
 
 	/* Enable interrupt */
-	sdio_writel(bdev->func, C_INT_EN_SET, MTK_REG_CHLPCR, NULL);
+	if (bdev->func->irq_handler)
+		sdio_writel(bdev->func, C_INT_EN_SET, MTK_REG_CHLPCR, NULL);
 
 	sdio_release_host(bdev->func);
 
-- 
2.39.5



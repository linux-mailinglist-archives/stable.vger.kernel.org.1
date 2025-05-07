Return-Path: <stable+bounces-142681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B30ACAAEBBB
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 21:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E69717AF818
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 19:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0FA28DF1F;
	Wed,  7 May 2025 19:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AMuRh+Cp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EEB2144C1;
	Wed,  7 May 2025 19:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746644999; cv=none; b=tRnSMHmJmSyqLuMlrDnsPj9kspu9bpaRUQjUDGdcp5LIavxTG/r7vZEosXdQPBbP9DbGl3nR7wQVtErxHqwLtJLUyxyahtvZnGAJkNA4leRJmpHWMRFAxCPNWZRmWAyHyuV7S+isIpq1BZQEE1NSFztPJa9cStu0ez605eqsa3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746644999; c=relaxed/simple;
	bh=wUPv3BolUqjvavnT7urm5v3KxyrhldDo3RozOGFG+b8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mpRBxtDtj+r+qNVS/MRDEM7UE6JJS79hyXy5EnUj7/YWnTB02Hi7iCPwPtyqS6J9xd5AUyuEPVPUO3wmusXdmFDnruxIbEguicSoO4bYKbUIN+fY7x//8b2EoiAzIPEx2DtvYv7+gG3RkW7icjhpJnq5xUO1xP/3Ru4J6UorGUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AMuRh+Cp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868B2C4CEE2;
	Wed,  7 May 2025 19:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746644999;
	bh=wUPv3BolUqjvavnT7urm5v3KxyrhldDo3RozOGFG+b8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AMuRh+Cpsx+tXQpSLWmAWBEQywVZcEExwcNRsdt58Gx4sIJijbEY5cf7FoxAyTGTY
	 XjoC63Y3DGeGdRp8OBM8PcU7QpmK9I7Fb568dwweKhwZlaWdhibjmqK7q4mFkLZz0c
	 UxtieRC9FCnmgKfSjPYdBDy2R9/yiDcu2yus9nN4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 062/129] net: ethernet: mtk-star-emac: rearm interrupts in rx_poll only when advised
Date: Wed,  7 May 2025 20:39:58 +0200
Message-ID: <20250507183816.038527910@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507183813.500572371@linuxfoundation.org>
References: <20250507183813.500572371@linuxfoundation.org>
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

From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

[ Upstream commit e54b4db35e201a9173da9cb7abc8377e12abaf87 ]

In mtk_star_rx_poll function, on event processing completion, the
mtk_star_emac driver calls napi_complete_done but ignores its return
code and enable RX DMA interrupts inconditionally. This return code
gives the info if a device should avoid rearming its interrupts or not,
so fix this behaviour by taking it into account.

Fixes: 8c7bd5a454ff ("net: ethernet: mtk-star-emac: new driver")
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Link: https://patch.msgid.link/20250424-mtk_star_emac-fix-spinlock-recursion-issue-v2-2-f3fde2e529d8@collabora.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mediatek/mtk_star_emac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_star_emac.c b/drivers/net/ethernet/mediatek/mtk_star_emac.c
index 47a00e02365a2..c2ab87828d858 100644
--- a/drivers/net/ethernet/mediatek/mtk_star_emac.c
+++ b/drivers/net/ethernet/mediatek/mtk_star_emac.c
@@ -1348,8 +1348,7 @@ static int mtk_star_rx_poll(struct napi_struct *napi, int budget)
 	priv = container_of(napi, struct mtk_star_priv, rx_napi);
 
 	work_done = mtk_star_rx(priv, budget);
-	if (work_done < budget) {
-		napi_complete_done(napi, work_done);
+	if (work_done < budget && napi_complete_done(napi, work_done)) {
 		spin_lock_irqsave(&priv->lock, flags);
 		mtk_star_enable_dma_irq(priv, true, false);
 		spin_unlock_irqrestore(&priv->lock, flags);
-- 
2.39.5





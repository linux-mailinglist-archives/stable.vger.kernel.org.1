Return-Path: <stable+bounces-36725-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BA489C15E
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F11BA282A74
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44B37BAE7;
	Mon,  8 Apr 2024 13:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xHXC8Sqo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DA67442A;
	Mon,  8 Apr 2024 13:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582162; cv=none; b=PMFPPu9y/SzoDNbPha81UUhjcBvQ1/5L+VWX/w2EbUUVcsXkMIZYsgmRGt5lFNpZ8T/nugjNERaoSVu0GJ5pr2BqVLfr7EVrN4dGTOqgy7qLszAI9EwE/mdM3WtjEIm/AnDaHtzqEBq8zyUfNy8EPB20uo2YyZc2jSmNqok9G5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582162; c=relaxed/simple;
	bh=+Nd7S7+R5g+YsIHBVMvQWrUcO4CCyuzIIkmIEijwh3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TI8JHoBa6GIGgg8qe52JfWM2cHKphksM9SLxKvu5OIfcL5yvvMtZopEq0/BjR4xRyRozmCzESWa+QXZKzFAyPjGoroO/6Kx1woOtWVGgMVQ9v+8nFGLfmJGz6QDXIGmLSi/fkXthXNtWXjIcRVD5YRHVrk8ISEg6p0NZBDyk/Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xHXC8Sqo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C83C43390;
	Mon,  8 Apr 2024 13:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712582162;
	bh=+Nd7S7+R5g+YsIHBVMvQWrUcO4CCyuzIIkmIEijwh3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xHXC8SqoulwEGKQCfxBGyaOmEpHrYXKCc3rd8fr84Ldqz9KudPw+PFjD+glHFISIx
	 c62bQuiLYGqQPpgj9NVV0Umyt4tQb0ftPPIwgMQRW4vjwzcy2BseHERrm2Ym3EbcwI
	 yxXLI6R5qcNY6M1kOMBVVNTffZeplNqg2CmlkkPw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paul Barker <paul.barker.ct@bp.renesas.com>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 083/138] net: ravb: Always process TX descriptor ring
Date: Mon,  8 Apr 2024 14:58:17 +0200
Message-ID: <20240408125258.806943510@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125256.218368873@linuxfoundation.org>
References: <20240408125256.218368873@linuxfoundation.org>
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

From: Paul Barker <paul.barker.ct@bp.renesas.com>

[ Upstream commit 596a4254915f94c927217fe09c33a6828f33fb25 ]

The TX queue should be serviced each time the poll function is called,
even if the full RX work budget has been consumed. This prevents
starvation of the TX queue when RX bandwidth usage is high.

Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Link: https://lore.kernel.org/r/20240402145305.82148-1-paul.barker.ct@bp.renesas.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/renesas/ravb_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 36e2718c564ac..b11cc365d19e3 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1294,12 +1294,12 @@ static int ravb_poll(struct napi_struct *napi, int budget)
 	int q = napi - priv->napi;
 	int mask = BIT(q);
 	int quota = budget;
+	bool unmask;
 
 	/* Processing RX Descriptor Ring */
 	/* Clear RX interrupt */
 	ravb_write(ndev, ~(mask | RIS0_RESERVED), RIS0);
-	if (ravb_rx(ndev, &quota, q))
-		goto out;
+	unmask = !ravb_rx(ndev, &quota, q);
 
 	/* Processing TX Descriptor Ring */
 	spin_lock_irqsave(&priv->lock, flags);
@@ -1309,6 +1309,9 @@ static int ravb_poll(struct napi_struct *napi, int budget)
 	netif_wake_subqueue(ndev, q);
 	spin_unlock_irqrestore(&priv->lock, flags);
 
+	if (!unmask)
+		goto out;
+
 	napi_complete(napi);
 
 	/* Re-enable RX/TX interrupts */
-- 
2.43.0





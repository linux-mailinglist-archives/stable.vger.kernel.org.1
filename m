Return-Path: <stable+bounces-38957-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED998A1137
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DED7C287FB4
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CD5146A72;
	Thu, 11 Apr 2024 10:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0oID2f79"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307BC143C76;
	Thu, 11 Apr 2024 10:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712832095; cv=none; b=GXcvdUAbTbJb4VRtLa/08nYr7twflwPgEFXd+DoUdOT6R2xmnq822/I+LTI8xMdc3e6IkHG8pWfNr+Rpkhp4XCXJwbMF+dqRLhSn9mz17jPuFc9TUJWTtHKs6nE9Ql4+YlsySQ7guHGmW7qB1jJrIUKpfWt2ow/BGAz8Mjfc/Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712832095; c=relaxed/simple;
	bh=/IitXE55ZDk1hRv9yBRTTxw7QQBBbXvcr9cuyvFukcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rzmk3d3cIPv76ZyeDT2o4DawHQBXqP+WXKMxcCYB8zYGiFgOi4VaPccevMGdS4jaLeL6HFgQTuXN7afdE/ccDfgsLsBgojSANYf8S6FqhQA9YVEY6/cyXsw6a8VLDxe9PVQt6KKFJgUCLAogSgKRFqRqiamQwD9CNh+m52QLd04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0oID2f79; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC803C433C7;
	Thu, 11 Apr 2024 10:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712832095;
	bh=/IitXE55ZDk1hRv9yBRTTxw7QQBBbXvcr9cuyvFukcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0oID2f79U+sWtoJ5ySTkbsVAeCJwgAedgfrAigliDRoE75P+VD1HLshfXP18UOEOv
	 W+X9pFDyZI0+gn6e//PRvqtsDmX5JmOPGh0yugSZDt6Ytjyktscdfh6fO3Cv20ZPM0
	 UEL99KJ6GQ1Jixon5go043+pGP7XCgtnQXwKLbhg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paul Barker <paul.barker.ct@bp.renesas.com>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 225/294] net: ravb: Always process TX descriptor ring
Date: Thu, 11 Apr 2024 11:56:28 +0200
Message-ID: <20240411095442.363750645@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095435.633465671@linuxfoundation.org>
References: <20240411095435.633465671@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index 8a4dff0566f7d..b08478aabc6e6 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -911,12 +911,12 @@ static int ravb_poll(struct napi_struct *napi, int budget)
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
 
 	/* Processing RX Descriptor Ring */
 	spin_lock_irqsave(&priv->lock, flags);
@@ -926,6 +926,9 @@ static int ravb_poll(struct napi_struct *napi, int budget)
 	netif_wake_subqueue(ndev, q);
 	spin_unlock_irqrestore(&priv->lock, flags);
 
+	if (!unmask)
+		goto out;
+
 	napi_complete(napi);
 
 	/* Re-enable RX/TX interrupts */
-- 
2.43.0





Return-Path: <stable+bounces-44974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D738C5595
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A581282D92
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E901F4594C;
	Tue, 14 May 2024 11:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r4B0XlYS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58732B9AD;
	Tue, 14 May 2024 11:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715687716; cv=none; b=mtLUC7afoqIapMOR+BGmIYhVAzPdhXgn3bic88oUfy1hz5yGkipJwrqlR92xpg9ziJlAtAIQ7KCO6hvtIL05U6wLFXSa6YrpTFi17Nk4YOBRcDVGR+nIqpiZ8F4sgCVrxheaqmLnX6lwhIBBuVGd1IlKO6iqKadaP7ZA/HRmZME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715687716; c=relaxed/simple;
	bh=xvOvpOdDpsdLPgfXd9oxOODId01mAYqWWmTLfx8Gui4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fFfuIlWZOfo0pio9RzT+phnD9PvbX+nQXw7UrS11eOqUVx3G07UdxrTigkwyigk3p58g78ISL7NMipqaK0Wf2rcChKFMDgriA2Ny9iqr/eEw9RdKcsTfIZTkVAeRcGpOjUwNnJHjFROInb53DevLBy0qCoL4eFTh9k7f2xY0XFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r4B0XlYS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B740C32781;
	Tue, 14 May 2024 11:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715687716;
	bh=xvOvpOdDpsdLPgfXd9oxOODId01mAYqWWmTLfx8Gui4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r4B0XlYS5AwGFEJ5KYuuz2fnBv/OXNvICz+Q41TYAijwYTk43QJo/tWCPv2ZIloj1
	 p+f5sp9C8PSK0dUx0LJY2wS5M7Y2iUkM+2XVjvpKb/uC1KMi1oExsI9vdYJm+BrxJo
	 oi9udGWe2qnhQ7MpPfFexKbH8NR/HWcPQc0LTs7o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 049/168] cxgb4: Properly lock TX queue for the selftest.
Date: Tue, 14 May 2024 12:19:07 +0200
Message-ID: <20240514101008.542561453@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101006.678521560@linuxfoundation.org>
References: <20240514101006.678521560@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 9067eccdd7849dd120d5495dbd5a686fa6ed2c1a ]

The selftest for the driver sends a dummy packet and checks if the
packet will be received properly as it should be. The regular TX path
and the selftest can use the same network queue so locking is required
and was missing in the selftest path. This was addressed in the commit
cited below.
Unfortunately locking the TX queue requires BH to be disabled which is
not the case in selftest path which is invoked in process context.
Lockdep should be complaining about this.

Use __netif_tx_lock_bh() for TX queue locking.

Fixes: c650e04898072 ("cxgb4: Fix race between loopback and normal Tx path")
Reported-by: "John B. Wyatt IV" <jwyatt@redhat.com>
Closes: https://lore.kernel.org/all/Zic0ot5aGgR-V4Ks@thinkpad2021/
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/r/20240429091147.YWAaal4v@linutronix.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/chelsio/cxgb4/sge.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/sge.c b/drivers/net/ethernet/chelsio/cxgb4/sge.c
index fa5b596ff23a1..a074e9d44277f 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/sge.c
@@ -2682,12 +2682,12 @@ int cxgb4_selftest_lb_pkt(struct net_device *netdev)
 	lb->loopback = 1;
 
 	q = &adap->sge.ethtxq[pi->first_qset];
-	__netif_tx_lock(q->txq, smp_processor_id());
+	__netif_tx_lock_bh(q->txq);
 
 	reclaim_completed_tx(adap, &q->q, -1, true);
 	credits = txq_avail(&q->q) - ndesc;
 	if (unlikely(credits < 0)) {
-		__netif_tx_unlock(q->txq);
+		__netif_tx_unlock_bh(q->txq);
 		return -ENOMEM;
 	}
 
@@ -2722,7 +2722,7 @@ int cxgb4_selftest_lb_pkt(struct net_device *netdev)
 	init_completion(&lb->completion);
 	txq_advance(&q->q, ndesc);
 	cxgb4_ring_tx_db(adap, &q->q, ndesc);
-	__netif_tx_unlock(q->txq);
+	__netif_tx_unlock_bh(q->txq);
 
 	/* wait for the pkt to return */
 	ret = wait_for_completion_timeout(&lb->completion, 10 * HZ);
-- 
2.43.0





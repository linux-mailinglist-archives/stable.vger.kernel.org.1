Return-Path: <stable+bounces-43827-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 720D38C4FCD
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 12:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A397F1C208B4
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 10:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7865E12FB3E;
	Tue, 14 May 2024 10:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cQ3PfQNL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3654155C3B;
	Tue, 14 May 2024 10:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715682496; cv=none; b=BfuK2nQXSEzkQWSj8jppYjsE7n410ygW2iqcyyNz/A703tgI6QIkJbp7IwtZabPmDnhaLQ2zhnKySoUI0D94CW1YCuikPHEnVacxqN70zOisKnXuOWg2z5v1C9GXssviDhCT3t+2aFsU3NJhUE1SdiHStTgwNn4V4gShUIyIm1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715682496; c=relaxed/simple;
	bh=K7e2srPiwuF4HM+jUVqtHzznBFarNnTxrRGsEv8BRYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ntbl8G86uSg6ObR798DPJEAG4cMtEd4t7iEsmISUzB5DCFjMja4Q7Ifwpna7OL4oFkMhghfPAsZAhQXHRiZUOkW51OrbuCCSyyd+5ZaFlM9/g5oGdE/l4hVUrLr7Pygk/89XW0ZXFaptmO6PK3F8LH+zDVWF2p44oNWqY1ae0Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cQ3PfQNL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56183C2BD10;
	Tue, 14 May 2024 10:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715682496;
	bh=K7e2srPiwuF4HM+jUVqtHzznBFarNnTxrRGsEv8BRYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cQ3PfQNLxqNYF+7xueAYZ0aPcqsF+TkmxY48HTsHO1MEZdYAuq723r5uSDJpTmUSy
	 iYRNjVOGYrMgHdj/lDUrRMmJLG2iZ9f5yo2xiDGspP7x4L2nQQkHgPChEUpJNp8SjM
	 72f+3RGr1q9r5RthcesMlPB1TchHROH+h8JKi0aQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 070/336] cxgb4: Properly lock TX queue for the selftest.
Date: Tue, 14 May 2024 12:14:34 +0200
Message-ID: <20240514101041.248355716@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101038.595152603@linuxfoundation.org>
References: <20240514101038.595152603@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

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
index b5ff2e1a9975f..2285f2e87e689 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/sge.c
@@ -2684,12 +2684,12 @@ int cxgb4_selftest_lb_pkt(struct net_device *netdev)
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
 
@@ -2724,7 +2724,7 @@ int cxgb4_selftest_lb_pkt(struct net_device *netdev)
 	init_completion(&lb->completion);
 	txq_advance(&q->q, ndesc);
 	cxgb4_ring_tx_db(adap, &q->q, ndesc);
-	__netif_tx_unlock(q->txq);
+	__netif_tx_unlock_bh(q->txq);
 
 	/* wait for the pkt to return */
 	ret = wait_for_completion_timeout(&lb->completion, 10 * HZ);
-- 
2.43.0





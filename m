Return-Path: <stable+bounces-98503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C51219E422D
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 18:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C45D5165B63
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B59207662;
	Wed,  4 Dec 2024 17:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yhtljgzq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CB920765A;
	Wed,  4 Dec 2024 17:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332359; cv=none; b=XWaSTq+vSwPiGM84RmfmepMEI9NSIhx4YWB1zLUhExufWEEeYnmdlBSaJNJbgTseVcgnWHkXamrC54/t81hDx3h5mF8IUpY97Z7eJeyn3nRKOrTUpKFnyoamvBSIOCZbMr17qRp1+ce03hss7gBP04J75ydqrPIartEgCGf0kVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332359; c=relaxed/simple;
	bh=+X9biTYdLqrN3HM1KDhzN5t9z9vfwvlhW1FN3fQOejA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HnoD8QJ0wPayxqTdw2OWzTp8y108FOi1Q0AHRQiZTy1THRKnGIwlY5TtvpfmXqQpVj4xn7Csyns0akVchnwuKJV9kz33nvcA7BNaG6yIYmrt3AwHOdSDywOfqCNH0aApdsuNJYhARB1DMhoMiSzosU5I3/2tTex5LAX8IYKVAek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yhtljgzq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881DBC4CECD;
	Wed,  4 Dec 2024 17:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733332359;
	bh=+X9biTYdLqrN3HM1KDhzN5t9z9vfwvlhW1FN3fQOejA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YhtljgzqIshQE6XxTq1lbxxK3TMOJaSXTaFkm6/f2swWdQkOXOkCKbSBuM3tMA9/L
	 TzJ7ZrAJEXCedkKe5QLTolKXZ1TblD6GdC1hyLg6o8GerI2raKHd/60hKJ8UaLD5+4
	 C7gB+QjTgZ1HgJqP4xfdF8KXkPLg9EjtgRNqXg2Qy/4Gf2zttmqTIAz/WfOLCkRnnK
	 QwO/qVNoszhYBPTRPShemZ03j4xPB2zxzqgg7/lVpjSXAqI6v/KScD9WT5ic6aCVd9
	 Jxn4hL1XlH7vs/DUoKPKb+W+6ttEB2P2ViHRfhsMmKClctVq3rzJAAXVt7++I9EZg/
	 cxtiDWaTxPIFw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-i3c@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 03/12] i3c: mipi-i3c-hci: Mask ring interrupts before ring stop request
Date: Wed,  4 Dec 2024 11:01:00 -0500
Message-ID: <20241204160115.2216718-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204160115.2216718-1-sashal@kernel.org>
References: <20241204160115.2216718-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
Content-Transfer-Encoding: 8bit

From: Jarkko Nikula <jarkko.nikula@linux.intel.com>

[ Upstream commit 6ca2738174e4ee44edb2ab2d86ce74f015a0cc32 ]

Bus cleanup path in DMA mode may trigger a RING_OP_STAT interrupt when
the ring is being stopped. Depending on timing between ring stop request
completion, interrupt handler removal and code execution this may lead
to a NULL pointer dereference in hci_dma_irq_handler() if it gets to run
after the io_data pointer is set to NULL in hci_dma_cleanup().

Prevent this my masking the ring interrupts before ring stop request.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Link: https://lore.kernel.org/r/20240920144432.62370-2-jarkko.nikula@linux.intel.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i3c/master/mipi-i3c-hci/dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/dma.c b/drivers/i3c/master/mipi-i3c-hci/dma.c
index edc3a69bfe31f..bcc0c7d4131f2 100644
--- a/drivers/i3c/master/mipi-i3c-hci/dma.c
+++ b/drivers/i3c/master/mipi-i3c-hci/dma.c
@@ -174,10 +174,10 @@ static void hci_dma_cleanup(struct i3c_hci *hci)
 	for (i = 0; i < rings->total; i++) {
 		rh = &rings->headers[i];
 
+		rh_reg_write(INTR_SIGNAL_ENABLE, 0);
 		rh_reg_write(RING_CONTROL, 0);
 		rh_reg_write(CR_SETUP, 0);
 		rh_reg_write(IBI_SETUP, 0);
-		rh_reg_write(INTR_SIGNAL_ENABLE, 0);
 
 		if (rh->xfer)
 			dma_free_coherent(&hci->master.dev,
-- 
2.43.0



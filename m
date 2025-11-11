Return-Path: <stable+bounces-194111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC8CC4AE11
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 02:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 72CDA4F7CAF
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F0F274FE3;
	Tue, 11 Nov 2025 01:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fTfIy0+y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D091C28E;
	Tue, 11 Nov 2025 01:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762824832; cv=none; b=PufsAu47JGgTM+5mo8hcsBUlA40/M/n89Dv6Ns+RJGF4Tw0w1HMhWkp4EzcxgJxh/VRxe3A/HnczFnXapB3JCgjucv2Dz6knvZge4rUaBgdZyC9ls9gu2wuzN4tKdBj8MFz0mK2ny3xGuMpfgJvIIIgu60YPk+T6d9DtqLwhwvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762824832; c=relaxed/simple;
	bh=ATjGa/j/QR5bPYzljkVS0CIj8BB951KRIpYadsoNY2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=snVSlvKyqIbUP5flNj4NRqbh7AoMgZwloRuRlF0qKgcmyEJL9sAW7jKdY0DkMvdlJOMxDqs8k4I2XPNAqzV68HCd+1TICIFjTwvN3/ISEuyph8YMQtwYEiyckJyFPMsvYwR9ARRw6vy/ySkKfxOx24rki79djo5SbV7HsWixWnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fTfIy0+y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558B2C4CEFB;
	Tue, 11 Nov 2025 01:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762824832;
	bh=ATjGa/j/QR5bPYzljkVS0CIj8BB951KRIpYadsoNY2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fTfIy0+ypi1/ILTvJ9a0rP1/lrtAXXeNgcDDkydZRJEBEpqX4I96sSyyQrwNgnLbH
	 rE8yJXz9LJBQZEo7AeyERltZMqXXHgHGs+7JLePPCZEcIM7Omjeht7+M2HevdkC1jo
	 fNvds1OblbsX8fIoCkg/sM+tbXH37+FRhMVQ+qdI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mohammad Heib <mheib@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 526/565] net: ionic: add dma_wmb() before ringing TX doorbell
Date: Tue, 11 Nov 2025 09:46:22 +0900
Message-ID: <20251111004538.799392068@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004526.816196597@linuxfoundation.org>
References: <20251111004526.816196597@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mohammad Heib <mheib@redhat.com>

[ Upstream commit d261f5b09c28850dc63ca1d3018596f829f402d5 ]

The TX path currently writes descriptors and then immediately writes to
the MMIO doorbell register to notify the NIC.  On weakly ordered
architectures, descriptor writes may still be pending in CPU or DMA
write buffers when the doorbell is issued, leading to the device
fetching stale or incomplete descriptors.

Add a dma_wmb() in ionic_txq_post() to ensure all descriptor writes are
visible to the device before the doorbell MMIO write.

Fixes: 0f3154e6bcb3 ("ionic: Add Tx and Rx handling")
Signed-off-by: Mohammad Heib <mheib@redhat.com>
Link: https://patch.msgid.link/20251031155203.203031-1-mheib@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 0f5758c273c22..3a094d3ea6f4f 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -29,6 +29,10 @@ static void ionic_tx_clean(struct ionic_queue *q,
 
 static inline void ionic_txq_post(struct ionic_queue *q, bool ring_dbell)
 {
+	/* Ensure TX descriptor writes reach memory before NIC reads them.
+	 * Prevents device from fetching stale descriptors.
+	 */
+	dma_wmb();
 	ionic_q_post(q, ring_dbell);
 }
 
-- 
2.51.0





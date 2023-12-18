Return-Path: <stable+bounces-7305-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D928171F2
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69E3B284A05
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC494238F;
	Mon, 18 Dec 2023 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ykcYurAH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6AF37884;
	Mon, 18 Dec 2023 14:01:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33377C433C7;
	Mon, 18 Dec 2023 14:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702908111;
	bh=d0NN5zbUVNQwoq21kIABh8pXmZaszIDr+qDEM1FCpuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ykcYurAHA1L98coJaEEFKsuOKuLrylM/bbHbZL8TZwpljK0M4IEhLWtOt60+IlRqF
	 PyyBksJqmvO1Br9g3/vHjOSVy5jB1cBJ0eT/3Y6oaPj+pVIncf+2x9Apau34Y9lp60
	 tOb6E8Zj5Eq9FldAVjhMH83Cc6SZfOQN2TQorgNk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chengfeng Ye <dg573847474@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 029/166] atm: solos-pci: Fix potential deadlock on &tx_queue_lock
Date: Mon, 18 Dec 2023 14:49:55 +0100
Message-ID: <20231218135106.254371061@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135104.927894164@linuxfoundation.org>
References: <20231218135104.927894164@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chengfeng Ye <dg573847474@gmail.com>

[ Upstream commit 15319a4e8ee4b098118591c6ccbd17237f841613 ]

As &card->tx_queue_lock is acquired under softirq context along the
following call chain from solos_bh(), other acquisition of the same
lock inside process context should disable at least bh to avoid double
lock.

<deadlock #2>
pclose()
--> spin_lock(&card->tx_queue_lock)
<interrupt>
   --> solos_bh()
   --> fpga_tx()
   --> spin_lock(&card->tx_queue_lock)

This flaw was found by an experimental static analysis tool I am
developing for irq-related deadlock.

To prevent the potential deadlock, the patch uses spin_lock_bh()
on &card->tx_queue_lock under process context code consistently to
prevent the possible deadlock scenario.

Fixes: 213e85d38912 ("solos-pci: clean up pclose() function")
Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/atm/solos-pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/atm/solos-pci.c b/drivers/atm/solos-pci.c
index 95f768b28a5e6..d3c30a28c410e 100644
--- a/drivers/atm/solos-pci.c
+++ b/drivers/atm/solos-pci.c
@@ -956,14 +956,14 @@ static void pclose(struct atm_vcc *vcc)
 	struct pkt_hdr *header;
 
 	/* Remove any yet-to-be-transmitted packets from the pending queue */
-	spin_lock(&card->tx_queue_lock);
+	spin_lock_bh(&card->tx_queue_lock);
 	skb_queue_walk_safe(&card->tx_queue[port], skb, tmpskb) {
 		if (SKB_CB(skb)->vcc == vcc) {
 			skb_unlink(skb, &card->tx_queue[port]);
 			solos_pop(vcc, skb);
 		}
 	}
-	spin_unlock(&card->tx_queue_lock);
+	spin_unlock_bh(&card->tx_queue_lock);
 
 	skb = alloc_skb(sizeof(*header), GFP_KERNEL);
 	if (!skb) {
-- 
2.43.0





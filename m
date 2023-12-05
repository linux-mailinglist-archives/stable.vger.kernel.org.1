Return-Path: <stable+bounces-4156-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA7F80464E
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CEFAB20C74
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A95C8F4;
	Tue,  5 Dec 2023 03:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c/K2biSI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3D08BF1;
	Tue,  5 Dec 2023 03:26:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E1FC433C7;
	Tue,  5 Dec 2023 03:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701746770;
	bh=+uY8lvv08kI+zB9Ja1EPGGmehkEElPN9OSdV+8pKOng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c/K2biSIeQeHSy3TqFrdRFs24bhsD0RJ8EIoMjMUvffE/RCO19UTHYnZxrC0KVU4g
	 363+tec3EgsbuJbNnEI/fmH9FrXVjR6vbNFr+sPuz/Wpq/JRMal4zWt9E5rJF/WsP3
	 yBnjwx5/dcMO8mrRnMjmgd1yeUNbt7IIDT7C0tT8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Samuel Holland <samuel.holland@sifive.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 14/71] net: axienet: Fix check for partial TX checksum
Date: Tue,  5 Dec 2023 12:16:12 +0900
Message-ID: <20231205031518.679137340@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031517.859409664@linuxfoundation.org>
References: <20231205031517.859409664@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Samuel Holland <samuel.holland@sifive.com>

[ Upstream commit fd0413bbf8b11f56e8aa842783b0deda0dfe2926 ]

Due to a typo, the code checked the RX checksum feature in the TX path.

Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Link: https://lore.kernel.org/r/20231122004219.3504219-1-samuel.holland@sifive.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 5190402f779ec..299162a74939f 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -702,7 +702,7 @@ axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 		if (lp->features & XAE_FEATURE_FULL_TX_CSUM) {
 			/* Tx Full Checksum Offload Enabled */
 			cur_p->app0 |= 2;
-		} else if (lp->features & XAE_FEATURE_PARTIAL_RX_CSUM) {
+		} else if (lp->features & XAE_FEATURE_PARTIAL_TX_CSUM) {
 			csum_start_off = skb_transport_offset(skb);
 			csum_index_off = csum_start_off + skb->csum_offset;
 			/* Tx Partial Checksum Offload Enabled */
-- 
2.42.0





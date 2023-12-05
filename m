Return-Path: <stable+bounces-4502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E25448047C3
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A006E28172F
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB326FB1;
	Tue,  5 Dec 2023 03:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NdjcjQdW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF6E8BF8;
	Tue,  5 Dec 2023 03:42:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75166C433C7;
	Tue,  5 Dec 2023 03:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701747721;
	bh=WoaiVc2VXffuj5o0QsmS2WKVbfp5caJvt/Ri2za+wEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NdjcjQdWTglxqhj7jUoXHWF/79yw/1/qwkpVA72FljU+7R5fbi3lNopL/H5D+qXul
	 CGeuSdDySBwwNyRtxQ58E5njHwFlHp3h3VIPOj9HYhtOsr3glej/n29enF/90JXYoD
	 EjV00QGVLB1xRN5K8K+43VeH6MS8ddSWTyRg2uG4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 44/67] ravb: Separate handling of irq enable/disable regs into feature
Date: Tue,  5 Dec 2023 12:17:29 +0900
Message-ID: <20231205031522.365127466@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031519.853779502@linuxfoundation.org>
References: <20231205031519.853779502@linuxfoundation.org>
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

From: Phil Edworthy <phil.edworthy@renesas.com>

[ Upstream commit cb99badde146c327f150773921ffe080abe1eb44 ]

Currently, when the HW has a single interrupt, the driver uses the
GIC, TIC, RIC0 registers to enable and disable interrupts.
When the HW has multiple interrupts, it uses the GIE, GID, TIE, TID,
RIE0, RID0 registers.

However, other devices, e.g. RZ/V2M, have multiple irqs and only have
the GIC, TIC, RIC0 registers.
Therefore, split this into a separate feature.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: eac16a733427 ("net: ravb: Stop DMA in case of failures on ravb_open()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/renesas/ravb.h      | 1 +
 drivers/net/ethernet/renesas/ravb_main.c | 5 +++--
 drivers/net/ethernet/renesas/ravb_ptp.c  | 6 +++---
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index a475f54a6b63c..a3cd09c7003bf 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1000,6 +1000,7 @@ struct ravb_hw_info {
 	unsigned internal_delay:1;	/* AVB-DMAC has internal delays */
 	unsigned tx_counters:1;		/* E-MAC has TX counters */
 	unsigned multi_irqs:1;		/* AVB-DMAC and E-MAC has multiple irqs */
+	unsigned irq_en_dis:1;		/* Has separate irq enable and disable regs */
 	unsigned gptp:1;		/* AVB-DMAC has gPTP support */
 	unsigned ccc_gac:1;		/* AVB-DMAC has gPTP support active in config mode */
 };
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 0c73bc4df98d5..57215c834188c 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -821,7 +821,7 @@ static bool ravb_queue_interrupt(struct net_device *ndev, int q)
 	if (((ris0 & ric0) & BIT(q)) || ((tis  & tic)  & BIT(q))) {
 		if (napi_schedule_prep(&priv->napi[q])) {
 			/* Mask RX and TX interrupts */
-			if (!info->multi_irqs) {
+			if (!info->irq_en_dis) {
 				ravb_write(ndev, ric0 & ~BIT(q), RIC0);
 				ravb_write(ndev, tic & ~BIT(q), TIC);
 			} else {
@@ -988,7 +988,7 @@ static int ravb_poll(struct napi_struct *napi, int budget)
 
 	/* Re-enable RX/TX interrupts */
 	spin_lock_irqsave(&priv->lock, flags);
-	if (!info->multi_irqs) {
+	if (!info->irq_en_dis) {
 		ravb_modify(ndev, RIC0, mask, mask);
 		ravb_modify(ndev, TIC,  mask, mask);
 	} else {
@@ -2038,6 +2038,7 @@ static const struct ravb_hw_info ravb_gen3_hw_info = {
 	.internal_delay = 1,
 	.tx_counters = 1,
 	.multi_irqs = 1,
+	.irq_en_dis = 1,
 	.ccc_gac = 1,
 };
 
diff --git a/drivers/net/ethernet/renesas/ravb_ptp.c b/drivers/net/ethernet/renesas/ravb_ptp.c
index c099656dd75b6..87c4306d66ecc 100644
--- a/drivers/net/ethernet/renesas/ravb_ptp.c
+++ b/drivers/net/ethernet/renesas/ravb_ptp.c
@@ -198,7 +198,7 @@ static int ravb_ptp_extts(struct ptp_clock_info *ptp,
 	priv->ptp.extts[req->index] = on;
 
 	spin_lock_irqsave(&priv->lock, flags);
-	if (!info->multi_irqs)
+	if (!info->irq_en_dis)
 		ravb_modify(ndev, GIC, GIC_PTCE, on ? GIC_PTCE : 0);
 	else if (on)
 		ravb_write(ndev, GIE_PTCS, GIE);
@@ -254,7 +254,7 @@ static int ravb_ptp_perout(struct ptp_clock_info *ptp,
 		error = ravb_ptp_update_compare(priv, (u32)start_ns);
 		if (!error) {
 			/* Unmask interrupt */
-			if (!info->multi_irqs)
+			if (!info->irq_en_dis)
 				ravb_modify(ndev, GIC, GIC_PTME, GIC_PTME);
 			else
 				ravb_write(ndev, GIE_PTMS0, GIE);
@@ -266,7 +266,7 @@ static int ravb_ptp_perout(struct ptp_clock_info *ptp,
 		perout->period = 0;
 
 		/* Mask interrupt */
-		if (!info->multi_irqs)
+		if (!info->irq_en_dis)
 			ravb_modify(ndev, GIC, GIC_PTME, 0);
 		else
 			ravb_write(ndev, GID_PTMD0, GID);
-- 
2.42.0





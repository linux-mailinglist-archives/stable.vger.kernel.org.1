Return-Path: <stable+bounces-190005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC93C0EA11
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 15:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 061EA3A56AA
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 14:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966BB308F0B;
	Mon, 27 Oct 2025 14:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHR/ojOf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F43F307AFB
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 14:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761576013; cv=none; b=FAW0X5c+UA6MpngBCIQWDOcUZf/5d119SDt4M9RNb+v46A5Ws3A1OSFGPU2bHY8k1s9cKZjhF6ZZGWgjm2OXswiK46oSzRLJMoM/kWO8AE7Hn8w5ntS2dhlqA4eWg5iYrYdidrJRpgK6kgIxLyP3OQMGEYHxilp5AHafVDQkq5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761576013; c=relaxed/simple;
	bh=6H1STr1MDjQdsTK46Ti3R8cTWSnRtuvMmsTmwJzK7uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j6mlriQ0jEWhf+6LdovX+njLG2EbLjkxtrzOqi0HnUp6A6KBL1qq9pSWM7IOM0ewNANWBknEtC/GFattKcdMiIfB+dmQvZM4cy8DZLalhFouCkiC0xCzrstSH6jrvICwoW1KqKpNgOVAjRqggt/1MX1i2EyAWiYHd88A3eJR7sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHR/ojOf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CBDC4CEF1;
	Mon, 27 Oct 2025 14:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761576010;
	bh=6H1STr1MDjQdsTK46Ti3R8cTWSnRtuvMmsTmwJzK7uk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gHR/ojOf4gYrnc95piEtfDrGOMVtPIOUeEV4jmXPoTPWHYfgdYpevd+hY1E/n7nGb
	 2GT3ksVYzlu0pF2HucdhsdrMhFEO+7vKDdp2o4APX8ItF1LPXXhRT/bzMRvnECUSal
	 IMD1IDhc3JVjcYwThOjN+mnJAmH5QIejEIDzW9Ub/RpKf6HkxIMRkHjtpxz96wLh5t
	 6SHtzuruhqSs3ZVm/C+zg5cNgt2jGW9V4VlhoDtkT4A8Bh8mICFZuyiYBprod3J6M0
	 O8IKKptsL/bp4s4/4uKtJdKh0x9g8BPutpBVLwMzrpVFQ+5uv7EoE51kb+T8ATSBsi
	 XFkoTH3FP3DmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] net: ravb: Enforce descriptor type ordering
Date: Mon, 27 Oct 2025 10:40:08 -0400
Message-ID: <20251027144008.525379-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102624-thirsty-otter-d285@gregkh>
References: <2025102624-thirsty-otter-d285@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

[ Upstream commit 5370c31e84b0e0999c7b5ff949f4e104def35584 ]

Ensure the TX descriptor type fields are published in a safe order so the
DMA engine never begins processing a descriptor chain before all descriptor
fields are fully initialised.

For multi-descriptor transmits the driver writes DT_FEND into the last
descriptor and DT_FSTART into the first. The DMA engine begins processing
when it observes DT_FSTART. Move the dma_wmb() barrier so it executes
immediately after DT_FEND and immediately before writing DT_FSTART
(and before DT_FSINGLE in the single-descriptor case). This guarantees
that all prior CPU writes to the descriptor memory are visible to the
device before DT_FSTART is seen.

This avoids a situation where compiler/CPU reordering could publish
DT_FSTART ahead of DT_FEND or other descriptor fields, allowing the DMA to
start on a partially initialised chain and causing corrupted transmissions
or TX timeouts. Such a failure was observed on RZ/G2L with an RT kernel as
transmit queue timeouts and device resets.

Fixes: 2f45d1902acf ("ravb: minimize TX data copying")
Cc: stable@vger.kernel.org
Co-developed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Link: https://patch.msgid.link/20251017151830.171062-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ kept unconditional skb_tx_timestamp() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/renesas/ravb_main.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index b08478aabc6e6..7e71c60f75d5a 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1596,13 +1596,25 @@ static netdev_tx_t ravb_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	}
 
 	skb_tx_timestamp(skb);
-	/* Descriptor type must be set after all the above writes */
-	dma_wmb();
+
 	if (num_tx_desc > 1) {
 		desc->die_dt = DT_FEND;
 		desc--;
+		/* When using multi-descriptors, DT_FEND needs to get written
+		 * before DT_FSTART, but the compiler may reorder the memory
+		 * writes in an attempt to optimize the code.
+		 * Use a dma_wmb() barrier to make sure DT_FEND and DT_FSTART
+		 * are written exactly in the order shown in the code.
+		 * This is particularly important for cases where the DMA engine
+		 * is already running when we are running this code. If the DMA
+		 * sees DT_FSTART without the corresponding DT_FEND it will enter
+		 * an error condition.
+		 */
+		dma_wmb();
 		desc->die_dt = DT_FSTART;
 	} else {
+		/* Descriptor type must be set after all the above writes */
+		dma_wmb();
 		desc->die_dt = DT_FSINGLE;
 	}
 	ravb_modify(ndev, TCCR, TCCR_TSRQ0 << q, TCCR_TSRQ0 << q);
-- 
2.51.0



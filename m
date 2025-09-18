Return-Path: <stable+bounces-167691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF27B23163
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1CBF3A4E15
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C872FE575;
	Tue, 12 Aug 2025 18:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fyHng3E8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167DB2F5E;
	Tue, 12 Aug 2025 18:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021671; cv=none; b=PI3F7daMis3fmIrCzzpZJ1VAJ0G0FHy2mNub7qwJ5IFgk4PzsWyiHl1lqGI4mU/rbLFSKWjKT891tAu4x1prWblLgbS1OYvTF2p2svzZI6SuJ2tyyfsLBobpSufPMojEU0Fr02hsFKReETe9PbrA2rKWkOykYQBeRcJA0U1Afzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021671; c=relaxed/simple;
	bh=Zaq6zRZgk84gxPsdZgDo0Jj3M9VU1Wzyn+9vXK8aKMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DwZUtarpCsC4euBN0ykkUgBla4StHyEkpnJ5c/JHGRRjwhm0wDiUpE+gAbtxFIo80isEF2Pd9l6nKCaC6Hx/zDdgrg00TxFd6r92F5bwSghejBwg8+x52qoImbG/kLEjTJxJPGR191XrP4yAFU1QO4CAXr5MKFWEzpZo/7lrgkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fyHng3E8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F7CC4CEF0;
	Tue, 12 Aug 2025 18:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755021670;
	bh=Zaq6zRZgk84gxPsdZgDo0Jj3M9VU1Wzyn+9vXK8aKMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fyHng3E8q5hQy7tA/zMASR8A+v7OLlfpTLhLi+bU5tMqnoiUstGmcpyLiQ7PJBL41
	 RB31jlCgkuvGu7C/ftlTd7Xkxa8FNiCBDE1Q2hDiZApTtb9jcdaxqdRkzq2JrxOqBp
	 DUvkyfgBePdZTvbI3zdRYobli4ns69NCgdQmTL+Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Fourier <fourier.thomas@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 157/262] mtd: rawnand: rockchip: Add missing check after DMA map
Date: Tue, 12 Aug 2025 19:29:05 +0200
Message-ID: <20250812172959.786558876@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812172952.959106058@linuxfoundation.org>
References: <20250812172952.959106058@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Thomas Fourier <fourier.thomas@gmail.com>

[ Upstream commit 3b36f86dc47261828f96f826077131a35dd825fd ]

The DMA map functions can fail and should be tested for errors.

Fixes: 058e0e847d54 ("mtd: rawnand: rockchip: NFC driver for RK3308, RK2928 and others")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/raw/rockchip-nand-controller.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/mtd/nand/raw/rockchip-nand-controller.c b/drivers/mtd/nand/raw/rockchip-nand-controller.c
index 2a95dd63b8c2..f68600ce5bfa 100644
--- a/drivers/mtd/nand/raw/rockchip-nand-controller.c
+++ b/drivers/mtd/nand/raw/rockchip-nand-controller.c
@@ -656,9 +656,16 @@ static int rk_nfc_write_page_hwecc(struct nand_chip *chip, const u8 *buf,
 
 	dma_data = dma_map_single(nfc->dev, (void *)nfc->page_buf,
 				  mtd->writesize, DMA_TO_DEVICE);
+	if (dma_mapping_error(nfc->dev, dma_data))
+		return -ENOMEM;
+
 	dma_oob = dma_map_single(nfc->dev, nfc->oob_buf,
 				 ecc->steps * oob_step,
 				 DMA_TO_DEVICE);
+	if (dma_mapping_error(nfc->dev, dma_oob)) {
+		dma_unmap_single(nfc->dev, dma_data, mtd->writesize, DMA_TO_DEVICE);
+		return -ENOMEM;
+	}
 
 	reinit_completion(&nfc->done);
 	writel(INT_DMA, nfc->regs + nfc->cfg->int_en_off);
@@ -772,9 +779,17 @@ static int rk_nfc_read_page_hwecc(struct nand_chip *chip, u8 *buf, int oob_on,
 	dma_data = dma_map_single(nfc->dev, nfc->page_buf,
 				  mtd->writesize,
 				  DMA_FROM_DEVICE);
+	if (dma_mapping_error(nfc->dev, dma_data))
+		return -ENOMEM;
+
 	dma_oob = dma_map_single(nfc->dev, nfc->oob_buf,
 				 ecc->steps * oob_step,
 				 DMA_FROM_DEVICE);
+	if (dma_mapping_error(nfc->dev, dma_oob)) {
+		dma_unmap_single(nfc->dev, dma_data, mtd->writesize,
+				 DMA_FROM_DEVICE);
+		return -ENOMEM;
+	}
 
 	/*
 	 * The first blocks (4, 8 or 16 depending on the device)
-- 
2.39.5





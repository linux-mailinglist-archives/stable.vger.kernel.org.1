Return-Path: <stable+bounces-62738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC8B940EF3
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 12:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCF75B224A6
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 10:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE81195B1A;
	Tue, 30 Jul 2024 10:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rrt2ifuk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05BE208DA
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 10:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335048; cv=none; b=TaS6WZdQxgZRdmYJfvf2RfZ5JtLJmxN/81NlCCEkShqqHN+VuuAj3guVMrTjpD0/pBbpyIFS/lbkfEE/JhEk4IdMwUtriNE0aZbArvBb17ZhQ3GukzWm2F73Uy0GGwram5hCcT9OgFY3SWUAF1k+48G/gak74/kU7xLP/pk+FvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335048; c=relaxed/simple;
	bh=NWNZnzses1dWKbepcztg0eSFNBwkovmvpL4aBZ3MEEo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=d+EDbD6wh1zt7R9NqbeWVgMcNx92S1GrhMJo5UEHs2hITbB1FKiYaZCR9NGB9MguSq7NupG1ljC60YXpSaM84nqOPyjeMFypRczBVph1nZI9L0OydNQT19jkPPHbPs0W4+NFIf2QlEHgo6KEB/CkZH1smS4CbWvfDbV+4d6PZy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rrt2ifuk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6FD4C32782;
	Tue, 30 Jul 2024 10:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722335048;
	bh=NWNZnzses1dWKbepcztg0eSFNBwkovmvpL4aBZ3MEEo=;
	h=Subject:To:Cc:From:Date:From;
	b=rrt2ifukPztoz0MspR4TiH/qgwJXE5TL4QcKRUFQxz+HIbq/UMl06Tj0ZETJ7D8d1
	 hDT2+LsDGQ7t5RrJOsN2WqBy42Xu64qknzqh6OxR06ySyt4TxzZrs13nZlvbWfEgc+
	 7gty3h2DGwV9D/25SdOD3IzeqfqDBsl74UJMfTGo=
Subject: FAILED: patch "[PATCH] mtd: rawnand: lpx32xx: Fix dma_request_chan() error checks" failed to apply to 6.1-stable tree
To: piotr.wojtaszczyk@timesys.com,miquel.raynal@bootlin.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 30 Jul 2024 12:23:58 +0200
Message-ID: <2024073058-suing-candied-447f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a503f91a3645651a39baf97f1aed90d5d9f9bda9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024073058-suing-candied-447f@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

a503f91a3645 ("mtd: rawnand: lpx32xx: Fix dma_request_chan() error checks")
478211867460 ("mtd: rawnand: lpx32xx: Request DMA channels using DT entries")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a503f91a3645651a39baf97f1aed90d5d9f9bda9 Mon Sep 17 00:00:00 2001
From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Date: Fri, 5 Jul 2024 13:51:35 +0200
Subject: [PATCH] mtd: rawnand: lpx32xx: Fix dma_request_chan() error checks

The dma_request_chan() returns error pointer in case of error, while
dma_request_channel() returns NULL in case of error therefore different
error checks are needed for the two.

Fixes: 7326d3fb1ee3 ("mtd: rawnand: lpx32xx: Request DMA channels using DT entries")
Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20240705115139.126522-1-piotr.wojtaszczyk@timesys.com

diff --git a/drivers/mtd/nand/raw/lpc32xx_mlc.c b/drivers/mtd/nand/raw/lpc32xx_mlc.c
index 92cebe871bb4..b9c3adc54c01 100644
--- a/drivers/mtd/nand/raw/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_mlc.c
@@ -575,7 +575,7 @@ static int lpc32xx_dma_setup(struct lpc32xx_nand_host *host)
 	dma_cap_mask_t mask;
 
 	host->dma_chan = dma_request_chan(mtd->dev.parent, "rx-tx");
-	if (!host->dma_chan) {
+	if (IS_ERR(host->dma_chan)) {
 		/* fallback to request using platform data */
 		if (!host->pdata || !host->pdata->dma_filter) {
 			dev_err(mtd->dev.parent, "no DMA platform data\n");
diff --git a/drivers/mtd/nand/raw/lpc32xx_slc.c b/drivers/mtd/nand/raw/lpc32xx_slc.c
index 3b7e3d259785..ade971e4cc3b 100644
--- a/drivers/mtd/nand/raw/lpc32xx_slc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_slc.c
@@ -722,7 +722,7 @@ static int lpc32xx_nand_dma_setup(struct lpc32xx_nand_host *host)
 	dma_cap_mask_t mask;
 
 	host->dma_chan = dma_request_chan(mtd->dev.parent, "rx-tx");
-	if (!host->dma_chan) {
+	if (IS_ERR(host->dma_chan)) {
 		/* fallback to request using platform data */
 		if (!host->pdata || !host->pdata->dma_filter) {
 			dev_err(mtd->dev.parent, "no DMA platform data\n");



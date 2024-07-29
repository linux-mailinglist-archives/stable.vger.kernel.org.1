Return-Path: <stable+bounces-62546-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0102E93F546
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 14:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A826F282DD9
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 12:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DE7148308;
	Mon, 29 Jul 2024 12:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c9LFTUP9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AE6147C76
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 12:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722255880; cv=none; b=biBRWLeV7WVjCON1Y0Mfee7xaWXucq/+RAVfn9Iiz59Zbu6jKkfuafjcyMPJqvHaJjsoVy1P+uviC/PbgfAfo/+NMgt4PKlNj71EScyAilgqusIG3dr6pT0zh3/t9Ue5VdB5MQka3KHKgtZHTJWl3OQ5dLJVFNX5WdUT912uq0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722255880; c=relaxed/simple;
	bh=HhYJe9oH9jpoDkLjerbRBPgllpng2rQyNYTDIsN34hU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=V/lEFlwo9OTXf1XfXYqShHw/W5U13MQ2kdXlbyZFYLIbA6oIgaPsc/qdNGUK3espBQ81AjBDFsKS7yIYjEIcBDjpeB+nmU6+/IUiKwoOMxwulJmSMaCSv2mZvt2VinFBnq6bat64MR1uiiprKPPc5ZRfnOwGSwDh2oiCbPa6Xq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c9LFTUP9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF77AC32786;
	Mon, 29 Jul 2024 12:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722255880;
	bh=HhYJe9oH9jpoDkLjerbRBPgllpng2rQyNYTDIsN34hU=;
	h=Subject:To:Cc:From:Date:From;
	b=c9LFTUP9fpZyYXQ5jFF1z4eEvKt6qXTkKXH57tztOivwV6sZnvTxzFVmBhvv22z7j
	 WDjYjqpQMNkgBDu9ohaU0VsA6eL74Lt8ZPdSzrYOzc579jxa7yWTuw+VUpHU4vHXUm
	 k9Py8jirJvJEIei8hrve0sgzF7JXUPlGIJMm+9xA=
Subject: FAILED: patch "[PATCH] dmaengine: fsl-edma: change the memory access from local into" failed to apply to 6.6-stable tree
To: joy.zou@nxp.com,Frank.Li@nxp.com,vkoul@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 14:24:28 +0200
Message-ID: <2024072928-engaged-steerable-531f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 8ddad558997002ce67980e30c9e8dfaa696e163b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072928-engaged-steerable-531f@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

8ddad5589970 ("dmaengine: fsl-edma: change the memory access from local into remote mode in i.MX 8QM")
77584368a0f3 ("dmaengine: fsl-edma: clean up unused "fsl,imx8qm-adma" compatible string")
d8d4355861d8 ("dmaengine: fsl-edma: add i.MX8ULP edma support")
4ee632c82d2d ("dmaengine: fsl-edma: fix DMA channel leak in eDMAv4")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8ddad558997002ce67980e30c9e8dfaa696e163b Mon Sep 17 00:00:00 2001
From: Joy Zou <joy.zou@nxp.com>
Date: Fri, 10 May 2024 11:09:34 +0800
Subject: [PATCH] dmaengine: fsl-edma: change the memory access from local into
 remote mode in i.MX 8QM

Fix the issue where MEM_TO_MEM fail on i.MX8QM due to the requirement
that both source and destination addresses need pass through the IOMMU.
Typically, peripheral FIFO addresses bypass the IOMMU, necessitating
only one of the source or destination to go through it.

Set "is_remote" to true to ensure both source and destination
addresses pass through the IOMMU.

iMX8 Spec define "Local" and "Remote" bus as below.
Local bus: bypass IOMMU to directly access other peripheral register,
such as FIFO.
Remote bus: go through IOMMU to access system memory.

The test fail log as follow:
[ 66.268506] dmatest: dma0chan0-copy0: result #1: 'test timed out' with src_off=0x100 dst_off=0x80 len=0x3ec0 (0)
[ 66.278785] dmatest: dma0chan0-copy0: summary 1 tests, 1 failures 0.32 iops 4 KB/s (0)

Fixes: 72f5801a4e2b ("dmaengine: fsl-edma: integrate v3 support")
Signed-off-by: Joy Zou <joy.zou@nxp.com>
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20240510030959.703663-1-joy.zou@nxp.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 9d565ab85502..b7f15ab96855 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -755,6 +755,8 @@ struct dma_async_tx_descriptor *fsl_edma_prep_memcpy(struct dma_chan *chan,
 	fsl_desc->iscyclic = false;
 
 	fsl_chan->is_sw = true;
+	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_MEM_REMOTE)
+		fsl_chan->is_remote = true;
 
 	/* To match with copy_align and max_seg_size so 1 tcd is enough */
 	fsl_edma_fill_tcd(fsl_chan, fsl_desc->tcd[0].vtcd, dma_src, dma_dst,
@@ -848,6 +850,7 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan)
 	fsl_chan->tcd_pool = NULL;
 	fsl_chan->is_sw = false;
 	fsl_chan->srcid = 0;
+	fsl_chan->is_remote = false;
 	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_CHCLK)
 		clk_disable_unprepare(fsl_chan->clk);
 }
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 1c90b95f4ff8..ce37e1ee9c46 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -194,6 +194,7 @@ struct fsl_edma_desc {
 #define FSL_EDMA_DRV_HAS_PD		BIT(5)
 #define FSL_EDMA_DRV_HAS_CHCLK		BIT(6)
 #define FSL_EDMA_DRV_HAS_CHMUX		BIT(7)
+#define FSL_EDMA_DRV_MEM_REMOTE		BIT(8)
 /* control and status register is in tcd address space, edma3 reg layout */
 #define FSL_EDMA_DRV_SPLIT_REG		BIT(9)
 #define FSL_EDMA_DRV_BUS_8BYTE		BIT(10)
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index ec4f5baafad5..c66185c5a199 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -343,7 +343,7 @@ static struct fsl_edma_drvdata imx7ulp_data = {
 };
 
 static struct fsl_edma_drvdata imx8qm_data = {
-	.flags = FSL_EDMA_DRV_HAS_PD | FSL_EDMA_DRV_EDMA3,
+	.flags = FSL_EDMA_DRV_HAS_PD | FSL_EDMA_DRV_EDMA3 | FSL_EDMA_DRV_MEM_REMOTE,
 	.chreg_space_sz = 0x10000,
 	.chreg_off = 0x10000,
 	.setup_irq = fsl_edma3_irq_init,



Return-Path: <stable+bounces-26087-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E99870D03
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C9AE1F21565
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898857BAF7;
	Mon,  4 Mar 2024 21:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1xMwyouy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479BF78B69;
	Mon,  4 Mar 2024 21:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587811; cv=none; b=pYTf9s32Yx4NFA7nudutOMYHqj3SBWbBAbWFAhQXQxGFZTuMfkHd23ynx0VMjPDcj+Gvso7qGZNAQlGd2Vkor69ajnFv3qeUIkAZ6ua0ZhPuTJkdy/OAPF1rz9GomDijkFykqXCmKKOP3eUYy9Ug3/KD0/1KpauqYrJvQK7WEIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587811; c=relaxed/simple;
	bh=7iqJs9/rcljyaYg5yQ35cEFoEnlYSkLxmz/W0RoPy/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lXuw2i0meSNmxnRhRwLy0bj3W14piofLNQ8upzIplZLUWzrFXd0Ok80Y3hk9Lq3LfFzptsAKuFO7hHGjvmQ4vHarnkpK2145xHtd3ka9PD89pUn6d2lNCEptPQIfvAHWrXoqxVMJfKpR6biXvzc5VzEyIHSUW4TERA4borwXEvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1xMwyouy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9DFC433C7;
	Mon,  4 Mar 2024 21:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709587811;
	bh=7iqJs9/rcljyaYg5yQ35cEFoEnlYSkLxmz/W0RoPy/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1xMwyouy/CWdELMziTY4m1TfctSpBDW/fz+7Yo8o3yQ8SSy5SccZWrtS4ca866kY8
	 SqLaQQ2VTWJZ1dFfPoiIglMut7ytePGM8dk3Q4nuT87s7A6/GjYpDIx23/RblxRqzX
	 JElSYf9944vHoBJJmoqHQrC0ZNqhVI3NODTc4pzA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Curtis Klein <curtis.klein@hpe.com>,
	Yi Zhao <yi.zhao@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6.7 099/162] dmaengine: fsl-qdma: init irq after reg initialization
Date: Mon,  4 Mar 2024 21:22:44 +0000
Message-ID: <20240304211554.996781558@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211551.833500257@linuxfoundation.org>
References: <20240304211551.833500257@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Curtis Klein <curtis.klein@hpe.com>

commit 87a39071e0b639f45e05d296cc0538eef44ec0bd upstream.

Initialize the qDMA irqs after the registers are configured so that
interrupts that may have been pending from a primary kernel don't get
processed by the irq handler before it is ready to and cause panic with
the following trace:

  Call trace:
   fsl_qdma_queue_handler+0xf8/0x3e8
   __handle_irq_event_percpu+0x78/0x2b0
   handle_irq_event_percpu+0x1c/0x68
   handle_irq_event+0x44/0x78
   handle_fasteoi_irq+0xc8/0x178
   generic_handle_irq+0x24/0x38
   __handle_domain_irq+0x90/0x100
   gic_handle_irq+0x5c/0xb8
   el1_irq+0xb8/0x180
   _raw_spin_unlock_irqrestore+0x14/0x40
   __setup_irq+0x4bc/0x798
   request_threaded_irq+0xd8/0x190
   devm_request_threaded_irq+0x74/0xe8
   fsl_qdma_probe+0x4d4/0xca8
   platform_drv_probe+0x50/0xa0
   really_probe+0xe0/0x3f8
   driver_probe_device+0x64/0x130
   device_driver_attach+0x6c/0x78
   __driver_attach+0xbc/0x158
   bus_for_each_dev+0x5c/0x98
   driver_attach+0x20/0x28
   bus_add_driver+0x158/0x220
   driver_register+0x60/0x110
   __platform_driver_register+0x44/0x50
   fsl_qdma_driver_init+0x18/0x20
   do_one_initcall+0x48/0x258
   kernel_init_freeable+0x1a4/0x23c
   kernel_init+0x10/0xf8
   ret_from_fork+0x10/0x18

Cc: stable@vger.kernel.org
Fixes: b092529e0aa0 ("dmaengine: fsl-qdma: Add qDMA controller driver for Layerscape SoCs")
Signed-off-by: Curtis Klein <curtis.klein@hpe.com>
Signed-off-by: Yi Zhao <yi.zhao@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20240201220406.440145-1-Frank.Li@nxp.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/fsl-qdma.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

--- a/drivers/dma/fsl-qdma.c
+++ b/drivers/dma/fsl-qdma.c
@@ -1199,10 +1199,6 @@ static int fsl_qdma_probe(struct platfor
 	if (!fsl_qdma->queue)
 		return -ENOMEM;
 
-	ret = fsl_qdma_irq_init(pdev, fsl_qdma);
-	if (ret)
-		return ret;
-
 	fsl_qdma->irq_base = platform_get_irq_byname(pdev, "qdma-queue0");
 	if (fsl_qdma->irq_base < 0)
 		return fsl_qdma->irq_base;
@@ -1241,16 +1237,19 @@ static int fsl_qdma_probe(struct platfor
 
 	platform_set_drvdata(pdev, fsl_qdma);
 
-	ret = dma_async_device_register(&fsl_qdma->dma_dev);
+	ret = fsl_qdma_reg_init(fsl_qdma);
 	if (ret) {
-		dev_err(&pdev->dev,
-			"Can't register NXP Layerscape qDMA engine.\n");
+		dev_err(&pdev->dev, "Can't Initialize the qDMA engine.\n");
 		return ret;
 	}
 
-	ret = fsl_qdma_reg_init(fsl_qdma);
+	ret = fsl_qdma_irq_init(pdev, fsl_qdma);
+	if (ret)
+		return ret;
+
+	ret = dma_async_device_register(&fsl_qdma->dma_dev);
 	if (ret) {
-		dev_err(&pdev->dev, "Can't Initialize the qDMA engine.\n");
+		dev_err(&pdev->dev, "Can't register NXP Layerscape qDMA engine.\n");
 		return ret;
 	}
 




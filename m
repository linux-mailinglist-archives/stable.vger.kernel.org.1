Return-Path: <stable+bounces-175408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCA2B36817
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90A392A6F90
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E2034AAFE;
	Tue, 26 Aug 2025 14:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YTRTLkN5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F133451A0;
	Tue, 26 Aug 2025 14:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216964; cv=none; b=snSnAClMpIxzGsbfYRqtU1NVbU01k1BehHyisYtDzyocqywK5DaoMVbDCCoohG7Wj3S7lOKe2PfG3VHOcc4N7FKXhzyrWIonnSlySSTgSinoWyuew8oWdWAwYTgJatN+OtG8D0sVTvfK96yp35TRGDkZsj9WUKf79CY4ymCbpfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216964; c=relaxed/simple;
	bh=X/wjVYGPKqyTVgfxj43LxW0dmGK6dbXskaGHy9uBluU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lFlqnUaWKWhzh4s3cWaESQXAUNWwsafmsZSqSuZ7q1ScaCIsqzEO/KP0Jc25U9uXzxilIL+SmgL3LKbuINhNYMiMl6xmZqgOFjWoGSUmlfgeEEYawVlMUoHaEhtHcDRwyPZY32v/C6ANhGTopsBzpkqJuS5f+f47IqTKev/P64o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YTRTLkN5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A03C4CEF1;
	Tue, 26 Aug 2025 14:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756216963;
	bh=X/wjVYGPKqyTVgfxj43LxW0dmGK6dbXskaGHy9uBluU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YTRTLkN5jina3YelMbFbCZ5/RhR3mgPHBLfeX6DgmjQwKkUGTMYOTmgS/IMMGI6pf
	 4HV/C0fGwQls7kAZAbN7/lmsCbPcoj7v45tMYqBGsPmLshU5CBtZKO5hkRZ7nJFGhk
	 WJE37urni7eq9vQBx4xhoUWbK0+pRCyqhQFlAgT0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pavel Pisa <pisa@fel.cvut.cz>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [PATCH 5.15 576/644] fpga: zynq_fpga: Fix the wrong usage of dma_map_sgtable()
Date: Tue, 26 Aug 2025 13:11:07 +0200
Message-ID: <20250826111000.804849271@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
References: <20250826110946.507083938@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xu Yilun <yilun.xu@linux.intel.com>

commit 1ca61060de92a4320d73adfe5dc8d335653907ac upstream.

dma_map_sgtable() returns only 0 or the error code. Read sgt->nents to
get the number of mapped segments.

Fixes: 37e00703228a ("zynq_fpga: use sgtable-based scatterlist wrappers")
Reported-by: Pavel Pisa <pisa@fel.cvut.cz>
Closes: https://lore.kernel.org/linux-fpga/202508041548.22955.pisa@fel.cvut.cz/
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Tested-by: Pavel Pisa <pisa@fel.cvut.cz>
Link: https://lore.kernel.org/r/20250806070605.1920909-2-yilun.xu@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/fpga/zynq-fpga.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -405,12 +405,12 @@ static int zynq_fpga_ops_write(struct fp
 		}
 	}
 
-	priv->dma_nelms =
-	    dma_map_sgtable(mgr->dev.parent, sgt, DMA_TO_DEVICE, 0);
-	if (priv->dma_nelms == 0) {
+	err = dma_map_sgtable(mgr->dev.parent, sgt, DMA_TO_DEVICE, 0);
+	if (err) {
 		dev_err(&mgr->dev, "Unable to DMA map (TO_DEVICE)\n");
-		return -ENOMEM;
+		return err;
 	}
+	priv->dma_nelms = sgt->nents;
 
 	/* enable clock */
 	err = clk_enable(priv->clk);




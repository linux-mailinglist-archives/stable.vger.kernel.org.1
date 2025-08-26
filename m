Return-Path: <stable+bounces-174609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEE2B3644D
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B81181781EF
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FA71917ED;
	Tue, 26 Aug 2025 13:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yUv9hhz9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E671C4609;
	Tue, 26 Aug 2025 13:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214846; cv=none; b=U93+vacB+y4/qamAam61OiENx2q92I4J6W8QTOMn0pzmX0dpH7Un/Dq1r5poxjy/RdxGXAr20f7K8X30CTWKH5V4MGxxncO7xnU/5e/FmmIUNX+Jgpy6rsc/uR6mUxYi/RLdZI5TARFxLs8q2rmR9tZ0iyuDnx9pvGkkn6ws7UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214846; c=relaxed/simple;
	bh=iY+bZYGKfSchmggfVc0HkMmIae9i6kZU4jsLZVeVvEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CGRb8fM4ZfC3dGmihDLZ6lmkldo0hYo7SMKfNhuf7iwTvjq6HG538XESJrVp07mNNv/2dYdRNcOXxceZ8SkbZvQEJ+3hUaNQ479mVTqV+wYwXnmpvhvTf/4YyzgtEl83bYCwQYCdvcXWVeckzEPVwXd3+miWpWzkuDhMd7kmU5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yUv9hhz9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6A2C4CEF1;
	Tue, 26 Aug 2025 13:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756214846;
	bh=iY+bZYGKfSchmggfVc0HkMmIae9i6kZU4jsLZVeVvEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yUv9hhz9GxYID4N+YFM2pHsq/RaMvy9yquPAWKzmjDNf8pOUqS9mF3oBuLWxlepef
	 3k324WkAPjakGCHNOMFxS8z+pmkCunLGxtskls30TYEgg/bSvXPt7jZXUK4+neZh0X
	 dzVeh0AqLNYUKGfCGXk3lBdgl4A+FmvrGFlCXchY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [PATCH 6.1 292/482] zynq_fpga: use sgtable-based scatterlist wrappers
Date: Tue, 26 Aug 2025 13:09:05 +0200
Message-ID: <20250826110938.005309828@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110930.769259449@linuxfoundation.org>
References: <20250826110930.769259449@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Szyprowski <m.szyprowski@samsung.com>

commit 37e00703228ab44d0aacc32a97809a4f6f58df1b upstream.

Use common wrappers operating directly on the struct sg_table objects to
fix incorrect use of statterlists related calls. dma_unmap_sg() function
has to be called with the number of elements originally passed to the
dma_map_sg() function, not the one returned in sgtable's nents.

CC: stable@vger.kernel.org
Fixes: 425902f5c8e3 ("fpga zynq: Use the scatterlist interface")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Xu Yilun <yilun.xu@intel.com>
Link: https://lore.kernel.org/r/20250616120932.1090614-1-m.szyprowski@samsung.com
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/fpga/zynq-fpga.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -406,7 +406,7 @@ static int zynq_fpga_ops_write(struct fp
 	}
 
 	priv->dma_nelms =
-	    dma_map_sg(mgr->dev.parent, sgt->sgl, sgt->nents, DMA_TO_DEVICE);
+	    dma_map_sgtable(mgr->dev.parent, sgt, DMA_TO_DEVICE, 0);
 	if (priv->dma_nelms == 0) {
 		dev_err(&mgr->dev, "Unable to DMA map (TO_DEVICE)\n");
 		return -ENOMEM;
@@ -478,7 +478,7 @@ out_clk:
 	clk_disable(priv->clk);
 
 out_free:
-	dma_unmap_sg(mgr->dev.parent, sgt->sgl, sgt->nents, DMA_TO_DEVICE);
+	dma_unmap_sgtable(mgr->dev.parent, sgt, DMA_TO_DEVICE, 0);
 	return err;
 }
 




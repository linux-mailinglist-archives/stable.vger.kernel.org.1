Return-Path: <stable+bounces-68744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AED3E9533C3
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E216F1C250EF
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F088F1A00CE;
	Thu, 15 Aug 2024 14:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Phojto5j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8D619DF6A;
	Thu, 15 Aug 2024 14:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731526; cv=none; b=XTIb5okOXClVO6zA2xRgltT8l82YTyru5m2zu8a/LyM/gpsP8EeEgdnLrWRc55NUDg6lnIxNthWDvF5RjOG26FAMEfYMLxLS937DWIj3I4HAJq4o1C2gY5OrCG0F+j7atLSwAM33ZXlWom3f3qwE2XUsCV1upxQJa7x3R8ZHLRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731526; c=relaxed/simple;
	bh=yRkne1UKBNX4G3LBa/fYDxRaV1K+KUGsjDaThHndTt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hmWAk7RB0TdI28RFMazAvowBzA2MAGx8oE/mJUoHnj4N90LYrazKJV8jY94s5ASCsq1jhnOamRD/owlCM53dAlUuIuL/GpAW+ktt2XihQ8K0/+J1xE30CxhrGW4n1pzrYAPCg01Dae0zhJip9dpFUJ57EeBuX2fs1dhvHGZeA5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Phojto5j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263FFC32786;
	Thu, 15 Aug 2024 14:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723731526;
	bh=yRkne1UKBNX4G3LBa/fYDxRaV1K+KUGsjDaThHndTt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Phojto5jIhpdnDk7uJhArnNUa6ZSzilUOfZ1KUevksqIoJAH5wSXhHmPv5l9WNkl8
	 pmaRNVb7ifPuFLRwnf66UFG92G1QV+YmqrXmD4W/UwDZwfhcQol9YnTW2/iWYDiQSV
	 EouXJH8P+99lX1IfpapjYCzTR25GRbHa0BE52UU4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Leon Romanovsky <leonro@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 157/259] nvme-pci: add missing condition check for existence of mapped data
Date: Thu, 15 Aug 2024 15:24:50 +0200
Message-ID: <20240815131908.847868593@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131902.779125794@linuxfoundation.org>
References: <20240815131902.779125794@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Romanovsky <leonro@nvidia.com>

[ Upstream commit c31fad1470389666ac7169fe43aa65bf5b7e2cfd ]

nvme_map_data() is called when request has physical segments, hence
the nvme_unmap_data() should have same condition to avoid dereference.

Fixes: 4aedb705437f ("nvme-pci: split metadata handling from nvme_map_data / nvme_unmap_data")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 486e44d20b430..1a6a628bb6f9f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -938,7 +938,8 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	nvme_submit_cmd(nvmeq, &cmnd, bd->last);
 	return BLK_STS_OK;
 out_unmap_data:
-	nvme_unmap_data(dev, req);
+	if (blk_rq_nr_phys_segments(req))
+		nvme_unmap_data(dev, req);
 out_free_cmd:
 	nvme_cleanup_cmd(req);
 	return ret;
-- 
2.43.0





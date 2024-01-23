Return-Path: <stable+bounces-15380-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1A8838577
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14CCEB2E273
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAF87764C;
	Tue, 23 Jan 2024 02:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RSb+uk3Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6F477636;
	Tue, 23 Jan 2024 02:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975548; cv=none; b=ah1qBM0rNwYx6hlOlvEN6Gtu2tJSrVYYErKcRocl4sDQ29oju+1B280cGD5cFvrpc+yoyI/eK+RDDWJAKyx2xunK0N6m3z0YahYURTY+SCkxxFUxtRh7PKZkOqN8zzZsdxKEuxusOD4/lbTM02TgLihxMxFdhN93PeC8k/6Ffpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975548; c=relaxed/simple;
	bh=Q23i1k3wd2LNLg7ozlWou0iyRCQw3bfbmDNps2Us6DQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WC2HXj2tw5PG2dhp0I4Jld6fQqgv+qFyOIiQ227r86DsGOqZbFKgRt5lLyLBZN793ZFGP/9brQfQVHrnSX1JPKWfhUaNAQ5U040+OYlo5GRfvkgCbfG8WkjHbE5M2StpQv6QH+6UwjisxnrBRYgqyZANJ6IsYJdZL0sqVA/PTIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RSb+uk3Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B62C433B1;
	Tue, 23 Jan 2024 02:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705975548;
	bh=Q23i1k3wd2LNLg7ozlWou0iyRCQw3bfbmDNps2Us6DQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RSb+uk3Yc3oRynR/3QMcmihM78pmsMR7mYMdv6leU6rLkfI5v4UCPypBQPUYdooM6
	 OfJ1pdYOFEWhRteG4ZODxfJaFxdDTeM6xk5bVTeTQKU1Uf/7jtlYgdtN2cYKM+QW9E
	 w2kQGu+/+z5bjpeMMAYBPKLzUI/1Q98R+NwJXGp4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 491/583] PCI: epf-mhi: Fix the DMA data direction of dma_unmap_single()
Date: Mon, 22 Jan 2024 15:59:02 -0800
Message-ID: <20240122235827.048101573@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

[ Upstream commit 327ec5f70609cf00c6f961073c01857555c6a8eb ]

In the error path of pci_epf_mhi_edma_write() function, the DMA data
direction passed (DMA_FROM_DEVICE) doesn't match the actual direction used
for the data transfer. Fix it by passing the correct one (DMA_TO_DEVICE).

Fixes: 7b99aaaddabb ("PCI: epf-mhi: Add eDMA support")
Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
Link: https://lore.kernel.org/r/20231214063328.40657-1-manivannan.sadhasivam@linaro.org
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index ec5f4a38178b..6dc918a8a023 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -405,7 +405,7 @@ static int pci_epf_mhi_edma_write(struct mhi_ep_cntrl *mhi_cntrl,
 	}
 
 err_unmap:
-	dma_unmap_single(dma_dev, src_addr, buf_info->size, DMA_FROM_DEVICE);
+	dma_unmap_single(dma_dev, src_addr, buf_info->size, DMA_TO_DEVICE);
 err_unlock:
 	mutex_unlock(&epf_mhi->lock);
 
-- 
2.43.0





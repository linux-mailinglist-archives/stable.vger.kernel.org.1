Return-Path: <stable+bounces-64328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B25CC941D7A
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 19:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA130B2943F
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053181A76D9;
	Tue, 30 Jul 2024 17:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ODILG4jN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B901A76D4;
	Tue, 30 Jul 2024 17:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359759; cv=none; b=Ly99UwcPPiSj+VQ2uw/da3CmuNXJxMU53ylb6yKVQScs2bC+BJit6fercdhxW5ljPPX2j0LM8TRkxhwq+zAr0B3nVsFC8UGmgFlCr1d5WfJ2V1oLtbLcQ61gMsy8Kfii/bCh2e1R+h3NwBP0Tg49gxEHtOVS/e9wgdUSTuFKYjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359759; c=relaxed/simple;
	bh=Lsfg/ozjT8i9nkSo15K47TIz6EPEaPDkx5V9XoiL/Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvnNmE+OHmx2cfULrZn4luiol0CuerMmuKxNGBsvVdauhJRETMwXr6Mwx98aZX75say21hTlwHJbKGv3pDIhzV9LgrUFeBk06gwE7ViPzgrERKwgiLOgc1o04YemOR9UCMxM/Aqr19Q1F8gy9Geh6J9jwAR27Yc7UZqfIUFOiLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ODILG4jN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB82C32782;
	Tue, 30 Jul 2024 17:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722359759;
	bh=Lsfg/ozjT8i9nkSo15K47TIz6EPEaPDkx5V9XoiL/Dk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ODILG4jNlWkpyKCozlJiohXJ67bdVpWHOi00CjTWcx27UPENwH5yDPC8P8pLav+RA
	 eMwocxbJjCTUHN0LBk+3dyq/YhoPnvVEPujQhpoI2ZXN4DtoTNoctltOEpOdEy0e27
	 OJtYRNrBfFOoR1bK7HgLB9RfJsGVIlIg8A77Edcs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lance Richardson <rlance@google.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 532/568] dma: fix call order in dmam_free_coherent
Date: Tue, 30 Jul 2024 17:50:39 +0200
Message-ID: <20240730151700.949506082@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151639.792277039@linuxfoundation.org>
References: <20240730151639.792277039@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lance Richardson <rlance@google.com>

[ Upstream commit 28e8b7406d3a1f5329a03aa25a43aa28e087cb20 ]

dmam_free_coherent() frees a DMA allocation, which makes the
freed vaddr available for reuse, then calls devres_destroy()
to remove and free the data structure used to track the DMA
allocation. Between the two calls, it is possible for a
concurrent task to make an allocation with the same vaddr
and add it to the devres list.

If this happens, there will be two entries in the devres list
with the same vaddr and devres_destroy() can free the wrong
entry, triggering the WARN_ON() in dmam_match.

Fix by destroying the devres entry before freeing the DMA
allocation.

Tested:
  kokonut //net/encryption
    http://sponge2/b9145fe6-0f72-4325-ac2f-a84d81075b03

Fixes: 9ac7849e35f7 ("devres: device resource management")
Signed-off-by: Lance Richardson <rlance@google.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index e323ca48f7f2a..f1d9f01b283d7 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -67,8 +67,8 @@ void dmam_free_coherent(struct device *dev, size_t size, void *vaddr,
 {
 	struct dma_devres match_data = { size, vaddr, dma_handle };
 
-	dma_free_coherent(dev, size, vaddr, dma_handle);
 	WARN_ON(devres_destroy(dev, dmam_release, dmam_match, &match_data));
+	dma_free_coherent(dev, size, vaddr, dma_handle);
 }
 EXPORT_SYMBOL(dmam_free_coherent);
 
-- 
2.43.0





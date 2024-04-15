Return-Path: <stable+bounces-39647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3501C8A53F6
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 16:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C96EA1F20ECB
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 14:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2A47E576;
	Mon, 15 Apr 2024 14:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iYm99qB0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAEB7C090;
	Mon, 15 Apr 2024 14:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191395; cv=none; b=Izq+U2Y+YaSaSCLvW68mV9j8kFkz12pTcFR/j7fPwG2Deov8qEOqWlk4Y4RWiWRSHOHnFlMOpjbAFtIWCMaDS/b39tTFPDc4e5cHauVQFGdi1m0LaiBZ5o4qqnqLEXXQjW1UFjOwqpLpx3FizDP2HY0S4atqtMC5cOfoYPnkRQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191395; c=relaxed/simple;
	bh=wd12WuFFLglZ3Kks3sqbtvu16UtgWk+VzHKRKKEGUeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=orhV96utDOp2Q0Msg50bAwVmuPvL6irz/uGmWWo/3Eug6BI8PHXODZOX7deWou7uC39AzeqB34zdK/RDDoQOecCklb3f3z5OLxWyYSbRu5DhvbyQw0Y/n3vz4eRvA5wposfgYTouItJUgf6WrBswqYz3xZN/hxN6WxBnSrLykdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iYm99qB0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4270EC2BD10;
	Mon, 15 Apr 2024 14:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713191395;
	bh=wd12WuFFLglZ3Kks3sqbtvu16UtgWk+VzHKRKKEGUeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iYm99qB0dtFUS+MJEUSqfs//NgtMby5qXkNSwGxeurWtI91Jf8HxuXQGN76gbHCiA
	 cJoHaSF8yRrZp1kn+XrvTMm4kNCPaJATcIR4kserpetl/5oYpES7tJL2Q1RrCbwwzO
	 4IgiZHUvXMFJXDpn0VAFTcusHiZ0E9+8MF/JT8lg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Steven Price <steven.price@arm.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [PATCH 6.8 127/172] drm/panfrost: Fix the error path in panfrost_mmu_map_fault_addr()
Date: Mon, 15 Apr 2024 16:20:26 +0200
Message-ID: <20240415142004.243244225@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415141959.976094777@linuxfoundation.org>
References: <20240415141959.976094777@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boris Brezillon <boris.brezillon@collabora.com>

commit 1fc9af813b25e146d3607669247d0f970f5a87c3 upstream.

Subject: [PATCH 6.8 127/172] drm/panfrost: Fix the error path in panfrost_mmu_map_fault_addr()

If some the pages or sgt allocation failed, we shouldn't release the
pages ref we got earlier, otherwise we will end up with unbalanced
get/put_pages() calls. We should instead leave everything in place
and let the BO release function deal with extra cleanup when the object
is destroyed, or let the fault handler try again next time it's called.

Fixes: 187d2929206e ("drm/panfrost: Add support for GPU heap allocations")
Cc: <stable@vger.kernel.org>
Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Co-developed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240105184624.508603-18-dmitry.osipenko@collabora.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -502,11 +502,18 @@ static int panfrost_mmu_map_fault_addr(s
 	mapping_set_unevictable(mapping);
 
 	for (i = page_offset; i < page_offset + NUM_FAULT_PAGES; i++) {
+		/* Can happen if the last fault only partially filled this
+		 * section of the pages array before failing. In that case
+		 * we skip already filled pages.
+		 */
+		if (pages[i])
+			continue;
+
 		pages[i] = shmem_read_mapping_page(mapping, i);
 		if (IS_ERR(pages[i])) {
 			ret = PTR_ERR(pages[i]);
 			pages[i] = NULL;
-			goto err_pages;
+			goto err_unlock;
 		}
 	}
 
@@ -514,7 +521,7 @@ static int panfrost_mmu_map_fault_addr(s
 	ret = sg_alloc_table_from_pages(sgt, pages + page_offset,
 					NUM_FAULT_PAGES, 0, SZ_2M, GFP_KERNEL);
 	if (ret)
-		goto err_pages;
+		goto err_unlock;
 
 	ret = dma_map_sgtable(pfdev->dev, sgt, DMA_BIDIRECTIONAL, 0);
 	if (ret)
@@ -537,8 +544,6 @@ out:
 
 err_map:
 	sg_free_table(sgt);
-err_pages:
-	drm_gem_shmem_put_pages(&bo->base);
 err_unlock:
 	dma_resv_unlock(obj->resv);
 err_bo:




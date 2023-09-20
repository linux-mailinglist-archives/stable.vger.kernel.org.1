Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9207A7FC1
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235923AbjITMaP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236129AbjITMaJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:30:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E00499
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:30:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A992C433C8;
        Wed, 20 Sep 2023 12:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213003;
        bh=IMz9QKHvg7++5/Jfq1xdxfb0KptErvhtZpx9eNSB5DU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fe9/Zmm9DC8nD+dQnXaVQ+gSz5SxMrxDul1KgBQtOX1bmz7UPFd/mr6dwFoayiQob
         8w0IQUUATQItFMzl2HrnPApHdasWZhs3zJUKp3YJKR1GhMNoxQ/jSq0YfMl7G1XPXV
         rmTVXoqUgdZg/tzliuwg3hYGRuOGM0Mrsp2yKims=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lucas Stach <l.stach@pengutronix.de>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 097/367] drm/etnaviv: fix dumping of active MMU context
Date:   Wed, 20 Sep 2023 13:27:54 +0200
Message-ID: <20230920112901.064954914@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lucas Stach <l.stach@pengutronix.de>

[ Upstream commit 20faf2005ec85fa1a6acc9a74ff27de667f90576 ]

gpu->mmu_context is the MMU context of the last job in the HW queue, which
isn't necessarily the same as the context from the bad job. Dump the MMU
context from the scheduler determined bad submit to make it work as intended.

Fixes: 17e4660ae3d7 ("drm/etnaviv: implement per-process address spaces on MMUv2")
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Reviewed-by: Christian Gmeiner <christian.gmeiner@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/etnaviv/etnaviv_dump.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_dump.c b/drivers/gpu/drm/etnaviv/etnaviv_dump.c
index 648cf02073092..67901f4586a3f 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_dump.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_dump.c
@@ -125,9 +125,9 @@ void etnaviv_core_dump(struct etnaviv_gem_submit *submit)
 		return;
 	etnaviv_dump_core = false;
 
-	mutex_lock(&gpu->mmu_context->lock);
+	mutex_lock(&submit->mmu_context->lock);
 
-	mmu_size = etnaviv_iommu_dump_size(gpu->mmu_context);
+	mmu_size = etnaviv_iommu_dump_size(submit->mmu_context);
 
 	/* We always dump registers, mmu, ring, hanging cmdbuf and end marker */
 	n_obj = 5;
@@ -157,7 +157,7 @@ void etnaviv_core_dump(struct etnaviv_gem_submit *submit)
 	iter.start = __vmalloc(file_size, GFP_KERNEL | __GFP_NOWARN | __GFP_NORETRY,
 			       PAGE_KERNEL);
 	if (!iter.start) {
-		mutex_unlock(&gpu->mmu_context->lock);
+		mutex_unlock(&submit->mmu_context->lock);
 		dev_warn(gpu->dev, "failed to allocate devcoredump file\n");
 		return;
 	}
@@ -169,18 +169,18 @@ void etnaviv_core_dump(struct etnaviv_gem_submit *submit)
 	memset(iter.hdr, 0, iter.data - iter.start);
 
 	etnaviv_core_dump_registers(&iter, gpu);
-	etnaviv_core_dump_mmu(&iter, gpu->mmu_context, mmu_size);
+	etnaviv_core_dump_mmu(&iter, submit->mmu_context, mmu_size);
 	etnaviv_core_dump_mem(&iter, ETDUMP_BUF_RING, gpu->buffer.vaddr,
 			      gpu->buffer.size,
 			      etnaviv_cmdbuf_get_va(&gpu->buffer,
-					&gpu->mmu_context->cmdbuf_mapping));
+					&submit->mmu_context->cmdbuf_mapping));
 
 	etnaviv_core_dump_mem(&iter, ETDUMP_BUF_CMD,
 			      submit->cmdbuf.vaddr, submit->cmdbuf.size,
 			      etnaviv_cmdbuf_get_va(&submit->cmdbuf,
-					&gpu->mmu_context->cmdbuf_mapping));
+					&submit->mmu_context->cmdbuf_mapping));
 
-	mutex_unlock(&gpu->mmu_context->lock);
+	mutex_unlock(&submit->mmu_context->lock);
 
 	/* Reserve space for the bomap */
 	if (n_bomap_pages) {
-- 
2.40.1




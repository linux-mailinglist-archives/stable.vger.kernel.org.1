Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4AB77AC28
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjHMV37 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjHMV36 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:29:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D8F10D7
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:30:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27D3A62AFA
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:30:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32459C433C8;
        Sun, 13 Aug 2023 21:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962199;
        bh=1c003UIrmwbmOnqJEoUdtA7kUjJf+M/OnAgg2A3N10A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nWHpFKr296OQ4LIbhSex2DjVR4BDi21loZ/L0+WHnglNGZW8ddj0PcnsKTZpCQj2c
         a+VdbT37doF+P61RRH9vt4enSV681r3zFn0cX/MTwxp3r08zQU9mHPxL4yo/D3CfLg
         5lHhqIVhmCY2xDenxPK9JXRGrsjhX2u+vyc6AYAc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Artemy Kovalyov <artemyko@nvidia.com>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
Subject: [PATCH 6.4 149/206] RDMA/umem: Set iova in ODP flow
Date:   Sun, 13 Aug 2023 23:18:39 +0200
Message-ID: <20230813211729.297784327@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Michael Guralnik <michaelgur@nvidia.com>

commit 186b169cf1e4be85aa212a893ea783a543400979 upstream.

Fixing the ODP registration flow to set the iova correctly.
The calculation in ib_umem_num_dma_blocks() function assumes the iova of
the umem is set correctly.

When iova is not set, the calculation in ib_umem_num_dma_blocks() is
equivalent to length/page_size, which is true only when memory is aligned.
For unaligned memory, iova must be set for the ALIGN() in the
ib_umem_num_dma_blocks() to take effect and return a correct value.

mlx5_ib uses ib_umem_num_dma_blocks() to decide the mkey size to use for
the MR. Without this fix, when registering unaligned ODP MR, a wrong
size mkey might be chosen and this might cause the UMR to fail.

UMR would fail over insufficient size to update the mkey translation:
infiniband mlx5_0: dump_cqe:273:(pid 0): dump error cqe
00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000030: 00 00 00 00 0f 00 78 06 25 00 00 58 00 da ac d2
infiniband mlx5_0: mlx5_ib_post_send_wait:806:(pid 20311): reg umr
failed (6)
infiniband mlx5_0: pagefault_real_mr:661:(pid 20311): Failed to update
mkey page tables

Fixes: f0093fb1a7cb ("RDMA/mlx5: Move mlx5_ib_cont_pages() to the creation of the mlx5_ib_mr")
Fixes: a665aca89a41 ("RDMA/umem: Split ib_umem_num_pages() into ib_umem_num_dma_blocks()")
Signed-off-by: Artemy Kovalyov <artemyko@nvidia.com>
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Link: https://lore.kernel.org/r/3d4be7ca2155bf239dd8c00a2d25974a92c26ab8.1689757344.git.leon@kernel.org
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/umem.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -85,6 +85,8 @@ unsigned long ib_umem_find_best_pgsz(str
 	dma_addr_t mask;
 	int i;
 
+	umem->iova = va = virt;
+
 	if (umem->is_odp) {
 		unsigned int page_size = BIT(to_ib_umem_odp(umem)->page_shift);
 
@@ -100,7 +102,6 @@ unsigned long ib_umem_find_best_pgsz(str
 	 */
 	pgsz_bitmap &= GENMASK(BITS_PER_LONG - 1, PAGE_SHIFT);
 
-	umem->iova = va = virt;
 	/* The best result is the smallest page size that results in the minimum
 	 * number of required pages. Compute the largest page size that could
 	 * work based on VA address bits that don't change.



Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB786FAB6B
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbjEHLNO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbjEHLNJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:13:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B1835D9E
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:13:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3A7C62BA3
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:13:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50BCC433D2;
        Mon,  8 May 2023 11:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544381;
        bh=4BiHR3hB1YoPleLHf1FQeCEQHaDGuu20vKxU55AJZuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k2NC/EUuS1r38C8IX3uGc7K4Tqci2M1gcNO9OVwp3skM3IobFP9wJRl4qfey3KwWH
         e8YotF2Khc7WMGK8ppimGUHfZ/ile6iYJwtOC2LmF7twyGt99pHgN5KfIPLe+t1bVl
         R0T8tGHvis47QzFbY098698n2+ungeOX4QpK7/DY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kal Conley <kal.conley@dectris.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 392/694] xsk: Fix unaligned descriptor validation
Date:   Mon,  8 May 2023 11:43:47 +0200
Message-Id: <20230508094445.782654175@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Kal Conley <kal.conley@dectris.com>

[ Upstream commit d769ccaf957fe7391f357c0a923de71f594b8a2b ]

Make sure unaligned descriptors that straddle the end of the UMEM are
considered invalid. Currently, descriptor validation is broken for
zero-copy mode which only checks descriptors at page granularity.
For example, descriptors in zero-copy mode that overrun the end of the
UMEM but not a page boundary are (incorrectly) considered valid. The
UMEM boundary check needs to happen before the page boundary and
contiguity checks in xp_desc_crosses_non_contig_pg(). Do this check in
xp_unaligned_validate_desc() instead like xp_check_unaligned() already
does.

Fixes: 2b43470add8c ("xsk: Introduce AF_XDP buffer allocation API")
Signed-off-by: Kal Conley <kal.conley@dectris.com>
Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
Link: https://lore.kernel.org/r/20230405235920.7305-2-kal.conley@dectris.com
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/xsk_buff_pool.h | 9 ++-------
 net/xdp/xsk_queue.h         | 1 +
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index 3e952e5694188..d318c769b4454 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -180,13 +180,8 @@ static inline bool xp_desc_crosses_non_contig_pg(struct xsk_buff_pool *pool,
 	if (likely(!cross_pg))
 		return false;
 
-	if (pool->dma_pages_cnt) {
-		return !(pool->dma_pages[addr >> PAGE_SHIFT] &
-			 XSK_NEXT_PG_CONTIG_MASK);
-	}
-
-	/* skb path */
-	return addr + len > pool->addrs_cnt;
+	return pool->dma_pages_cnt &&
+	       !(pool->dma_pages[addr >> PAGE_SHIFT] & XSK_NEXT_PG_CONTIG_MASK);
 }
 
 static inline u64 xp_aligned_extract_addr(struct xsk_buff_pool *pool, u64 addr)
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index bfb2a7e50c261..66c6f57c9c447 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -162,6 +162,7 @@ static inline bool xp_unaligned_validate_desc(struct xsk_buff_pool *pool,
 		return false;
 
 	if (base_addr >= pool->addrs_cnt || addr >= pool->addrs_cnt ||
+	    addr + desc->len > pool->addrs_cnt ||
 	    xp_desc_crosses_non_contig_pg(pool, addr, desc->len))
 		return false;
 
-- 
2.39.2




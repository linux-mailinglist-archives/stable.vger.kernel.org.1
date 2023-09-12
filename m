Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2EF79B6ED
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350487AbjIKViv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239261AbjIKOP6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:15:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AAEDE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:15:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486F2C433C9;
        Mon, 11 Sep 2023 14:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441753;
        bh=7AH5LaGmsJin0v7cq7sxcSToM5LEt5kWImCq3MkXkmc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HBLrFUodwv1TvfLmCOGKwyULKEXNOgzZsipgQJQzOpxvuRCjMOYyKqnzi8Pixb8p8
         x22ZmfpYY0O6AVS3/3Ms5GnEHr/5n14/avrTXaxsG3DuVRq7Wc6pj+pY1M4WdP9n5b
         B39bBWeA45UEKynmPaIWhuC5I0qbH6xY96MoF3AY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 498/739] RDMA/irdma: Replace one-element array with flexible-array member
Date:   Mon, 11 Sep 2023 15:44:57 +0200
Message-ID: <20230911134705.036729071@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo A. R. Silva <gustavoars@kernel.org>

[ Upstream commit 38313c6d2a02c28162e06753b01bd885caf9386d ]

One-element and zero-length arrays are deprecated. So, replace
one-element array in struct irdma_qvlist_info with flexible-array
member.

A patch for this was sent a while ago[1]. However, it seems that, at
the time, the changes were partially folded[2][3], and the actual
flexible-array transformation was omitted. This patch fixes that.

The only binary difference seen before/after changes is shown below:

|  drivers/infiniband/hw/irdma/hw.o
| @@ -868,7 +868,7 @@
| drivers/infiniband/hw/irdma/hw.c:484 (discriminator 2)
|	size += struct_size(iw_qvlist, qv_info, rf->msix_count);
|      55b:      imul   $0x45c,%rdi,%rdi
|-     562:      add    $0x10,%rdi
|+     562:      add    $0x4,%rdi

which is, of course, expected as it reflects the mistake made
while folding the patch I've mentioned above.

Worth mentioning is the fact that with this change we save 12 bytes
of memory, as can be inferred from the diff snapshot above. Notice
that:

$ pahole -C rdma_qv_info idrivers/infiniband/hw/irdma/hw.o
struct irdma_qv_info {
	u32                        v_idx;                /*     0     4 */
	u16                        ceq_idx;              /*     4     2 */
	u16                        aeq_idx;              /*     6     2 */
	u8                         itr_idx;              /*     8     1 */

	/* size: 12, cachelines: 1, members: 4 */
	/* padding: 3 */
	/* last cacheline: 12 bytes */
};

Link: https://lore.kernel.org/linux-hardening/20210525230038.GA175516@embeddedor/ [1]
Link: https://lore.kernel.org/linux-hardening/bf46b428deef4e9e89b0ea1704b1f0e5@intel.com/ [2]
Link: https://lore.kernel.org/linux-rdma/20210520143809.819-1-shiraz.saleem@intel.com/T/#u [3]
Fixes: 44d9e52977a1 ("RDMA/irdma: Implement device initialization definitions")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Link: https://lore.kernel.org/r/ZMpsQrZadBaJGkt4@work
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/irdma/main.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index 2323962cdeacb..de2f4c0514118 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -239,7 +239,7 @@ struct irdma_qv_info {
 
 struct irdma_qvlist_info {
 	u32 num_vectors;
-	struct irdma_qv_info qv_info[1];
+	struct irdma_qv_info qv_info[];
 };
 
 struct irdma_gen_ops {
-- 
2.40.1




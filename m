Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E847A801E
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236162AbjITMdF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236174AbjITMdE (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:33:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFCCCE
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:32:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65CBBC433C8;
        Wed, 20 Sep 2023 12:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213178;
        bh=39frHKFj48Kblw3mUpWxVOAxzjg1y1cqxcW8FNavCmQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hIpGkfkJnaM8SFaJUlLiRrBQO70PTJJ8pHEqpCzFgp6c2r+ufD1iXugDY/dzbyD+e
         L0UvF9h0cZ7/AmWxKCTuAaXqQkk4jGtH3eWnehnd6kxL6M8AhVGrHhATlbm6//tbh+
         amfqpFwwl7zoKeE4XidClJsDclYJc4NpO8A44QcQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Guoqing Jiang <guoqing.jiang@linux.dev>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 190/367] RDMA/siw: Correct wrong debug message
Date:   Wed, 20 Sep 2023 13:29:27 +0200
Message-ID: <20230920112903.553410517@linuxfoundation.org>
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

From: Guoqing Jiang <guoqing.jiang@linux.dev>

[ Upstream commit bee024d20451e4ce04ea30099cad09f7f75d288b ]

We need to print num_sle first then pbl->max_buf per the condition.
Also replace mem->pbl with pbl while at it.

Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
Link: https://lore.kernel.org/r/20230821133255.31111-3-guoqing.jiang@linux.dev
Acked-by: Bernard Metzler <bmt@zurich.ibm.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/sw/siw/siw_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index c8c2014b79d22..236f9efaa75ce 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -1509,7 +1509,7 @@ int siw_map_mr_sg(struct ib_mr *base_mr, struct scatterlist *sl, int num_sle,
 
 	if (pbl->max_buf < num_sle) {
 		siw_dbg_mem(mem, "too many SGE's: %d > %d\n",
-			    mem->pbl->max_buf, num_sle);
+			    num_sle, pbl->max_buf);
 		return -ENOMEM;
 	}
 	for_each_sg(sl, slp, num_sle, i) {
-- 
2.40.1




Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8926FA91C
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbjEHKsH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235118AbjEHKrt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:47:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD742C3F4
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:47:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 978F9628DF
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:47:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB2FC4339B;
        Mon,  8 May 2023 10:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542827;
        bh=0y5fik3iuohyoHYC0Yzunl6vS+d3MfQ0KCVN9cPo5dE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CtIp86rnymyRnt7Y9kcwCheRDRJtMBcEAQEFdBCFqwDzaXdDcstSJtWUc1BSyRzE/
         VRfOnIcK7ycrdB3UOITIKeo+KgQ8PhSr9R5pDjYZR1qZj7X5QcWEPB4fe0v8KaAe/F
         ZUACGeGjkYYm6ZHPpBD8VvJ8ePGAo8oSgZRHvzVM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <error27@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 529/663] RDMA/mlx4: Prevent shift wrapping in set_user_sq_size()
Date:   Mon,  8 May 2023 11:45:55 +0200
Message-Id: <20230508094446.037577601@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dan Carpenter <error27@gmail.com>

[ Upstream commit d50b3c73f1ac20dabc53dc6e9d64ce9c79a331eb ]

The ucmd->log_sq_bb_count variable is controlled by the user so this
shift can wrap.  Fix it by using check_shl_overflow() in the same way
that it was done in commit 515f60004ed9 ("RDMA/hns: Prevent undefined
behavior in hns_roce_set_user_sq_size()").

Fixes: 839041329fd3 ("IB/mlx4: Sanity check userspace send queue sizes")
Signed-off-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/r/a8dfbd1d-c019-4556-930b-bab1ded73b10@kili.mountain
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx4/qp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index b17d6ebc5b705..488c906c0432c 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -412,9 +412,13 @@ static int set_user_sq_size(struct mlx4_ib_dev *dev,
 			    struct mlx4_ib_qp *qp,
 			    struct mlx4_ib_create_qp *ucmd)
 {
+	u32 cnt;
+
 	/* Sanity check SQ size before proceeding */
-	if ((1 << ucmd->log_sq_bb_count) > dev->dev->caps.max_wqes	 ||
-	    ucmd->log_sq_stride >
+	if (check_shl_overflow(1, ucmd->log_sq_bb_count, &cnt) ||
+	    cnt > dev->dev->caps.max_wqes)
+		return -EINVAL;
+	if (ucmd->log_sq_stride >
 		ilog2(roundup_pow_of_two(dev->dev->caps.max_sq_desc_sz)) ||
 	    ucmd->log_sq_stride < MLX4_IB_MIN_SQ_STRIDE)
 		return -EINVAL;
-- 
2.39.2




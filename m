Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5868976AE56
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbjHAJiM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbjHAJh3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:37:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C57E2139
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:35:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04AD6614DF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13092C433C7;
        Tue,  1 Aug 2023 09:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882544;
        bh=VNghHi08ay2I90ltuMo9NhGFydrdgAtYDXfdwayzGU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DLAFdf6DceneUdD3WNeeu8jtS2f3jmmMl4kJ8jGT8m4X39R2BwEfW6seA+6ImjCvs
         bh7buYlxovn4THB/u8ONvQxgFjzaNaHSO8Qn1PaUDCpJnGBt1JA8JSAHZqosGxsrV3
         HTqfMM1q35hGk+JpwGIDWN8FI6YFhNy48Ba0+yUE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 115/228] RDMA/mlx4: Make check for invalid flags stricter
Date:   Tue,  1 Aug 2023 11:19:33 +0200
Message-ID: <20230801091926.928816496@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit d64b1ee12a168030fbb3e0aebf7bce49e9a07589 ]

This code is trying to ensure that only the flags specified in the list
are allowed.  The problem is that ucmd->rx_hash_fields_mask is a u64 and
the flags are an enum which is treated as a u32 in this context.  That
means the test doesn't check whether the highest 32 bits are zero.

Fixes: 4d02ebd9bbbd ("IB/mlx4: Fix RSS hash fields restrictions")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/233ed975-982d-422a-b498-410f71d8a101@moroto.mountain
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx4/qp.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index 488c906c0432c..ac479e81ddee8 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -530,15 +530,15 @@ static int set_qp_rss(struct mlx4_ib_dev *dev, struct mlx4_ib_rss *rss_ctx,
 		return (-EOPNOTSUPP);
 	}
 
-	if (ucmd->rx_hash_fields_mask & ~(MLX4_IB_RX_HASH_SRC_IPV4	|
-					  MLX4_IB_RX_HASH_DST_IPV4	|
-					  MLX4_IB_RX_HASH_SRC_IPV6	|
-					  MLX4_IB_RX_HASH_DST_IPV6	|
-					  MLX4_IB_RX_HASH_SRC_PORT_TCP	|
-					  MLX4_IB_RX_HASH_DST_PORT_TCP	|
-					  MLX4_IB_RX_HASH_SRC_PORT_UDP	|
-					  MLX4_IB_RX_HASH_DST_PORT_UDP  |
-					  MLX4_IB_RX_HASH_INNER)) {
+	if (ucmd->rx_hash_fields_mask & ~(u64)(MLX4_IB_RX_HASH_SRC_IPV4	|
+					       MLX4_IB_RX_HASH_DST_IPV4	|
+					       MLX4_IB_RX_HASH_SRC_IPV6	|
+					       MLX4_IB_RX_HASH_DST_IPV6	|
+					       MLX4_IB_RX_HASH_SRC_PORT_TCP |
+					       MLX4_IB_RX_HASH_DST_PORT_TCP |
+					       MLX4_IB_RX_HASH_SRC_PORT_UDP |
+					       MLX4_IB_RX_HASH_DST_PORT_UDP |
+					       MLX4_IB_RX_HASH_INNER)) {
 		pr_debug("RX Hash fields_mask has unsupported mask (0x%llx)\n",
 			 ucmd->rx_hash_fields_mask);
 		return (-EOPNOTSUPP);
-- 
2.40.1




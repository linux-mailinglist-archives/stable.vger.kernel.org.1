Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC6B7758AF
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbjHIKzA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbjHIKyr (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:54:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3321D26B7
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:53:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5067163142
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:52:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0A1C433C8;
        Wed,  9 Aug 2023 10:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578340;
        bh=W8gTjz6JBWRo1z3n/Cjmmi/MrMHg5XQxAkz4MYEtOjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sQs+MEUBfOo+WzHXIIjmsGY7xl3m1k6Au52RRfz6tBc/QxxXvaNRaictxLa7cwTY4
         +PJQ1ku8apN2C4YB1cJO39aWSzyWgSel2KL8vy6cXHT7NGWeHpnTfwWKKtsLW6UI7S
         89fMsgBaVFg9AysSmD+K5Brxq9rjDLhNIBkn0hmM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhengchao Shao <shaozhengchao@huawei.com>,
        Simon Horman <simon.horman@corigine.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 024/127] net/mlx5: fix potential memory leak in mlx5e_init_rep_rx
Date:   Wed,  9 Aug 2023 12:40:11 +0200
Message-ID: <20230809103637.436814138@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.615294317@linuxfoundation.org>
References: <20230809103636.615294317@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Zhengchao Shao <shaozhengchao@huawei.com>

[ Upstream commit c6cf0b6097bf1bf1b2a89b521e9ecd26b581a93a ]

The memory pointed to by the priv->rx_res pointer is not freed in the error
path of mlx5e_init_rep_rx, which can lead to a memory leak. Fix by freeing
the memory in the error path, thereby making the error path identical to
mlx5e_cleanup_rep_rx().

Fixes: af8bbf730068 ("net/mlx5e: Convert mlx5e_flow_steering member of mlx5e_priv to pointer")
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 9bd1a93a512d4..ff0c025db1402 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -912,7 +912,7 @@ static int mlx5e_init_rep_rx(struct mlx5e_priv *priv)
 	err = mlx5e_open_drop_rq(priv, &priv->drop_rq);
 	if (err) {
 		mlx5_core_err(mdev, "open drop rq failed, %d\n", err);
-		return err;
+		goto err_rx_res_free;
 	}
 
 	err = mlx5e_rx_res_init(priv->rx_res, priv->mdev, 0,
@@ -946,6 +946,7 @@ static int mlx5e_init_rep_rx(struct mlx5e_priv *priv)
 	mlx5e_rx_res_destroy(priv->rx_res);
 err_close_drop_rq:
 	mlx5e_close_drop_rq(&priv->drop_rq);
+err_rx_res_free:
 	mlx5e_rx_res_free(priv->rx_res);
 	priv->rx_res = NULL;
 err_free_fs:
-- 
2.40.1




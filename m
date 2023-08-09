Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC76877589A
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbjHIKy3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbjHIKyF (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:54:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D533B47EE
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:52:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E59163149
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:52:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C496C433C8;
        Wed,  9 Aug 2023 10:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578337;
        bh=6WhjAG1T28u5DjVEQTAG3JW0y652XEj+QoODt3HW8o8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AD64zOFpEYliAXBdt9wHC6MCI+yI7DvwwdFhlYgtR3hjX6WP7iC1+eJCyaD6n/h36
         Hs1Jz1n3j6nMv4yiBS0t+KZVvk49bFKfkd3wWVaw/MLHOUV3tb4S5wLbIbcJawsmw1
         b2VhArxdRteKvvBSEot/WAixHBC73+/h9OuudiBU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhengchao Shao <shaozhengchao@huawei.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 023/127] net/mlx5: DR, fix memory leak in mlx5dr_cmd_create_reformat_ctx
Date:   Wed,  9 Aug 2023 12:40:10 +0200
Message-ID: <20230809103637.407899898@linuxfoundation.org>
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

[ Upstream commit 5dd77585dd9d0e03dd1bceb95f0269a7eaf6b936 ]

when mlx5_cmd_exec failed in mlx5dr_cmd_create_reformat_ctx, the memory
pointed by 'in' is not released, which will cause memory leak. Move memory
release after mlx5_cmd_exec.

Fixes: 1d9186476e12 ("net/mlx5: DR, Add direct rule command utilities")
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c
index 84364691a3791..d7b1a230b59e8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c
@@ -538,11 +538,12 @@ int mlx5dr_cmd_create_reformat_ctx(struct mlx5_core_dev *mdev,
 
 	err = mlx5_cmd_exec(mdev, in, inlen, out, sizeof(out));
 	if (err)
-		return err;
+		goto err_free_in;
 
 	*reformat_id = MLX5_GET(alloc_packet_reformat_context_out, out, packet_reformat_id);
-	kvfree(in);
 
+err_free_in:
+	kvfree(in);
 	return err;
 }
 
-- 
2.40.1




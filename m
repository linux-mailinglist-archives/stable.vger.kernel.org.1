Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C0F75D41C
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjGUTSF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbjGUTSE (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:18:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBDF3A81
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:17:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 831F361D96
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:17:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F163C433C7;
        Fri, 21 Jul 2023 19:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967072;
        bh=PpKYSH7zt/h6PgL18rq2cpJGVnwbNBV60ArGAvc48UU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PPrSz5HCjilwDntS9RgrKRU4lS3qre1BhaI/VcF7t0ncMZPu7x8QpWczVgQM88nVS
         XuWox8RQg4Nku6B8sy208HKMNX6JkOxPogtQpUD+kNSe7ubLdZMtg5Y0fXkCQP/4ml
         BS8p5KvA4p9TiWZgIfp7aF70KfWD+hMQ9Ix18meU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhengchao Shao <shaozhengchao@huawei.com>,
        Simon Horman <simon.horman@corigine.com>,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 017/223] net/mlx5e: fix memory leak in mlx5e_fs_tt_redirect_any_create
Date:   Fri, 21 Jul 2023 18:04:30 +0200
Message-ID: <20230721160521.613089605@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Zhengchao Shao <shaozhengchao@huawei.com>

[ Upstream commit 3250affdc658557a41df9c5fb567723e421f8bf2 ]

The memory pointed to by the fs->any pointer is not freed in the error
path of mlx5e_fs_tt_redirect_any_create, which can lead to a memory leak.
Fix by freeing the memory in the error path, thereby making the error path
identical to mlx5e_fs_tt_redirect_any_destroy().

Fixes: 0f575c20bf06 ("net/mlx5e: Introduce Flow Steering ANY API")
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c b/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
index 03cb79adf912f..be83ad9db82a4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
@@ -594,7 +594,7 @@ int mlx5e_fs_tt_redirect_any_create(struct mlx5e_flow_steering *fs)
 
 	err = fs_any_create_table(fs);
 	if (err)
-		return err;
+		goto err_free_any;
 
 	err = fs_any_enable(fs);
 	if (err)
@@ -606,8 +606,8 @@ int mlx5e_fs_tt_redirect_any_create(struct mlx5e_flow_steering *fs)
 
 err_destroy_table:
 	fs_any_destroy_table(fs_any);
-
-	kfree(fs_any);
+err_free_any:
 	mlx5e_fs_set_any(fs, NULL);
+	kfree(fs_any);
 	return err;
 }
-- 
2.39.2




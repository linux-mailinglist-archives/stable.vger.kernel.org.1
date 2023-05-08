Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6834A6FABB6
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbjEHLQj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235390AbjEHLQh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:16:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD00F3760D
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:16:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28EF962C07
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:16:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A4FC433EF;
        Mon,  8 May 2023 11:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544593;
        bh=fypwj02jBN7yXCq4UVjJSopEQ6EABI9dbKtZHRjOQ98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BAZKwOOIf8eYIhuGNKZmay5oZpl/+v2BQdx3p530swMklmNFFsqAcu0ncoKN9pmeX
         nj6OhgcMbnTZWDUFn6rqBrNIBzRZWWeyhlOsgDt+PSMw8CSy6lVpiEecLtRAOgEfU6
         cI3/GpBmx3sZxOF9TMDxtjGEDH6xKtU769/ylc5w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vlad Buslov <vladbu@nvidia.com>,
        Roi Dayan <roid@nvidia.com>, Paul Blakey <paulb@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 461/694] net/mlx5e: Release the label when replacing existing ct entry
Date:   Mon,  8 May 2023 11:44:56 +0200
Message-Id: <20230508094448.648462427@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Vlad Buslov <vladbu@nvidia.com>

[ Upstream commit 8ac04a28144cfa89b61be518268233742c23d88d ]

Cited commit doesn't release the label mapping when replacing existing ct
entry which leads to following memleak report:

unreferenced object 0xffff8881854cf280 (size 96):
  comm "kworker/u48:74", pid 23093, jiffies 4296664564 (age 175.944s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000002722d368>] __kmalloc+0x4b/0x1c0
    [<00000000cc44e18f>] mapping_add+0x6e8/0xc90 [mlx5_core]
    [<000000003ad942a7>] mlx5_get_label_mapping+0x66/0xe0 [mlx5_core]
    [<00000000266308ac>] mlx5_tc_ct_entry_create_mod_hdr+0x1c4/0xf50 [mlx5_core]
    [<000000009a768b4f>] mlx5_tc_ct_entry_add_rule+0x16f/0xaf0 [mlx5_core]
    [<00000000a178f3e5>] mlx5_tc_ct_block_flow_offload_add+0x10cb/0x1f90 [mlx5_core]
    [<000000007b46c496>] mlx5_tc_ct_block_flow_offload+0x14a/0x630 [mlx5_core]
    [<00000000a9a18ac5>] nf_flow_offload_tuple+0x1a3/0x390 [nf_flow_table]
    [<00000000d0881951>] flow_offload_work_handler+0x257/0xd30 [nf_flow_table]
    [<000000009e4935a4>] process_one_work+0x7c2/0x13e0
    [<00000000f5cd36a7>] worker_thread+0x59d/0xec0
    [<00000000baed1daf>] kthread+0x28f/0x330
    [<0000000063d282a4>] ret_from_fork+0x1f/0x30

Fix the issue by correctly releasing the label mapping.

Fixes: 94ceffb48eac ("net/mlx5e: Implement CT entry update")
Signed-off-by: Vlad Buslov <vladbu@nvidia.com>
Reviewed-by: Roi Dayan <roid@nvidia.com>
Reviewed-by: Paul Blakey <paulb@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
index 314983bc6f085..ee49bd2461e46 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
@@ -920,6 +920,7 @@ mlx5_tc_ct_entry_replace_rule(struct mlx5_tc_ct_priv *ct_priv,
 	zone_rule->rule = rule;
 	mlx5_tc_ct_entry_destroy_mod_hdr(ct_priv, old_attr, zone_rule->mh);
 	zone_rule->mh = mh;
+	mlx5_put_label_mapping(ct_priv, old_attr->ct_attr.ct_labels_id);
 
 	kfree(old_attr);
 	kvfree(spec);
-- 
2.39.2




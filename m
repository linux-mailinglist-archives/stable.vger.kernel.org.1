Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4CE73E8FD
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbjFZSb0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbjFZSbI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:31:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B467926A9
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:30:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAD0260F4E
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:30:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27B6C433C9;
        Mon, 26 Jun 2023 18:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804253;
        bh=kQ/c/9y3pvo8knkXdUpR1gRtoLueUemBMgTPCK4nB78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2AABF1Pn4z3MuAJglqjzicUXun4nOrctVLrDlJwLhxSNPDnuLmjG/7BD3s+IVx9+F
         BTPoFBJc8/v7d84G08wU5ofvpPZRzmY5EUl/DwiGDLlDV09FKU41kRYZWt3S/5hdPP
         XSaPa3QrhCBaIJfw8k0inX0tC/pR/M/dkM3gHj8o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yevgeny Kliteynik <kliteyn@nvidia.com>,
        Alex Vesker <valex@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 094/170] net/mlx5: DR, Fix wrong action data allocation in decap action
Date:   Mon, 26 Jun 2023 20:11:03 +0200
Message-ID: <20230626180804.787426960@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
References: <20230626180800.476539630@linuxfoundation.org>
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

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

[ Upstream commit ef4c5afc783dc3d47640270a9b94713229c697e8 ]

When TUNNEL_L3_TO_L2 decap action was created, a pointer to a local
variable was passed as its HW action data, resulting in attempt to
free invalid address:

  BUG: KASAN: invalid-free in mlx5dr_action_destroy+0x318/0x410 [mlx5_core]

Fixes: 4781df92f4da ("net/mlx5: DR, Move STEv0 modify header logic")
Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Alex Vesker <valex@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/mellanox/mlx5/core/steering/dr_action.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c
index b1dfad274a39e..a3e7602b044e5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c
@@ -1200,9 +1200,13 @@ dr_action_create_reformat_action(struct mlx5dr_domain *dmn,
 	}
 	case DR_ACTION_TYP_TNL_L3_TO_L2:
 	{
-		u8 hw_actions[ACTION_CACHE_LINE_SIZE] = {};
+		u8 *hw_actions;
 		int ret;
 
+		hw_actions = kzalloc(ACTION_CACHE_LINE_SIZE, GFP_KERNEL);
+		if (!hw_actions)
+			return -ENOMEM;
+
 		ret = mlx5dr_ste_set_action_decap_l3_list(dmn->ste_ctx,
 							  data, data_sz,
 							  hw_actions,
@@ -1210,6 +1214,7 @@ dr_action_create_reformat_action(struct mlx5dr_domain *dmn,
 							  &action->rewrite->num_of_actions);
 		if (ret) {
 			mlx5dr_dbg(dmn, "Failed creating decap l3 action list\n");
+			kfree(hw_actions);
 			return ret;
 		}
 
@@ -1217,6 +1222,7 @@ dr_action_create_reformat_action(struct mlx5dr_domain *dmn,
 								DR_CHUNK_SIZE_8);
 		if (!action->rewrite->chunk) {
 			mlx5dr_dbg(dmn, "Failed allocating modify header chunk\n");
+			kfree(hw_actions);
 			return -ENOMEM;
 		}
 
@@ -1230,6 +1236,7 @@ dr_action_create_reformat_action(struct mlx5dr_domain *dmn,
 		if (ret) {
 			mlx5dr_dbg(dmn, "Writing decap l3 actions to ICM failed\n");
 			mlx5dr_icm_free_chunk(action->rewrite->chunk);
+			kfree(hw_actions);
 			return ret;
 		}
 		return 0;
-- 
2.39.2




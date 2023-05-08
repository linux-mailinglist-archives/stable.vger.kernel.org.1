Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B236FABB8
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235401AbjEHLQt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235378AbjEHLQr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:16:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CC23703F
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:16:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78F4462BEC
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:16:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8453DC433D2;
        Mon,  8 May 2023 11:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544599;
        bh=Gs3XflwxLToaEsf+Liax7wQxJGi4ptvOVx0qYKfXPy4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tf6ttDcl51I8bA6/6cB/v1WjpRRAH7KldcG19QNzENkd02lqpupNx/YSfeFLteFbg
         x9iZR1T+aeWSBOwFY8g7t9NTEK66lCf2hQzoCExM3DWYHW9tFLwqbXiitlqBlXFxaI
         iuUKk6EJRbXk4+uxVf+3Fsv6RhHKVc+IlrHc2oTM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chris Mi <cmi@nvidia.com>,
        Roi Dayan <roid@nvidia.com>, Maor Dickman <maord@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 463/694] net/mlx5: E-switch, Dont destroy indirect table in split rule
Date:   Mon,  8 May 2023 11:44:58 +0200
Message-Id: <20230508094448.732358480@linuxfoundation.org>
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

From: Chris Mi <cmi@nvidia.com>

[ Upstream commit 4c8189302567f75099a336b0efcff8291ec86ff4 ]

Source port rewrite (forward to ovs internal port or statck device) isn't
supported in the rule of split action. So there is no indirect table in
split rule. The cited commit destroyes indirect table in split rule. The
indirect table for other rules will be destroyed wrongly. It will cause
traffic loss.

Fix it by removing the destroy function in split rule. And also remove
the destroy function in error flow.

Fixes: 10742efc20a4 ("net/mlx5e: VF tunnel TX traffic offloading")
Signed-off-by: Chris Mi <cmi@nvidia.com>
Reviewed-by: Roi Dayan <roid@nvidia.com>
Reviewed-by: Maor Dickman <maord@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 706746cd10af5..c99d208722f58 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -760,7 +760,6 @@ mlx5_eswitch_add_fwd_rule(struct mlx5_eswitch *esw,
 	kfree(dest);
 	return rule;
 err_chain_src_rewrite:
-	esw_put_dest_tables_loop(esw, attr, 0, i);
 	mlx5_esw_vporttbl_put(esw, &fwd_attr);
 err_get_fwd:
 	mlx5_chains_put_table(chains, attr->chain, attr->prio, 0);
@@ -803,7 +802,6 @@ __mlx5_eswitch_del_rule(struct mlx5_eswitch *esw,
 	if (fwd_rule)  {
 		mlx5_esw_vporttbl_put(esw, &fwd_attr);
 		mlx5_chains_put_table(chains, attr->chain, attr->prio, 0);
-		esw_put_dest_tables_loop(esw, attr, 0, esw_attr->split_count);
 	} else {
 		if (split)
 			mlx5_esw_vporttbl_put(esw, &fwd_attr);
-- 
2.39.2




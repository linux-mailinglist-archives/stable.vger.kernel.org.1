Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6A16FABBE
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbjEHLRB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbjEHLRA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:17:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F45B32348
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:16:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7CA462C09
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:16:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BABABC433D2;
        Mon,  8 May 2023 11:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544618;
        bh=RgT8d/fI58ByLNU70uHPNTEYayy68ag2MuLm2uSZaYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l8DClqs+0qfOEK4jBLyFfILiWBWNfW/Tpa9jeNQgJ+/kTWgJJtD8savt5wOpZ8IM+
         dclixiBmDOGQl2F7acnsnrejqWo/y1f6R7JUOL/8xbgsNOKTdvl0Xyrdj1+HCggNws
         pw0KxpOHnnwETmjkogRxHY97isOqHMpG3gUGsFgY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Aya Levin <ayal@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 468/694] net/mlx5e: Nullify table pointer when failing to create
Date:   Mon,  8 May 2023 11:45:03 +0200
Message-Id: <20230508094448.935996963@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Aya Levin <ayal@nvidia.com>

[ Upstream commit 1b540decd03acd736693aabb6cb46c71fca38ae6 ]

On failing to create promisc flow steering table, the pointer is
returned with an error. Nullify it so unloading the driver won't try to
destroy a non existing table.

Failing to create promisc table may happen over BF devices when the ARM
side is going through a firmware tear down. The host side start a
reload flow. While the driver unloads, it tries to remove the promisc
table. Remove WARN in this state as it is a valid error flow.

Fixes: 1c46d7409f30 ("net/mlx5e: Optimize promiscuous mode")
Signed-off-by: Aya Levin <ayal@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_fs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
index f1dac0244958c..33bfe4d7338be 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
@@ -783,6 +783,7 @@ static int mlx5e_create_promisc_table(struct mlx5e_flow_steering *fs)
 	ft->t = mlx5_create_auto_grouped_flow_table(fs->ns, &ft_attr);
 	if (IS_ERR(ft->t)) {
 		err = PTR_ERR(ft->t);
+		ft->t = NULL;
 		fs_err(fs, "fail to create promisc table err=%d\n", err);
 		return err;
 	}
@@ -810,7 +811,7 @@ static void mlx5e_del_promisc_rule(struct mlx5e_flow_steering *fs)
 
 static void mlx5e_destroy_promisc_table(struct mlx5e_flow_steering *fs)
 {
-	if (WARN(!fs->promisc.ft.t, "Trying to remove non-existing promiscuous table"))
+	if (!fs->promisc.ft.t)
 		return;
 	mlx5e_del_promisc_rule(fs);
 	mlx5_destroy_flow_table(fs->promisc.ft.t);
-- 
2.39.2




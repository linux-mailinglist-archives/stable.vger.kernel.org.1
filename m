Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D465C7352C7
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjFSKiI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbjFSKh5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:37:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D6010E4
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:37:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55E6160B42
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:37:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8AAC433C8;
        Mon, 19 Jun 2023 10:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171074;
        bh=r8R8F2KSXz7B3mK9NmRbbDeZxrHfN5wa2GOHumcC+tw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aD1iH1hE1WEXBkR4C+i8+K49aT+JOdEpqql33JxdRFodF8ZcAcch9Wy+c/ib0kHgK
         i+XxgfoNCPNMSloDvDkVBHAeZdyGw70ji6C0ksC4BuUbbCT75TbXdnI5GcPmVO5unI
         BnWBC5+dXEA6ZVuz6ESgRllnHQOC7BPX1jPSlR1o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Maher Sanalla <msanalla@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 139/187] RDMA/mlx5: Initiate dropless RQ for RAW Ethernet functions
Date:   Mon, 19 Jun 2023 12:29:17 +0200
Message-ID: <20230619102204.366052265@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
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

From: Maher Sanalla <msanalla@nvidia.com>

[ Upstream commit ee4d269eccfea6c17b18281bef482700d898e86f ]

Delay drop data is initiated for PFs that have the capability of
rq_delay_drop and are in roce profile.

However, PFs with RAW ethernet profile do not initiate delay drop data
on function load, causing kernel panic if delay drop struct members are
accessed later on in case a dropless RQ is created.

Thus, stage the delay drop initialization as part of RAW ethernet
PF loading process.

Fixes: b5ca15ad7e61 ("IB/mlx5: Add proper representors support")
Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Link: https://lore.kernel.org/r/2e9d386785043d48c38711826eb910315c1de141.1685960567.git.leon@kernel.org
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 5d45de223c43a..f0b394ed7452a 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4275,6 +4275,9 @@ const struct mlx5_ib_profile raw_eth_profile = {
 	STAGE_CREATE(MLX5_IB_STAGE_POST_IB_REG_UMR,
 		     mlx5_ib_stage_post_ib_reg_umr_init,
 		     NULL),
+	STAGE_CREATE(MLX5_IB_STAGE_DELAY_DROP,
+		     mlx5_ib_stage_delay_drop_init,
+		     mlx5_ib_stage_delay_drop_cleanup),
 	STAGE_CREATE(MLX5_IB_STAGE_RESTRACK,
 		     mlx5_ib_restrack_init,
 		     NULL),
-- 
2.39.2




Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05331775760
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjHIKpR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjHIKpQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:45:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BCA1702
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:45:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 937FC63118
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:45:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF59C433C7;
        Wed,  9 Aug 2023 10:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691577915;
        bh=oMVLknb+rM/ouJa/crUSOWQO2lP8iOZc7yqmIWO8yq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xd8GGCQB8+yneRyO8x48sXBkX2RpuxEfNjiXKg+Y+K5sYGSsng+lb00vIuSdHGmb7
         LJflKNYNQDVCUJjqQ/X7Yjnf7v5OrbWHTbS5woIzSY5u1tERf85RvsiBBdgUSFbBwk
         3xB+4T4Ub+zXTLI9SidM1dH6CaN0ViBdteQk0kfI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shay Drory <shayd@nvidia.com>,
        Roi Dayan <roid@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 032/165] net/mlx5: Honor user input for migratable port fn attr
Date:   Wed,  9 Aug 2023 12:39:23 +0200
Message-ID: <20230809103643.869738302@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
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

From: Shay Drory <shayd@nvidia.com>

[ Upstream commit 0507f2c8be0d345fe7014147c027cea6dc1c00a4 ]

Currently, whenever a user is setting migratable port fn attr, the
driver is always turn migratable capability on.
Fix it by honor the user input

Fixes: e5b9642a33be ("net/mlx5: E-Switch, Implement devlink port function cmds to control migratable")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Roi Dayan <roid@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 8d19c20d3447e..178880ba7c7b3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -4073,7 +4073,7 @@ int mlx5_devlink_port_fn_migratable_set(struct devlink_port *port, bool enable,
 	}
 
 	hca_caps = MLX5_ADDR_OF(query_hca_cap_out, query_ctx, capability);
-	MLX5_SET(cmd_hca_cap_2, hca_caps, migratable, 1);
+	MLX5_SET(cmd_hca_cap_2, hca_caps, migratable, enable);
 
 	err = mlx5_vport_set_other_func_cap(esw->dev, hca_caps, vport->vport,
 					    MLX5_SET_HCA_CAP_OP_MOD_GENERAL_DEVICE2);
-- 
2.40.1




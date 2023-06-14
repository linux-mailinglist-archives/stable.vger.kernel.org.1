Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB34719E09
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbjFAN20 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbjFAN2L (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:28:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149491A1
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:27:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E07BB644EC
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:27:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FDBC433D2;
        Thu,  1 Jun 2023 13:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685626073;
        bh=CjvYxRR58wZbkTSnAWdbO1Zkt6+g0LBERQVs85dpOkc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kptNDJP0XMgT3cEZwlAJ0sbToVzGJLokvlbbFeFLFK85xRZis0WWsJ7UqknbQMP78
         iLXcH6cr+6UbA6cHRRk18uoLMnamrJfrzGSnKwlMJ3njIHhf+XVvyFds+BgpzKHfaS
         XZNksKC+YOsLO3jRwzxpH770xma45/3UjJpeFS9s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shay Drory <shayd@nvidia.com>,
        Mark Bloch <mbloch@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 12/42] net/mlx5: E-switch, Devcom, sync devcom events and devcom comp register
Date:   Thu,  1 Jun 2023 14:21:21 +0100
Message-Id: <20230601131939.600837561@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131939.051934720@linuxfoundation.org>
References: <20230601131939.051934720@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Shay Drory <shayd@nvidia.com>

[ Upstream commit 8c253dfc89efde6b5faddf9e7400e5d17884e042 ]

devcom events are sent to all registered component. Following the
cited patch, it is possible for two components, e.g.: two eswitches,
to send devcom events, while both components are registered. This
means eswitch layer will do double un/pairing, which is double
allocation and free of resources, even though only one un/pairing is
needed. flow example:

	cpu0					cpu1
	----					----

 mlx5_devlink_eswitch_mode_set(dev0)
  esw_offloads_devcom_init()
   mlx5_devcom_register_component(esw0)
                                         mlx5_devlink_eswitch_mode_set(dev1)
                                          esw_offloads_devcom_init()
                                           mlx5_devcom_register_component(esw1)
                                           mlx5_devcom_send_event()
   mlx5_devcom_send_event()

Hence, check whether the eswitches are already un/paired before
free/allocation of resources.

Fixes: 09b278462f16 ("net: devlink: enable parallel ops on netlink interface")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h        | 1 +
 .../net/ethernet/mellanox/mlx5/core/eswitch_offloads.c   | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 821c78bab3732..a3daca44f74b1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -340,6 +340,7 @@ struct mlx5_eswitch {
 	}  params;
 	struct blocking_notifier_head n_head;
 	struct dentry *dbgfs;
+	bool paired[MLX5_MAX_PORTS];
 };
 
 void esw_offloads_disable(struct mlx5_eswitch *esw);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 5235b5a7b9637..433cdd0a2cf34 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2827,6 +2827,9 @@ static int mlx5_esw_offloads_devcom_event(int event,
 		    mlx5_eswitch_vport_match_metadata_enabled(peer_esw))
 			break;
 
+		if (esw->paired[mlx5_get_dev_index(peer_esw->dev)])
+			break;
+
 		err = mlx5_esw_offloads_set_ns_peer(esw, peer_esw, true);
 		if (err)
 			goto err_out;
@@ -2838,14 +2841,18 @@ static int mlx5_esw_offloads_devcom_event(int event,
 		if (err)
 			goto err_pair;
 
+		esw->paired[mlx5_get_dev_index(peer_esw->dev)] = true;
+		peer_esw->paired[mlx5_get_dev_index(esw->dev)] = true;
 		mlx5_devcom_set_paired(devcom, MLX5_DEVCOM_ESW_OFFLOADS, true);
 		break;
 
 	case ESW_OFFLOADS_DEVCOM_UNPAIR:
-		if (!mlx5_devcom_is_paired(devcom, MLX5_DEVCOM_ESW_OFFLOADS))
+		if (!esw->paired[mlx5_get_dev_index(peer_esw->dev)])
 			break;
 
 		mlx5_devcom_set_paired(devcom, MLX5_DEVCOM_ESW_OFFLOADS, false);
+		esw->paired[mlx5_get_dev_index(peer_esw->dev)] = false;
+		peer_esw->paired[mlx5_get_dev_index(esw->dev)] = false;
 		mlx5_esw_offloads_unpair(peer_esw);
 		mlx5_esw_offloads_unpair(esw);
 		mlx5_esw_offloads_set_ns_peer(esw, peer_esw, false);
-- 
2.39.2




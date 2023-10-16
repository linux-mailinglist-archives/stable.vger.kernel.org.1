Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9CC7CA2EB
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbjJPI5l (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbjJPI5j (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:57:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793EEF3
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:57:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE99C433C7;
        Mon, 16 Oct 2023 08:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446656;
        bh=wZmF9/bE6ac9pu9qCkH+R4JVinUx6vHdn54QepN4QtQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jk9B6w/3/YScIvQfep6se9yVoH2PdPSmxPbMSkLO09Plta5f4BAoeWGeYTeMMhPrY
         OkGml9fND95Q+IlSnIaD40Dwvt8aPijIqz5E2azaso/DNce/X0ZtHPv7iImsBKw/Yj
         +QHPWNrC9NIrV+3AK1O7bN0WywGEZ1Q81CFf0BFA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Charlotte Tan <charlotte@extrahop.com>,
        Adham Faris <afaris@nvidia.com>, Aya Levin <ayal@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Will Mortensen <will@extrahop.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 060/131] net/mlx5e: Again mutually exclude RX-FCS and RX-port-timestamp
Date:   Mon, 16 Oct 2023 10:40:43 +0200
Message-ID: <20231016084001.560169385@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084000.050926073@linuxfoundation.org>
References: <20231016084000.050926073@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Mortensen <will@extrahop.com>

[ Upstream commit da6192ca72d5ad913d109d43dc896290ad05d98f ]

Commit 1e66220948df8 ("net/mlx5e: Update rx ring hw mtu upon each rx-fcs
flag change") seems to have accidentally inverted the logic added in
commit 0bc73ad46a76 ("net/mlx5e: Mutually exclude RX-FCS and
RX-port-timestamp").

The impact of this is a little unclear since it seems the FCS scattered
with RX-FCS is (usually?) correct regardless.

Fixes: 1e66220948df8 ("net/mlx5e: Update rx ring hw mtu upon each rx-fcs flag change")
Tested-by: Charlotte Tan <charlotte@extrahop.com>
Reviewed-by: Charlotte Tan <charlotte@extrahop.com>
Cc: Adham Faris <afaris@nvidia.com>
Cc: Aya Levin <ayal@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>
Cc: Moshe Shemesh <moshe@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Will Mortensen <will@extrahop.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://lore.kernel.org/r/20231006053706.514618-1-will@extrahop.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 4e7daa382bc05..42e6f2fcf5f59 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3862,13 +3862,14 @@ static int set_feature_rx_fcs(struct net_device *netdev, bool enable)
 	struct mlx5e_channels *chs = &priv->channels;
 	struct mlx5e_params new_params;
 	int err;
+	bool rx_ts_over_crc = !enable;
 
 	mutex_lock(&priv->state_lock);
 
 	new_params = chs->params;
 	new_params.scatter_fcs_en = enable;
 	err = mlx5e_safe_switch_params(priv, &new_params, mlx5e_set_rx_port_ts_wrap,
-				       &new_params.scatter_fcs_en, true);
+				       &rx_ts_over_crc, true);
 	mutex_unlock(&priv->state_lock);
 	return err;
 }
-- 
2.40.1




Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C697CAC08
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbjJPOs4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbjJPOsx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:48:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF4BED
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:48:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DAE3C433C7;
        Mon, 16 Oct 2023 14:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697467731;
        bh=drPmrXrfaXFdu8ziIbycDxRZQm7JZTpRhqmDeScoqtY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZNKCQusbBvL8ctbutWkElp1ldFYa2uqTuaVUVrzKd54knlyHJC2e9qTjL3HL2zV2B
         OKA7gvuZ0P/a5LVaj2pl3CJAECkzVvU9YLqX6tJo3iojfrCwY+yDxrtzfjDtgDOOUl
         8ze0jkGqdXOGtWFqZ+4X31lbQTNsO3rwPIfpGT50=
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
Subject: [PATCH 6.5 078/191] net/mlx5e: Again mutually exclude RX-FCS and RX-port-timestamp
Date:   Mon, 16 Oct 2023 10:41:03 +0200
Message-ID: <20231016084017.225837513@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

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
index f7b494125eee8..0cbe822ab084f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3952,13 +3952,14 @@ static int set_feature_rx_fcs(struct net_device *netdev, bool enable)
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




Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECFF726B0C
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbjFGUWL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbjFGUWA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:22:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EC52139
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:21:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2823B643A1
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:21:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A687C433EF;
        Wed,  7 Jun 2023 20:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169292;
        bh=6GEBGYH06qSMLwQTvR9JPM2nTVrE0SRb3Ucot2ZY2W0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZJh3ZAtnYB7p9vbrc3WefXM6P5GhDKuNUtOPZJu4vS1G3znOTPZR6h+tUARfTUi4F
         sUBdx4IV5XR7IOITjxX2u3FbJQKnUryHs+e16pqgmLcIWNt2vy2dxkYBDQYKLRo8yk
         wTxtyOs/JxE8l7+VsguxD1tTLPz6hNbhEhZy0XmA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Maher Sanalla <msanalla@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 025/286] net/mlx5e: Do not update SBCM when prio2buffer command is invalid
Date:   Wed,  7 Jun 2023 22:12:04 +0200
Message-ID: <20230607200923.842531529@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Maher Sanalla <msanalla@nvidia.com>

[ Upstream commit 623efc4cbd6115db36716e31037cb6d1f3ce6754 ]

The shared buffer pools configuration which are stored in the SBCM
register are updated when the user changes the prio2buffer mapping.

However, in case the user desired prio2buffer change is invalid,
which can occur due to mapping a lossless priority to a not large enough
buffer, the SBCM update should not be performed, as the user command is
failed.

Thus, Perform the SBCM update only after xoff threshold calculation is
performed and the user prio2buffer mapping is validated.

Fixes: a440030d8946 ("net/mlx5e: Update shared buffer along with device buffer changes")
Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
index 0d78527451bca..7e8e96cc5cd08 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
@@ -442,11 +442,11 @@ static int update_buffer_lossy(struct mlx5_core_dev *mdev,
 	}
 
 	if (changed) {
-		err = port_update_pool_cfg(mdev, port_buffer);
+		err = update_xoff_threshold(port_buffer, xoff, max_mtu, port_buff_cell_sz);
 		if (err)
 			return err;
 
-		err = update_xoff_threshold(port_buffer, xoff, max_mtu, port_buff_cell_sz);
+		err = port_update_pool_cfg(mdev, port_buffer);
 		if (err)
 			return err;
 
-- 
2.39.2




Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76114726B40
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbjFGUYL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbjFGUXh (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:23:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9386C2688
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:23:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A331861046
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:23:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A68C433D2;
        Wed,  7 Jun 2023 20:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169395;
        bh=ALUFDKssxiiSBzr4fBpMY3zQLySp7hE5A1qxvAHmTAM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JKPnzjaCAgsZ1RaTMM+QvgnnxogWFExZESJ20fn0a9462FS/vIeIqQ4Cji2YcWq3y
         CFWkRmijO0BvJp6k7LxkfUip6t7WxX7rk5ksEZnnf4ij0g5vataeCAh/PO8Nfb1hVo
         NlOgn9JvUvuxka9DJ8pa4U63aDWJBbgI97AZdpJk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Moshe Shemesh <moshe@nvidia.com>,
        Shay Drory <shayd@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 063/286] net/mlx5: Read embedded cpu after init bit cleared
Date:   Wed,  7 Jun 2023 22:12:42 +0200
Message-ID: <20230607200925.126324261@linuxfoundation.org>
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

From: Moshe Shemesh <moshe@nvidia.com>

[ Upstream commit bbfa4b58997e3d38ba629c9f6fc0bd1c163aaf43 ]

During driver load it reads embedded_cpu bit from initialization
segment, but the initialization segment is readable only after
initialization bit is cleared.

Move the call to mlx5_read_embedded_cpu() right after initialization bit
cleared.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Fixes: 591905ba9679 ("net/mlx5: Introduce Mellanox SmartNIC and modify page management logic")
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 504179dbff9dd..9058fa8c5b657 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -913,7 +913,6 @@ static int mlx5_pci_init(struct mlx5_core_dev *dev, struct pci_dev *pdev,
 	}
 
 	mlx5_pci_vsc_init(dev);
-	dev->caps.embedded_cpu = mlx5_read_embedded_cpu(dev);
 	return 0;
 
 err_clr_master:
@@ -1147,6 +1146,7 @@ static int mlx5_function_setup(struct mlx5_core_dev *dev, bool boot, u64 timeout
 		goto err_cmd_cleanup;
 	}
 
+	dev->caps.embedded_cpu = mlx5_read_embedded_cpu(dev);
 	mlx5_cmd_set_state(dev, MLX5_CMDIF_STATE_UP);
 
 	mlx5_start_health_poll(dev);
-- 
2.39.2




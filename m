Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B2F713FA4
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjE1Tra (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbjE1Tr3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:47:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475DA9C
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:47:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9ADC61FBB
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:47:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02127C433EF;
        Sun, 28 May 2023 19:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685303248;
        bh=glwm0XPTDE45ot7si0Nl9OnZg9KN1zzQXht50iLz8QQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gehD9KmlY3dq6WiRBx/x3n8UkuMCi/jDE0FgHzaBZCNdSyxepMxeWH2KvDI1vMP/r
         7wA1nvlUJ0Ms7hYM/ilSmm4+IBdu4jCkndjZ96VIHGbDZYfd6xEwG618dARfaNOSEQ
         pCyFqHHFTpYlUyVkw+tYfmpWIn0pZNuITUgfnkR0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Roi Dayan <roid@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH 5.10 207/211] net/mlx5: Fix error message when failing to allocate device memory
Date:   Sun, 28 May 2023 20:12:08 +0100
Message-Id: <20230528190848.635537214@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190843.514829708@linuxfoundation.org>
References: <20230528190843.514829708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Roi Dayan <roid@nvidia.com>

commit a65735148e0328f80c0f72f9f8d2f609bfcf4aff upstream.

Fix spacing for the error and also the correct error code pointer.

Fixes: c9b9dcb430b3 ("net/mlx5: Move device memory management to mlx5_core")
Signed-off-by: Roi Dayan <roid@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -887,7 +887,7 @@ static int mlx5_init_once(struct mlx5_co
 
 	dev->dm = mlx5_dm_create(dev);
 	if (IS_ERR(dev->dm))
-		mlx5_core_warn(dev, "Failed to init device memory%d\n", err);
+		mlx5_core_warn(dev, "Failed to init device memory %ld\n", PTR_ERR(dev->dm));
 
 	dev->tracer = mlx5_fw_tracer_create(dev);
 	dev->hv_vhca = mlx5_hv_vhca_create(dev);



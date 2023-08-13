Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A3277AC45
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbjHMVbQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbjHMVbP (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:31:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FA3171F
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:31:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B17B62B46
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:31:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696E8C433C7;
        Sun, 13 Aug 2023 21:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962269;
        bh=NoUPcJ4FOvoxtzYCXNMFtSK+3nWoNyjlq+PvalwjL8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l39Mx9sMq2kuE1p7ERl2N/TPxWMj5k7Ty2CoDPowpIQsWy09ca5tUswYMn5zxw0+j
         jONIx8t2+k97MF0EXzDTc2k2QZI8oCt9Gd3O0cFfF/YQbV8y3lK4WopHka0J5bNzT5
         ObYPSOjuPf3a0Z7lHh3QyuQbjjzPWHpD4QExFBrI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Moshe Shemesh <moshe@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH 6.4 174/206] net/mlx5: Reload auxiliary devices in pci error handlers
Date:   Sun, 13 Aug 2023 23:19:04 +0200
Message-ID: <20230813211730.003796740@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Moshe Shemesh <moshe@nvidia.com>

commit aab8e1a200b926147db51e3f82fd07bb9edf6a98 upstream.

Handling pci errors should fully teardown and load back auxiliary
devices, same as done through mlx5 health recovery flow.

Fixes: 72ed5d5624af ("net/mlx5: Suspend auxiliary devices only in case of PCI device suspend")
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1845,7 +1845,7 @@ static pci_ers_result_t mlx5_pci_err_det
 
 	mlx5_enter_error_state(dev, false);
 	mlx5_error_sw_reset(dev);
-	mlx5_unload_one(dev, true);
+	mlx5_unload_one(dev, false);
 	mlx5_drain_health_wq(dev);
 	mlx5_pci_disable_device(dev);
 



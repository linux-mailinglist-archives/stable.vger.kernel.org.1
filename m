Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46506783259
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjHUUHV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjHUUHV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:07:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B2411C
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:07:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53F88649A1
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:07:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62AE4C433C7;
        Mon, 21 Aug 2023 20:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648438;
        bh=4QnqED9HyCmTPU9FpVcVZEjLMg3SGtTLBBbUlIDLS4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lhMZhmJhAm344UyQ3gYymKZhK/o3MVfWQZ5BhZKcdSFXHm3Fnj7M1HK24zNNJbdZ8
         DRx0i0LRLMoWms5SjndL5l/ki7p8jfcUXNNFYSErZSecb0YENctKaaRzgjv+ZnMhzv
         1yfKeKDGeECSf6CWFqCMgTPavHu3XugSqyTSxcrA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Martin Habets <habetsm.xilinx@gmail.com>,
        Edward Cree <ecree.xilinx@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 175/234] sfc: dont fail probe if MAE/TC setup fails
Date:   Mon, 21 Aug 2023 21:42:18 +0200
Message-ID: <20230821194136.579148912@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
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

From: Edward Cree <ecree.xilinx@gmail.com>

[ Upstream commit 54c9016eb8eda55952a195b071359cd13f50ed9b ]

Existing comment in the source explains why we don't want efx_init_tc()
 failure to be fatal.  Cited commit erroneously consolidated failure
 paths causing the probe to be failed in this case.

Fixes: 7e056e2360d9 ("sfc: obtain device mac address based on firmware handle for ef100")
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
Link: https://lore.kernel.org/r/aa7f589dd6028bd1ad49f0a85f37ab33c09b2b45.1692114888.git.ecree.xilinx@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/sfc/ef100_nic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/ef100_nic.c b/drivers/net/ethernet/sfc/ef100_nic.c
index 7adde9639c8ab..35d8e9811998d 100644
--- a/drivers/net/ethernet/sfc/ef100_nic.c
+++ b/drivers/net/ethernet/sfc/ef100_nic.c
@@ -1194,7 +1194,7 @@ int ef100_probe_netdev_pf(struct efx_nic *efx)
 		net_dev->features |= NETIF_F_HW_TC;
 		efx->fixed_features |= NETIF_F_HW_TC;
 	}
-	return rc;
+	return 0;
 }
 
 int ef100_probe_vf(struct efx_nic *efx)
-- 
2.40.1




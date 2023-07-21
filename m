Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D9475D206
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjGUSzS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbjGUSzQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:55:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C9B3588
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:55:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DFDF61D85
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:55:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201AFC433C8;
        Fri, 21 Jul 2023 18:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965712;
        bh=kBBCz2VdiSpBqjeYxDsaGBZfXxd8rCTORJWfmZw1ZtA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ahUAMBUH7XUkNBoVZiLgC9uI7MWFvTWRnoARaGFz4VBJKxz2BXlF1Jq1f+hev5mly
         yEznPvLCV36lRVb0SsiNc+rsszmT8vC9dHlGzN4X6jK93V5QSdqHF3sbgraID9oTg1
         e910D1RorlYoAhCMckhtMwaoqSJCMZyKLg1z1R9s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
        Edward Cree <ecree.xilinx@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 087/532] sfc: fix crash when reading stats while NIC is resetting
Date:   Fri, 21 Jul 2023 17:59:51 +0200
Message-ID: <20230721160619.297347470@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
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

From: Edward Cree <ecree.xilinx@gmail.com>

[ Upstream commit d1b355438b8325a486f087e506d412c4e852f37b ]

efx_net_stats() (.ndo_get_stats64) can be called during an ethtool
 selftest, during which time nic_data->mc_stats is NULL as the NIC has
 been fini'd.  In this case do not attempt to fetch the latest stats
 from the hardware, else we will crash on a NULL dereference:
    BUG: kernel NULL pointer dereference, address: 0000000000000038
    RIP efx_nic_update_stats
    abridged calltrace:
    efx_ef10_update_stats_pf
    efx_net_stats
    dev_get_stats
    dev_seq_printf_stats
Skipping the read is safe, we will simply give out stale stats.
To ensure that the free in efx_ef10_fini_nic() does not race against
 efx_ef10_update_stats_pf(), which could cause a TOCTTOU bug, take the
 efx->stats_lock in fini_nic (it is already held across update_stats).

Fixes: d3142c193dca ("sfc: refactor EF10 stats handling")
Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/sfc/ef10.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
index 302b97c2e617c..b20dbda37c7ef 100644
--- a/drivers/net/ethernet/sfc/ef10.c
+++ b/drivers/net/ethernet/sfc/ef10.c
@@ -1297,8 +1297,10 @@ static void efx_ef10_fini_nic(struct efx_nic *efx)
 {
 	struct efx_ef10_nic_data *nic_data = efx->nic_data;
 
+	spin_lock_bh(&efx->stats_lock);
 	kfree(nic_data->mc_stats);
 	nic_data->mc_stats = NULL;
+	spin_unlock_bh(&efx->stats_lock);
 }
 
 static int efx_ef10_init_nic(struct efx_nic *efx)
@@ -1852,9 +1854,14 @@ static size_t efx_ef10_update_stats_pf(struct efx_nic *efx, u64 *full_stats,
 
 	efx_ef10_get_stat_mask(efx, mask);
 
-	efx_nic_copy_stats(efx, nic_data->mc_stats);
-	efx_nic_update_stats(efx_ef10_stat_desc, EF10_STAT_COUNT,
-			     mask, stats, nic_data->mc_stats, false);
+	/* If NIC was fini'd (probably resetting), then we can't read
+	 * updated stats right now.
+	 */
+	if (nic_data->mc_stats) {
+		efx_nic_copy_stats(efx, nic_data->mc_stats);
+		efx_nic_update_stats(efx_ef10_stat_desc, EF10_STAT_COUNT,
+				     mask, stats, nic_data->mc_stats, false);
+	}
 
 	/* Update derived statistics */
 	efx_nic_fix_nodesc_drop_stat(efx,
-- 
2.39.2




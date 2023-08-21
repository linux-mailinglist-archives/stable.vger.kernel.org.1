Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F1F78338A
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjHUT5c (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjHUT5c (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:57:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F5FCF
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:57:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAEE76466C
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:57:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC65FC433C7;
        Mon, 21 Aug 2023 19:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647850;
        bh=63DoUM+Q+NylRYkPzqYnb/TaawSHcakRxY876FWY4AI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uxv6oB00QRxs7xVPfGT3yz6Exa/fGYr6zPnLyGIpZOY+WXd2mWzQgO+cXKLg30xMi
         qWZS3NUKL9Mfeq81iUoF7AqO5WmfeN0+4SRs8aBna0M7/OZf9ffM3c+kEHvPNdyJQB
         B7TziKvwvpUOHb9LqQvOa87/ZIjtJEdyCpnIlvoY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
        Martin Habets <habetsm.xilinx@gmail.com>,
        Edward Cree <ecree.xilinx@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 130/194] sfc: dont unregister flow_indr if it was never registered
Date:   Mon, 21 Aug 2023 21:41:49 +0200
Message-ID: <20230821194128.411508114@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
References: <20230821194122.695845670@linuxfoundation.org>
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

[ Upstream commit fa165e1949976704500a442faeef8d9596faee76 ]

In efx_init_tc(), move the setting of efx->tc->up after the
 flow_indr_dev_register() call, so that if it fails, efx_fini_tc()
 won't call flow_indr_dev_unregister().

Fixes: 5b2e12d51bd8 ("sfc: bind indirect blocks for TC offload on EF100")
Suggested-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
Link: https://lore.kernel.org/r/a81284d7013aba74005277bd81104e4cfbea3f6f.1692114888.git.ecree.xilinx@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/sfc/tc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/tc.c b/drivers/net/ethernet/sfc/tc.c
index 3478860d40232..d312147cd2dd7 100644
--- a/drivers/net/ethernet/sfc/tc.c
+++ b/drivers/net/ethernet/sfc/tc.c
@@ -603,10 +603,10 @@ int efx_init_tc(struct efx_nic *efx)
 	rc = efx_tc_configure_rep_mport(efx);
 	if (rc)
 		return rc;
-	efx->tc->up = true;
 	rc = flow_indr_dev_register(efx_tc_indr_setup_cb, efx);
 	if (rc)
 		return rc;
+	efx->tc->up = true;
 	return 0;
 }
 
-- 
2.40.1




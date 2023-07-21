Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA9275CD63
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjGUQKo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbjGUQKl (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:10:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5BD3580
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:10:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2ECD261D2F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:10:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7F7C433C7;
        Fri, 21 Jul 2023 16:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689955835;
        bh=2Uo47Zc3XQibxdcPYOIpL5UY4BRvbicfap1abjn2qHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YNW16ba9EL5FF5TE0HglM0/KgrcSBOMNGTcB7oD5TWfv1aAoQdlvOtoc3NERqVifA
         5fHXMB4sx2qDgnkS6b19E+K/5H2UduNZNVPeZG9sxx1lGvRiU2sQuOELTN3pUpWqto
         aH66HVo5/7nceNk+JwrnW7SyuXMlTBWhh3wusAZE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
        Sasha Neftin <sasha.neftin@intel.com>,
        Naama Meir <naamax.meir@linux.intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 022/292] igc: Remove delay during TX ring configuration
Date:   Fri, 21 Jul 2023 18:02:11 +0200
Message-ID: <20230721160529.757236987@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>

[ Upstream commit cca28ceac7c7857bc2d313777017585aef00bcc4 ]

Remove unnecessary delay during the TX ring configuration.
This will cause delay, especially during link down and
link up activity.

Furthermore, old SKUs like as I225 will call the reset_adapter
to reset the controller during TSN mode Gate Control List (GCL)
setting. This will add more time to the configuration of the
real-time use case.

It doesn't mentioned about this delay in the Software User Manual.
It might have been ported from legacy code I210 in the past.

Fixes: 13b5b7fd6a4a ("igc: Add support for Tx/Rx rings")
Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Acked-by: Sasha Neftin <sasha.neftin@intel.com>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index a8815ccf7887d..b131c8f2b03df 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -711,7 +711,6 @@ static void igc_configure_tx_ring(struct igc_adapter *adapter,
 	/* disable the queue */
 	wr32(IGC_TXDCTL(reg_idx), 0);
 	wrfl();
-	mdelay(10);
 
 	wr32(IGC_TDLEN(reg_idx),
 	     ring->count * sizeof(union igc_adv_tx_desc));
-- 
2.39.2




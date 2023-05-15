Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86EDD703A85
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244748AbjEORv6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244667AbjEORve (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:51:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABD91641A
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:49:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9045F62F39
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:49:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79043C4339B;
        Mon, 15 May 2023 17:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172969;
        bh=q+bnfdVHnWeGEdCphvB7BmzYlC0PZTsd1sXXUYDMRrg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UuUNncBb6yqdu6mYzn05YEtaN6U26CSFDc8nxmZ8/HBEB1at75Zg6ZcAKN21rFWLa
         mIkwPRgPSUpcurTRTEZuIRgsYQvcMWJdscnd32MpCqL+WXePJ+SAgUpNqjQYY3dKmz
         GAPZ7F7A6mw0bEd4NODLjWr+Fg/0RzsTQbj7MAO4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Subbaraya Sundeep <sbhatta@marvell.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Sai Krishna <saikrishnag@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 318/381] octeontx2-pf: Disable packet I/O for graceful exit
Date:   Mon, 15 May 2023 18:29:29 +0200
Message-Id: <20230515161751.168291627@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Subbaraya Sundeep <sbhatta@marvell.com>

[ Upstream commit c926252205c424c4842dbdbe02f8e3296f623204 ]

At the stage of enabling packet I/O in otx2_open, If mailbox
timeout occurs then interface ends up in down state where as
hardware packet I/O is enabled. Hence disable packet I/O also
before bailing out.

Fixes: 1ea0166da050 ("octeontx2-pf: Fix the device state on error")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 161174be51c31..54aeb276b9a0a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1589,11 +1589,20 @@ int otx2_open(struct net_device *netdev)
 	otx2_config_pause_frm(pf);
 
 	err = otx2_rxtx_enable(pf, true);
-	if (err)
+	/* If a mbox communication error happens at this point then interface
+	 * will end up in a state such that it is in down state but hardware
+	 * mcam entries are enabled to receive the packets. Hence disable the
+	 * packet I/O.
+	 */
+	if (err == EIO)
+		goto err_disable_rxtx;
+	else if (err)
 		goto err_tx_stop_queues;
 
 	return 0;
 
+err_disable_rxtx:
+	otx2_rxtx_enable(pf, false);
 err_tx_stop_queues:
 	netif_tx_stop_all_queues(netdev);
 	netif_carrier_off(netdev);
-- 
2.39.2




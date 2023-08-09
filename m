Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECCF7758CA
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjHIKzZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbjHIKzM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:55:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D139B359B
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:53:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C25F630F7
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:53:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA468C433C8;
        Wed,  9 Aug 2023 10:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578430;
        bh=CP+m6OiCvJjydhiiP8VVZY25lYLszjj7A3Kya1sc5mI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0Ba4PGxFdw5pItb3fgsBjtheOJDfyd0rswlytj9rhQuPFWyRTpeYz1o5eY7TUuD5v
         FF12tS6kmZc68k9TfkOnv3U/nq7IWzrpxIHf1seSPE1C6X/DZ4fjvBkbSfrCbASDYd
         AA21DorgSD2UoZc4BTeNcO393ld9aK8utf4ImnbY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Ajit Khaparde <ajit.khaparde@broadcom.com>,
        Andy Gospodarek <andrew.gospodarek@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 056/127] bnxt_en: Fix max_mtu setting for multi-buf XDP
Date:   Wed,  9 Aug 2023 12:40:43 +0200
Message-ID: <20230809103638.536365979@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.615294317@linuxfoundation.org>
References: <20230809103636.615294317@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Michael Chan <michael.chan@broadcom.com>

[ Upstream commit 08450ea98ae98d5a35145b675b76db616046ea11 ]

The existing code does not allow the MTU to be set to the maximum even
after an XDP program supporting multiple buffers is attached.  Fix it
to set the netdev->max_mtu to the maximum value if the attached XDP
program supports mutiple buffers, regardless of the current MTU value.

Also use a local variable dev instead of repeatedly using bp->dev.

Fixes: 1dc4c557bfed ("bnxt: adding bnxt_xdp_build_skb to build skb from multibuffer xdp_buff")
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Link: https://lore.kernel.org/r/20230731142043.58855-3-michael.chan@broadcom.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 9bd18c2b10bc6..969db3c45d176 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4027,26 +4027,29 @@ void bnxt_set_ring_params(struct bnxt *bp)
  */
 int bnxt_set_rx_skb_mode(struct bnxt *bp, bool page_mode)
 {
+	struct net_device *dev = bp->dev;
+
 	if (page_mode) {
 		bp->flags &= ~BNXT_FLAG_AGG_RINGS;
 		bp->flags |= BNXT_FLAG_RX_PAGE_MODE;
 
-		if (bp->dev->mtu > BNXT_MAX_PAGE_MODE_MTU) {
+		if (bp->xdp_prog->aux->xdp_has_frags)
+			dev->max_mtu = min_t(u16, bp->max_mtu, BNXT_MAX_MTU);
+		else
+			dev->max_mtu =
+				min_t(u16, bp->max_mtu, BNXT_MAX_PAGE_MODE_MTU);
+		if (dev->mtu > BNXT_MAX_PAGE_MODE_MTU) {
 			bp->flags |= BNXT_FLAG_JUMBO;
 			bp->rx_skb_func = bnxt_rx_multi_page_skb;
-			bp->dev->max_mtu =
-				min_t(u16, bp->max_mtu, BNXT_MAX_MTU);
 		} else {
 			bp->flags |= BNXT_FLAG_NO_AGG_RINGS;
 			bp->rx_skb_func = bnxt_rx_page_skb;
-			bp->dev->max_mtu =
-				min_t(u16, bp->max_mtu, BNXT_MAX_PAGE_MODE_MTU);
 		}
 		bp->rx_dir = DMA_BIDIRECTIONAL;
 		/* Disable LRO or GRO_HW */
-		netdev_update_features(bp->dev);
+		netdev_update_features(dev);
 	} else {
-		bp->dev->max_mtu = bp->max_mtu;
+		dev->max_mtu = bp->max_mtu;
 		bp->flags &= ~BNXT_FLAG_RX_PAGE_MODE;
 		bp->rx_dir = DMA_FROM_DEVICE;
 		bp->rx_skb_func = bnxt_rx_skb;
-- 
2.40.1




Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1969B775788
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjHIKrJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbjHIKrI (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:47:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC4C1999
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:47:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CA146283F
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:47:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6726CC433C8;
        Wed,  9 Aug 2023 10:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578026;
        bh=rgXARWS0v2Kq5MFa99LkyTR3FnjA8SLOM9iXsKzygFo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RLeQI+jK02j7hnlXddx8obRfHxRP0TgvWtUhbmPDr2EXruypKo/9sdJqQfxY6lbGg
         9cj0AHXKId6n5QrGyoRSAlfk//deRA1e0t/0Tp5/jUhSQ48eWvgbbwo+o3GFx8twi6
         f+a4JO/Ll3nDDA5xSfx/Hq42bsNMwXuQ0QIAlSVI=
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
Subject: [PATCH 6.4 080/165] bnxt_en: Fix max_mtu setting for multi-buf XDP
Date:   Wed,  9 Aug 2023 12:40:11 +0200
Message-ID: <20230809103645.418075600@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
index 81ed3744fa330..e481960cb6c7a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4005,26 +4005,29 @@ void bnxt_set_ring_params(struct bnxt *bp)
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




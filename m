Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539537A8051
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235916AbjITMgc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234920AbjITMga (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:36:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA73D7
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:36:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63966C433C7;
        Wed, 20 Sep 2023 12:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213381;
        bh=7i6aRFZ+LwbJPrsKWj5j+/wae6p9Zi+v4RplqkoS5pg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OacczKRQklZIoLyGAk1tWtKyMz6IStQddPT7fgLwuNF2JSwzQVO4QpW4fXhCyg/CO
         8gPdk3i4BTk9lBk8oC6R/suY2BabqQqWlqDf+eDOyeYRxDMlC5Ek8RZxX0fIZEfew5
         seg64bT2QLD4MGW7rLJ9kIAARDYFOvmgqBBJphTs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Manfred Rudigier <manfred.rudigier@omicronenergy.com>,
        Radoslaw Tyl <radoslawx.tyl@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Arpana Arland <arpanax.arland@intel.com>
Subject: [PATCH 5.4 209/367] igb: set max size RX buffer when store bad packet is enabled
Date:   Wed, 20 Sep 2023 13:29:46 +0200
Message-ID: <20230920112904.020925422@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Radoslaw Tyl <radoslawx.tyl@intel.com>

commit bb5ed01cd2428cd25b1c88a3a9cba87055eb289f upstream.

Increase the RX buffer size to 3K when the SBP bit is on. The size of
the RX buffer determines the number of pages allocated which may not
be sufficient for receive frames larger than the set MTU size.

Cc: stable@vger.kernel.org
Fixes: 89eaefb61dc9 ("igb: Support RX-ALL feature flag.")
Reported-by: Manfred Rudigier <manfred.rudigier@omicronenergy.com>
Signed-off-by: Radoslaw Tyl <radoslawx.tyl@intel.com>
Tested-by: Arpana Arland <arpanax.arland@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/igb/igb_main.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -4552,6 +4552,10 @@ void igb_configure_rx_ring(struct igb_ad
 static void igb_set_rx_buffer_len(struct igb_adapter *adapter,
 				  struct igb_ring *rx_ring)
 {
+#if (PAGE_SIZE < 8192)
+	struct e1000_hw *hw = &adapter->hw;
+#endif
+
 	/* set build_skb and buffer size flags */
 	clear_ring_build_skb_enabled(rx_ring);
 	clear_ring_uses_large_buffer(rx_ring);
@@ -4562,10 +4566,9 @@ static void igb_set_rx_buffer_len(struct
 	set_ring_build_skb_enabled(rx_ring);
 
 #if (PAGE_SIZE < 8192)
-	if (adapter->max_frame_size <= IGB_MAX_FRAME_BUILD_SKB)
-		return;
-
-	set_ring_uses_large_buffer(rx_ring);
+	if (adapter->max_frame_size > IGB_MAX_FRAME_BUILD_SKB ||
+	    rd32(E1000_RCTL) & E1000_RCTL_SBP)
+		set_ring_uses_large_buffer(rx_ring);
 #endif
 }
 



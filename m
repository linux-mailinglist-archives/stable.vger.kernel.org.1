Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A060779BC7C
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237767AbjIKUvo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240922AbjIKO5V (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:57:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E079E4D
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:57:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A673BC433C9;
        Mon, 11 Sep 2023 14:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444237;
        bh=mFMSycq9IJytNpYNtyEGbV4HumCD/fxmfGoTJ2sWbjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ebwIRkzEvUrkvYC/mzE/LS27hm1H/4Zf4bFYgUWsF0DCJLNx43ayIv4Nx+B3DWz+g
         bsVOHbECbYofOVi/29W8+gX/aOl0qtXKGfpTqL81U0xAZhGEI1n4264bffLY4ndA4P
         wUyrf3gJVoYoDbZWhWVgufQbj4PUoZWi2YlOqsQU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Manfred Rudigier <manfred.rudigier@omicronenergy.com>,
        Radoslaw Tyl <radoslawx.tyl@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Arpana Arland <arpanax.arland@intel.com>
Subject: [PATCH 6.4 641/737] igb: set max size RX buffer when store bad packet is enabled
Date:   Mon, 11 Sep 2023 15:48:20 +0200
Message-ID: <20230911134708.435025709@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4812,6 +4812,10 @@ void igb_configure_rx_ring(struct igb_ad
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
@@ -4822,10 +4826,9 @@ static void igb_set_rx_buffer_len(struct
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
 



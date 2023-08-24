Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E6C7879B4
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 22:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242136AbjHXUxy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 16:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243609AbjHXUxh (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 16:53:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506EB1993;
        Thu, 24 Aug 2023 13:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692910416; x=1724446416;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RNGUkWJz6u5noM4ESetkFS5Pzq1ZqTjYb+tKjWixtDY=;
  b=A/hgeheb0SqGADT4IfrgU2tfrYH/udmgcLAw2aVXj1CDawGraR3NEHfR
   eK4Dpy+Slx6BrbJSjpRtRJ6vLEtohmJTWOqoAMGbUUHQMLLJvtWEj3L+W
   PDAEm1QsKRBQgKLRX6fgefGfnGHqIBeziJ5ZiKYjXQgHS8Yk+V+F3dvoM
   O5LvDM7Bla7S5Zlo36Lg4I2dKrj85OT9NkyjGReBdtaKVgyyO7ytuRvgM
   zShrVZ3e0IEY7OjoUM8ohhxcZEqIMxgfpZevtxw37FG+cW900Mr0F2/c4
   0Q3ep7AyE2fiqL/U0u6mY02OA1k7F8ygLr11AYZhNg9Aa4YnIPWX4gV5y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="373432415"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="373432415"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 13:53:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="807278188"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="807278188"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga004.fm.intel.com with ESMTP; 24 Aug 2023 13:53:35 -0700
From:   Tony Nguyen <anthony.l.nguyen@intel.com>
To:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        edumazet@google.com, netdev@vger.kernel.org
Cc:     Radoslaw Tyl <radoslawx.tyl@intel.com>, anthony.l.nguyen@intel.com,
        greearb@candelatech.com, jesse.brandeburg@intel.com,
        stable@vger.kernel.org,
        Manfred Rudigier <manfred.rudigier@omicronenergy.com>,
        Arpana Arland <arpanax.arland@intel.com>
Subject: [PATCH net] igb: set max size RX buffer when store bad packet is enabled
Date:   Thu, 24 Aug 2023 13:46:19 -0700
Message-Id: <20230824204619.1551135-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Radoslaw Tyl <radoslawx.tyl@intel.com>

Increase the RX buffer size to 3K when the SBP bit is on. The size of
the RX buffer determines the number of pages allocated which may not
be sufficient for receive frames larger than the set MTU size.

Cc: stable@vger.kernel.org
Fixes: 89eaefb61dc9 ("igb: Support RX-ALL feature flag.")
Reported-by: Manfred Rudigier <manfred.rudigier@omicronenergy.com>
Signed-off-by: Radoslaw Tyl <radoslawx.tyl@intel.com>
Tested-by: Arpana Arland <arpanax.arland@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 9a2561409b06..08e3df37089f 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -4814,6 +4814,10 @@ void igb_configure_rx_ring(struct igb_adapter *adapter,
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
@@ -4824,10 +4828,9 @@ static void igb_set_rx_buffer_len(struct igb_adapter *adapter,
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
 
-- 
2.38.1


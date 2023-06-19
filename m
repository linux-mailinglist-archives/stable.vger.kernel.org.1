Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53B173552E
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 13:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjFSLCZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 07:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbjFSLBt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 07:01:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0593F1BD3
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 04:00:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97C5F60BAD
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 11:00:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA616C433C8;
        Mon, 19 Jun 2023 11:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687172456;
        bh=Da95ZFAVIBu741+Syw+NCttQga/Q7FPZRyL46lP2kSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=unKliayv2rUl4SYlQ+hh4LEOh8VQQ1wNnnnJvjvG1XuMRNC42xrqEYC+SA6dkjFBa
         ooInIn7rCL5I7V7ge1G2ITemtsiOcZctgRgTehuFPd04gKZ0cX9JWdkNAfm9gsIZYy
         f9KZEgsEx4qZ74JluAdqdL038XIa2vDEiMERsyjY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ahmed Zaki <ahmed.zaki@intel.com>,
        Rafal Romanowski <rafal.romanowski@intel.com>,
        Simon Horman <simon.horman@corigine.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 074/107] iavf: remove mask from iavf_irq_enable_queues()
Date:   Mon, 19 Jun 2023 12:30:58 +0200
Message-ID: <20230619102144.981971874@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102141.541044823@linuxfoundation.org>
References: <20230619102141.541044823@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ahmed Zaki <ahmed.zaki@intel.com>

[ Upstream commit c37cf54c12cfaa51e7aaf88708167b0d3259e64e ]

Enable more than 32 IRQs by removing the u32 bit mask in
iavf_irq_enable_queues(). There is no need for the mask as there are no
callers that select individual IRQs through the bitmask. Also, if the PF
allocates more than 32 IRQs, this mask will prevent us from using all of
them.

Modify the comment in iavf_register.h to show that the maximum number
allowed for the IRQ index is 63 as per the iAVF standard 1.0 [1].

link: [1] https://www.intel.com/content/dam/www/public/us/en/documents/product-specifications/ethernet-adaptive-virtual-function-hardware-spec.pdf
Fixes: 5eae00c57f5e ("i40evf: main driver core")
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Link: https://lore.kernel.org/r/20230608200226.451861-1-anthony.l.nguyen@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/iavf/iavf.h          |  2 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c     | 15 ++++++---------
 drivers/net/ethernet/intel/iavf/iavf_register.h |  2 +-
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 99d2b090a1e61..478a292ac803b 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -461,7 +461,7 @@ void iavf_set_ethtool_ops(struct net_device *netdev);
 void iavf_update_stats(struct iavf_adapter *adapter);
 void iavf_reset_interrupt_capability(struct iavf_adapter *adapter);
 int iavf_init_interrupt_scheme(struct iavf_adapter *adapter);
-void iavf_irq_enable_queues(struct iavf_adapter *adapter, u32 mask);
+void iavf_irq_enable_queues(struct iavf_adapter *adapter);
 void iavf_free_all_tx_resources(struct iavf_adapter *adapter);
 void iavf_free_all_rx_resources(struct iavf_adapter *adapter);
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 3b62f37b3cf14..a3caab0b6fa2a 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -253,21 +253,18 @@ static void iavf_irq_disable(struct iavf_adapter *adapter)
 }
 
 /**
- * iavf_irq_enable_queues - Enable interrupt for specified queues
+ * iavf_irq_enable_queues - Enable interrupt for all queues
  * @adapter: board private structure
- * @mask: bitmap of queues to enable
  **/
-void iavf_irq_enable_queues(struct iavf_adapter *adapter, u32 mask)
+void iavf_irq_enable_queues(struct iavf_adapter *adapter)
 {
 	struct iavf_hw *hw = &adapter->hw;
 	int i;
 
 	for (i = 1; i < adapter->num_msix_vectors; i++) {
-		if (mask & BIT(i - 1)) {
-			wr32(hw, IAVF_VFINT_DYN_CTLN1(i - 1),
-			     IAVF_VFINT_DYN_CTLN1_INTENA_MASK |
-			     IAVF_VFINT_DYN_CTLN1_ITR_INDX_MASK);
-		}
+		wr32(hw, IAVF_VFINT_DYN_CTLN1(i - 1),
+		     IAVF_VFINT_DYN_CTLN1_INTENA_MASK |
+		     IAVF_VFINT_DYN_CTLN1_ITR_INDX_MASK);
 	}
 }
 
@@ -281,7 +278,7 @@ void iavf_irq_enable(struct iavf_adapter *adapter, bool flush)
 	struct iavf_hw *hw = &adapter->hw;
 
 	iavf_misc_irq_enable(adapter);
-	iavf_irq_enable_queues(adapter, ~0);
+	iavf_irq_enable_queues(adapter);
 
 	if (flush)
 		iavf_flush(hw);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_register.h b/drivers/net/ethernet/intel/iavf/iavf_register.h
index bf793332fc9d5..a19e88898a0bb 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_register.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_register.h
@@ -40,7 +40,7 @@
 #define IAVF_VFINT_DYN_CTL01_INTENA_MASK IAVF_MASK(0x1, IAVF_VFINT_DYN_CTL01_INTENA_SHIFT)
 #define IAVF_VFINT_DYN_CTL01_ITR_INDX_SHIFT 3
 #define IAVF_VFINT_DYN_CTL01_ITR_INDX_MASK IAVF_MASK(0x3, IAVF_VFINT_DYN_CTL01_ITR_INDX_SHIFT)
-#define IAVF_VFINT_DYN_CTLN1(_INTVF) (0x00003800 + ((_INTVF) * 4)) /* _i=0...15 */ /* Reset: VFR */
+#define IAVF_VFINT_DYN_CTLN1(_INTVF) (0x00003800 + ((_INTVF) * 4)) /* _i=0...63 */ /* Reset: VFR */
 #define IAVF_VFINT_DYN_CTLN1_INTENA_SHIFT 0
 #define IAVF_VFINT_DYN_CTLN1_INTENA_MASK IAVF_MASK(0x1, IAVF_VFINT_DYN_CTLN1_INTENA_SHIFT)
 #define IAVF_VFINT_DYN_CTLN1_SWINT_TRIG_SHIFT 2
-- 
2.39.2




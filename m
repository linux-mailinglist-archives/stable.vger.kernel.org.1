Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91569761219
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbjGYK73 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjGYK6c (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:58:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9410213D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:55:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37F0E6166F
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:55:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482D7C433C7;
        Tue, 25 Jul 2023 10:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282555;
        bh=r1BqpfkFGdl2cuSwbIQtbgPggKO/R2ap+b1O/y0r/Ww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TNss4/xTv/Zcuujzc027kLL+l3KWkW71UNO1BPBNKTACE3gh7CwERYVm7VtPueXM1
         fo85rsEniP6o4lYLXweZliXCC5ns3LQ7i+jCx8Q4PZqfCO1t5wbQmfQnn71TTAKCw0
         7XjCQgcFyxvBH0IIAFSAuNLtfr+2LPszOwvFLGkE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ahmed Zaki <ahmed.zaki@intel.com>,
        Rafal Romanowski <rafal.romanowski@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 172/227] iavf: use internal state to free traffic IRQs
Date:   Tue, 25 Jul 2023 12:45:39 +0200
Message-ID: <20230725104521.996401835@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
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

From: Ahmed Zaki <ahmed.zaki@intel.com>

[ Upstream commit a77ed5c5b768e9649be240a2d864e5cd9c6a2015 ]

If the system tries to close the netdev while iavf_reset_task() is
running, __LINK_STATE_START will be cleared and netif_running() will
return false in iavf_reinit_interrupt_scheme(). This will result in
iavf_free_traffic_irqs() not being called and a leak as follows:

    [7632.489326] remove_proc_entry: removing non-empty directory 'irq/999', leaking at least 'iavf-enp24s0f0v0-TxRx-0'
    [7632.490214] WARNING: CPU: 0 PID: 10 at fs/proc/generic.c:718 remove_proc_entry+0x19b/0x1b0

is shown when pci_disable_msix() is later called. Fix by using the
internal adapter state. The traffic IRQs will always exist if
state == __IAVF_RUNNING.

Fixes: 5b36e8d04b44 ("i40evf: Enable VF to request an alternate queue allocation")
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 601de8e8f3654..b698f8917f049 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1941,15 +1941,16 @@ static void iavf_free_rss(struct iavf_adapter *adapter)
 /**
  * iavf_reinit_interrupt_scheme - Reallocate queues and vectors
  * @adapter: board private structure
+ * @running: true if adapter->state == __IAVF_RUNNING
  *
  * Returns 0 on success, negative on failure
  **/
-static int iavf_reinit_interrupt_scheme(struct iavf_adapter *adapter)
+static int iavf_reinit_interrupt_scheme(struct iavf_adapter *adapter, bool running)
 {
 	struct net_device *netdev = adapter->netdev;
 	int err;
 
-	if (netif_running(netdev))
+	if (running)
 		iavf_free_traffic_irqs(adapter);
 	iavf_free_misc_irq(adapter);
 	iavf_reset_interrupt_capability(adapter);
@@ -3065,7 +3066,7 @@ static void iavf_reset_task(struct work_struct *work)
 
 	if ((adapter->flags & IAVF_FLAG_REINIT_MSIX_NEEDED) ||
 	    (adapter->flags & IAVF_FLAG_REINIT_ITR_NEEDED)) {
-		err = iavf_reinit_interrupt_scheme(adapter);
+		err = iavf_reinit_interrupt_scheme(adapter, running);
 		if (err)
 			goto reset_err;
 	}
-- 
2.39.2




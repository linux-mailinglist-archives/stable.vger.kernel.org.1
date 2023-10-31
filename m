Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1047DD548
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376501AbjJaRtC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376506AbjJaRtB (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:49:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB57ED
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:48:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB40C433C9;
        Tue, 31 Oct 2023 17:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774536;
        bh=Vrsn6G7hgpWW31hwbhZVDVOyC1BlzazCi02uoAzjGhI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MEMsN+wTkaNGrtUyaIY0xKcT/GY0Vu6wu2l7mNN/u/5THtXyYFrhlG/NSVSmKSiL8
         0KdAAqCrT4q7VsuKvZ2Wjp1/Yx2079dPd3bM1jUIwQCyNDycg3+bCN0BzVXSwbbNpW
         zi+gaUdms9OYHACUJwrnHKhEgPJr4DSDkCauDt/c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Michal Schmidt <mschmidt@redhat.com>,
        Wojciech Drewek <wojciech.drewek@intel.com>,
        Rafal Romanowski <rafal.romanowski@intel.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 079/112] iavf: in iavf_down, disable queues when removing the driver
Date:   Tue, 31 Oct 2023 18:01:20 +0100
Message-ID: <20231031165903.811043534@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
References: <20231031165901.318222981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Schmidt <mschmidt@redhat.com>

[ Upstream commit 53798666648af3aa0dd512c2380576627237a800 ]

In iavf_down, we're skipping the scheduling of certain operations if
the driver is being removed. However, the IAVF_FLAG_AQ_DISABLE_QUEUES
request must not be skipped in this case, because iavf_close waits
for the transition to the __IAVF_DOWN state, which happens in
iavf_virtchnl_completion after the queues are released.

Without this fix, "rmmod iavf" takes half a second per interface that's
up and prints the "Device resources not yet released" warning.

Fixes: c8de44b577eb ("iavf: do not process adminq tasks when __IAVF_IN_REMOVE_TASK is set")
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Tested-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Link: https://lore.kernel.org/r/20231025183213.874283-1-jacob.e.keller@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 14875cd85a8e3..13bfc9333a8c3 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1437,9 +1437,9 @@ void iavf_down(struct iavf_adapter *adapter)
 			adapter->aq_required |= IAVF_FLAG_AQ_DEL_FDIR_FILTER;
 		if (!list_empty(&adapter->adv_rss_list_head))
 			adapter->aq_required |= IAVF_FLAG_AQ_DEL_ADV_RSS_CFG;
-		adapter->aq_required |= IAVF_FLAG_AQ_DISABLE_QUEUES;
 	}
 
+	adapter->aq_required |= IAVF_FLAG_AQ_DISABLE_QUEUES;
 	mod_delayed_work(adapter->wq, &adapter->watchdog_task, 0);
 }
 
-- 
2.42.0




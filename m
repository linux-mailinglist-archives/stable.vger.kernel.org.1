Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128B77B8B31
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbjJDSsY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244240AbjJDS02 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:26:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E270C4
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:26:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536DEC433C8;
        Wed,  4 Oct 2023 18:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443984;
        bh=ajla/PiQ55wH2+WoJFdEz5C3zmtIhluxVB9eIZ02zN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vswsqvhVYHwGv5qC9JGB4Fq2+UXvLJmDCeF7tHe+EEt8bd/OndRgNnf2JGcn3koD4
         8KZ+kaHT7/foTPXIccErhZ6MduZRHntNhqIpbettgdpgtLBtrA3zFszkhjhEc1FV+u
         +2/KF2r9H+p6GuXrTVd+m7pNbV/aUyFAGm9u73MI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Petr Oros <poros@redhat.com>,
        Michal Schmidt <mschmidt@redhat.com>,
        Ivan Vecera <ivecera@redhat.com>,
        Ahmed Zaki <ahmed.zaki@intel.com>,
        Simon Horman <horms@kernel.org>,
        Rafal Romanowski <rafal.romanowski@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 061/321] iavf: schedule a request immediately after add/delete vlan
Date:   Wed,  4 Oct 2023 19:53:26 +0200
Message-ID: <20231004175231.999906423@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Petr Oros <poros@redhat.com>

[ Upstream commit 5f3d319a248654a805bafc9e7094bcea47dac6c7 ]

When the iavf driver wants to reconfigure the VLAN filters
(iavf_add_vlan, iavf_del_vlan), it sets a flag in
aq_required:
  adapter->aq_required |= IAVF_FLAG_AQ_ADD_VLAN_FILTER;
or:
  adapter->aq_required |= IAVF_FLAG_AQ_DEL_VLAN_FILTER;

This is later processed by the watchdog_task, but it runs periodically
every 2 seconds, so it can be a long time before it processes the request.

In the worst case, the interface is unable to receive traffic for more
than 2 seconds for no objective reason.

Fixes: 5eae00c57f5e ("i40evf: main driver core")
Signed-off-by: Petr Oros <poros@redhat.com>
Co-developed-by: Michal Schmidt <mschmidt@redhat.com>
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Co-developed-by: Ivan Vecera <ivecera@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Ahmed Zaki <ahmed.zaki@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index d76465474049c..8ea5c0825c3c4 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -821,7 +821,7 @@ iavf_vlan_filter *iavf_add_vlan(struct iavf_adapter *adapter,
 		list_add_tail(&f->list, &adapter->vlan_filter_list);
 		f->state = IAVF_VLAN_ADD;
 		adapter->num_vlan_filters++;
-		adapter->aq_required |= IAVF_FLAG_AQ_ADD_VLAN_FILTER;
+		iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_ADD_VLAN_FILTER);
 	}
 
 clearout:
@@ -843,7 +843,7 @@ static void iavf_del_vlan(struct iavf_adapter *adapter, struct iavf_vlan vlan)
 	f = iavf_find_vlan(adapter, vlan);
 	if (f) {
 		f->state = IAVF_VLAN_REMOVE;
-		adapter->aq_required |= IAVF_FLAG_AQ_DEL_VLAN_FILTER;
+		iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_DEL_VLAN_FILTER);
 	}
 
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
-- 
2.40.1




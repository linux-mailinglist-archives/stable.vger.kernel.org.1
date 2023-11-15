Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA437ECFD1
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbjKOTvE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235419AbjKOTvA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:51:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCE412C
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:50:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF433C433C8;
        Wed, 15 Nov 2023 19:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077857;
        bh=BNtRXE4iu+nnSW4ea2LayvaSEz1ouufnM3XA2nV8SlA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lydx1c008i7ubeaAjZxZi0njdslqWVRrIxFHBOQnOsEAcvKkgwpFpCrzfzkuQCVjK
         qeMmipLNMJUKUxaUaRLH4G+V23KIG4mQmh+ULbQF55MshBQXXszZhBXo5XGjEhgnaZ
         JHhYE49mR/+YzTt8aisnX5JIKey1BLRLcyiIJ8bg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dave Ertman <david.m.ertman@intel.com>,
        Wojciech Drewek <wojciech.drewek@intel.com>,
        Simon Horman <horms@kernel.org>,
        Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 562/603] ice: Fix SRIOV LAG disable on non-compliant aggregate
Date:   Wed, 15 Nov 2023 14:18:27 -0500
Message-ID: <20231115191650.502826259@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Ertman <david.m.ertman@intel.com>

[ Upstream commit 3e39da4fa16c9c09207d98b8a86a6f6436b531c9 ]

If an attribute of an aggregate interface disqualifies it from supporting
SRIOV, the driver will unwind the SRIOV support.  Currently the driver is
clearing the feature bit for all interfaces in the aggregate, but this is
not allowing the other interfaces to unwind successfully on driver unload.

Only clear the feature bit for the interface that is currently unwinding.

Fixes: bf65da2eb279 ("ice: enforce interface eligibility and add messaging for SRIOV LAG")
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_lag.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index 7b1256992dcf6..a8da5f8374451 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -1529,18 +1529,12 @@ static void ice_lag_chk_disabled_bond(struct ice_lag *lag, void *ptr)
  */
 static void ice_lag_disable_sriov_bond(struct ice_lag *lag)
 {
-	struct ice_lag_netdev_list *entry;
 	struct ice_netdev_priv *np;
-	struct net_device *netdev;
 	struct ice_pf *pf;
 
-	list_for_each_entry(entry, lag->netdev_head, node) {
-		netdev = entry->netdev;
-		np = netdev_priv(netdev);
-		pf = np->vsi->back;
-
-		ice_clear_feature_support(pf, ICE_F_SRIOV_LAG);
-	}
+	np = netdev_priv(lag->netdev);
+	pf = np->vsi->back;
+	ice_clear_feature_support(pf, ICE_F_SRIOV_LAG);
 }
 
 /**
-- 
2.42.0




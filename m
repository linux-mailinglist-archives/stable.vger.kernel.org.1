Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B5377ACF7
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjHMVil (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbjHMVil (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:38:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FED10DD
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:38:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57A8563742
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:38:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E753C433C8;
        Sun, 13 Aug 2023 21:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962721;
        bh=PRcvwgMcXZzG1wyr1pZcJh57zqmpSsrMIGSgMl8KA2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aDZlR6RhFupuCa52baU4DM9BF1FIQihCau9T5tQy6oiImGjufyedZhCHcLlT/p4yV
         T5FPo1bSYz+l1ZBbekp06AMzlkqzCRJDrnHa/NCCKs62j4+P0zRatlz5iePWv8mjfw
         qXZk+/8lEXDEYiyfvFhhvqEEJ4UzdzOwWvAFFSAs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Piotr Gardocki <piotrx.gardocki@intel.com>,
        Rafal Romanowski <rafal.romanowski@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Simon Horman <horms@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 098/149] iavf: fix potential races for FDIR filters
Date:   Sun, 13 Aug 2023 23:19:03 +0200
Message-ID: <20230813211721.718084012@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
References: <20230813211718.757428827@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Piotr Gardocki <piotrx.gardocki@intel.com>

commit 0fb1d8eb234b6979d4981d2d385780dd7d8d9771 upstream.

Add fdir_fltr_lock locking in unprotected places.

The change in iavf_fdir_is_dup_fltr adds a spinlock around a loop which
iterates over all filters and looks for a duplicate. The filter can be
removed from list and freed from memory at the same time it's being
compared. All other places where filters are deleted are already
protected with spinlock.

The remaining changes protect adapter->fdir_active_fltr variable so now
all its uses are under a spinlock.

Fixes: 527691bf0682 ("iavf: Support IPv4 Flow Director filters")
Signed-off-by: Piotr Gardocki <piotrx.gardocki@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20230807205011.3129224-1-anthony.l.nguyen@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c |    5 ++++-
 drivers/net/ethernet/intel/iavf/iavf_fdir.c    |   11 ++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -1401,14 +1401,15 @@ static int iavf_add_fdir_ethtool(struct
 	if (fsp->flow_type & FLOW_MAC_EXT)
 		return -EINVAL;
 
+	spin_lock_bh(&adapter->fdir_fltr_lock);
 	if (adapter->fdir_active_fltr >= IAVF_MAX_FDIR_FILTERS) {
+		spin_unlock_bh(&adapter->fdir_fltr_lock);
 		dev_err(&adapter->pdev->dev,
 			"Unable to add Flow Director filter because VF reached the limit of max allowed filters (%u)\n",
 			IAVF_MAX_FDIR_FILTERS);
 		return -ENOSPC;
 	}
 
-	spin_lock_bh(&adapter->fdir_fltr_lock);
 	if (iavf_find_fdir_fltr_by_loc(adapter, fsp->location)) {
 		dev_err(&adapter->pdev->dev, "Failed to add Flow Director filter, it already exists\n");
 		spin_unlock_bh(&adapter->fdir_fltr_lock);
@@ -1781,7 +1782,9 @@ static int iavf_get_rxnfc(struct net_dev
 	case ETHTOOL_GRXCLSRLCNT:
 		if (!FDIR_FLTR_SUPPORT(adapter))
 			break;
+		spin_lock_bh(&adapter->fdir_fltr_lock);
 		cmd->rule_cnt = adapter->fdir_active_fltr;
+		spin_unlock_bh(&adapter->fdir_fltr_lock);
 		cmd->data = IAVF_MAX_FDIR_FILTERS;
 		ret = 0;
 		break;
--- a/drivers/net/ethernet/intel/iavf/iavf_fdir.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_fdir.c
@@ -722,7 +722,9 @@ void iavf_print_fdir_fltr(struct iavf_ad
 bool iavf_fdir_is_dup_fltr(struct iavf_adapter *adapter, struct iavf_fdir_fltr *fltr)
 {
 	struct iavf_fdir_fltr *tmp;
+	bool ret = false;
 
+	spin_lock_bh(&adapter->fdir_fltr_lock);
 	list_for_each_entry(tmp, &adapter->fdir_list_head, list) {
 		if (tmp->flow_type != fltr->flow_type)
 			continue;
@@ -732,11 +734,14 @@ bool iavf_fdir_is_dup_fltr(struct iavf_a
 		    !memcmp(&tmp->ip_data, &fltr->ip_data,
 			    sizeof(fltr->ip_data)) &&
 		    !memcmp(&tmp->ext_data, &fltr->ext_data,
-			    sizeof(fltr->ext_data)))
-			return true;
+			    sizeof(fltr->ext_data))) {
+			ret = true;
+			break;
+		}
 	}
+	spin_unlock_bh(&adapter->fdir_fltr_lock);
 
-	return false;
+	return ret;
 }
 
 /**



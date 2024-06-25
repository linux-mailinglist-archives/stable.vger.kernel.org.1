Return-Path: <stable+bounces-55511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 217B09163ED
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 11:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5492E1C21B1C
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 09:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09171149E0A;
	Tue, 25 Jun 2024 09:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1ahg1XqW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACAA147C7F;
	Tue, 25 Jun 2024 09:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719309118; cv=none; b=T2KQViA3GF2JLKC3oyuxAjYuFCkRGEftnZRGrQYuufK4Buv1O7cGq9Pqsd3eG7G83wviOU2/3pxxp73FIc9HSuNoLHegwl5vyGoDfIUvMGQAwX/78aTrd43K5m/xrzIqA3SbfHGeOlmAZQfwFhREjrlmKJ5VL28s80NZqS4fLvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719309118; c=relaxed/simple;
	bh=bEAFdZ1UwEVcE6v7UW6nJQXWMRz6EkLc2Zvvs0CZ/PM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BBz84mH85ly8g5tpAYyaWwhZazQxbFI37oeCzjJBneFCoXtNrd/pKWLtLTwcoHUbLG58C91Mpl0pFyENy1zwGPOvrqBCeRmoW/0ASlTzN3MbSKLpieAbPTAMh7/NF7uEn8KMyLgS+jYaxig16yfffIQ/qeflp/2n5T0bK0DFSBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1ahg1XqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ADF0C32781;
	Tue, 25 Jun 2024 09:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719309118;
	bh=bEAFdZ1UwEVcE6v7UW6nJQXWMRz6EkLc2Zvvs0CZ/PM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1ahg1XqW3GveF4TC7mnDEgorIEYAdYYILwx8uctudBvBDpC4pfGYw/DK99IGLLrD1
	 wePYO4c/c30Sn1mazcQXpvWM3Y8scjt2DrDZrAdKRBqjrWIpqR5sD2twVQ+4hbEZpU
	 zqAuzZM5wfPT2tJm+d/9upUvnvcT0GFYKiDzHChM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 101/192] ice: Fix VSI list rule with ICE_SW_LKUP_LAST type
Date: Tue, 25 Jun 2024 11:32:53 +0200
Message-ID: <20240625085541.054097009@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625085537.150087723@linuxfoundation.org>
References: <20240625085537.150087723@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marcin Szycik <marcin.szycik@linux.intel.com>

[ Upstream commit 74382aebc9035470ec4c789bdb0d09d8c14f261e ]

Adding/updating VSI list rule, as well as allocating/freeing VSI list
resource are called several times with type ICE_SW_LKUP_LAST, which fails
because ice_update_vsi_list_rule() and ice_aq_alloc_free_vsi_list()
consider it invalid. Allow calling these functions with ICE_SW_LKUP_LAST.

This fixes at least one issue in switchdev mode, where the same rule with
different action cannot be added, e.g.:

  tc filter add dev $PF1 ingress protocol arp prio 0 flower skip_sw \
    dst_mac ff:ff:ff:ff:ff:ff action mirred egress redirect dev $VF1_PR
  tc filter add dev $PF1 ingress protocol arp prio 0 flower skip_sw \
    dst_mac ff:ff:ff:ff:ff:ff action mirred egress redirect dev $VF2_PR

Fixes: 0f94570d0cae ("ice: allow adding advanced rules")
Suggested-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Link: https://lore.kernel.org/r/20240618210206.981885-1-anthony.l.nguyen@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 4c6d58bb2690d..d2a2388d4fa0a 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -1829,7 +1829,8 @@ ice_aq_alloc_free_vsi_list(struct ice_hw *hw, u16 *vsi_list_id,
 	    lkup_type == ICE_SW_LKUP_ETHERTYPE_MAC ||
 	    lkup_type == ICE_SW_LKUP_PROMISC ||
 	    lkup_type == ICE_SW_LKUP_PROMISC_VLAN ||
-	    lkup_type == ICE_SW_LKUP_DFLT) {
+	    lkup_type == ICE_SW_LKUP_DFLT ||
+	    lkup_type == ICE_SW_LKUP_LAST) {
 		sw_buf->res_type = cpu_to_le16(ICE_AQC_RES_TYPE_VSI_LIST_REP);
 	} else if (lkup_type == ICE_SW_LKUP_VLAN) {
 		if (opc == ice_aqc_opc_alloc_res)
@@ -2775,7 +2776,8 @@ ice_update_vsi_list_rule(struct ice_hw *hw, u16 *vsi_handle_arr, u16 num_vsi,
 	    lkup_type == ICE_SW_LKUP_ETHERTYPE_MAC ||
 	    lkup_type == ICE_SW_LKUP_PROMISC ||
 	    lkup_type == ICE_SW_LKUP_PROMISC_VLAN ||
-	    lkup_type == ICE_SW_LKUP_DFLT)
+	    lkup_type == ICE_SW_LKUP_DFLT ||
+	    lkup_type == ICE_SW_LKUP_LAST)
 		rule_type = remove ? ICE_AQC_SW_RULES_T_VSI_LIST_CLEAR :
 			ICE_AQC_SW_RULES_T_VSI_LIST_SET;
 	else if (lkup_type == ICE_SW_LKUP_VLAN)
-- 
2.43.0





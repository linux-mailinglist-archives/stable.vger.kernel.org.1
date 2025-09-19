Return-Path: <stable+bounces-180696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E56AB8AFEC
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 20:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDC345638E1
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 18:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3435527F19F;
	Fri, 19 Sep 2025 18:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A0d0EgmN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4888D26E712;
	Fri, 19 Sep 2025 18:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758307812; cv=none; b=j/HAwJImGGOy+689ZfOEMLibDBFPPQ3uxYlnNxf31GnAwQMIRo5l2m7psqa/GOAg73RlrExM9o5lrNtw7P4GUyJJle+y052FYvQhf6wdrX5CxgQJx32TAXZWaABLWfg2rPfSQaeeVlbcNxUxhxrTDCllOy6cLfIWdsTTWZ7XZjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758307812; c=relaxed/simple;
	bh=MrZy2Ko0mo//8O5XMZ/cacNhOydByJYZwKgoxfDJaF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c5OpoxIdGep21iHiQ3cfclyX/d6NboJJdxRhdfoyT9iyuIUxYGReZdHWnt4YO23HR/SpyJO0NdKw0X6kB40S/rO1/YV6bejK6cEc7ixE47NkgkXZVetrr53iBEdGAp14c3K/oxSuDlY4fox6hnY5W5M08MoxYGlAUiF3LLyQids=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A0d0EgmN; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758307810; x=1789843810;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MrZy2Ko0mo//8O5XMZ/cacNhOydByJYZwKgoxfDJaF8=;
  b=A0d0EgmNSy7jGqNF9+NonxqVwv0zrXxivOow9CYd91RP+xtrNxY26TV6
   OZgkntbHiC6iPkT+mN/zA3DWoLDH+A8xhZ7mjH9n9VYFWuJunTq9tiFmY
   ogb0g726mzZeoVf7Omhzg37YzeTEnbR7Iuh92dy7+sE0dfL19yml7eDbk
   xaJcZzGSWto5HPHaECVWHCSTth/017nTb5BD3B5Ri/Cqp9aSmmmwn01gu
   UTR9kOxk+SJZHjoWY1ami9p3xFX0m+rLmTrQdBNIQusX/IIFacdigtH99
   /q4n1uTEn80yTSzeM86LUVl//aEXx1OEtQMmlrb2t+6ohBO4enVVMK+/N
   w==;
X-CSE-ConnectionGUID: MfzfF+vRS4GvdGqVcN7H1w==
X-CSE-MsgGUID: 2+7O7d/1RRa+ipfIveNsOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="60589777"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="60589777"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 11:50:06 -0700
X-CSE-ConnectionGUID: yxW5e0goSWaQTXXs/qiGcA==
X-CSE-MsgGUID: /x9VXwmdT6mTvdXhpLd34w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="175458799"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 19 Sep 2025 11:50:06 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Lukasz Czapnik <lukasz.czapnik@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	leszek.pepiak@intel.com,
	jeremiah.kyle@intel.com,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 8/8] i40e: improve VF MAC filters accounting
Date: Fri, 19 Sep 2025 11:49:58 -0700
Message-ID: <20250919184959.656681-9-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250919184959.656681-1-anthony.l.nguyen@intel.com>
References: <20250919184959.656681-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukasz Czapnik <lukasz.czapnik@intel.com>

When adding new VM MAC, driver checks only *active* filters in
vsi->mac_filter_hash. Each MAC, even in non-active state is using resources.

To determine number of MACs VM uses, count VSI filters in *any* state.

Add i40e_count_all_filters() to simply count all filters, and rename
i40e_count_filters() to i40e_count_active_filters() to avoid ambiguity.

Fixes: cfb1d572c986 ("i40e: Add ensurance of MacVlan resources for every trusted VF")
Cc: stable@vger.kernel.org
Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h        |  3 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 26 ++++++--
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 65 ++++++++-----------
 3 files changed, 50 insertions(+), 44 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 49aa4497efce..801a57a925da 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -1278,7 +1278,8 @@ struct i40e_mac_filter *i40e_add_mac_filter(struct i40e_vsi *vsi,
 					    const u8 *macaddr);
 int i40e_del_mac_filter(struct i40e_vsi *vsi, const u8 *macaddr);
 bool i40e_is_vsi_in_vlan(struct i40e_vsi *vsi);
-int i40e_count_filters(struct i40e_vsi *vsi);
+int i40e_count_all_filters(struct i40e_vsi *vsi);
+int i40e_count_active_filters(struct i40e_vsi *vsi);
 struct i40e_mac_filter *i40e_find_mac(struct i40e_vsi *vsi, const u8 *macaddr);
 void i40e_vlan_stripping_enable(struct i40e_vsi *vsi);
 static inline bool i40e_is_sw_dcb(struct i40e_pf *pf)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index b14019d44b58..529d5501baac 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1243,12 +1243,30 @@ void i40e_update_stats(struct i40e_vsi *vsi)
 }
 
 /**
- * i40e_count_filters - counts VSI mac filters
+ * i40e_count_all_filters - counts VSI MAC filters
  * @vsi: the VSI to be searched
  *
- * Returns count of mac filters
- **/
-int i40e_count_filters(struct i40e_vsi *vsi)
+ * Return: count of MAC filters in any state.
+ */
+int i40e_count_all_filters(struct i40e_vsi *vsi)
+{
+	struct i40e_mac_filter *f;
+	struct hlist_node *h;
+	int bkt, cnt = 0;
+
+	hash_for_each_safe(vsi->mac_filter_hash, bkt, h, f, hlist)
+		cnt++;
+
+	return cnt;
+}
+
+/**
+ * i40e_count_active_filters - counts VSI MAC filters
+ * @vsi: the VSI to be searched
+ *
+ * Return: count of active MAC filters.
+ */
+int i40e_count_active_filters(struct i40e_vsi *vsi)
 {
 	struct i40e_mac_filter *f;
 	struct hlist_node *h;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index f9b2197f0942..081a4526a2f0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2862,24 +2862,6 @@ static int i40e_vc_get_stats_msg(struct i40e_vf *vf, u8 *msg)
 				      (u8 *)&stats, sizeof(stats));
 }
 
-/**
- * i40e_can_vf_change_mac
- * @vf: pointer to the VF info
- *
- * Return true if the VF is allowed to change its MAC filters, false otherwise
- */
-static bool i40e_can_vf_change_mac(struct i40e_vf *vf)
-{
-	/* If the VF MAC address has been set administratively (via the
-	 * ndo_set_vf_mac command), then deny permission to the VF to
-	 * add/delete unicast MAC addresses, unless the VF is trusted
-	 */
-	if (vf->pf_set_mac && !vf->trusted)
-		return false;
-
-	return true;
-}
-
 #define I40E_MAX_MACVLAN_PER_HW 3072
 #define I40E_MAX_MACVLAN_PER_PF(num_ports) (I40E_MAX_MACVLAN_PER_HW /	\
 	(num_ports))
@@ -2918,8 +2900,10 @@ static inline int i40e_check_vf_permission(struct i40e_vf *vf,
 	struct i40e_pf *pf = vf->pf;
 	struct i40e_vsi *vsi = pf->vsi[vf->lan_vsi_idx];
 	struct i40e_hw *hw = &pf->hw;
-	int mac2add_cnt = 0;
-	int i;
+	int i, mac_add_max, mac_add_cnt = 0;
+	bool vf_trusted;
+
+	vf_trusted = test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
 
 	for (i = 0; i < al->num_elements; i++) {
 		struct i40e_mac_filter *f;
@@ -2939,9 +2923,8 @@ static inline int i40e_check_vf_permission(struct i40e_vf *vf,
 		 * The VF may request to set the MAC address filter already
 		 * assigned to it so do not return an error in that case.
 		 */
-		if (!i40e_can_vf_change_mac(vf) &&
-		    !is_multicast_ether_addr(addr) &&
-		    !ether_addr_equal(addr, vf->default_lan_addr.addr)) {
+		if (!vf_trusted && !is_multicast_ether_addr(addr) &&
+		    vf->pf_set_mac && !ether_addr_equal(addr, vf->default_lan_addr.addr)) {
 			dev_err(&pf->pdev->dev,
 				"VF attempting to override administratively set MAC address, bring down and up the VF interface to resume normal operation\n");
 			return -EPERM;
@@ -2950,29 +2933,33 @@ static inline int i40e_check_vf_permission(struct i40e_vf *vf,
 		/*count filters that really will be added*/
 		f = i40e_find_mac(vsi, addr);
 		if (!f)
-			++mac2add_cnt;
+			++mac_add_cnt;
 	}
 
 	/* If this VF is not privileged, then we can't add more than a limited
-	 * number of addresses. Check to make sure that the additions do not
-	 * push us over the limit.
-	 */
-	if (!test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps)) {
-		if ((i40e_count_filters(vsi) + mac2add_cnt) >
-		    I40E_VC_MAX_MAC_ADDR_PER_VF) {
-			dev_err(&pf->pdev->dev,
-				"Cannot add more MAC addresses, VF is not trusted, switch the VF to trusted to add more functionality\n");
-			return -EPERM;
-		}
-	/* If this VF is trusted, it can use more resources than untrusted.
+	 * number of addresses.
+	 *
+	 * If this VF is trusted, it can use more resources than untrusted.
 	 * However to ensure that every trusted VF has appropriate number of
 	 * resources, divide whole pool of resources per port and then across
 	 * all VFs.
 	 */
-	} else {
-		if ((i40e_count_filters(vsi) + mac2add_cnt) >
-		    I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF(pf->num_alloc_vfs,
-						       hw->num_ports)) {
+	if (!vf_trusted)
+		mac_add_max = I40E_VC_MAX_MAC_ADDR_PER_VF;
+	else
+		mac_add_max = I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF(pf->num_alloc_vfs, hw->num_ports);
+
+	/* VF can replace all its filters in one step, in this case mac_add_max
+	 * will be added as active and another mac_add_max will be in
+	 * a to-be-removed state. Account for that.
+	 */
+	if ((i40e_count_active_filters(vsi) + mac_add_cnt) > mac_add_max ||
+	    (i40e_count_all_filters(vsi) + mac_add_cnt) > 2 * mac_add_max) {
+		if (!vf_trusted) {
+			dev_err(&pf->pdev->dev,
+				"Cannot add more MAC addresses, VF is not trusted, switch the VF to trusted to add more functionality\n");
+			return -EPERM;
+		} else {
 			dev_err(&pf->pdev->dev,
 				"Cannot add more MAC addresses, trusted VF exhausted it's resources\n");
 			return -EPERM;
-- 
2.47.1



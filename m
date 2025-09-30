Return-Path: <stable+bounces-182385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AED7BAD81B
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 17:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9865189A23C
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 15:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4AA3043C4;
	Tue, 30 Sep 2025 15:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AEQDMOwm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D58217F55;
	Tue, 30 Sep 2025 15:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759244773; cv=none; b=MP+OkvXOFXfxfGs1Q49Mfgo1oyoshRMp7B2FKgekXFH2BKmNdp7QU0OFFae+7bVjZzIN+4PI328A2P83+NoQcw6IWgKtqWOxmtgEbaJx2ztdce7jNvXVsoLpzsf1mqxnTd44kBqaSWK2KfymhDyN8v2mmpPAiRFkiexNhimTqwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759244773; c=relaxed/simple;
	bh=CWUR4Ja81Rm2KEdrx9/h5nPGEwQv3A8Pjt6G5ebHYvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n073TJPict4B9kE2JnTVoq+tca2tVT4fd+G7sQODNh7xRLrNTr7UtkgxziX08sX/8Jg+y+kjz84HlRrZ1Exm5M8UE7qcc+Q9IzW6rD34DFqRrmGH9pcA9mT0d8uTaQXmjAEeMzwcrxHmQFtMMJXiWbBD/s84+JOAcMGE+A4k52A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AEQDMOwm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C990C4CEF0;
	Tue, 30 Sep 2025 15:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759244773;
	bh=CWUR4Ja81Rm2KEdrx9/h5nPGEwQv3A8Pjt6G5ebHYvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AEQDMOwmbTScpZOit63pFrxdY0t5sOUX//LBvuC2dsXQb+00U1KjBv3P8ZbBF3mFQ
	 e8PZ6fzsAmPOlkWU+lQGvaXWQcyEUM7PKa44eNKVPogjoqWuahs0NoU+1q83DXWPgY
	 xlXmipoFvreigqBus7WNFop1bNKm0Hf5Ud+VSoKw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH 6.16 109/143] i40e: improve VF MAC filters accounting
Date: Tue, 30 Sep 2025 16:47:13 +0200
Message-ID: <20250930143835.577641862@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930143831.236060637@linuxfoundation.org>
References: <20250930143831.236060637@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukasz Czapnik <lukasz.czapnik@intel.com>

commit b99dd77076bd3fddac6f7f1cbfa081c38fde17f5 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/i40e/i40e.h             |    3 
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   26 +++++++-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   65 ++++++++-------------
 3 files changed, 50 insertions(+), 44 deletions(-)

--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -1277,7 +1277,8 @@ struct i40e_mac_filter *i40e_add_mac_fil
 					    const u8 *macaddr);
 int i40e_del_mac_filter(struct i40e_vsi *vsi, const u8 *macaddr);
 bool i40e_is_vsi_in_vlan(struct i40e_vsi *vsi);
-int i40e_count_filters(struct i40e_vsi *vsi);
+int i40e_count_all_filters(struct i40e_vsi *vsi);
+int i40e_count_active_filters(struct i40e_vsi *vsi);
 struct i40e_mac_filter *i40e_find_mac(struct i40e_vsi *vsi, const u8 *macaddr);
 void i40e_vlan_stripping_enable(struct i40e_vsi *vsi);
 static inline bool i40e_is_sw_dcb(struct i40e_pf *pf)
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1241,12 +1241,30 @@ void i40e_update_stats(struct i40e_vsi *
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
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2865,24 +2865,6 @@ error_param:
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
@@ -2921,8 +2903,10 @@ static inline int i40e_check_vf_permissi
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
@@ -2942,9 +2926,8 @@ static inline int i40e_check_vf_permissi
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
@@ -2953,29 +2936,33 @@ static inline int i40e_check_vf_permissi
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




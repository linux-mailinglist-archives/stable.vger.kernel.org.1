Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B8E7BDF6E
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376904AbjJINaB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376690AbjJINaA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:30:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3412B7
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:29:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3010BC433C8;
        Mon,  9 Oct 2023 13:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858198;
        bh=ZQnsHsyxGJnZnYgVbceaVA2NamMi6i5CwZM0hy0K0nk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XofQ8+Z4EF30OxRm3aPa0JjEOpAJmxm7hLsZWKKfeg+FY3k9HxAP8jgY1mGnLSSLX
         8BxrLWnf8+dOq6xxBjIKvwnStZjXat6rboJQEEABUG/Md+dUXbz7dPi0uEbhnrlPWY
         4KahG0ZM2RoTOXvFPlfjB9SNrWqddpcePwUo0yyQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
        Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 020/131] i40e: Remove scheduling while atomic possibility
Date:   Mon,  9 Oct 2023 15:01:00 +0200
Message-ID: <20231009130116.933375056@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130116.329529591@linuxfoundation.org>
References: <20231009130116.329529591@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

[ Upstream commit 37d318d7805f25b672bfd74fc694f19a2ee9665d ]

In some occasions task held spinlock (mac_filter_hash_lock),
while being rescheduled due to admin queue mutex_lock.  The struct
i40e_spinlock asq_spinlock, which later expands to struct mutex
spinlock.  Moved i40e_aq_set_vsi_multicast_promiscuous(),
i40e_aq_set_vsi_unicast_promiscuous(),
i40e_aq_set_vsi_mc_promisc_on_vlan(), and
i40e_aq_set_vsi_uc_promisc_on_vlan() outside of atomic context.  Without
this patch there is a race condition, which might result in scheduling
while in atomic context.  The race condition is between the thread, which
holds mac_filter_hash_lock, while trying to acquire an admin queue mutex
and a thread, which already has said admin queue mutex. The thread, which
holds spinlock, fails to acquire the mutex, which causes this thread to
sleep.

Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Stable-dep-of: d0d362ffa33d ("i40e: Fix VF VLAN offloading when port VLAN is configured")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 234 ++++++++++--------
 1 file changed, 137 insertions(+), 97 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index be07148a7b294..590469c4a1b00 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1110,39 +1110,81 @@ static int i40e_quiesce_vf_pci(struct i40e_vf *vf)
 	return -EIO;
 }
 
-static inline int i40e_getnum_vf_vsi_vlan_filters(struct i40e_vsi *vsi);
+/**
+ * i40e_getnum_vf_vsi_vlan_filters
+ * @vsi: pointer to the vsi
+ *
+ * called to get the number of VLANs offloaded on this VF
+ **/
+static int i40e_getnum_vf_vsi_vlan_filters(struct i40e_vsi *vsi)
+{
+	struct i40e_mac_filter *f;
+	int num_vlans = 0, bkt;
+
+	hash_for_each(vsi->mac_filter_hash, bkt, f, hlist) {
+		if (f->vlan >= 0 && f->vlan <= I40E_MAX_VLANID)
+			num_vlans++;
+	}
+
+	return num_vlans;
+}
 
 /**
- * i40e_config_vf_promiscuous_mode
- * @vf: pointer to the VF info
- * @vsi_id: VSI id
- * @allmulti: set MAC L2 layer multicast promiscuous enable/disable
- * @alluni: set MAC L2 layer unicast promiscuous enable/disable
+ * i40e_get_vlan_list_sync
+ * @vsi: pointer to the VSI
+ * @num_vlans: number of VLANs in mac_filter_hash, returned to caller
+ * @vlan_list: list of VLANs present in mac_filter_hash, returned to caller.
+ *             This array is allocated here, but has to be freed in caller.
  *
- * Called from the VF to configure the promiscuous mode of
- * VF vsis and from the VF reset path to reset promiscuous mode.
+ * Called to get number of VLANs and VLAN list present in mac_filter_hash.
  **/
-static i40e_status i40e_config_vf_promiscuous_mode(struct i40e_vf *vf,
-						   u16 vsi_id,
-						   bool allmulti,
-						   bool alluni)
+static void i40e_get_vlan_list_sync(struct i40e_vsi *vsi, int *num_vlans,
+					   s16 **vlan_list)
 {
-	struct i40e_pf *pf = vf->pf;
-	struct i40e_hw *hw = &pf->hw;
 	struct i40e_mac_filter *f;
-	i40e_status aq_ret = 0;
-	struct i40e_vsi *vsi;
+	int i = 0;
 	int bkt;
 
-	vsi = i40e_find_vsi_from_id(pf, vsi_id);
-	if (!i40e_vc_isvalid_vsi_id(vf, vsi_id) || !vsi)
-		return I40E_ERR_PARAM;
+	spin_lock_bh(&vsi->mac_filter_hash_lock);
+	*num_vlans = i40e_getnum_vf_vsi_vlan_filters(vsi);
+	*vlan_list = kcalloc(*num_vlans, sizeof(**vlan_list), GFP_ATOMIC);
+	if (!(*vlan_list))
+		goto err;
 
-	if (vf->port_vlan_id) {
-		aq_ret = i40e_aq_set_vsi_mc_promisc_on_vlan(hw, vsi->seid,
-							    allmulti,
-							    vf->port_vlan_id,
-							    NULL);
+	hash_for_each(vsi->mac_filter_hash, bkt, f, hlist) {
+		if (f->vlan < 0 || f->vlan > I40E_MAX_VLANID)
+			continue;
+		(*vlan_list)[i++] = f->vlan;
+	}
+err:
+	spin_unlock_bh(&vsi->mac_filter_hash_lock);
+}
+
+/**
+ * i40e_set_vsi_promisc
+ * @vf: pointer to the VF struct
+ * @seid: VSI number
+ * @multi_enable: set MAC L2 layer multicast promiscuous enable/disable
+ *                for a given VLAN
+ * @unicast_enable: set MAC L2 layer unicast promiscuous enable/disable
+ *                  for a given VLAN
+ * @vl: List of VLANs - apply filter for given VLANs
+ * @num_vlans: Number of elements in @vl
+ **/
+static i40e_status
+i40e_set_vsi_promisc(struct i40e_vf *vf, u16 seid, bool multi_enable,
+		     bool unicast_enable, s16 *vl, int num_vlans)
+{
+	struct i40e_pf *pf = vf->pf;
+	struct i40e_hw *hw = &pf->hw;
+	i40e_status aq_ret;
+	int i;
+
+	/* No VLAN to set promisc on, set on VSI */
+	if (!num_vlans || !vl) {
+		aq_ret = i40e_aq_set_vsi_multicast_promiscuous(hw, seid,
+							       multi_enable,
+							       NULL);
 		if (aq_ret) {
 			int aq_err = pf->hw.aq.asq_last_status;
 
@@ -1151,13 +1193,14 @@ static i40e_status i40e_config_vf_promiscuous_mode(struct i40e_vf *vf,
 				vf->vf_id,
 				i40e_stat_str(&pf->hw, aq_ret),
 				i40e_aq_str(&pf->hw, aq_err));
+
 			return aq_ret;
 		}
 
-		aq_ret = i40e_aq_set_vsi_uc_promisc_on_vlan(hw, vsi->seid,
-							    alluni,
-							    vf->port_vlan_id,
-							    NULL);
+		aq_ret = i40e_aq_set_vsi_unicast_promiscuous(hw, seid,
+							     unicast_enable,
+							     NULL, true);
+
 		if (aq_ret) {
 			int aq_err = pf->hw.aq.asq_last_status;
 
@@ -1167,68 +1210,84 @@ static i40e_status i40e_config_vf_promiscuous_mode(struct i40e_vf *vf,
 				i40e_stat_str(&pf->hw, aq_ret),
 				i40e_aq_str(&pf->hw, aq_err));
 		}
+
 		return aq_ret;
-	} else if (i40e_getnum_vf_vsi_vlan_filters(vsi)) {
-		hash_for_each(vsi->mac_filter_hash, bkt, f, hlist) {
-			if (f->vlan < 0 || f->vlan > I40E_MAX_VLANID)
-				continue;
-			aq_ret = i40e_aq_set_vsi_mc_promisc_on_vlan(hw,
-								    vsi->seid,
-								    allmulti,
-								    f->vlan,
-								    NULL);
-			if (aq_ret) {
-				int aq_err = pf->hw.aq.asq_last_status;
+	}
 
-				dev_err(&pf->pdev->dev,
-					"Could not add VLAN %d to multicast promiscuous domain err %s aq_err %s\n",
-					f->vlan,
-					i40e_stat_str(&pf->hw, aq_ret),
-					i40e_aq_str(&pf->hw, aq_err));
-			}
+	for (i = 0; i < num_vlans; i++) {
+		aq_ret = i40e_aq_set_vsi_mc_promisc_on_vlan(hw, seid,
+							    multi_enable,
+							    vl[i], NULL);
+		if (aq_ret) {
+			int aq_err = pf->hw.aq.asq_last_status;
+
+			dev_err(&pf->pdev->dev,
+				"VF %d failed to set multicast promiscuous mode err %s aq_err %s\n",
+				vf->vf_id,
+				i40e_stat_str(&pf->hw, aq_ret),
+				i40e_aq_str(&pf->hw, aq_err));
+		}
 
-			aq_ret = i40e_aq_set_vsi_uc_promisc_on_vlan(hw,
-								    vsi->seid,
-								    alluni,
-								    f->vlan,
-								    NULL);
-			if (aq_ret) {
-				int aq_err = pf->hw.aq.asq_last_status;
+		aq_ret = i40e_aq_set_vsi_uc_promisc_on_vlan(hw, seid,
+							    unicast_enable,
+							    vl[i], NULL);
+		if (aq_ret) {
+			int aq_err = pf->hw.aq.asq_last_status;
 
-				dev_err(&pf->pdev->dev,
-					"Could not add VLAN %d to Unicast promiscuous domain err %s aq_err %s\n",
-					f->vlan,
-					i40e_stat_str(&pf->hw, aq_ret),
-					i40e_aq_str(&pf->hw, aq_err));
-			}
+			dev_err(&pf->pdev->dev,
+				"VF %d failed to set unicast promiscuous mode err %s aq_err %s\n",
+				vf->vf_id,
+				i40e_stat_str(&pf->hw, aq_ret),
+				i40e_aq_str(&pf->hw, aq_err));
 		}
-		return aq_ret;
 	}
-	aq_ret = i40e_aq_set_vsi_multicast_promiscuous(hw, vsi->seid, allmulti,
-						       NULL);
-	if (aq_ret) {
-		int aq_err = pf->hw.aq.asq_last_status;
+	return aq_ret;
+}
 
-		dev_err(&pf->pdev->dev,
-			"VF %d failed to set multicast promiscuous mode err %s aq_err %s\n",
-			vf->vf_id,
-			i40e_stat_str(&pf->hw, aq_ret),
-			i40e_aq_str(&pf->hw, aq_err));
+/**
+ * i40e_config_vf_promiscuous_mode
+ * @vf: pointer to the VF info
+ * @vsi_id: VSI id
+ * @allmulti: set MAC L2 layer multicast promiscuous enable/disable
+ * @alluni: set MAC L2 layer unicast promiscuous enable/disable
+ *
+ * Called from the VF to configure the promiscuous mode of
+ * VF vsis and from the VF reset path to reset promiscuous mode.
+ **/
+static i40e_status i40e_config_vf_promiscuous_mode(struct i40e_vf *vf,
+						   u16 vsi_id,
+						   bool allmulti,
+						   bool alluni)
+{
+	i40e_status aq_ret = I40E_SUCCESS;
+	struct i40e_pf *pf = vf->pf;
+	struct i40e_vsi *vsi;
+	int num_vlans;
+	s16 *vl;
+
+	vsi = i40e_find_vsi_from_id(pf, vsi_id);
+	if (!i40e_vc_isvalid_vsi_id(vf, vsi_id) || !vsi)
+		return I40E_ERR_PARAM;
+
+	if (vf->port_vlan_id) {
+		aq_ret = i40e_set_vsi_promisc(vf, vsi->seid, allmulti,
+					      alluni, &vf->port_vlan_id, 1);
 		return aq_ret;
-	}
+	} else if (i40e_getnum_vf_vsi_vlan_filters(vsi)) {
+		i40e_get_vlan_list_sync(vsi, &num_vlans, &vl);
 
-	aq_ret = i40e_aq_set_vsi_unicast_promiscuous(hw, vsi->seid, alluni,
-						     NULL, true);
-	if (aq_ret) {
-		int aq_err = pf->hw.aq.asq_last_status;
+		if (!vl)
+			return I40E_ERR_NO_MEMORY;
 
-		dev_err(&pf->pdev->dev,
-			"VF %d failed to set unicast promiscuous mode err %s aq_err %s\n",
-			vf->vf_id,
-			i40e_stat_str(&pf->hw, aq_ret),
-			i40e_aq_str(&pf->hw, aq_err));
+		aq_ret = i40e_set_vsi_promisc(vf, vsi->seid, allmulti, alluni,
+					      vl, num_vlans);
+		kfree(vl);
+		return aq_ret;
 	}
 
+	/* no VLANs to set on, set on VSI */
+	aq_ret = i40e_set_vsi_promisc(vf, vsi->seid, allmulti, alluni,
+				      NULL, 0);
 	return aq_ret;
 }
 
@@ -2052,25 +2111,6 @@ static void i40e_vc_reset_vf_msg(struct i40e_vf *vf)
 		i40e_reset_vf(vf, false);
 }
 
-/**
- * i40e_getnum_vf_vsi_vlan_filters
- * @vsi: pointer to the vsi
- *
- * called to get the number of VLANs offloaded on this VF
- **/
-static inline int i40e_getnum_vf_vsi_vlan_filters(struct i40e_vsi *vsi)
-{
-	struct i40e_mac_filter *f;
-	int num_vlans = 0, bkt;
-
-	hash_for_each(vsi->mac_filter_hash, bkt, f, hlist) {
-		if (f->vlan >= 0 && f->vlan <= I40E_MAX_VLANID)
-			num_vlans++;
-	}
-
-	return num_vlans;
-}
-
 /**
  * i40e_vc_config_promiscuous_mode_msg
  * @vf: pointer to the VF info
-- 
2.40.1




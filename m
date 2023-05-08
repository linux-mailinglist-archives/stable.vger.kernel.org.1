Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291F46FA64C
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbjEHKSS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234374AbjEHKSF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:18:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977133A295
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:17:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E957610F4
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:17:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85CC0C433EF;
        Mon,  8 May 2023 10:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541077;
        bh=wq9UfJzxH9fDlScrgxs2KBfproKqUIIK9oAkp3ZfsgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SS7pFCYAWpszQpZjCRkh9bpXcBKINwdo7JL2tZ7vaNLEKJHO1OiG5ODk5G98C9m87
         D61ay+Bql9YfKa6qih+p1TvGRZxheRxw4G6lonzNARFHMrOJTOcDFI67ncON3+l0PP
         rx6Vm1lGsPE2j25v1NhSVPz1oCe4fYFT1sc+2uf8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jan Sokolowski <jan.sokolowski@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Gurucharan G <gurucharanx.g@intel.com>
Subject: [PATCH 6.1 607/611] i40e: Remove string printing for i40e_status
Date:   Mon,  8 May 2023 11:47:29 +0200
Message-Id: <20230508094441.632699609@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jan Sokolowski <jan.sokolowski@intel.com>

commit 5d968af27a166e055bdd5f832f095d809eadb992 upstream.

Remove the i40e_stat_str() function which prints the string
representation of the i40e_status error code. With upcoming changes
moving away from i40e_status, there will be no need for this function

Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/i40e/i40e_client.c      |    8 
 drivers/net/ethernet/intel/i40e/i40e_common.c      |   78 -----
 drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c      |   16 -
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |   41 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  307 ++++++++++-----------
 drivers/net/ethernet/intel/i40e/i40e_nvm.c         |    4 
 drivers/net/ethernet/intel/i40e/i40e_prototype.h   |    1 
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   28 -
 8 files changed, 201 insertions(+), 282 deletions(-)

--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -686,8 +686,8 @@ static int i40e_client_update_vsi_ctxt(s
 	ctxt.flags = I40E_AQ_VSI_TYPE_PF;
 	if (err) {
 		dev_info(&pf->pdev->dev,
-			 "couldn't get PF vsi config, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, err),
+			 "couldn't get PF vsi config, err %d aq_err %s\n",
+			 err,
 			 i40e_aq_str(&pf->hw,
 				     pf->hw.aq.asq_last_status));
 		return -ENOENT;
@@ -714,8 +714,8 @@ static int i40e_client_update_vsi_ctxt(s
 		err = i40e_aq_update_vsi_params(&vsi->back->hw, &ctxt, NULL);
 		if (err) {
 			dev_info(&pf->pdev->dev,
-				 "update VSI ctxt for PE failed, err %s aq_err %s\n",
-				 i40e_stat_str(&pf->hw, err),
+				 "update VSI ctxt for PE failed, err %d aq_err %s\n",
+				 err,
 				 i40e_aq_str(&pf->hw,
 					     pf->hw.aq.asq_last_status));
 		}
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -125,84 +125,6 @@ const char *i40e_aq_str(struct i40e_hw *
 }
 
 /**
- * i40e_stat_str - convert status err code to a string
- * @hw: pointer to the HW structure
- * @stat_err: the status error code to convert
- **/
-const char *i40e_stat_str(struct i40e_hw *hw, i40e_status stat_err)
-{
-	switch (stat_err) {
-	case 0:
-		return "OK";
-	case I40E_ERR_NVM:
-		return "I40E_ERR_NVM";
-	case I40E_ERR_NVM_CHECKSUM:
-		return "I40E_ERR_NVM_CHECKSUM";
-	case I40E_ERR_CONFIG:
-		return "I40E_ERR_CONFIG";
-	case I40E_ERR_PARAM:
-		return "I40E_ERR_PARAM";
-	case I40E_ERR_UNKNOWN_PHY:
-		return "I40E_ERR_UNKNOWN_PHY";
-	case I40E_ERR_INVALID_MAC_ADDR:
-		return "I40E_ERR_INVALID_MAC_ADDR";
-	case I40E_ERR_DEVICE_NOT_SUPPORTED:
-		return "I40E_ERR_DEVICE_NOT_SUPPORTED";
-	case I40E_ERR_RESET_FAILED:
-		return "I40E_ERR_RESET_FAILED";
-	case I40E_ERR_NO_AVAILABLE_VSI:
-		return "I40E_ERR_NO_AVAILABLE_VSI";
-	case I40E_ERR_NO_MEMORY:
-		return "I40E_ERR_NO_MEMORY";
-	case I40E_ERR_BAD_PTR:
-		return "I40E_ERR_BAD_PTR";
-	case I40E_ERR_INVALID_SIZE:
-		return "I40E_ERR_INVALID_SIZE";
-	case I40E_ERR_QUEUE_EMPTY:
-		return "I40E_ERR_QUEUE_EMPTY";
-	case I40E_ERR_TIMEOUT:
-		return "I40E_ERR_TIMEOUT";
-	case I40E_ERR_INVALID_SD_INDEX:
-		return "I40E_ERR_INVALID_SD_INDEX";
-	case I40E_ERR_INVALID_PAGE_DESC_INDEX:
-		return "I40E_ERR_INVALID_PAGE_DESC_INDEX";
-	case I40E_ERR_INVALID_SD_TYPE:
-		return "I40E_ERR_INVALID_SD_TYPE";
-	case I40E_ERR_INVALID_HMC_OBJ_INDEX:
-		return "I40E_ERR_INVALID_HMC_OBJ_INDEX";
-	case I40E_ERR_INVALID_HMC_OBJ_COUNT:
-		return "I40E_ERR_INVALID_HMC_OBJ_COUNT";
-	case I40E_ERR_ADMIN_QUEUE_ERROR:
-		return "I40E_ERR_ADMIN_QUEUE_ERROR";
-	case I40E_ERR_ADMIN_QUEUE_TIMEOUT:
-		return "I40E_ERR_ADMIN_QUEUE_TIMEOUT";
-	case I40E_ERR_BUF_TOO_SHORT:
-		return "I40E_ERR_BUF_TOO_SHORT";
-	case I40E_ERR_ADMIN_QUEUE_FULL:
-		return "I40E_ERR_ADMIN_QUEUE_FULL";
-	case I40E_ERR_ADMIN_QUEUE_NO_WORK:
-		return "I40E_ERR_ADMIN_QUEUE_NO_WORK";
-	case I40E_ERR_NVM_BLANK_MODE:
-		return "I40E_ERR_NVM_BLANK_MODE";
-	case I40E_ERR_NOT_IMPLEMENTED:
-		return "I40E_ERR_NOT_IMPLEMENTED";
-	case I40E_ERR_DIAG_TEST_FAILED:
-		return "I40E_ERR_DIAG_TEST_FAILED";
-	case I40E_ERR_NOT_READY:
-		return "I40E_ERR_NOT_READY";
-	case I40E_NOT_SUPPORTED:
-		return "I40E_NOT_SUPPORTED";
-	case I40E_ERR_FIRMWARE_API_VERSION:
-		return "I40E_ERR_FIRMWARE_API_VERSION";
-	case I40E_ERR_ADMIN_QUEUE_CRITICAL_ERROR:
-		return "I40E_ERR_ADMIN_QUEUE_CRITICAL_ERROR";
-	}
-
-	snprintf(hw->err_str, sizeof(hw->err_str), "%d", stat_err);
-	return hw->err_str;
-}
-
-/**
  * i40e_debug_aq
  * @hw: debug mask related to admin queue
  * @mask: debug mask
--- a/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
@@ -135,8 +135,8 @@ static int i40e_dcbnl_ieee_setets(struct
 	ret = i40e_hw_dcb_config(pf, &pf->tmp_cfg);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "Failed setting DCB ETS configuration err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "Failed setting DCB ETS configuration err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		return -EINVAL;
 	}
@@ -174,8 +174,8 @@ static int i40e_dcbnl_ieee_setpfc(struct
 	ret = i40e_hw_dcb_config(pf, &pf->tmp_cfg);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "Failed setting DCB PFC configuration err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "Failed setting DCB PFC configuration err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		return -EINVAL;
 	}
@@ -225,8 +225,8 @@ static int i40e_dcbnl_ieee_setapp(struct
 	ret = i40e_hw_dcb_config(pf, &pf->tmp_cfg);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "Failed setting DCB configuration err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "Failed setting DCB configuration err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		return -EINVAL;
 	}
@@ -290,8 +290,8 @@ static int i40e_dcbnl_ieee_delapp(struct
 	ret = i40e_hw_dcb_config(pf, &pf->tmp_cfg);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "Failed setting DCB configuration err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "Failed setting DCB configuration err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		return -EINVAL;
 	}
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1453,8 +1453,8 @@ static int i40e_set_link_ksettings(struc
 		status = i40e_aq_set_phy_config(hw, &config, NULL);
 		if (status) {
 			netdev_info(netdev,
-				    "Set phy config failed, err %s aq_err %s\n",
-				    i40e_stat_str(hw, status),
+				    "Set phy config failed, err %d aq_err %s\n",
+				    status,
 				    i40e_aq_str(hw, hw->aq.asq_last_status));
 			err = -EAGAIN;
 			goto done;
@@ -1463,8 +1463,8 @@ static int i40e_set_link_ksettings(struc
 		status = i40e_update_link_info(hw);
 		if (status)
 			netdev_dbg(netdev,
-				   "Updating link info failed with err %s aq_err %s\n",
-				   i40e_stat_str(hw, status),
+				   "Updating link info failed with err %d aq_err %s\n",
+				   status,
 				   i40e_aq_str(hw, hw->aq.asq_last_status));
 
 	} else {
@@ -1515,8 +1515,8 @@ static int i40e_set_fec_cfg(struct net_d
 		status = i40e_aq_set_phy_config(hw, &config, NULL);
 		if (status) {
 			netdev_info(netdev,
-				    "Set phy config failed, err %s aq_err %s\n",
-				    i40e_stat_str(hw, status),
+				    "Set phy config failed, err %d aq_err %s\n",
+				    status,
 				    i40e_aq_str(hw, hw->aq.asq_last_status));
 			err = -EAGAIN;
 			goto done;
@@ -1529,8 +1529,8 @@ static int i40e_set_fec_cfg(struct net_d
 			 * (e.g. no physical connection etc.)
 			 */
 			netdev_dbg(netdev,
-				   "Updating link info failed with err %s aq_err %s\n",
-				   i40e_stat_str(hw, status),
+				   "Updating link info failed with err %d aq_err %s\n",
+				   status,
 				   i40e_aq_str(hw, hw->aq.asq_last_status));
 	}
 
@@ -1636,8 +1636,8 @@ static int i40e_nway_reset(struct net_de
 
 	ret = i40e_aq_set_link_restart_an(hw, link_up, NULL);
 	if (ret) {
-		netdev_info(netdev, "link restart failed, err %s aq_err %s\n",
-			    i40e_stat_str(hw, ret),
+		netdev_info(netdev, "link restart failed, err %d aq_err %s\n",
+			    ret,
 			    i40e_aq_str(hw, hw->aq.asq_last_status));
 		return -EIO;
 	}
@@ -1753,20 +1753,20 @@ static int i40e_set_pauseparam(struct ne
 	status = i40e_set_fc(hw, &aq_failures, link_up);
 
 	if (aq_failures & I40E_SET_FC_AQ_FAIL_GET) {
-		netdev_info(netdev, "Set fc failed on the get_phy_capabilities call with err %s aq_err %s\n",
-			    i40e_stat_str(hw, status),
+		netdev_info(netdev, "Set fc failed on the get_phy_capabilities call with err %d aq_err %s\n",
+			    status,
 			    i40e_aq_str(hw, hw->aq.asq_last_status));
 		err = -EAGAIN;
 	}
 	if (aq_failures & I40E_SET_FC_AQ_FAIL_SET) {
-		netdev_info(netdev, "Set fc failed on the set_phy_config call with err %s aq_err %s\n",
-			    i40e_stat_str(hw, status),
+		netdev_info(netdev, "Set fc failed on the set_phy_config call with err %d aq_err %s\n",
+			    status,
 			    i40e_aq_str(hw, hw->aq.asq_last_status));
 		err = -EAGAIN;
 	}
 	if (aq_failures & I40E_SET_FC_AQ_FAIL_UPDATE) {
-		netdev_info(netdev, "Set fc failed on the get_link_info call with err %s aq_err %s\n",
-			    i40e_stat_str(hw, status),
+		netdev_info(netdev, "Set fc failed on the get_link_info call with err %d aq_err %s\n",
+			    status,
 			    i40e_aq_str(hw, hw->aq.asq_last_status));
 		err = -EAGAIN;
 	}
@@ -5360,8 +5360,8 @@ flags_complete:
 						0, NULL);
 		if (ret && pf->hw.aq.asq_last_status != I40E_AQ_RC_ESRCH) {
 			dev_info(&pf->pdev->dev,
-				 "couldn't set switch config bits, err %s aq_err %s\n",
-				 i40e_stat_str(&pf->hw, ret),
+				 "couldn't set switch config bits, err %d aq_err %s\n",
+				 ret,
 				 i40e_aq_str(&pf->hw,
 					     pf->hw.aq.asq_last_status));
 			/* not a fatal problem, just keep going */
@@ -5433,9 +5433,8 @@ flags_complete:
 					return -EBUSY;
 				default:
 					dev_warn(&pf->pdev->dev,
-						 "Starting FW LLDP agent failed: error: %s, %s\n",
-						 i40e_stat_str(&pf->hw,
-							       status),
+						 "Starting FW LLDP agent failed: error: %d, %s\n",
+						 status,
 						 i40e_aq_str(&pf->hw,
 							     adq_err));
 					return -EINVAL;
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1822,8 +1822,8 @@ static int i40e_set_mac(struct net_devic
 		ret = i40e_aq_mac_address_write(hw, I40E_AQC_WRITE_TYPE_LAA_WOL,
 						addr->sa_data, NULL);
 		if (ret)
-			netdev_info(netdev, "Ignoring error from firmware on LAA update, status %s, AQ ret %s\n",
-				    i40e_stat_str(hw, ret),
+			netdev_info(netdev, "Ignoring error from firmware on LAA update, status %d, AQ ret %s\n",
+				    ret,
 				    i40e_aq_str(hw, hw->aq.asq_last_status));
 	}
 
@@ -1854,8 +1854,8 @@ static int i40e_config_rss_aq(struct i40
 		ret = i40e_aq_set_rss_key(hw, vsi->id, seed_dw);
 		if (ret) {
 			dev_info(&pf->pdev->dev,
-				 "Cannot set RSS key, err %s aq_err %s\n",
-				 i40e_stat_str(hw, ret),
+				 "Cannot set RSS key, err %d aq_err %s\n",
+				 ret,
 				 i40e_aq_str(hw, hw->aq.asq_last_status));
 			return ret;
 		}
@@ -1866,8 +1866,8 @@ static int i40e_config_rss_aq(struct i40
 		ret = i40e_aq_set_rss_lut(hw, vsi->id, pf_lut, lut, lut_size);
 		if (ret) {
 			dev_info(&pf->pdev->dev,
-				 "Cannot set RSS lut, err %s aq_err %s\n",
-				 i40e_stat_str(hw, ret),
+				 "Cannot set RSS lut, err %d aq_err %s\n",
+				 ret,
 				 i40e_aq_str(hw, hw->aq.asq_last_status));
 			return ret;
 		}
@@ -2358,8 +2358,8 @@ void i40e_aqc_del_filters(struct i40e_vs
 	if (aq_ret && !(aq_status == I40E_AQ_RC_ENOENT)) {
 		*retval = -EIO;
 		dev_info(&vsi->back->pdev->dev,
-			 "ignoring delete macvlan error on %s, err %s, aq_err %s\n",
-			 vsi_name, i40e_stat_str(hw, aq_ret),
+			 "ignoring delete macvlan error on %s, err %d, aq_err %s\n",
+			 vsi_name, aq_ret,
 			 i40e_aq_str(hw, aq_status));
 	}
 }
@@ -2488,8 +2488,8 @@ static int i40e_set_promiscuous(struct i
 							   NULL);
 		if (aq_ret) {
 			dev_info(&pf->pdev->dev,
-				 "Set default VSI failed, err %s, aq_err %s\n",
-				 i40e_stat_str(hw, aq_ret),
+				 "Set default VSI failed, err %d, aq_err %s\n",
+				 aq_ret,
 				 i40e_aq_str(hw, hw->aq.asq_last_status));
 		}
 	} else {
@@ -2500,8 +2500,8 @@ static int i40e_set_promiscuous(struct i
 						  true);
 		if (aq_ret) {
 			dev_info(&pf->pdev->dev,
-				 "set unicast promisc failed, err %s, aq_err %s\n",
-				 i40e_stat_str(hw, aq_ret),
+				 "set unicast promisc failed, err %d, aq_err %s\n",
+				 aq_ret,
 				 i40e_aq_str(hw, hw->aq.asq_last_status));
 		}
 		aq_ret = i40e_aq_set_vsi_multicast_promiscuous(
@@ -2510,8 +2510,8 @@ static int i40e_set_promiscuous(struct i
 						  promisc, NULL);
 		if (aq_ret) {
 			dev_info(&pf->pdev->dev,
-				 "set multicast promisc failed, err %s, aq_err %s\n",
-				 i40e_stat_str(hw, aq_ret),
+				 "set multicast promisc failed, err %d, aq_err %s\n",
+				 aq_ret,
 				 i40e_aq_str(hw, hw->aq.asq_last_status));
 		}
 	}
@@ -2814,9 +2814,9 @@ int i40e_sync_vsi_filters(struct i40e_vs
 			retval = i40e_aq_rc_to_posix(aq_ret,
 						     hw->aq.asq_last_status);
 			dev_info(&pf->pdev->dev,
-				 "set multi promisc failed on %s, err %s aq_err %s\n",
+				 "set multi promisc failed on %s, err %d aq_err %s\n",
 				 vsi_name,
-				 i40e_stat_str(hw, aq_ret),
+				 aq_ret,
 				 i40e_aq_str(hw, hw->aq.asq_last_status));
 		} else {
 			dev_info(&pf->pdev->dev, "%s allmulti mode.\n",
@@ -2834,10 +2834,10 @@ int i40e_sync_vsi_filters(struct i40e_vs
 			retval = i40e_aq_rc_to_posix(aq_ret,
 						     hw->aq.asq_last_status);
 			dev_info(&pf->pdev->dev,
-				 "Setting promiscuous %s failed on %s, err %s aq_err %s\n",
+				 "Setting promiscuous %s failed on %s, err %d aq_err %s\n",
 				 cur_promisc ? "on" : "off",
 				 vsi_name,
-				 i40e_stat_str(hw, aq_ret),
+				 aq_ret,
 				 i40e_aq_str(hw, hw->aq.asq_last_status));
 		}
 	}
@@ -2985,8 +2985,8 @@ void i40e_vlan_stripping_enable(struct i
 	ret = i40e_aq_update_vsi_params(&vsi->back->hw, &ctxt, NULL);
 	if (ret) {
 		dev_info(&vsi->back->pdev->dev,
-			 "update vlan stripping failed, err %s aq_err %s\n",
-			 i40e_stat_str(&vsi->back->hw, ret),
+			 "update vlan stripping failed, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&vsi->back->hw,
 				     vsi->back->hw.aq.asq_last_status));
 	}
@@ -3020,8 +3020,8 @@ void i40e_vlan_stripping_disable(struct
 	ret = i40e_aq_update_vsi_params(&vsi->back->hw, &ctxt, NULL);
 	if (ret) {
 		dev_info(&vsi->back->pdev->dev,
-			 "update vlan stripping failed, err %s aq_err %s\n",
-			 i40e_stat_str(&vsi->back->hw, ret),
+			 "update vlan stripping failed, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&vsi->back->hw,
 				     vsi->back->hw.aq.asq_last_status));
 	}
@@ -3265,8 +3265,8 @@ int i40e_vsi_add_pvid(struct i40e_vsi *v
 	ret = i40e_aq_update_vsi_params(&vsi->back->hw, &ctxt, NULL);
 	if (ret) {
 		dev_info(&vsi->back->pdev->dev,
-			 "add pvid failed, err %s aq_err %s\n",
-			 i40e_stat_str(&vsi->back->hw, ret),
+			 "add pvid failed, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&vsi->back->hw,
 				     vsi->back->hw.aq.asq_last_status));
 		return -ENOENT;
@@ -5532,8 +5532,8 @@ static int i40e_vsi_get_bw_info(struct i
 	ret = i40e_aq_query_vsi_bw_config(hw, vsi->seid, &bw_config, NULL);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "couldn't get PF vsi bw config, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "couldn't get PF vsi bw config, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		return -EINVAL;
 	}
@@ -5543,8 +5543,8 @@ static int i40e_vsi_get_bw_info(struct i
 					       NULL);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "couldn't get PF vsi ets bw config, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "couldn't get PF vsi ets bw config, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		return -EINVAL;
 	}
@@ -5733,8 +5733,8 @@ int i40e_update_adq_vsi_queues(struct i4
 
 	ret = i40e_aq_update_vsi_params(hw, &ctxt, NULL);
 	if (ret) {
-		dev_info(&pf->pdev->dev, "Update vsi config failed, err %s aq_err %s\n",
-			 i40e_stat_str(hw, ret),
+		dev_info(&pf->pdev->dev, "Update vsi config failed, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(hw, hw->aq.asq_last_status));
 		return ret;
 	}
@@ -5789,8 +5789,8 @@ static int i40e_vsi_config_tc(struct i40
 						  &bw_config, NULL);
 		if (ret) {
 			dev_info(&pf->pdev->dev,
-				 "Failed querying vsi bw info, err %s aq_err %s\n",
-				 i40e_stat_str(hw, ret),
+				 "Failed querying vsi bw info, err %d aq_err %s\n",
+				 ret,
 				 i40e_aq_str(hw, hw->aq.asq_last_status));
 			goto out;
 		}
@@ -5856,8 +5856,8 @@ static int i40e_vsi_config_tc(struct i40
 	ret = i40e_aq_update_vsi_params(hw, &ctxt, NULL);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "Update vsi tc config failed, err %s aq_err %s\n",
-			 i40e_stat_str(hw, ret),
+			 "Update vsi tc config failed, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(hw, hw->aq.asq_last_status));
 		goto out;
 	}
@@ -5869,8 +5869,8 @@ static int i40e_vsi_config_tc(struct i40
 	ret = i40e_vsi_get_bw_info(vsi);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "Failed updating vsi bw info, err %s aq_err %s\n",
-			 i40e_stat_str(hw, ret),
+			 "Failed updating vsi bw info, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(hw, hw->aq.asq_last_status));
 		goto out;
 	}
@@ -5961,8 +5961,8 @@ int i40e_set_bw_limit(struct i40e_vsi *v
 					  I40E_MAX_BW_INACTIVE_ACCUM, NULL);
 	if (ret)
 		dev_err(&pf->pdev->dev,
-			"Failed set tx rate (%llu Mbps) for vsi->seid %u, err %s aq_err %s\n",
-			max_tx_rate, seid, i40e_stat_str(&pf->hw, ret),
+			"Failed set tx rate (%llu Mbps) for vsi->seid %u, err %d aq_err %s\n",
+			max_tx_rate, seid, ret,
 			i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 	return ret;
 }
@@ -6037,8 +6037,8 @@ static void i40e_remove_queue_channels(s
 			last_aq_status = pf->hw.aq.asq_last_status;
 			if (ret)
 				dev_info(&pf->pdev->dev,
-					 "Failed to delete cloud filter, err %s aq_err %s\n",
-					 i40e_stat_str(&pf->hw, ret),
+					 "Failed to delete cloud filter, err %d aq_err %s\n",
+					 ret,
 					 i40e_aq_str(&pf->hw, last_aq_status));
 			kfree(cfilter);
 		}
@@ -6172,8 +6172,8 @@ static int i40e_vsi_reconfig_rss(struct
 	ret = i40e_config_rss(vsi, seed, lut, vsi->rss_table_size);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "Cannot set RSS lut, err %s aq_err %s\n",
-			 i40e_stat_str(hw, ret),
+			 "Cannot set RSS lut, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(hw, hw->aq.asq_last_status));
 		kfree(lut);
 		return ret;
@@ -6271,8 +6271,8 @@ static int i40e_add_channel(struct i40e_
 	ret = i40e_aq_add_vsi(hw, &ctxt, NULL);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "add new vsi failed, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "add new vsi failed, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw,
 				     pf->hw.aq.asq_last_status));
 		return -ENOENT;
@@ -6517,8 +6517,8 @@ static int i40e_validate_and_set_switch_
 					mode, NULL);
 	if (ret && hw->aq.asq_last_status != I40E_AQ_RC_ESRCH)
 		dev_err(&pf->pdev->dev,
-			"couldn't set switch config bits, err %s aq_err %s\n",
-			i40e_stat_str(hw, ret),
+			"couldn't set switch config bits, err %d aq_err %s\n",
+			ret,
 			i40e_aq_str(hw,
 				    hw->aq.asq_last_status));
 
@@ -6718,8 +6718,8 @@ int i40e_veb_config_tc(struct i40e_veb *
 						   &bw_data, NULL);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "VEB bw config failed, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "VEB bw config failed, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		goto out;
 	}
@@ -6728,8 +6728,8 @@ int i40e_veb_config_tc(struct i40e_veb *
 	ret = i40e_veb_get_bw_info(veb);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "Failed getting veb bw config, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "Failed getting veb bw config, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 	}
 
@@ -6812,8 +6812,8 @@ static int i40e_resume_port_tx(struct i4
 	ret = i40e_aq_resume_port_tx(hw, NULL);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "Resume Port Tx failed, err %s aq_err %s\n",
-			  i40e_stat_str(&pf->hw, ret),
+			 "Resume Port Tx failed, err %d aq_err %s\n",
+			  ret,
 			  i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		/* Schedule PF reset to recover */
 		set_bit(__I40E_PF_RESET_REQUESTED, pf->state);
@@ -6837,8 +6837,8 @@ static int i40e_suspend_port_tx(struct i
 	ret = i40e_aq_suspend_port_tx(hw, pf->mac_seid, NULL);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "Suspend Port Tx failed, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "Suspend Port Tx failed, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		/* Schedule PF reset to recover */
 		set_bit(__I40E_PF_RESET_REQUESTED, pf->state);
@@ -6877,8 +6877,8 @@ static int i40e_hw_set_dcb_config(struct
 	ret = i40e_set_dcb_config(&pf->hw);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "Set DCB Config failed, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "Set DCB Config failed, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		goto out;
 	}
@@ -6994,8 +6994,8 @@ int i40e_hw_dcb_config(struct i40e_pf *p
 		 i40e_aqc_opc_modify_switching_comp_ets, NULL);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "Modify Port ETS failed, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "Modify Port ETS failed, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		goto out;
 	}
@@ -7032,8 +7032,8 @@ int i40e_hw_dcb_config(struct i40e_pf *p
 	ret = i40e_aq_dcb_updated(&pf->hw, NULL);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "DCB Updated failed, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "DCB Updated failed, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		goto out;
 	}
@@ -7116,8 +7116,8 @@ int i40e_dcb_sw_default_config(struct i4
 		 i40e_aqc_opc_enable_switching_comp_ets, NULL);
 	if (err) {
 		dev_info(&pf->pdev->dev,
-			 "Enable Port ETS failed, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, err),
+			 "Enable Port ETS failed, err %d aq_err %s\n",
+			 err,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		err = -ENOENT;
 		goto out;
@@ -7196,8 +7196,8 @@ static int i40e_init_pf_dcb(struct i40e_
 		pf->flags |= I40E_FLAG_DISABLE_FW_LLDP;
 	} else {
 		dev_info(&pf->pdev->dev,
-			 "Query for DCB configuration failed, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, err),
+			 "Query for DCB configuration failed, err %d aq_err %s\n",
+			 err,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 	}
 
@@ -7435,8 +7435,8 @@ static i40e_status i40e_force_link_state
 					   NULL);
 	if (err) {
 		dev_err(&pf->pdev->dev,
-			"failed to get phy cap., ret =  %s last_status =  %s\n",
-			i40e_stat_str(hw, err),
+			"failed to get phy cap., ret =  %d last_status =  %s\n",
+			err,
 			i40e_aq_str(hw, hw->aq.asq_last_status));
 		return err;
 	}
@@ -7447,8 +7447,8 @@ static i40e_status i40e_force_link_state
 					   NULL);
 	if (err) {
 		dev_err(&pf->pdev->dev,
-			"failed to get phy cap., ret =  %s last_status =  %s\n",
-			i40e_stat_str(hw, err),
+			"failed to get phy cap., ret =  %d last_status =  %s\n",
+			err,
 			i40e_aq_str(hw, hw->aq.asq_last_status));
 		return err;
 	}
@@ -7492,8 +7492,8 @@ static i40e_status i40e_force_link_state
 
 	if (err) {
 		dev_err(&pf->pdev->dev,
-			"set phy config ret =  %s last_status =  %s\n",
-			i40e_stat_str(&pf->hw, err),
+			"set phy config ret =  %d last_status =  %s\n",
+			err,
 			i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		return err;
 	}
@@ -7833,8 +7833,8 @@ static int i40e_fwd_ring_up(struct i40e_
 			rx_ring->netdev = NULL;
 		}
 		dev_info(&pf->pdev->dev,
-			 "Error adding mac filter on macvlan err %s, aq_err %s\n",
-			  i40e_stat_str(hw, ret),
+			 "Error adding mac filter on macvlan err %d, aq_err %s\n",
+			  ret,
 			  i40e_aq_str(hw, aq_err));
 		netdev_err(vdev, "L2fwd offload disabled to L2 filter error\n");
 	}
@@ -7906,8 +7906,8 @@ static int i40e_setup_macvlans(struct i4
 	ret = i40e_aq_update_vsi_params(hw, &ctxt, NULL);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "Update vsi tc config failed, err %s aq_err %s\n",
-			 i40e_stat_str(hw, ret),
+			 "Update vsi tc config failed, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(hw, hw->aq.asq_last_status));
 		return ret;
 	}
@@ -8122,8 +8122,8 @@ static void i40e_fwd_del(struct net_devi
 				ch->fwd = NULL;
 			} else {
 				dev_info(&pf->pdev->dev,
-					 "Error deleting mac filter on macvlan err %s, aq_err %s\n",
-					  i40e_stat_str(hw, ret),
+					 "Error deleting mac filter on macvlan err %d, aq_err %s\n",
+					  ret,
 					  i40e_aq_str(hw, aq_err));
 			}
 			break;
@@ -8874,8 +8874,7 @@ static int i40e_delete_clsflower(struct
 	kfree(filter);
 	if (err) {
 		dev_err(&pf->pdev->dev,
-			"Failed to delete cloud filter, err %s\n",
-			i40e_stat_str(&pf->hw, err));
+			"Failed to delete cloud filter, err %d\n", err);
 		return i40e_aq_rc_to_posix(err, pf->hw.aq.asq_last_status);
 	}
 
@@ -9437,8 +9436,8 @@ static int i40e_handle_lldp_event(struct
 			pf->flags &= ~I40E_FLAG_DCB_CAPABLE;
 		} else {
 			dev_info(&pf->pdev->dev,
-				 "Failed querying DCB configuration data from firmware, err %s aq_err %s\n",
-				 i40e_stat_str(&pf->hw, ret),
+				 "Failed querying DCB configuration data from firmware, err %d aq_err %s\n",
+				 ret,
 				 i40e_aq_str(&pf->hw,
 					     pf->hw.aq.asq_last_status));
 		}
@@ -10264,8 +10263,8 @@ static void i40e_enable_pf_switch_lb(str
 	ret = i40e_aq_get_vsi_params(&pf->hw, &ctxt, NULL);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "couldn't get PF vsi config, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "couldn't get PF vsi config, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		return;
 	}
@@ -10276,8 +10275,8 @@ static void i40e_enable_pf_switch_lb(str
 	ret = i40e_aq_update_vsi_params(&vsi->back->hw, &ctxt, NULL);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "update vsi switch failed, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "update vsi switch failed, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 	}
 }
@@ -10300,8 +10299,8 @@ static void i40e_disable_pf_switch_lb(st
 	ret = i40e_aq_get_vsi_params(&pf->hw, &ctxt, NULL);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "couldn't get PF vsi config, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "couldn't get PF vsi config, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		return;
 	}
@@ -10312,8 +10311,8 @@ static void i40e_disable_pf_switch_lb(st
 	ret = i40e_aq_update_vsi_params(&vsi->back->hw, &ctxt, NULL);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "update vsi switch failed, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "update vsi switch failed, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 	}
 }
@@ -10457,8 +10456,8 @@ static int i40e_get_capabilities(struct
 			buf_len = data_size;
 		} else if (pf->hw.aq.asq_last_status != I40E_AQ_RC_OK || err) {
 			dev_info(&pf->pdev->dev,
-				 "capability discovery failed, err %s aq_err %s\n",
-				 i40e_stat_str(&pf->hw, err),
+				 "capability discovery failed, err %d aq_err %s\n",
+				 err,
 				 i40e_aq_str(&pf->hw,
 					     pf->hw.aq.asq_last_status));
 			return -ENODEV;
@@ -10595,8 +10594,8 @@ static int i40e_rebuild_cloud_filters(st
 
 		if (ret) {
 			dev_dbg(&pf->pdev->dev,
-				"Failed to rebuild cloud filter, err %s aq_err %s\n",
-				i40e_stat_str(&pf->hw, ret),
+				"Failed to rebuild cloud filter, err %d aq_err %s\n",
+				ret,
 				i40e_aq_str(&pf->hw,
 					    pf->hw.aq.asq_last_status));
 			return ret;
@@ -10836,8 +10835,8 @@ static void i40e_rebuild(struct i40e_pf
 	/* rebuild the basics for the AdminQ, HMC, and initial HW switch */
 	ret = i40e_init_adminq(&pf->hw);
 	if (ret) {
-		dev_info(&pf->pdev->dev, "Rebuild AdminQ failed, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+		dev_info(&pf->pdev->dev, "Rebuild AdminQ failed, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		goto clear_recovery;
 	}
@@ -10948,8 +10947,8 @@ static void i40e_rebuild(struct i40e_pf
 					 I40E_AQ_EVENT_MEDIA_NA |
 					 I40E_AQ_EVENT_MODULE_QUAL_FAIL), NULL);
 	if (ret)
-		dev_info(&pf->pdev->dev, "set phy mask fail, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+		dev_info(&pf->pdev->dev, "set phy mask fail, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 
 	/* Rebuild the VSIs and VEBs that existed before reset.
@@ -11052,8 +11051,8 @@ static void i40e_rebuild(struct i40e_pf
 		msleep(75);
 		ret = i40e_aq_set_link_restart_an(&pf->hw, true, NULL);
 		if (ret)
-			dev_info(&pf->pdev->dev, "link restart failed, err %s aq_err %s\n",
-				 i40e_stat_str(&pf->hw, ret),
+			dev_info(&pf->pdev->dev, "link restart failed, err %d aq_err %s\n",
+				 ret,
 				 i40e_aq_str(&pf->hw,
 					     pf->hw.aq.asq_last_status));
 	}
@@ -11084,9 +11083,9 @@ static void i40e_rebuild(struct i40e_pf
 	ret = i40e_set_promiscuous(pf, pf->cur_promisc);
 	if (ret)
 		dev_warn(&pf->pdev->dev,
-			 "Failed to restore promiscuous setting: %s, err %s aq_err %s\n",
+			 "Failed to restore promiscuous setting: %s, err %d aq_err %s\n",
 			 pf->cur_promisc ? "on" : "off",
-			 i40e_stat_str(&pf->hw, ret),
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 
 	i40e_reset_all_vfs(pf, true);
@@ -12220,8 +12219,8 @@ static int i40e_get_rss_aq(struct i40e_v
 			(struct i40e_aqc_get_set_rss_key_data *)seed);
 		if (ret) {
 			dev_info(&pf->pdev->dev,
-				 "Cannot get RSS key, err %s aq_err %s\n",
-				 i40e_stat_str(&pf->hw, ret),
+				 "Cannot get RSS key, err %d aq_err %s\n",
+				 ret,
 				 i40e_aq_str(&pf->hw,
 					     pf->hw.aq.asq_last_status));
 			return ret;
@@ -12234,8 +12233,8 @@ static int i40e_get_rss_aq(struct i40e_v
 		ret = i40e_aq_get_rss_lut(hw, vsi->id, pf_lut, lut, lut_size);
 		if (ret) {
 			dev_info(&pf->pdev->dev,
-				 "Cannot get RSS lut, err %s aq_err %s\n",
-				 i40e_stat_str(&pf->hw, ret),
+				 "Cannot get RSS lut, err %d aq_err %s\n",
+				 ret,
 				 i40e_aq_str(&pf->hw,
 					     pf->hw.aq.asq_last_status));
 			return ret;
@@ -12575,8 +12574,8 @@ i40e_status i40e_commit_partition_bw_set
 	last_aq_status = pf->hw.aq.asq_last_status;
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "Cannot acquire NVM for read access, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "Cannot acquire NVM for read access, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, last_aq_status));
 		goto bw_commit_out;
 	}
@@ -12592,8 +12591,8 @@ i40e_status i40e_commit_partition_bw_set
 	last_aq_status = pf->hw.aq.asq_last_status;
 	i40e_release_nvm(&pf->hw);
 	if (ret) {
-		dev_info(&pf->pdev->dev, "NVM read error, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+		dev_info(&pf->pdev->dev, "NVM read error, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, last_aq_status));
 		goto bw_commit_out;
 	}
@@ -12606,8 +12605,8 @@ i40e_status i40e_commit_partition_bw_set
 	last_aq_status = pf->hw.aq.asq_last_status;
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "Cannot acquire NVM for write access, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "Cannot acquire NVM for write access, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, last_aq_status));
 		goto bw_commit_out;
 	}
@@ -12626,8 +12625,8 @@ i40e_status i40e_commit_partition_bw_set
 	i40e_release_nvm(&pf->hw);
 	if (ret)
 		dev_info(&pf->pdev->dev,
-			 "BW settings NOT SAVED, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "BW settings NOT SAVED, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, last_aq_status));
 bw_commit_out:
 
@@ -12681,8 +12680,8 @@ static bool i40e_is_total_port_shutdown_
 
 err_nvm:
 	dev_warn(&pf->pdev->dev,
-		 "total-port-shutdown feature is off due to read nvm error: %s\n",
-		 i40e_stat_str(&pf->hw, read_status));
+		 "total-port-shutdown feature is off due to read nvm error: %d\n",
+		 read_status);
 	return ret;
 }
 
@@ -13009,8 +13008,8 @@ static int i40e_udp_tunnel_set_port(stru
 	ret = i40e_aq_add_udp_tunnel(hw, ntohs(ti->port), type, &filter_index,
 				     NULL);
 	if (ret) {
-		netdev_info(netdev, "add UDP port failed, err %s aq_err %s\n",
-			    i40e_stat_str(hw, ret),
+		netdev_info(netdev, "add UDP port failed, err %d aq_err %s\n",
+			    ret,
 			    i40e_aq_str(hw, hw->aq.asq_last_status));
 		return -EIO;
 	}
@@ -13029,8 +13028,8 @@ static int i40e_udp_tunnel_unset_port(st
 
 	ret = i40e_aq_del_udp_tunnel(hw, ti->hw_priv, NULL);
 	if (ret) {
-		netdev_info(netdev, "delete UDP port failed, err %s aq_err %s\n",
-			    i40e_stat_str(hw, ret),
+		netdev_info(netdev, "delete UDP port failed, err %d aq_err %s\n",
+			    ret,
 			    i40e_aq_str(hw, hw->aq.asq_last_status));
 		return -EIO;
 	}
@@ -13919,8 +13918,8 @@ static int i40e_add_vsi(struct i40e_vsi
 		ctxt.flags = I40E_AQ_VSI_TYPE_PF;
 		if (ret) {
 			dev_info(&pf->pdev->dev,
-				 "couldn't get PF vsi config, err %s aq_err %s\n",
-				 i40e_stat_str(&pf->hw, ret),
+				 "couldn't get PF vsi config, err %d aq_err %s\n",
+				 ret,
 				 i40e_aq_str(&pf->hw,
 					     pf->hw.aq.asq_last_status));
 			return -ENOENT;
@@ -13949,8 +13948,8 @@ static int i40e_add_vsi(struct i40e_vsi
 			ret = i40e_aq_update_vsi_params(hw, &ctxt, NULL);
 			if (ret) {
 				dev_info(&pf->pdev->dev,
-					 "update vsi failed, err %s aq_err %s\n",
-					 i40e_stat_str(&pf->hw, ret),
+					 "update vsi failed, err %d aq_err %s\n",
+					 ret,
 					 i40e_aq_str(&pf->hw,
 						     pf->hw.aq.asq_last_status));
 				ret = -ENOENT;
@@ -13969,8 +13968,8 @@ static int i40e_add_vsi(struct i40e_vsi
 			ret = i40e_aq_update_vsi_params(hw, &ctxt, NULL);
 			if (ret) {
 				dev_info(&pf->pdev->dev,
-					 "update vsi failed, err %s aq_err %s\n",
-					 i40e_stat_str(&pf->hw, ret),
+					 "update vsi failed, err %d aq_err %s\n",
+					 ret,
 					 i40e_aq_str(&pf->hw,
 						    pf->hw.aq.asq_last_status));
 				ret = -ENOENT;
@@ -13992,9 +13991,9 @@ static int i40e_add_vsi(struct i40e_vsi
 				 * message and continue
 				 */
 				dev_info(&pf->pdev->dev,
-					 "failed to configure TCs for main VSI tc_map 0x%08x, err %s aq_err %s\n",
+					 "failed to configure TCs for main VSI tc_map 0x%08x, err %d aq_err %s\n",
 					 enabled_tc,
-					 i40e_stat_str(&pf->hw, ret),
+					 ret,
 					 i40e_aq_str(&pf->hw,
 						    pf->hw.aq.asq_last_status));
 			}
@@ -14088,8 +14087,8 @@ static int i40e_add_vsi(struct i40e_vsi
 		ret = i40e_aq_add_vsi(hw, &ctxt, NULL);
 		if (ret) {
 			dev_info(&vsi->back->pdev->dev,
-				 "add vsi failed, err %s aq_err %s\n",
-				 i40e_stat_str(&pf->hw, ret),
+				 "add vsi failed, err %d aq_err %s\n",
+				 ret,
 				 i40e_aq_str(&pf->hw,
 					     pf->hw.aq.asq_last_status));
 			ret = -ENOENT;
@@ -14120,8 +14119,8 @@ static int i40e_add_vsi(struct i40e_vsi
 	ret = i40e_vsi_get_bw_info(vsi);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "couldn't get vsi bw info, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "couldn't get vsi bw info, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		/* VSI is already added so not tearing that up */
 		ret = 0;
@@ -14567,8 +14566,8 @@ static int i40e_veb_get_bw_info(struct i
 						  &bw_data, NULL);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "query veb bw config failed, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "query veb bw config failed, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, hw->aq.asq_last_status));
 		goto out;
 	}
@@ -14577,8 +14576,8 @@ static int i40e_veb_get_bw_info(struct i
 						   &ets_data, NULL);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "query veb bw ets config failed, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "query veb bw ets config failed, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, hw->aq.asq_last_status));
 		goto out;
 	}
@@ -14774,8 +14773,8 @@ static int i40e_add_veb(struct i40e_veb
 	/* get a VEB from the hardware */
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "couldn't add VEB, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "couldn't add VEB, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		return -EPERM;
 	}
@@ -14785,16 +14784,16 @@ static int i40e_add_veb(struct i40e_veb
 					 &veb->stats_idx, NULL, NULL, NULL);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "couldn't get VEB statistics idx, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "couldn't get VEB statistics idx, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		return -EPERM;
 	}
 	ret = i40e_veb_get_bw_info(veb);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "couldn't get VEB bw info, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "couldn't get VEB bw info, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		i40e_aq_delete_element(&pf->hw, veb->seid, NULL);
 		return -ENOENT;
@@ -15004,8 +15003,8 @@ int i40e_fetch_switch_configuration(stru
 						&next_seid, NULL);
 		if (ret) {
 			dev_info(&pf->pdev->dev,
-				 "get switch config failed err %s aq_err %s\n",
-				 i40e_stat_str(&pf->hw, ret),
+				 "get switch config failed err %d aq_err %s\n",
+				 ret,
 				 i40e_aq_str(&pf->hw,
 					     pf->hw.aq.asq_last_status));
 			kfree(aq_buf);
@@ -15050,8 +15049,8 @@ static int i40e_setup_pf_switch(struct i
 	ret = i40e_fetch_switch_configuration(pf, false);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "couldn't fetch switch config, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "couldn't fetch switch config, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		return ret;
 	}
@@ -15077,8 +15076,8 @@ static int i40e_setup_pf_switch(struct i
 						NULL);
 		if (ret && pf->hw.aq.asq_last_status != I40E_AQ_RC_ESRCH) {
 			dev_info(&pf->pdev->dev,
-				 "couldn't set switch config bits, err %s aq_err %s\n",
-				 i40e_stat_str(&pf->hw, ret),
+				 "couldn't set switch config bits, err %d aq_err %s\n",
+				 ret,
 				 i40e_aq_str(&pf->hw,
 					     pf->hw.aq.asq_last_status));
 			/* not a fatal problem, just keep going */
@@ -15983,8 +15982,8 @@ static int i40e_probe(struct pci_dev *pd
 					 I40E_AQ_EVENT_MEDIA_NA |
 					 I40E_AQ_EVENT_MODULE_QUAL_FAIL), NULL);
 	if (err)
-		dev_info(&pf->pdev->dev, "set phy mask fail, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, err),
+		dev_info(&pf->pdev->dev, "set phy mask fail, err %d aq_err %s\n",
+			 err,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 
 	/* Reconfigure hardware for allowing smaller MSS in the case
@@ -16002,8 +16001,8 @@ static int i40e_probe(struct pci_dev *pd
 		msleep(75);
 		err = i40e_aq_set_link_restart_an(&pf->hw, true, NULL);
 		if (err)
-			dev_info(&pf->pdev->dev, "link restart failed, err %s aq_err %s\n",
-				 i40e_stat_str(&pf->hw, err),
+			dev_info(&pf->pdev->dev, "link restart failed, err %d aq_err %s\n",
+				 err,
 				 i40e_aq_str(&pf->hw,
 					     pf->hw.aq.asq_last_status));
 	}
@@ -16135,8 +16134,8 @@ static int i40e_probe(struct pci_dev *pd
 	/* get the requested speeds from the fw */
 	err = i40e_aq_get_phy_capabilities(hw, false, false, &abilities, NULL);
 	if (err)
-		dev_dbg(&pf->pdev->dev, "get requested speeds ret =  %s last_status =  %s\n",
-			i40e_stat_str(&pf->hw, err),
+		dev_dbg(&pf->pdev->dev, "get requested speeds ret =  %d last_status =  %s\n",
+			err,
 			i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 	pf->hw.phy.link_info.requested_speeds = abilities.link_speed;
 
@@ -16146,8 +16145,8 @@ static int i40e_probe(struct pci_dev *pd
 	/* get the supported phy types from the fw */
 	err = i40e_aq_get_phy_capabilities(hw, false, true, &abilities, NULL);
 	if (err)
-		dev_dbg(&pf->pdev->dev, "get supported phy types ret =  %s last_status =  %s\n",
-			i40e_stat_str(&pf->hw, err),
+		dev_dbg(&pf->pdev->dev, "get supported phy types ret =  %d last_status =  %s\n",
+			err,
 			i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 
 	/* make sure the MFS hasn't been set lower than the default */
--- a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
@@ -1429,8 +1429,8 @@ static i40e_status i40e_nvmupd_exec_aq(s
 				       buff_size, &cmd_details);
 	if (status) {
 		i40e_debug(hw, I40E_DEBUG_NVM,
-			   "i40e_nvmupd_exec_aq err %s aq_err %s\n",
-			   i40e_stat_str(hw, status),
+			   "%s err %d aq_err %s\n",
+			   __func__, status,
 			   i40e_aq_str(hw, hw->aq.asq_last_status));
 		*perrno = i40e_aq_rc_to_posix(status, hw->aq.asq_last_status);
 		return status;
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -55,7 +55,6 @@ void i40e_idle_aq(struct i40e_hw *hw);
 bool i40e_check_asq_alive(struct i40e_hw *hw);
 i40e_status i40e_aq_queue_shutdown(struct i40e_hw *hw, bool unloading);
 const char *i40e_aq_str(struct i40e_hw *hw, enum i40e_admin_queue_err aq_err);
-const char *i40e_stat_str(struct i40e_hw *hw, i40e_status stat_err);
 
 i40e_status i40e_aq_get_rss_lut(struct i40e_hw *hw, u16 seid,
 				bool pf_lut, u8 *lut, u16 lut_size);
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1264,9 +1264,9 @@ i40e_set_vsi_promisc(struct i40e_vf *vf,
 			int aq_err = pf->hw.aq.asq_last_status;
 
 			dev_err(&pf->pdev->dev,
-				"VF %d failed to set multicast promiscuous mode err %s aq_err %s\n",
+				"VF %d failed to set multicast promiscuous mode err %d aq_err %s\n",
 				vf->vf_id,
-				i40e_stat_str(&pf->hw, aq_ret),
+				aq_ret,
 				i40e_aq_str(&pf->hw, aq_err));
 
 			return aq_ret;
@@ -1280,9 +1280,9 @@ i40e_set_vsi_promisc(struct i40e_vf *vf,
 			int aq_err = pf->hw.aq.asq_last_status;
 
 			dev_err(&pf->pdev->dev,
-				"VF %d failed to set unicast promiscuous mode err %s aq_err %s\n",
+				"VF %d failed to set unicast promiscuous mode err %d aq_err %s\n",
 				vf->vf_id,
-				i40e_stat_str(&pf->hw, aq_ret),
+				aq_ret,
 				i40e_aq_str(&pf->hw, aq_err));
 		}
 
@@ -1297,9 +1297,9 @@ i40e_set_vsi_promisc(struct i40e_vf *vf,
 			int aq_err = pf->hw.aq.asq_last_status;
 
 			dev_err(&pf->pdev->dev,
-				"VF %d failed to set multicast promiscuous mode err %s aq_err %s\n",
+				"VF %d failed to set multicast promiscuous mode err %d aq_err %s\n",
 				vf->vf_id,
-				i40e_stat_str(&pf->hw, aq_ret),
+				aq_ret,
 				i40e_aq_str(&pf->hw, aq_err));
 
 			if (!aq_tmp)
@@ -1313,9 +1313,9 @@ i40e_set_vsi_promisc(struct i40e_vf *vf,
 			int aq_err = pf->hw.aq.asq_last_status;
 
 			dev_err(&pf->pdev->dev,
-				"VF %d failed to set unicast promiscuous mode err %s aq_err %s\n",
+				"VF %d failed to set unicast promiscuous mode err %d aq_err %s\n",
 				vf->vf_id,
-				i40e_stat_str(&pf->hw, aq_ret),
+				aq_ret,
 				i40e_aq_str(&pf->hw, aq_err));
 
 			if (!aq_tmp)
@@ -3615,8 +3615,8 @@ static void i40e_del_all_cloud_filters(s
 			ret = i40e_add_del_cloud_filter(vsi, cfilter, false);
 		if (ret)
 			dev_err(&pf->pdev->dev,
-				"VF %d: Failed to delete cloud filter, err %s aq_err %s\n",
-				vf->vf_id, i40e_stat_str(&pf->hw, ret),
+				"VF %d: Failed to delete cloud filter, err %d aq_err %s\n",
+				vf->vf_id, ret,
 				i40e_aq_str(&pf->hw,
 					    pf->hw.aq.asq_last_status));
 
@@ -3718,8 +3718,8 @@ static int i40e_vc_del_cloud_filter(stru
 		ret = i40e_add_del_cloud_filter(vsi, &cfilter, false);
 	if (ret) {
 		dev_err(&pf->pdev->dev,
-			"VF %d: Failed to delete cloud filter, err %s aq_err %s\n",
-			vf->vf_id, i40e_stat_str(&pf->hw, ret),
+			"VF %d: Failed to delete cloud filter, err %d aq_err %s\n",
+			vf->vf_id, ret,
 			i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		goto err;
 	}
@@ -3852,8 +3852,8 @@ static int i40e_vc_add_cloud_filter(stru
 		ret = i40e_add_del_cloud_filter(vsi, cfilter, true);
 	if (ret) {
 		dev_err(&pf->pdev->dev,
-			"VF %d: Failed to add cloud filter, err %s aq_err %s\n",
-			vf->vf_id, i40e_stat_str(&pf->hw, ret),
+			"VF %d: Failed to add cloud filter, err %d aq_err %s\n",
+			vf->vf_id, ret,
 			i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		goto err_free;
 	}



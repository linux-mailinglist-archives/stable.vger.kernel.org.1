Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB707BDF6D
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376855AbjJIN36 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376690AbjJIN35 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:29:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF2D9C
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:29:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D59C433CA;
        Mon,  9 Oct 2023 13:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858195;
        bh=Lp+XK8Ii4aRisPFZF/zMKaamk3DeMcRG+1goVKNmNLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fKXdQQrMxWBcLFZt9PINa+l0CIOD2eqPgz0eofoQ047gMGj0Z7ZsFTa/lY1YNmu9a
         d7IbOafZokRc5gaC5vel24pyLiqqBk8QpZBzB91LC1syN33HiZJJqwUSbNkQqcDPR6
         yMDzSC26C36eGZak8QKpYdIVAtMOBQagrV/k8BiE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sylwia Wnuczko <sylwia.wnuczko@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 019/131] i40e: Fix for persistent lldp support
Date:   Mon,  9 Oct 2023 15:00:59 +0200
Message-ID: <20231009130116.903993602@linuxfoundation.org>
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

From: Sylwia Wnuczko <sylwia.wnuczko@intel.com>

[ Upstream commit ff9246571a2e79944d6d4d22de4f717081beb5d3 ]

This patch fixes function to read NVM module data and uses it to
read current LLDP agent configuration from NVM API version 1.8.

Signed-off-by: Sylwia Wnuczko <sylwia.wnuczko@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Stable-dep-of: d0d362ffa33d ("i40e: Fix VF VLAN offloading when port VLAN is configured")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_dcb.c    |  4 +-
 drivers/net/ethernet/intel/i40e/i40e_dcb.h    |  3 +
 drivers/net/ethernet/intel/i40e/i40e_nvm.c    | 61 ++++++++++---------
 .../net/ethernet/intel/i40e/i40e_prototype.h  | 10 +--
 4 files changed, 44 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb.c b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
index 200a1cb3b5363..9de503c5f99b3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_dcb.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
@@ -889,7 +889,9 @@ i40e_status i40e_init_dcb(struct i40e_hw *hw, bool enable_mib_change)
 
 		ret = i40e_read_nvm_module_data(hw,
 						I40E_SR_EMP_SR_SETTINGS_PTR,
-						offset, 1,
+						offset,
+						I40E_LLDP_CURRENT_STATUS_OFFSET,
+						I40E_LLDP_CURRENT_STATUS_SIZE,
 						&lldp_cfg.adminstatus);
 	} else {
 		ret = i40e_read_lldp_cfg(hw, &lldp_cfg);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb.h b/drivers/net/ethernet/intel/i40e/i40e_dcb.h
index 2a80c5daa376e..ba86ad833bee8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_dcb.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_dcb.h
@@ -32,6 +32,9 @@
 #define I40E_CEE_MAX_FEAT_TYPE		3
 #define I40E_LLDP_CURRENT_STATUS_XL710_OFFSET	0x2B
 #define I40E_LLDP_CURRENT_STATUS_X722_OFFSET	0x31
+#define I40E_LLDP_CURRENT_STATUS_OFFSET		1
+#define I40E_LLDP_CURRENT_STATUS_SIZE		1
+
 /* Defines for LLDP TLV header */
 #define I40E_LLDP_TLV_LEN_SHIFT		0
 #define I40E_LLDP_TLV_LEN_MASK		(0x01FF << I40E_LLDP_TLV_LEN_SHIFT)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_nvm.c b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
index 37a29b5fc2afd..6b1996451a4bd 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
@@ -323,20 +323,24 @@ i40e_status i40e_read_nvm_word(struct i40e_hw *hw, u16 offset,
 
 /**
  * i40e_read_nvm_module_data - Reads NVM Buffer to specified memory location
- * @hw: pointer to the HW structure
+ * @hw: Pointer to the HW structure
  * @module_ptr: Pointer to module in words with respect to NVM beginning
- * @offset: offset in words from module start
+ * @module_offset: Offset in words from module start
+ * @data_offset: Offset in words from reading data area start
  * @words_data_size: Words to read from NVM
  * @data_ptr: Pointer to memory location where resulting buffer will be stored
  **/
-i40e_status i40e_read_nvm_module_data(struct i40e_hw *hw,
-				      u8 module_ptr, u16 offset,
-				      u16 words_data_size,
-				      u16 *data_ptr)
+enum i40e_status_code i40e_read_nvm_module_data(struct i40e_hw *hw,
+						u8 module_ptr,
+						u16 module_offset,
+						u16 data_offset,
+						u16 words_data_size,
+						u16 *data_ptr)
 {
 	i40e_status status;
+	u16 specific_ptr = 0;
 	u16 ptr_value = 0;
-	u32 flat_offset;
+	u32 offset = 0;
 
 	if (module_ptr != 0) {
 		status = i40e_read_nvm_word(hw, module_ptr, &ptr_value);
@@ -352,36 +356,35 @@ i40e_status i40e_read_nvm_module_data(struct i40e_hw *hw,
 
 	/* Pointer not initialized */
 	if (ptr_value == I40E_NVM_INVALID_PTR_VAL ||
-	    ptr_value == I40E_NVM_INVALID_VAL)
+	    ptr_value == I40E_NVM_INVALID_VAL) {
+		i40e_debug(hw, I40E_DEBUG_ALL, "Pointer not initialized.\n");
 		return I40E_ERR_BAD_PTR;
+	}
 
 	/* Check whether the module is in SR mapped area or outside */
 	if (ptr_value & I40E_PTR_TYPE) {
 		/* Pointer points outside of the Shared RAM mapped area */
-		ptr_value &= ~I40E_PTR_TYPE;
+		i40e_debug(hw, I40E_DEBUG_ALL,
+			   "Reading nvm data failed. Pointer points outside of the Shared RAM mapped area.\n");
 
-		/* PtrValue in 4kB units, need to convert to words */
-		ptr_value /= 2;
-		flat_offset = ((u32)ptr_value * 0x1000) + (u32)offset;
-		status = i40e_acquire_nvm(hw, I40E_RESOURCE_READ);
-		if (!status) {
-			status = i40e_aq_read_nvm(hw, 0, 2 * flat_offset,
-						  2 * words_data_size,
-						  data_ptr, true, NULL);
-			i40e_release_nvm(hw);
-			if (status) {
-				i40e_debug(hw, I40E_DEBUG_ALL,
-					   "Reading nvm aq failed.Error code: %d.\n",
-					   status);
-				return I40E_ERR_NVM;
-			}
-		} else {
-			return I40E_ERR_NVM;
-		}
+		return I40E_ERR_PARAM;
 	} else {
 		/* Read from the Shadow RAM */
-		status = i40e_read_nvm_buffer(hw, ptr_value + offset,
-					      &words_data_size, data_ptr);
+
+		status = i40e_read_nvm_word(hw, ptr_value + module_offset,
+					    &specific_ptr);
+		if (status) {
+			i40e_debug(hw, I40E_DEBUG_ALL,
+				   "Reading nvm word failed.Error code: %d.\n",
+				   status);
+			return I40E_ERR_NVM;
+		}
+
+		offset = ptr_value + module_offset + specific_ptr +
+			data_offset;
+
+		status = i40e_read_nvm_buffer(hw, offset, &words_data_size,
+					      data_ptr);
 		if (status) {
 			i40e_debug(hw, I40E_DEBUG_ALL,
 				   "Reading nvm buffer failed.Error code: %d.\n",
diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index 5250441bf75b8..7effe5010e326 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -315,10 +315,12 @@ i40e_status i40e_acquire_nvm(struct i40e_hw *hw,
 void i40e_release_nvm(struct i40e_hw *hw);
 i40e_status i40e_read_nvm_word(struct i40e_hw *hw, u16 offset,
 					 u16 *data);
-i40e_status i40e_read_nvm_module_data(struct i40e_hw *hw,
-				      u8 module_ptr, u16 offset,
-				      u16 words_data_size,
-				      u16 *data_ptr);
+enum i40e_status_code i40e_read_nvm_module_data(struct i40e_hw *hw,
+						u8 module_ptr,
+						u16 module_offset,
+						u16 data_offset,
+						u16 words_data_size,
+						u16 *data_ptr);
 i40e_status i40e_read_nvm_buffer(struct i40e_hw *hw, u16 offset,
 				 u16 *words, u16 *data);
 i40e_status i40e_update_nvm_checksum(struct i40e_hw *hw);
-- 
2.40.1




Return-Path: <stable+bounces-23073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAA785DF1D
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 15:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A333D1C23D02
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018367A708;
	Wed, 21 Feb 2024 14:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JWbsWxgA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21B369E00;
	Wed, 21 Feb 2024 14:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708525488; cv=none; b=W5TKNLuzpe7MBMFJfII2SjT/sXhxOCCmJHRzSuGJUfLC8G3HCZbHhFylvJp+CKZz2nPZIZmc6ubP5ikzh0A5JmSrPAqPyw+HZrFGkhCQsPt6GoEht0CUbyoh2oKhw6j/mNHqVI8JwGnZdhdiGceJQY4RBbYyfNxVVsZrqn7+AzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708525488; c=relaxed/simple;
	bh=60glTaMiR8CNZeqT6Ck0G70iBiBvwUtoklMvRxM0Atw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VhgUQqgcaPu+r6yLiaegtkB4HR2iGR6KKqkoJjIoieYcVGZoTfVm2RKHBI+edrgQfL63i7ZTe2zllIZG1mQznr2DI9zXuIQadBsDReLosN9QuH49FaI1gqD3bQWqXmImxKXeLPjmuPS1wCZdOd/nMNZtB/dCOe33uvdkTS8tdIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JWbsWxgA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4907C433C7;
	Wed, 21 Feb 2024 14:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708525488;
	bh=60glTaMiR8CNZeqT6Ck0G70iBiBvwUtoklMvRxM0Atw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JWbsWxgAnvMikmFagVP2t7Lx3/wnm5vB+Kfi8FCzK3Goik9HDXeDNEStH+DN/jLzX
	 Sp1ZyWHkkVvm0zIqYcPcN9zZwsdrC86VSjH8anO0GAYVyAMYn+BSTeO3NqJFtRqct7
	 ZZR/g/b83k8sAUVgDuGXiUFzxIPtc8775mnyPDCY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	Sunitha Mekala <sunithax.d.mekala@intel.com>
Subject: [PATCH 5.4 163/267] ixgbe: Refactor overtemp event handling
Date: Wed, 21 Feb 2024 14:08:24 +0100
Message-ID: <20240221125945.206950924@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221125940.058369148@linuxfoundation.org>
References: <20240221125940.058369148@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

[ Upstream commit 6c1b4af8c1b20c70dde01e58381685d6a4a1d2c8 ]

Currently ixgbe driver is notified of overheating events
via internal IXGBE_ERR_OVERTEMP error code.

Change the approach for handle_lasi() to use freshly introduced
is_overtemp function parameter which set when such event occurs.
Change check_overtemp() to bool and return true if overtemp
event occurs.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 16 +++-----
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  | 21 +++++-----
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h  |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 41 +++++++++++--------
 5 files changed, 43 insertions(+), 41 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index f9f1f4153ad6..805aa9f53fc1 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2755,7 +2755,6 @@ static void ixgbe_check_overtemp_subtask(struct ixgbe_adapter *adapter)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
 	u32 eicr = adapter->interrupt_event;
-	s32 rc;
 
 	if (test_bit(__IXGBE_DOWN, &adapter->state))
 		return;
@@ -2789,14 +2788,13 @@ static void ixgbe_check_overtemp_subtask(struct ixgbe_adapter *adapter)
 		}
 
 		/* Check if this is not due to overtemp */
-		if (hw->phy.ops.check_overtemp(hw) != IXGBE_ERR_OVERTEMP)
+		if (!hw->phy.ops.check_overtemp(hw))
 			return;
 
 		break;
 	case IXGBE_DEV_ID_X550EM_A_1G_T:
 	case IXGBE_DEV_ID_X550EM_A_1G_T_L:
-		rc = hw->phy.ops.check_overtemp(hw);
-		if (rc != IXGBE_ERR_OVERTEMP)
+		if (!hw->phy.ops.check_overtemp(hw))
 			return;
 		break;
 	default:
@@ -7862,7 +7860,7 @@ static void ixgbe_service_timer(struct timer_list *t)
 static void ixgbe_phy_interrupt_subtask(struct ixgbe_adapter *adapter)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
-	u32 status;
+	bool overtemp;
 
 	if (!(adapter->flags2 & IXGBE_FLAG2_PHY_INTERRUPT))
 		return;
@@ -7872,11 +7870,9 @@ static void ixgbe_phy_interrupt_subtask(struct ixgbe_adapter *adapter)
 	if (!hw->phy.ops.handle_lasi)
 		return;
 
-	status = hw->phy.ops.handle_lasi(&adapter->hw);
-	if (status != IXGBE_ERR_OVERTEMP)
-		return;
-
-	e_crit(drv, "%s\n", ixgbe_overheat_msg);
+	hw->phy.ops.handle_lasi(&adapter->hw, &overtemp);
+	if (overtemp)
+		e_crit(drv, "%s\n", ixgbe_overheat_msg);
 }
 
 static void ixgbe_reset_subtask(struct ixgbe_adapter *adapter)
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index 2584a1105e79..33f6ee1d5be5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -405,8 +405,7 @@ s32 ixgbe_reset_phy_generic(struct ixgbe_hw *hw)
 		return status;
 
 	/* Don't reset PHY if it's shut down due to overtemp. */
-	if (!hw->phy.reset_if_overtemp &&
-	    (IXGBE_ERR_OVERTEMP == hw->phy.ops.check_overtemp(hw)))
+	if (!hw->phy.reset_if_overtemp && hw->phy.ops.check_overtemp(hw))
 		return 0;
 
 	/* Blocked by MNG FW so bail */
@@ -2620,22 +2619,24 @@ static void ixgbe_i2c_bus_clear(struct ixgbe_hw *hw)
  *  @hw: pointer to hardware structure
  *
  *  Checks if the LASI temp alarm status was triggered due to overtemp
+ *
+ *  Return true when an overtemp event detected, otherwise false.
  **/
-s32 ixgbe_tn_check_overtemp(struct ixgbe_hw *hw)
+bool ixgbe_tn_check_overtemp(struct ixgbe_hw *hw)
 {
 	u16 phy_data = 0;
+	u32 status;
 
 	if (hw->device_id != IXGBE_DEV_ID_82599_T3_LOM)
-		return 0;
+		return false;
 
 	/* Check that the LASI temp alarm status was triggered */
-	hw->phy.ops.read_reg(hw, IXGBE_TN_LASI_STATUS_REG,
-			     MDIO_MMD_PMAPMD, &phy_data);
-
-	if (!(phy_data & IXGBE_TN_LASI_STATUS_TEMP_ALARM))
-		return 0;
+	status = hw->phy.ops.read_reg(hw, IXGBE_TN_LASI_STATUS_REG,
+				      MDIO_MMD_PMAPMD, &phy_data);
+	if (status)
+		return false;
 
-	return IXGBE_ERR_OVERTEMP;
+	return !!(phy_data & IXGBE_TN_LASI_STATUS_TEMP_ALARM);
 }
 
 /** ixgbe_set_copper_phy_power - Control power for copper phy
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
index 6544c4539c0d..ef72729d7c93 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
@@ -155,7 +155,7 @@ s32 ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw);
 s32 ixgbe_get_sfp_init_sequence_offsets(struct ixgbe_hw *hw,
 					u16 *list_offset,
 					u16 *data_offset);
-s32 ixgbe_tn_check_overtemp(struct ixgbe_hw *hw);
+bool ixgbe_tn_check_overtemp(struct ixgbe_hw *hw);
 s32 ixgbe_read_i2c_byte_generic(struct ixgbe_hw *hw, u8 byte_offset,
 				u8 dev_addr, u8 *data);
 s32 ixgbe_read_i2c_byte_generic_unlocked(struct ixgbe_hw *hw, u8 byte_offset,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 66963e142024..e84dbf6a3cb8 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -3505,10 +3505,10 @@ struct ixgbe_phy_operations {
 	s32 (*read_i2c_sff8472)(struct ixgbe_hw *, u8 , u8 *);
 	s32 (*read_i2c_eeprom)(struct ixgbe_hw *, u8 , u8 *);
 	s32 (*write_i2c_eeprom)(struct ixgbe_hw *, u8, u8);
-	s32 (*check_overtemp)(struct ixgbe_hw *);
+	bool (*check_overtemp)(struct ixgbe_hw *);
 	s32 (*set_phy_power)(struct ixgbe_hw *, bool on);
 	s32 (*enter_lplu)(struct ixgbe_hw *);
-	s32 (*handle_lasi)(struct ixgbe_hw *hw);
+	s32 (*handle_lasi)(struct ixgbe_hw *hw, bool *);
 	s32 (*read_i2c_byte_unlocked)(struct ixgbe_hw *, u8 offset, u8 addr,
 				      u8 *value);
 	s32 (*write_i2c_byte_unlocked)(struct ixgbe_hw *, u8 offset, u8 addr,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 3906234da369..7d3da1e823dc 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -600,8 +600,10 @@ static s32 ixgbe_setup_fw_link(struct ixgbe_hw *hw)
 	rc = ixgbe_fw_phy_activity(hw, FW_PHY_ACT_SETUP_LINK, &setup);
 	if (rc)
 		return rc;
+
 	if (setup[0] == FW_PHY_ACT_SETUP_LINK_RSP_DOWN)
-		return IXGBE_ERR_OVERTEMP;
+		return -EIO;
+
 	return 0;
 }
 
@@ -2319,18 +2321,18 @@ static s32 ixgbe_get_link_capabilities_X550em(struct ixgbe_hw *hw,
  * @hw: pointer to hardware structure
  * @lsc: pointer to boolean flag which indicates whether external Base T
  *	 PHY interrupt is lsc
+ * @is_overtemp: indicate whether an overtemp event encountered
  *
  * Determime if external Base T PHY interrupt cause is high temperature
  * failure alarm or link status change.
- *
- * Return IXGBE_ERR_OVERTEMP if interrupt is high temperature
- * failure alarm, else return PHY access status.
  **/
-static s32 ixgbe_get_lasi_ext_t_x550em(struct ixgbe_hw *hw, bool *lsc)
+static s32 ixgbe_get_lasi_ext_t_x550em(struct ixgbe_hw *hw, bool *lsc,
+				       bool *is_overtemp)
 {
 	u32 status;
 	u16 reg;
 
+	*is_overtemp = false;
 	*lsc = false;
 
 	/* Vendor alarm triggered */
@@ -2362,7 +2364,8 @@ static s32 ixgbe_get_lasi_ext_t_x550em(struct ixgbe_hw *hw, bool *lsc)
 	if (reg & IXGBE_MDIO_GLOBAL_ALM_1_HI_TMP_FAIL) {
 		/* power down the PHY in case the PHY FW didn't already */
 		ixgbe_set_copper_phy_power(hw, false);
-		return IXGBE_ERR_OVERTEMP;
+		*is_overtemp = true;
+		return -EIO;
 	}
 	if (reg & IXGBE_MDIO_GLOBAL_ALM_1_DEV_FAULT) {
 		/*  device fault alarm triggered */
@@ -2376,7 +2379,8 @@ static s32 ixgbe_get_lasi_ext_t_x550em(struct ixgbe_hw *hw, bool *lsc)
 		if (reg == IXGBE_MDIO_GLOBAL_FAULT_MSG_HI_TMP) {
 			/* power down the PHY in case the PHY FW didn't */
 			ixgbe_set_copper_phy_power(hw, false);
-			return IXGBE_ERR_OVERTEMP;
+			*is_overtemp = true;
+			return -EIO;
 		}
 	}
 
@@ -2412,12 +2416,12 @@ static s32 ixgbe_get_lasi_ext_t_x550em(struct ixgbe_hw *hw, bool *lsc)
  **/
 static s32 ixgbe_enable_lasi_ext_t_x550em(struct ixgbe_hw *hw)
 {
+	bool lsc, overtemp;
 	u32 status;
 	u16 reg;
-	bool lsc;
 
 	/* Clear interrupt flags */
-	status = ixgbe_get_lasi_ext_t_x550em(hw, &lsc);
+	status = ixgbe_get_lasi_ext_t_x550em(hw, &lsc, &overtemp);
 
 	/* Enable link status change alarm */
 
@@ -2496,21 +2500,20 @@ static s32 ixgbe_enable_lasi_ext_t_x550em(struct ixgbe_hw *hw)
 /**
  * ixgbe_handle_lasi_ext_t_x550em - Handle external Base T PHY interrupt
  * @hw: pointer to hardware structure
+ * @is_overtemp: indicate whether an overtemp event encountered
  *
  * Handle external Base T PHY interrupt. If high temperature
  * failure alarm then return error, else if link status change
  * then setup internal/external PHY link
- *
- * Return IXGBE_ERR_OVERTEMP if interrupt is high temperature
- * failure alarm, else return PHY access status.
  **/
-static s32 ixgbe_handle_lasi_ext_t_x550em(struct ixgbe_hw *hw)
+static s32 ixgbe_handle_lasi_ext_t_x550em(struct ixgbe_hw *hw,
+					  bool *is_overtemp)
 {
 	struct ixgbe_phy_info *phy = &hw->phy;
 	bool lsc;
 	u32 status;
 
-	status = ixgbe_get_lasi_ext_t_x550em(hw, &lsc);
+	status = ixgbe_get_lasi_ext_t_x550em(hw, &lsc, is_overtemp);
 	if (status)
 		return status;
 
@@ -3138,21 +3141,23 @@ static s32 ixgbe_reset_phy_fw(struct ixgbe_hw *hw)
 /**
  * ixgbe_check_overtemp_fw - Check firmware-controlled PHYs for overtemp
  * @hw: pointer to hardware structure
+ *
+ * Return true when an overtemp event detected, otherwise false.
  */
-static s32 ixgbe_check_overtemp_fw(struct ixgbe_hw *hw)
+static bool ixgbe_check_overtemp_fw(struct ixgbe_hw *hw)
 {
 	u32 store[FW_PHY_ACT_DATA_COUNT] = { 0 };
 	s32 rc;
 
 	rc = ixgbe_fw_phy_activity(hw, FW_PHY_ACT_GET_LINK_INFO, &store);
 	if (rc)
-		return rc;
+		return false;
 
 	if (store[0] & FW_PHY_ACT_GET_LINK_INFO_TEMP) {
 		ixgbe_shutdown_fw_phy(hw);
-		return IXGBE_ERR_OVERTEMP;
+		return true;
 	}
-	return 0;
+	return false;
 }
 
 /**
-- 
2.43.0





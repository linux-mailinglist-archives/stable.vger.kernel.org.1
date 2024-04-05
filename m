Return-Path: <stable+bounces-36086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5149E899B19
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 12:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC5C81F2228C
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 10:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D98D15FCE7;
	Fri,  5 Apr 2024 10:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U69o5DT5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7B728E34
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 10:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712313854; cv=none; b=uWARF32QXsh9wa3BzwlO+k/hLRuisR9FkFJ6eWzEgu0PvIQ99tbdLyumCfp1ItWUO1I2lJBB4bQimSBs4bgCQwoRO3zcaczA5ndX+ZlP/mFSgVQEOOBfSr8xIdV9Wyx7k9T1BxuX57WgDcuuDFs0Q5vZqQxoEO4G6/AgcvKHqso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712313854; c=relaxed/simple;
	bh=BcNbQ+R6xAjpnTIU/bXwpRyi5h6rXuOrvLhz78TXNc8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jVwdEod/8tEZhVBX10bIvnPfMQK4tT57lLRrhi8MrvAGnP9yYW9kP+Bpy4HEG+dpcdpX9dZM5tCq5UNcLmfJPeB8Op7la7lrybliPc+7AJZE0xHJIo2mqoYLFY2Rex5Y6Hfl9TWl92MpdHFRHqqNIcK/pJwzfnHW5kGFG2+yYZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U69o5DT5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A6DC433F1;
	Fri,  5 Apr 2024 10:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712313853;
	bh=BcNbQ+R6xAjpnTIU/bXwpRyi5h6rXuOrvLhz78TXNc8=;
	h=Subject:To:Cc:From:Date:From;
	b=U69o5DT5hXEbI24+GQcfX5CVG7TT7anEEHb+j84NTFdRvtwNPxjwbMfNO+eYPv1Rn
	 HRipbg+V3bimHr266iUfBHO/k+SHKurRBowyFVx3tEBevepnj1nzuQQBkXPBtXIwpM
	 wE8qcutaVly3v6SCrKlj9tWkIz9XldCKqk2rlMbw=
Subject: FAILED: patch "[PATCH] e1000e: Workaround for sporadic MDI error on Meteor Lake" failed to apply to 5.15-stable tree
To: vitaly.lifshits@intel.com,anthony.l.nguyen@intel.com,naamax.meir@linux.intel.com,nikolay.mushayev@intel.com,nir.efrati@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 05 Apr 2024 12:44:05 +0200
Message-ID: <2024040504-unedited-capture-9d05@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 6dbdd4de0362c37e54e8b049781402e5a409e7d0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040504-unedited-capture-9d05@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6dbdd4de0362c37e54e8b049781402e5a409e7d0 Mon Sep 17 00:00:00 2001
From: Vitaly Lifshits <vitaly.lifshits@intel.com>
Date: Thu, 4 Jan 2024 16:16:52 +0200
Subject: [PATCH] e1000e: Workaround for sporadic MDI error on Meteor Lake
 systems

On some Meteor Lake systems accessing the PHY via the MDIO interface may
result in an MDI error. This issue happens sporadically and in most cases
a second access to the PHY via the MDIO interface results in success.

As a workaround, introduce a retry counter which is set to 3 on Meteor
Lake systems. The driver will only return an error if 3 consecutive PHY
access attempts fail. The retry mechanism is disabled in specific flows,
where MDI errors are expected.

Fixes: cc23f4f0b6b9 ("e1000e: Add support for Meteor Lake")
Suggested-by: Nikolay Mushayev <nikolay.mushayev@intel.com>
Co-developed-by: Nir Efrati <nir.efrati@intel.com>
Signed-off-by: Nir Efrati <nir.efrati@intel.com>
Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

diff --git a/drivers/net/ethernet/intel/e1000e/hw.h b/drivers/net/ethernet/intel/e1000e/hw.h
index 1fef6bb5a5fb..4b6e7536170a 100644
--- a/drivers/net/ethernet/intel/e1000e/hw.h
+++ b/drivers/net/ethernet/intel/e1000e/hw.h
@@ -628,6 +628,7 @@ struct e1000_phy_info {
 	u32 id;
 	u32 reset_delay_us;	/* in usec */
 	u32 revision;
+	u32 retry_count;
 
 	enum e1000_media_type media_type;
 
@@ -644,6 +645,7 @@ struct e1000_phy_info {
 	bool polarity_correction;
 	bool speed_downgraded;
 	bool autoneg_wait_to_complete;
+	bool retry_enabled;
 };
 
 struct e1000_nvm_info {
diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index 19e450a5bd31..d8e97669f31b 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -222,11 +222,18 @@ static bool e1000_phy_is_accessible_pchlan(struct e1000_hw *hw)
 	if (hw->mac.type >= e1000_pch_lpt) {
 		/* Only unforce SMBus if ME is not active */
 		if (!(er32(FWSM) & E1000_ICH_FWSM_FW_VALID)) {
+			/* Switching PHY interface always returns MDI error
+			 * so disable retry mechanism to avoid wasting time
+			 */
+			e1000e_disable_phy_retry(hw);
+
 			/* Unforce SMBus mode in PHY */
 			e1e_rphy_locked(hw, CV_SMB_CTRL, &phy_reg);
 			phy_reg &= ~CV_SMB_CTRL_FORCE_SMBUS;
 			e1e_wphy_locked(hw, CV_SMB_CTRL, phy_reg);
 
+			e1000e_enable_phy_retry(hw);
+
 			/* Unforce SMBus mode in MAC */
 			mac_reg = er32(CTRL_EXT);
 			mac_reg &= ~E1000_CTRL_EXT_FORCE_SMBUS;
@@ -310,6 +317,11 @@ static s32 e1000_init_phy_workarounds_pchlan(struct e1000_hw *hw)
 		goto out;
 	}
 
+	/* There is no guarantee that the PHY is accessible at this time
+	 * so disable retry mechanism to avoid wasting time
+	 */
+	e1000e_disable_phy_retry(hw);
+
 	/* The MAC-PHY interconnect may be in SMBus mode.  If the PHY is
 	 * inaccessible and resetting the PHY is not blocked, toggle the
 	 * LANPHYPC Value bit to force the interconnect to PCIe mode.
@@ -380,6 +392,8 @@ static s32 e1000_init_phy_workarounds_pchlan(struct e1000_hw *hw)
 		break;
 	}
 
+	e1000e_enable_phy_retry(hw);
+
 	hw->phy.ops.release(hw);
 	if (!ret_val) {
 
@@ -449,6 +463,11 @@ static s32 e1000_init_phy_params_pchlan(struct e1000_hw *hw)
 
 	phy->id = e1000_phy_unknown;
 
+	if (hw->mac.type == e1000_pch_mtp) {
+		phy->retry_count = 2;
+		e1000e_enable_phy_retry(hw);
+	}
+
 	ret_val = e1000_init_phy_workarounds_pchlan(hw);
 	if (ret_val)
 		return ret_val;
@@ -1146,6 +1165,11 @@ s32 e1000_enable_ulp_lpt_lp(struct e1000_hw *hw, bool to_sx)
 	if (ret_val)
 		goto out;
 
+	/* Switching PHY interface always returns MDI error
+	 * so disable retry mechanism to avoid wasting time
+	 */
+	e1000e_disable_phy_retry(hw);
+
 	/* Force SMBus mode in PHY */
 	ret_val = e1000_read_phy_reg_hv_locked(hw, CV_SMB_CTRL, &phy_reg);
 	if (ret_val)
@@ -1153,6 +1177,8 @@ s32 e1000_enable_ulp_lpt_lp(struct e1000_hw *hw, bool to_sx)
 	phy_reg |= CV_SMB_CTRL_FORCE_SMBUS;
 	e1000_write_phy_reg_hv_locked(hw, CV_SMB_CTRL, phy_reg);
 
+	e1000e_enable_phy_retry(hw);
+
 	/* Force SMBus mode in MAC */
 	mac_reg = er32(CTRL_EXT);
 	mac_reg |= E1000_CTRL_EXT_FORCE_SMBUS;
@@ -1313,6 +1339,11 @@ static s32 e1000_disable_ulp_lpt_lp(struct e1000_hw *hw, bool force)
 		/* Toggle LANPHYPC Value bit */
 		e1000_toggle_lanphypc_pch_lpt(hw);
 
+	/* Switching PHY interface always returns MDI error
+	 * so disable retry mechanism to avoid wasting time
+	 */
+	e1000e_disable_phy_retry(hw);
+
 	/* Unforce SMBus mode in PHY */
 	ret_val = e1000_read_phy_reg_hv_locked(hw, CV_SMB_CTRL, &phy_reg);
 	if (ret_val) {
@@ -1333,6 +1364,8 @@ static s32 e1000_disable_ulp_lpt_lp(struct e1000_hw *hw, bool force)
 	phy_reg &= ~CV_SMB_CTRL_FORCE_SMBUS;
 	e1000_write_phy_reg_hv_locked(hw, CV_SMB_CTRL, phy_reg);
 
+	e1000e_enable_phy_retry(hw);
+
 	/* Unforce SMBus mode in MAC */
 	mac_reg = er32(CTRL_EXT);
 	mac_reg &= ~E1000_CTRL_EXT_FORCE_SMBUS;
diff --git a/drivers/net/ethernet/intel/e1000e/phy.c b/drivers/net/ethernet/intel/e1000e/phy.c
index 5e329156d1ba..93544f1cc2a5 100644
--- a/drivers/net/ethernet/intel/e1000e/phy.c
+++ b/drivers/net/ethernet/intel/e1000e/phy.c
@@ -107,6 +107,16 @@ s32 e1000e_phy_reset_dsp(struct e1000_hw *hw)
 	return e1e_wphy(hw, M88E1000_PHY_GEN_CONTROL, 0);
 }
 
+void e1000e_disable_phy_retry(struct e1000_hw *hw)
+{
+	hw->phy.retry_enabled = false;
+}
+
+void e1000e_enable_phy_retry(struct e1000_hw *hw)
+{
+	hw->phy.retry_enabled = true;
+}
+
 /**
  *  e1000e_read_phy_reg_mdic - Read MDI control register
  *  @hw: pointer to the HW structure
@@ -118,55 +128,73 @@ s32 e1000e_phy_reset_dsp(struct e1000_hw *hw)
  **/
 s32 e1000e_read_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 *data)
 {
+	u32 i, mdic = 0, retry_counter, retry_max;
 	struct e1000_phy_info *phy = &hw->phy;
-	u32 i, mdic = 0;
+	bool success;
 
 	if (offset > MAX_PHY_REG_ADDRESS) {
 		e_dbg("PHY Address %d is out of range\n", offset);
 		return -E1000_ERR_PARAM;
 	}
 
+	retry_max = phy->retry_enabled ? phy->retry_count : 0;
+
 	/* Set up Op-code, Phy Address, and register offset in the MDI
 	 * Control register.  The MAC will take care of interfacing with the
 	 * PHY to retrieve the desired data.
 	 */
-	mdic = ((offset << E1000_MDIC_REG_SHIFT) |
-		(phy->addr << E1000_MDIC_PHY_SHIFT) |
-		(E1000_MDIC_OP_READ));
+	for (retry_counter = 0; retry_counter <= retry_max; retry_counter++) {
+		success = true;
 
-	ew32(MDIC, mdic);
+		mdic = ((offset << E1000_MDIC_REG_SHIFT) |
+			(phy->addr << E1000_MDIC_PHY_SHIFT) |
+			(E1000_MDIC_OP_READ));
 
-	/* Poll the ready bit to see if the MDI read completed
-	 * Increasing the time out as testing showed failures with
-	 * the lower time out
-	 */
-	for (i = 0; i < (E1000_GEN_POLL_TIMEOUT * 3); i++) {
-		udelay(50);
-		mdic = er32(MDIC);
-		if (mdic & E1000_MDIC_READY)
-			break;
-	}
-	if (!(mdic & E1000_MDIC_READY)) {
-		e_dbg("MDI Read PHY Reg Address %d did not complete\n", offset);
-		return -E1000_ERR_PHY;
-	}
-	if (mdic & E1000_MDIC_ERROR) {
-		e_dbg("MDI Read PHY Reg Address %d Error\n", offset);
-		return -E1000_ERR_PHY;
-	}
-	if (FIELD_GET(E1000_MDIC_REG_MASK, mdic) != offset) {
-		e_dbg("MDI Read offset error - requested %d, returned %d\n",
-		      offset, FIELD_GET(E1000_MDIC_REG_MASK, mdic));
-		return -E1000_ERR_PHY;
-	}
-	*data = (u16)mdic;
+		ew32(MDIC, mdic);
 
-	/* Allow some time after each MDIC transaction to avoid
-	 * reading duplicate data in the next MDIC transaction.
-	 */
-	if (hw->mac.type == e1000_pch2lan)
-		udelay(100);
-	return 0;
+		/* Poll the ready bit to see if the MDI read completed
+		 * Increasing the time out as testing showed failures with
+		 * the lower time out
+		 */
+		for (i = 0; i < (E1000_GEN_POLL_TIMEOUT * 3); i++) {
+			usleep_range(50, 60);
+			mdic = er32(MDIC);
+			if (mdic & E1000_MDIC_READY)
+				break;
+		}
+		if (!(mdic & E1000_MDIC_READY)) {
+			e_dbg("MDI Read PHY Reg Address %d did not complete\n",
+			      offset);
+			success = false;
+		}
+		if (mdic & E1000_MDIC_ERROR) {
+			e_dbg("MDI Read PHY Reg Address %d Error\n", offset);
+			success = false;
+		}
+		if (FIELD_GET(E1000_MDIC_REG_MASK, mdic) != offset) {
+			e_dbg("MDI Read offset error - requested %d, returned %d\n",
+			      offset, FIELD_GET(E1000_MDIC_REG_MASK, mdic));
+			success = false;
+		}
+
+		/* Allow some time after each MDIC transaction to avoid
+		 * reading duplicate data in the next MDIC transaction.
+		 */
+		if (hw->mac.type == e1000_pch2lan)
+			usleep_range(100, 150);
+
+		if (success) {
+			*data = (u16)mdic;
+			return 0;
+		}
+
+		if (retry_counter != retry_max) {
+			e_dbg("Perform retry on PHY transaction...\n");
+			mdelay(10);
+		}
+	}
+
+	return -E1000_ERR_PHY;
 }
 
 /**
@@ -179,56 +207,72 @@ s32 e1000e_read_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 *data)
  **/
 s32 e1000e_write_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 data)
 {
+	u32 i, mdic = 0, retry_counter, retry_max;
 	struct e1000_phy_info *phy = &hw->phy;
-	u32 i, mdic = 0;
+	bool success;
 
 	if (offset > MAX_PHY_REG_ADDRESS) {
 		e_dbg("PHY Address %d is out of range\n", offset);
 		return -E1000_ERR_PARAM;
 	}
 
+	retry_max = phy->retry_enabled ? phy->retry_count : 0;
+
 	/* Set up Op-code, Phy Address, and register offset in the MDI
 	 * Control register.  The MAC will take care of interfacing with the
 	 * PHY to retrieve the desired data.
 	 */
-	mdic = (((u32)data) |
-		(offset << E1000_MDIC_REG_SHIFT) |
-		(phy->addr << E1000_MDIC_PHY_SHIFT) |
-		(E1000_MDIC_OP_WRITE));
+	for (retry_counter = 0; retry_counter <= retry_max; retry_counter++) {
+		success = true;
 
-	ew32(MDIC, mdic);
+		mdic = (((u32)data) |
+			(offset << E1000_MDIC_REG_SHIFT) |
+			(phy->addr << E1000_MDIC_PHY_SHIFT) |
+			(E1000_MDIC_OP_WRITE));
 
-	/* Poll the ready bit to see if the MDI read completed
-	 * Increasing the time out as testing showed failures with
-	 * the lower time out
-	 */
-	for (i = 0; i < (E1000_GEN_POLL_TIMEOUT * 3); i++) {
-		udelay(50);
-		mdic = er32(MDIC);
-		if (mdic & E1000_MDIC_READY)
-			break;
-	}
-	if (!(mdic & E1000_MDIC_READY)) {
-		e_dbg("MDI Write PHY Reg Address %d did not complete\n", offset);
-		return -E1000_ERR_PHY;
-	}
-	if (mdic & E1000_MDIC_ERROR) {
-		e_dbg("MDI Write PHY Red Address %d Error\n", offset);
-		return -E1000_ERR_PHY;
-	}
-	if (FIELD_GET(E1000_MDIC_REG_MASK, mdic) != offset) {
-		e_dbg("MDI Write offset error - requested %d, returned %d\n",
-		      offset, FIELD_GET(E1000_MDIC_REG_MASK, mdic));
-		return -E1000_ERR_PHY;
+		ew32(MDIC, mdic);
+
+		/* Poll the ready bit to see if the MDI read completed
+		 * Increasing the time out as testing showed failures with
+		 * the lower time out
+		 */
+		for (i = 0; i < (E1000_GEN_POLL_TIMEOUT * 3); i++) {
+			usleep_range(50, 60);
+			mdic = er32(MDIC);
+			if (mdic & E1000_MDIC_READY)
+				break;
+		}
+		if (!(mdic & E1000_MDIC_READY)) {
+			e_dbg("MDI Write PHY Reg Address %d did not complete\n",
+			      offset);
+			success = false;
+		}
+		if (mdic & E1000_MDIC_ERROR) {
+			e_dbg("MDI Write PHY Reg Address %d Error\n", offset);
+			success = false;
+		}
+		if (FIELD_GET(E1000_MDIC_REG_MASK, mdic) != offset) {
+			e_dbg("MDI Write offset error - requested %d, returned %d\n",
+			      offset, FIELD_GET(E1000_MDIC_REG_MASK, mdic));
+			success = false;
+		}
+
+		/* Allow some time after each MDIC transaction to avoid
+		 * reading duplicate data in the next MDIC transaction.
+		 */
+		if (hw->mac.type == e1000_pch2lan)
+			usleep_range(100, 150);
+
+		if (success)
+			return 0;
+
+		if (retry_counter != retry_max) {
+			e_dbg("Perform retry on PHY transaction...\n");
+			mdelay(10);
+		}
 	}
 
-	/* Allow some time after each MDIC transaction to avoid
-	 * reading duplicate data in the next MDIC transaction.
-	 */
-	if (hw->mac.type == e1000_pch2lan)
-		udelay(100);
-
-	return 0;
+	return -E1000_ERR_PHY;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/e1000e/phy.h b/drivers/net/ethernet/intel/e1000e/phy.h
index c48777d09523..049bb325b4b1 100644
--- a/drivers/net/ethernet/intel/e1000e/phy.h
+++ b/drivers/net/ethernet/intel/e1000e/phy.h
@@ -51,6 +51,8 @@ s32 e1000e_read_phy_reg_bm2(struct e1000_hw *hw, u32 offset, u16 *data);
 s32 e1000e_write_phy_reg_bm2(struct e1000_hw *hw, u32 offset, u16 data);
 void e1000_power_up_phy_copper(struct e1000_hw *hw);
 void e1000_power_down_phy_copper(struct e1000_hw *hw);
+void e1000e_disable_phy_retry(struct e1000_hw *hw);
+void e1000e_enable_phy_retry(struct e1000_hw *hw);
 s32 e1000e_read_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 *data);
 s32 e1000e_write_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 data);
 s32 e1000_read_phy_reg_hv(struct e1000_hw *hw, u32 offset, u16 *data);



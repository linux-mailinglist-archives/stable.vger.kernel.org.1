Return-Path: <stable+bounces-23065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D1485DF0E
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 15:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17CAE283C1A
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A322A76037;
	Wed, 21 Feb 2024 14:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IVDBrC0B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BED3CF42;
	Wed, 21 Feb 2024 14:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708525464; cv=none; b=ZW+hmJ58DBf0heKsmD7/v8cjjk/wbLWKf8Fk64R+Vi7oi7U4OnLqFNeu+MlPDUQd1tJmoVueQXqYAk4843kxrJKR1CUNuGC4NV5JedM8niFmskVa+EtEFedx7S1QxmxMn04w1glGyp98O3DmLo66PYbNhgbAOfpTlmo1W0+ZekY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708525464; c=relaxed/simple;
	bh=83Erjb2X2xXdOQ0BU9Yxd/MrN4ImvtJFUpF3KDyaDP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HI0qFLwJo0KwFjk0CSEBRQmyirbS/Hvl0q/LpMuU1XGmqOyFfgaqI9JdOUozqWP8hswEFIG+y1540Fbuk1RBgFFMqrUgIFBtudunASvmv69cuapRwc7cSMNqqRfgon8vdF9JP5D9S/6dDmz8EzFQSMLDt1HTBDuC6y/+a+jNTiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IVDBrC0B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6CE3C433F1;
	Wed, 21 Feb 2024 14:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708525464;
	bh=83Erjb2X2xXdOQ0BU9Yxd/MrN4ImvtJFUpF3KDyaDP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IVDBrC0BVjv553+dkSLJHm/v3ALsG9yXF0noC//eC37JfjSQpxxvCbcWI/AuFpHnv
	 K4LptyIM9hWA/PRahfnxlXq20kzPXfmiFO4UuygvAJAHGNyTBuGWSHTwvMbamH8KyP
	 rIam+tKERaltuIAxejF27OQvbA4sz2/9C2Ci/JsQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Piotr Skajewski <piotrx.skajewski@intel.com>,
	Dave Switzer <david.switzer@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 161/267] ixgbe: Remove non-inclusive language
Date: Wed, 21 Feb 2024 14:08:22 +0100
Message-ID: <20240221125945.141315637@linuxfoundation.org>
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

From: Piotr Skajewski <piotrx.skajewski@intel.com>

[ Upstream commit 93b067f154b3edfd3d75a272fd9433bf787e2e1d ]

Remove non-inclusive language from the driver.

Additionally correct the duplication "from from"
reported by checkpatch after the changes above.

Signed-off-by: Piotr Skajewski <piotrx.skajewski@intel.com>
Tested-by: Dave Switzer <david.switzer@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Stable-dep-of: bbc404d20d1b ("ixgbe: Fix an error handling path in ixgbe_read_iosf_sb_reg_x550()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/intel/ixgbe/ixgbe_common.c   | 36 +++++++++----------
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  4 +--
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h | 10 +++---
 3 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index 39c5e6fdb72c..162adcc2bc9d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -30,7 +30,7 @@ static s32 ixgbe_write_eeprom_buffer_bit_bang(struct ixgbe_hw *hw, u16 offset,
 					     u16 words, u16 *data);
 static s32 ixgbe_detect_eeprom_page_size_generic(struct ixgbe_hw *hw,
 						 u16 offset);
-static s32 ixgbe_disable_pcie_master(struct ixgbe_hw *hw);
+static s32 ixgbe_disable_pcie_primary(struct ixgbe_hw *hw);
 
 /* Base table for registers values that change by MAC */
 const u32 ixgbe_mvals_8259X[IXGBE_MVALS_IDX_LIMIT] = {
@@ -746,10 +746,10 @@ s32 ixgbe_stop_adapter_generic(struct ixgbe_hw *hw)
 	usleep_range(1000, 2000);
 
 	/*
-	 * Prevent the PCI-E bus from from hanging by disabling PCI-E master
+	 * Prevent the PCI-E bus from hanging by disabling PCI-E primary
 	 * access and verify no pending requests
 	 */
-	return ixgbe_disable_pcie_master(hw);
+	return ixgbe_disable_pcie_primary(hw);
 }
 
 /**
@@ -2506,15 +2506,15 @@ static u32 ixgbe_pcie_timeout_poll(struct ixgbe_hw *hw)
 }
 
 /**
- *  ixgbe_disable_pcie_master - Disable PCI-express master access
+ *  ixgbe_disable_pcie_primary - Disable PCI-express primary access
  *  @hw: pointer to hardware structure
  *
- *  Disables PCI-Express master access and verifies there are no pending
- *  requests. IXGBE_ERR_MASTER_REQUESTS_PENDING is returned if master disable
- *  bit hasn't caused the master requests to be disabled, else 0
- *  is returned signifying master requests disabled.
+ *  Disables PCI-Express primary access and verifies there are no pending
+ *  requests. IXGBE_ERR_PRIMARY_REQUESTS_PENDING is returned if primary disable
+ *  bit hasn't caused the primary requests to be disabled, else 0
+ *  is returned signifying primary requests disabled.
  **/
-static s32 ixgbe_disable_pcie_master(struct ixgbe_hw *hw)
+static s32 ixgbe_disable_pcie_primary(struct ixgbe_hw *hw)
 {
 	u32 i, poll;
 	u16 value;
@@ -2523,23 +2523,23 @@ static s32 ixgbe_disable_pcie_master(struct ixgbe_hw *hw)
 	IXGBE_WRITE_REG(hw, IXGBE_CTRL, IXGBE_CTRL_GIO_DIS);
 
 	/* Poll for bit to read as set */
-	for (i = 0; i < IXGBE_PCI_MASTER_DISABLE_TIMEOUT; i++) {
+	for (i = 0; i < IXGBE_PCI_PRIMARY_DISABLE_TIMEOUT; i++) {
 		if (IXGBE_READ_REG(hw, IXGBE_CTRL) & IXGBE_CTRL_GIO_DIS)
 			break;
 		usleep_range(100, 120);
 	}
-	if (i >= IXGBE_PCI_MASTER_DISABLE_TIMEOUT) {
+	if (i >= IXGBE_PCI_PRIMARY_DISABLE_TIMEOUT) {
 		hw_dbg(hw, "GIO disable did not set - requesting resets\n");
 		goto gio_disable_fail;
 	}
 
-	/* Exit if master requests are blocked */
+	/* Exit if primary requests are blocked */
 	if (!(IXGBE_READ_REG(hw, IXGBE_STATUS) & IXGBE_STATUS_GIO) ||
 	    ixgbe_removed(hw->hw_addr))
 		return 0;
 
-	/* Poll for master request bit to clear */
-	for (i = 0; i < IXGBE_PCI_MASTER_DISABLE_TIMEOUT; i++) {
+	/* Poll for primary request bit to clear */
+	for (i = 0; i < IXGBE_PCI_PRIMARY_DISABLE_TIMEOUT; i++) {
 		udelay(100);
 		if (!(IXGBE_READ_REG(hw, IXGBE_STATUS) & IXGBE_STATUS_GIO))
 			return 0;
@@ -2547,13 +2547,13 @@ static s32 ixgbe_disable_pcie_master(struct ixgbe_hw *hw)
 
 	/*
 	 * Two consecutive resets are required via CTRL.RST per datasheet
-	 * 5.2.5.3.2 Master Disable.  We set a flag to inform the reset routine
-	 * of this need.  The first reset prevents new master requests from
+	 * 5.2.5.3.2 Primary Disable.  We set a flag to inform the reset routine
+	 * of this need.  The first reset prevents new primary requests from
 	 * being issued by our device.  We then must wait 1usec or more for any
 	 * remaining completions from the PCIe bus to trickle in, and then reset
 	 * again to clear out any effects they may have had on our device.
 	 */
-	hw_dbg(hw, "GIO Master Disable bit didn't clear - requesting resets\n");
+	hw_dbg(hw, "GIO Primary Disable bit didn't clear - requesting resets\n");
 gio_disable_fail:
 	hw->mac.flags |= IXGBE_FLAGS_DOUBLE_RESET_REQUIRED;
 
@@ -2575,7 +2575,7 @@ static s32 ixgbe_disable_pcie_master(struct ixgbe_hw *hw)
 	}
 
 	hw_dbg(hw, "PCIe transaction pending bit also did not clear.\n");
-	return IXGBE_ERR_MASTER_REQUESTS_PENDING;
+	return IXGBE_ERR_PRIMARY_REQUESTS_PENDING;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 567bb7792f8f..b4f4264ad990 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -5941,8 +5941,8 @@ void ixgbe_reset(struct ixgbe_adapter *adapter)
 	case IXGBE_ERR_SFP_NOT_PRESENT:
 	case IXGBE_ERR_SFP_NOT_SUPPORTED:
 		break;
-	case IXGBE_ERR_MASTER_REQUESTS_PENDING:
-		e_dev_err("master disable timed out\n");
+	case IXGBE_ERR_PRIMARY_REQUESTS_PENDING:
+		e_dev_err("primary disable timed out\n");
 		break;
 	case IXGBE_ERR_EEPROM_VERSION:
 		/* We are running on a pre-production device, log a warning */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 2be1c4c72435..039f7c73a3b5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -1247,7 +1247,7 @@ struct ixgbe_nvm_version {
 #define IXGBE_PSRTYPE_RQPL_SHIFT    29
 
 /* CTRL Bit Masks */
-#define IXGBE_CTRL_GIO_DIS      0x00000004 /* Global IO Master Disable bit */
+#define IXGBE_CTRL_GIO_DIS      0x00000004 /* Global IO Primary Disable bit */
 #define IXGBE_CTRL_LNK_RST      0x00000008 /* Link Reset. Resets everything. */
 #define IXGBE_CTRL_RST          0x04000000 /* Reset (SW) */
 #define IXGBE_CTRL_RST_MASK     (IXGBE_CTRL_LNK_RST | IXGBE_CTRL_RST)
@@ -1810,7 +1810,7 @@ enum {
 /* STATUS Bit Masks */
 #define IXGBE_STATUS_LAN_ID         0x0000000C /* LAN ID */
 #define IXGBE_STATUS_LAN_ID_SHIFT   2          /* LAN ID Shift*/
-#define IXGBE_STATUS_GIO            0x00080000 /* GIO Master Enable Status */
+#define IXGBE_STATUS_GIO            0x00080000 /* GIO Primary Enable Status */
 
 #define IXGBE_STATUS_LAN_ID_0   0x00000000 /* LAN ID 0 */
 #define IXGBE_STATUS_LAN_ID_1   0x00000004 /* LAN ID 1 */
@@ -2192,8 +2192,8 @@ enum {
 #define IXGBE_PCIDEVCTRL2_4_8s		0xd
 #define IXGBE_PCIDEVCTRL2_17_34s	0xe
 
-/* Number of 100 microseconds we wait for PCI Express master disable */
-#define IXGBE_PCI_MASTER_DISABLE_TIMEOUT	800
+/* Number of 100 microseconds we wait for PCI Express primary disable */
+#define IXGBE_PCI_PRIMARY_DISABLE_TIMEOUT	800
 
 /* RAH */
 #define IXGBE_RAH_VIND_MASK     0x003C0000
@@ -3674,7 +3674,7 @@ struct ixgbe_info {
 #define IXGBE_ERR_ADAPTER_STOPPED               -9
 #define IXGBE_ERR_INVALID_MAC_ADDR              -10
 #define IXGBE_ERR_DEVICE_NOT_SUPPORTED          -11
-#define IXGBE_ERR_MASTER_REQUESTS_PENDING       -12
+#define IXGBE_ERR_PRIMARY_REQUESTS_PENDING      -12
 #define IXGBE_ERR_INVALID_LINK_SETTINGS         -13
 #define IXGBE_ERR_AUTONEG_NOT_COMPLETE          -14
 #define IXGBE_ERR_RESET_FAILED                  -15
-- 
2.43.0





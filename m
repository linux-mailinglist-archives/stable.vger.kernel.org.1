Return-Path: <stable+bounces-208291-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78088D1B14E
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 20:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E63E3028186
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 19:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2902236C595;
	Tue, 13 Jan 2026 19:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J0Vy1xbO"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8508736AB65;
	Tue, 13 Jan 2026 19:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768333141; cv=none; b=JBFu4RWoeRAaWMgf2rqoJnVu8iLg945gMXLx4RNh6aEKxid3229icKGsMYZB9s32gcej1WfzAv6RteRiby1GhxvfQMo6vioM+2kMsFEqAIXepK0pP6zfIo2m0KSkhsOYAQirjCJslRW/s551DneUt62mTLueEmz2mJPRNBRj5Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768333141; c=relaxed/simple;
	bh=cQBJ2VxWuFTxQUDOTo6qtyEYlivydYoNMrH+/6fqZRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o/92oHemBQKARPGywudauypWppvvF4ERarA1eXPKEUE8wrB9Zb1Py5DfwA4ymJiL42njaE3fVTD2puQEBpP57I0E/4eVt+4QXH12jVSHn3RSbzIcSG6O4QyMkSH2LDYiP/KeBv5Gn6ntxEyBbfnPjp2oxcWSxnaffucjvAQM4+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J0Vy1xbO; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768333140; x=1799869140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cQBJ2VxWuFTxQUDOTo6qtyEYlivydYoNMrH+/6fqZRo=;
  b=J0Vy1xbO0Mw7OSJ9f7VU+PF3C4aBt/66TSUh+UIyb5hOTWh75IltLM46
   Euk9SLzr3VnlA0OyN0CKpK4bQ+zsHgJcKIirHYs23sCxrBEtuAG0g8lpW
   2SmkAxn1dgBCkYI6uSBfzujRJ2BDjZ6lqbXB1jMKWVThHfxX7sgayc1v0
   NIAIepiIChLn4/GYHbNgLsZ6NrXM+4ac3m8RjTpAA5A13X+ZMHk7245aJ
   WHDO6qVmTquVFccBZ4UmLaTUxuYKW3pkxvGkcOQRRwe/TLMnFishlGVUs
   7t3JQHhofxKTVAgzYq0aDCgis0U2aA4nKfd1OHBPbIrJTUXwmEAHDROwN
   w==;
X-CSE-ConnectionGUID: eN5uY+DaTGin4ScuteoUPQ==
X-CSE-MsgGUID: KDH6pDTOSJW2SjEIiIMF2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="80993531"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="80993531"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 11:39:00 -0800
X-CSE-ConnectionGUID: fuUb7S8FSd+1isAwjaWYGQ==
X-CSE-MsgGUID: XmFmkVOGTBSszu2DWXYeFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="208629085"
Received: from kasadzad-mobl.ger.corp.intel.com (HELO soc-5CG4396XFB.clients.intel.com) ([10.94.252.226])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 11:38:58 -0800
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Jakub Staniszewski <jakub.staniszewski@linux.intel.com>,
	stable@vger.kernel.org,
	Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net 2/2] ice: fix retry for AQ command 0x06EE
Date: Tue, 13 Jan 2026 20:38:17 +0100
Message-ID: <20260113193817.582-3-dawid.osuchowski@linux.intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113193817.582-1-dawid.osuchowski@linux.intel.com>
References: <20260113193817.582-1-dawid.osuchowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

From: Jakub Staniszewski <jakub.staniszewski@linux.intel.com>

Executing ethtool -m can fail reporting a netlink I/O error while firmware
link management holds the i2c bus used to communicate with the module.

According to Intel(R) Ethernet Controller E810 Datasheet Rev 2.8 [1]
Section 3.3.10.4 Read/Write SFF EEPROM (0x06EE)
request should to be retried upon receiving EBUSY from firmware.

Commit e9c9692c8a81 ("ice: Reimplement module reads used by ethtool")
implemented it only for part of ice_get_module_eeprom(), leaving all other
calls to ice_aq_sff_eeprom() vulnerable to returning early on getting
EBUSY without retrying.

Remove the retry loop from ice_get_module_eeprom() and add Admin Queue
(AQ) command with opcode 0x06EE to the list of commands that should be
retried on receiving EBUSY from firmware.

Cc: stable@vger.kernel.org
Fixes: e9c9692c8a81 ("ice: Reimplement module reads used by ethtool")
Signed-off-by: Jakub Staniszewski <jakub.staniszewski@linux.intel.com>
Co-developed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Link: https://www.intel.com/content/www/us/en/content-details/613875/intel-ethernet-controller-e810-datasheet.html [1]
---
 drivers/net/ethernet/intel/ice/ice_common.c  |  1 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 35 ++++++++------------
 2 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index aab00c44e9b2..26eb8e05498b 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1854,6 +1854,7 @@ static bool ice_should_retry_sq_send_cmd(u16 opcode)
 	case ice_aqc_opc_lldp_stop:
 	case ice_aqc_opc_lldp_start:
 	case ice_aqc_opc_lldp_filter_ctrl:
+	case ice_aqc_opc_sff_eeprom:
 		return true;
 	}
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 3565a5d96c6d..478876908db1 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -4496,7 +4496,7 @@ ice_get_module_eeprom(struct net_device *netdev,
 	u8 addr = ICE_I2C_EEPROM_DEV_ADDR;
 	struct ice_hw *hw = &pf->hw;
 	bool is_sfp = false;
-	unsigned int i, j;
+	unsigned int i;
 	u16 offset = 0;
 	u8 page = 0;
 	int status;
@@ -4538,26 +4538,19 @@ ice_get_module_eeprom(struct net_device *netdev,
 		if (page == 0 || !(data[0x2] & 0x4)) {
 			u32 copy_len;
 
-			/* If i2c bus is busy due to slow page change or
-			 * link management access, call can fail. This is normal.
-			 * So we retry this a few times.
-			 */
-			for (j = 0; j < 4; j++) {
-				status = ice_aq_sff_eeprom(hw, 0, addr, offset, page,
-							   !is_sfp, value,
-							   SFF_READ_BLOCK_SIZE,
-							   0, NULL);
-				netdev_dbg(netdev, "SFF %02X %02X %02X %X = %02X%02X%02X%02X.%02X%02X%02X%02X (%X)\n",
-					   addr, offset, page, is_sfp,
-					   value[0], value[1], value[2], value[3],
-					   value[4], value[5], value[6], value[7],
-					   status);
-				if (status) {
-					usleep_range(1500, 2500);
-					memset(value, 0, SFF_READ_BLOCK_SIZE);
-					continue;
-				}
-				break;
+			status = ice_aq_sff_eeprom(hw, 0, addr, offset, page,
+						   !is_sfp, value,
+						   SFF_READ_BLOCK_SIZE,
+						   0, NULL);
+			netdev_dbg(netdev, "SFF %02X %02X %02X %X = %02X%02X%02X%02X.%02X%02X%02X%02X (%pe)\n",
+				   addr, offset, page, is_sfp,
+				   value[0], value[1], value[2], value[3],
+				   value[4], value[5], value[6], value[7],
+				   ERR_PTR(status));
+			if (status) {
+				netdev_err(netdev, "%s: error reading module EEPROM: status %pe\n",
+					   __func__, ERR_PTR(status));
+				return status;
 			}
 
 			/* Make sure we have enough room for the new block */
-- 
2.51.0



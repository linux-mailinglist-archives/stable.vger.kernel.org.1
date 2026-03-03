Return-Path: <stable+bounces-222956-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PSEFd9qp2mWhQAAu9opvQ
	(envelope-from <stable+bounces-222956-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 00:12:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9761F8491
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 00:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3BBB4307096E
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 23:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA2A39A056;
	Tue,  3 Mar 2026 23:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e/RToW9Z"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF69396B67;
	Tue,  3 Mar 2026 23:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772579525; cv=none; b=j3bjipQJ6UIriIg17fOV/Phk7NOTVi/hXhduQUEmi/E88XGPu0tyHLnpx7n1CBwGzsRxlpfw2mWyEwWHuzA3ClN3LB54DcJxJvzmKt7zP/0NaGTrTpdfmbO4dfAnm8UZ65+UhZqhyTnZTFmxVZZNlmTI7qNiCZxVWXf2gH8fI2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772579525; c=relaxed/simple;
	bh=K0fRyEWZrjrVoRd5ZbHxJR9zHkvq5aMjQ6/6pRtJqZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FqCr28Xm+3h/Tu/JTWg/ZVVWi/f/bIzQcqAtzY6OL97I6XzgjG2QBaFCwDyZiA37Xbj7vM0ypH3Ml0iwVcIN7lhvlcAx18b7uvzMX2gRHKPf/edjCtCSbCSIh2Txpyzyg7NQAZoKlyXxxj8I7kLhsmuioHys5nxHMyDRCpKCPMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e/RToW9Z; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772579522; x=1804115522;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K0fRyEWZrjrVoRd5ZbHxJR9zHkvq5aMjQ6/6pRtJqZo=;
  b=e/RToW9ZAcK3egmvSYYEOFsMTaukXcgIkzNdLEE3urOh4Jvv0vnuILAk
   LjtmE+yrBCvs6EUk35GSZoaHmIjkpSjM8n9fss1UzpacW/BCS6awKPMgv
   olCi/fmqq32ne3eQiNn9ucWI5/uIzJLfCJ0R2UD13XRlFzZcRVmII8qZm
   jQakSFvY2kxnCLsSAj1/dUs/K4ZWmOhM2DRD8ocYo3ZX9OBlWHt+Yv0zC
   TvutW48X0sI7ZqvfLpZl+y1/UiuHrgN3ehoNHduFcYf21t+Js4WgiCQkp
   rTgsT0m6DrWgS4iB/XBRIIHDjym9RKbEseJHD2/F0urky5Tw1gsy0Tkrj
   g==;
X-CSE-ConnectionGUID: ZnRRz5AsQxOK/XLXhhz0wQ==
X-CSE-MsgGUID: zAt34b34SPmooUDvVbcigQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="77238802"
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="77238802"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 15:11:59 -0800
X-CSE-ConnectionGUID: l1ro+eBbT3We97QOMe5CXQ==
X-CSE-MsgGUID: fjTW86lRTGm9OAZLAxYHJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="248633804"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 03 Mar 2026 15:11:59 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jakub Staniszewski <jakub.staniszewski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	scott.w.taylor@intel.com,
	stable@vger.kernel.org,
	Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 3/8] ice: fix retry for AQ command 0x06EE
Date: Tue,  3 Mar 2026 15:11:49 -0800
Message-ID: <20260303231155.2895065-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260303231155.2895065-1-anthony.l.nguyen@intel.com>
References: <20260303231155.2895065-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CD9761F8491
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-222956-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

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
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c  |  1 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 35 ++++++++------------
 2 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index fd32c318d3f5..ce11fea122d0 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1816,6 +1816,7 @@ static bool ice_should_retry_sq_send_cmd(u16 opcode)
 	case ice_aqc_opc_lldp_stop:
 	case ice_aqc_opc_lldp_start:
 	case ice_aqc_opc_lldp_filter_ctrl:
+	case ice_aqc_opc_sff_eeprom:
 		return true;
 	}
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 3c1a084c2a4b..29e341251754 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -4509,7 +4509,7 @@ ice_get_module_eeprom(struct net_device *netdev,
 	u8 addr = ICE_I2C_EEPROM_DEV_ADDR;
 	struct ice_hw *hw = &pf->hw;
 	bool is_sfp = false;
-	unsigned int i, j;
+	unsigned int i;
 	u16 offset = 0;
 	u8 page = 0;
 	int status;
@@ -4551,26 +4551,19 @@ ice_get_module_eeprom(struct net_device *netdev,
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
2.47.1



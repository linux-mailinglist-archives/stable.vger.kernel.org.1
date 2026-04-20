Return-Path: <stable+bounces-238976-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGUpBUA05mmOtQEAu9opvQ
	(envelope-from <stable+bounces-238976-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:12:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE1F42CC09
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 096DC3173559
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 13:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621AD3F2110;
	Mon, 20 Apr 2026 13:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDH/FQp8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9943BD654;
	Mon, 20 Apr 2026 13:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691542; cv=none; b=XGp6lWZXIQwtljFoZSzMrAUUdZtc9+a9oPx9By7iK1EPf6dPIgVv08qXAktg/PsHHM0YO9LKHsSBoCnEpOezhEO0pvO3sbljWwHSxhd5RYUcZDw4hx/BzXK74mE78bNXNFWrH4SeTC/jvm7elftWeBXTjVMcyKEX+Mkg3vWJdAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691542; c=relaxed/simple;
	bh=d5z/ux0RoWsVHSFKIjpXceLH38gp5GTJw6vk/1sYnEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cIFiiI6k1Y+ddr+ipHzk0yAhBoRuWfFzEPbCtvIrhKXVXeYoBnum1mOAdZ6VWh+f5+4bOy8J6BFevQ7/nGldzmo+x/gFMqN5qr/V5Cc7XtKn2WRi/xSOhHJzZhk+ktJEn39S/I8h4MzWSL/sVWMYptJarROhgSQLEOenCJbPtgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDH/FQp8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3470C19425;
	Mon, 20 Apr 2026 13:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691542;
	bh=d5z/ux0RoWsVHSFKIjpXceLH38gp5GTJw6vk/1sYnEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kDH/FQp8nwZKpk9f444vo8J8uAwpYDrbi62yJHoFLFtf9DBFtQQjPzDYMGQLVWBdH
	 PvoIJpJJcosP8UD0pCi3i5FRRZputXVGTaFkgf9cwewIX4zyAs3C2IGTb4sN3zzgBx
	 EEUNaYj216GXkLS6FpzBcUHbFx0XsTFrpewlankJ9VvCpPoMv1mKyJd/mZrzyUBi31
	 cIb1VLm6qcNyIue8E9SYJss6OokgFNIoIEQBprhYFUsSrTmYCrvwLrabB8jcjz8ikD
	 jvuvjvj371Qm0VRGN9v3q0e3T421GayVHYw3eIqR+baUIwPT9XdPjf0yp5lIv1jZGD
	 /RSYD9T9ouOkg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rinitha S <sx.rinitha@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mateusz.polchlopek@intel.com,
	slawomirx.mrozowicz@intel.com,
	stefan.wegrzyn@intel.com,
	piotr.kwapulinski@intel.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18] ixgbe: stop re-reading flash on every get_drvinfo for e610
Date: Mon, 20 Apr 2026 09:18:04 -0400
Message-ID: <20260420132314.1023554-90-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420132314.1023554-1-sashal@kernel.org>
References: <20260420132314.1023554-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.23
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-238976-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: EEE1F42CC09
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

[ Upstream commit d8ae40dc20cbd7bb6e6b36a928e2db2296060ad2 ]

ixgbe_get_drvinfo() calls ixgbe_refresh_fw_version() on every ethtool
query for e610 adapters.  That ends up in ixgbe_discover_flash_size(),
which bisects the full 16 MB NVM space issuing one ACI command per
step (~20 ms each, ~24 steps total = ~500 ms).

Profiling on an idle E610-XAT2 system with telegraf scraping ethtool
stats every 10 seconds:

  kretprobe:ixgbe_get_drvinfo took 527603 us
  kretprobe:ixgbe_get_drvinfo took 523978 us
  kretprobe:ixgbe_get_drvinfo took 552975 us
  kretprobe:ice_get_drvinfo   took       3 us
  kretprobe:igb_get_drvinfo   took       2 us
  kretprobe:i40e_get_drvinfo  took       5 us

The half-second stall happens under the RTNL lock, causing visible
latency on ip-link and friends.

The FW version can only change after an EMPR reset.  All flash data is
already populated at probe time and the cached adapter->eeprom_id is
what get_drvinfo should be returning.  The only place that needs to
trigger a re-read is ixgbe_devlink_reload_empr_finish(), right after
the EMPR completes and new firmware is running.  Additionally, refresh
the FW version in ixgbe_reinit_locked() so that any PF that undergoes a
reinit after an EMPR (e.g. triggered by another PF's devlink reload)
also picks up the new version in adapter->eeprom_id.

ixgbe_devlink_info_get() keeps its refresh call for explicit
"devlink dev info" queries, which is fine given those are user-initiated.

Fixes: c9e563cae19e ("ixgbe: add support for devlink reload")
Co-developed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Error: Failed to generate final synthesis

 drivers/net/ethernet/intel/ixgbe/devlink/devlink.c |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe.h           |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c   | 13 +++++++------
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      | 10 ++++++++++
 4 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
index d227f4d2a2d17..f32e640ef4ac0 100644
--- a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
@@ -474,7 +474,7 @@ static int ixgbe_devlink_reload_empr_finish(struct devlink *devlink,
 	adapter->flags2 &= ~(IXGBE_FLAG2_API_MISMATCH |
 			     IXGBE_FLAG2_FW_ROLLBACK);
 
-	return 0;
+	return ixgbe_refresh_fw_version(adapter);
 }
 
 static const struct devlink_ops ixgbe_devlink_ops = {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index dce4936708eb4..047f04045585a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -973,7 +973,7 @@ int ixgbe_init_interrupt_scheme(struct ixgbe_adapter *adapter);
 bool ixgbe_wol_supported(struct ixgbe_adapter *adapter, u16 device_id,
 			 u16 subdevice_id);
 void ixgbe_set_fw_version_e610(struct ixgbe_adapter *adapter);
-void ixgbe_refresh_fw_version(struct ixgbe_adapter *adapter);
+int ixgbe_refresh_fw_version(struct ixgbe_adapter *adapter);
 #ifdef CONFIG_PCI_IOV
 void ixgbe_full_sync_mac_table(struct ixgbe_adapter *adapter);
 #endif
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 2d660e9edb80a..0c8f310689776 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -1153,12 +1153,17 @@ static int ixgbe_set_eeprom(struct net_device *netdev,
 	return ret_val;
 }
 
-void ixgbe_refresh_fw_version(struct ixgbe_adapter *adapter)
+int ixgbe_refresh_fw_version(struct ixgbe_adapter *adapter)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
+	int err;
+
+	err = ixgbe_get_flash_data(hw);
+	if (err)
+		return err;
 
-	ixgbe_get_flash_data(hw);
 	ixgbe_set_fw_version_e610(adapter);
+	return 0;
 }
 
 static void ixgbe_get_drvinfo(struct net_device *netdev,
@@ -1166,10 +1171,6 @@ static void ixgbe_get_drvinfo(struct net_device *netdev,
 {
 	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
 
-	/* need to refresh info for e610 in case fw reloads in runtime */
-	if (adapter->hw.mac.type == ixgbe_mac_e610)
-		ixgbe_refresh_fw_version(adapter);
-
 	strscpy(drvinfo->driver, ixgbe_driver_name, sizeof(drvinfo->driver));
 
 	strscpy(drvinfo->fw_version, adapter->eeprom_id,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 501216970e611..240f7cc3f213f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -6289,6 +6289,16 @@ void ixgbe_reinit_locked(struct ixgbe_adapter *adapter)
 	if (adapter->flags & IXGBE_FLAG_SRIOV_ENABLED)
 		msleep(2000);
 	ixgbe_up(adapter);
+
+	/* E610 has no FW event to notify all PFs of an EMPR reset, so
+	 * refresh the FW version here to pick up any new FW version after
+	 * a hardware reset (e.g. EMPR triggered by another PF's devlink
+	 * reload).  ixgbe_refresh_fw_version() updates both hw->flash and
+	 * adapter->eeprom_id so ethtool -i reports the correct string.
+	 */
+	if (adapter->hw.mac.type == ixgbe_mac_e610)
+		(void)ixgbe_refresh_fw_version(adapter);
+
 	clear_bit(__IXGBE_RESETTING, &adapter->state);
 }
 
-- 
2.53.0



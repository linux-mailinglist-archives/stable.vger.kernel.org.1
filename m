Return-Path: <stable+bounces-88192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4EA9B0D83
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 20:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEE2C1C2303B
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 18:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB4C20BB5C;
	Fri, 25 Oct 2024 18:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wtc08K3A"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AFF209F57;
	Fri, 25 Oct 2024 18:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729881547; cv=none; b=qJiWIz9zkl+gBa4q+0qqnkcBU4utx3nNikUEcR8m6iT5f9+X0QOG/mGRiFNmnxizNxgLDZJI9GfhKH7OTfT74kf/FbdVJoE9rK3KyR8RkEx+gTEpuAtcbk3l05Aj03l4u7H/jpRWhRscJBaH0VzaLm5C1LoRxjyNhPeHGTsDx4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729881547; c=relaxed/simple;
	bh=fnA0+V9d6R0QH4pHuCxe4JCw3zsvVsBfrNKGuSh+9/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LgR6xgOzKLWTuaepcFfZE06AiLnNZfVsHPiYykRB5xkp3BgeZawhfu+dtka8hPrM7LCWSao3zoMo9//RRXGLgNQP9yK0B86s/KDbkMf9ToVclSQ7xZwrjQINDyhFT4HcT9UgQm2kRVVGTJ58csEnz6fiATH7nXLojIXpm73Heu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wtc08K3A; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729881544; x=1761417544;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fnA0+V9d6R0QH4pHuCxe4JCw3zsvVsBfrNKGuSh+9/Y=;
  b=Wtc08K3A4em7Rs0Uz2ckrxtBRckhJACvEgbZ8OYHRfhnnoQl+FpHnTl9
   obWYP3eMbdKfiOm6jrQrc0hvfdHarztYUspvw0qJandiayipvMnT/lWVE
   TmY99dBgN15YEGAUJNoBMjm0vsqGq6YZlzpvxFwsVbv6Uo+4BP0Jt9t4d
   5y8+3/9YlCbGFm5s4edHU+ZlMSAhoOzyyK1tK0KYkZB2QpFHBJkcck8Wk
   Qq3Ojwjsvl5bAp3olS0n+UQnIGm4795IMIgnqUVK7Hb96c8YX4XY9nL3w
   0BD7lBJFsBvrLKfqOCvL0ooGFSZ5ts2M90RMUmaCh0Era6/qbLMwShZRs
   A==;
X-CSE-ConnectionGUID: S6GO0l0tS+iOx9O4SNBo4g==
X-CSE-MsgGUID: hjPwiyZkQJ2Np/fGCX/1Rg==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="47043915"
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="47043915"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 11:39:01 -0700
X-CSE-ConnectionGUID: 5xjyYdX9SHmtX9LIFV9biw==
X-CSE-MsgGUID: YxweRXZPQlSL3+/YCY6WhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="111801066"
Received: from unknown (HELO localhost.jf.intel.com) ([10.166.80.24])
  by fmviesa001.fm.intel.com with ESMTP; 25 Oct 2024 11:39:01 -0700
From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	horms@kernel.org,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
	stable@vger.kernel.org,
	Tarun K Singh <tarun.k.singh@intel.com>
Subject: [PATCH iwl-net v2 1/2] idpf: avoid vport access in idpf_get_link_ksettings
Date: Fri, 25 Oct 2024 11:38:42 -0700
Message-ID: <20241025183843.34678-2-pavan.kumar.linga@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241025183843.34678-1-pavan.kumar.linga@intel.com>
References: <20241025183843.34678-1-pavan.kumar.linga@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the device control plane is removed or the platform
running device control plane is rebooted, a reset is detected
on the driver. On driver reset, it releases the resources and
waits for the reset to complete. If the reset fails, it takes
the error path and releases the vport lock. At this time if the
monitoring tools tries to access link settings, it call traces
for accessing released vport pointer.

To avoid it, move link_speed_mbps to netdev_priv structure
which removes the dependency on vport pointer and the vport lock
in idpf_get_link_ksettings. Also use netif_carrier_ok()
to check the link status and adjust the offsetof to use link_up
instead of link_speed_mbps.

Fixes: 02cbfba1add5 ("idpf: add ethtool callbacks")
Cc: stable@vger.kernel.org # 6.7+
Reviewed-by: Tarun K Singh <tarun.k.singh@intel.com>
Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h          |  4 ++--
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c  | 11 +++--------
 drivers/net/ethernet/intel/idpf/idpf_lib.c      |  4 ++--
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c |  2 +-
 4 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 2c31ad87587a..66544faab710 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -141,6 +141,7 @@ enum idpf_vport_state {
  * @adapter: Adapter back pointer
  * @vport: Vport back pointer
  * @vport_id: Vport identifier
+ * @link_speed_mbps: Link speed in mbps
  * @vport_idx: Relative vport index
  * @state: See enum idpf_vport_state
  * @netstats: Packet and byte stats
@@ -150,6 +151,7 @@ struct idpf_netdev_priv {
 	struct idpf_adapter *adapter;
 	struct idpf_vport *vport;
 	u32 vport_id;
+	u32 link_speed_mbps;
 	u16 vport_idx;
 	enum idpf_vport_state state;
 	struct rtnl_link_stats64 netstats;
@@ -287,7 +289,6 @@ struct idpf_port_stats {
  * @tx_itr_profile: TX profiles for Dynamic Interrupt Moderation
  * @port_stats: per port csum, header split, and other offload stats
  * @link_up: True if link is up
- * @link_speed_mbps: Link speed in mbps
  * @sw_marker_wq: workqueue for marker packets
  */
 struct idpf_vport {
@@ -331,7 +332,6 @@ struct idpf_vport {
 	struct idpf_port_stats port_stats;
 
 	bool link_up;
-	u32 link_speed_mbps;
 
 	wait_queue_head_t sw_marker_wq;
 };
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index 3806ddd3ce4a..59b1a1a09996 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -1296,24 +1296,19 @@ static void idpf_set_msglevel(struct net_device *netdev, u32 data)
 static int idpf_get_link_ksettings(struct net_device *netdev,
 				   struct ethtool_link_ksettings *cmd)
 {
-	struct idpf_vport *vport;
-
-	idpf_vport_ctrl_lock(netdev);
-	vport = idpf_netdev_to_vport(netdev);
+	struct idpf_netdev_priv *np = netdev_priv(netdev);
 
 	ethtool_link_ksettings_zero_link_mode(cmd, supported);
 	cmd->base.autoneg = AUTONEG_DISABLE;
 	cmd->base.port = PORT_NONE;
-	if (vport->link_up) {
+	if (netif_carrier_ok(netdev)) {
 		cmd->base.duplex = DUPLEX_FULL;
-		cmd->base.speed = vport->link_speed_mbps;
+		cmd->base.speed = np->link_speed_mbps;
 	} else {
 		cmd->base.duplex = DUPLEX_UNKNOWN;
 		cmd->base.speed = SPEED_UNKNOWN;
 	}
 
-	idpf_vport_ctrl_unlock(netdev);
-
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 4f20343e49a9..c3848e10e7db 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1860,7 +1860,7 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 	 * mess with. Nothing below should use those variables from new_vport
 	 * and should instead always refer to them in vport if they need to.
 	 */
-	memcpy(new_vport, vport, offsetof(struct idpf_vport, link_speed_mbps));
+	memcpy(new_vport, vport, offsetof(struct idpf_vport, link_up));
 
 	/* Adjust resource parameters prior to reallocating resources */
 	switch (reset_cause) {
@@ -1906,7 +1906,7 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 	/* Same comment as above regarding avoiding copying the wait_queues and
 	 * mutexes applies here. We do not want to mess with those if possible.
 	 */
-	memcpy(vport, new_vport, offsetof(struct idpf_vport, link_speed_mbps));
+	memcpy(vport, new_vport, offsetof(struct idpf_vport, link_up));
 
 	if (reset_cause == IDPF_SR_Q_CHANGE)
 		idpf_vport_alloc_vec_indexes(vport);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 70986e12da28..3be883726b87 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -141,7 +141,7 @@ static void idpf_handle_event_link(struct idpf_adapter *adapter,
 	}
 	np = netdev_priv(vport->netdev);
 
-	vport->link_speed_mbps = le32_to_cpu(v2e->link_speed);
+	np->link_speed_mbps = le32_to_cpu(v2e->link_speed);
 
 	if (vport->link_up == v2e->link_status)
 		return;
-- 
2.43.0



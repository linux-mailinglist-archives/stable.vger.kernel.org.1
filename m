Return-Path: <stable+bounces-121439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C431A57099
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 19:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 621333A493B
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 18:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F2223F292;
	Fri,  7 Mar 2025 18:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LBbrXkE1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3634194C9E
	for <stable@vger.kernel.org>; Fri,  7 Mar 2025 18:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741372318; cv=none; b=NRygMLZ/P5kvuuOAbpZiE4HUv2sHiQTbdkTbES8IMUwebS4ZJO1Fu/3zdCSlwWJO0mkgOfSB/rwM3D5SZmMX7xFYzh8AsnNJtlafamXm9FnvogeoqFoVC4fmhiNHlfPIKeo5ruToAM/wzpYErzQClWOujeP0cP+9go8Wjyc4ktI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741372318; c=relaxed/simple;
	bh=xAPoOl5E6d6FFqkDAmVH1nYHQECWj7e0x4LjKlRP2os=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RgAsDnh5mDe7kdc9sLPOnipe0LjJPNNH5Lce1Xmz7x+d9twt2XMpHzJepGMhQYNcK4W0fMkFlgRl3Rh8A0rM0HaRCHW6oPISwrEmSVAFXMgqvAGfbZiyS5GEOBjI4drYb2/bu8SIOjLEOyzud8D6bwM2aeHaoOPrrqnKwxnZMMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LBbrXkE1; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741372317; x=1772908317;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xAPoOl5E6d6FFqkDAmVH1nYHQECWj7e0x4LjKlRP2os=;
  b=LBbrXkE1oVp33HCkFR/KC2L+ByMxFNJ/9OCyh8MrI0DzpYVroBib4wKI
   yRYcQmF0WCPW4mlerbKrZALxy8Tp1c5kssiANvuo9idC1oJqKWZfIgjVx
   vD0PTYXuLQB5czfqrZ/u6ylXqhED9ewjt5slXAiNm2EWuSAT4+eTR16z3
   eNyss4t/JZxeT8+GvmUrtRv9KB0nqtoWUuOKTTgiXCp/I7VVnq+jCMRMp
   H3un0Y/Gcvgxu4mfWN3x/VavHoyAxY15auRFb5ZFswxQXagzmqOXblbEt
   0piyX2Zn0cg0WI8nDmJXM5gSQOK0wi0ODuwvpZNv4eU4LcVWHduJcnZpc
   Q==;
X-CSE-ConnectionGUID: BpPzdUtsS3GsEqL5QNCdqg==
X-CSE-MsgGUID: UxmoPUXuQnaQurVOjdVwnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="53068601"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="53068601"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 10:31:55 -0800
X-CSE-ConnectionGUID: CSVWqhpaSY+g8/AVtpBBYw==
X-CSE-MsgGUID: IerteWPUQVm6CrmeYL8Tow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119336588"
Received: from ideak-desk.fi.intel.com ([10.237.72.78])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 10:31:54 -0800
From: Imre Deak <imre.deak@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Wayne Lin <Wayne.Lin@amd.com>,
	Lyude Paul <lyude@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/dp_mst: Fix locking when skipping CSN before topology probing
Date: Fri,  7 Mar 2025 20:31:52 +0200
Message-ID: <20250307183152.3822170-1-imre.deak@intel.com>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The handling of the MST Connection Status Notify message is skipped if
the probing of the topology is still pending. Acquiring the
drm_dp_mst_topology_mgr::probe_lock for this in
drm_dp_mst_handle_up_req() is problematic: the task/work this function
is called from is also responsible for handling MST down-request replies
(in drm_dp_mst_handle_down_rep()). Thus drm_dp_mst_link_probe_work() -
holding already probe_lock - could be blocked waiting for an MST
down-request reply while drm_dp_mst_handle_up_req() is waiting for
probe_lock while processing a CSN message. This leads to the probe
work's down-request message timing out.

A scenario similar to the above leading to a down-request timeout is
handling a CSN message in drm_dp_mst_handle_conn_stat(), holding the
probe_lock and sending down-request messages while a second CSN message
sent by the sink subsequently is handled by drm_dp_mst_handle_up_req().

Fix the above by moving the logic to skip the CSN handling to
drm_dp_mst_process_up_req(). This function is called from a work
(separate from the task/work handling new up/down messages), already
holding probe_lock. This solves the above timeout issue, since handling
of down-request replies won't be blocked by probe_lock.

Fixes: ddf983488c3e ("drm/dp_mst: Skip CSN if topology probing is not done yet")
Cc: Wayne Lin <Wayne.Lin@amd.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org # v6.6+
Signed-off-by: Imre Deak <imre.deak@intel.com>
---
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 40 +++++++++++--------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index 8b68bb3fbffb0..3a1f1ffc7b552 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -4036,6 +4036,22 @@ static int drm_dp_mst_handle_down_rep(struct drm_dp_mst_topology_mgr *mgr)
 	return 0;
 }
 
+static bool primary_mstb_probing_is_done(struct drm_dp_mst_topology_mgr *mgr)
+{
+	bool probing_done = false;
+
+	mutex_lock(&mgr->lock);
+
+	if (mgr->mst_primary && drm_dp_mst_topology_try_get_mstb(mgr->mst_primary)) {
+		probing_done = mgr->mst_primary->link_address_sent;
+		drm_dp_mst_topology_put_mstb(mgr->mst_primary);
+	}
+
+	mutex_unlock(&mgr->lock);
+
+	return probing_done;
+}
+
 static inline bool
 drm_dp_mst_process_up_req(struct drm_dp_mst_topology_mgr *mgr,
 			  struct drm_dp_pending_up_req *up_req)
@@ -4066,8 +4082,12 @@ drm_dp_mst_process_up_req(struct drm_dp_mst_topology_mgr *mgr,
 
 	/* TODO: Add missing handler for DP_RESOURCE_STATUS_NOTIFY events */
 	if (msg->req_type == DP_CONNECTION_STATUS_NOTIFY) {
-		dowork = drm_dp_mst_handle_conn_stat(mstb, &msg->u.conn_stat);
-		hotplug = true;
+		if (!primary_mstb_probing_is_done(mgr)) {
+			drm_dbg_kms(mgr->dev, "Got CSN before finish topology probing. Skip it.\n");
+		} else {
+			dowork = drm_dp_mst_handle_conn_stat(mstb, &msg->u.conn_stat);
+			hotplug = true;
+		}
 	}
 
 	drm_dp_mst_topology_put_mstb(mstb);
@@ -4149,10 +4169,11 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
 	drm_dp_send_up_ack_reply(mgr, mst_primary, up_req->msg.req_type,
 				 false);
 
+	drm_dp_mst_topology_put_mstb(mst_primary);
+
 	if (up_req->msg.req_type == DP_CONNECTION_STATUS_NOTIFY) {
 		const struct drm_dp_connection_status_notify *conn_stat =
 			&up_req->msg.u.conn_stat;
-		bool handle_csn;
 
 		drm_dbg_kms(mgr->dev, "Got CSN: pn: %d ldps:%d ddps: %d mcs: %d ip: %d pdt: %d\n",
 			    conn_stat->port_number,
@@ -4161,16 +4182,6 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
 			    conn_stat->message_capability_status,
 			    conn_stat->input_port,
 			    conn_stat->peer_device_type);
-
-		mutex_lock(&mgr->probe_lock);
-		handle_csn = mst_primary->link_address_sent;
-		mutex_unlock(&mgr->probe_lock);
-
-		if (!handle_csn) {
-			drm_dbg_kms(mgr->dev, "Got CSN before finish topology probing. Skip it.");
-			kfree(up_req);
-			goto out_put_primary;
-		}
 	} else if (up_req->msg.req_type == DP_RESOURCE_STATUS_NOTIFY) {
 		const struct drm_dp_resource_status_notify *res_stat =
 			&up_req->msg.u.resource_stat;
@@ -4185,9 +4196,6 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
 	list_add_tail(&up_req->next, &mgr->up_req_list);
 	mutex_unlock(&mgr->up_req_lock);
 	queue_work(system_long_wq, &mgr->up_req_work);
-
-out_put_primary:
-	drm_dp_mst_topology_put_mstb(mst_primary);
 out_clear_reply:
 	reset_msg_rx_state(&mgr->up_req_recv);
 	return ret;
-- 
2.44.2



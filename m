Return-Path: <stable+bounces-97783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEA79E2590
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 17:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3FDC287EE3
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3882D1E3DCF;
	Tue,  3 Dec 2024 16:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kvWsbJK1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEF31F8909
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 16:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733241718; cv=none; b=OA1F+b5IU3YqJBkBgG6Ln6QtvxJN9oRw9yOu5jlUoa8IVTy2mfHDQYma72Yaae+dt2Cu7yL1RjqFGGegNKFEFBXYRUtAcCVTi4ldYiAmKlKTx1OAQO+W9G3Nbnjoo1vmdx6+4QEZa2hwbaqC2E8ngJ72kYvIU5RGwVCWIa72jpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733241718; c=relaxed/simple;
	bh=k8fwvjctETWNOv+QwoVYOowJ+wYnbUTYofPb3m49Mdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uogOpzxqDMc7MW73Ovl4qHdCU4OAi/zE5t/qeVUFaPHDEiR+M8lMBf67b+N/7PZJV6PDUJN1MOJBMB49s0v4PF8k/WMBFHyc1XAGypRLKzDpaGaN4PBvQjG5/J1lu0myhchEywlOnRuykoR2JfavJbJUlCt1xFIfhyZiNfORFmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kvWsbJK1; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733241715; x=1764777715;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k8fwvjctETWNOv+QwoVYOowJ+wYnbUTYofPb3m49Mdc=;
  b=kvWsbJK1Bx3SJo+gtxciab0amRL+Lmtvic/RPAaC99gvosJgwoljrkpZ
   MVQ4NStnE8tOmzQ/C41LCxhKCF67vhcXrtSqj9HoXPgg0SinI5p8Q8y5V
   ddVxUMGc7oMtBmhezMjtFFKJhFtxM4BZZzWgHfmTdVj4L45Jhtd+LYgac
   /T585JusZrh8MmL2mIbyvujyopyg+S7hrlWk9dpGuHUS/rcHJEAUJOcEw
   0INaw+rFZKEBfKAc5cjDzJA9VQOx0htPXvsmVeBRoRtqX5f6LoICvvsYx
   gLzqHuUGM7TgTbZ3hLecrSeuMo3Jdh6Jhz92w3h3ASTNkGTAVDx69tNsR
   Q==;
X-CSE-ConnectionGUID: teLq0MXHRUqaxvTASWkXhQ==
X-CSE-MsgGUID: yLk+DCzjSveALqLfDXG+kw==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="37236056"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="37236056"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 08:01:55 -0800
X-CSE-ConnectionGUID: cKg/nNRNTwCnWzdj/GfRCw==
X-CSE-MsgGUID: FN9XY4kVRFepH3HXPFPbvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="93313039"
Received: from ideak-desk.fi.intel.com ([10.237.72.78])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 08:01:46 -0800
From: Imre Deak <imre.deak@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	Lyude Paul <lyude@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/7] drm/dp_mst: Verify request type in the corresponding down message reply
Date: Tue,  3 Dec 2024 18:02:18 +0200
Message-ID: <20241203160223.2926014-3-imre.deak@intel.com>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20241203160223.2926014-1-imre.deak@intel.com>
References: <20241203160223.2926014-1-imre.deak@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After receiving the response for an MST down request message, the
response should be accepted/parsed only if the response type matches
that of the request. Ensure this by checking if the request type code
stored both in the request and the reply match, dropping the reply in
case of a mismatch.

This fixes the topology detection for an MST hub, as described in the
Closes link below, where the hub sends an incorrect reply message after
a CLEAR_PAYLOAD_TABLE -> LINK_ADDRESS down request message sequence.

Cc: Lyude Paul <lyude@redhat.com>
Cc: <stable@vger.kernel.org>
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/12804
Signed-off-by: Imre Deak <imre.deak@intel.com>
---
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index 1475aa95ab6b2..bcf3a33123be1 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -3941,6 +3941,34 @@ drm_dp_get_one_sb_msg(struct drm_dp_mst_topology_mgr *mgr, bool up,
 	return true;
 }
 
+static int get_msg_request_type(u8 data)
+{
+	return data & 0x7f;
+}
+
+static bool verify_rx_request_type(struct drm_dp_mst_topology_mgr *mgr,
+				   const struct drm_dp_sideband_msg_tx *txmsg,
+				   const struct drm_dp_sideband_msg_rx *rxmsg)
+{
+	const struct drm_dp_sideband_msg_hdr *hdr = &rxmsg->initial_hdr;
+	const struct drm_dp_mst_branch *mstb = txmsg->dst;
+	int tx_req_type = get_msg_request_type(txmsg->msg[0]);
+	int rx_req_type = get_msg_request_type(rxmsg->msg[0]);
+	char rad_str[64];
+
+	if (tx_req_type == rx_req_type)
+		return true;
+
+	drm_dp_mst_rad_to_str(mstb->rad, mstb->lct, rad_str, sizeof(rad_str));
+	drm_dbg_kms(mgr->dev,
+		    "Got unexpected MST reply, mstb: %p seqno: %d lct: %d rad: %s rx_req_type: %s (%02x) != tx_req_type: %s (%02x)\n",
+		    mstb, hdr->seqno, mstb->lct, rad_str,
+		    drm_dp_mst_req_type_str(rx_req_type), rx_req_type,
+		    drm_dp_mst_req_type_str(tx_req_type), tx_req_type);
+
+	return false;
+}
+
 static int drm_dp_mst_handle_down_rep(struct drm_dp_mst_topology_mgr *mgr)
 {
 	struct drm_dp_sideband_msg_tx *txmsg;
@@ -3970,6 +3998,9 @@ static int drm_dp_mst_handle_down_rep(struct drm_dp_mst_topology_mgr *mgr)
 		goto out_clear_reply;
 	}
 
+	if (!verify_rx_request_type(mgr, txmsg, msg))
+		goto out_clear_reply;
+
 	drm_dp_sideband_parse_reply(mgr, msg, &txmsg->reply);
 
 	if (txmsg->reply.reply_type == DP_SIDEBAND_REPLY_NAK) {
-- 
2.44.2



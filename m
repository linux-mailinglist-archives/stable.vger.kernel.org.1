Return-Path: <stable+bounces-127268-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BD8A76D8D
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 21:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 245EE7A2F39
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 19:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3659B2165F3;
	Mon, 31 Mar 2025 19:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="lLbVueT6"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2C240BF5
	for <stable@vger.kernel.org>; Mon, 31 Mar 2025 19:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743450144; cv=none; b=nSUZTKAzQX/pDpsccfbr/E0lHpSz2ZsZY+YUs8A0eLufk0Sn359wA/5CMnFB1mCUlvWtyz1adtgrrbcARK40a+FZF9PJ8hegnB3wVvbcFXBh9xnxDcBacpiqt6eBtLDMO9azcGJo8eKZ+vVhK3aCCU4h8z4l57ahnDekfpwO+2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743450144; c=relaxed/simple;
	bh=1rdzZgaopTotZkNIRmA717+eLaCzNdtBc/yDyNQ2b0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tmJ/W1AOxfegYwG3ra/eEuZ0Naj8SjW7kv/DAC7khiwrYRnqEgaxHm8qDiWyz0y8ri2mMysyXZT+MA/9EB3y9X/3j0QKo7BIytp027fof9aLVW089naNrmt3QNrHfULrX5THwRgMhMpXQR9+Eczsz6LXe7/wGV68CYZqP97xev8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=lLbVueT6; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=lKMAFtRCx2LB6z27ofQ9uHfRH+dwUW5nwAVN63fZ0o0=; b=lLbVueT6u00GZOvnPbJu08dnSp
	oMlUMGivQZxBrGAMkmGrP+jToCs9aS0DhyxehVv9IU8vDPaYvK669RXnyxe3TY5X/w2z3Fhg10I9s
	8R95dSRiD+GeAPXOpaGF7n2u0qkQjxjqVU2eMwaZ8OTYy/3Ik1ICZ6bsvoPOyVYCYUJGnTe11sgJX
	aWlG/qYR8LlIGHPVW+F+IDJ94WB4a4aXBeJsL9EG/Cum4qeFgyqkQGoY4v0CvST858fKNFfpFsWGA
	CqfjKOywn6lqJILW1YuycJysl9eR6Zs8OwrpEiJzVO0pVwPY1WSTDV3eViGB2aiDJWwb/d+uJ59yO
	xZ+sltvg==;
Received: from [179.125.94.226] (helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tzL1U-009LPP-0C; Mon, 31 Mar 2025 21:42:17 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Imre Deak <imre.deak@intel.com>,
	Lyude Paul <lyude@redhat.com>,
	Wayne Lin <Wayne.Lin@amd.com>,
	Jerry Zuo <jerry.zuo@amd.com>,
	Zaeem Mohamed <zaeem.mohamed@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	kernel-dev@igalia.com,
	cascardo@igalia.com
Subject: [PATCH 6.6 2/3] drm/dp_mst: Add a helper to queue a topology probe
Date: Mon, 31 Mar 2025 16:42:16 -0300
Message-ID: <20250331194217.763735-2-cascardo@igalia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250331194217.763735-1-cascardo@igalia.com>
References: <20250331194217.763735-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Imre Deak <imre.deak@intel.com>

[ Upstream commit dbaeef363ea54f4c18112874b77503c72ba60fec ]

A follow up i915 patch will need to reprobe the MST topology after the
initial probing, add a helper for this.

Cc: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240722165503.2084999-3-imre.deak@intel.com
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 27 +++++++++++++++++++
 include/drm/display/drm_dp_mst_helper.h       |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index 2a6feb83f786..71a30387ca12 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -3685,6 +3685,33 @@ drm_dp_mst_topology_mgr_invalidate_mstb(struct drm_dp_mst_branch *mstb)
 			drm_dp_mst_topology_mgr_invalidate_mstb(port->mstb);
 }
 
+/**
+ * drm_dp_mst_topology_queue_probe - Queue a topology probe
+ * @mgr: manager to probe
+ *
+ * Queue a work to probe the MST topology. Driver's should call this only to
+ * sync the topology's HW->SW state after the MST link's parameters have
+ * changed in a way the state could've become out-of-sync. This is the case
+ * for instance when the link rate between the source and first downstream
+ * branch device has switched between UHBR and non-UHBR rates. Except of those
+ * cases - for instance when a sink gets plugged/unplugged to a port - the SW
+ * state will get updated automatically via MST UP message notifications.
+ */
+void drm_dp_mst_topology_queue_probe(struct drm_dp_mst_topology_mgr *mgr)
+{
+	mutex_lock(&mgr->lock);
+
+	if (drm_WARN_ON(mgr->dev, !mgr->mst_state || !mgr->mst_primary))
+		goto out_unlock;
+
+	drm_dp_mst_topology_mgr_invalidate_mstb(mgr->mst_primary);
+	drm_dp_mst_queue_probe_work(mgr);
+
+out_unlock:
+	mutex_unlock(&mgr->lock);
+}
+EXPORT_SYMBOL(drm_dp_mst_topology_queue_probe);
+
 /**
  * drm_dp_mst_topology_mgr_suspend() - suspend the MST manager
  * @mgr: manager to suspend
diff --git a/include/drm/display/drm_dp_mst_helper.h b/include/drm/display/drm_dp_mst_helper.h
index ab1d73f93408..46705dacdd08 100644
--- a/include/drm/display/drm_dp_mst_helper.h
+++ b/include/drm/display/drm_dp_mst_helper.h
@@ -859,6 +859,8 @@ int drm_dp_check_act_status(struct drm_dp_mst_topology_mgr *mgr);
 void drm_dp_mst_dump_topology(struct seq_file *m,
 			      struct drm_dp_mst_topology_mgr *mgr);
 
+void drm_dp_mst_topology_queue_probe(struct drm_dp_mst_topology_mgr *mgr);
+
 void drm_dp_mst_topology_mgr_suspend(struct drm_dp_mst_topology_mgr *mgr);
 int __must_check
 drm_dp_mst_topology_mgr_resume(struct drm_dp_mst_topology_mgr *mgr,
-- 
2.47.2



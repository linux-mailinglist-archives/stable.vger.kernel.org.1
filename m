Return-Path: <stable+bounces-100722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F3F9ED547
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 19:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D820188AA8B
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 18:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59626244D64;
	Wed, 11 Dec 2024 18:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CeeL2CyF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A1F244D55;
	Wed, 11 Dec 2024 18:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943110; cv=none; b=dPYjuO8PHHKyc+rcyn5CX4kGzA2jhdMC46vMO2bCOil5tiO1fnuUxoqJV4PMaGxEbXDwaNqMDc/lOimrTlxMbtrTd9gFaP7ZrugNmx9V1nAda+0m3jBQnakGg/6VvFD4t44I1HWUiZPEJLQqqB6ABfdUEaA9ScBIRpXhdYAOhTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943110; c=relaxed/simple;
	bh=1RqGStyKhgV/GQphYSxtp915b3UclsbL6+B3aNayzyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=emRcJWt37X9QBmfbnIBSPGY54FPhp8z7MlTWDS+3z1rnu7azhetQ4EXDvUhDgp7fltsNyZepzCzmffwJ+HtaFaoNhc7wFpTQlXsJsPDnzMSjJAiOk9u/TsZH5VMj+GPDalcLSXzgpOjOPE5BFoLV35nmZl+MDVeEjZGSc6dUuNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CeeL2CyF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275D4C4CEDD;
	Wed, 11 Dec 2024 18:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943109;
	bh=1RqGStyKhgV/GQphYSxtp915b3UclsbL6+B3aNayzyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CeeL2CyF5Fyg6c5KGj/CQay3yyhEeH+LL9Kdoku3j5ET1wADMFPHGWCWOBuqwMOop
	 incCdnBQcX78p6T9trs0kas4Tz8c8I84pvY3n7dljsnfdCCaq1MBxHIHEBNPld7e+Y
	 59ElTSqxfNjK8fQpfTsiZ+HBPzE8moZJV5qWIs8BT6SrPeiE+629CMMvamWUxI+uq+
	 vPGpQSnCXBEOAfJ22P3VjygxwXzT6l2JD9iIuvxhnmWG0JpS4nEgxSkIrRWZy5Uf6a
	 OGAKnpYebMw+bjrS2kcbp6ufIdZswKlvpVVh2mXwvCui+mn/jucTEZ7AYe9wYM46S3
	 l2i8d3Am6KuLw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Imre Deak <imre.deak@intel.com>,
	Lyude Paul <lyude@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	jani.nikula@intel.com,
	harry.wentland@amd.com,
	alexander.deucher@amd.com,
	Wayne.Lin@amd.com,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 32/36] drm/dp_mst: Ensure mst_primary pointer is valid in drm_dp_mst_handle_up_req()
Date: Wed, 11 Dec 2024 13:49:48 -0500
Message-ID: <20241211185028.3841047-32-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185028.3841047-1-sashal@kernel.org>
References: <20241211185028.3841047-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.4
Content-Transfer-Encoding: 8bit

From: Imre Deak <imre.deak@intel.com>

[ Upstream commit e54b00086f7473dbda1a7d6fc47720ced157c6a8 ]

While receiving an MST up request message from one thread in
drm_dp_mst_handle_up_req(), the MST topology could be removed from
another thread via drm_dp_mst_topology_mgr_set_mst(false), freeing
mst_primary and setting drm_dp_mst_topology_mgr::mst_primary to NULL.
This could lead to a NULL deref/use-after-free of mst_primary in
drm_dp_mst_handle_up_req().

Avoid the above by holding a reference for mst_primary in
drm_dp_mst_handle_up_req() while it's used.

v2: Fix kfreeing the request if getting an mst_primary reference fails.

Cc: Lyude Paul <lyude@redhat.com>
Reviewed-by: Lyude Paul <lyude@redhat.com> (v1)
Signed-off-by: Imre Deak <imre.deak@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241204132007.3132494-1-imre.deak@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 24 ++++++++++++++-----
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index ac90118b9e7a8..a13514d106345 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -4070,9 +4070,10 @@ static void drm_dp_mst_up_req_work(struct work_struct *work)
 static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
 {
 	struct drm_dp_pending_up_req *up_req;
+	struct drm_dp_mst_branch *mst_primary;
 
 	if (!drm_dp_get_one_sb_msg(mgr, true, NULL))
-		goto out;
+		goto out_clear_reply;
 
 	if (!mgr->up_req_recv.have_eomt)
 		return 0;
@@ -4090,10 +4091,19 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
 		drm_dbg_kms(mgr->dev, "Received unknown up req type, ignoring: %x\n",
 			    up_req->msg.req_type);
 		kfree(up_req);
-		goto out;
+		goto out_clear_reply;
+	}
+
+	mutex_lock(&mgr->lock);
+	mst_primary = mgr->mst_primary;
+	if (!mst_primary || !drm_dp_mst_topology_try_get_mstb(mst_primary)) {
+		mutex_unlock(&mgr->lock);
+		kfree(up_req);
+		goto out_clear_reply;
 	}
+	mutex_unlock(&mgr->lock);
 
-	drm_dp_send_up_ack_reply(mgr, mgr->mst_primary, up_req->msg.req_type,
+	drm_dp_send_up_ack_reply(mgr, mst_primary, up_req->msg.req_type,
 				 false);
 
 	if (up_req->msg.req_type == DP_CONNECTION_STATUS_NOTIFY) {
@@ -4110,13 +4120,13 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
 			    conn_stat->peer_device_type);
 
 		mutex_lock(&mgr->probe_lock);
-		handle_csn = mgr->mst_primary->link_address_sent;
+		handle_csn = mst_primary->link_address_sent;
 		mutex_unlock(&mgr->probe_lock);
 
 		if (!handle_csn) {
 			drm_dbg_kms(mgr->dev, "Got CSN before finish topology probing. Skip it.");
 			kfree(up_req);
-			goto out;
+			goto out_put_primary;
 		}
 	} else if (up_req->msg.req_type == DP_RESOURCE_STATUS_NOTIFY) {
 		const struct drm_dp_resource_status_notify *res_stat =
@@ -4133,7 +4143,9 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
 	mutex_unlock(&mgr->up_req_lock);
 	queue_work(system_long_wq, &mgr->up_req_work);
 
-out:
+out_put_primary:
+	drm_dp_mst_topology_put_mstb(mst_primary);
+out_clear_reply:
 	memset(&mgr->up_req_recv, 0, sizeof(struct drm_dp_sideband_msg_rx));
 	return 0;
 }
-- 
2.43.0



Return-Path: <stable+bounces-127269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7920AA76D8E
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 21:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C930B3AABC4
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 19:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16072215067;
	Mon, 31 Mar 2025 19:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="PfD6USYn"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95391214201
	for <stable@vger.kernel.org>; Mon, 31 Mar 2025 19:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743450150; cv=none; b=erpusD6vzWoOYnE5a9NR24SrWVGsmtpXi+I+VL3P4HIPeybI6RrxYxc0WieEyjdB0O6nuXyMrKr8J6VWOlv69GtkUUkaU/y2Tj50zewZGPNBl91nl0hyp7E9eUCLnVjFLinHCxu5aeojnw/svHpnd1z7LrOEpt2mx8IFRLtmzJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743450150; c=relaxed/simple;
	bh=aPKWTk9O6jvx7rc6Zp+Is6TBVXCKivNv+Hw0kK9/cTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zl8ZP8LU0HVoT6Ui3JI5cUsr2UiqJ01d9Pf+dCvMc9lpyQOHDXrw+G7xWh89cYs4JuUbDt8pPIMIAjzrz6CegWbAc+NHeLcpRvBM0/2R+/oOEbjdX/t8iiHXkEi/xM2TX/CRgOR/Sgo14tWp3PntnVTeumiGWxCWvrw7bxW88rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=PfD6USYn; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=rVlZZIyv4OmgkIPoXTTB1AOOU+jCOEaTz7XE+EIH4Es=; b=PfD6USYnQn7UdkrdK8S+n6AhjU
	KPG1r0g+MGl8ap2Fkr/Jle67xArcIR/Chclmh3xVu4n1gCge+URpJ/VDnq4l88hAO1ejlzkUCry3f
	DG2VfY805uCZF4xDRYKUukV/efvmQaH3IqSbBD7LsXASKcwjzdV6FwaKQU6mK32iMfBfef5kgtBOa
	EVyJoL/8I7eL+I8IYoP4VdVtVaDWYeAevY+xhHa2/lSMXWR4jUA6rO9Iqac7u4u3h3fOl04Exl6g8
	3WG0nhPHXMXdX/98VlHKrZcZOTRJ/VvGjZ7fnvXGkJPkY16hLjl8fc+ewJi4gq1YOlEXXbJ8eGJ69
	LRrRrF6A==;
Received: from [179.125.94.226] (helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tzL1d-009LPP-1s; Mon, 31 Mar 2025 21:42:26 +0200
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
Subject: [PATCH 6.6 3/3] drm/amd/display: Don't write DP_MSTM_CTRL after LT
Date: Mon, 31 Mar 2025 16:42:17 -0300
Message-ID: <20250331194217.763735-3-cascardo@igalia.com>
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

From: Wayne Lin <Wayne.Lin@amd.com>

[ Upstream commit bc068194f548ef1f230d96c4398046bf59165992 ]

[Why]
Observe after suspend/resme, we can't light up mst monitors under specific
mst hub. The reason is that driver still writes DPCD DP_MSTM_CTRL after LT.
It's forbidden even we write the same value for that dpcd register.

[How]
We already resume the mst branch device dpcd settings during
resume_mst_branch_status(). Leverage drm_dp_mst_topology_queue_probe() to
only probe the topology, not calling drm_dp_mst_topology_mgr_resume() which
will set DP_MSTM_CTRL as well.

Reviewed-by: Jerry Zuo <jerry.zuo@amd.com>
Change-Id: I879e9f2e53dfb6fa28a33b6202a5402945ae91c5
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
[cascardo: adjust context in local declarations]
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 986ee37688c1..2b7f98a2e36f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2825,8 +2825,7 @@ static int dm_resume(void *handle)
 	struct dm_atomic_state *dm_state = to_dm_atomic_state(dm->atomic_obj.state);
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	struct dc_state *dc_state;
-	int i, r, j, ret;
-	bool need_hotplug = false;
+	int i, r, j;
 
 	if (amdgpu_in_reset(adev)) {
 		dc_state = dm->cached_dc_state;
@@ -3003,23 +3002,16 @@ static int dm_resume(void *handle)
 		    aconnector->mst_root)
 			continue;
 
-		ret = drm_dp_mst_topology_mgr_resume(&aconnector->mst_mgr, true);
-
-		if (ret < 0) {
-			dm_helpers_dp_mst_stop_top_mgr(aconnector->dc_link->ctx,
-					aconnector->dc_link);
-			need_hotplug = true;
-		}
+		drm_dp_mst_topology_queue_probe(&aconnector->mst_mgr);
 	}
 	drm_connector_list_iter_end(&iter);
 
-	if (need_hotplug)
-		drm_kms_helper_hotplug_event(ddev);
-
 	amdgpu_dm_irq_resume_late(adev);
 
 	amdgpu_dm_smu_write_watermarks_table(adev);
 
+	drm_kms_helper_hotplug_event(ddev);
+
 	return 0;
 }
 
-- 
2.47.2



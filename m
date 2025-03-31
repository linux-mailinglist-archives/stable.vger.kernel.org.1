Return-Path: <stable+bounces-127260-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EE1A76A63
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 17:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD38E7A03D4
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 15:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124872147E0;
	Mon, 31 Mar 2025 14:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="C092Emt5"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B500202978
	for <stable@vger.kernel.org>; Mon, 31 Mar 2025 14:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743433106; cv=none; b=gsv/e5A8H36jnoaBNrcpUkAcDsac7xNz6PsPDn0EYYmK0lCw4YufBWVfILn8GasnFStW84c9oLdMRyyc5xuXSTMcqJLweWST97XxsaZ/1w8ZeNH9Y3IQrxFHf0D5iAySmYPDhS8ck0ZLBBJU/zoDVlSQsNb5t/N8uO7DGK0jDG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743433106; c=relaxed/simple;
	bh=AytwwkCCw7mAVvmaQUJ146h6BcX7r/O6OSfcod8qcGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fJWGh4/BksQ5feBdfOJNcnit0pKGHGbCeE/wU8g1myfownjhT4O8h568RrO/kJzTovxFHbvwSg6DdyOkKHWtq5sIuPglcz4CtYz8LRWcNYZ//eadUCYMgDMDB3T5lASbcfuDiGe6unNQN4+9X8I0gjhqS169/p7h4/9UDnfUo4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=C092Emt5; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=x2CQAuRRAYRwMlr3omFwD6fijeSiAzW0M3gV5PMmEAQ=; b=C092Emt5ERNe/qO651jZskXloE
	3D6dgtXYyqVSPFli/fs6K2kA2fFvXty4vnGuqCO1O2LdjRcJs7H3SDYRrWwGDEZbxS/g3ko6zpKni
	IjTN9FUNmCzkRJnUiWERFjbO2z4xopt9QXOkRNGnuP85RnpTAaPGrR02ZWKuHDl06TqesQhLC+Nl/
	UKcVbJL8RGnf74/RenAG+7JOM14Z4Z0NX3mHUWYzMXqrZTZedIgR+Muz1UoSlAmg7Z9yeTqErycNj
	gAPJ+3fNWnhKyTSazHHiA0JZbWSw0r1mw5/khznEkw2WMqY162LpPRJLWxVh1JZsRjKIfl6BuZOal
	fYv1knxQ==;
Received: from [179.125.94.226] (helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tzGah-009FbH-Vz; Mon, 31 Mar 2025 16:58:20 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Wayne Lin <Wayne.Lin@amd.com>,
	Jerry Zuo <jerry.zuo@amd.com>,
	Zaeem Mohamed <zaeem.mohamed@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	kernel-dev@igalia.com,
	cascardo@igalia.com
Subject: [PATCH 6.12] drm/amd/display: Don't write DP_MSTM_CTRL after LT
Date: Mon, 31 Mar 2025 11:58:19 -0300
Message-ID: <20250331145819.682274-1-cascardo@igalia.com>
X-Mailer: git-send-email 2.47.2
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
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d9a3917d207e..c4c6538eabae 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3231,8 +3231,7 @@ static int dm_resume(void *handle)
 	struct dm_atomic_state *dm_state = to_dm_atomic_state(dm->atomic_obj.state);
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	struct dc_state *dc_state;
-	int i, r, j, ret;
-	bool need_hotplug = false;
+	int i, r, j;
 	struct dc_commit_streams_params commit_params = {};
 
 	if (dm->dc->caps.ips_support) {
@@ -3427,23 +3426,16 @@ static int dm_resume(void *handle)
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



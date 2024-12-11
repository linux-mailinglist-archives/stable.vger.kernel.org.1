Return-Path: <stable+bounces-100723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4383A9ED549
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 19:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EA4E1882826
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 18:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47700244D58;
	Wed, 11 Dec 2024 18:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Am2NNJVX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0F7244D55;
	Wed, 11 Dec 2024 18:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943114; cv=none; b=NGDk5SQ89w3a0+P8SeafcP4YlPDg6iJDaf1NDNzfVv6uT0o8eMG8Rb4VDbiXWRM+O0Qk5pEHQElpEYhEiYzrbH6TvkRkVYS3QqUwQs6spE7wmFNHBAVrQfk7iB+cV3i6zEwbNM9W+NeZ8dbNEFf+CZIz/OFo4kBKs09MQUQNGkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943114; c=relaxed/simple;
	bh=+HSKXP6r3NyuvfrA0kmvVvwH4bgMKZCwVV7m4fl+PPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=emh2Tfcg2d2pOIQIPtksmChFn85V79mAqy52MDHayi/jrc5FjFKX9Pdy/4PqK5QWnGLoCNnS46O7bVBTMBWATyI967UXExllRhoXzwiK7g8Vdu1fNl7kOujdM4KwD1NexIcssGFI+k80XY/ENVI+yzqAfupti0MFBi68QVkxECk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Am2NNJVX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20BC3C4CED2;
	Wed, 11 Dec 2024 18:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943113;
	bh=+HSKXP6r3NyuvfrA0kmvVvwH4bgMKZCwVV7m4fl+PPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Am2NNJVXrnn2WK27Jl0+3zvmPrPGOB2NhEPfDVbkmMuK1eRIhjO8MBQgzh6hJp4KT
	 lTILytvkRSN7wOI5ZrP37jEJWcgEDYXEdzGpaK92CnvuUgozGVDT5vl4QojA93NqJw
	 1S1tuQ8FcWSsjwDyEiwIhBoThZkFHhLnddpYCkDE6GOrLJKiV+ym8NQ5xjpdP2q8QL
	 VfX9EkjlM38okJTMDGJ4vBGvNZUY1bmah3QJFI8dqyynIKn88A/mZ/y2/W7f/v3HEU
	 ymOHs8MHE9qp/Ghrh3ZEKuyYl2iDFNL6d7HVoBoKkcSHF0loKK/YxVIl0neGZ4zRtf
	 eBWh4AjoUZDAQ==
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
	alexander.deucher@amd.com,
	harry.wentland@amd.com,
	Wayne.Lin@amd.com,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 33/36] drm/dp_mst: Reset message rx state after OOM in drm_dp_mst_handle_up_req()
Date: Wed, 11 Dec 2024 13:49:49 -0500
Message-ID: <20241211185028.3841047-33-sashal@kernel.org>
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

[ Upstream commit 2b245c97b1af5d8f04c359e0826cb5a5c81ef704 ]

After an out-of-memory error the reception state should be reset, so
that the next attempt receiving a message doesn't fail (due to getting a
start-of-message packet, while the reception state has already the
start-of-message flag set).

Cc: Lyude Paul <lyude@redhat.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241203160223.2926014-7-imre.deak@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index a13514d106345..788ca93040997 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -4071,6 +4071,7 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
 {
 	struct drm_dp_pending_up_req *up_req;
 	struct drm_dp_mst_branch *mst_primary;
+	int ret = 0;
 
 	if (!drm_dp_get_one_sb_msg(mgr, true, NULL))
 		goto out_clear_reply;
@@ -4079,8 +4080,10 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
 		return 0;
 
 	up_req = kzalloc(sizeof(*up_req), GFP_KERNEL);
-	if (!up_req)
-		return -ENOMEM;
+	if (!up_req) {
+		ret = -ENOMEM;
+		goto out_clear_reply;
+	}
 
 	INIT_LIST_HEAD(&up_req->next);
 
@@ -4147,7 +4150,7 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
 	drm_dp_mst_topology_put_mstb(mst_primary);
 out_clear_reply:
 	memset(&mgr->up_req_recv, 0, sizeof(struct drm_dp_sideband_msg_rx));
-	return 0;
+	return ret;
 }
 
 /**
-- 
2.43.0



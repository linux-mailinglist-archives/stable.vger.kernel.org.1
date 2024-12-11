Return-Path: <stable+bounces-100746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 570559ED586
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 20:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 102F1283120
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 19:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC5D24B22B;
	Wed, 11 Dec 2024 18:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecvZY0FG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F9C24B226;
	Wed, 11 Dec 2024 18:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943181; cv=none; b=qjb+6sbXeK9kBu28ZOjPtU6lhxB44FPpAH5tPe1DfZxwCL0MNXbn4GZXfHB6bQc7wpL9CTmVdT/IdRsSKppZC6wb6mHrP2lWl+TmJ8925XRJ3XgFNZ0HBZ4qMEPe+rRPUJisYqt5GQ5CWhh0KkUdjawiuZX9ZCCmoNa0mhsFDPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943181; c=relaxed/simple;
	bh=PapIcMWuQBW53H0NJkjda0FyjBJnhe9N/rI7amErZe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uITs5T62dtRU0/84O1jxLwnX6X4zYGs03cIj5k0ECQTJEfbJNENrJmu5WFhSsymKOZvPd4o14RSd+RcFSo+QwSIUrmExDmesrIH4jmj3mXDuZSyd/uvvIcTuObECq7LAQ4UAzjr6LCrMuFOmw+CPKVresmIv25rE6k09/q4+6oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecvZY0FG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60D1C4CEDE;
	Wed, 11 Dec 2024 18:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943180;
	bh=PapIcMWuQBW53H0NJkjda0FyjBJnhe9N/rI7amErZe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ecvZY0FGQDtoLcF7KWTvukbjKA3Dt3nfZ1TleP6W4Z9hu4qSn8BqpDX5tvTAgyaG/
	 Ngvn841fqXfmvTpUJjgZSEsMu9haozYvY5EkhuF3qQGUgDYck4O+DqWsU4PIYZ2pSl
	 8/GcCoHuclwxt9TsoAd2SngDGfOrfxYD3moS+mnOqvauFMHv3nc/SX64HdyhdTo3Kg
	 +O8eFWwfGJwOm8/lS6IiOO9V7ibBzxx5pTe8VVGRhrOJr7WACJhYbWnVW4kk1Hpu1G
	 CHqyGOIzc0FTNmtAs0KRYm4mfrKkhyruxOeTvC4VPFWKfj9PcE34NnzY+DkFRES1vn
	 +EXtlKGEgRuNw==
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
Subject: [PATCH AUTOSEL 6.6 20/23] drm/dp_mst: Reset message rx state after OOM in drm_dp_mst_handle_up_req()
Date: Wed, 11 Dec 2024 13:51:57 -0500
Message-ID: <20241211185214.3841978-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185214.3841978-1-sashal@kernel.org>
References: <20241211185214.3841978-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.65
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
index 4d954e50964f0..b3c613f5e2089 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -3996,6 +3996,7 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
 {
 	struct drm_dp_pending_up_req *up_req;
 	struct drm_dp_mst_branch *mst_primary;
+	int ret = 0;
 
 	if (!drm_dp_get_one_sb_msg(mgr, true, NULL))
 		goto out_clear_reply;
@@ -4004,8 +4005,10 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
 		return 0;
 
 	up_req = kzalloc(sizeof(*up_req), GFP_KERNEL);
-	if (!up_req)
-		return -ENOMEM;
+	if (!up_req) {
+		ret = -ENOMEM;
+		goto out_clear_reply;
+	}
 
 	INIT_LIST_HEAD(&up_req->next);
 
@@ -4072,7 +4075,7 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
 	drm_dp_mst_topology_put_mstb(mst_primary);
 out_clear_reply:
 	memset(&mgr->up_req_recv, 0, sizeof(struct drm_dp_sideband_msg_rx));
-	return 0;
+	return ret;
 }
 
 /**
-- 
2.43.0



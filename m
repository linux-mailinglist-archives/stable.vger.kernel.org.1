Return-Path: <stable+bounces-140541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C03B8AAAE12
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 337B818907BB
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BD03731B7;
	Mon,  5 May 2025 22:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMIxcF+o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9A235B941;
	Mon,  5 May 2025 22:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485090; cv=none; b=V8sIt2S6GNYi+YPmSk3BfA/FqnS4hcqVq8lbPFydHeM/afOYWpL6LJEE4D1NkwAbpVFIlqmGlscJiVDZjaGHTcX10cg8O4C85ilAhDMkWtBNXcQKtUF1xViBt+O8cr1b1eyRhSmkEei5SD0KAxy7PfSOElCXTFBDYD8hE09uDI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485090; c=relaxed/simple;
	bh=LCnnPAWWj9dD4v3jedrgPS8PzuwhW6mTI4/VpNY/qZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qe6KPziVj+Owm62hU+Ar5bAwhhhs8tnMaD8381Tu0VEN2UhpV1xUEwyClqcS7mfxAApXagxVvqJClen/M59zuNWxyb6P6EGu+xLeMjapnBti/VRh1OjRmln1xGSEGTCxbYCG0lBum3GvBKzBdYCpmVQYptXJZBq/+mLraSV/Qw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMIxcF+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3656DC4CEE4;
	Mon,  5 May 2025 22:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485090;
	bh=LCnnPAWWj9dD4v3jedrgPS8PzuwhW6mTI4/VpNY/qZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FMIxcF+oIvruhNxU/yj2+dfsIgdH9OIVguARj99/Ceeeucwp2WitamSJX0GSYN9d3
	 lOiZy2DKvod7kDYWn9ndL4zzXT0XTtIh/AmE8M8oiSHgg18I/nKRSdICHIvKv5/zji
	 +oFPVGUWwmAhMlLJkld4zRcHdoTUTu6Xc/Cs661y7PVj2Ry6Zn+XcKR9aT2KpezY08
	 csoJzZf2OzGCHCcuGyTSQcoTTLbELSDiLOS9GJ4RhGzqw3Sg8wgLTjarDaPM8DHNNZ
	 gjIllpAiRqzPNNnykmsvH3GkWHrokrLwX3rz8HiSlXW0GaHNXI4eGeTIx1yBXKUJHR
	 4JK7JEBRTFWlg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peichen Huang <PeiChen.Huang@amd.com>,
	Cruise Hung <cruise.hung@amd.com>,
	Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	wenjing.liu@amd.com,
	alex.hung@amd.com,
	Jerry.Zuo@amd.com,
	michael.strauss@amd.com,
	Brendan.Tam@amd.com,
	ivlipski@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 158/486] drm/amd/display: not abort link train when bw is low
Date: Mon,  5 May 2025 18:33:54 -0400
Message-Id: <20250505223922.2682012-158-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Peichen Huang <PeiChen.Huang@amd.com>

[ Upstream commit 8a21da2842bb22b2b80e5902d0438030d729bfd3 ]

[WHY]
DP tunneling should not abort link train even bandwidth become
too low after downgrade. Otherwise, it would fail compliance test.

[HOW}
Do link train with downgrade settings even bandwidth is not enough

Reviewed-by: Cruise Hung <cruise.hung@amd.com>
Reviewed-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Signed-off-by: Peichen Huang <PeiChen.Huang@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_training.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index 27b881f947e8b..9385a32a471b8 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -1769,13 +1769,10 @@ bool perform_link_training_with_retries(
 			is_link_bw_min = ((cur_link_settings.link_rate <= LINK_RATE_LOW) &&
 				(cur_link_settings.lane_count <= LANE_COUNT_ONE));
 
-			if (is_link_bw_low) {
+			if (is_link_bw_low)
 				DC_LOG_WARNING(
 					"%s: Link(%d) bandwidth too low after fallback req_bw(%d) > link_bw(%d)\n",
 					__func__, link->link_index, req_bw, link_bw);
-
-				return false;
-			}
 		}
 
 		msleep(delay_between_attempts);
-- 
2.39.5



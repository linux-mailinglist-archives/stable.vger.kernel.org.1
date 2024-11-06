Return-Path: <stable+bounces-90044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3300E9BDCDE
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 03:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF981288967
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 02:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329C21D86FB;
	Wed,  6 Nov 2024 02:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyyoZYPF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CCA1D86E4;
	Wed,  6 Nov 2024 02:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859291; cv=none; b=N40xyjKpTcmz3mm3M1oQDKXeoHEsUCdUvqmE5+aFfFTSpY4SAfvXaNg/Ov3SM0d9plHy5z4T3+0kOyaYaVpGRj16MhfwaB9kbrtUBMm0gGhkbK25Xcd/J1YfjBGYCJL5Qb7gPVV3ye1I7OdkHXlSG8LbZiOExdBLkYErhF/X84E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859291; c=relaxed/simple;
	bh=P2id+Gw2WOcfKdVpLPLdbz2/z6zU4UVmt7vCNRcdu5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X7W5jTiwpy6w/e519d8ElPcpwh0+R64T4UNPbU67Fbj8rrfmzyQUuqREkbZkgr4/Yn3JSDZWp+9FJgERMK8GbtBh6KwtuqmV2aMYR6gWnR/PFigJFsWaXWeDhexpvmMsIc0woFnhfwIwk7ZEakC4Dpy6ahR8prfMigMbCzErE18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyyoZYPF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2516DC4CECF;
	Wed,  6 Nov 2024 02:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730859290;
	bh=P2id+Gw2WOcfKdVpLPLdbz2/z6zU4UVmt7vCNRcdu5Y=;
	h=From:To:Cc:Subject:Date:From;
	b=DyyoZYPFweVzH6gYO49j2bHiLQ6miHraSUZuy85KXX5UsELMxHMEpbh2pNJZTqnsD
	 qV05dIosfL2kPNELivTElKdt5LfYq9l/Z75beFOPfIGRQyPvO3tK1OfEqoxd5Gn3o+
	 9vQAi+LimbM5qaXMO6qRKRjsVVDblb7d1D+6v2a8AihEqyAOctHuoXZCAxmAX7T5sK
	 8i3mVq4DRI+Uiaeu8ATetpIUh3I9zujyhAB7lBvOJt0JOqBIGNS5rtTA6emHT/KVaV
	 EXpPxbBrzcKrhtc819Yt2BvwSU3u2FG6VRxe+YJdVLQOzmIDEr6AqogM1xc6CWcYxP
	 Ret+wrakWr81Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Ovidiu.Bunea@amd.com
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "Revert "drm/amd/display: update DML2 policy EnhancedPrefetchScheduleAccelerationFinal DCN35"" failed to apply to v4.19-stable tree
Date: Tue,  5 Nov 2024 21:14:47 -0500
Message-ID: <20241106021447.184517-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the v4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1b6063a57754eae5705753c01e78dc268b989038 Mon Sep 17 00:00:00 2001
From: Ovidiu Bunea <Ovidiu.Bunea@amd.com>
Date: Fri, 11 Oct 2024 11:12:19 -0400
Subject: [PATCH] Revert "drm/amd/display: update DML2 policy
 EnhancedPrefetchScheduleAccelerationFinal DCN35"

This reverts
commit 9dad21f910fc ("drm/amd/display: update DML2 policy EnhancedPrefetchScheduleAccelerationFinal DCN35")

[why & how]
The offending commit exposes a hang with lid close/open behavior.
Both issues seem to be related to ODM 2:1 mode switching, so there
is another issue generic to that sequence that needs to be
investigated.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Ovidiu Bunea <Ovidiu.Bunea@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 68bf95317ebf2cfa7105251e4279e951daceefb7)
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c
index 11c904ae29586..c4c52173ef224 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c
@@ -303,6 +303,7 @@ void build_unoptimized_policy_settings(enum dml_project_id project, struct dml_m
 	if (project == dml_project_dcn35 ||
 		project == dml_project_dcn351) {
 		policy->DCCProgrammingAssumesScanDirectionUnknownFinal = false;
+		policy->EnhancedPrefetchScheduleAccelerationFinal = 0;
 		policy->AllowForPStateChangeOrStutterInVBlankFinal = dml_prefetch_support_uclk_fclk_and_stutter_if_possible; /*new*/
 		policy->UseOnlyMaxPrefetchModes = 1;
 	}
-- 
2.43.0






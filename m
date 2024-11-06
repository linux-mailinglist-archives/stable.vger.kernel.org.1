Return-Path: <stable+bounces-90001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E6F9BDC70
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 03:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9480E28253A
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 02:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4F51DFD89;
	Wed,  6 Nov 2024 02:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdlpagER"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888201DF97B;
	Wed,  6 Nov 2024 02:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859140; cv=none; b=SOcnV4U9qiw9D7CUiYhNCH6RJ0idNsBV4F5MNvvQ633F8LkXUf+LWterC3/AU6i8pVY75IUZC1cZgoQckcaedtT0lLzI5X0R2Qb1zxugq3UPKgrqbc5F4+mrhBHxGvMd5C4ytJFbNV4UqIs8HBXAUtuDwcd/++hnPOtb4iGlOzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859140; c=relaxed/simple;
	bh=6NOUjoFKAnmlgTL6auRg+aL90Zd3N/TCb0L0ebHelxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WC8e3bAburVrKyBXpGYlvzvdlXM6KQveZRm8XjIwy8E5KIfS5gXCmx4DwA2DtiVWVGGkhpqZBLFEtjAp4KJMBvly2TLOwDT/H9+b227DlryZgTK5auTpXvUkuQzn2u/PQDOji7SCl+kqG2ji0APCDXVu7FzZYrVDyZ23IcDm9+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdlpagER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213CFC4CECF;
	Wed,  6 Nov 2024 02:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730859140;
	bh=6NOUjoFKAnmlgTL6auRg+aL90Zd3N/TCb0L0ebHelxY=;
	h=From:To:Cc:Subject:Date:From;
	b=DdlpagERtTeS1sGfPQaYripjw4gHXQ0o1uIIi8lgLiQS2AvjAqEhCQB9O2AobH3EO
	 tmq4cLHuy24TzfqZdrpTe10o7hfGV/iIuUv2h5cW/WFPTSMECJN8bHMSgClXusKiDu
	 hO2Xn8vriDx4HWQUepHIowQj5kPa7xrCXiYoIVsM9UaIJhhSq0XR66r0vG+gfoEnlT
	 KiXid4xhvzY1/J6hloTWYE4xXNEzO6YDq9Utfo/N8+zG0a56iQRdO1Z+s7rzCNxd9h
	 D1rdFccEucRIPSmevBhKgmR1lVcREWQPPcU3LG1pxQcIocpS+4ICsN0l57DfpnHOMV
	 1m4IPzLlC26pQ==
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
Subject: FAILED: Patch "Revert "drm/amd/display: update DML2 policy EnhancedPrefetchScheduleAccelerationFinal DCN35"" failed to apply to v5.15-stable tree
Date: Tue,  5 Nov 2024 21:12:17 -0500
Message-ID: <20241106021217.182816-1-sashal@kernel.org>
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

The patch below does not apply to the v5.15-stable tree.
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






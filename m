Return-Path: <stable+bounces-89966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2392E9BDC0D
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 03:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 550341C22E64
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 02:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329871D4342;
	Wed,  6 Nov 2024 02:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TR/W5rJB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FC61D3656;
	Wed,  6 Nov 2024 02:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859010; cv=none; b=n1lBAeyEUXvZ9m1QujkTGrDhOSvRRBPyaZtnPgmosL/0csgYbEmgVLBsLPhk3O1ZS4+FgFOopJjGrDM38QOLQH7uT/X9w0AgL7oUgE3btgPu60/4jqCDxFqYCI5zXEIJyjmHoz7J7Aa7fyvPatf2EkTB1y1IsDpeZD7Jv9GHWbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859010; c=relaxed/simple;
	bh=JTUr1Gm+x2wnMS4e/VgV7frMfSYXZgyw4iuSRBJeMGw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t7UF2ZLpRqbVl5/wcGoJNE2GFtOe0HVGSsLQcin5zcIBdMhNCcrM45OhbHY3Er002yBnkG3aF8DaGe3mvZ5eoVTNO46iBJB+22iXaj36NHPE+S3g+XyfK3N5ICBoRsD2BxJKyTPZigL55yBZVm6ZiTC9oCf3jdkhVdOa5KDUHDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TR/W5rJB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D244C4CECF;
	Wed,  6 Nov 2024 02:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730859009;
	bh=JTUr1Gm+x2wnMS4e/VgV7frMfSYXZgyw4iuSRBJeMGw=;
	h=From:To:Cc:Subject:Date:From;
	b=TR/W5rJB6VaO5B+/Tf+Pm+Dn5WvZi843z7Sx9zc+Sf5V8vgkRGLW1uScZU7cmE8ts
	 DXvSn0t9ub6EmOZlL17jVov+lY2YZdmtWwubedlyLxyacEqYuJZUidyWmhTCBMqBCD
	 EZ58FqDKur/Ib3RmUFGhaQBrIpOkf6Xq38TCMpdyHJ8gWX2pEQLeWKcDcp9pXFSxOZ
	 Bv03jLe1HEP7o0rXCux4Qym6YfXBISun+RqFL0YPtktg+EfN2O2LzsHx/9L17UgjSy
	 YlaSHQynKbZwEfaYKsHIP33lpR+04DTvt9Hg89xx1sfpaGR4BKR/2byWS7a+ss0nyI
	 /gSZYxLtwV08w==
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
Subject: FAILED: Patch "Revert "drm/amd/display: update DML2 policy EnhancedPrefetchScheduleAccelerationFinal DCN35"" failed to apply to v6.6-stable tree
Date: Tue,  5 Nov 2024 21:10:06 -0500
Message-ID: <20241106021006.177847-1-sashal@kernel.org>
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

The patch below does not apply to the v6.6-stable tree.
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






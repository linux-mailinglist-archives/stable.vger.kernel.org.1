Return-Path: <stable+bounces-89985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 707F69BDC47
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 03:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 249891F242F2
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 02:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45C918FC79;
	Wed,  6 Nov 2024 02:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgSz+eL1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6CE1DE2A8;
	Wed,  6 Nov 2024 02:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859083; cv=none; b=Stuy4vPHIj+UnSiutm/1iB4MR8JmQWpbwInsGlOKw4x36OyJDUFi+uFasaynGOMvJsO/OhiZauUPdvVzK01aUd6jC6MZtFaN4bOdh/1pjuJP/fjdVYD9eFSt5DxoluZMSUEwMWt0ocsFgAuPtXQxhO5WZdjLOlSxICbEFeXV6Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859083; c=relaxed/simple;
	bh=3kEhtOmblVvUNtD4XPHUPCIhjUg4Z8gzRsPWYugazGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BPVeRpodlShkYCshx72ILpzjqbSL3Evjkba2Dlruio5MVtBI6tYULH0DQayU16k0p8ZMi3k6j5CoTTl4wLMpCJhdSre9phgXvOtl5BW1LA+Aro6DLT7V39cHSaCAu4XflUKimzV0vknt9pH3j4RiLKloelGQqE1q5jgXQGSGNoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgSz+eL1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DEFBC4CED1;
	Wed,  6 Nov 2024 02:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730859083;
	bh=3kEhtOmblVvUNtD4XPHUPCIhjUg4Z8gzRsPWYugazGk=;
	h=From:To:Cc:Subject:Date:From;
	b=PgSz+eL1tk3yM67wr967jKDMVj4iRMw3wvi8BWmTRpRNqpV8XlsZmiKJ27emVJQhT
	 +WHB6LFK1LctXPh+9pVhc6QweebDoVr8Gae4mBx9xTgqvw8NC56oxBPp6ZJRJxd/vp
	 b6NJGDgoqr0QjCZQ3ZS7U87U53eD01QzLMa/jga6LMtKyzP5ZjfAz3K2ZXpiPE6OvA
	 mjcUDpfDvjkVnSp8MvZAUPHZ+GWnT8Ch6ysmwmWf11ABPLnsg1voN6ngisEWULo5IT
	 T0UBoFs/KHsLslns0wyh5BL2DFRhFNEBxwKasBXx2wzasZZQYG/aclnN2jMW6XWmrf
	 wCW1uqw5MT/eg==
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
Subject: FAILED: Patch "Revert "drm/amd/display: update DML2 policy EnhancedPrefetchScheduleAccelerationFinal DCN35"" failed to apply to v6.1-stable tree
Date: Tue,  5 Nov 2024 21:11:18 -0500
Message-ID: <20241106021119.182168-1-sashal@kernel.org>
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

The patch below does not apply to the v6.1-stable tree.
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






Return-Path: <stable+bounces-64950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F856943CED
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E479F282968
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BB213BAD5;
	Thu,  1 Aug 2024 00:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbjufLQm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816AE13B5AC;
	Thu,  1 Aug 2024 00:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471686; cv=none; b=fs2UvPbXSlmbQhHZShs0V1V/pQT2v9lyHH35zVTwq14KOdAJD6Kt296XkMT8Q+LQlOG9bncHqhjWF0NVgG9KHl2YERGLfCUwmA6tVkxZvjqSZXND4c2ryJ+qRKFg7+NC0TkGKucgLKymAaZI8N6rVVhviiDTOD2KZ8V4P7syJHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471686; c=relaxed/simple;
	bh=N/bSIkhj/XYcZYs6JP3HgkmNpDC86vDoRWk/nTN1TCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BtQ0xIdb0OANTptBT5Vt2foSfNWBgxNxay6OBXEjhCevS0LEuRE0ZmBhHtHZDTNWYRZyWSsG4MuHBaex0N9ULAveEUdnJLfXbQVJTwlVs8CnOepaFMX4JIkBy8ry3PSvjZLS8CvdKXQbvd6pc9UgZ4JoC3tk1iU231O9rdwHIcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbjufLQm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB954C32786;
	Thu,  1 Aug 2024 00:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471686;
	bh=N/bSIkhj/XYcZYs6JP3HgkmNpDC86vDoRWk/nTN1TCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QbjufLQmAQvdLShBn7PpVK4VtRtzyDgRid2gBw1VFrLPF5qoCqEWfT8eFZu2P2W8M
	 3LRv8Ioi2MATEov1ZjsldSeffAfdr+0f415k4nVMi4YFfh55Loo73KH803AMOa+A2k
	 Gr0gZAnP0yOSWLXynzkU9nPoech5wKxMPgzL9TktwwoKip1fHaAZY8Yxqyx00tyTYQ
	 UgnId0JoAS2o5v32wJ84/2wXLcYBnM09JCNX0NcRQX3agreAGfPd7ege+TdKsbAJt/
	 agHIRRP0Y5fY+QXRsUpO91PIrxCcbb4Jv9wf2eNqLYdCqz7d0hna5Ea5MeGVrNUodu
	 mb9DxcSgxFgSw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jesse Zhang <jesse.zhang@amd.com>,
	Jesse Zhang <Jesse.Zhang@amd.com>,
	Tim Huang <Tim.Huang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	kenneth.feng@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	kevinyang.wang@amd.com,
	Jun.Ma2@amd.com,
	ruanjinjie@huawei.com,
	mario.limonciello@amd.com,
	bob.zhou@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 04/83] drm/amd/pm: fix warning using uninitialized value of max_vid_step
Date: Wed, 31 Jul 2024 20:17:19 -0400
Message-ID: <20240801002107.3934037-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002107.3934037-1-sashal@kernel.org>
References: <20240801002107.3934037-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
Content-Transfer-Encoding: 8bit

From: Jesse Zhang <jesse.zhang@amd.com>

[ Upstream commit 17e3bea65cdc453695b2fe4ff26d25d17f5339e9 ]

Check the return of pp_atomfwctrl_get_Voltage_table_v4
as it may fail to initialize max_vid_step
V2: change the check condition (Tim Huang)

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 6d6bc6a380b36..cdac0bc420341 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -2571,8 +2571,11 @@ static int vega10_init_smc_table(struct pp_hwmgr *hwmgr)
 		}
 	}
 
-	pp_atomfwctrl_get_voltage_table_v4(hwmgr, VOLTAGE_TYPE_VDDC,
+	result = pp_atomfwctrl_get_voltage_table_v4(hwmgr, VOLTAGE_TYPE_VDDC,
 			VOLTAGE_OBJ_SVID2,  &voltage_table);
+	PP_ASSERT_WITH_CODE(!result,
+			"Failed to get voltage table!",
+			return result);
 	pp_table->MaxVidStep = voltage_table.max_vid_step;
 
 	pp_table->GfxDpmVoltageMode =
-- 
2.43.0



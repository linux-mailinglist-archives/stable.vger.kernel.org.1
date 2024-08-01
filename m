Return-Path: <stable+bounces-65094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01348943E54
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E8E81F2270C
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1785C1A2559;
	Thu,  1 Aug 2024 00:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMdUtXJW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84931A256A;
	Thu,  1 Aug 2024 00:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472393; cv=none; b=EyhS67W3cdZhyOhBbxHjeQlC25LogTFNYg3kvYpjyErt81V7CjIajF+U3mwaLCqbnsZmTnIpiAApp6K9UC8K2/GlHePjWaWTH/eYLMwml8WlSJSQ2k7PQt36JvGw1BV/913JmHcmB/ZjQMOmhe15ykyvRgj+mYiFhNpAz/NPPMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472393; c=relaxed/simple;
	bh=nTM7HYpIjDGojVI8Bjqq5lNQj65xZvmldy11U0D1yYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JaXtnoDfvuEAN3ub6ar+AvpU+icXMMEXccDOVkQajKJqKwn9K1oFZRNc6sQuYFjZuyBqO8hXB3c0gIGfodqMvz7vxCa8zooxabsLABmU42+ZVIWVjcNMnbYlmmYpJi1SAiMU8+n0Ar3JtPg1bOqI2xUyprHK+90z4kOi46dRUDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMdUtXJW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D5FC116B1;
	Thu,  1 Aug 2024 00:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472393;
	bh=nTM7HYpIjDGojVI8Bjqq5lNQj65xZvmldy11U0D1yYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pMdUtXJWPQAnSN/7ju/azKl8QnUGDEILMw+735xC4FTZ3L5RaOi4x9FzRkVseKm2g
	 tCl4CubgGrPcpAvCAvbbQTVovRNnLPIK+QIhPNOe0japOX1OssBSOvIgxxVIoqgRQq
	 k5CBR0iQbVWGT0q+4prZWoiGyJd7LwcjaXQLB7TK3Pm9UJvrW54cNWVnrHqPMQKQU6
	 ejVy+1lglN2Rs7wBQPGWVJPc97hiYTTv4oELMkdeB8AggRSHEELsrfpXTiRMmtttjD
	 wWIrXm0SlQlFgWOeN4l93LcDrx6lPke4fqKQC+YRwkmbtEWfhklBgSUMlVdF5cVc0M
	 EhUHCbP8eMZ4w==
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
	Jun.Ma2@amd.com,
	kevinyang.wang@amd.com,
	ruanjinjie@huawei.com,
	mario.limonciello@amd.com,
	bob.zhou@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 04/47] drm/amd/pm: fix warning using uninitialized value of max_vid_step
Date: Wed, 31 Jul 2024 20:30:54 -0400
Message-ID: <20240801003256.3937416-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003256.3937416-1-sashal@kernel.org>
References: <20240801003256.3937416-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
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
index e6336654c5655..259bf8e702ce2 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -2575,8 +2575,11 @@ static int vega10_init_smc_table(struct pp_hwmgr *hwmgr)
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



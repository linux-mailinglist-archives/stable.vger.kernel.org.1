Return-Path: <stable+bounces-65033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EC0943DBA
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C3C3286B7D
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCC2148FFC;
	Thu,  1 Aug 2024 00:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O87GQpeO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A538149005;
	Thu,  1 Aug 2024 00:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472101; cv=none; b=Lpha/dliQ9yhM2TtnrMcobIP3ljC4JDBn+7t0BgUzodoJWLSvPi82Z6HCODH0NHPxpJeWgmtbpt7wZRjL6e79wAD5FDbVlXG0E9RBr16n4M2Mc8ZXmA9L6UbeNSr+FSOg0eBrhPOy5prn0SSP8ofwEhSHbds9KJTAMtK7JJKPGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472101; c=relaxed/simple;
	bh=m5sgOSAD3BvmjhEOo4qqxP7WUR7dUGmX77YFDOuB1O8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vBbhDXUQxzu0B6cXF/ozyai4X4S1SiwOEyhfSbCwGkOSDJkDZiQ+JJMlfl6y+QAbz0pnbeup+djlhFMRrn6GJNq1DK3QlaGhRfAbYQTMOz7dro0N6K7/vc645XjW29TgcmQV/cM+6YWUK27o6FRw72XiLGKfEDWU/dRyI47zhjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O87GQpeO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B752BC32786;
	Thu,  1 Aug 2024 00:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472100;
	bh=m5sgOSAD3BvmjhEOo4qqxP7WUR7dUGmX77YFDOuB1O8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O87GQpeOvoq8IFYewbu+/WxBLZAsYC3KAotmkKe9TWr2wYmbeWlNxLcSOmMzkUHE3
	 vseL4uKegyoggFYU4B+P/A6ek+amS0KOlPDkWPKd6RR90+gh6ZOz14QtDyf8gaKVX0
	 NunQdCoS/8w2CTLgIFhHs2l0l5is6LWvxwZ9Olq2IvlZ4uq+SSIBYdzkRtDMT95SR2
	 7d5f+3siLSmROWsyl16rh309JvhhASLZ9c9ydMaDqbL+V8bhRJ1IhxL73HKIaiq5Kr
	 v5mpM2ewdgR+3ZeTq7ZrSnsmJT8YPdxB08V+h1NbBfGfN2+pqD1/JWMw2e7YXEeVrI
	 ScYAVardhmbFg==
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
	bob.zhou@amd.com,
	mario.limonciello@amd.com,
	ruanjinjie@huawei.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 04/61] drm/amd/pm: fix warning using uninitialized value of max_vid_step
Date: Wed, 31 Jul 2024 20:25:22 -0400
Message-ID: <20240801002803.3935985-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002803.3935985-1-sashal@kernel.org>
References: <20240801002803.3935985-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
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
index d8cd23438b762..0d7fb8542249b 100644
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



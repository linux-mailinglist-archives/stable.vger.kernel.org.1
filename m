Return-Path: <stable+bounces-65139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FE2943F15
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49C082835EF
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5910137764;
	Thu,  1 Aug 2024 00:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIbX0M0Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DB614BF89;
	Thu,  1 Aug 2024 00:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472611; cv=none; b=PwImT+oricpprc3lyy+pvqXWwQtXHpiBDJBXkvu+PSV97y87uyUAFLi5mfg/1U/+JnUcueXauHXWVpC8xdKLcs8zhrBhjTNlYykTsPtA/P52j+jhFJfIfpHTTei3R3163BmMtmw25uCqP+JehAmf8q4+fBNyaieVxuoItqzWaiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472611; c=relaxed/simple;
	bh=NiqrHfgRjNUyUmugbUTlAatN3DcyQdZGpSanQx3Masw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bb6f5yRKkOwKL9IDeL2q63nPCBjY1O53HVePmto81KG5PAjT6s0h5NRxwoTAQF0wrGpEMI5pcAAK7QSfQAM3NFJNU+T5t2Ts/t8sAz4kaJdbKqhxIoGctGq0L4+gSOnIR4jvXglhDsRC+48pm7T8J4Dv45t4CEI8dKHmXeYpAqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIbX0M0Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB33C116B1;
	Thu,  1 Aug 2024 00:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472611;
	bh=NiqrHfgRjNUyUmugbUTlAatN3DcyQdZGpSanQx3Masw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dIbX0M0ZbALzW3XTDOtJSdHBFUWtE1LCPBLryP1pve9Tu8zy/XRxpTomnGwtmdf3/
	 oGezHrz7ZOfxxZk/isuegTQ6+31M4vCoOCOkuPJn30xOgKmZWlvRAhtszMBA5I7//v
	 fcOPKgyxQ7Vs3UPngUu0HSjmhvgnufVe+ITQ8fLd4bLfg/LbSROaxqzqYEoItDzH7I
	 iAMDMKu5GGEO29CQYI0gMMWfGUowAsSiYzsjFAWHuOKmT/58vKwBNNAsQwWnTce9eB
	 t33+kjHubjEIYqdNRILQ9yUbIdtyw6XtAE5SZVthrMTzNjgqNJDG/y6TGv2khIonHU
	 k/roi6TVfXihA==
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
Subject: [PATCH AUTOSEL 5.10 02/38] drm/amd/pm: fix warning using uninitialized value of max_vid_step
Date: Wed, 31 Jul 2024 20:35:08 -0400
Message-ID: <20240801003643.3938534-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003643.3938534-1-sashal@kernel.org>
References: <20240801003643.3938534-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
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
index 4dc27ec4d012d..04daba8a0fe8e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -2572,8 +2572,11 @@ static int vega10_init_smc_table(struct pp_hwmgr *hwmgr)
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



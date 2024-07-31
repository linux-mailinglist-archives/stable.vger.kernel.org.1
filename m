Return-Path: <stable+bounces-64830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 581D9943A73
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5CFBB24B0E
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A17914A0A7;
	Thu,  1 Aug 2024 00:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D05Mhozd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9646149DF7;
	Thu,  1 Aug 2024 00:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470939; cv=none; b=hYL4xVpsGvMrijk/ZDZxUSVbib310D7hGVyZXZYEi9Ku+6dUDqyhiAMDfnxuiquyzMn7w4uAEJsHjWI9GBXCnCCqOI057dKhgNjy2sxV0oKI7OQHgy96c010/bq/FgrM5FqGG5/z2Ss7sbswnqoB6VNLYLkuGXFuqAwZr4IL4Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470939; c=relaxed/simple;
	bh=LLlKLnv23RmWkKCwfzyxr/XoUJ6LQ2IibXn+TX9skGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f+eJB5ZywUx/HO2+J+3YsgvWMAFnbFaUQbukWCvRbQDpGyMbSq7R5RuZyIOSlRjESAexVYm9V30B7PL3f1ueq/7F/5hGmigng2wf2/llsEt0DYV3nIlbibqnFU57LC5uTuli4PfTt2tCLury/QPs1MJgaezFxrUdh2D4SVkYGSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D05Mhozd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930E3C4AF0F;
	Thu,  1 Aug 2024 00:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470939;
	bh=LLlKLnv23RmWkKCwfzyxr/XoUJ6LQ2IibXn+TX9skGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D05MhozdmbjO9Z+FCvurSBmGaywpU5HNkUMxxHzuVb9xYnppDN54yS86P+xn/q/1+
	 6jLYs6b7es6DzRcDm7qDRMnChGJODHLJKhlzjzt5JhM0d0y54xzX3ZRvRGylwuMxhe
	 smRvkA80svAGJnXOd7IpAsd+nlT23ZND2eICQQW3buEH827NDL2yTzWXKPwDcugQQ1
	 s8HrqmG1GNIhI9/I88qXxmDSVm0xnabqYesqx0CDxbyxhufvoh3+5Vrgpq8z21QfEx
	 2pPO6Q4g//1W1RQ9kh5/K+f8IhkmECxXGT0nYTfVzLPyhPrzSPXLWFbD5zmpLeXf/a
	 gwDcjDB/5yb3Q==
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
	bob.zhou@amd.com,
	mario.limonciello@amd.com,
	ruanjinjie@huawei.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 005/121] drm/amd/pm: fix warning using uninitialized value of max_vid_step
Date: Wed, 31 Jul 2024 19:59:03 -0400
Message-ID: <20240801000834.3930818-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
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
index 9f5bd998c6bff..1a79210a7572c 100644
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



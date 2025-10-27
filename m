Return-Path: <stable+bounces-190814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62587C10C3A
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 20:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBBCA5657A5
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 19:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B747F2C3256;
	Mon, 27 Oct 2025 19:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k2fvNJ4d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F22022A4DB;
	Mon, 27 Oct 2025 19:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761592266; cv=none; b=geo657aifSAzsVjuvePg196WE7C8T73R382bUrPARvAXKlBLZUe3ELtnUMaeFwL9Zbc8JJovzawoWAFHMM+/SWgDgjMYTUFsHnCb5CybqMPowCUkiO4VwUFDDIVJD6eGxF8D0BI9HyvvqH5EvPvXMxCA1yI6dXciWXgTXfbn5cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761592266; c=relaxed/simple;
	bh=SrpPZCkq/QiwSkWRp/ZGBwy1isTgL3QgpgBxAYNB/eI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eHio4tRLnmQI0tkZ7SFstF7GsQWUZwStComCld0EsQlPiu/AGFPIUCCosh9rZPtLf08B9wXQ4Wvn98KYyduSr21ux4PBZzgh/PElX0uA23KW8CQMY97G/GzNWu8RE6Um8BkwN9lPc8LFEiy1ihmnDjujhjCS/+jYwEULkU25HqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k2fvNJ4d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 006A0C4CEF1;
	Mon, 27 Oct 2025 19:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761592266;
	bh=SrpPZCkq/QiwSkWRp/ZGBwy1isTgL3QgpgBxAYNB/eI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k2fvNJ4d80YgfvxvUge5+u2qJ7lhVcsqLltj5/6S9kYJQe0GLPIyll422l5j9rwB2
	 IqmihxTOscqxWvni2uBa455HQ1O7jC50TqyynpcHimA0cwWHA+wKroPkGKM19Ehsuf
	 tNIPoPAsbTVOG4uxF5rGwIcyKGwD67ltnvPKBGcQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 057/157] drm/amd/powerplay: Fix CIK shutdown temperature
Date: Mon, 27 Oct 2025 19:35:18 +0100
Message-ID: <20251027183502.818244381@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251027183501.227243846@linuxfoundation.org>
References: <20251027183501.227243846@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Timur Kristóf <timur.kristof@gmail.com>

[ Upstream commit 6917112af2ba36c5f19075eb9f2933ffd07e55bf ]

Remove extra multiplication.

CIK GPUs such as Hawaii appear to use PP_TABLE_V0 in which case
the shutdown temperature is hardcoded in smu7_init_dpm_defaults
and is already multiplied by 1000. The value was mistakenly
multiplied another time by smu7_get_thermal_temperature_range.

Fixes: 4ba082572a42 ("drm/amd/powerplay: export the thermal ranges of VI asics (V2)")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1676
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 530888c475be1..d13ab986a5c20 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -5435,8 +5435,7 @@ static int smu7_get_thermal_temperature_range(struct pp_hwmgr *hwmgr,
 		thermal_data->max = table_info->cac_dtp_table->usSoftwareShutdownTemp *
 			PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
 	else if (hwmgr->pp_table_version == PP_TABLE_V0)
-		thermal_data->max = data->thermal_temp_setting.temperature_shutdown *
-			PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		thermal_data->max = data->thermal_temp_setting.temperature_shutdown;
 
 	thermal_data->sw_ctf_threshold = thermal_data->max;
 
-- 
2.51.0





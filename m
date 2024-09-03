Return-Path: <stable+bounces-72760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0CF9692FA
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 06:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C953728467B
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 04:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF76A1CE6EA;
	Tue,  3 Sep 2024 04:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QkSB7icF"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C0D1CDA02
	for <stable@vger.kernel.org>; Tue,  3 Sep 2024 04:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725339534; cv=none; b=Y7H8neGMdCpvNtrHM/wxC+jsn6oAekHLlRVUwKrPfZ++2mO/0m/C3NAsxXs/Cf5AcjM5or5d6Fg+SiMlF4isELrIkOOQ5zr472J6tge64/tZ1s90fQObNnspD3eI6vjcaLXoQ57MTQKWnSaXTCSJrOAhgBSCosQb4Tb2AiJSOBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725339534; c=relaxed/simple;
	bh=8o85C8EbJOznl3BLIG+cQfhkgOXbYiQlzAjPgnN+QnU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GYR1naN9IHPRVnMdxGavXBUa2wTPcyUoukEP1rSi6c140jpEHASuNYxHMN/ddqZkyXwRxGIyhG2t6dfZJf3nK9WvcwyLXbd8wpGIuyQqqJxquMoRI/E3pyKBZ/zRv/CTN5WznGf8vRmsFCmk7Zb/NcKCJTOHW+uC1X839xFZnzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QkSB7icF; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7093b53f315so1698954a34.2
        for <stable@vger.kernel.org>; Mon, 02 Sep 2024 21:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725339532; x=1725944332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sPhZdW35wA0lKARiWkZjmf+aWFeCFp2ESl8o+4bQ7rQ=;
        b=QkSB7icFuZD4j2OvZYLn0LuHd2Zs//PGbdQKPeb2vTgN82g7rCGDGzx3CVU9L4jfCi
         fVMJVSN6CjXOLxFDwzgfiZIM6mGmbITLyyc9ab9hyxuSzXB7A3ex3YNyxT7NSw8uX0zB
         D6ftEYuvHb++lGwyG4EP0RU38QXEVDUwZUj5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725339532; x=1725944332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sPhZdW35wA0lKARiWkZjmf+aWFeCFp2ESl8o+4bQ7rQ=;
        b=uOdw79oH5A4i+/4Q0jaIAEaRERzZf0zjN17MTcV60LX9dM8cAIlKtxcBSxT2Epsv5u
         fK1SPualcPyAtdEEMNU4c1NjL5kooPd0qk0Ls62MfXxD+GHYaSyRFrd1gyJpH1LKuEDx
         AnZFcNMPftbXnOkuDSvCg1UbYZX+ioS7OWXBwjRGxXCiWElq6M1NGzXMxqkHosCErCat
         7Uoz96szNyR8ioY/LfEWVe4yLBNPwmwhHOdsvlGlmmEzTCDN8DvXdoYLsU0OAsvTP3A5
         EiCl5z4lg4/cbAgiSeG6vLNoFKr3Susn6Dx4kugIPL/A/VXaeVh6qOn/FcfH1DXgjLRO
         8cRw==
X-Gm-Message-State: AOJu0YwHVxAULnh0KMpC5BFb/hjRAQxkaeqhzZNAmJBRz+ssP4lHMTol
	fo0qMZdCAkKx98YDxMyAr8d15GcJKmjipJSJuXAkthNCkmN5fariB+W8gWsvTG3YSupGAfytX/s
	wHBo+BJIuWvi4fu3zmOpVhkl4eNZv4Ku1ZWGM1z2iODgXgryZFtXJ3/Zn5uK4jSPlrAMohVp+P2
	Z95LfE6TQlNhhIyBiqAm9AmZRkSGK5PLKYYE2G2FUoRSQGJWx+aQ==
X-Google-Smtp-Source: AGHT+IG8me1bSENR4wRx/OKAQejDcXWKY5+HZ/AzEltyhw/WRh8aAe2pXkZG/Vr0P7/zTKqlGwLNxQ==
X-Received: by 2002:a05:6358:4429:b0:1aa:b9f2:a0c4 with SMTP id e5c5f4694b2df-1b8117bccf4mr268303755d.11.1725339531470;
        Mon, 02 Sep 2024 21:58:51 -0700 (PDT)
Received: from photon-a190c64c6e7e.. ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8d06c9340sm3599334a91.22.2024.09.02.21.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 21:58:51 -0700 (PDT)
From: sikkamukul <mukul.sikka@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: evan.quan@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@linux.ie,
	daniel@ffwll.ch,
	Jun.Ma2@amd.com,
	kevinyang.wang@amd.com,
	sashal@kernel.org,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Bob Zhou <bob.zhou@amd.com>,
	Tim Huang <Tim.Huang@amd.com>,
	Mukul Sikka <mukul.sikka@broadcom.com>
Subject: [PATCH v5.15-v5.10] drm/amd/pm: Fix the null pointer dereference for vega10_hwmgr
Date: Tue,  3 Sep 2024 04:58:09 +0000
Message-Id: <20240903045809.5025-1-mukul.sikka@broadcom.com>
X-Mailer: git-send-email 2.39.4
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bob Zhou <bob.zhou@amd.com>

[ Upstream commit 50151b7f1c79a09117837eb95b76c2de76841dab ]

Check return value and conduct null pointer handling to avoid null pointer dereference.

Signed-off-by: Bob Zhou <bob.zhou@amd.com>
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Mukul Sikka <mukul.sikka@broadcom.com>
---
 .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 30 ++++++++++++++++---
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 10678b519..304874cba 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -3391,13 +3391,17 @@ static int vega10_find_dpm_states_clocks_in_dpm_table(struct pp_hwmgr *hwmgr, co
 	const struct vega10_power_state *vega10_ps =
 			cast_const_phw_vega10_power_state(states->pnew_state);
 	struct vega10_single_dpm_table *sclk_table = &(data->dpm_table.gfx_table);
-	uint32_t sclk = vega10_ps->performance_levels
-			[vega10_ps->performance_level_count - 1].gfx_clock;
 	struct vega10_single_dpm_table *mclk_table = &(data->dpm_table.mem_table);
-	uint32_t mclk = vega10_ps->performance_levels
-			[vega10_ps->performance_level_count - 1].mem_clock;
+	uint32_t sclk, mclk;
 	uint32_t i;
 
+	if (vega10_ps == NULL)
+		return -EINVAL;
+	sclk = vega10_ps->performance_levels
+			[vega10_ps->performance_level_count - 1].gfx_clock;
+	mclk = vega10_ps->performance_levels
+			[vega10_ps->performance_level_count - 1].mem_clock;
+
 	for (i = 0; i < sclk_table->count; i++) {
 		if (sclk == sclk_table->dpm_levels[i].value)
 			break;
@@ -3704,6 +3708,9 @@ static int vega10_generate_dpm_level_enable_mask(
 			cast_const_phw_vega10_power_state(states->pnew_state);
 	int i;
 
+	if (vega10_ps == NULL)
+		return -EINVAL;
+
 	PP_ASSERT_WITH_CODE(!vega10_trim_dpm_states(hwmgr, vega10_ps),
 			"Attempt to Trim DPM States Failed!",
 			return -1);
@@ -4828,6 +4835,9 @@ static int vega10_check_states_equal(struct pp_hwmgr *hwmgr,
 
 	psa = cast_const_phw_vega10_power_state(pstate1);
 	psb = cast_const_phw_vega10_power_state(pstate2);
+	if (psa == NULL || psb == NULL)
+		return -EINVAL;
+
 	/* If the two states don't even have the same number of performance levels they cannot be the same state. */
 	if (psa->performance_level_count != psb->performance_level_count) {
 		*equal = false;
@@ -4953,6 +4963,8 @@ static int vega10_set_sclk_od(struct pp_hwmgr *hwmgr, uint32_t value)
 		return -EINVAL;
 
 	vega10_ps = cast_phw_vega10_power_state(&ps->hardware);
+	if (vega10_ps == NULL)
+		return -EINVAL;
 
 	vega10_ps->performance_levels
 	[vega10_ps->performance_level_count - 1].gfx_clock =
@@ -5004,6 +5016,8 @@ static int vega10_set_mclk_od(struct pp_hwmgr *hwmgr, uint32_t value)
 		return -EINVAL;
 
 	vega10_ps = cast_phw_vega10_power_state(&ps->hardware);
+	if (vega10_ps == NULL)
+		return -EINVAL;
 
 	vega10_ps->performance_levels
 	[vega10_ps->performance_level_count - 1].mem_clock =
@@ -5239,6 +5253,9 @@ static void vega10_odn_update_power_state(struct pp_hwmgr *hwmgr)
 		return;
 
 	vega10_ps = cast_phw_vega10_power_state(&ps->hardware);
+	if (vega10_ps == NULL)
+		return;
+
 	max_level = vega10_ps->performance_level_count - 1;
 
 	if (vega10_ps->performance_levels[max_level].gfx_clock !=
@@ -5261,6 +5278,9 @@ static void vega10_odn_update_power_state(struct pp_hwmgr *hwmgr)
 
 	ps = (struct pp_power_state *)((unsigned long)(hwmgr->ps) + hwmgr->ps_size * (hwmgr->num_ps - 1));
 	vega10_ps = cast_phw_vega10_power_state(&ps->hardware);
+	if (vega10_ps == NULL)
+		return;
+
 	max_level = vega10_ps->performance_level_count - 1;
 
 	if (vega10_ps->performance_levels[max_level].gfx_clock !=
@@ -5451,6 +5471,8 @@ static int vega10_get_performance_level(struct pp_hwmgr *hwmgr, const struct pp_
 		return -EINVAL;
 
 	ps = cast_const_phw_vega10_power_state(state);
+	if (ps == NULL)
+		return -EINVAL;
 
 	i = index > ps->performance_level_count - 1 ?
 			ps->performance_level_count - 1 : index;
-- 
2.39.4



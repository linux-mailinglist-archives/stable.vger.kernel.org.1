Return-Path: <stable+bounces-78855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEFE98D54D
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C73C1C21E73
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF4F1D0945;
	Wed,  2 Oct 2024 13:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LJ2uFnFR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9C61D07BD;
	Wed,  2 Oct 2024 13:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727875725; cv=none; b=QDI3UDoGsD5OYkYPb3qN8BLYABhuWP4wP+F91U+A/vZXGDcKrFaHNAv3ZX0X+ANmDoG+ggdH163t1aE/VMu6BDgzYRgmuySf94qaKrN2YJMR3hs4Ic32xH6J87Wm2K3xt1d/57R3dGf6iLpZUqibgJfm3BZ0FF1HC8bIq+V9Es4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727875725; c=relaxed/simple;
	bh=g1DvcwJtdf0CUZECgdxPcatULhs1qnTOVBA4AFHtWOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=njhvhzDebRXwiZ63jN1f3oZYsyXLy1NAfIt2bqJYskuyt6QC9sJeS92CmuVsqpz8yP/cWWgPS8Hn3cch5LK2+sTCoGnA+Gz6zosDiQcZ6BC4IDfUybRgbuUHdulSBPRqklaqnOkf3h2Xmwi/i76EBY1gGvYGf+Alf7C13fGiQcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LJ2uFnFR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB47EC4CEC5;
	Wed,  2 Oct 2024 13:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727875725;
	bh=g1DvcwJtdf0CUZECgdxPcatULhs1qnTOVBA4AFHtWOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LJ2uFnFRjm/gCQkXbn+rm6ci8eBZ4sTcDALb0jS0bnMnuoPUM18ElruBZ0xRI2iZ2
	 y3GxjKYPoqt0B2NaXQPznb61VrTs0mXJRFsFWUHS14GRkmz8Tni0dZete/rGejRUjn
	 PUs6y4p68w+NeXB5/FiTw5dUgtBMvOMTAgyZfMMs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Jerry Zuo <jerry.zuo@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 200/695] drm/amd/display: free bo used for dmub bounding box
Date: Wed,  2 Oct 2024 14:53:18 +0200
Message-ID: <20241002125830.447248003@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125822.467776898@linuxfoundation.org>
References: <20241002125822.467776898@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[ Upstream commit f59549c7e705be0087d08bc116ccc767b86d8362 ]

fix a memleak introduced by not removing the buffer object for use with
early dmub bounding box value storage

Fixes: 234e94555800 ("drm/amd/display: Enable copying of bounding box data from VBIOS DMUB")
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1e069fa5211ee..511d46d38d6af 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1740,7 +1740,7 @@ static struct dml2_soc_bb *dm_dmub_get_vbios_bounding_box(struct amdgpu_device *
 		/* Send the chunk */
 		ret = dm_dmub_send_vbios_gpint_command(adev, send_addrs[i], chunk, 30000);
 		if (ret != DMUB_STATUS_OK)
-			/* No need to free bb here since it shall be done unconditionally <elsewhere> */
+			/* No need to free bb here since it shall be done in dm_sw_fini() */
 			return NULL;
 	}
 
@@ -2489,8 +2489,17 @@ static int dm_sw_init(void *handle)
 static int dm_sw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct dal_allocation *da;
+
+	list_for_each_entry(da, &adev->dm.da_list, list) {
+		if (adev->dm.bb_from_dmub == (void *) da->cpu_ptr) {
+			amdgpu_bo_free_kernel(&da->bo, &da->gpu_addr, &da->cpu_ptr);
+			list_del(&da->list);
+			kfree(da);
+			break;
+		}
+	}
 
-	kfree(adev->dm.bb_from_dmub);
 	adev->dm.bb_from_dmub = NULL;
 
 	kfree(adev->dm.dmub_fb_info);
-- 
2.43.0





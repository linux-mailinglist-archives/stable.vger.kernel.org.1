Return-Path: <stable+bounces-19879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 321E58537AF
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 18:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 416B91C220D4
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 17:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76E45FEF0;
	Tue, 13 Feb 2024 17:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="thn6mKcX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652965F54E;
	Tue, 13 Feb 2024 17:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845297; cv=none; b=FtdniAbZUbfB3aD+OAIfICcNpEBjubkS0Fn+ctnRARKoXE1u6G1ehCYqUlJVDc5oLlQGg408B0fvNL8z7FvrTiB82CWRHbzB3Gjltae2PhVRkMW06jyK6zYbtGVkC37ocQmE2uPIJu0DWcH/BMAgNzNVkSpAkj319vtMIK/4nvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845297; c=relaxed/simple;
	bh=PR/cvgRCycQ25+9w3OoSn62kd/fPdw9Y1ELqNprNArM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fI8VwwKxUHiSSUd0GhgRxqDU1GUTmE/Iuvt7niEAf1mwFwRkCFLobOmweboFA+wynMgycLzOMonLozea0gh7e92wf5abokgREn4/KMrRszoDJ6tWq48WaMwRY8THdc1mYyvyamGs/OxSw2lcbMx52OGbvRM4f5PoRMuIHeCPyLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=thn6mKcX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFDBC43390;
	Tue, 13 Feb 2024 17:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707845297;
	bh=PR/cvgRCycQ25+9w3OoSn62kd/fPdw9Y1ELqNprNArM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=thn6mKcX3Q7iR0ttbbEWJv1RrEenxCX+n1YpYbQ89WziKAEwDNXpd4/6vKQ48aPcz
	 gj/01Rcs+Ny4BoK74GrD6/LxJ9HO70OmvwgumHlFYSFQcmPd5kukD6WNNyNQZlc6+z
	 ulhbHV3uwumQIJuRYjegBULw4kG7Pf2+S8Xnb7hI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 040/121] drm/msm/dpu: check for valid hw_pp in dpu_encoder_helper_phys_cleanup
Date: Tue, 13 Feb 2024 18:20:49 +0100
Message-ID: <20240213171854.169530170@linuxfoundation.org>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240213171852.948844634@linuxfoundation.org>
References: <20240213171852.948844634@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

[ Upstream commit 7f3d03c48b1eb6bc45ab20ca98b8b11be25f9f52 ]

The commit 8b45a26f2ba9 ("drm/msm/dpu: reserve cdm blocks for writeback
in case of YUV output") introduced a smatch warning about another
conditional block in dpu_encoder_helper_phys_cleanup() which had assumed
hw_pp will always be valid which may not necessarily be true.

Lets fix the other conditional block by making sure hw_pp is valid
before dereferencing it.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Fixes: ae4d721ce100 ("drm/msm/dpu: add an API to reset the encoder related hw blocks")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/574878/
Link: https://lore.kernel.org/r/20240117194109.21609-1-quic_abhinavk@quicinc.com
Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 7d4cf81fd31c..ca4e5eae8e06 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -2063,7 +2063,7 @@ void dpu_encoder_helper_phys_cleanup(struct dpu_encoder_phys *phys_enc)
 	}
 
 	/* reset the merge 3D HW block */
-	if (phys_enc->hw_pp->merge_3d) {
+	if (phys_enc->hw_pp && phys_enc->hw_pp->merge_3d) {
 		phys_enc->hw_pp->merge_3d->ops.setup_3d_mode(phys_enc->hw_pp->merge_3d,
 				BLEND_3D_NONE);
 		if (phys_enc->hw_ctl->ops.update_pending_flush_merge_3d)
@@ -2085,7 +2085,7 @@ void dpu_encoder_helper_phys_cleanup(struct dpu_encoder_phys *phys_enc)
 	if (phys_enc->hw_wb)
 		intf_cfg.wb = phys_enc->hw_wb->idx;
 
-	if (phys_enc->hw_pp->merge_3d)
+	if (phys_enc->hw_pp && phys_enc->hw_pp->merge_3d)
 		intf_cfg.merge_3d = phys_enc->hw_pp->merge_3d->idx;
 
 	if (ctl->ops.reset_intf_cfg)
-- 
2.43.0





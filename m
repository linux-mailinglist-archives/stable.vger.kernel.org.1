Return-Path: <stable+bounces-204796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D12A5CF3DAC
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 14:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 784A230E42FF
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 13:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B273236A8B;
	Mon,  5 Jan 2026 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xy1Rzm5+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ABE2356A4
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767619827; cv=none; b=RatYObrzdxNw8bf3Wd8bYrLgxXEOam0w3HfrM5WQKHm+4LRefHPPBpVLBlMvWAurgGxqdvo+1ww7aAaT5SmVLllr855QJXyVvLTZxPZ4tndKwr8wJG0XYM8mhqnPcWtP4wx4T7HW1Rxp8kBaMsk37hoZBqoDeFKI++YBLjmRJno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767619827; c=relaxed/simple;
	bh=Y9w6wEHkkFm/41Tlv85aOLs2CuQdt/9L7eCGCV3zXyA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AyGWiBEWqHhU6c0M6cqnLYNv5RHg07BAKp9fjZTjb6gIHPG3zOH343RYwstFRb0PZVSvYkbItsou0nai1d9MjmGDXrD8/FOibMT4Sf8sEzQgPl01UMpMVpJ5sCtw3Y5nvJE9dVhefnfBWR2PDeW4QtrqfQtTf0eyb0wbv+4jeYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xy1Rzm5+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94379C116D0;
	Mon,  5 Jan 2026 13:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767619827;
	bh=Y9w6wEHkkFm/41Tlv85aOLs2CuQdt/9L7eCGCV3zXyA=;
	h=Subject:To:Cc:From:Date:From;
	b=xy1Rzm5+9Ay6YSi2fEoR/aTDPGRaACa4O6LGsoHAEQLBm1n5vvfyvblGGEsdXA8w/
	 jjLTqLeqUaKLGeZuAbqxROLBY5ALn3jbEqq6NBr6EV8x/Qy/V9pxQ5lijqgVoIy3en
	 ZrAk+P1qJD1ZVFry8Kd5rmIae5GrFSokTDewcc6I=
Subject: FAILED: patch "[PATCH] drm/msm/dpu: Add missing NULL pointer check for pingpong" failed to apply to 6.1-stable tree
To: kniv@yandex-team.ru,dmitry.baryshkov@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 14:30:18 +0100
Message-ID: <2026010518-urethane-exemption-8edc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 88733a0b64872357e5ecd82b7488121503cb9cc6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010518-urethane-exemption-8edc@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 88733a0b64872357e5ecd82b7488121503cb9cc6 Mon Sep 17 00:00:00 2001
From: Nikolay Kuratov <kniv@yandex-team.ru>
Date: Thu, 11 Dec 2025 12:36:30 +0300
Subject: [PATCH] drm/msm/dpu: Add missing NULL pointer check for pingpong
 interface

It is checked almost always in dpu_encoder_phys_wb_setup_ctl(), but in a
single place the check is missing.
Also use convenient locals instead of phys_enc->* where available.

Cc: stable@vger.kernel.org
Fixes: d7d0e73f7de33 ("drm/msm/dpu: introduce the dpu_encoder_phys_* for writeback")
Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Patchwork: https://patchwork.freedesktop.org/patch/693860/
Link: https://lore.kernel.org/r/20251211093630.171014-1-kniv@yandex-team.ru
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
index 46f348972a97..6d28f2281c76 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
@@ -247,14 +247,12 @@ static void dpu_encoder_phys_wb_setup_ctl(struct dpu_encoder_phys *phys_enc)
 		if (hw_cdm)
 			intf_cfg.cdm = hw_cdm->idx;
 
-		if (phys_enc->hw_pp->merge_3d && phys_enc->hw_pp->merge_3d->ops.setup_3d_mode)
-			phys_enc->hw_pp->merge_3d->ops.setup_3d_mode(phys_enc->hw_pp->merge_3d,
-					mode_3d);
+		if (hw_pp && hw_pp->merge_3d && hw_pp->merge_3d->ops.setup_3d_mode)
+			hw_pp->merge_3d->ops.setup_3d_mode(hw_pp->merge_3d, mode_3d);
 
 		/* setup which pp blk will connect to this wb */
-		if (hw_pp && phys_enc->hw_wb->ops.bind_pingpong_blk)
-			phys_enc->hw_wb->ops.bind_pingpong_blk(phys_enc->hw_wb,
-					phys_enc->hw_pp->idx);
+		if (hw_pp && hw_wb->ops.bind_pingpong_blk)
+			hw_wb->ops.bind_pingpong_blk(hw_wb, hw_pp->idx);
 
 		phys_enc->hw_ctl->ops.setup_intf_cfg(phys_enc->hw_ctl, &intf_cfg);
 	} else if (phys_enc->hw_ctl && phys_enc->hw_ctl->ops.setup_intf_cfg) {



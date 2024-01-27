Return-Path: <stable+bounces-16177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF73783F18C
	for <lists+stable@lfdr.de>; Sun, 28 Jan 2024 00:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B8C02840B0
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC96C200AD;
	Sat, 27 Jan 2024 23:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xQa1bM47"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF6A1F946
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 23:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706397032; cv=none; b=q2A/iaxx9nvatFwDHDo061uBjsH+llg2OXgZ5jhzg9xYA2KTGUnwnC9ygIozu9wP4ig1hVKJ01Qp34jrQQYnTfM38+qi+7yihFYQSerjQz+xsx6/z1bXxgpLUEztpx2ew9A8R1P9NfiNfpnxkqZ9yCmxzQW5Svq+dygzSNhJswc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706397032; c=relaxed/simple;
	bh=OE71Vn0xigIpYOTb6hl9KJhWcXuS2fTsWgeaWtU6waY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uDsuQ17y9KTEQvYINsiDz86wiQ8kMPifE3UhpTRaI+84OCcDqxpZtf1JG2titH7INsVMF7aKPNrmXbs+46P2HIXS9M1NogDrekwINIKheqVoeX9Je5oUBC/dmW5NuGrI0P1oBfMU87adauSEsXZqnULchg1RpKWMZg9S0pickYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xQa1bM47; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B71C433F1;
	Sat, 27 Jan 2024 23:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706397032;
	bh=OE71Vn0xigIpYOTb6hl9KJhWcXuS2fTsWgeaWtU6waY=;
	h=Subject:To:Cc:From:Date:From;
	b=xQa1bM47CT0cfW0BvMmBhlMBBgbv3Wj5zHbOUk/XPsIk9UpD90vXlDiaaaNS8xn9H
	 u0qTe3FBPyJv1JZr2RBjTr1viBggvMcXbS/lvArJqSyuBS8HuiHZhmTsNieXz1nj24
	 Y3fzKbjXWLDtRqgdh5zM65F3ruOROa8r4OBC1fBw=
Subject: FAILED: patch "[PATCH] drm/amd/display: Use DRAM speed from validation for dummy" failed to apply to 6.6-stable tree
To: alvin.lee2@amd.com,alexander.deucher@amd.com,hamza.mahfooz@amd.com,samson.tam@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 15:10:31 -0800
Message-ID: <2024012731-patriot-numbness-9887@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 40436ce7ccfec5c616e2e48d0ec2c905637c7397
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012731-patriot-numbness-9887@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

40436ce7ccfe ("drm/amd/display: Use DRAM speed from validation for dummy p-state")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 40436ce7ccfec5c616e2e48d0ec2c905637c7397 Mon Sep 17 00:00:00 2001
From: Alvin Lee <alvin.lee2@amd.com>
Date: Tue, 7 Nov 2023 17:01:49 -0500
Subject: [PATCH] drm/amd/display: Use DRAM speed from validation for dummy
 p-state

[Description]
When choosing which dummy p-state latency to use, we
need to use the DRAM speed from validation. The DRAMSpeed
DML variable can change because we use different input
params to DML when populating watermarks set B.

Cc: stable@vger.kernel.org # 6.1+
Reviewed-by: Samson Tam <samson.tam@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index e7f13e28caa3..92e2ddc9ab7e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -2231,6 +2231,7 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 	int i, pipe_idx, vlevel_temp = 0;
 	double dcfclk = dcn3_2_soc.clock_limits[0].dcfclk_mhz;
 	double dcfclk_from_validation = context->bw_ctx.dml.vba.DCFCLKState[vlevel][context->bw_ctx.dml.vba.maxMpcComb];
+	double dram_speed_from_validation = context->bw_ctx.dml.vba.DRAMSpeed;
 	double dcfclk_from_fw_based_mclk_switching = dcfclk_from_validation;
 	bool pstate_en = context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] !=
 			dm_dram_clock_change_unsupported;
@@ -2418,7 +2419,7 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 	}
 
 	if (dc->clk_mgr->bw_params->wm_table.nv_entries[WM_C].valid) {
-		min_dram_speed_mts = context->bw_ctx.dml.vba.DRAMSpeed;
+		min_dram_speed_mts = dram_speed_from_validation;
 		min_dram_speed_mts_margin = 160;
 
 		context->bw_ctx.dml.soc.dram_clock_change_latency_us =



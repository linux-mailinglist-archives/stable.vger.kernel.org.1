Return-Path: <stable+bounces-196745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B32F1C80DF2
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 14:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 102AB34245B
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 13:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2719E30BB82;
	Mon, 24 Nov 2025 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XA/t2tvJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D933E30B533
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 13:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763992596; cv=none; b=UME9fAdTSibNiDbsO75x+WURX8yUNes+iNazvIzXmqQWScl7zRwUg3elFf0EKZC13cVDw9ZPBIBtyQjcKxRpxd6ziU+BOo5j/vwc1m33nk/VE27vrV6uxykGyWXHIAH3QuKfbeGYlH1knaB8jc4KS0uP0laP1GgzoGn6vYvQrd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763992596; c=relaxed/simple;
	bh=6abxCqMV3RTijRa4odLtSXZrub2R2YsRgbUQFHRyzH4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lcmIBhsS0HWCPdAxCrPaSgve0MyakRzH6jbBKT69NxCwmZwL5xETjxS/eExtrDDrE0lOu9Ar6pLhyUFFumKwXct5wc2+3+hgjrwFDlF2V+XIf1IvJetzj6mtjHwE60/iJ2k09NPmH24g/nLAGvnorYOpCAsVo59TAUVLkD376IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XA/t2tvJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243E5C4CEF1;
	Mon, 24 Nov 2025 13:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763992596;
	bh=6abxCqMV3RTijRa4odLtSXZrub2R2YsRgbUQFHRyzH4=;
	h=Subject:To:Cc:From:Date:From;
	b=XA/t2tvJxBSTW520KduZX3OxShmEvAh6Jg2cl019koyYWUyrjnKmWomMOfGpCXB75
	 x3rU7qoCDDlTPTtc2hmu4HKf4dr46ZjZq6OfubkloQOWR2j/1qxhdimI+gET2WugXO
	 /jWsH2JMwvCjEIg5O0VPHjT2UGoLVvWX3Fd5w30I=
Subject: FAILED: patch "[PATCH] drm/amd/display: Prevent Gating DTBCLK before It Is Properly" failed to apply to 6.12-stable tree
To: Jerry.Zuo@amd.com,alexander.deucher@amd.com,aurabindo.pillai@amd.com,charlene.liu@amd.com,daniel.wheeler@amd.com,roman.li@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Nov 2025 14:56:25 +0100
Message-ID: <2025112425-aspirin-conduit-e44b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x cfa0904a35fd0231f4d05da0190f0a22ed881cce
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112425-aspirin-conduit-e44b@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cfa0904a35fd0231f4d05da0190f0a22ed881cce Mon Sep 17 00:00:00 2001
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
Date: Thu, 18 Sep 2025 16:25:45 -0400
Subject: [PATCH] drm/amd/display: Prevent Gating DTBCLK before It Is Properly
 Latched

[why]
1. With allow_0_dtb_clk enabled, the time required to latch DTBCLK to 600 MHz
depends on the SMU. If DTBCLK is not latched to 600 MHz before set_mode completes,
gating DTBCLK causes the DP2 sink to lose its clock source.

2. The existing DTBCLK gating sequence ungates DTBCLK based on both pix_clk and ref_dtbclk,
but gates DTBCLK when either pix_clk or ref_dtbclk is zero.
pix_clk can be zero outside the set_mode sequence before DTBCLK is properly latched,
which can lead to DTBCLK being gated by mistake.

[how]
Consider both pixel_clk and ref_dtbclk when determining when it is safe to gate DTBCLK;
this is more accurate.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4701
Fixes: 5949e7c4890c ("drm/amd/display: Enable Dynamic DTBCLK Switch")
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit d04eb0c402780ca037b62a6aecf23b863545ebca)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index b11383fba35f..1eb04772f5da 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -394,6 +394,8 @@ void dcn35_update_clocks(struct clk_mgr *clk_mgr_base,
 	display_count = dcn35_get_active_display_cnt_wa(dc, context, &all_active_disps);
 	if (new_clocks->dtbclk_en && !new_clocks->ref_dtbclk_khz)
 		new_clocks->ref_dtbclk_khz = 600000;
+	else if (!new_clocks->dtbclk_en && new_clocks->ref_dtbclk_khz > 590000)
+		new_clocks->ref_dtbclk_khz = 0;
 
 	/*
 	 * if it is safe to lower, but we are already in the lower state, we don't have to do anything
@@ -435,7 +437,7 @@ void dcn35_update_clocks(struct clk_mgr *clk_mgr_base,
 
 			actual_dtbclk = REG_READ(CLK1_CLK4_CURRENT_CNT);
 
-			if (actual_dtbclk) {
+			if (actual_dtbclk > 590000) {
 				clk_mgr_base->clks.ref_dtbclk_khz = new_clocks->ref_dtbclk_khz;
 				clk_mgr_base->clks.dtbclk_en = new_clocks->dtbclk_en;
 			}
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
index de6d62401362..c899c09ea31b 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
@@ -1411,7 +1411,7 @@ static void dccg35_set_dtbclk_dto(
 				__func__, params->otg_inst, params->pixclk_khz,
 				params->ref_dtbclk_khz, req_dtbclk_khz, phase, modulo);
 
-	} else {
+	} else if (!params->ref_dtbclk_khz && !req_dtbclk_khz) {
 		switch (params->otg_inst) {
 		case 0:
 			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, DTBCLK_P0_GATE_DISABLE, 0);



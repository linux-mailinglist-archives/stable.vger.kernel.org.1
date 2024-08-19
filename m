Return-Path: <stable+bounces-69550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6355956826
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 12:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 143871C214E1
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 10:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B036A160877;
	Mon, 19 Aug 2024 10:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d1wRxTEf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED4F1607BD
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 10:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724062811; cv=none; b=KVTFVHYKaQSzEd3KvFpElmx6wwa+YAbtD46nvBh5T2y2Mmq2CDvZ0oRq2ggunfvLrS/PpHTd60PXgzXjoXvYdhla/mlYNsWmZPR+tctaKgaewnpv95E/0cAxEREdrdSDa3OOsil8SBGb6+oy8veX35zYTHu2bjQtCiFNh2pFyc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724062811; c=relaxed/simple;
	bh=KCLnWTw/8YjUSZasDhM84LfISnf9+1GrqVtGPz5/JAg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rMYQbIuG2cSZXMsAl0lwFMOYEZusbZ6gUWlUIaM8Hcn1LLSaJIuRnKnLBcisf0E3rAO7NsdSmgvUC7vizlpaHoop5zt57twP8Dd4sGwEGlWml08BENpnuvgZcCv+aD7dSVNxcLgWHUaTBmJYiflUpbYox9jp74xW069l8/VpNY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d1wRxTEf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D82EC4AF09;
	Mon, 19 Aug 2024 10:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724062810;
	bh=KCLnWTw/8YjUSZasDhM84LfISnf9+1GrqVtGPz5/JAg=;
	h=Subject:To:Cc:From:Date:From;
	b=d1wRxTEf4xoZiI8taSfmzGu+omk7NZigmN02ap3u/bUhIAM2Ge4a3aj/WE/aTikwV
	 zU1IvGrREeF8kRPryJuCEOUF0pWN/9oPuf0yQ5Aq995p7s3hRN3A9X0WoI1H4kTyww
	 0X0uhyc2LRX5yQHCX3lvTZG7loTQym6Ci1T3VMbw=
Subject: FAILED: patch "[PATCH] drm/amd/display: Enable otg synchronization logic for DCN321" failed to apply to 6.6-stable tree
To: lo-an.chen@amd.com,alexander.deucher@amd.com,alvin.lee2@amd.com,chiahsuan.chung@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Aug 2024 12:20:08 +0200
Message-ID: <2024081907-uptight-blah-bb36@gregkh>
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
git cherry-pick -x 0dbb81d44108a2a1004e5b485ef3fca5bc078424
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081907-uptight-blah-bb36@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

0dbb81d44108 ("drm/amd/display: Enable otg synchronization logic for DCN321")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0dbb81d44108a2a1004e5b485ef3fca5bc078424 Mon Sep 17 00:00:00 2001
From: Loan Chen <lo-an.chen@amd.com>
Date: Fri, 2 Aug 2024 13:57:40 +0800
Subject: [PATCH] drm/amd/display: Enable otg synchronization logic for DCN321

[Why]
Tiled display cannot synchronize properly after S3.
The fix for commit 5f0c74915815 ("drm/amd/display: Fix for otg
synchronization logic") is not enable in DCN321, which causes
the otg is excluded from synchronization.

[How]
Enable otg synchronization logic in dcn321.

Fixes: 5f0c74915815 ("drm/amd/display: Fix for otg synchronization logic")
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Loan Chen <lo-an.chen@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit d6ed53712f583423db61fbb802606759e023bf7b)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index 9a3cc0514a36..8e0588b1cf30 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -1778,6 +1778,9 @@ static bool dcn321_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
 
+	/* Use pipe context based otg sync logic */
+	dc->config.use_pipe_ctx_sync_logic = true;
+
 	dc->config.dc_mode_clk_limit_support = true;
 	dc->config.enable_windowed_mpo_odm = true;
 	/* read VBIOS LTTPR caps */



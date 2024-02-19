Return-Path: <stable+bounces-20602-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37ECD85A8B8
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 17:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53DB51C23784
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 16:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B4E3CF56;
	Mon, 19 Feb 2024 16:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nEiA+QyU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BF441C85
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 16:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359586; cv=none; b=hhnxRvKjc4ighoVFQ3BkevM2gOUbhQ0tmz9JF7OUVonNyEA/l2JSgk5yX8h+i1QiTObVfrWm0ycsy62pmhY6CzO24GGnSyeD2P2T34DZFeSEy8YzlsC+5ntQ8sfWZvsF3tUVSGLyEFfiiqMlEdCLPVnIdxutOwqReN5wqTQVdLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359586; c=relaxed/simple;
	bh=1dycVF/uJZAMMkIv3d/eS8YWB48UmzaQMa3zDFG5zOY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=L6QeTAppmRW9N21R6fU4FkZvvrDVM+zG9CD44aJXVGfbqmLuf6G1+XvQtbI4JNNzElDtWugPUTYh70EaBAHGwbd/7/gkz2Jvbchv4A6aIKB18o/pAWdmLo38Ikexz3avtyuTURSZINXUt4TyZ70/PX64QXhySZEb8To0ufTn0lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nEiA+QyU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD64DC43394;
	Mon, 19 Feb 2024 16:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708359586;
	bh=1dycVF/uJZAMMkIv3d/eS8YWB48UmzaQMa3zDFG5zOY=;
	h=Subject:To:Cc:From:Date:From;
	b=nEiA+QyUp8zzaVr4ZQoAd1kDG71N8+bCxQ637TXr9IuuQjLRKKe6vsfEyx8OX1iR7
	 zBAFzobun8RPH30nBTv3+iWgR4Fx3ajoBgRYWzOvMCobJrV51LsFv7D8H9pDgd9OFk
	 IZ6Zvo+P0Nuyxd3XF5lTJRe3BC48xEtWgsFX2yTU=
Subject: FAILED: patch "[PATCH] Revert "drm/amd/display: increased min_dcfclk_mhz and" failed to apply to 6.7-stable tree
To: sohaib.nadeem@amd.com,alexander.deucher@amd.com,alvin.lee2@amd.com,aurabindo.pillai@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 17:19:43 +0100
Message-ID: <2024021942-sherry-overstock-5857@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.7-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.7.y
git checkout FETCH_HEAD
git cherry-pick -x a538dabf772c169641e151834e161e241802ab33
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021942-sherry-overstock-5857@gregkh' --subject-prefix 'PATCH 6.7.y' HEAD^..

Possible dependencies:

a538dabf772c ("Revert "drm/amd/display: increased min_dcfclk_mhz and min_fclk_mhz"")
2ff33c759a42 ("drm/amd/display: increased min_dcfclk_mhz and min_fclk_mhz")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a538dabf772c169641e151834e161e241802ab33 Mon Sep 17 00:00:00 2001
From: Sohaib Nadeem <sohaib.nadeem@amd.com>
Date: Mon, 29 Jan 2024 17:33:40 -0500
Subject: [PATCH] Revert "drm/amd/display: increased min_dcfclk_mhz and
 min_fclk_mhz"

[why]:
This reverts commit 2ff33c759a4247c84ec0b7815f1f223e155ba82a.

The commit caused corruption when running some applications in fullscreen

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Sohaib Nadeem <sohaib.nadeem@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index ba76dd4a2ce2..a0a65e099104 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -2760,7 +2760,7 @@ static int build_synthetic_soc_states(bool disable_dc_mode_overwrite, struct clk
 	struct _vcs_dpi_voltage_scaling_st entry = {0};
 	struct clk_limit_table_entry max_clk_data = {0};
 
-	unsigned int min_dcfclk_mhz = 399, min_fclk_mhz = 599;
+	unsigned int min_dcfclk_mhz = 199, min_fclk_mhz = 299;
 
 	static const unsigned int num_dcfclk_stas = 5;
 	unsigned int dcfclk_sta_targets[DC__VOLTAGE_STATES] = {199, 615, 906, 1324, 1564};



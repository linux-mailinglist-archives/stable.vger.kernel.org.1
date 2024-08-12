Return-Path: <stable+bounces-66663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 895D394F09E
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A178281079
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA92153BF6;
	Mon, 12 Aug 2024 14:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qXb1Sj66"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6F85336D
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474324; cv=none; b=kfGuZ/xZ+qhj0zjskiqSrIEmfEB03PLTcN2YlUumGDgnKO7url8Y418UNK9iXNPAoylh49TPi87iz3QYJQU8Q7waR70JrJ/sS8FNE+ijvs1PDIV0sVQml6bNDQQPkeO7trZuVOUR70iy9PDpjYpieiqPklifQBrJ3r8gJAWpXts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474324; c=relaxed/simple;
	bh=jyXpOJ6+w7WdzLvrqYrnr+zSoC0/CVhCgzWmzfojhDo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IQUgPNjwDodO9lNAbFujVPuMCVoHAQ9GbBAwbthDXKfD9qCoHHA0V6XNNA8q71w2hjTw/Jd307+4EJV/RGyzeRdhD84ZOqtoJ9mXa+3W8AaDP+GixOqHcYU+7MroE7vWHBtFFyAFaAJZOCCt50jivzQm0LNol8Xbnm8pSQ9+NnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qXb1Sj66; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC9FC32782;
	Mon, 12 Aug 2024 14:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474324;
	bh=jyXpOJ6+w7WdzLvrqYrnr+zSoC0/CVhCgzWmzfojhDo=;
	h=Subject:To:Cc:From:Date:From;
	b=qXb1Sj66eUY+E/KG1qH+dCRjFrWnd39pKiaVErtFE0OPSMxAHzrBHDm6bbdbzrCBf
	 X2yHo+3IqH1Fkg1JvhSFxspMYKh5R32DM4c8KoOPa00gngPPGYz+Sz9seoli+U5CpA
	 odDcxO3zv1bhSWk1/zcBYo4waA+3Vt9xGsJZa/HI=
Subject: FAILED: patch "[PATCH] drm/amd/display: Always enable HPO for DCN4 dGPU" failed to apply to 6.1-stable tree
To: hanghong.ma@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com,wenjing.liu@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:49:50 +0200
Message-ID: <2024081250-array-undermine-d32e@gregkh>
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
git cherry-pick -x a4758aa3d1d9ff1c7a05da58387d217c2cd0c38b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081250-array-undermine-d32e@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

a4758aa3d1d9 ("drm/amd/display: Always enable HPO for DCN4 dGPU")
70839da63605 ("drm/amd/display: Add new DCN401 sources")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a4758aa3d1d9ff1c7a05da58387d217c2cd0c38b Mon Sep 17 00:00:00 2001
From: "Leo (Hanghong) Ma" <hanghong.ma@amd.com>
Date: Tue, 11 Jun 2024 14:12:43 -0400
Subject: [PATCH] drm/amd/display: Always enable HPO for DCN4 dGPU

[WHY && HOW]
Some DP EDID CTS tests fail due to HPO disable, and we should keep it
enable on DCN4 dGPU.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Leo (Hanghong) Ma <hanghong.ma@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 42753f56d31d..79a911e1a09a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -408,6 +408,8 @@ void dcn401_init_hw(struct dc *dc)
 		REG_UPDATE(DCFCLK_CNTL, DCFCLK_GATE_DIS, 0);
 	}
 
+	dcn401_setup_hpo_hw_control(hws, true);
+
 	if (!dcb->funcs->is_accelerated_mode(dcb) && dc->res_pool->hubbub->funcs->init_watermarks)
 		dc->res_pool->hubbub->funcs->init_watermarks(dc->res_pool->hubbub);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
index 1cf0608e1980..8159fd838dc3 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
@@ -137,7 +137,6 @@ static const struct hwseq_private_funcs dcn401_private_funcs = {
 	.program_mall_pipe_config = dcn32_program_mall_pipe_config,
 	.update_force_pstate = dcn32_update_force_pstate,
 	.update_mall_sel = dcn32_update_mall_sel,
-	.setup_hpo_hw_control = dcn401_setup_hpo_hw_control,
 	.calculate_dccg_k1_k2_values = NULL,
 	.apply_single_controller_ctx_to_hw = dce110_apply_single_controller_ctx_to_hw,
 	.reset_back_end_for_pipe = dcn20_reset_back_end_for_pipe,



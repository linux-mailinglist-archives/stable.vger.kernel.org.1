Return-Path: <stable+bounces-66666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F9994F0A1
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5BD11C20C85
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2161C153BF6;
	Mon, 12 Aug 2024 14:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cwmsjV+b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AA74B5AE
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474334; cv=none; b=R+KixqNjCew2aT61KZTJelyzXILKE3LuuZIoXGD7uL5N3EtE1hbxkNrmYDUDCj6cm7RnNo/JixOhrL6einafIsiuVTqwbP4MTgDHAJlRMpfLutetdF6q1MrA0V/j6rD9853ido/8150C/El4icMuW5T17J+yMapRjdVB7PikuOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474334; c=relaxed/simple;
	bh=zYcwprNojK2Kq0LMENnPWm8ZObNHkP0H6/b26iEeO4Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eS+XLF7/wJSMBH+o2k9z8lEDMOb6Rf8My0W28MZJOgjft6HaGUyDlaKL5GVTUuqpi/Djlq/GVSYQkfWAAOKtsmh0sNs1qSFE92tLpf4p9B6p9ZnoceCOBhqLMTtOWl9P1lIusma6LV0/AqE54Pt/G9R/QzWMJUIWAhgLRaqAhKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cwmsjV+b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E51C32782;
	Mon, 12 Aug 2024 14:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474334;
	bh=zYcwprNojK2Kq0LMENnPWm8ZObNHkP0H6/b26iEeO4Q=;
	h=Subject:To:Cc:From:Date:From;
	b=cwmsjV+b51UnXIwgwoqZTqMEbH9GHs2jboPh1Anlua9vcWqzkZZtPI4Zaw51GIHTH
	 DMwShIKkcH6T2dyJVqiYnGiBnUKXthJmjuTglPEwsHvDeFx1Tx8Ie7fKJcPPkhwXWK
	 2Otl9C83FIRGOGQaBgk1HhqaTE90PXwM7pB+t0nw=
Subject: FAILED: patch "[PATCH] drm/amd/display: Always enable HPO for DCN4 dGPU" failed to apply to 5.10-stable tree
To: hanghong.ma@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com,wenjing.liu@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:49:52 +0200
Message-ID: <2024081251-washcloth-turtle-111f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x a4758aa3d1d9ff1c7a05da58387d217c2cd0c38b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081251-washcloth-turtle-111f@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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



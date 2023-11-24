Return-Path: <stable+bounces-254-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2E97F7606
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 15:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6468281695
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 14:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C171B28E25;
	Fri, 24 Nov 2023 14:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mLcSqLCI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6388E2C85B
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 14:13:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A22DC433CC;
	Fri, 24 Nov 2023 14:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700835213;
	bh=7X5gEQPQGWTxXd2Gwxi9Ax2I6xSASDQPHBk7gTt7RmE=;
	h=Subject:To:Cc:From:Date:From;
	b=mLcSqLCIAklvaAPNqcqBUurAACtt3vcuCdtnktbWuiNRDDpeDYw+wzTbZzs7TOte8
	 d6Ad1JZS0ieULdhTMIWqbnOIgXokN+4QuzwjH9bQ450Vz45BInM+4THlmES9we3lQ7
	 LhVcMTti2D/MoSFHmF1+JP5yL3raiNrtgcSnIGoc=
Subject: FAILED: patch "[PATCH] drm/amd/display: register edp_backlight_control() for DCN301" failed to apply to 6.6-stable tree
To: hamza.mahfooz@amd.com,alexander.deucher@amd.com,harry.wentland@amd.com,swapnil.patel@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 14:13:31 +0000
Message-ID: <2023112431-scolding-varsity-1012@gregkh>
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
git cherry-pick -x ac0ec1c7d1f0d017d0ea44954026d2f138c581e4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112431-scolding-varsity-1012@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

ac0ec1c7d1f0 ("drm/amd/display: register edp_backlight_control() for DCN301")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ac0ec1c7d1f0d017d0ea44954026d2f138c581e4 Mon Sep 17 00:00:00 2001
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
Date: Tue, 22 Aug 2023 12:31:09 -0400
Subject: [PATCH] drm/amd/display: register edp_backlight_control() for DCN301

As made mention of in commit 099303e9a9bd ("drm/amd/display: eDP
intermittent black screen during PnP"), we need to turn off the
display's backlight before powering off an eDP display. Not doing so
will result in undefined behaviour according to the eDP spec. So, set
DCN301's edp_backlight_control() function pointer to
dce110_edp_backlight_control().

Cc: stable@vger.kernel.org
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2765
Fixes: 9c75891feef0 ("drm/amd/display: rework recent update PHY state commit")
Suggested-by: Swapnil Patel <swapnil.patel@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
index 257df8660b4c..61205cdbe2d5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
@@ -75,6 +75,7 @@ static const struct hw_sequencer_funcs dcn301_funcs = {
 	.get_hw_state = dcn10_get_hw_state,
 	.clear_status_bits = dcn10_clear_status_bits,
 	.wait_for_mpcc_disconnect = dcn10_wait_for_mpcc_disconnect,
+	.edp_backlight_control = dce110_edp_backlight_control,
 	.edp_power_control = dce110_edp_power_control,
 	.edp_wait_for_hpd_ready = dce110_edp_wait_for_hpd_ready,
 	.set_cursor_position = dcn10_set_cursor_position,



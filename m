Return-Path: <stable+bounces-16148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B1D83F0FD
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6B5B1C2329D
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 22:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AE71E86A;
	Sat, 27 Jan 2024 22:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TYbtZrQO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EB61E52B
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 22:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706395253; cv=none; b=AVTXjToxr7Hc8brnMSPzBeOxcSlPXM8ELyEEaRMy4/a8f/3Q3TKnWUe4HA8KnP05/SqYDb5ApixYqGJsQn176pjVgPFANdxhLrbEJ5VjjE7aWQjmcG3tr2Ga35UVq1RskY098j+dLlCbLq3iuNpMuYUlBDDWd1vgkgZBg0Do04I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706395253; c=relaxed/simple;
	bh=WXqz9pN8Om+Lj6rwjWQjjDMP2j+7JTvdD3A9QKrTwsg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Syra406RE1acq5ruD4Xpal86qB70pQMf8Phrsmur2tA/gvFzcffUvg30e9ZqtyI/8pcEm+jt/U8GJBO8N11DLgKmgU+d6GZNN/AmUCLiF1riNeYkGEGvk56hcjJuBGvziYpP3M1mTUn5dPxxFMhs4ZuQUCyxbYFj5pT5j6qQACk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TYbtZrQO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA3BC433C7;
	Sat, 27 Jan 2024 22:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706395252;
	bh=WXqz9pN8Om+Lj6rwjWQjjDMP2j+7JTvdD3A9QKrTwsg=;
	h=Subject:To:Cc:From:Date:From;
	b=TYbtZrQOPsRsx2spjoa+uzUaJ/qnGMcqnK4NXfWtMsY2tc/XG6polaTtik9VihPQD
	 A/m1nqWF2ZcCUgDOA0AyPbSPYQbbiYmX9vlUrLEqeAT+szd+NIe09uIS+kRmw+dAtS
	 EPqqsdkxXahn3RTZySXQ//xYeW1DlSJBiq3VImoI=
Subject: FAILED: patch "[PATCH] drm/amd/display: Update min Z8 residency time to 2100 for" failed to apply to 6.1-stable tree
To: nicholas.kazlauskas@amd.com,alexander.deucher@amd.com,hamza.mahfooz@amd.com,syed.hassan@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 14:40:52 -0800
Message-ID: <2024012751-payment-luckless-5da3@gregkh>
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
git cherry-pick -x d642b0100bf8c95e88e8396b7191b35807dabb4c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012751-payment-luckless-5da3@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

d642b0100bf8 ("drm/amd/display: Update min Z8 residency time to 2100 for DCN314")
8b8eed05a1c6 ("drm/amd/display: Refactor resource into component directory")
e53524cdcc02 ("drm/amd/display: Refactor HWSS into component folder")
6e2c4941ce0c ("drm/amd/display: Move dml code under CONFIG_DRM_AMD_DC_FP guard")
45e7649fd191 ("drm/amd/display: Add DCN35 CORE")
1cb87e048975 ("drm/amd/display: Add DCN35 blocks to Makefile")
0fa45b6aeae4 ("drm/amd/display: Add DCN35 Resource")
ec129fa356be ("drm/amd/display: Add DCN35 init")
6f8b7565cca4 ("drm/amd/display: Add DCN35 HWSEQ")
927e784c180c ("drm/amd/display: Add symclk enable/disable during stream enable/disable")
927e784c180c ("drm/amd/display: Add symclk enable/disable during stream enable/disable")
927e784c180c ("drm/amd/display: Add symclk enable/disable during stream enable/disable")
927e784c180c ("drm/amd/display: Add symclk enable/disable during stream enable/disable")
927e784c180c ("drm/amd/display: Add symclk enable/disable during stream enable/disable")
927e784c180c ("drm/amd/display: Add symclk enable/disable during stream enable/disable")
927e784c180c ("drm/amd/display: Add symclk enable/disable during stream enable/disable")
927e784c180c ("drm/amd/display: Add symclk enable/disable during stream enable/disable")
927e784c180c ("drm/amd/display: Add symclk enable/disable during stream enable/disable")
927e784c180c ("drm/amd/display: Add symclk enable/disable during stream enable/disable")
927e784c180c ("drm/amd/display: Add symclk enable/disable during stream enable/disable")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d642b0100bf8c95e88e8396b7191b35807dabb4c Mon Sep 17 00:00:00 2001
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Date: Wed, 8 Nov 2023 10:59:00 -0500
Subject: [PATCH] drm/amd/display: Update min Z8 residency time to 2100 for
 DCN314

[Why]
Some panels with residency period of 2054 exhibit flickering with
Z8 at the end of the frame.

[How]
As a workaround, increase the limit to block these panels.

Cc: stable@vger.kernel.org # 6.1+
Reviewed-by: Syed Hassan <syed.hassan@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
index 677361d74a4e..c97391edb5ff 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
@@ -871,7 +871,7 @@ static const struct dc_plane_cap plane_cap = {
 static const struct dc_debug_options debug_defaults_drv = {
 	.disable_z10 = false,
 	.enable_z9_disable_interface = true,
-	.minimum_z8_residency_time = 2000,
+	.minimum_z8_residency_time = 2100,
 	.psr_skip_crtc_disable = true,
 	.replay_skip_crtc_disabled = true,
 	.disable_dmcu = true,



Return-Path: <stable+bounces-69551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE3495682A
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 12:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09EAE2833C9
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 10:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3D115FD04;
	Mon, 19 Aug 2024 10:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y+HXooCd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF608165EF2
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 10:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724062815; cv=none; b=jJ8vS8CSLs/aIpBWi1iklSrHjNnk1JIdl47nDsrV1JGYAqaGfKkJLrwjZrhkkiMi2U1jrEJbdi71jg610ncLc8mkyfhwdioH1WZZxtYSLvYmvKXX9GRiRDXj/4S3l9Jm6Bqun8k0eIgugABbgNaf6LkQ2mavqSAd4Gqf07y7CKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724062815; c=relaxed/simple;
	bh=4PBBoplkL7aMhjnspVm0QNvcTISUWRwXjj498Oc21+s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fpjIcUgVaWuTR9LMEr9gYJ8g7A/qSytK0ZIDOlTYL3LsWOnki3/DJz50FIvngVSBMxHsvSe57mSWD/SE0Y/c2AfGPn6R2bHnAPosuxYw5cPDJHsGIRvOryrdzPFqQo6KKlk2xeklxh2mlZtB5jJR71bqfQ35mJ/2rsyWH/jzUxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y+HXooCd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE0D8C4AF16;
	Mon, 19 Aug 2024 10:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724062814;
	bh=4PBBoplkL7aMhjnspVm0QNvcTISUWRwXjj498Oc21+s=;
	h=Subject:To:Cc:From:Date:From;
	b=y+HXooCdzuqXYyqk/pYSWuhOfXfQtf2j0v2KanNPeLguBbsxllEM31krPP70u4l4V
	 OkPkHPEPHbiRePINdzY+AShRLlvxYTupxLMPYblKCflA3AIymW/zRUX3zZIqEY5+d6
	 IuIFo+IpI15DsBgMHlTOVyZbA6ZCkJszCioa0T3Q=
Subject: FAILED: patch "[PATCH] drm/amd/display: Enable otg synchronization logic for DCN321" failed to apply to 6.1-stable tree
To: lo-an.chen@amd.com,alexander.deucher@amd.com,alvin.lee2@amd.com,chiahsuan.chung@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Aug 2024 12:20:11 +0200
Message-ID: <2024081910-upload-display-e82d@gregkh>
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
git cherry-pick -x 0dbb81d44108a2a1004e5b485ef3fca5bc078424
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081910-upload-display-e82d@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

0dbb81d44108 ("drm/amd/display: Enable otg synchronization logic for DCN321")
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



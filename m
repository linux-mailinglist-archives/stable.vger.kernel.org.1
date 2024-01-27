Return-Path: <stable+bounces-16209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C26483F1AC
	for <lists+stable@lfdr.de>; Sun, 28 Jan 2024 00:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16C9E281C03
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF8B200A4;
	Sat, 27 Jan 2024 23:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WkFzIH0S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D0A1B80B
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 23:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706397342; cv=none; b=LlBMKyQdWWTrlaXVp1X8usaHY4DmY2LPF3huHpu3oplLhSrTRmqULeEIe+S7p7DUX7iWds7CjTG1B1MFibhUZHJdAc2rYNyA1SSFYk9FTGLWRwWrSM+6IiGF5yKZNhdfav7MS+qsvnV8llOzu6NjXU74Qnnb1n9ILGKkqJEgW64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706397342; c=relaxed/simple;
	bh=ho0hbi8zxa3d4wdDUE8JrfH72z9O1i+JIU+vE8yNHPc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MvrdEOHJdOsV3nV4NpHO3RAGClksKkybuqmHnEWXVcXXPgDa7KYKpnsF7CuItrQjooyQUZ0NPIswWKIMDPONX+ZFv1ymeH2DXlIIIz41Cnqwp6XmZ4FyEZ8V3iIiDGhWdoilmdzsjzwfQ7/vHHFOJE4V8B0GAPw+HuYTN8JIIFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WkFzIH0S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7473C433C7;
	Sat, 27 Jan 2024 23:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706397342;
	bh=ho0hbi8zxa3d4wdDUE8JrfH72z9O1i+JIU+vE8yNHPc=;
	h=Subject:To:Cc:From:Date:From;
	b=WkFzIH0SghTFlUSdDJ860rxmG/paX4+ewMNcIP/8q4RW582G++pE1T3XdkCuAve8Q
	 /hjhuuElrHx5YC0fAzDyWZhwxNiuNk15PLA3ZJVgsEcHIdalNZk9QDrtlnpdo2nYUH
	 h9HSP0ebWhn5ha3itFRLF8Agyd/Z85/cZNPLOL/o=
Subject: FAILED: patch "[PATCH] drm/amd/display: Clear OPTC mem select on disable" failed to apply to 6.7-stable tree
To: ilya.bakoulin@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,charlene.liu@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 15:15:41 -0800
Message-ID: <2024012741-tulip-enhance-9750@gregkh>
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
git cherry-pick -x 3ba2a0bfd8cf94eb225e1c60dff16e5c35bde1da
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012741-tulip-enhance-9750@gregkh' --subject-prefix 'PATCH 6.7.y' HEAD^..

Possible dependencies:

3ba2a0bfd8cf ("drm/amd/display: Clear OPTC mem select on disable")
7bdbfb4e36e3 ("drm/amd/display: Disconnect phantom pipe OPP from OPTC being disabled")
e7b2b108cdea ("drm/amd/display: Fix hang/underflow when transitioning to ODM4:1")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3ba2a0bfd8cf94eb225e1c60dff16e5c35bde1da Mon Sep 17 00:00:00 2001
From: Ilya Bakoulin <ilya.bakoulin@amd.com>
Date: Wed, 3 Jan 2024 09:42:04 -0500
Subject: [PATCH] drm/amd/display: Clear OPTC mem select on disable

[Why]
Not clearing the memory select bits prior to OPTC disable can cause DSC
corruption issues when attempting to reuse a memory instance for another
OPTC that enables ODM.

[How]
Clear the memory select bits prior to disabling an OPTC.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ilya Bakoulin <ilya.bakoulin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
index 1788eb29474b..823493543325 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
@@ -173,6 +173,9 @@ static bool optc32_disable_crtc(struct timing_generator *optc)
 			OPTC_SEG3_SRC_SEL, 0xf,
 			OPTC_NUM_OF_INPUT_SEGMENT, 0);
 
+	REG_UPDATE(OPTC_MEMORY_CONFIG,
+			OPTC_MEM_SEL, 0);
+
 	/* disable otg request until end of the first line
 	 * in the vertical blank region
 	 */
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
index 3d6c1b2c2b4d..5b1547508850 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
@@ -145,6 +145,9 @@ static bool optc35_disable_crtc(struct timing_generator *optc)
 			OPTC_SEG3_SRC_SEL, 0xf,
 			OPTC_NUM_OF_INPUT_SEGMENT, 0);
 
+	REG_UPDATE(OPTC_MEMORY_CONFIG,
+			OPTC_MEM_SEL, 0);
+
 	/* disable otg request until end of the first line
 	 * in the vertical blank region
 	 */



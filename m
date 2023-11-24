Return-Path: <stable+bounces-278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C59D07F7623
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 15:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81284281B45
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 14:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF902836C;
	Fri, 24 Nov 2023 14:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GWJdqtxS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD06E28E25
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 14:17:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BB5C433CD;
	Fri, 24 Nov 2023 14:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700835434;
	bh=IQvEcGMAX35rD4e1H8x8araq4NKmzTRpSw4vPT3ZsFA=;
	h=Subject:To:Cc:From:Date:From;
	b=GWJdqtxSm9hz9z1afS+VZTKpAjEYRtL4s1v/jH53LzlEDEZoYnLBBQI9ff/b3UO2N
	 qsp0QVOFlR80HtENMTEGr6OhDgEY1uN45EhpkPIhs8KmOUuyGXiZR3/zHRCW5AsVHQ
	 eYgg2BtQQ9i/knyCKPsKxF6x5h1tjLNBkr0MANtE=
Subject: FAILED: patch "[PATCH] drm/amd/display: Don't set dpms_off for seamless boot" failed to apply to 5.10-stable tree
To: daniel.miess@amd.com,alexander.deucher@amd.com,charlene.liu@amd.com,chiahsuan.chung@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 14:17:04 +0000
Message-ID: <2023112403-second-camisole-9772@gregkh>
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
git cherry-pick -x ef013f6fcd8affaae4a5bf4b51cb6244c8a2ed3f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112403-second-camisole-9772@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

ef013f6fcd8a ("drm/amd/display: Don't set dpms_off for seamless boot")
850d2fcf3e34 ("drm/amd/display: only check available pipe to disable vbios mode.")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ef013f6fcd8affaae4a5bf4b51cb6244c8a2ed3f Mon Sep 17 00:00:00 2001
From: Daniel Miess <daniel.miess@amd.com>
Date: Fri, 29 Sep 2023 13:04:33 -0400
Subject: [PATCH] drm/amd/display: Don't set dpms_off for seamless boot

[Why]
eDPs fail to light up with seamless boot enabled

[How]
When seamless boot is enabled don't configure dpms_off
in disable_vbios_mode_if_required.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Daniel Miess <daniel.miess@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index f9aac215ef1f..00d6fce5b766 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1232,6 +1232,9 @@ static void disable_vbios_mode_if_required(
 		if (stream == NULL)
 			continue;
 
+		if (stream->apply_seamless_boot_optimization)
+			continue;
+
 		// only looking for first odm pipe
 		if (pipe->prev_odm_pipe)
 			continue;



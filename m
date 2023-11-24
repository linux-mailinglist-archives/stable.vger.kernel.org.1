Return-Path: <stable+bounces-242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 277F57F75B5
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 14:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6AFF28253C
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 13:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0E828DDA;
	Fri, 24 Nov 2023 13:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A7SEIhRH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73602286B9
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 13:54:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7A2C433C8;
	Fri, 24 Nov 2023 13:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700834063;
	bh=jE2ByXSHog6xlUW6UTI8vfk0NqKX9hVoNqjPCl1A4jI=;
	h=Subject:To:Cc:From:Date:From;
	b=A7SEIhRHhMIsR3KpWcIQCq9pPXhjKlVwC5FV2n5OHmjAeIdlWCFCicAcfY3YK8oNU
	 7C96Eaq2kLwi5iDW+bknc1R97ny7AkLA4qNLCsAYvmsta9euhkzDd4R0Tgk/tScY9g
	 g3QbvV4Lcs678HOJxFylzC8ZoyJA1zxD8kTDbOFw=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix 2nd DPIA encoder Assignment" failed to apply to 6.5-stable tree
To: mghaddar@amd.com,alexander.deucher@amd.com,cruise.hung@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com,meenakshikumar.somasundaram@amd.com,stylon.wang@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 13:54:16 +0000
Message-ID: <2023112416-venue-tinwork-820b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.5-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
git checkout FETCH_HEAD
git cherry-pick -x 48468787c2b029e5c9f8abef777cd065647abf2e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112416-venue-tinwork-820b@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:

48468787c2b0 ("drm/amd/display: Fix 2nd DPIA encoder Assignment")
753b7e62c9cf ("drm/amd/display: Add DPIA Link Encoder Assignment Fix")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 48468787c2b029e5c9f8abef777cd065647abf2e Mon Sep 17 00:00:00 2001
From: Mustapha Ghaddar <mghaddar@amd.com>
Date: Tue, 22 Aug 2023 16:18:03 -0400
Subject: [PATCH] drm/amd/display: Fix 2nd DPIA encoder Assignment

[HOW & Why]
There seems to be an issue with 2nd DPIA acquiring link encoder for tiled displays.
Solution is to remove check for eng_id before we get first dynamic encoder for it

Reviewed-by: Cruise Hung <cruise.hung@amd.com>
Reviewed-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Mustapha Ghaddar <mghaddar@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
index b66eeac4d3d2..be5a6d008b29 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
@@ -395,8 +395,7 @@ void link_enc_cfg_link_encs_assign(
 					stream->link->dpia_preferred_eng_id != ENGINE_ID_UNKNOWN)
 				eng_id_req = stream->link->dpia_preferred_eng_id;
 
-			if (eng_id == ENGINE_ID_UNKNOWN)
-				eng_id = find_first_avail_link_enc(stream->ctx, state, eng_id_req);
+			eng_id = find_first_avail_link_enc(stream->ctx, state, eng_id_req);
 		}
 		else
 			eng_id =  link_enc->preferred_engine;
@@ -501,7 +500,6 @@ struct dc_link *link_enc_cfg_get_link_using_link_enc(
 	if (stream)
 		link = stream->link;
 
-	// dm_output_to_console("%s: No link using DIG(%d).\n", __func__, eng_id);
 	return link;
 }
 



Return-Path: <stable+bounces-265-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D047F7612
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 15:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57528B21402
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 14:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2289286B9;
	Fri, 24 Nov 2023 14:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MT3DThb/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718712C85B
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 14:14:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00ABDC433CA;
	Fri, 24 Nov 2023 14:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700835270;
	bh=BwxL+T49LNoI/gQNP0XA458wWcfxcvv5g0A5t0GjuUI=;
	h=Subject:To:Cc:From:Date:From;
	b=MT3DThb/jDT+zMbAsttXUHtnPn0ATzDCIvbdtyx01PKu8MYW4uAlbr94aJu7bLgeN
	 90jZsErI84bj5H4r8zHCu++JD0YvIdWWglTgGv+WEtaHGAU4mchEZcr7Gmn/ccW4Qu
	 hx0bjpiAN8mC/HTcjlSrHLMCQPJ7pEe8Q1Dq5dh8=
Subject: FAILED: patch "[PATCH] drm/amd/display: prevent potential division by zero errors" failed to apply to 5.4-stable tree
To: hamza.mahfooz@amd.com,alexander.deucher@amd.com,aurabindo.pillai@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 14:14:18 +0000
Message-ID: <2023112418-animation-princess-502b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 084f658ece139645d203fa09c77c7f96cb849bb7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112418-animation-princess-502b@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

084f658ece13 ("drm/amd/display: prevent potential division by zero errors")
e4ed4dbbc838 ("drm/amd/display: Fix LFC multiplier changing erratically")
bb2746ac9143 ("drm/amd/display: Improve LFC behaviour")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 084f658ece139645d203fa09c77c7f96cb849bb7 Mon Sep 17 00:00:00 2001
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
Date: Tue, 5 Sep 2023 13:27:22 -0400
Subject: [PATCH] drm/amd/display: prevent potential division by zero errors

There are two places in apply_below_the_range() where it's possible for
a divide by zero error to occur. So, to fix this make sure the divisor
is non-zero before attempting the computation in both cases.

Cc: stable@vger.kernel.org
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2637
Fixes: a463b263032f ("drm/amd/display: Fix frames_to_insert math")
Fixes: ded6119e825a ("drm/amd/display: Reinstate LFC optimization")
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index dbd60811f95d..ef3a67409021 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -338,7 +338,9 @@ static void apply_below_the_range(struct core_freesync *core_freesync,
 		 *  - Delta for CEIL: delta_from_mid_point_in_us_1
 		 *  - Delta for FLOOR: delta_from_mid_point_in_us_2
 		 */
-		if ((last_render_time_in_us / mid_point_frames_ceil) < in_out_vrr->min_duration_in_us) {
+		if (mid_point_frames_ceil &&
+		    (last_render_time_in_us / mid_point_frames_ceil) <
+		    in_out_vrr->min_duration_in_us) {
 			/* Check for out of range.
 			 * If using CEIL produces a value that is out of range,
 			 * then we are forced to use FLOOR.
@@ -385,8 +387,9 @@ static void apply_below_the_range(struct core_freesync *core_freesync,
 		/* Either we've calculated the number of frames to insert,
 		 * or we need to insert min duration frames
 		 */
-		if (last_render_time_in_us / frames_to_insert <
-				in_out_vrr->min_duration_in_us){
+		if (frames_to_insert &&
+		    (last_render_time_in_us / frames_to_insert) <
+		    in_out_vrr->min_duration_in_us){
 			frames_to_insert -= (frames_to_insert > 1) ?
 					1 : 0;
 		}



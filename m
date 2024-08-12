Return-Path: <stable+bounces-66648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE0994F08F
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92B461F212F7
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A245A183CCD;
	Mon, 12 Aug 2024 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OrDiNyrC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6437117BB03
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474272; cv=none; b=Dw3oYSRewPwh5YWQwwQZXHn87bKxomK9GNGys9nxgmQESmaHgT+H16DfvWwtU4s2h0/30DznVJnCQWfOaiaMwAY6jdZtpBFJcO/iZWcrTiFStVe/UMYY1HewAJ/hgSqF6ARgQv6jyBy/554yq5M1mmzNMWFiaq8Tt6aESXz8G0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474272; c=relaxed/simple;
	bh=a7cCKAhpmGP/tG6s599a/BIO+p0uhc6gs7CT2qSy6kY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HH8tiGKwZJMVoJZGJ8ZSPdL5VIrk2R+JfFoWlX7BBlLxbSzx8bOOLIXWLieFkwG7RKBzrJn56iM3Jzjs+lR6ZqwSnc0S7+jjRDFCnj/I+NbJdUGU/cKDbVgRsZmYkFVUzgYYDmNmy3dJxV9/UlH3ASjDV1XGkvBPYcgPKEcqX78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OrDiNyrC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB4DC32782;
	Mon, 12 Aug 2024 14:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474272;
	bh=a7cCKAhpmGP/tG6s599a/BIO+p0uhc6gs7CT2qSy6kY=;
	h=Subject:To:Cc:From:Date:From;
	b=OrDiNyrCyQt5CYi3J80NBu9Svqc/amcvSWXT1XgP8xQUYYgCe/gBw6aElkNdOL9rb
	 WMDw/Uulu5SkbKTb43A1jr94EvXldiUbJWrjFoPBljK3q5LRypk5QQyaO2H9SeYT47
	 ormlwi5cQ+qQOf3LNOsN/wvlSNd8vZ/iVpw+dxLI=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix reduced resolution and refresh rate" failed to apply to 6.6-stable tree
To: daniel.sa@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com,wenjing.liu@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:49:07 +0200
Message-ID: <2024081207-voter-silencer-8387@gregkh>
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
git cherry-pick -x 0dd1190faff7f7b389291266e118deb381b6c8d9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081207-voter-silencer-8387@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

0dd1190faff7 ("drm/amd/display: Fix reduced resolution and refresh rate")
82c421ba46ec ("drm/amd/display: Add fallback defaults for invalid LTTPR DPCD caps")
4eaf110f97ae ("drm/amd/display: Check UHBR13.5 cap when determining max link cap")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0dd1190faff7f7b389291266e118deb381b6c8d9 Mon Sep 17 00:00:00 2001
From: Daniel Sa <daniel.sa@amd.com>
Date: Thu, 13 Jun 2024 15:38:06 -0400
Subject: [PATCH] drm/amd/display: Fix reduced resolution and refresh rate

[WHY]
Some monitors are forced to a lower resolution and refresh rate after
system restarts.

[HOW]
Some monitors may give invalid LTTPR information when queried such as
indicating they have one DP lane instead of 4. If given an invalid DPCD
version, skip over getting lttpr link rate and lane counts.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Daniel Sa <daniel.sa@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index f1cac74dd7f7..46bb7a855bc2 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -409,9 +409,6 @@ static enum dc_link_rate get_lttpr_max_link_rate(struct dc_link *link)
 	case LINK_RATE_HIGH3:
 		lttpr_max_link_rate = link->dpcd_caps.lttpr_caps.max_link_rate;
 		break;
-	default:
-		// Assume all LTTPRs support up to HBR3 to improve misbehaving sink interop
-		lttpr_max_link_rate = LINK_RATE_HIGH3;
 	}
 
 	if (link->dpcd_caps.lttpr_caps.supported_128b_132b_rates.bits.UHBR20)
@@ -2137,15 +2134,19 @@ struct dc_link_settings dp_get_max_link_cap(struct dc_link *link)
 	 * notes: repeaters do not snoop in the DPRX Capabilities addresses (3.6.3).
 	 */
 	if (dp_is_lttpr_present(link)) {
-		if (link->dpcd_caps.lttpr_caps.max_lane_count < max_link_cap.lane_count)
-			max_link_cap.lane_count = link->dpcd_caps.lttpr_caps.max_lane_count;
-		lttpr_max_link_rate = get_lttpr_max_link_rate(link);
 
-		if (lttpr_max_link_rate < max_link_cap.link_rate)
-			max_link_cap.link_rate = lttpr_max_link_rate;
+		/* Some LTTPR devices do not report valid DPCD revisions, if so, do not take it's link cap into consideration. */
+		if (link->dpcd_caps.lttpr_caps.revision.raw >= DPCD_REV_14) {
+			if (link->dpcd_caps.lttpr_caps.max_lane_count < max_link_cap.lane_count)
+				max_link_cap.lane_count = link->dpcd_caps.lttpr_caps.max_lane_count;
+			lttpr_max_link_rate = get_lttpr_max_link_rate(link);
 
-		if (!link->dpcd_caps.lttpr_caps.supported_128b_132b_rates.bits.UHBR13_5)
-			is_uhbr13_5_supported = false;
+			if (lttpr_max_link_rate < max_link_cap.link_rate)
+				max_link_cap.link_rate = lttpr_max_link_rate;
+
+			if (!link->dpcd_caps.lttpr_caps.supported_128b_132b_rates.bits.UHBR13_5)
+				is_uhbr13_5_supported = false;
+		}
 
 		DC_LOG_HW_LINK_TRAINING("%s\n Training with LTTPR,  max_lane count %d max_link rate %d \n",
 						__func__,



Return-Path: <stable+bounces-66649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD21C94F090
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F22441C22095
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB605336D;
	Mon, 12 Aug 2024 14:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qUGHFbth"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFD34B5AE
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474276; cv=none; b=pk/zvnHfmEIfrtO7dINxX5I2C3krQNzidrtWeNwX+v0yykqEvv4Ir040ozDs3jb3AdePwlPqi56IT8kAv3bBbdDSq32m+D/qY5YFI65N5/G+BWcYGqWtkuw9aNRMuFDKgX1ICXImy6qHfF03tAV2tgucTnCmFbnFvsJbV9V1l4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474276; c=relaxed/simple;
	bh=+zCDnfQ6g5gPPJNwCG1G7jOMtZ3YcZFbl2e3nUoEnv4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Mpayk9K3sG/8aDMJ0/wN/v0alf0CJbNio30ADoLYHkLQFDkSqmOJvj5bqZy/yloeuBxV/3SVhMBiGeBorVi6Zm4ekKusX+7q4Hbm/wUeGYcGe3zEAdBWjmeh2LFhp6n9qdr2R5xNDnQ82d6OdwjQU1mZOeqRkqXgPQonwD53GNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qUGHFbth; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BBD1C4AF09;
	Mon, 12 Aug 2024 14:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474275;
	bh=+zCDnfQ6g5gPPJNwCG1G7jOMtZ3YcZFbl2e3nUoEnv4=;
	h=Subject:To:Cc:From:Date:From;
	b=qUGHFbthMdDBd9jVAKFCz4mxgHYXH1Q+nXXa3EKcwMl2OYT4zkdyW5nHbbTGpnu+Y
	 CkDDnLV3qF1Ennjni9FKJXmc70caA/R7JlvhVI3h81ZyX17uqirA1NmnIlM9mqD39p
	 RT6JHT0SqVArKyIJn91J7nOmxPJDtiKgGmf5p65U=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix reduced resolution and refresh rate" failed to apply to 6.1-stable tree
To: daniel.sa@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com,wenjing.liu@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:49:08 +0200
Message-ID: <2024081208-lilac-skintight-2316@gregkh>
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
git cherry-pick -x 0dd1190faff7f7b389291266e118deb381b6c8d9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081208-lilac-skintight-2316@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

0dd1190faff7 ("drm/amd/display: Fix reduced resolution and refresh rate")
82c421ba46ec ("drm/amd/display: Add fallback defaults for invalid LTTPR DPCD caps")
4eaf110f97ae ("drm/amd/display: Check UHBR13.5 cap when determining max link cap")
bc33f5e5f05b ("drm/amd/display: create accessories, hwss and protocols sub folders in link")
028c4ccfb812 ("drm/amd/display: force connector state when bpc changes during compliance")
603a521ec279 ("drm/amd/display: remove duplicate included header files")
d5a43956b73b ("drm/amd/display: move dp capability related logic to link_dp_capability")
94dfeaa46925 ("drm/amd/display: move dp phy related logic to link_dp_phy")
630168a97314 ("drm/amd/display: move dp link training logic to link_dp_training")
d144b40a4833 ("drm/amd/display: move dc_link_dpia logic to link_dp_dpia")
a28d0bac0956 ("drm/amd/display: move dpcd logic from dc_link_dpcd to link_dpcd")
a98cdd8c4856 ("drm/amd/display: refactor ddc logic from dc_link_ddc to link_ddc")
4370f72e3845 ("drm/amd/display: refactor hpd logic from dc_link to link_hpd")
0e8cf83a2b47 ("drm/amd/display: allow hpo and dio encoder switching during dp retrain test")
7462475e3a06 ("drm/amd/display: move dccg programming from link hwss hpo dp to hwss")
e85d59885409 ("drm/amd/display: use encoder type independent hwss instead of accessing enc directly")
ebf13b72020a ("drm/amd/display: Revert Scaler HCBlank issue workaround")
639f6ad6df7f ("drm/amd/display: Revert Reduce delay when sink device not able to ACK 00340h write")
e3aa827e2ab3 ("drm/amd/display: Avoid setting pixel rate divider to N/A")
fe4e2662b2dd ("drm/amd/display: Phase 1 Add Bw Allocation source and header files")

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



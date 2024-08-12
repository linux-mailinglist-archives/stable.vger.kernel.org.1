Return-Path: <stable+bounces-66697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9A794F0C3
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4D431F22DD6
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C6918132A;
	Mon, 12 Aug 2024 14:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yt7Gxh2i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6358117BB03
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474445; cv=none; b=M4v4J4+jr5605vu5w3rRlYLCGpI1gG0+E5UhEl0dcMNeoUzlfyblu549CrqMpqJ6QDDPnPeTrCk4WL22Md7f/L+zRx2H3xSs92MYnD+NTy3njb9jWxUBLVO+DlhD29BOQdsJI+Z8J7oLRYwGgz33IDIItHTBxcGPExHzFMLcjG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474445; c=relaxed/simple;
	bh=nWj2Ul1PSwhsEyDiWGR6Flmdtczxj43pH8SrHDOowvg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YaEyFi5KHO4Az2Rfg8nwRMuUA1BKysOlzQQDa+n6x0tyxDE99eYdbMP4+RBm8uAfRD45B4To/H033wTIAHRYKxAfH3OH42l5uItgy3VawruF7SPGg5J/UOz3Juhg86aAd+p4O/Vuo0OJBGNoC9VCpK5RsoAbEyfax6appplOAw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yt7Gxh2i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43DDC32782;
	Mon, 12 Aug 2024 14:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474445;
	bh=nWj2Ul1PSwhsEyDiWGR6Flmdtczxj43pH8SrHDOowvg=;
	h=Subject:To:Cc:From:Date:From;
	b=yt7Gxh2itVGvUDVLTceC184oocwzUfw4wGvMG3aalZAjkApit4sNcCr2E4fP+Q6LV
	 vWda/cw1IBe4Kpl7+iXOnQTUnsC+oENcLqNbgH33BxUwj+bVu5Wn8nY6EKOt5biTgt
	 OFnnTH2WRk2fDxTSFqzBvTeeG3rjwaVZPsAnNipU=
Subject: FAILED: patch "[PATCH] drm/amd/display: Send DP_TOTAL_LTTPR_CNT during detection if" failed to apply to 6.10-stable tree
To: michael.strauss@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com,wenjing.liu@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:51:20 +0200
Message-ID: <2024081219-deforest-viscous-3723@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x d03415f60b3401914fabd27a20017f8056fd5e40
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081219-deforest-viscous-3723@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

d03415f60b34 ("drm/amd/display: Send DP_TOTAL_LTTPR_CNT during detection if LTTPR is present")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d03415f60b3401914fabd27a20017f8056fd5e40 Mon Sep 17 00:00:00 2001
From: Michael Strauss <michael.strauss@amd.com>
Date: Tue, 28 Nov 2023 10:31:12 -0500
Subject: [PATCH] drm/amd/display: Send DP_TOTAL_LTTPR_CNT during detection if
 LTTPR is present

[WHY]
New register field added in DP2.1 SCR, needed for auxless ALPM

[HOW]
Echo value read from 0xF0007 back to sink

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 00974c50e11f..f1cac74dd7f7 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1605,9 +1605,17 @@ static bool retrieve_link_cap(struct dc_link *link)
 			return false;
 	}
 
-	if (dp_is_lttpr_present(link))
+	if (dp_is_lttpr_present(link)) {
 		configure_lttpr_mode_transparent(link);
 
+		// Echo TOTAL_LTTPR_CNT back downstream
+		core_link_write_dpcd(
+				link,
+				DP_TOTAL_LTTPR_CNT,
+				&link->dpcd_caps.lttpr_caps.phy_repeater_cnt,
+				sizeof(link->dpcd_caps.lttpr_caps.phy_repeater_cnt));
+	}
+
 	/* Read DP tunneling information. */
 	status = dpcd_get_tunneling_device_data(link);
 
diff --git a/drivers/gpu/drm/amd/display/include/dpcd_defs.h b/drivers/gpu/drm/amd/display/include/dpcd_defs.h
index 914f28e9f224..aee5170f5fb2 100644
--- a/drivers/gpu/drm/amd/display/include/dpcd_defs.h
+++ b/drivers/gpu/drm/amd/display/include/dpcd_defs.h
@@ -177,4 +177,9 @@ enum dpcd_psr_sink_states {
 #define DP_SINK_PR_PIXEL_DEVIATION_PER_LINE     0x379
 #define DP_SINK_PR_MAX_NUMBER_OF_DEVIATION_LINE 0x37A
 
+/* Remove once drm_dp_helper.h is updated upstream */
+#ifndef DP_TOTAL_LTTPR_CNT
+#define DP_TOTAL_LTTPR_CNT                                  0xF000A /* 2.1 */
+#endif
+
 #endif /* __DAL_DPCD_DEFS_H__ */



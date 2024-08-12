Return-Path: <stable+bounces-66699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50ABD94F0C6
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12529280E11
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26864153BF6;
	Mon, 12 Aug 2024 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z3vNAFOa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC14C4B5AE
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474452; cv=none; b=NbB8HQSSuwHD1JRxqanSDnnsTteP9D8S5v5aCRRtVxQ63MMCO5lcGJ3itQDJZ4zojRw+lp4s5jtRlB3BQ/ntX0Q+rKqrE2iMZYz27kO8VR5js0JnwfbAgm7mD+jr+8NYNeUoipsgjtAF3zTNN4W98m2uDiSp2aTINtOvovYFlHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474452; c=relaxed/simple;
	bh=Hnm/3mo2KUHOSyW5eSUGl7vg4KFrQsVpsWq8IxgIt7s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZMwIUqVqUMrDYt6LM85qxKhEnbS6BjkIvMaBiFbXiSN9avuavii90axim0rXxiwhorTVBmeat+Yn/4mHPmgbzn5bpCFE47HVkLHxCpFaH2qqwuYqqmU/PoGpOUzVbgajftIn2ZavxqPbPSIfE/BknvsqnKw4Oj2R7wc6W4+WfnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z3vNAFOa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD8AC32782;
	Mon, 12 Aug 2024 14:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474452;
	bh=Hnm/3mo2KUHOSyW5eSUGl7vg4KFrQsVpsWq8IxgIt7s=;
	h=Subject:To:Cc:From:Date:From;
	b=z3vNAFOaA3usPPL7q0GS/bduXyhU9/0MKFPEf4XnzHYZVpoSAkh+gNG/n1oWGZtDt
	 7sGG0iYFvIMB1eXg4NweZPVPBP6xuuI+s6+58DtDkqU2UFswxSxCrIhZzFcHr+TOXh
	 gF5Ljh04HOpcQ5Ka4ouc00YWieATT7TgTaaRCXe8=
Subject: FAILED: patch "[PATCH] drm/amd/display: Send DP_TOTAL_LTTPR_CNT during detection if" failed to apply to 6.1-stable tree
To: michael.strauss@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com,wenjing.liu@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:51:24 +0200
Message-ID: <2024081224-encode-climate-495b@gregkh>
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
git cherry-pick -x d03415f60b3401914fabd27a20017f8056fd5e40
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081224-encode-climate-495b@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

d03415f60b34 ("drm/amd/display: Send DP_TOTAL_LTTPR_CNT during detection if LTTPR is present")
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
180f33d27a55 ("drm/amd/display: Adjust DP 8b10b LT exit behavior")
b7ada7ee61d3 ("drm/amd/display: Populate DP2.0 output type for DML pipe")

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



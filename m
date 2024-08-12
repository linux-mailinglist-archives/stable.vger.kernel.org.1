Return-Path: <stable+bounces-66703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 753CD94F0CA
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31069280F4A
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD4217F4FE;
	Mon, 12 Aug 2024 14:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gdvfa/nH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53BE4B5AE
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474465; cv=none; b=QLIlp2YPDuQeo6heke6P0mytalGVY6x+lCphiEj9nc0+YuREopuMIQr4C7ZrJn1kn3MLgZL3Nn03sjGeh92pksZ9Fynq6sr772XC0VVxFcsDifeFC++jrfbgvbNhwcF0SJBZnVKiDeFlKtz3vWxOkRfjPncWUWCDxDXFBmrxmQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474465; c=relaxed/simple;
	bh=BOQzOKHcRlVpE9p5WDv+jyKVLqUmnq+yO5Ix7cfb4Rs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PZXQMdJYwOqmnTjVk09lZhYIgZRj8Tds9gXvSh6bG6k7vmQIW+1iNmBSzZDuxCBPuGGPjGTx5/fs4JN5yJti4L38ZO+1S8eL/My7oLDVFEzP5KnXPJGqeZlWeLQVvu1jXjeTR5aL5fNIiaIGBCkGBORY0rTPZ/h3Y2BOoPcdZ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gdvfa/nH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321EBC32782;
	Mon, 12 Aug 2024 14:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474465;
	bh=BOQzOKHcRlVpE9p5WDv+jyKVLqUmnq+yO5Ix7cfb4Rs=;
	h=Subject:To:Cc:From:Date:From;
	b=Gdvfa/nH7CENLOg0k0IDm/gNW5MgDqJQyX1+YLsC4Kq0X+He2pc4YcteIK3tm8pTb
	 AOozSqcqODYkE/eo0wbHm6vjSCEnM2ExlnvuGc9bnJ0LgA8j3MRPfT/v6vTPWziUZr
	 /LWGSBkYrIVOx9cBpGWQpUYSwe0PPY3k0hD9CiAg=
Subject: FAILED: patch "[PATCH] drm/amd/display: Send DP_TOTAL_LTTPR_CNT during detection if" failed to apply to 4.19-stable tree
To: michael.strauss@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com,wenjing.liu@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:51:27 +0200
Message-ID: <2024081227-unfilled-embark-efe9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x d03415f60b3401914fabd27a20017f8056fd5e40
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081227-unfilled-embark-efe9@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

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



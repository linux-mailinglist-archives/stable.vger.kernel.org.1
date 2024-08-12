Return-Path: <stable+bounces-66695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB7D94F0C1
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2AAF1C20F2F
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11658153BF6;
	Mon, 12 Aug 2024 14:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hw2D43SI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CED4B5AE
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474437; cv=none; b=XYlj9Nk1InvBQqW+6wZCWtm0xFiLfBgdEeI82XR4yi7fGmDJdqU0EOaN+hlAcDxITxMiecPVv41jWN2P/iLTkMuNOZcJV0Oe+ucQi2A5liWWX/+a/zMC83iAAJd4kAJsprbEjpQkkC0qO8/RDGN2GmCj5m0Ae82O697VraetODE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474437; c=relaxed/simple;
	bh=01BEffErbiZn5Y9W78odVOYcUBDlNQo/87MX5WXoCFY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uAoS6F4iVBnOru7QwEqjjTBe55SzeJuf5jCHMcoz6kayrutjtOh7b4VsesjFn/S3rUxGlWqE23gCDttR9hCdS15nNv8QnOg/IF6PWBIhwuRUa3dk/84azR1ULJIkMUQZ6bnuCrwZ8gZ1gtLxcOfg9HELnjg590r6Ma/L+WjJ2r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hw2D43SI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347D6C32782;
	Mon, 12 Aug 2024 14:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474437;
	bh=01BEffErbiZn5Y9W78odVOYcUBDlNQo/87MX5WXoCFY=;
	h=Subject:To:Cc:From:Date:From;
	b=Hw2D43SI5tHAGUN4tzeo+z+6nUPWiJHU/CljvvolMBCJGDwg8MNCVaap/J/bCPykg
	 L1YBs59ec1H79GktwBrPh7lHKy8bw28EOaOaHVjD+TP0vnXC47DwcRv3mUQllYhzJa
	 G9PsE5bkxuYL1ekDo6KO6O5G/m+NZ0lXZKRsMe2o=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix FEC_READY write on DP LT" failed to apply to 4.19-stable tree
To: ilya.bakoulin@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com,wayne.lin@amd.com,wenjing.liu@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:51:14 +0200
Message-ID: <2024081214-bony-overhang-43f4@gregkh>
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
git cherry-pick -x a8baec4623aedf36d50767627f6eae5ebf07c6fb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081214-bony-overhang-43f4@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

a8baec4623ae ("drm/amd/display: Fix FEC_READY write on DP LT")
a8ac994cf069 ("drm/amd/display: Disable error correction if it's not supported")
788c6e2ce5c7 ("drm/amd/display: replace all dc_link function call in link with link functions")
c69fc3d0de6c ("drm/amd/display: Reduce CPU busy-waiting for long delays")
8e5cfe547bf3 ("drm/amd/display: upstream link_dp_dpia_bw.c")
54618888d1ea ("drm/amd/display: break down dc_link.c")
71d7e8904d54 ("drm/amd/display: Add HDMI manufacturer OUI and device id read")
65a4cfb45e0e ("drm/amdgpu/display: remove duplicate include header in files")
e322843e5e33 ("drm/amd/display: fix linux dp link lost handled only one time")
0c2bfcc338eb ("drm/amd/display: Add Function declaration in dc_link")
6ca7415f11af ("drm/amd/display: merge dc_link_dp into dc_link")
de3fb390175b ("drm/amd/display: move dp cts functions from dc_link_dp to link_dp_cts")
c5a31f178e35 ("drm/amd/display: move dp irq handler functions from dc_link_dp to link_dp_irq_handler")
0078c924e733 ("drm/amd/display: move eDP panel control logic to link_edp_panel_control")
bc33f5e5f05b ("drm/amd/display: create accessories, hwss and protocols sub folders in link")
2daeb74b7d66 ("drm/amdgpu/display/mst: update mst_mgr relevant variable when long HPD")
028c4ccfb812 ("drm/amd/display: force connector state when bpc changes during compliance")
603a521ec279 ("drm/amd/display: remove duplicate included header files")
bd3149014dff ("drm/amd/display: Decrease messaging about DP alt mode state to debug")
d5a43956b73b ("drm/amd/display: move dp capability related logic to link_dp_capability")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a8baec4623aedf36d50767627f6eae5ebf07c6fb Mon Sep 17 00:00:00 2001
From: Ilya Bakoulin <ilya.bakoulin@amd.com>
Date: Wed, 17 Apr 2024 14:21:28 -0400
Subject: [PATCH] drm/amd/display: Fix FEC_READY write on DP LT

[Why/How]
We can miss writing FEC_READY in some cases before LT start, which
violates DP spec. Remove the condition guarding the DPCD write so that
the write happens unconditionally.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Ilya Bakoulin <ilya.bakoulin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
index 5cbf5f93e584..bafa52a0165a 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
@@ -151,16 +151,14 @@ enum dc_status dp_set_fec_ready(struct dc_link *link, const struct link_resource
 		return DC_NOT_SUPPORTED;
 
 	if (ready && dp_should_enable_fec(link)) {
-		if (link->fec_state == dc_link_fec_not_ready) {
-			fec_config = 1;
+		fec_config = 1;
 
-			status = core_link_write_dpcd(link, DP_FEC_CONFIGURATION,
-					&fec_config, sizeof(fec_config));
+		status = core_link_write_dpcd(link, DP_FEC_CONFIGURATION,
+				&fec_config, sizeof(fec_config));
 
-			if (status == DC_OK) {
-				link_enc->funcs->fec_set_ready(link_enc, true);
-				link->fec_state = dc_link_fec_ready;
-			}
+		if (status == DC_OK) {
+			link_enc->funcs->fec_set_ready(link_enc, true);
+			link->fec_state = dc_link_fec_ready;
 		}
 	} else {
 		if (link->fec_state == dc_link_fec_ready) {



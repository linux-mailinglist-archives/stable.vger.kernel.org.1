Return-Path: <stable+bounces-53726-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E8D90E5E4
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 10:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FFDA2833B2
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 08:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3A47BB15;
	Wed, 19 Jun 2024 08:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="My0iD7wO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0387C082
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 08:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786262; cv=none; b=Y6x5lu/+5zh7NyKFY6IdNL2P9Hx0CSVDVW1JnwgPC0d8Lg4WC0Bg8oH7M5ZKwYKwk7aIIyS5jF193x7TEVSnKWHZHr0lt/hfsO7QjSF2E6vITH5F6LiCbbzHOBkMl/l8ORwzROOsCMpP+fLtAq3DctHRqhohIQacSMOuSaSve5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786262; c=relaxed/simple;
	bh=jBRZDRVv1vfreQ/lesZrk+scTjAQSx/xu8hyGZ0gjoQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dRw96mf1wBBOJjqjiOVl1nJHToZ6N7oL15UA1tbMtO2uvNFvoN3brLNrV5lCzp2pKxeaOSK5RybJe95ujsLTpZhpxSlBEyTnSr0jupAtha+NTbxniy2BEg/1vn1pdcRVZtj0A4AzRXjILZj0qkeP61UC8WyxhvHp0nCRvZSS9V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=My0iD7wO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E44FC32786;
	Wed, 19 Jun 2024 08:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718786261;
	bh=jBRZDRVv1vfreQ/lesZrk+scTjAQSx/xu8hyGZ0gjoQ=;
	h=Subject:To:Cc:From:Date:From;
	b=My0iD7wOJ09CVtom0EIzyhh4UvntBYBPpqSOzckI3mzThZKysK4I/FUreEHUYGSxI
	 8CDwAoLCFG4p2gVo5EceXUQSHtApMq2TMvmHOaNSkzzoAxCGFine0e06s7L/538ozO
	 PA+U4T5WlcMF1sZt4vf1iDOKKn3m3tS8V+7DxqDM=
Subject: FAILED: patch "[PATCH] drm/amd/display: Set DCN351 BB and IP the same as DCN35" failed to apply to 5.10-stable tree
To: xi.liu@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,jun.lei@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Jun 2024 10:37:29 +0200
Message-ID: <2024061929-icky-grandly-5efd@gregkh>
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
git cherry-pick -x 1c5c36530a573de1a4b647b7d8c36f3b298e60ed
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061929-icky-grandly-5efd@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

1c5c36530a57 ("drm/amd/display: Set DCN351 BB and IP the same as DCN35")
115009d11ccf ("drm/amd/display: Add DCN35 DML2 support")
7966f319c66d ("drm/amd/display: Introduce DML2")
6e2c4941ce0c ("drm/amd/display: Move dml code under CONFIG_DRM_AMD_DC_FP guard")
c51d87202d1f ("drm/amd/display: do not attempt ODM power optimization if minimal transition doesn't exist")
1cb87e048975 ("drm/amd/display: Add DCN35 blocks to Makefile")
0fa45b6aeae4 ("drm/amd/display: Add DCN35 Resource")
39d39a019657 ("drm/amd/display: switch to new ODM policy for windowed MPO ODM support")
0b9dc439f404 ("drm/amd/display: Write flip addr to scratch reg for subvp")
96182df99dad ("drm/amd/display: Enable runtime register offset init for DCN32 DMUB")
ca030d83f53b ("drm/amd/display: always acquire MPO pipe for every blending tree")
71ba6b577a35 ("drm/amd/display: Add interface to enable DPIA trace")
70e64c4d522b ("drm/amd: Disable S/G for APUs when 64GB or more host memory")
3d00c59d1477 ("Merge tag 'amd-drm-next-6.6-2023-07-28' of https://gitlab.freedesktop.org/agd5f/linux into drm-next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1c5c36530a573de1a4b647b7d8c36f3b298e60ed Mon Sep 17 00:00:00 2001
From: Xi Liu <xi.liu@amd.com>
Date: Tue, 27 Feb 2024 13:39:00 -0500
Subject: [PATCH] drm/amd/display: Set DCN351 BB and IP the same as DCN35

[WHY & HOW]
DCN351 and DCN35 should use the same bounding box and IP settings.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Xi Liu <xi.liu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index cf98411d0799..151b480b3cea 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -229,17 +229,13 @@ void dml2_init_socbb_params(struct dml2_context *dml2, const struct dc *in_dc, s
 		break;
 
 	case dml_project_dcn35:
+	case dml_project_dcn351:
 		out->num_chans = 4;
 		out->round_trip_ping_latency_dcfclk_cycles = 106;
 		out->smn_latency_us = 2;
 		out->dispclk_dppclk_vco_speed_mhz = 3600;
 		break;
 
-	case dml_project_dcn351:
-		out->num_chans = 16;
-		out->round_trip_ping_latency_dcfclk_cycles = 1100;
-		out->smn_latency_us = 2;
-		break;
 	}
 	/* ---Overrides if available--- */
 	if (dml2->config.bbox_overrides.dram_num_chan)



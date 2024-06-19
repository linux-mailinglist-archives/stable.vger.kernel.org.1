Return-Path: <stable+bounces-53723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BA190E5E1
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 10:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18BE01F21A53
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 08:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49617B3E5;
	Wed, 19 Jun 2024 08:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CErvZkBa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841DD8120F
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 08:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786253; cv=none; b=OB+w/xzlgF/R5J85KiAyxiuI8FupBDB4cWCn2FTvxTF/VT0+g85dzpDm+o9IQy2157R12YbMO7grSg4Vyx3Vmul9SDQ6lAElyzFwhzm0JLJbl72MMUtCsXnFcxZpuivlachuyFwpog94L+QwbYIwj20XoHWZCQrsz/gK7ZaPrnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786253; c=relaxed/simple;
	bh=qJIxenfJoFmzGfhuJ5j9h55LRtBtuCh9+QTNluMlVYE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jWaHkYyZNL8Zv5EcbXnQZj449mrMrun1b429E938YE/W72QKmLErcVgM2UE8W53QWqgCNTdL4PJVwPe6XSkMlBljccjnv15Q5QMOFsZaO2rRcq/AuPC+diIrmEki2hQ2R+LBYct3cBI4lJrKmFNm9pmQpwu/MBCHmIlxDAPYDU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CErvZkBa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E0F9C4AF1A;
	Wed, 19 Jun 2024 08:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718786253;
	bh=qJIxenfJoFmzGfhuJ5j9h55LRtBtuCh9+QTNluMlVYE=;
	h=Subject:To:Cc:From:Date:From;
	b=CErvZkBaBnCa6CFntQM6UyKyvCR/9jw0O7CUTV8SfcIZH1M5QrN8ip+MNnehXXP3/
	 yxXryWmkrQHbkqCAuen/16F9oqqLbb1914bNSeu56ELfDfJBPxo3KQbIoK4acEz4RC
	 mUjlW1z4O2cAYWm1uAGSprQ6DFYgaMubRL7l2hJM=
Subject: FAILED: patch "[PATCH] drm/amd/display: Set DCN351 BB and IP the same as DCN35" failed to apply to 6.6-stable tree
To: xi.liu@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,jun.lei@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Jun 2024 10:37:27 +0200
Message-ID: <2024061927-rocket-pummel-1255@gregkh>
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
git cherry-pick -x 1c5c36530a573de1a4b647b7d8c36f3b298e60ed
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061927-rocket-pummel-1255@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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



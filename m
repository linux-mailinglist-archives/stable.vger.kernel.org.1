Return-Path: <stable+bounces-53725-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A6290E5E3
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 10:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A2E81C21BAB
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 08:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528CC7C081;
	Wed, 19 Jun 2024 08:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bh1//c7i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D9B7BAEC
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 08:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786259; cv=none; b=jkQddxw+WYYOt8wYKGSuB7GOFjK8VfTrPaJhn4GMbBdnkNy2jmKreXnIYcfIWaC6cR9XOAWROlH0qBkAkslQj1V7U+U5CCWICB+IbbSeU1R1sJv0JUvjDLpJeqSeH0WL4kiurqdgwwBIx6u+UAS/qFE9RKOb6NPL/TFhT5suwlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786259; c=relaxed/simple;
	bh=aV0+q1ucB/1gGahSKJeqGyuzr1+4lY3vcpvlu7hHBp8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=R7okCu4E+Cj5op5SaV+mGC7BY6GOuMHV11+Tyw50WjvmcOs+30O9tBt3AyUqegL8KArR21UTJI3/kHkM/WHjDmK71ZUfTPbHVHcJPoNEN+g87JLtE84uKTIKItuNi8WaZtgHgLzlguIZKz1RZ18XJsDl/tL9WClkMqnSq5SdnA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bh1//c7i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89549C4AF48;
	Wed, 19 Jun 2024 08:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718786258;
	bh=aV0+q1ucB/1gGahSKJeqGyuzr1+4lY3vcpvlu7hHBp8=;
	h=Subject:To:Cc:From:Date:From;
	b=bh1//c7iqP9+YMhnScuWIGKnUk4eSUbxCe8SqVdi8MMmDf6iuW7dVlpYfYsTvEY5h
	 1omYdG16/b6s34AdRU9FOMJ7/ySFyMkYXlfltsr59xJtMSmJQJPMd56/lx1uEwsja6
	 bSf/4eDi6T7C0DRSDJZg4NaAQ4gI3Yt7nLyZiukY=
Subject: FAILED: patch "[PATCH] drm/amd/display: Set DCN351 BB and IP the same as DCN35" failed to apply to 6.1-stable tree
To: xi.liu@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,jun.lei@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Jun 2024 10:37:28 +0200
Message-ID: <2024061927-scholar-reapprove-9500@gregkh>
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
git cherry-pick -x 1c5c36530a573de1a4b647b7d8c36f3b298e60ed
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061927-scholar-reapprove-9500@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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



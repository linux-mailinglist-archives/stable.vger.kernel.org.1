Return-Path: <stable+bounces-16211-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 535E183F1AE
	for <lists+stable@lfdr.de>; Sun, 28 Jan 2024 00:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA43EB21D43
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791A8200BD;
	Sat, 27 Jan 2024 23:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IqmaBciP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACAC1B7E5
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 23:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706397344; cv=none; b=hd/6P8GmPRrdjxSIkyt+jWO6yyVpyDmuT4Ben+R1sdIdl5tDAZ422OFK9nMPtP9d0YUTmjKzW0v0wRYbF/Jgd3Xw0p3PhV1HQiUcfaIiPBZHdohLHs9TCBGYrRLi7UcwOaAXdBHmhILX3PfWzsftral+vuItz0C0KmyBzAJG95I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706397344; c=relaxed/simple;
	bh=K7L7CD0IJ+gya762bSjg+oSMsu0YV7RQfE8CGWqjCb0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=A5HpeoALCeC3pGZ2zx+d1+RDGuKkSs5lixk0AZQQXw0JFfHX9dCU5izPkRDXQ+cOjWEtk0T6ic7LQC7GotaA4hBiboXmuDAL4KUfIaC1nPX2ROipH72wnUg4ypiADotatb/nvTHktEdyaMYdzZRyaQkn9/pOCg9MluYg8pWE914=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IqmaBciP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F243EC433F1;
	Sat, 27 Jan 2024 23:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706397344;
	bh=K7L7CD0IJ+gya762bSjg+oSMsu0YV7RQfE8CGWqjCb0=;
	h=Subject:To:Cc:From:Date:From;
	b=IqmaBciPFrMfsxLyOHm+IAS26jfBjTweibQ8ed5QYz50BAoR9NVOTq/+BCzJKlfVz
	 vrSS6qFX2jSJfatK1Kvpzj3cU8lPRS8SZVkMJnDuH5An/eyr2r1GqZhW1m6Yg5NVRb
	 FbrmZhlVIbnSbrQTEizDqsqFOd4kgUKJN6iC1axQ=
Subject: FAILED: patch "[PATCH] drm/amd/display: Clear OPTC mem select on disable" failed to apply to 6.1-stable tree
To: ilya.bakoulin@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,charlene.liu@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 15:15:43 -0800
Message-ID: <2024012743-upheld-scratch-4c23@gregkh>
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
git cherry-pick -x 3ba2a0bfd8cf94eb225e1c60dff16e5c35bde1da
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012743-upheld-scratch-4c23@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

3ba2a0bfd8cf ("drm/amd/display: Clear OPTC mem select on disable")
7bdbfb4e36e3 ("drm/amd/display: Disconnect phantom pipe OPP from OPTC being disabled")
e7b2b108cdea ("drm/amd/display: Fix hang/underflow when transitioning to ODM4:1")
3d0fe4945465 ("drm/amd/display: Refactor OPTC into component folder")
6c22fb07e0c2 ("drm/amd/display: Refactor DSC into component folder")
8b8eed05a1c6 ("drm/amd/display: Refactor resource into component directory")
e53524cdcc02 ("drm/amd/display: Refactor HWSS into component folder")
6e2c4941ce0c ("drm/amd/display: Move dml code under CONFIG_DRM_AMD_DC_FP guard")
45e7649fd191 ("drm/amd/display: Add DCN35 CORE")
1cb87e048975 ("drm/amd/display: Add DCN35 blocks to Makefile")
0fa45b6aeae4 ("drm/amd/display: Add DCN35 Resource")
ec129fa356be ("drm/amd/display: Add DCN35 init")
6f8b7565cca4 ("drm/amd/display: Add DCN35 HWSEQ")
327959a489d5 ("drm/amd/display: Add DCN35 DSC")
b9c96af677cb ("drm/amd/display: Add DCN35 OPTC")
b188069f788d ("drm/amd/display: add DCN301 specific logic for OTG programming")
0baae6246307 ("drm/amd/display: Refactor fast update to use new HWSS build sequence")
5b466b28fa94 ("drm/amd/display: Reorganize DCN30 Makefile")
d205a800a66e ("drm/amd/display: Add visual confirm color support for MCLK switch")
6ba5a269cdc9 ("drm/amd/display: Update vactive margin and max vblank for fpo + vactive")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3ba2a0bfd8cf94eb225e1c60dff16e5c35bde1da Mon Sep 17 00:00:00 2001
From: Ilya Bakoulin <ilya.bakoulin@amd.com>
Date: Wed, 3 Jan 2024 09:42:04 -0500
Subject: [PATCH] drm/amd/display: Clear OPTC mem select on disable

[Why]
Not clearing the memory select bits prior to OPTC disable can cause DSC
corruption issues when attempting to reuse a memory instance for another
OPTC that enables ODM.

[How]
Clear the memory select bits prior to disabling an OPTC.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ilya Bakoulin <ilya.bakoulin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
index 1788eb29474b..823493543325 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
@@ -173,6 +173,9 @@ static bool optc32_disable_crtc(struct timing_generator *optc)
 			OPTC_SEG3_SRC_SEL, 0xf,
 			OPTC_NUM_OF_INPUT_SEGMENT, 0);
 
+	REG_UPDATE(OPTC_MEMORY_CONFIG,
+			OPTC_MEM_SEL, 0);
+
 	/* disable otg request until end of the first line
 	 * in the vertical blank region
 	 */
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
index 3d6c1b2c2b4d..5b1547508850 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
@@ -145,6 +145,9 @@ static bool optc35_disable_crtc(struct timing_generator *optc)
 			OPTC_SEG3_SRC_SEL, 0xf,
 			OPTC_NUM_OF_INPUT_SEGMENT, 0);
 
+	REG_UPDATE(OPTC_MEMORY_CONFIG,
+			OPTC_MEM_SEL, 0);
+
 	/* disable otg request until end of the first line
 	 * in the vertical blank region
 	 */



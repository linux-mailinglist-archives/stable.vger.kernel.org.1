Return-Path: <stable+bounces-16210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFE083F1AD
	for <lists+stable@lfdr.de>; Sun, 28 Jan 2024 00:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9148A1F222C3
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD599200AD;
	Sat, 27 Jan 2024 23:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HgDk9ycL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D38C1B7E5
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 23:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706397343; cv=none; b=ClNT2hdoCoxZZWcv7LhbWHOV+TEfDkr7dXuHu29Eop58pLfA8SzExuUKyIL9+ZhGdqyEZnGoIXpkC/zBmeQCnuBCdS3WFQFt969Z2pH5vHHSY60hW81CVsYmU0czI+Mg+wUodADgHLqtWDjA1SAk6hJ6U1tVxszjilpjY+CDIrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706397343; c=relaxed/simple;
	bh=n/69pK/nuXC/Nfr0N1iEozlA0N8EVMboj+bFczYyjuU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Kmkb5kjd6UzQF8e2vDM5+FvAK3D3MrQLfEjeZSfbfju51y7L2icshB+czNB1WN1AtBSMU2LbhlgL3NyQ/zUwOXqq/iYMvr96wp8ajmORPlwdZJVmV90VYY+3/z2kk1h0QdBJvzNE+FGV0pPcscXjSGl7x1xaC7j5/uk5jKytZVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HgDk9ycL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC264C433F1;
	Sat, 27 Jan 2024 23:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706397343;
	bh=n/69pK/nuXC/Nfr0N1iEozlA0N8EVMboj+bFczYyjuU=;
	h=Subject:To:Cc:From:Date:From;
	b=HgDk9ycLdUIS7Xpawb2EfRtYShq4L6s8K/XTPpsPnJMuhOMeQyJDr0MAyX965cl4f
	 aXDjvYHb4PZCjuLTep/eRAj7lLt2042ZKivie5gN0I5B4zPMlDUe97aRFWielIB4Eb
	 o2A2wvCOUqxa7dxnyJVa2YK1SQ5eSz36Zhk7+Abk=
Subject: FAILED: patch "[PATCH] drm/amd/display: Clear OPTC mem select on disable" failed to apply to 6.6-stable tree
To: ilya.bakoulin@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,charlene.liu@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 15:15:42 -0800
Message-ID: <2024012742-critter-profanity-43af@gregkh>
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
git cherry-pick -x 3ba2a0bfd8cf94eb225e1c60dff16e5c35bde1da
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012742-critter-profanity-43af@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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



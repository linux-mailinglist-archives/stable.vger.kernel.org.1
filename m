Return-Path: <stable+bounces-66692-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 542EB94F0BF
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2072B233BB
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5F854724;
	Mon, 12 Aug 2024 14:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mdT1cPpk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22158153BF6
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474426; cv=none; b=r7RvX+abP4vO/BbbV08J49/wRwx5ruxZDS7yPIHa/cUx6D9NCvbcJ0wEHBgl5kfjcyO/8PPIe6fvNqR7VrBz4cRMecRyJHCIgbBaFyikKK2knAp8vt853S63OIFhIn7SX1VkuJXyQ/RuezHIobXJysi8/wEodA0X3+N9vprt0QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474426; c=relaxed/simple;
	bh=GchTE/pcM9K5cBx/GOqnQC2jrwV6DRjCLnR/G4XXIPY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=q3z6LoZDiocTnSTjOH28G4sNy9QWqqBmIjmrIQ+4141l/pdmJTS1FLfHC272O9/fS5DEA3umam5gDOnh+SuInIaxW5suJ7QGMAlAcGSKJsik20upqgNUlQ0oDW74RDPmamEa8uk/JoyPh2l0QGrXKagrypHC3QqOdR3laax4Ir0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mdT1cPpk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929CAC32782;
	Mon, 12 Aug 2024 14:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474426;
	bh=GchTE/pcM9K5cBx/GOqnQC2jrwV6DRjCLnR/G4XXIPY=;
	h=Subject:To:Cc:From:Date:From;
	b=mdT1cPpkqHf7kM2uCVVl8JDW41hOO5y23hHoRXfkPBMKdJzjEkg0HbHjX+QIRIQ4l
	 cE2R6gLHEe6vebWSaNxWUkwthK1LieE3LV3IrQflB1KXXbbiSkETxiiRAMe2ohRNXi
	 7HbBCvK4ESYVk8VfObbPvqOQyvKaBAmzSmqhyK1c=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix FEC_READY write on DP LT" failed to apply to 6.6-stable tree
To: ilya.bakoulin@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com,wayne.lin@amd.com,wenjing.liu@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:51:11 +0200
Message-ID: <2024081210-collie-staunch-198a@gregkh>
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
git cherry-pick -x a8baec4623aedf36d50767627f6eae5ebf07c6fb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081210-collie-staunch-198a@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

a8baec4623ae ("drm/amd/display: Fix FEC_READY write on DP LT")
a8ac994cf069 ("drm/amd/display: Disable error correction if it's not supported")

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



Return-Path: <stable+bounces-66690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7CE94F0BB
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43AE3280CE1
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C0F172773;
	Mon, 12 Aug 2024 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iDfsf+Nc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A744B4B5AE
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474419; cv=none; b=msOgQH/6q9X2sBK2fPCRh29S8+2gZovrEKKdi1jTrqkynhsSajnMv0jfnjExCqoQ7B+S6P9eiTSbn1RJTobS0z9Y0lo2SnGOexfZnZ6nAR4y3W2ffaEMT51IN/hkXmN5zfZ9/NU30qsyyUfJ6veK6NzLKpd6Skts6FKKbEZoPAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474419; c=relaxed/simple;
	bh=E4Rn0XWxzrkGwYQes6p44JY7lqTGxlrQ3+DkmcGF7+c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bQQpDLMlPX0W4SZPjIHiZetoGm0qpJNksYTlpZObJOVdj3/jeHFAuKnGTBWRvraPhoMYbgV84k9rP+kQGAb4PJOGVAmG6MnYBRADpTkjMOrtnrCIvQgOpLcdOQ/SamLN212vYKcHcsZhtYYf3MNkUV72IB1DMTWHk0EN7shWB/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iDfsf+Nc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA10AC32782;
	Mon, 12 Aug 2024 14:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474419;
	bh=E4Rn0XWxzrkGwYQes6p44JY7lqTGxlrQ3+DkmcGF7+c=;
	h=Subject:To:Cc:From:Date:From;
	b=iDfsf+NcNGumJTCTXqZxz2alOgPmllfH3WbCJWbs3hMlPthqm9+xJN/OW93SHIjAm
	 s0oI3BmhD//F4XnSNivb/LvJCVVfWPTtmMgqWeVaCr8WNvOTja/Uh8EoGJ7dse3ET6
	 1mzWTryZnu+W9QCvzW8gxAxAoinykW9nzkoFOBH8=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix FEC_READY write on DP LT" failed to apply to 6.10-stable tree
To: ilya.bakoulin@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com,wayne.lin@amd.com,wenjing.liu@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:51:10 +0200
Message-ID: <2024081210-crablike-harmonize-49e1@gregkh>
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
git cherry-pick -x a8baec4623aedf36d50767627f6eae5ebf07c6fb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081210-crablike-harmonize-49e1@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

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



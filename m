Return-Path: <stable+bounces-195343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C69C4C756A6
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 17:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AD46534CE8C
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 16:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742A236E57E;
	Thu, 20 Nov 2025 16:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UJKRQRsq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F7636E56F
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 16:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763656109; cv=none; b=TSr2hdF/Os6rfwhVaSK0ZajaFk17rUYE33PmcE3JwGmUEIsfqqZ7FpsB5NB0cHBvG+m8ROGeu7rwXdehAsOFTiabUkktqYvuM5hO91aFKJVGOUNL4RqoaJ9Ismhb5GQ1jpy7pwFGLVFzLsonZP04SxBYnQLwVJOf54K0jPqGQMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763656109; c=relaxed/simple;
	bh=6UXbLHVrPNknWW3mbNJweibc6oD02NVjDEGL2tPA+Cc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OG9DziKe7zjc/+OjYe5yLAftTRtF14E+M7EMKKTXuV0NrQ/HHb6tTug2ElnIUuTo1yC/wkSvn+XiSpQ+ofnZgXh0co4v7QVPJhIW5GWcFur40xFx5/db8EBWAoS3bElWcQ7HLvCM5e3Gj0ypgAaH1RQV3QM95defHYtbOtl4rTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UJKRQRsq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D9DC4CEF1;
	Thu, 20 Nov 2025 16:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763656108;
	bh=6UXbLHVrPNknWW3mbNJweibc6oD02NVjDEGL2tPA+Cc=;
	h=Subject:To:Cc:From:Date:From;
	b=UJKRQRsqGe66ms2o6OO1A81nVnlCg9VkKZyshlwIjTByuguDjrtDYun7Ktmbd63mq
	 j27uYV0qYfF7QHSMZtC/LPwz5nghHD/3s5YPd3WPKq0lSb5sPPMnq9POAzr8LeB3dp
	 CpWaGubsAS97qWbNdyqBFO2OAvgW3oeCi83bDDG8=
Subject: FAILED: patch "[PATCH] drm/i915/dp_mst: Disable Panel Replay" failed to apply to 6.12-stable tree
To: imre.deak@intel.com,animesh.manna@intel.com,jouni.hogander@intel.com,rodrigo.vivi@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Nov 2025 17:28:17 +0100
Message-ID: <2025112017-gigahertz-gravitate-93f3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x f2687d3cc9f905505d7b510c50970176115066a2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112017-gigahertz-gravitate-93f3@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f2687d3cc9f905505d7b510c50970176115066a2 Mon Sep 17 00:00:00 2001
From: Imre Deak <imre.deak@intel.com>
Date: Fri, 7 Nov 2025 14:41:41 +0200
Subject: [PATCH] drm/i915/dp_mst: Disable Panel Replay
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Disable Panel Replay on MST links until it's properly implemented. For
instance the required VSC SDP is not programmed on MST and FEC is not
enabled if Panel Replay is enabled.

Fixes: 3257e55d3ea7 ("drm/i915/panelreplay: enable/disable panel replay")
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/15174
Cc: Jouni Högander <jouni.hogander@intel.com>
Cc: Animesh Manna <animesh.manna@intel.com>
Cc: stable@vger.kernel.org # v6.8+
Reviewed-by: Jouni Högander <jouni.hogander@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Link: https://patch.msgid.link/20251107124141.911895-1-imre.deak@intel.com
(cherry picked from commit e109f644b871df8440c886a69cdce971ed533088)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index d5e0a1e66944..4619237f1346 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -585,6 +585,10 @@ static void _panel_replay_init_dpcd(struct intel_dp *intel_dp)
 	struct intel_display *display = to_intel_display(intel_dp);
 	int ret;
 
+	/* TODO: Enable Panel Replay on MST once it's properly implemented. */
+	if (intel_dp->mst_detect == DRM_DP_MST)
+		return;
+
 	ret = drm_dp_dpcd_read_data(&intel_dp->aux, DP_PANEL_REPLAY_CAP_SUPPORT,
 				    &intel_dp->pr_dpcd, sizeof(intel_dp->pr_dpcd));
 	if (ret < 0)



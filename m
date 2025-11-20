Return-Path: <stable+bounces-195342-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFCDC755B0
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 17:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id C89F82B2E0
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 16:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85033366579;
	Thu, 20 Nov 2025 16:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iY3QOvRs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414A63346B2
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 16:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763656100; cv=none; b=fnz/Gi6nR7JzxLHI5xli/jjuhvatRqoI/DCFqhhb9O4Poz0K+/4RTd3RKmkas6GZ/Ze4H6o4Dmlt9q5XiFBZNf9XQs5o+y0QoOri7NshjH0GuzONVREuluAqh9/301sp1bTTBBFBjg+XF6XwgWHmV3Xqflpue9dt39VAeK45mXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763656100; c=relaxed/simple;
	bh=Ce7/gBetXr/ud0gvmz1puauHaanVMXp/mcuH7gKKri4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XsgqRRjvaECAG5UizNyyNI7QLW7PmqlkZ3QkRKUesnV0mJN41j+qvAwY/aXacy3xZWyN/jT0kRjxdsdTrGkU1WRui4AdsN/BSjZCirlazdtI3P4WGww7ef2HgjfJ5JlZNpdkgAuHWoVye4ixG3Q+pwIJkU8+FyANWOsLsWd3VSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iY3QOvRs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15EAC4CEF1;
	Thu, 20 Nov 2025 16:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763656100;
	bh=Ce7/gBetXr/ud0gvmz1puauHaanVMXp/mcuH7gKKri4=;
	h=Subject:To:Cc:From:Date:From;
	b=iY3QOvRsg1BbHzyGwSxFfl2fyFae0rdA4nsOReR1oSAZzJzt2+8H0JnGBD8i2Mmm9
	 GjKbkfi3Pqo+KJZ1wDtPgm99rlvjBKa1Y6MRZ5zpRRUPcIIe0bamkax3vXnOVSRwH1
	 PaTrFLWXRSmS9354HRbyHZF4S6fcpE/mzsj45bd8=
Subject: FAILED: patch "[PATCH] drm/i915/dp_mst: Disable Panel Replay" failed to apply to 6.17-stable tree
To: imre.deak@intel.com,animesh.manna@intel.com,jouni.hogander@intel.com,rodrigo.vivi@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Nov 2025 17:28:17 +0100
Message-ID: <2025112017-voter-absentee-5ffd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.17-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.17.y
git checkout FETCH_HEAD
git cherry-pick -x f2687d3cc9f905505d7b510c50970176115066a2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112017-voter-absentee-5ffd@gregkh' --subject-prefix 'PATCH 6.17.y' HEAD^..

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



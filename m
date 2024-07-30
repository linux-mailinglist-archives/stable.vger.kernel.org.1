Return-Path: <stable+bounces-62706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA60B940DB3
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 11:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 092281C24674
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 09:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E2519EEB8;
	Tue, 30 Jul 2024 09:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bwIuXkvo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CA41990DA
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 09:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722331782; cv=none; b=VmlI6fz8Cu5GYWimC1/KO/Iy8YvzYbiscrPeZ0gBf+451St9SLZjapvODXrviZQZoc3KvCfWeqULmlc9HYz6YdoiBQkigtekNXPKSZi8EPZ7TzeL6Ei6QNNUaenvHiVbHrAN5K5LGBGwcXZWbnw73afH+WjaghkbKMZMf7TGYeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722331782; c=relaxed/simple;
	bh=Rv8WRShjjpcjB3iX/XcQaMcPkBd4xaUKJCycLiQglg8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pEXreDeqtbHOEpqt8ICEUiIjBqOBpiDZLiBI9BXRBnjKuZLQQ+b1LimDNZnDuAWWI63a+hC36la012vFzfn7OuYkICNh7TkltGcdUnajAo2cXYxPD+mhyHzZ6y5rcL2KUCblsXnzSxsjMUQgSlrPZJOqdlC5Z2XlqHYI2mo+MSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bwIuXkvo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31182C4AF0B;
	Tue, 30 Jul 2024 09:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722331781;
	bh=Rv8WRShjjpcjB3iX/XcQaMcPkBd4xaUKJCycLiQglg8=;
	h=Subject:To:Cc:From:Date:From;
	b=bwIuXkvo0SEXPFCjMwD5HvBa1c13Ox4YKi+mor8QE321TrNCmAf56P5ShgQKCj4Eo
	 x4sSftZ9/ylrCgHYF1rzGvkWQL4z0EXaxcttff4NiR/ZeWOqA7XGTROnxR/XX658R8
	 ZKGnjahnpXw6KHsTI9wrUI2aoDimxoc4DD1vWc98=
Subject: FAILED: patch "[PATCH] drm/mst: Fix NULL pointer dereference at" failed to apply to 6.10-stable tree
To: Wayne.Lin@amd.com,alexander.deucher@amd.com,harry.wentland@amd.com,jani.nikula@intel.com,leon.weiss@ruhr-uni-bochum.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 30 Jul 2024 11:29:38 +0200
Message-ID: <2024073038-affirm-rule-f9ea@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x 8a0a7b98d4b6eeeab337ec25daa4bc0a5e710a15
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024073038-affirm-rule-f9ea@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

8a0a7b98d4b6 ("drm/mst: Fix NULL pointer dereference at drm_dp_add_payload_part2")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8a0a7b98d4b6eeeab337ec25daa4bc0a5e710a15 Mon Sep 17 00:00:00 2001
From: Wayne Lin <Wayne.Lin@amd.com>
Date: Thu, 7 Mar 2024 14:29:57 +0800
Subject: [PATCH] drm/mst: Fix NULL pointer dereference at
 drm_dp_add_payload_part2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[Why]
Commit:
- commit 5aa1dfcdf0a4 ("drm/mst: Refactor the flow for payload allocation/removement")
accidently overwrite the commit
- commit 54d217406afe ("drm: use mgr->dev in drm_dbg_kms in drm_dp_add_payload_part2")
which cause regression.

[How]
Recover the original NULL fix and remove the unnecessary input parameter 'state' for
drm_dp_add_payload_part2().

Fixes: 5aa1dfcdf0a4 ("drm/mst: Refactor the flow for payload allocation/removement")
Reported-by: Leon Weiß <leon.weiss@ruhr-uni-bochum.de>
Link: https://lore.kernel.org/r/38c253ea42072cc825dc969ac4e6b9b600371cc8.camel@ruhr-uni-bochum.de/
Cc: lyude@redhat.com
Cc: imre.deak@intel.com
Cc: stable@vger.kernel.org
Cc: regressions@lists.linux.dev
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240307062957.2323620-1-Wayne.Lin@amd.com

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index c27063305a13..2c36f3d00ca2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -363,7 +363,7 @@ void dm_helpers_dp_mst_send_payload_allocation(
 	mst_state = to_drm_dp_mst_topology_state(mst_mgr->base.state);
 	new_payload = drm_atomic_get_mst_payload_state(mst_state, aconnector->mst_output_port);
 
-	ret = drm_dp_add_payload_part2(mst_mgr, mst_state->base.state, new_payload);
+	ret = drm_dp_add_payload_part2(mst_mgr, new_payload);
 
 	if (ret) {
 		amdgpu_dm_set_mst_status(&aconnector->mst_status,
diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index 3577786b5db2..7f8e1cfbe19d 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -3421,7 +3421,6 @@ EXPORT_SYMBOL(drm_dp_remove_payload_part2);
 /**
  * drm_dp_add_payload_part2() - Execute payload update part 2
  * @mgr: Manager to use.
- * @state: The global atomic state
  * @payload: The payload to update
  *
  * If @payload was successfully assigned a starting time slot by drm_dp_add_payload_part1(), this
@@ -3430,14 +3429,13 @@ EXPORT_SYMBOL(drm_dp_remove_payload_part2);
  * Returns: 0 on success, negative error code on failure.
  */
 int drm_dp_add_payload_part2(struct drm_dp_mst_topology_mgr *mgr,
-			     struct drm_atomic_state *state,
 			     struct drm_dp_mst_atomic_payload *payload)
 {
 	int ret = 0;
 
 	/* Skip failed payloads */
 	if (payload->payload_allocation_status != DRM_DP_MST_PAYLOAD_ALLOCATION_DFP) {
-		drm_dbg_kms(state->dev, "Part 1 of payload creation for %s failed, skipping part 2\n",
+		drm_dbg_kms(mgr->dev, "Part 1 of payload creation for %s failed, skipping part 2\n",
 			    payload->port->connector->name);
 		return -EIO;
 	}
diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
index c772ba19c547..715d2f59f565 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -1241,7 +1241,7 @@ static void intel_mst_enable_dp(struct intel_atomic_state *state,
 	if (first_mst_stream)
 		intel_ddi_wait_for_fec_status(encoder, pipe_config, true);
 
-	drm_dp_add_payload_part2(&intel_dp->mst_mgr, &state->base,
+	drm_dp_add_payload_part2(&intel_dp->mst_mgr,
 				 drm_atomic_get_mst_payload_state(mst_state, connector->port));
 
 	if (DISPLAY_VER(dev_priv) >= 12)
diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 0c3d88ad0b0e..88728a0b2c25 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -915,7 +915,7 @@ nv50_msto_cleanup(struct drm_atomic_state *state,
 		msto->disabled = false;
 		drm_dp_remove_payload_part2(mgr, new_mst_state, old_payload, new_payload);
 	} else if (msto->enabled) {
-		drm_dp_add_payload_part2(mgr, state, new_payload);
+		drm_dp_add_payload_part2(mgr, new_payload);
 		msto->enabled = false;
 	}
 }
diff --git a/include/drm/display/drm_dp_mst_helper.h b/include/drm/display/drm_dp_mst_helper.h
index 3546b58a121b..cfe096389d94 100644
--- a/include/drm/display/drm_dp_mst_helper.h
+++ b/include/drm/display/drm_dp_mst_helper.h
@@ -871,7 +871,6 @@ int drm_dp_add_payload_part1(struct drm_dp_mst_topology_mgr *mgr,
 			     struct drm_dp_mst_topology_state *mst_state,
 			     struct drm_dp_mst_atomic_payload *payload);
 int drm_dp_add_payload_part2(struct drm_dp_mst_topology_mgr *mgr,
-			     struct drm_atomic_state *state,
 			     struct drm_dp_mst_atomic_payload *payload);
 void drm_dp_remove_payload_part1(struct drm_dp_mst_topology_mgr *mgr,
 				 struct drm_dp_mst_topology_state *mst_state,



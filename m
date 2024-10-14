Return-Path: <stable+bounces-83776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 018B399C958
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 13:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0F4C1F22B22
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 11:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107D719E806;
	Mon, 14 Oct 2024 11:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sE85tYq+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C438B19DF7A
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 11:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728906611; cv=none; b=c/G0SevFaBzWJ6ej8DclF40oJ0b2FPu9wF8HQ1tcuDcmnpZGjgP4hIIH/gGl+8Ha7yGl8rHnCuJh3ZCa8H+XL4JAFueXqFKFtyaSWm60wPVY2BglLYnvFNa0IqiACBt4Ddyvi9CYgkMI8JoLwPYk2eWMXlZWsIsDjt/D6dpxbh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728906611; c=relaxed/simple;
	bh=zJBzp5QVtVVz2rJvq+2i8il2ZmKM8rxl5X+AgYlPquY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pqOTPLalym7/55HAyCO/BVDEBBYjx7rtG0KAtBsfYjf4M/wCWqqOWCYIkim4D3sWM43iMYLFYLHgojCYoiTNz6YcTmIjxUsCJq/fpZ2FT7XKX3tfSBWLdJBDfwwiCpQjn6ZqS1HtbUzc/fwz15mAqz21yp9eSoqDJ5ZGyHXIfCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sE85tYq+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89BBC4CEC3;
	Mon, 14 Oct 2024 11:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728906611;
	bh=zJBzp5QVtVVz2rJvq+2i8il2ZmKM8rxl5X+AgYlPquY=;
	h=Subject:To:Cc:From:Date:From;
	b=sE85tYq+ocgNRDUc2B13BE40A/pxgaTQ4Bs76nipLPAPwzluo/yQPYYEfADUve9wa
	 wq9143vo1+mg7XGLmZjbK5y20tXwh3sJQQ/apGIa9TK9gftdXjIsVMRn4JwMmpCBtG
	 hUCuQya19h2NgMslw0/Dm826JG1RC5l+BNGelavQ=
Subject: FAILED: patch "[PATCH] drm/i915/hdcp: fix connector refcounting" failed to apply to 5.10-stable tree
To: jani.nikula@intel.com,joonas.lahtinen@linux.intel.com,seanpaul@chromium.org,suraj.kandpal@intel.com,ville.syrjala@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 14 Oct 2024 13:46:06 +0200
Message-ID: <2024101406-gallows-construct-02e9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 4cc2718f621a6a57a02581125bb6d914ce74d23b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024101406-gallows-construct-02e9@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

4cc2718f621a ("drm/i915/hdcp: fix connector refcounting")
848a4e5c096d ("drm/i915: add a dedicated workqueue inside drm_i915_private")
f48eab290287 ("drm/i915/dp: Add link training debug and error printing helpers")
f60500f31e99 ("drm/i915/display/dp: 128/132b LT requirement")
40053823baad ("drm/i915/display: move modeset probe/remove functions to intel_display_driver.c")
15e4f0b541d4 ("drm/i915/display: rename intel_modeset_probe_defer() -> intel_display_driver_probe_defer()")
ff2c80be1a00 ("drm/i915/display: move intel_modeset_probe_defer() to intel_display_driver.[ch]")
77316e755213 ("drm/i915/display: start high level display driver file")
99cfbed19d06 ("drm/i915/vrr: Relocate VRR enable/disable")
ecaeecea9263 ("drm/i915/vrr: Tell intel_crtc_update_active_timings() about VRR explicitly")
fa9e4fce52ec ("drm/i915/vrr: Make delayed vblank operational in VRR mode on adl/dg2")
b25e07419fee ("drm/i915/vrr: Eliminate redundant function arguments")
6a9856075563 ("drm/i915: Generalize planes_{enabling,disabling}()")
c5de248484af ("drm/i915/dpt: Add a modparam to disable DPT via the chicken bit")
5a08585d38d6 ("drm/i915: Add PLANE_CHICKEN registers")
1a324a40b452 ("i915/display/dp: SDP CRC16 for 128b132b link layer")
b5202a93cd37 ("drm/i915: Extract intel_crtc_scanline_offset()")
84f4ebe8c1ab ("drm/i915: Relocate intel_crtc_update_active_timings()")
6e8acb6686d8 ("drm/i915: Add belts and suspenders locking for seamless M/N changes")
8cb1f95cca68 ("drm/i915: Update vblank timestamping stuff on seamless M/N change")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4cc2718f621a6a57a02581125bb6d914ce74d23b Mon Sep 17 00:00:00 2001
From: Jani Nikula <jani.nikula@intel.com>
Date: Tue, 24 Sep 2024 18:30:22 +0300
Subject: [PATCH] drm/i915/hdcp: fix connector refcounting
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We acquire a connector reference before scheduling an HDCP prop work,
and expect the work function to release the reference.

However, if the work was already queued, it won't be queued multiple
times, and the reference is not dropped.

Release the reference immediately if the work was already queued.

Fixes: a6597faa2d59 ("drm/i915: Protect workers against disappearing connectors")
Cc: Sean Paul <seanpaul@chromium.org>
Cc: Suraj Kandpal <suraj.kandpal@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: stable@vger.kernel.org # v5.10+
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240924153022.2255299-1-jani.nikula@intel.com
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
(cherry picked from commit abc0742c79bdb3b164eacab24aea0916d2ec1cb5)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>

diff --git a/drivers/gpu/drm/i915/display/intel_hdcp.c b/drivers/gpu/drm/i915/display/intel_hdcp.c
index 6980b98792c2..377939de0ff4 100644
--- a/drivers/gpu/drm/i915/display/intel_hdcp.c
+++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
@@ -1094,7 +1094,8 @@ static void intel_hdcp_update_value(struct intel_connector *connector,
 	hdcp->value = value;
 	if (update_property) {
 		drm_connector_get(&connector->base);
-		queue_work(i915->unordered_wq, &hdcp->prop_work);
+		if (!queue_work(i915->unordered_wq, &hdcp->prop_work))
+			drm_connector_put(&connector->base);
 	}
 }
 
@@ -2524,7 +2525,8 @@ void intel_hdcp_update_pipe(struct intel_atomic_state *state,
 		mutex_lock(&hdcp->mutex);
 		hdcp->value = DRM_MODE_CONTENT_PROTECTION_DESIRED;
 		drm_connector_get(&connector->base);
-		queue_work(i915->unordered_wq, &hdcp->prop_work);
+		if (!queue_work(i915->unordered_wq, &hdcp->prop_work))
+			drm_connector_put(&connector->base);
 		mutex_unlock(&hdcp->mutex);
 	}
 
@@ -2541,7 +2543,9 @@ void intel_hdcp_update_pipe(struct intel_atomic_state *state,
 		 */
 		if (!desired_and_not_enabled && !content_protection_type_changed) {
 			drm_connector_get(&connector->base);
-			queue_work(i915->unordered_wq, &hdcp->prop_work);
+			if (!queue_work(i915->unordered_wq, &hdcp->prop_work))
+				drm_connector_put(&connector->base);
+
 		}
 	}
 



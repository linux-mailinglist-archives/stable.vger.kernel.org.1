Return-Path: <stable+bounces-119186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09475A42552
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 16:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8811D4269EF
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 14:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA8124EF83;
	Mon, 24 Feb 2025 14:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RThNnz5n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674F817BEC6;
	Mon, 24 Feb 2025 14:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408613; cv=none; b=DoX/lR+iVuimwOKZtX8iwNw+K4BUJVx9O0c4+QKWVb5tUzKb9CgL40BP2/1jcfvKcFboiRFDj2BffieJGZntuXnz7Sk5ybPnHu2Sy7kEEZY6TZWbE17lvtqOGspVHXVa+ikA3m9brNbTFaeHlmytsNMilFoRFQbYn7c5bO8o8jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408613; c=relaxed/simple;
	bh=3+56lIqfSdLKp1GXEl4pLrT4bJWNB5a4VocxEoAc5dM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ayC37H7Ka/7f6jO2/O5F1GnlsirwjCZqMsiLZ9y+Aa7EPLdThg4eJtXHmyfBvZOWcSyn9yv7Urd2FvOMjWhgApyQMYOK+B2mjQNlQIcYT0AWHtVo8EDvEH2M2y0q9ycE2sSWyoq4RAWwDeAgfPmNsHJjU8PbtNcXRD7GnZ8VJYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RThNnz5n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56B7C4CED6;
	Mon, 24 Feb 2025 14:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740408613;
	bh=3+56lIqfSdLKp1GXEl4pLrT4bJWNB5a4VocxEoAc5dM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RThNnz5nbMNgDl0QhiWfOziCNBKOS9qasphcNJwTORtDCllwPDWPsY5LzAVG1Nxo1
	 aAtncbvYfNCqKduZAdCobEsi58nlQqx/8o+tos5JN7GtOsZpBClwyFB0Kc0Lke00VC
	 pu+75HFIF6iZqeWCwPPP3dVYPRtPKwhb8HoCWWVU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 6.12 108/154] drm/i915: Make sure all planes in use by the joiner have their crtc included
Date: Mon, 24 Feb 2025 15:35:07 +0100
Message-ID: <20250224142611.285630022@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224142607.058226288@linuxfoundation.org>
References: <20250224142607.058226288@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit 07fb70d82e0df085980246bf17bc12537588795f upstream.

Any active plane needs to have its crtc included in the atomic
state. For planes enabled via uapi that is all handler in the core.
But when we use a plane for joiner the uapi code things the plane
is disabled and therefore doesn't have a crtc. So we need to pull
those in by hand. We do it first thing in
intel_joiner_add_affected_crtcs() so that any newly added crtc will
subsequently pull in all of its joined crtcs as well.

The symptoms from failing to do this are:
- duct tape in the form of commit 1d5b09f8daf8 ("drm/i915: Fix NULL
  ptr deref by checking new_crtc_state")
- the plane's hw state will get overwritten by the disabled
  uapi state if it can't find the uapi counterpart plane in
  the atomic state from where it should copy the correct state

Cc: stable@vger.kernel.org
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250212164330.16891-2-ville.syrjala@linux.intel.com
(cherry picked from commit 91077d1deb5374eb8be00fb391710f00e751dc4b)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/display/intel_display.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -6369,12 +6369,30 @@ static int intel_async_flip_check_hw(str
 static int intel_joiner_add_affected_crtcs(struct intel_atomic_state *state)
 {
 	struct drm_i915_private *i915 = to_i915(state->base.dev);
+	const struct intel_plane_state *plane_state;
 	struct intel_crtc_state *crtc_state;
+	struct intel_plane *plane;
 	struct intel_crtc *crtc;
 	u8 affected_pipes = 0;
 	u8 modeset_pipes = 0;
 	int i;
 
+	/*
+	 * Any plane which is in use by the joiner needs its crtc.
+	 * Pull those in first as this will not have happened yet
+	 * if the plane remains disabled according to uapi.
+	 */
+	for_each_new_intel_plane_in_state(state, plane, plane_state, i) {
+		crtc = to_intel_crtc(plane_state->hw.crtc);
+		if (!crtc)
+			continue;
+
+		crtc_state = intel_atomic_get_crtc_state(&state->base, crtc);
+		if (IS_ERR(crtc_state))
+			return PTR_ERR(crtc_state);
+	}
+
+	/* Now pull in all joined crtcs */
 	for_each_new_intel_crtc_in_state(state, crtc, crtc_state, i) {
 		affected_pipes |= crtc_state->joiner_pipes;
 		if (intel_crtc_needs_modeset(crtc_state))




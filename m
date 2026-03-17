Return-Path: <stable+bounces-225910-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OucJUJOuWnj/wEAu9opvQ
	(envelope-from <stable+bounces-225910-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:51:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E2B2AA21A
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 293EC3061164
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5E4372B2B;
	Tue, 17 Mar 2026 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gQahF/po"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F8F3644C6
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773751861; cv=none; b=Bt/qyxHMobT3GT5/zm6KGN4+rXyb1X2MNyR1rzj17G/Iz5twEcpdtZejmagPHOs0dvDGKpVqnjuUIzKcQEzLfnX1tGbWhj5JY+KHbMrfkau3aXvxYTWYbdFuJqI1xet+FStGWwR39iKJhzQRgRGR9cfMZ+yv9Wdbek8Q+lA/Sd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773751861; c=relaxed/simple;
	bh=DxVU8hYhcVI6JsvhsHlAjBznzbViZ91Ar4Y/zVGF6ho=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IPIOH3JeoIHxRTsMYbGeHZPCUKmursow+wSP4mLlmtDult6gAqw6KxmxNfq15oZuFkt/3faqmzqBQH/ZcLtvt6JbF26u6Vsfw3M0DCFBUtV2CIP4nspRhdifFiP54JYceDdqO2acE/U/70F1HGIJiwPEbI5vSUzsX8ckK7bhvKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gQahF/po; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0681C4CEF7;
	Tue, 17 Mar 2026 12:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773751861;
	bh=DxVU8hYhcVI6JsvhsHlAjBznzbViZ91Ar4Y/zVGF6ho=;
	h=Subject:To:Cc:From:Date:From;
	b=gQahF/poNuyENpDzCu99i1jDr4xWwhujjwkV8jJpRfqAdUsiOhCrG97QlTAwgyzI3
	 drsYMvgUGnvEZmWwj+DlealEhIaBOJrepbY0UMrxTe+7wjGKZskIZpEY0jM/6BbhNe
	 3VP1mlby+9AYe73c/XMHoXQqad0K6IqZDei6X3zE=
Subject: FAILED: patch "[PATCH] drm/i915/psr: Repeat Selective Update area alignment" failed to apply to 6.12-stable tree
To: jouni.hogander@intel.com,ankit.k.nautiyal@intel.com,stable@vger.kernel.org,tursulin@ursulin.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 13:50:57 +0100
Message-ID: <2026031757-reflux-strongman-61ef@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225910-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email,ursulin.net:email]
X-Rspamd-Queue-Id: 15E2B2AA21A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 1be2fca84f520105413d0d89ed04bb0ff742ab16
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031757-reflux-strongman-61ef@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1be2fca84f520105413d0d89ed04bb0ff742ab16 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
Date: Wed, 4 Mar 2026 13:30:08 +0200
Subject: [PATCH] drm/i915/psr: Repeat Selective Update area alignment
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently we are aligning Selective Update area to cover cursor fully if
needed only once. It may happen that cursor is in Selective Update area
after pipe alignment and after that covering cursor plane only
partially. Fix this by looping alignment as long as alignment isn't needed
anymore.

v2:
  - do not unecessarily loop if cursor was already fully covered
  - rename aligned as su_area_changed

Fixes: 1bff93b8bc27 ("drm/i915/psr: Extend SU area to cover cursor fully if needed")
Cc: <stable@vger.kernel.org> # v6.9+
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
Reviewed-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Link: https://patch.msgid.link/20260304113011.626542-2-jouni.hogander@intel.com
(cherry picked from commit 681e12440d8b110350a5709101169f319e10ccbb)
Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 4ce1173a2e91..3848cd4fba0e 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -2689,11 +2689,12 @@ static void clip_area_update(struct drm_rect *overlap_damage_area,
 		overlap_damage_area->y2 = damage_area->y2;
 }
 
-static void intel_psr2_sel_fetch_pipe_alignment(struct intel_crtc_state *crtc_state)
+static bool intel_psr2_sel_fetch_pipe_alignment(struct intel_crtc_state *crtc_state)
 {
 	struct intel_display *display = to_intel_display(crtc_state);
 	const struct drm_dsc_config *vdsc_cfg = &crtc_state->dsc.config;
 	u16 y_alignment;
+	bool su_area_changed = false;
 
 	/* ADLP aligns the SU region to vdsc slice height in case dsc is enabled */
 	if (crtc_state->dsc.compression_enable &&
@@ -2702,10 +2703,18 @@ static void intel_psr2_sel_fetch_pipe_alignment(struct intel_crtc_state *crtc_st
 	else
 		y_alignment = crtc_state->su_y_granularity;
 
-	crtc_state->psr2_su_area.y1 -= crtc_state->psr2_su_area.y1 % y_alignment;
-	if (crtc_state->psr2_su_area.y2 % y_alignment)
+	if (crtc_state->psr2_su_area.y1 % y_alignment) {
+		crtc_state->psr2_su_area.y1 -= crtc_state->psr2_su_area.y1 % y_alignment;
+		su_area_changed = true;
+	}
+
+	if (crtc_state->psr2_su_area.y2 % y_alignment) {
 		crtc_state->psr2_su_area.y2 = ((crtc_state->psr2_su_area.y2 /
 						y_alignment) + 1) * y_alignment;
+		su_area_changed = true;
+	}
+
+	return su_area_changed;
 }
 
 /*
@@ -2839,7 +2848,7 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 	struct intel_crtc_state *crtc_state = intel_atomic_get_new_crtc_state(state, crtc);
 	struct intel_plane_state *new_plane_state, *old_plane_state;
 	struct intel_plane *plane;
-	bool full_update = false, cursor_in_su_area = false;
+	bool full_update = false, su_area_changed;
 	int i, ret;
 
 	if (!crtc_state->enable_psr2_sel_fetch)
@@ -2946,15 +2955,32 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 	if (ret)
 		return ret;
 
-	/*
-	 * Adjust su area to cover cursor fully as necessary (early
-	 * transport). This needs to be done after
-	 * drm_atomic_add_affected_planes to ensure visible cursor is added into
-	 * affected planes even when cursor is not updated by itself.
-	 */
-	intel_psr2_sel_fetch_et_alignment(state, crtc, &cursor_in_su_area);
+	do {
+		bool cursor_in_su_area;
 
-	intel_psr2_sel_fetch_pipe_alignment(crtc_state);
+		/*
+		 * Adjust su area to cover cursor fully as necessary
+		 * (early transport). This needs to be done after
+		 * drm_atomic_add_affected_planes to ensure visible
+		 * cursor is added into affected planes even when
+		 * cursor is not updated by itself.
+		 */
+		intel_psr2_sel_fetch_et_alignment(state, crtc, &cursor_in_su_area);
+
+		su_area_changed = intel_psr2_sel_fetch_pipe_alignment(crtc_state);
+
+		/*
+		 * If the cursor was outside the SU area before
+		 * alignment, the alignment step (which only expands
+		 * SU) may pull the cursor partially inside, so we
+		 * must run ET alignment again to fully cover it. But
+		 * if the cursor was already fully inside before
+		 * alignment, expanding the SU area won't change that,
+		 * so no further work is needed.
+		 */
+		if (cursor_in_su_area)
+			break;
+	} while (su_area_changed);
 
 	/*
 	 * Now that we have the pipe damaged area check if it intersect with



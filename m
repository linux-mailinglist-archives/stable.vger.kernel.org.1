Return-Path: <stable+bounces-8977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07ECA8205AF
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 13:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39C5B1C21151
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 12:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76036849C;
	Sat, 30 Dec 2023 12:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sVD1lttf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400C579DC;
	Sat, 30 Dec 2023 12:10:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE24C433C7;
	Sat, 30 Dec 2023 12:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703938254;
	bh=2voai+wTGMDdfQZNJ+vS5HmdObP0Mq9vXuAE8Ovh1Bo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sVD1lttfYVTVyIErlBpNjEICw50036Bdyc+u7HULdiXknKc6imgBvO392DO3IMLHy
	 ea8+MsiTS6x737yVOASc7qy4nYtLfVQBZ6XDD7/Wxn7h1pemAPxe2PzxVcNXFj4AjE
	 Syljq/fWetJkUJ9XZvK//bJYzJsqM/zSzqcrlSE0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
	Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 6.1 086/112] drm/i915: Reject async flips with bigjoiner
Date: Sat, 30 Dec 2023 11:59:59 +0000
Message-ID: <20231230115809.550116533@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231230115806.714618407@linuxfoundation.org>
References: <20231230115806.714618407@linuxfoundation.org>
User-Agent: quilt/0.67
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit 88a173e5dd05e788068e8fa20a8c37c44bd8f416 upstream.

Currently async flips are busted when bigjoiner is in use.
As a short term fix simply reject async flips in that case.

Cc: stable@vger.kernel.org
Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/9769
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231211081134.2698-1-ville.syrjala@linux.intel.com
Reviewed-by: Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>
(cherry picked from commit e93bffc2ac0a833b42841f31fff955549d38ce98)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/display/intel_display.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -6481,6 +6481,17 @@ static int intel_async_flip_check_uapi(s
 		return -EINVAL;
 	}
 
+	/*
+	 * FIXME: Bigjoiner+async flip is busted currently.
+	 * Remove this check once the issues are fixed.
+	 */
+	if (new_crtc_state->bigjoiner_pipes) {
+		drm_dbg_kms(&i915->drm,
+			    "[CRTC:%d:%s] async flip disallowed with bigjoiner\n",
+			    crtc->base.base.id, crtc->base.name);
+		return -EINVAL;
+	}
+
 	for_each_oldnew_intel_plane_in_state(state, plane, old_plane_state,
 					     new_plane_state, i) {
 		if (plane->pipe != crtc->pipe)




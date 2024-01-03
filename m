Return-Path: <stable+bounces-9434-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BBF823257
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 18:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 819B52856B0
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 17:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261431C280;
	Wed,  3 Jan 2024 17:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mm13H5SN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E931BDDE;
	Wed,  3 Jan 2024 17:05:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49406C433C8;
	Wed,  3 Jan 2024 17:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704301545;
	bh=F7eqM7hgB17WpgkL69T0wi/0/PtbIpLTuulGpW36bzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mm13H5SNxZKbSGh3WBLCQKxSgzVprBh5QTitBMevG8JOFFnupiLXTfd8g8ohO2DNu
	 VTjgzEDZbrBZOlEPJKqFdVSTPtlTVt9lcLUbBl7NYUNzuemPO4Q8W15TVfJaAme8L9
	 rPUUPyKkDZPq8vAeVo63ADGrTs7G3dw1Mw0k49TM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 32/95] drm/i915: Fix intel_atomic_setup_scalers() plane_state handling
Date: Wed,  3 Jan 2024 17:54:40 +0100
Message-ID: <20240103164858.889896562@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103164853.921194838@linuxfoundation.org>
References: <20240103164853.921194838@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

[ Upstream commit c3070f080f9ba18dea92eaa21730f7ab85b5c8f4 ]

Since the plane_state variable is declared outside the scaler_users
loop in intel_atomic_setup_scalers(), and it's never reset back to
NULL inside the loop we may end up calling intel_atomic_setup_scaler()
with a non-NULL plane state for the pipe scaling case. That is bad
because intel_atomic_setup_scaler() determines whether we are doing
plane scaling or pipe scaling based on plane_state!=NULL. The end
result is that we may miscalculate the scaler mode for pipe scaling.

The hardware becomes somewhat upset if we end up in this situation
when scanning out a planar format on a SDR plane. We end up
programming the pipe scaler into planar mode as well, and the
result is a screenfull of garbage.

Fix the situation by making sure we pass the correct plane_state==NULL
when calculating the scaler mode for pipe scaling.

Cc: stable@vger.kernel.org
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231207193441.20206-2-ville.syrjala@linux.intel.com
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
(cherry picked from commit e81144106e21271c619f0c722a09e27ccb8c043d)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/skl_scaler.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/skl_scaler.c b/drivers/gpu/drm/i915/display/skl_scaler.c
index a9cc5cfad0bd2..e55df2f05cbd5 100644
--- a/drivers/gpu/drm/i915/display/skl_scaler.c
+++ b/drivers/gpu/drm/i915/display/skl_scaler.c
@@ -450,7 +450,6 @@ int intel_atomic_setup_scalers(struct drm_i915_private *dev_priv,
 {
 	struct drm_plane *plane = NULL;
 	struct intel_plane *intel_plane;
-	struct intel_plane_state *plane_state = NULL;
 	struct intel_crtc_scaler_state *scaler_state =
 		&crtc_state->scaler_state;
 	struct drm_atomic_state *drm_state = crtc_state->uapi.state;
@@ -482,6 +481,7 @@ int intel_atomic_setup_scalers(struct drm_i915_private *dev_priv,
 
 	/* walkthrough scaler_users bits and start assigning scalers */
 	for (i = 0; i < sizeof(scaler_state->scaler_users) * 8; i++) {
+		struct intel_plane_state *plane_state = NULL;
 		int *scaler_id;
 		const char *name;
 		int idx, ret;
-- 
2.43.0





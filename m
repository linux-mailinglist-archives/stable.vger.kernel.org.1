Return-Path: <stable+bounces-165117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3CCB152D9
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 20:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF8D63A5C3A
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 18:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B4C16A94A;
	Tue, 29 Jul 2025 18:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCn0v9gb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4184A186A
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 18:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753813849; cv=none; b=STw6eDRhdopyZKVtOrMHtyvMMs7quplzXR5OPgWEO3tgt8XzdYOYhk1b2ogkacaY0ta2tgBTnhVQD3SA0QPlPqUBPDHpL5kMe+5lrmBdlbxDgnR60q8ek0V5kNuJGGqX9qgEjbWdLbKKk0v5t5s68isVuoYctal23yL0NR8d21w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753813849; c=relaxed/simple;
	bh=ksPRCqNlXNiPCJCObes7go+21tLQ9R7Mxo9EoKcO9e0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QO/oyGE+yPRMiGxZRJE5TnCit0BCQR6ziG0Vf9pvPsbrxq3vmXksFO7OqH/Ex0vaQ7vsXmQYlFjd7O60iqT6H04RZt4b85RkN622aS+N5fluc8OMzn0m1sc4t7i/pW30Qn7IxTd82KDSJPOI06L+fQlwpA6Oxi4FPvRaYXSu9DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCn0v9gb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED6FC4CEF6;
	Tue, 29 Jul 2025 18:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753813848;
	bh=ksPRCqNlXNiPCJCObes7go+21tLQ9R7Mxo9EoKcO9e0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aCn0v9gbAONRtTWeGWjzvYOmOUPG6HakybZVDlNli07+soSOHbr4318CCTiAbMf42
	 Ak86WhPCviOyJ9kKilD9yj1X76HD2ndGflRN0HNiTMAvu5iWK5Ak9i4RHWANFNRl2P
	 emssZiwg/2o5W6CPidvNLomWQyXR9gNcjV1hF0EmneI+0lKKFm7Zb/+3w4Hcic1kTr
	 3Po1984xM7FL5MWgQGwZ9BL+45BENPSohjOgMX7tVGx1mhwctjadN5Dmnw+IU0ZUI5
	 YSxukm7fx2Ovx5QLvpF4OC8hSseBYZ1WPS1RTaZRvyqAW9X94ItUNd1Er5sg3GigfO
	 /4w5kMfGzvT6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Imre Deak <imre.deak@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] drm/i915/dp: Fix 2.7 Gbps DP_LINK_BW value on g4x
Date: Tue, 29 Jul 2025 14:30:45 -0400
Message-Id: <20250729183045.2854937-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072852-brewing-moonrise-04ac@gregkh>
References: <2025072852-brewing-moonrise-04ac@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

[ Upstream commit 9e0c433d0c05fde284025264b89eaa4ad59f0a3e ]

On g4x we currently use the 96MHz non-SSC refclk, which can't actually
generate an exact 2.7 Gbps link rate. In practice we end up with 2.688
Gbps which seems to be close enough to actually work, but link training
is currently failing due to miscalculating the DP_LINK_BW value (we
calcualte it directly from port_clock which reflects the actual PLL
outpout frequency).

Ideas how to fix this:
- nudge port_clock back up to 270000 during PLL computation/readout
- track port_clock and the nominal link rate separately so they might
  differ a bit
- switch to the 100MHz refclk, but that one should be SSC so perhaps
  not something we want

While we ponder about a better solution apply some band aid to the
immediate issue of miscalculated DP_LINK_BW value. With this
I can again use 2.7 Gbps link rate on g4x.

Cc: stable@vger.kernel.org
Fixes: 665a7b04092c ("drm/i915: Feed the DPLL output freq back into crtc_state")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250710201718.25310-2-ville.syrjala@linux.intel.com
Reviewed-by: Imre Deak <imre.deak@intel.com>
(cherry picked from commit a8b874694db5cae7baaf522756f87acd956e6e66)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
[ changed display->platform.g4x to IS_G4X(i915) ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 3f65d890b8a9..9120e367a913 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -1139,6 +1139,12 @@ int intel_dp_rate_select(struct intel_dp *intel_dp, int rate)
 void intel_dp_compute_rate(struct intel_dp *intel_dp, int port_clock,
 			   u8 *link_bw, u8 *rate_select)
 {
+	struct drm_i915_private *i915 = dp_to_i915(intel_dp);
+
+	/* FIXME g4x can't generate an exact 2.7GHz with the 96MHz non-SSC refclk */
+	if (IS_G4X(i915) && port_clock == 268800)
+		port_clock = 270000;
+
 	/* eDP 1.4 rate select method. */
 	if (intel_dp->use_rate_select) {
 		*link_bw = 0;
-- 
2.39.5



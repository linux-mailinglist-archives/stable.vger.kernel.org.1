Return-Path: <stable+bounces-128021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D15C7A7AE35
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A78791890239
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653311FE471;
	Thu,  3 Apr 2025 19:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIWMJaAT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA14C1FECB8;
	Thu,  3 Apr 2025 19:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707780; cv=none; b=L1MGgMcp2gN+wh3zDHgtHYc1bhI+itrOupu7tiIjBB3BhylKilxcWrrCopo/87UeC7ea/OLwijW3005CZoVZTmCVAl8htZeJdKY3sUFkWzW82feqdbG3az+phWALWkXdJJZoLV0/c16bGUjPtd523ulAWW2V8wggnQLuTBUpAmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707780; c=relaxed/simple;
	bh=6DawYNWvJ6dNBYweojLU9iinP7E66eH6Pv3SICYLtsI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=soSOq6BFuNsQ7l3XHfEsLO72zd7M4ghL2wYmCf7weDVSt0Bl/WtisFHOGiIyKwx6yPdYFLkkJGHH/qAYbKPTIPG+QCc54H5AHYHUrggn6XlQ476xYURP6e3FlKCJm+7WhsaFQ9TIzY3DN8Nf+f/E/BEKtcBYUXE8gK5RMRFB7fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIWMJaAT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B185C4CEE9;
	Thu,  3 Apr 2025 19:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707779;
	bh=6DawYNWvJ6dNBYweojLU9iinP7E66eH6Pv3SICYLtsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KIWMJaAT9gcA5W5VBQTbbQBMy6YhGxgZ9Eabcw6wIzcHA86Sic2fhUCpiECPjZ6wy
	 CwG9ng5EkWsr1XlEbI5A3rEV6gA0TpxDFaedLHhhBwfuCpFuAtG7C8e+J9SPtFF9Nl
	 QAVhiBbI0q0nkjolE+5ZA/wxELSctqS/N7S2pd94celNwfkb9/oy63WyhT9WON2oRS
	 +CPuoiHl/MDMPN44ngorNQCPscEnNTJ81ag1vPEeOYR6fo3gGrn4PhzDlk7ePXJ5mY
	 0u4PzF80ZR463xq9Uor43nInMo1GJ+23y6wVSjt0zak8JmQOi54vkCYP3W80Gx+jV4
	 cP7PvZyAkRUxQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Gustavo Sousa <gustavo.sousa@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.13 22/37] drm/xe/xelp: Move Wa_16011163337 from tunings to workarounds
Date: Thu,  3 Apr 2025 15:14:58 -0400
Message-Id: <20250403191513.2680235-22-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191513.2680235-1-sashal@kernel.org>
References: <20250403191513.2680235-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
Content-Transfer-Encoding: 8bit

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

[ Upstream commit d9b5d83c5a4d720af6ddbefe2825c78f0325a3fd ]

Workaround database specifies 16011163337 as a workaround so lets move it
there.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: Gustavo Sousa <gustavo.sousa@intel.com>
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250227101304.46660-3-tvrtko.ursulin@igalia.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_tuning.c | 8 --------
 drivers/gpu/drm/xe/xe_wa.c     | 7 +++++++
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_tuning.c b/drivers/gpu/drm/xe/xe_tuning.c
index d449de0fb6ecb..3c78f3d715591 100644
--- a/drivers/gpu/drm/xe/xe_tuning.c
+++ b/drivers/gpu/drm/xe/xe_tuning.c
@@ -97,14 +97,6 @@ static const struct xe_rtp_entry_sr engine_tunings[] = {
 };
 
 static const struct xe_rtp_entry_sr lrc_tunings[] = {
-	{ XE_RTP_NAME("Tuning: ganged timer, also known as 16011163337"),
-	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(1200, 1210), ENGINE_CLASS(RENDER)),
-	  /* read verification is ignored due to 1608008084. */
-	  XE_RTP_ACTIONS(FIELD_SET_NO_READ_MASK(FF_MODE2,
-						FF_MODE2_GS_TIMER_MASK,
-						FF_MODE2_GS_TIMER_224))
-	},
-
 	/* DG2 */
 
 	{ XE_RTP_NAME("Tuning: L3 cache"),
diff --git a/drivers/gpu/drm/xe/xe_wa.c b/drivers/gpu/drm/xe/xe_wa.c
index 02cf647f86d8e..da15af8093cae 100644
--- a/drivers/gpu/drm/xe/xe_wa.c
+++ b/drivers/gpu/drm/xe/xe_wa.c
@@ -612,6 +612,13 @@ static const struct xe_rtp_entry_sr engine_was[] = {
 };
 
 static const struct xe_rtp_entry_sr lrc_was[] = {
+	{ XE_RTP_NAME("16011163337"),
+	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(1200, 1210), ENGINE_CLASS(RENDER)),
+	  /* read verification is ignored due to 1608008084. */
+	  XE_RTP_ACTIONS(FIELD_SET_NO_READ_MASK(FF_MODE2,
+						FF_MODE2_GS_TIMER_MASK,
+						FF_MODE2_GS_TIMER_224))
+	},
 	{ XE_RTP_NAME("1409342910, 14010698770, 14010443199, 1408979724, 1409178076, 1409207793, 1409217633, 1409252684, 1409347922, 1409142259"),
 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(1200, 1210)),
 	  XE_RTP_ACTIONS(SET(COMMON_SLICE_CHICKEN3,
-- 
2.39.5



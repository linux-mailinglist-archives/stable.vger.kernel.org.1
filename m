Return-Path: <stable+bounces-128057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 403A7A7AECC
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDB4F162992
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DAF223302;
	Thu,  3 Apr 2025 19:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUbPLtsp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B457122259C;
	Thu,  3 Apr 2025 19:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707867; cv=none; b=S0I3h4gze4jgYTZUvaZXr5A6w7hkNrkd1h4w9Bv6QGqhlqF6SSD4uACXE25lcv85y5JjI2pXWHcyqGR2Nmm/N4up1alS6OFvz1wI9yuadmbj5PGa25V3W7kOAEjaR8yJW8+thgXFNtl8BrzJt3MG67404uq2zwyJfgDDqbwJnto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707867; c=relaxed/simple;
	bh=3YZxGM2WVxAkFV5d/S6Jq7YbV5c9cU1lXyeQj4JIpCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IaQnruhEyPVVCeo5x7do/THlL0VEbyYjOicR1K/qrgpHzbDG1otuQ+qVoKdVpDC+RaYhmiafyn1RmMt1sJ0IS7frulOUWG9p1zvJhmJwvKGgbxmw0+7L4AypRNnkk3qZQBiJm89bClrjbjPsYaLaGMuyVJbKVBqjY6jt3E4Mf2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUbPLtsp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C86CCC4CEE3;
	Thu,  3 Apr 2025 19:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707867;
	bh=3YZxGM2WVxAkFV5d/S6Jq7YbV5c9cU1lXyeQj4JIpCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NUbPLtsp0eeSNrvkNU+iO9Jcc6zDi5ztW0zppn3IFCWJLZUrzSPY2hXVMZIO+g2zw
	 4OJlhoPidlKK07YiNSKsl1OjRkD2gtgwXa6durde30tCa9iz84HRkspUBaB0xNfblx
	 gcr6ql6GDIZSPkghh8i6Udit6ZilFDGfrU2WZeqh8eINSpV45lOQJ0ZeyPCB4FnLj6
	 v5V5TXoETd8yVakK2lQoBv9R9udjbctqmPxwON4sn/y0SLNEProM3vwVJMY00hvNou
	 NPVXhn83t3/jsYbCVqFQV0NyjNcr/Yi+Ryuyvy5JcR5kjFA2+cYZXhwUWlFyud+JnR
	 IVbadwdN0aArQ==
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
Subject: [PATCH AUTOSEL 6.12 19/33] drm/xe/xelp: Move Wa_16011163337 from tunings to workarounds
Date: Thu,  3 Apr 2025 15:16:42 -0400
Message-Id: <20250403191656.2680995-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191656.2680995-1-sashal@kernel.org>
References: <20250403191656.2680995-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
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
index 0d5e04158917b..1fb12da21c9e4 100644
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
index 37e592b2bf062..0a1905f8d380a 100644
--- a/drivers/gpu/drm/xe/xe_wa.c
+++ b/drivers/gpu/drm/xe/xe_wa.c
@@ -606,6 +606,13 @@ static const struct xe_rtp_entry_sr engine_was[] = {
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



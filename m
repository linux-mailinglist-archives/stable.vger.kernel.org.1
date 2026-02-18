Return-Path: <stable+bounces-217219-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id pqDZGrlolWm2QgIAu9opvQ
	(envelope-from <stable+bounces-217219-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 08:22:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B6B153A2D
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 08:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 39F443006D76
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 07:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36111309DC5;
	Wed, 18 Feb 2026 07:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aybvzdrJ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF22829994B
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 07:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771399348; cv=none; b=n4tcHj+2Onmq2vslA4k15IMecj8t6IXq3zAcm+nAgkZMhJetacf7MlIxA89/V3tZ+C55YF1C+SJiNpVn8wgFfo9W6ksngxvtbFdXQKFe58vapeMY16aXCi6rovID5oisuNjBdIbUh2pIsw6ycUV6KaWGoYp16ItAmXX4yRL+UgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771399348; c=relaxed/simple;
	bh=S2fo0Xdvl8AoJRIa6sGYzPFDBwSqzeEMvC1EzeI1hkE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J7Z6ZfNwUvo5fUilAgGZuhrNweHmIrtEqyGco7iEUaWtMOh5QPbyoFA33Vz2YejTHrRn8VRl47Kk12ySOWnk6L6/ySvlteVXWhhtED6wKDmO74UFMjBKrllLAniowMDB1oR4ro6Moyrphc8mSb5/ZN3fWEWVkO6eblA6R7aMMvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aybvzdrJ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771399348; x=1802935348;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S2fo0Xdvl8AoJRIa6sGYzPFDBwSqzeEMvC1EzeI1hkE=;
  b=aybvzdrJ6kPIJLoi9dCKjiHkhW9CLDAW6DOiBmY2ABVozk4qh/TYPQaa
   sZR8V4cJMKmhpZw7oHP4mecP9FukpU4a7oz830tbTKoV0eaw9io0IbxdV
   jDUu8ibk4xr1a50NM1BmZtYkMJM8cRsLkpUNDCsuOUThBglDKJUQgnm1r
   ukTB42cw2RSKB1VOybEMwSLdnwMCm+wWsT2jFmzHNz6NNMcuKuwmN0QwN
   tnjYTcP3iFsR29ZzxrqudS94ftFV8ph0dZEZ8L2QPqw5qWBPAvMVMDZnD
   ENlcNyKx4f61N+kUOoixsEXth+1GtodGiuGtCb8BsqrkFETRasw2vqLzB
   Q==;
X-CSE-ConnectionGUID: H/7nEFvkQLOP+N/5QWerSA==
X-CSE-MsgGUID: YtrekC67Q/iQIaGMY4czbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="72519039"
X-IronPort-AV: E=Sophos;i="6.21,297,1763452800"; 
   d="scan'208";a="72519039"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 23:22:27 -0800
X-CSE-ConnectionGUID: qwrYAf25Qk6NQkA7+Umg3A==
X-CSE-MsgGUID: S7KM8cbHTMqGGA1X3RMQ6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,297,1763452800"; 
   d="scan'208";a="213208226"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
  by orviesa006.jf.intel.com with ESMTP; 17 Feb 2026 23:22:23 -0800
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: contact@emersion.fr,
	alex.hung@amd.com,
	harry.wentland@amd.com,
	daniels@collabora.com,
	mwen@igalia.com,
	sebastian.wick@redhat.com,
	uma.shankar@intel.com,
	ville.syrjala@linux.intel.com,
	maarten.lankhorst@linux.intel.com,
	jani.nikula@intel.com,
	louis.chauvet@bootlin.com,
	stable@vger.kernel.org,
	chaitanya.kumar.borah@intel.com
Subject: [PATCH 1/2] drm/colorop: Preserve bypass value in duplicate_state()
Date: Wed, 18 Feb 2026 12:27:12 +0530
Message-Id: <20260218065713.326417-2-chaitanya.kumar.borah@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260218065713.326417-1-chaitanya.kumar.borah@intel.com>
References: <20260218065713.326417-1-chaitanya.kumar.borah@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217219-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chaitanya.kumar.borah@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 91B6B153A2D
X-Rspamd-Action: no action

__drm_atomic_helper_colorop_duplicate_state() unconditionally
sets state->bypass = true after copying the existing state.

This override causes the new atomic state to no longer reflect
the currently committed hardware state. Since the bypass property
directly controls whether the colorop is active in hardware,
resetting it to true can inadvertently disable an active colorop
during a subsequent commit, particularly for internal driver commits
where userspace does not touch the property.

Drop the unconditional assignment and preserve the duplicated
bypass value.

Fixes: 8c5ea1745f4c ("drm/colorop: Add BYPASS property")
Cc: <stable@vger.kernel.org> #v6.19+
Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
---
 drivers/gpu/drm/drm_colorop.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
index aa19de769eb2..5037efcc3497 100644
--- a/drivers/gpu/drm/drm_colorop.c
+++ b/drivers/gpu/drm/drm_colorop.c
@@ -466,8 +466,6 @@ static void __drm_atomic_helper_colorop_duplicate_state(struct drm_colorop *colo
 
 	if (state->data)
 		drm_property_blob_get(state->data);
-
-	state->bypass = true;
 }
 
 struct drm_colorop_state *
-- 
2.25.1



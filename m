Return-Path: <stable+bounces-224499-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oE1OFPkbsGnufwIAu9opvQ
	(envelope-from <stable+bounces-224499-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 14:26:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D73250368
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 14:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CEEC3443CEF
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F6A3C4571;
	Tue, 10 Mar 2026 11:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bVk9z8yP"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD7B3A3E8C
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 11:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143870; cv=none; b=kw4OKBepG2YIkROhiz0OfEy5Q5WBfzc41/9zK27VKwHkGqtgGK9G7FnMvaZ41EnolDxhdDId7li6NwK3CNiAlncYr1v+HnCa6Dd66BSOkBVscxFyyqgtYKCl5yfWCm9Nd0/yIhUJ29fXqbIxEvN6AcPP/yvV8eJzNQYv/cQawXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143870; c=relaxed/simple;
	bh=X5bkIg01mSwii0raJK6zIIndcQTpTwNMf2UUfEWI840=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mZfOT1vGyj8Q0nzPVPspef3WSiIaJSEgrBfNsNeaePpFk7I/pfBZQVoQ+lSX+4d8REyK1yjK2ILAqa59GoqzUDY2XUCgvBbZeQuN+L612suCYRwQnbdnMxxR1cHKy5wAeQ+9XkhQ0XPmn2amvK23rEL7vIRns2LrOcLpewb5OOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bVk9z8yP; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773143864; x=1804679864;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X5bkIg01mSwii0raJK6zIIndcQTpTwNMf2UUfEWI840=;
  b=bVk9z8yPKDvrEouUlhiLe5qEjwdU+NtsObMU85dD418/gZ4xNnZnKRRy
   DdEVlud6XadTcHnzHqVMWM76JixBH307/TiDpbDGWgTZP0pAgDGFO/jmz
   j7niRCQ+zC/mOrXLpHQzJdwGigX61jy9CysosOfYQTpbo237lMbk6hjGf
   Q7EuYYjUxlZDo1KjDxIRtrd2sE+9soibVkhNehogeUrVuoxw7lBpgtZmE
   vLx0CaaEC41J6BJ7F20SEI8bP2rWIkmxcZrZfpp1kojrLsK4FjgsphljI
   3DMTwhaTbvOoETZgjMcAYp/dirghbdZqpZR9jm4SM17mQ7luh2Y6DWdr7
   A==;
X-CSE-ConnectionGUID: 3pS5t+6dQtisDKk2T/2PMQ==
X-CSE-MsgGUID: j93mG611SISAvCMRBvGnCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="84897884"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="84897884"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 04:57:42 -0700
X-CSE-ConnectionGUID: 5caxrIYCR6u91I0aJdALGA==
X-CSE-MsgGUID: utGbFRa4SMWw1tJHYvJBsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="224773043"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
  by fmviesa005.fm.intel.com with ESMTP; 10 Mar 2026 04:57:38 -0700
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
Subject: [PATCH v2 1/2] drm/colorop: Preserve bypass value in duplicate_state()
Date: Tue, 10 Mar 2026 17:02:37 +0530
Message-Id: <20260310113238.3495981-2-chaitanya.kumar.borah@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260310113238.3495981-1-chaitanya.kumar.borah@intel.com>
References: <20260310113238.3495981-1-chaitanya.kumar.borah@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A2D73250368
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224499-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chaitanya.kumar.borah@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
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
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
---
 drivers/gpu/drm/drm_colorop.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
index f421c623b3f0..e44a738c4c14 100644
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



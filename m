Return-Path: <stable+bounces-217220-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLEzAbxolWm2QgIAu9opvQ
	(envelope-from <stable+bounces-217220-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 08:22:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94ACA153A42
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 08:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DE5D3015C83
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 07:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38BE309DC5;
	Wed, 18 Feb 2026 07:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T0spdZjC"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773F33093BF
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 07:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771399352; cv=none; b=SucopZLUfgPWU5E1CURNg+wXB+/58cyFeRbGNOgGlYewx5dOKtNrKTP5oT3fMlnwu9th3P4DGh7N24R328sDLUynKrOetHxLVTHM7VHUoCUcYkOdQkcRwWRi9JofXVfYq/W3diFgezPjR+EIHqYoIhi0oT2u6Zmd2qSMhYuKJEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771399352; c=relaxed/simple;
	bh=MLq4MrXZFepM8181YTs+GRl6oXIi+u2CPpRSLMbsieI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rXKi+Q8FNUbO2w8uApyL4DWrl+/Y2iWoo2LoM3AF3b8OHyJnQIByXFZtylgMYWfjN/3hSLiy4SquqD+OKiGBaKW8KChEsxFVYjCsDe3IDO0whHu5HbvH3q3997MyERxCM9ATWIDWyLPTvK+PhhUi6DrdXT8Tnrrum/ERSuwMGEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T0spdZjC; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771399352; x=1802935352;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MLq4MrXZFepM8181YTs+GRl6oXIi+u2CPpRSLMbsieI=;
  b=T0spdZjCqEQm/QY/0EZgvtduz2aojaYOFZ9kghwKYXD0Dmd2yN6wP+9I
   VYrXJIkmeoAuHNKu60Sl2EUasQOOP8zwrMhCOT0Rg+IH0h3fJ/P/ASmMN
   ZpvdQqQEh5wUcfiuy47EhOKwf4LhWYdDXYNdwHZN9xWJt0qeLGxdZsnZA
   9Pa1dwCjSS2fN6yR5vrkdMB93bU1ubUGY0X/BxHBwAzo/MF9Ss2C1upuu
   vgu82LfDNwc7mXM9MXr5XR+b8o486XMQyU7wPEfXsckd+FiOnCYTzG+r5
   n96Kgi50pFTZPbL74YKLbQHxqFVr4knPIhM0eyW2bTmRqdFsmp8edSox1
   g==;
X-CSE-ConnectionGUID: wDbfX7VOR+O1UcfRskB+Ug==
X-CSE-MsgGUID: 7u/EwaYzT9qxAB2ZjOlShQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="72519047"
X-IronPort-AV: E=Sophos;i="6.21,297,1763452800"; 
   d="scan'208";a="72519047"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 23:22:32 -0800
X-CSE-ConnectionGUID: AEUHbYIqR5GLUL6Tk7xDmw==
X-CSE-MsgGUID: 7qfj6d3GTdmoetzxLYy4+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,297,1763452800"; 
   d="scan'208";a="213208229"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
  by orviesa006.jf.intel.com with ESMTP; 17 Feb 2026 23:22:27 -0800
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
Subject: [PATCH 2/2] drm/atomic: Add affected colorops with affected planes
Date: Wed, 18 Feb 2026 12:27:13 +0530
Message-Id: <20260218065713.326417-3-chaitanya.kumar.borah@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217220-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 94ACA153A42
X-Rspamd-Action: no action

When drm_atomic_add_affected_planes() adds a plane to the atomic
state, the associated colorops are not guaranteed to be included.
This can leave colorop state out of the transaction when planes
are pulled in implicitly (eg. during modeset or internal commits).

Also add affected colorops when adding affected planes to keep
plane and color pipeline state consistent within the atomic
transaction.

Fixes: 2afc3184f3b3 ("drm/plane: Add COLOR PIPELINE property")
Cc: <stable@vger.kernel.org> #v6.19+
Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
---
 drivers/gpu/drm/drm_atomic.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index e3029c8f02e5..8bcd76aaeb6a 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1588,6 +1588,7 @@ drm_atomic_add_affected_planes(struct drm_atomic_state *state,
 	const struct drm_crtc_state *old_crtc_state =
 		drm_atomic_get_old_crtc_state(state, crtc);
 	struct drm_plane *plane;
+	int ret;
 
 	WARN_ON(!drm_atomic_get_new_crtc_state(state, crtc));
 
@@ -1601,6 +1602,10 @@ drm_atomic_add_affected_planes(struct drm_atomic_state *state,
 
 		if (IS_ERR(plane_state))
 			return PTR_ERR(plane_state);
+
+		ret = drm_atomic_add_affected_colorops(state, plane);
+		if (ret)
+			return ret;
 	}
 	return 0;
 }
-- 
2.25.1



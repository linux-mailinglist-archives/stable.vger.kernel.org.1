Return-Path: <stable+bounces-245097-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFObNqVvAWptZQEAu9opvQ
	(envelope-from <stable+bounces-245097-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 07:56:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAB85084D7
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 07:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B99E9300A761
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 05:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E47377EB2;
	Mon, 11 May 2026 05:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="egpFpywh"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB8A2C08DC
	for <stable@vger.kernel.org>; Mon, 11 May 2026 05:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778479009; cv=none; b=lsT2vvAGu2ARMLDxjgKsdyz8neGFF+5WQlo36GB8FZaEgZeo4urN5HgxT0i5lMymZ2mR89ofj14t89zAkMzPbLxg7HKeJgTwlDz9BYeKZUbxnpkseCWtoODQXEVL7klFznqqgWF0M1YGPauDdeZ2PAGnrTpIr1O1WaTPBq2NXRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778479009; c=relaxed/simple;
	bh=U6Wh5Gv0D56MOUy2DzHZyVMtM17X5gG4x9V6InyVG/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f+tXg/AfRJR8i27VpfKh2YBPL0ospcUtK6OwGc5W2l731VXC82nYTRW59MOf+JfgXpimpcXBPGxYEQTXwpNAcXw5jssexVIracwu/armNi1ZKT9M8bSi9P0pAS+u8vvEPd21lGolURQ7z8tEiXbngKGeR7PdcOpmZ7/Dh+0M1Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=egpFpywh; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778479008; x=1810015008;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U6Wh5Gv0D56MOUy2DzHZyVMtM17X5gG4x9V6InyVG/4=;
  b=egpFpywhuiGQdm43nMMTlSRpXxhhnoNeOKP+Ug7UHnEMTlkUWVtWlg0R
   90XHh9gkUlHqANUQv8E3MY8UtIjvxs+BuVi4OjJkIqJxTqgUHWP+czh+/
   Ft71u2RxQ36UTZaEFgYuvm+X4RFkZSwt/yavbEW8edQqdAysG1ZlTDBX3
   V20Y8LN1UJ1Vv5n6+ml2tjborBO57+1JGp6ZtNQOxy4pLzXf98Q79Db+U
   Ue1fZgoetwVfE0fNbWsscaFQbYN/kP6lYsKVCmyLpdy5Qc1xm665k0aZy
   H4AW3JtJaW6ihHQkf2VYP9morKAuYQQzJ809STX91Hxq4MW9L0FeSQL0q
   w==;
X-CSE-ConnectionGUID: gz6zM8XPQI2AGaoFko1VqQ==
X-CSE-MsgGUID: k1KEAsD4RA6GGCvJ2keBSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="81922843"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="81922843"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 22:56:47 -0700
X-CSE-ConnectionGUID: fxYH/fl7TCeDheqcOccFyg==
X-CSE-MsgGUID: bJC9tEHpQK2+Qb0kQK6sBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="241719944"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
  by orviesa004.jf.intel.com with ESMTP; 10 May 2026 22:56:45 -0700
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: ville.syrjala@linux.intel.com,
	uma.shankar@intel.com,
	chaitanya.kumar.borah@intel.com,
	pranay.samala@intel.com,
	stable@vger.kernel.org,
	Vidya Srinivas <vidya.srinivas@intel.com>
Subject: [PATCH v3 1/4] drm/i915/display: Copy color pipeline from plane in the primary joiner pipe
Date: Mon, 11 May 2026 11:02:10 +0530
Message-Id: <20260511053213.3122314-2-chaitanya.kumar.borah@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260511053213.3122314-1-chaitanya.kumar.borah@intel.com>
References: <20260511053213.3122314-1-chaitanya.kumar.borah@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3DAB85084D7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245097-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chaitanya.kumar.borah@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

When copying plane color state in a joiner configuration, use the plane in
the primary joiner pipe since it carries the pipeline number selected by
the user-space.

This assumes that all pipes in the joiner are symmetric in their plane
color capabilities.

Cc: stable@vger.kernel.org # v6.19+
Fixes: a78f1b6baf4d ("drm/i915/color: Add framework to program CSC")
Tested-by: Vidya Srinivas <vidya.srinivas@intel.com>
Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
---
 drivers/gpu/drm/i915/display/intel_plane.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_plane.c b/drivers/gpu/drm/i915/display/intel_plane.c
index c181a7d063ec..e403fe4a8a20 100644
--- a/drivers/gpu/drm/i915/display/intel_plane.c
+++ b/drivers/gpu/drm/i915/display/intel_plane.c
@@ -396,7 +396,7 @@ intel_plane_color_copy_uapi_to_hw_state(struct intel_plane_state *plane_state,
 	bool changed = false;
 	int i = 0;
 
-	iter_colorop = plane_state->uapi.color_pipeline;
+	iter_colorop = from_plane_state->uapi.color_pipeline;
 
 	while (iter_colorop) {
 		for_each_new_colorop_in_state(state, colorop, new_colorop_state, i) {
-- 
2.25.1



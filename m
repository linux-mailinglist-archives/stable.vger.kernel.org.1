Return-Path: <stable+bounces-219987-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCoKN+LJoWmqwQQAu9opvQ
	(envelope-from <stable+bounces-219987-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 17:44:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 156101BAF36
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 17:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8DF563004419
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 16:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503283491C8;
	Fri, 27 Feb 2026 16:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bv0q08lc"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9807329E53
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 16:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772210654; cv=none; b=L4ntag704+H3U9859viEogR8YP0g99h0TzChDQdqZGDFCvGuArqAHusPNkuFDJf/VZZi3iV3zTFPlsRLilIljTv8jIxmnpA/hr7P87UPl6FGuhdZDNEg7z/nBd6zXdTR44TzT6/hxMwDvsOBqPtgTiyZFqZyAsTvTbMaVW4XLCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772210654; c=relaxed/simple;
	bh=iFkp1QKVkUBs7h3tg9Xx7HNiMzOyEyGW7spIFTjBYgA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iDn3K1e0Ej4KN9rgnxHgRTZByGCXPpmUYpcglNsUFa9KNmK+vUwJfFjUkt2oauDoJhaQe1A+O6YRszs2fS2zUZWPXeHvzzbbJ56/nc6kvTuME6UwEhXxJOAJZGa623lY4o81wD7B7kDWzBAt741HIOUfzaoiFxS4BwT+yLSFt8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bv0q08lc; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772210653; x=1803746653;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iFkp1QKVkUBs7h3tg9Xx7HNiMzOyEyGW7spIFTjBYgA=;
  b=Bv0q08lcUbh7HtmaVcJackkuuhoVFT0DEOVsvZbWRIay0LSduVIAjmD6
   JamAHRYcrUt/5tyoLi0bGItl+y3qAj3CF/IY+6uTL1ctyJkDaQ1sxAYeR
   aPOsG7zVxRq+cSNNJWO/Ji0HxMUvUl54sqpHIpxRIby4NKd80S+eK8hbB
   gohdLJb+5isGLiFfiNbzZrKSkldnBUJdl3+LinkTeSZw9C6gv5ZS4WvXu
   xysGSjZVUH/HFpg9SuKittsaad2j4QyX964voopiPOFDmC3Hw2XPlJ5x8
   zC9Gg28WFj5js/mTBHqmP0Z8OyEpOLHIGFhBpnVwTTARah4Bkj8/G/zFV
   w==;
X-CSE-ConnectionGUID: 9cilB9wgQEi9YH+4xOAy+Q==
X-CSE-MsgGUID: RwcZS/BsTaqTTiCtX+K1qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="90698334"
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; 
   d="scan'208";a="90698334"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 08:44:12 -0800
X-CSE-ConnectionGUID: XVJHUtRrQc+mlhHpyIOMmQ==
X-CSE-MsgGUID: Z/ooLAG1RUWnwnyl5ypSlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; 
   d="scan'208";a="221936786"
Received: from mdroper-desk1.fm.intel.com ([10.1.39.133])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 08:44:12 -0800
From: Matt Roper <matthew.d.roper@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.d.roper@intel.com,
	Aradhya Bhatia <aradhya.bhatia@intel.com>,
	Tejas Upadhyay <tejas.upadhyay@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe/xe2_hpg: Correct implementation of Wa_16025250150
Date: Fri, 27 Feb 2026 08:43:41 -0800
Message-ID: <20260227164341.3600098-2-matthew.d.roper@intel.com>
X-Mailer: git-send-email 2.53.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219987-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[matthew.d.roper@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 156101BAF36
X-Rspamd-Action: no action

Wa_16025250150 asks us to set five register fields of the register to
0x1 each.  However we were just OR'ing this into the existing register
value (which has a default of 0x4 for each nibble-sized field) resulting
in final field values of 0x5 instead of the desired 0x1.  Correct the
RTP programming (use FIELD_SET instead of SET) to ensure each field is
assigned to exactly the value we want.

Cc: Aradhya Bhatia <aradhya.bhatia@intel.com>
Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
Cc: <stable@vger.kernel.org> # v6.16+
Fixes: 7654d51f1fd8 ("drm/xe/xe2hpg: Add Wa_16025250150")
Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
---
 drivers/gpu/drm/xe/xe_wa.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_wa.c b/drivers/gpu/drm/xe/xe_wa.c
index 26950b8a7543..183c5c86c35a 100644
--- a/drivers/gpu/drm/xe/xe_wa.c
+++ b/drivers/gpu/drm/xe/xe_wa.c
@@ -249,12 +249,13 @@ static const struct xe_rtp_entry_sr gt_was[] = {
 
 	{ XE_RTP_NAME("16025250150"),
 	  XE_RTP_RULES(GRAPHICS_VERSION(2001)),
-	  XE_RTP_ACTIONS(SET(LSN_VC_REG2,
-			     LSN_LNI_WGT(1) |
-			     LSN_LNE_WGT(1) |
-			     LSN_DIM_X_WGT(1) |
-			     LSN_DIM_Y_WGT(1) |
-			     LSN_DIM_Z_WGT(1)))
+	  XE_RTP_ACTIONS(FIELD_SET(LSN_VC_REG2,
+				   LSN_LNI_WGT_MASK | LSN_LNE_WGT_MASK |
+				   LSN_DIM_X_WGT_MASK | LSN_DIM_Y_WGT_MASK |
+				   LSN_DIM_Z_WGT_MASK,
+				   LSN_LNI_WGT(1) | LSN_LNE_WGT(1) |
+				   LSN_DIM_X_WGT(1) | LSN_DIM_Y_WGT(1) |
+				   LSN_DIM_Z_WGT(1)))
 	},
 
 	/* Xe3_LPG */
-- 
2.53.0



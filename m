Return-Path: <stable+bounces-227033-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oH6hK/SRumnSXgIAu9opvQ
	(envelope-from <stable+bounces-227033-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 12:52:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AD22BB1BF
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 12:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0EF4302E91A
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 11:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D16A35C182;
	Wed, 18 Mar 2026 11:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dqm64erO"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB99C3D3006
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 11:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773834689; cv=none; b=pgjDYalG06pL4Rvsl0eMyBr9SGz/oA6TeC7CW7SPGSbnzIVtbiDAgesj/7GtA2iBspJEaPwvV8fyJJeI4besXB8tlYwb4k99gMz+jdovHJ8yKQv+7PFKFFtZzma8HxarXxOb4IhUQeBk/5//pfjbpXmF34m2zrsvm3H+lkf87hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773834689; c=relaxed/simple;
	bh=xVDaqdXaVwqd3Ly0lQR5ZrswxmHvL2CqE5jRBSWGVQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EJIDF4rwcSGVD0iDmXmoD3ho3lD09U6koGmzzGCUmYVzmvMbbhJvr4ppofE68LSS7chd63h1xsEeoViPYTKSsmOeHl2XlvlH3hiE6Y5fT4/yjG7kdPKCgvUbZl4p93i4ehGgi8GY+6UvOmhOyUd/9YSLTf0Y8nHopIm24tem6vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dqm64erO; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773834687; x=1805370687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xVDaqdXaVwqd3Ly0lQR5ZrswxmHvL2CqE5jRBSWGVQg=;
  b=dqm64erO0lNcQCuQGrD0daI9QGJDsUNKoMdMbn11GUOlawYenDZ6qx52
   z1T+d2CHdOJJquNddDdyXOojKds/LDrQ9vxUXJF7y6xzkbCwjQ4tCHuME
   OGEDXg8ojZ1IAxNfIC+gLSb7KQ4c4sd7Qt0qYDcDptM9/Cta6kEj18dhI
   Vkut6KTh5sosKagyEkhRfBRs5dLDmpxR3Dd85YRpDfv4zu1U8jmBjTNYB
   qmASBub3HM7yzLT6GPNSNmZlUN2C66sSsr/rfy1jAM3XSDRRiKkb/bsmm
   D78Yg7cDlgfOl9TS6zcJI8g25ZONF57OaAzKgBrOFkyP8MOiaC4jdR/cX
   Q==;
X-CSE-ConnectionGUID: j1rhdgTHQR+9zOifl9m+LQ==
X-CSE-MsgGUID: TGLjPS0FQV6aAkgvRZYAeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="74772055"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="74772055"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 04:51:27 -0700
X-CSE-ConnectionGUID: g+CF7WEPQvGBaeioeGCeJQ==
X-CSE-MsgGUID: 9DckWNZYQxePla4InVGM/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="227543977"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO jhogande-mobl3.intel.com) ([10.245.245.220])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 04:51:25 -0700
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Animesh Manna <animesh.manna@intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	=?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 6.12.y] drm/i915/alpm: ALPM disable fixes
Date: Wed, 18 Mar 2026 13:50:55 +0200
Message-ID: <20260318115055.834362-1-jouni.hogander@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026031731-secret-rocket-af05@gregkh>
References: <2026031731-secret-rocket-af05@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227033-lists,stable=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jouni.hogander@intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 14AD22BB1BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit eb4a7139e97374f42b7242cc754e77f1623fbcd5 upstream

PORT_ALPM_CTL is supposed to be written only before link training. Remove
writing it from ALPM disable.

Also clearing ALPM_CTL_ALPM_AUX_LESS_ENABLE and is not about disabling ALPM
but switching to AUX-Wake ALPM. Stop touching this bit on ALPM disable.

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/7153
Fixes: 1ccbf135862b ("drm/i915/psr: Enable ALPM on source side for eDP Panel replay")
Cc: Animesh Manna <animesh.manna@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: <stable@vger.kernel.org> # v6.10+
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
Reviewed-by: Michał Grzelak <michal.grzelak@intel.com>
Link: https://patch.msgid.link/20260212062731.397801-1-jouni.hogander@intel.com
(cherry picked from commit 008304c9ae75c772d3460040de56e12112cdf5e6)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
(cherry picked from commit eb4a7139e97374f42b7242cc754e77f1623fbcd5)
---
 drivers/gpu/drm/i915/display/intel_psr.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 34d61e44c6bd..4d697b44078c 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -2114,12 +2114,7 @@ static void intel_psr_disable_locked(struct intel_dp *intel_dp)
 	/* Panel Replay on eDP is always using ALPM aux less. */
 	if (intel_dp->psr.panel_replay_enabled && intel_dp_is_edp(intel_dp)) {
 		intel_de_rmw(display, ALPM_CTL(display, cpu_transcoder),
-			     ALPM_CTL_ALPM_ENABLE |
-			     ALPM_CTL_ALPM_AUX_LESS_ENABLE, 0);
-
-		intel_de_rmw(display,
-			     PORT_ALPM_CTL(display, cpu_transcoder),
-			     PORT_ALPM_CTL_ALPM_AUX_LESS_ENABLE, 0);
+			     ALPM_CTL_ALPM_ENABLE, 0);
 	}
 
 	/* Disable PSR on Sink */
-- 
2.43.0



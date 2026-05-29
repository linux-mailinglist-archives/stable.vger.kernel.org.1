Return-Path: <stable+bounces-256576-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODxHOnZfGWpevwgAu9opvQ
	(envelope-from <stable+bounces-256576-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 11:42:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DB460019F
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 11:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6D59D304B6E7
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 09:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD813BCD02;
	Fri, 29 May 2026 09:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rv7g/hs1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4379C3AD50B
	for <stable@vger.kernel.org>; Fri, 29 May 2026 09:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780047561; cv=none; b=gdcZPGvbU1dJ6lAFos9tELfUxQCruIyM7Yd9FANPOMKZa6fpneXNsNDr7oKkt8tt+jacFKhsGo4MaKs/H61BTKYzt41ruUetcQ3PttzFowylGyESV+0s3mr1fMbb47w0m+1s0sSIhzKZa0D+ngTk36qq0a7TXUgvvtIQeFskFkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780047561; c=relaxed/simple;
	bh=boYyluUvc6oiNlItTy0FXYzUO9iUbIdEFrmuqohVWqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jTOM8kDFJQLzTwBEAb728cyHzs9ikv5pz/S6Eh1O3fyJNH1PIDWKp5SFwRSGMTUD89cTCn+c30NsIc+X1yGCvd10afibiuomB2dajseKD7BhhSShaLQRwInn9tckUdfCu0bN1yGCMPDAwCgm2hG7ltyHiRr5rfX+35qXEgjxVtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rv7g/hs1; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780047560; x=1811583560;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=boYyluUvc6oiNlItTy0FXYzUO9iUbIdEFrmuqohVWqo=;
  b=Rv7g/hs1f/xD108dopPRbXAPTZyE/JoxXomFA/osf8oMhZV7XKQOmTDF
   HvVpnj2ilky5/QyF4geteDWjcu9Yct85DUCssZwxRuNqWLguTBzNabmqR
   /PfevDyXlu5giO7PffJJgCHo1HSxyGmxWke0PpRoOXxn/qtW1fmMGc8uH
   aVzlOgsraMONbJg0r3H0jWXG/gYTvB0VIgOLTvZ8K45kAaTeMT39OpCWW
   d2RHUBmZoRY0Vg19KATKR5OpEfq3UshWIxBcYBpppI4dRid7eGfkQQel2
   W1gkaD5vxiy23lq5HjJNVmW9vy7NeRWewXSs4FoxePx+hzHNLOlmr5V2l
   Q==;
X-CSE-ConnectionGUID: DF+VLJAGR7K1qhnFeqjZRw==
X-CSE-MsgGUID: ztMAuvY+SLil0MAqiPtXrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="80623629"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="80623629"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 02:39:18 -0700
X-CSE-ConnectionGUID: UyxS6//3QeClHQxt7aIViw==
X-CSE-MsgGUID: 5ghH1BQOS4WMg3SbKGIWNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="241990981"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO jhogande-mobl3.intel.com) ([10.245.246.54])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 02:39:15 -0700
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Subject: [PATCH 7.0.y 2/3] drm/i915/psr: Read Intel DPCD workaround register
Date: Fri, 29 May 2026 12:38:36 +0300
Message-ID: <20260529093837.610767-2-jouni.hogander@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529093837.610767-1-jouni.hogander@intel.com>
References: <2026052815-gown-browse-cf36@gregkh>
 <20260529093837.610767-1-jouni.hogander@intel.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256576-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jouni.hogander@intel.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,ursulin.net:email,intel.com:email,intel.com:mid,intel.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E5DB460019F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit f30bece421a4ae34359254e1dc2a187a42b6af9b upstream.

Read Intel DPCD workaround register and store it into
intel_connector->dp.psr_caps. psr_caps was chosen as currently it contains
only PSR workaround for PSR2 SDP on prior scanline implementation.

Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Link: https://patch.msgid.link/20260515095756.2799483-3-jouni.hogander@intel.com
(cherry picked from commit c48ff24d0f4ab7ad696b2d35ad64ce7e049c668c)
Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>
---
 drivers/gpu/drm/i915/display/intel_display_types.h | 1 +
 drivers/gpu/drm/i915/display/intel_psr.c           | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index ced0e5a5989b..3596ed0ff151 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -583,6 +583,7 @@ struct intel_connector {
 
 		struct {
 			u8 dpcd[EDP_PSR_RECEIVER_CAP_SIZE];
+			u8 intel_wa_dpcd;
 
 			bool support;
 			bool su_support;
diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 8a7075c4a248..aa2ef49afa67 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -43,6 +43,7 @@
 #include "intel_display_utils.h"
 #include "intel_dmc.h"
 #include "intel_dp.h"
+#include "intel_dpcd.h"
 #include "intel_dp_aux.h"
 #include "intel_dsb.h"
 #include "intel_frontbuffer.h"
@@ -708,8 +709,14 @@ static void _psr_init_dpcd(struct intel_dp *intel_dp, struct intel_connector *co
 			    connector->dp.psr_caps.su_support ? "" : "not ");
 	}
 
-	if (connector->dp.psr_caps.su_support)
+	if (connector->dp.psr_caps.su_support) {
+		ret = drm_dp_dpcd_read_byte(&intel_dp->aux,
+					    INTEL_DPCD_INTEL_WA_REGISTER_CAPS,
+					    &connector->dp.psr_caps.intel_wa_dpcd);
+		if (ret < 0)
+			return;
 		_psr_compute_su_granularity(intel_dp, connector);
+	}
 }
 
 void intel_psr_init_dpcd(struct intel_dp *intel_dp, struct intel_connector *connector)
-- 
2.43.0



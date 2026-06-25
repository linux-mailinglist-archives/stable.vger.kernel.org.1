Return-Path: <stable+bounces-268629-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tdDiDjlgPWqz2AgAu9opvQ
	(envelope-from <stable+bounces-268629-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 19:07:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 915456C7B23
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 19:07:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=asBWxr5S;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268629-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268629-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2BDF3006161
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 17:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C15B3AA1B0;
	Thu, 25 Jun 2026 17:03:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907DB1D5174
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 17:03:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782406994; cv=none; b=f8p3yatOjHqiR25pHcUpi3wUHrstlJ3MfPxDA7fCkz5Rq7Q2lenwifApwk6AqGIo+m5Wznk0av45Vl/646FPO6+Fu4rfh+kusSF8Wyep/93cz05BsZb3FkVOW40wqJrRPj1PSdNV7S9RNmmVIEzu2HskzFNQKzl9U5BPRdxXbIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782406994; c=relaxed/simple;
	bh=fcnuWjNDpxYoqPLJY8tZDCmNmusN3hivYrhzF//HNOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b4GrTBGojDPMRfXR/VXUaPh/kYZFuHI4navgDRjmxZoTt88vZc+sy8YYuSIs2GF8vRGXFUfHpgfdAuJgHwKY46vbLW6jlcDiJT1nKmLlTjssG9gLjQxvRgf+z/lhs37KJ+JrDQvPIvlIn0ltT9VqN+ZQ/9yqbeQrQpWaqV+rjhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=asBWxr5S; arc=none smtp.client-ip=198.175.65.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782406993; x=1813942993;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fcnuWjNDpxYoqPLJY8tZDCmNmusN3hivYrhzF//HNOM=;
  b=asBWxr5SfmzMAFHZ1kDLbe7YGTuByxTqjogNoXuod6un8VDGO9BwHHsh
   QQ89HVNCfKWNzVuQiSDu2/uFzoVMzCCXVoFGfQt/OXqCi/Y4IvCnff6Jd
   p9o8aqC7XUzkwVrA/AxITVhiTWO0VnbWdzRYUFybvKk6AI6OU/zrB7GDp
   ISjvoJ8YZ8gRLO/KoJF/df7aX0rHW5qnaJPgpwkwo2hyYggtPnAhvpUsv
   b+opbPfDryZMIrrpozjpdmIu6Us00g3mEYeolUtQRMy7NPCmlARaMeSAR
   aQMxma2dmjqW/2X5231bN6jgAY4N7hVjoy9I8ajelTHpyat+bM62cHr8I
   Q==;
X-CSE-ConnectionGUID: VhN0uIytSoW8Lk0QnbAyTw==
X-CSE-MsgGUID: unynUmwRS4enduyDu9lUZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="83289076"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="83289076"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 10:03:12 -0700
X-CSE-ConnectionGUID: 6s39jCKiRr+xXiPP/nKRFA==
X-CSE-MsgGUID: zWSJR28ZToikF1c6x2A8ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="274187306"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.126])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 10:03:09 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: jani.nikula@intel.com,
	Martin Hodo <martin.hodo@intel.com>,
	stable@vger.kernel.org,
	Anshuman Gupta <anshuman.gupta@intel.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>
Subject: [PATCH] drm/i915/hdcp: check streams[] bounds before overflow
Date: Thu, 25 Jun 2026 20:03:04 +0300
Message-ID: <20260625170304.1104723-1-jani.nikula@intel.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-268629-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:intel-gfx@lists.freedesktop.org,m:intel-xe@lists.freedesktop.org,m:jani.nikula@intel.com,m:martin.hodo@intel.com,m:stable@vger.kernel.org,m:anshuman.gupta@intel.com,m:suraj.kandpal@intel.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jani.nikula@intel.com,stable@vger.kernel.org];
	HAS_ORG_HEADER(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jani.nikula@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	FORGED_SENDER_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 915456C7B23

The data->streams[] overflow check is done after the buffer overflow has
already happened. Move the overflow check before the write.

Side note, emitting a warning splat with a backtrace might be overkill
here, but prefer not changing the behaviour other than not doing the
overrun.

Discovered using AI-assisted static analysis confirmed by Intel Product
Security.

Reported-by: Martin Hodo <martin.hodo@intel.com>
Fixes: e03187e12cae ("drm/i915/hdcp: MST streams support in hdcp port_data")
Cc: <stable@vger.kernel.org> # v5.12+
Cc: Anshuman Gupta <anshuman.gupta@intel.com>
Cc: Suraj Kandpal <suraj.kandpal@intel.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/display/intel_hdcp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdcp.c b/drivers/gpu/drm/i915/display/intel_hdcp.c
index e88fec24af49..521786a75c42 100644
--- a/drivers/gpu/drm/i915/display/intel_hdcp.c
+++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
@@ -145,6 +145,9 @@ intel_hdcp_required_content_stream(struct intel_atomic_state *state,
 		if (!new_conn_state || !new_conn_state->crtc)
 			continue;
 
+		if (drm_WARN_ON(display->drm, data->k >= INTEL_NUM_PIPES(display)))
+			return -EINVAL;
+
 		data->streams[data->k].stream_id =
 			intel_conn_to_vcpi(state, connector);
 		data->k++;
@@ -155,7 +158,7 @@ intel_hdcp_required_content_stream(struct intel_atomic_state *state,
 	}
 	drm_connector_list_iter_end(&conn_iter);
 
-	if (drm_WARN_ON(display->drm, data->k > INTEL_NUM_PIPES(display) || data->k == 0))
+	if (drm_WARN_ON(display->drm, !data->k))
 		return -EINVAL;
 
 	/*
-- 
2.47.3



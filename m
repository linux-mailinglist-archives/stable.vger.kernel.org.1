Return-Path: <stable+bounces-268344-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tWtTLwYHPWoawAgAu9opvQ
	(envelope-from <stable+bounces-268344-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 12:46:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD076C4CC9
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 12:46:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=S040DzGU;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268344-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268344-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7A92B303F8EB
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 10:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3020D3D410A;
	Thu, 25 Jun 2026 10:44:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3D93CFF50
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 10:44:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782384256; cv=none; b=Eu4JV92pYag+uC8I2azBFdND3k2kMKU8iqIBCeystecdEvHjFNAPjrl+MmiOcW/u5cR+PRAOJh0hgBZAnZtz1NzChRos8ZhmdIkx9W/INX/RyRd+3abwJYBTry8HcJCBCoq5Y1+skWJkBcnmlU5yJ/nbyhKCx5qBEYlY8Il6TBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782384256; c=relaxed/simple;
	bh=ox2VHxHbUs26Ni59OI8XgN8aYvGnixGst5y0T/QA9lc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MEx2E9KtxLjonWvpJRXKlKW4ztCigEcqM8merGis8on5BKhkf56ey/yakRCCo99xzKHg3TmU/eSOOm/9dXmaSmr4J/8v8mgJzrXHNOvIi1YzQ6ktSVF+hnbKAh0zq0IKCG31rnK5wKbMQKGg5vuKcmNNHOLzvqd3DhbxmwNkOcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S040DzGU; arc=none smtp.client-ip=198.175.65.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782384254; x=1813920254;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ox2VHxHbUs26Ni59OI8XgN8aYvGnixGst5y0T/QA9lc=;
  b=S040DzGUJ9nfKNBWirgrrjKnHzgL5t2XCu29Z0RazjgXgfp33aAcmn6c
   SIf0A8UZSdP/0N9lb3nXIkCdofVm7a/ZiBzs6TqRvVVx86nQD/9dKsI7q
   7Fb3HcwgfX9MRAME8Ofi0BI71OmGkd4M0os1kOU4oRjwIw3uT0DXq/Zko
   ajJ+byeo7JPwCRWriKFyKp7/kvM55593TJFFj/mgOK1+E0+jVJznpZGuT
   0JS7CD9dH1fm8SHUPheV1Q8/S9pb+Jzxr5C4FLC7J/5a9xMGQ1fckVs6Y
   kZv0meXemamtST/Z66tOrSIvJbdf5YzLwqEUIjPQZMqFpnpeD9OLZWC1w
   w==;
X-CSE-ConnectionGUID: sIQVl+G+TzaqxYvRDy3SDw==
X-CSE-MsgGUID: XNVVSGrDTQaUiu2em1yBwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="83254766"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="83254766"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 03:44:14 -0700
X-CSE-ConnectionGUID: qhR+zweIQWOIdCgu//38ww==
X-CSE-MsgGUID: 401S0iDuQyCIsMcpD2ulQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="250732423"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.126])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 03:44:12 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: jani.nikula@intel.com,
	Martin Hodo <martin.hodo@intel.com>,
	stable@vger.kernel.org,
	Suraj Kandpal <suraj.kandpal@intel.com>
Subject: [PATCH] drm/i915/hdcp: require monotonically increasing seq_num_v
Date: Thu, 25 Jun 2026 13:44:07 +0300
Message-ID: <20260625104407.1025614-1-jani.nikula@intel.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268344-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:intel-gfx@lists.freedesktop.org,m:intel-xe@lists.freedesktop.org,m:jani.nikula@intel.com,m:martin.hodo@intel.com,m:stable@vger.kernel.org,m:suraj.kandpal@intel.com,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jani.nikula@intel.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jani.nikula@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BDD076C4CC9

The HDCP 2.2 specification requires the seq_num_v to be monotonically
increasing, and repeated seq_num_v needs to be treated as an integrity
failure. Make it so.

For the first message, seq_num_v must be zero, and is already
checked. We can only check for less-than-or-equal for the subsequent
messages, where hdcp2_encrypted is true.

Discovered using AI-assisted static analysis confirmed by Intel Product
Security.

Reported-by: Martin Hodo <martin.hodo@intel.com>
Fixes: d849178e2c9e ("drm/i915: Implement HDCP2.2 repeater authentication")
Cc: <stable@vger.kernel.org> # v5.2+
Cc: Suraj Kandpal <suraj.kandpal@intel.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/display/intel_hdcp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdcp.c b/drivers/gpu/drm/i915/display/intel_hdcp.c
index e88fec24af49..d097b478d010 100644
--- a/drivers/gpu/drm/i915/display/intel_hdcp.c
+++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
@@ -1798,9 +1798,10 @@ int hdcp2_authenticate_repeater_topology(struct intel_connector *connector)
 		return -EINVAL;
 	}
 
-	if (seq_num_v < hdcp->seq_num_v) {
-		/* Roll over of the seq_num_v from repeater. Reauthenticate. */
-		drm_dbg_kms(display->drm, "Seq_num_v roll over.\n");
+	if (hdcp->hdcp2_encrypted && seq_num_v <= hdcp->seq_num_v) {
+		/* Reauthenticate on Seq_num_v repeat or rollover */
+		drm_dbg_kms(display->drm, "Seq_num_v %s\n",
+			    seq_num_v == hdcp->seq_num_v ? "repeat" : "rollover");
 		return -EINVAL;
 	}
 
-- 
2.47.3



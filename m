Return-Path: <stable+bounces-225282-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFn8MxXws2nYdgAAu9opvQ
	(envelope-from <stable+bounces-225282-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 12:08:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DFE281E84
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 12:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F4AA305FC53
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 11:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AAA3328FD;
	Fri, 13 Mar 2026 11:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AQJSCkq2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F116D372B3B
	for <stable@vger.kernel.org>; Fri, 13 Mar 2026 11:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773400067; cv=none; b=tQzoHsDiVfr9/52ZUj8j8ZpK6ZwPjnefpXQab76ZIdIHk9rYBjz/oIh2+PVbnfvHsCcdxylqTjo5yZIJ0H5kOeHqr5QjlqURS+1nXmgTrMzU4oL1Y3R+q+S2QU+EC3LPqTCnk3YaRI1EYGIJOLuZ0nYyMjaDpOfOjpImQ0dOBI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773400067; c=relaxed/simple;
	bh=DzUf/8iRGA8qUsueHxIvGDpDNyCtY9vmcu0Q7nYLcAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K4iSfRmBGnp85vabRHjdSKSSFCimBu/2ULM//KpoO5KIUHBk+X2mjnkscMhZki00dAPYmYAMPHZJYI4yI3ZFhfLSZ1z9P5ZtySXGpFsiIx1ymJNs2b0t3shZXvFsvb5tomSfSLNFynKsoX1TR/GiJSDO9ldfmeSCLlENu29kJFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AQJSCkq2; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773400066; x=1804936066;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DzUf/8iRGA8qUsueHxIvGDpDNyCtY9vmcu0Q7nYLcAM=;
  b=AQJSCkq2U4ZMD3j22SQIUtQQWdtJmuBrVqnlxGZ8+1CX/HrbZcXIpRyC
   yMxk5eLNv3h0f+QsqCEZu9OMO2bHP3hpStq7pYgO+I/8mlHz8SWxJ9zFQ
   E9legoirhKSXBvwHLGNHqRc2GEOyY9nOTWQjLWPzjyOGIPpzL4+UDQaiQ
   agvnegAns61vrCfm3TYlYq/3Uakvn5cRW2yE9sNXWubavGcKhTfo6RICC
   X6GyNGOK5YoFf5t6xCcCggaozfoaDhekzRA24SBb/plpZmso1VEyNtOkb
   Y0HofkvMNk760lAK/ckoMngoWA7i0+U8mlCwpK/eshje3PCJqxrT8D1F5
   A==;
X-CSE-ConnectionGUID: SbqyZ1AnT+uius93T7Qo3Q==
X-CSE-MsgGUID: VDBu3oyIRoSHCJ217WigaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="85134816"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="85134816"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 04:07:45 -0700
X-CSE-ConnectionGUID: gfF/eYY5SVmFBvkyMAph5w==
X-CSE-MsgGUID: bEtW3hdpQJSVMuyRTvSw7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="226088946"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 04:07:44 -0700
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: [PATCH] drm/i915: Order OP vs. timeout correctly in __wait_for()
Date: Fri, 13 Mar 2026 13:07:40 +0200
Message-ID: <20260313110740.24620-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225282-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ville.syrjala@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.intel.com:mid]
X-Rspamd-Queue-Id: 47DFE281E84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Put the barrier() before the OP so that anything we read out in
OP and check in COND will actually be read out after the timeout
has been evaluated.

Currently the only place where we use OP is __intel_wait_for_register(),
but the use there is precisely susceptible to this reordering, assuming
the ktime_*() stuff itself doesn't act as a sufficient barrier:

__intel_wait_for_register(...)
{
	...
	ret = __wait_for(reg_value = intel_uncore_read_notrace(...),
 			 (reg_value & mask) == value, ...);
	...
}

Cc: stable@vger.kernel.org
Fixes: 1c3c1dc66a96 ("drm/i915: Add compiler barrier to wait_for")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/i915_wait_util.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_wait_util.h b/drivers/gpu/drm/i915/i915_wait_util.h
index 7376898e3bf8..e1ed7921ec70 100644
--- a/drivers/gpu/drm/i915/i915_wait_util.h
+++ b/drivers/gpu/drm/i915/i915_wait_util.h
@@ -25,9 +25,9 @@
 	might_sleep();							\
 	for (;;) {							\
 		const bool expired__ = ktime_after(ktime_get_raw(), end__); \
-		OP;							\
 		/* Guarantee COND check prior to timeout */		\
 		barrier();						\
+		OP;							\
 		if (COND) {						\
 			ret__ = 0;					\
 			break;						\
-- 
2.52.0



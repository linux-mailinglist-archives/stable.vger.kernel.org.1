Return-Path: <stable+bounces-249484-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iM/sC0YUDGoZVQUAu9opvQ
	(envelope-from <stable+bounces-249484-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 09:41:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5DA57949D
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 09:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3C6FE3024246
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 07:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F0E3D1712;
	Tue, 19 May 2026 07:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HvwsZu2/"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE90337883C
	for <stable@vger.kernel.org>; Tue, 19 May 2026 07:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779176514; cv=none; b=PG9w+OqMdF97avWpg/t0FbO3+8BtI7B8pT6yP7Od6uxxiFs3NL3zl1SjE8SMrr4ExQI7y2aSjxxWigudSkogCM1+1HHSwpPZxEr9l4Hd/DCTWxCD1JAld1IIgTAkSCC9XsmSvz7r9XbPu2jYUKceopIdp52MTNWWRNlyxIxXwLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779176514; c=relaxed/simple;
	bh=3hIsISCVTPH0EQKueOEFFXhsxHwXcccPYq7/eFktsxo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l1lN2idDqa82qaaejZyBFBKFgouLnnqpPlF5WSiaNMRER+tHGEI4BtM2lF4z9zb5t1PR06cAr30Uc00lRJa8LDGrCMYaOa+f9KT+OlShDp7/BXxcmJCDEQq4lrOCBa/jgCvjhBfanQ25Z/0YwkrpgaZOLlonJO4JG9VqB6oj6E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HvwsZu2/; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779176513; x=1810712513;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3hIsISCVTPH0EQKueOEFFXhsxHwXcccPYq7/eFktsxo=;
  b=HvwsZu2/jbUtGTAm/7wEZrhMoT1A0tqEReMAu6GTZK1cFr4pSpQIIfoQ
   tIGp72NZige+jFd4+VyrTyxawaZpAZjeKNhcizsshQFu2gUnFzxp5hqM6
   gL75g0IkEjSUS5MGv9gt85999JNz9c+GsLgVpcnb/MjG5CvLt2qk9nfcd
   ugvmw80PcxZJsAWPQx7xwlma5SpHWKN1NnOYdgGyvy7tyyUUmAQ+2ftEA
   kOsyR+BNKq4Bs3cdYQcZjI6cuTjWnJZ5+ohgS9jDtcRKsYYYD8Z1jC/38
   lFSggxyD/EDGkR8SOa4RoV7aTAb9xwa4FOHbL6hytlBjkmKdkzN4JvtRb
   g==;
X-CSE-ConnectionGUID: 7klRH2VoTUW9i5RWaR2/cA==
X-CSE-MsgGUID: 0iURrRVATESa+Sj6xGccQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="80025910"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="80025910"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 00:41:53 -0700
X-CSE-ConnectionGUID: +QM1njEERKG96iKdipAZoA==
X-CSE-MsgGUID: Guzy/myRTX21HNGvhi/IBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="239561838"
Received: from pranay-x299-aorus-gaming-3-pro.iind.intel.com ([10.223.74.54])
  by orviesa008.jf.intel.com with ESMTP; 19 May 2026 00:41:50 -0700
From: Pranay Samala <pranay.samala@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: karthik.b.s@intel.com,
	sameer.lattannavar@intel.com,
	pranay.samala@intel.com,
	stable@vger.kernel.org,
	Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
	Uma Shankar <uma.shankar@intel.com>
Subject: [PATCH] drm/i915/color: Fix HDR pre-CSC LUT programming loop
Date: Tue, 19 May 2026 13:22:45 +0530
Message-Id: <20260519075245.383864-1-pranay.samala@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249484-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pranay.samala@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CD5DA57949D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The integer lut programming loop never executes completely due to
incorrect condition (i++ > 130).

Fix to properly program 129th+ entries for values > 1.0.

Cc: <stable@vger.kernel.org> #v6.19
Fixes: 82caa1c8813f ("drm/i915/color: Program Pre-CSC registers")
Signed-off-by: Pranay Samala <pranay.samala@intel.com>
Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
---
 drivers/gpu/drm/i915/display/intel_color.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_color.c b/drivers/gpu/drm/i915/display/intel_color.c
index 2d318e922671..3bfe09d81a4c 100644
--- a/drivers/gpu/drm/i915/display/intel_color.c
+++ b/drivers/gpu/drm/i915/display/intel_color.c
@@ -3976,7 +3976,7 @@ xelpd_program_plane_pre_csc_lut(struct intel_dsb *dsb,
 				intel_de_write_dsb(display, dsb,
 						   PLANE_PRE_CSC_GAMC_DATA_ENH(pipe, plane, 0),
 						   (1 << 24));
-			} while (i++ > 130);
+			} while (i++ < 130);
 		} else {
 			for (i = 0; i < lut_size; i++) {
 				u32 v = (i * ((1 << 24) - 1)) / (lut_size - 1);
-- 
2.34.1



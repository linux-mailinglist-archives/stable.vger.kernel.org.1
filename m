Return-Path: <stable+bounces-217492-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MTqGFZRl2kJxAIAu9opvQ
	(envelope-from <stable+bounces-217492-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 19:07:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C33FC161793
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 19:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 343DF301953E
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 18:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7243334C05;
	Thu, 19 Feb 2026 18:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iXSE4pQi"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C69E350A3F
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 18:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771524428; cv=none; b=czKjazI01lXUXSHef4etTozQN08UJBcQS9YC7VgkK7RnaGZdV2YBycd8qa8aN+4LT1XCi9HOQc9usJ+MSNxZsCvrwattQobz/lpE8ahLPLT21Viag3NzCJAv+Zy/xEdRE/8/7l9hL/24YHAYeVFhKlbdvWTZdjFft653KyoxEMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771524428; c=relaxed/simple;
	bh=E5FcJ17P9iYye3aEMUUBS/vcgWA1jvdXZPl9Ol4vIJI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f2Z/VZHgyVidklwV7gAX8GYcnjg2GuTww2KZsX692JvVLiuq20p+wVam05M7oWt07RdHwpLGOtYUWsnUS+UaHyr/wuQLPZmthWI5wmV5rW4UQwl+F28n5HXKakUcvnp6/5ndmWqRd7B+H5ie8FDiLz+H7BGwdVKgcca165UdA20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iXSE4pQi; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771524427; x=1803060427;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E5FcJ17P9iYye3aEMUUBS/vcgWA1jvdXZPl9Ol4vIJI=;
  b=iXSE4pQi2k5bo7aIET3hi3umgHMuGNMFTlCVkGOoc2SEjWBsEsgriHdW
   X+8YlMY2UqgtojIAB6UM46ACPn4h9e5o1wUhMhWvZ+CafIrtpn8XooWrK
   3dej3nqz4EDM7UN66OcHq1GVwVcRa63puoXWXBIyxp7n5zCTNmMydbl5k
   i+RiQ6dsjFle7hYpnSPvzp1QbdCq8Gw+7RyjS3sbAgSt9UkYdPDGpgnnG
   2UInJKF74vizLp38ElRs7kTdZEl4asemaMgZwn58/PBvboIgPKdyzcqPl
   h3AzhB+3/HOfGGAl+cNwjngrltJgZXbInioOAleq6e/VDgvHdDklDBaNf
   A==;
X-CSE-ConnectionGUID: KbCXPU/VREOmZDPEm+IvWA==
X-CSE-MsgGUID: YDi/VJtgQ36i6QR1iGFKUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="76482818"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="76482818"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 10:07:04 -0800
X-CSE-ConnectionGUID: tnKjiCaKTvaiCBKJOU8Q9g==
X-CSE-MsgGUID: SRiQLzqhSSWyyaTCK6ZNxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="245189032"
Received: from guc-pnp-dev-box-1.fm.intel.com ([10.1.39.24])
  by orviesa002.jf.intel.com with ESMTP; 19 Feb 2026 10:07:04 -0800
From: Zhanjun Dong <zhanjun.dong@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Wajdeczko@web.codeaurora.org,
	Michal <Michal.Wajdeczko@intel.com>,
	Zhanjun Dong <zhanjun.dong@intel.com>, stable@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>
Subject: [PATCH v7 5/7] drm/xe/guc: Ensure CT state transitions via STOP before DISABLED
Date: Thu, 19 Feb 2026 13:06:59 -0500
Message-Id: <20260219180701.2418453-6-zhanjun.dong@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260219180701.2418453-1-zhanjun.dong@intel.com>
References: <20260219180701.2418453-1-zhanjun.dong@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	R_DKIM_REJECT(1.00)[intel.com:s=Intel];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[intel.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217492-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[zhanjun.dong@intel.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:-];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.980];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:email]
X-Rspamd-Queue-Id: C33FC161793
X-Rspamd-Action: no action

The GuC CT state transition requires moving to the STOP state before
entering the DISABLED state. Update the driver teardown sequence to make
the proper state machine transitions.

Fixes: ee4b32220a6b ("drm/xe/guc: Add devm release action to safely tear down CT")
Cc: stable@vger.kernel.org
Signed-off-by: Zhanjun Dong <zhanjun.dong@intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_guc_ct.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
index 8a45573f8812..7e66e9420f5d 100644
--- a/drivers/gpu/drm/xe/xe_guc_ct.c
+++ b/drivers/gpu/drm/xe/xe_guc_ct.c
@@ -346,6 +346,7 @@ static void guc_action_disable_ct(void *arg)
 {
 	struct xe_guc_ct *ct = arg;
 
+	xe_guc_ct_stop(ct);
 	guc_ct_change_state(ct, XE_GUC_CT_STATE_DISABLED);
 }
 
-- 
2.34.1



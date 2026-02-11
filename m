Return-Path: <stable+bounces-215883-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBiAE7IAjWnAwwAAu9opvQ
	(envelope-from <stable+bounces-215883-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 23:20:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E174812813A
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 23:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75D6F30C1852
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 22:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64256326D55;
	Wed, 11 Feb 2026 22:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IVKmGlm1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FF829D297
	for <stable@vger.kernel.org>; Wed, 11 Feb 2026 22:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770848428; cv=none; b=l7deMjT/GF9b0fqrHcceQQs1/bGPrI+ouRqFS69xeLnSvNH3M2ABaMW3F/rJX3rnf9dD8AqnVQ8WWAiyVmVg4ZnBT/r8dTuCq85oYYQXrM7EqCsNCir9hN9U/kyzXjJcU/g86NSdLK6KBfIjy8kBxmUzWA52z/Lo1qAhRBXvL7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770848428; c=relaxed/simple;
	bh=E5FcJ17P9iYye3aEMUUBS/vcgWA1jvdXZPl9Ol4vIJI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TmSlo8y4vmRMhXfYMeTbUBS4ezqkSzsG0N1I3D6CuF9uvqWjc4Flx47MFaA25k7mBJF8ZX0+wEXXLlw5m6fysrrz00cVK5Mjp9EbOAwFjrU2FDk+T6/0p0GxjiT4qI+uIrIBJcOFpud+BRFAN5xPL7udZBAO6D5XtqL3DqEt1lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IVKmGlm1; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770848427; x=1802384427;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E5FcJ17P9iYye3aEMUUBS/vcgWA1jvdXZPl9Ol4vIJI=;
  b=IVKmGlm1YauKKpQRaeWidu/dBWSTMyq+z02JsDD9yYamTWPcQZe5BcMR
   rqu2neXfX+Zw3s56Em1+gvAHdAM3ZGIw1uLZV8LwDYOSvSCyCjhyly79/
   oghneYa7n7zfd4XXb1xPCrKItrtTbkTi1kZwt0Go2GPkWY3hKiysZxL8o
   Lz1slrwuXHT/mQSbb8y87lEITJdG3wTFld91ad32qS4GTeodVrye3m42S
   CEVOg07wRNT84lhSdZUdHH8w/fRUywbVrCGZQA5LomugzCzLcAJGjFlz5
   D0xt1QjYaFxyZuP/uOH9e77lrfEh9k0jzy+0MJpiBbBz59g5JV5q2R5m3
   A==;
X-CSE-ConnectionGUID: RnIgxSX9QT+G6BdwPlW+fw==
X-CSE-MsgGUID: FYjr8zU0Tgigp+Xwv/fdmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="89415214"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; 
   d="scan'208";a="89415214"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 14:20:24 -0800
X-CSE-ConnectionGUID: e0KQ5ZhFSSyS1YlNiPY6zg==
X-CSE-MsgGUID: AvYTqw8+Sq6229UpaJrKfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; 
   d="scan'208";a="212479589"
Received: from guc-pnp-dev-box-1.fm.intel.com ([10.1.39.24])
  by orviesa007.jf.intel.com with ESMTP; 11 Feb 2026 14:20:24 -0800
From: Zhanjun Dong <zhanjun.dong@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Zhanjun Dong <zhanjun.dong@intel.com>,
	stable@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>
Subject: [PATCH v6 5/6] drm/xe/guc: Ensure CT state transitions via STOP before DISABLED
Date: Wed, 11 Feb 2026 17:20:19 -0500
Message-Id: <20260211222020.848341-6-zhanjun.dong@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260211222020.848341-1-zhanjun.dong@intel.com>
References: <20260211222020.848341-1-zhanjun.dong@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-215883-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhanjun.dong@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E174812813A
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



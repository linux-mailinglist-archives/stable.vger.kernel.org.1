Return-Path: <stable+bounces-256564-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEhqFr9YGWqtvggAu9opvQ
	(envelope-from <stable+bounces-256564-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 11:13:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F915FFBF4
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 11:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56FA6309B52F
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 09:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2FE3BA25E;
	Fri, 29 May 2026 09:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IduQ1uEA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0633AFAEA
	for <stable@vger.kernel.org>; Fri, 29 May 2026 09:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780045614; cv=none; b=rogA+Mhywzp6/uxcR2qaCNjFWUUejIH7UToL+eQt7HHkOFlMZLSwHMtPmWGTviOCwRm1qtPKZNcYZh4ZJn5MLFllUl29q/XUEBnMvv7G/ld9cTjI8QNehMy4hPhybYcnDEKvw+z3X6HioNLLDFr2mLEZTiMbyMQmsT/hf+RVpSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780045614; c=relaxed/simple;
	bh=vsJULIgCzsHGDamx1IlbHt6HaQRnN7wQJmkLT6lhAfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gJNX5yPlQZhQjB7oHbV5+PLGSf0/caaGQWsabQk2nJyLFd+wtmZc0l496t4k8MkPFV4qBh5thkFJezqcRCvyXbpB3qCE1NBjcAz21YC5A3iNtLb0iJBRyaF/76xTYPBlMk0Qal9c5Sp9Cv8EpsWHHs9hIrzCMQa1IoepSjITuIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IduQ1uEA; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780045613; x=1811581613;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vsJULIgCzsHGDamx1IlbHt6HaQRnN7wQJmkLT6lhAfA=;
  b=IduQ1uEAUhf0ViyWHn2Jxy81fNjEC62I9pxYxxVDmfes2F76RK614GTy
   e8adLnj+4t/BX4PGCTzzEHu5y9XQAOlgFISxhX+YXce1niwfpcaAv+nx0
   91OsEMP3N5t5NzAfq406dwD7IMplL6KcNP1hSVnQLpDvbS6zpNGh1ViC/
   u14DumgyFmNqO21bbewGpSyf0/tYivy+EEKaHfLPu4MTjBh8YXpuKWQt4
   YYDyjHRIChpZbzpOsMU6SK/gGzeS8HYJmrADSXfvjCiVHRxdu/JbYHlP4
   ggT57/ukPxZCtUftm3YYl12WOpcLABcSDYvuq0O9sDwlX23/fsAbterQI
   Q==;
X-CSE-ConnectionGUID: vNQx9hNPR0W8s1brSasosg==
X-CSE-MsgGUID: aGJZLh2JRtWb+M2y+TPJ2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="84520487"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="84520487"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 02:06:53 -0700
X-CSE-ConnectionGUID: lCceyK97Tka3FM2WnN66pw==
X-CSE-MsgGUID: B+UjVnl/RTizL8xw6TxjsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="241987028"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO jhogande-mobl3.intel.com) ([10.245.246.54])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 02:06:51 -0700
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Subject: [PATCH 6.6.y 1/4] drm/i915/psr: Add defininitions for INTEL_WA_REGISTER_CAPS DPCD register
Date: Fri, 29 May 2026 12:06:33 +0300
Message-ID: <20260529090636.530204-1-jouni.hogander@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026052827-tweezers-colonize-3631@gregkh>
References: <2026052827-tweezers-colonize-3631@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256564-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jouni.hogander@intel.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ursulin.net:email,intel.com:email,intel.com:mid,intel.com:dkim,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A8F915FFBF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit fbceb39b536e40c2f7cc47ab42037bb7c2b7ced9 upstream.

EDP specification says:

"If either VSC SDP is unable to be transmitted 100 ns before the SU region,
the Source device may optionally transmit the VSC SDP during the prior
video scan line’s HBlank period There is a Intel specific drm dp register
currently containing bits related how TCON can support PSR2 with SDP on
prior line."

Unfortunately many panels are having problems in implementing this. So
there is a custom Intel specific DPCD register (INTEL_WA_REGISTER_CAPS) to
figure out if this is properly implemented on a panel or if panel doesn't
require that 100 ns delay before the SU region. Here are the definitions in
this custom DPCD address:

0 = Panel doesn't support SDP on prior line
1 = Panel supports SDP on prior line
2 = Panel doesn't have 100ns requirement
3 = Reserved

Add definitions for this new register and it's values into new header
intel_dpcd.h.

v2: add INTEL_DPCD_ prefix to definitions

Bspec: 74741
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Link: https://patch.msgid.link/20260515095756.2799483-2-jouni.hogander@intel.com
(cherry picked from commit 1da1c9294825f08f622c473480d185680c2a3b75)
Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>
---
 drivers/gpu/drm/i915/display/intel_dpcd.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 drivers/gpu/drm/i915/display/intel_dpcd.h

diff --git a/drivers/gpu/drm/i915/display/intel_dpcd.h b/drivers/gpu/drm/i915/display/intel_dpcd.h
new file mode 100644
index 000000000000..4aea5326f2ed
--- /dev/null
+++ b/drivers/gpu/drm/i915/display/intel_dpcd.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright © 2026 Intel Corporation
+ */
+
+#ifndef __INTEL_DPCD_H__
+#define __INTEL_DPCD_H__
+
+#define INTEL_DPCD_INTEL_WA_REGISTER_CAPS					0x3f0
+# define INTEL_DPCD_INTEL_WA_REGISTER_CAPS_PSR2_EARLYSCANLINE_SDP_SUPPORT_MASK	REG_GENMASK(1, 0)
+# define INTEL_DPCD_INTEL_WA_REGISTER_CAPS_FALL_BACK_TO_PSR1			0
+# define INTEL_DPCD_INTEL_WA_REGISTER_CAPS_PSR2_WITH_EARLY_SCANLINE		1
+# define INTEL_DPCD_INTEL_WA_REGISTER_CAPS_PSR2_WITHOUT_EARLY_SCANLINE		2
+
+#endif /* __INTEL_DPCD_H__ */
-- 
2.43.0



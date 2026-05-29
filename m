Return-Path: <stable+bounces-256594-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPyWKp9tGWpzwggAu9opvQ
	(envelope-from <stable+bounces-256594-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 12:42:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72304600FF7
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 12:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A026F3013D62
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 10:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28703C456B;
	Fri, 29 May 2026 10:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E2PxU0E1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF843C061C
	for <stable@vger.kernel.org>; Fri, 29 May 2026 10:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780051340; cv=none; b=VfX9mRJEpFjhro5DygwsU0eZcNNlZtTVO7PpYR6un7Q4qZ5WdlbnyCoecWzvjVzNygvAF/wxdgH4Ds9knpSQX/29D2hJQB//gp6171769B57CGbnUeguKPElPsu4EcvjpI+pBzQtCTduFXTTMEx5O/EcyN8uHN05cpeBL5C5W30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780051340; c=relaxed/simple;
	bh=vsJULIgCzsHGDamx1IlbHt6HaQRnN7wQJmkLT6lhAfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pAYt8khUv12Qs5nhMvJ0md4oSAnRKB694P7jX25SOrK5TGUesEroK+BGaRN+8wisHwnPyUJH4NBr1awS0MzheP6LQBnZX9nYX4mRxLVjD8HZ1MmdQj7X4uwjmxoudA6/fmBMkeVT3WhX8jyIYZifgnSrMppHdguQMGxKr7tpAiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E2PxU0E1; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780051339; x=1811587339;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vsJULIgCzsHGDamx1IlbHt6HaQRnN7wQJmkLT6lhAfA=;
  b=E2PxU0E15u/2m/nEu/MxnVgFsYddB+fU1kae4eq8C0KSNrRpZiiqiAPN
   QOxMB6+ng/zHqwNy+gg0tlnkqZnxvgBPujwP3wGMNm5HCj9oREGFcXgQx
   xuaQNcJpJs5WqVCXQNd+4EToJrOv30JWjA1NyThgu94jnj3GUqG+V7khr
   AkIMNLOBvrReBBVBgMLhuAWVYiBn/Q5AphwNRwgUZhDq4Ri6G3HZri7fg
   EanIQlNmaTpplpjV17cztoKnli6PUOsCIk0m4/ZURbsYVpSG8e03MOaEm
   mTyE/KG105YvKqoaE2kYf1mW12jd0HnfPkqKje6YIe6F+qvDbxw9q0dfs
   w==;
X-CSE-ConnectionGUID: JljW5D/uSzCxCabGef+fqw==
X-CSE-MsgGUID: 5vEHl+6gQoeM0NljASp5LQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="92376489"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="92376489"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 03:42:19 -0700
X-CSE-ConnectionGUID: BK0841AkQRGPoamMV5KIjA==
X-CSE-MsgGUID: DAct2jNvSCyk+sRtzx00CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="238625152"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO jhogande-mobl3.intel.com) ([10.245.246.54])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 03:42:17 -0700
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Subject: [PATCH 6.12.y 1/4] drm/i915/psr: Add defininitions for INTEL_WA_REGISTER_CAPS DPCD register
Date: Fri, 29 May 2026 13:42:03 +0300
Message-ID: <20260529104206.758103-1-jouni.hogander@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026052816-harvest-stinking-041d@gregkh>
References: <2026052816-harvest-stinking-041d@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256594-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:email,intel.com:mid,intel.com:dkim,msgid.link:url,ursulin.net:email]
X-Rspamd-Queue-Id: 72304600FF7
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



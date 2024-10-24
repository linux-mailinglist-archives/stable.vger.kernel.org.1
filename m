Return-Path: <stable+bounces-87994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E48519ADA90
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 05:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69DFF1F22311
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 03:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFD516F0CA;
	Thu, 24 Oct 2024 03:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dWNTIWN2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB34416DEA2
	for <stable@vger.kernel.org>; Thu, 24 Oct 2024 03:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729741143; cv=none; b=Lk18EjNAsOU2+Hd9GlO2GdFf5N/zhRk/v4PS3GsR/hk4uNSqd9C4WJvSdidV/h0fURi8KmqfK9HyGB+uorIwewnntYixkQHV5cxTTXRjuwufRsJyc4WheeQcE0a/VaqoEJ6SyDG/GmxzONMFQL1G6gLLviqI0XUUR3wbfIJCQi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729741143; c=relaxed/simple;
	bh=SMW858yUWIZGzbbyNCclHnGdcNjjQZ/SbNFjcDswCrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rWetRQ5aaNqT6tu/hw4q03qi+nyAxKMZiy2cD0vVJsPACEu0CTbhhjNrHOhRfwy050RVhIjMcjrAX6t4VCMXrDpsqQJZhlcKZKGWZf1riy2KT16J7DSMowPvUrX9W6WByLeNtyK9JmNr72noYkaaNq6bHqzzgw31QacAmNaE2E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dWNTIWN2; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729741142; x=1761277142;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SMW858yUWIZGzbbyNCclHnGdcNjjQZ/SbNFjcDswCrI=;
  b=dWNTIWN2pkx0RyTpMk8YFOtmyVUtcE611Q81G7NeGOyXQDs1bMzOzBT8
   TaSagV1uzzqVpzKoQD6qkytVCx5bdy3lK85T6T+MzYfv0Zm4lASwT28yp
   Q/cidN33Vsxi7dKmriBuX2uDfqkVOzyo0Q5XUtymhMbu5o6a4BxfQjzcn
   6t82X2iUPb0YbGPGhDSAiHaGZJsk3UglFIolgqS8n5M43KNb9fKP3NJCM
   t4Zq8SVdpsTM1nQsnvRwR1zt3RrjFmgxJhQj7LAW/c37nluv4XTcjWRPw
   QkHlSDj1ni7LsRodUeCsSPsy6rmyqNoinyZsgFn3O75bpCqG6gHxAUWmO
   g==;
X-CSE-ConnectionGUID: k65Vn8wFS+uMQmwyDwDt0A==
X-CSE-MsgGUID: j1A1o9CcTzmOGWj64mSmYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="33264999"
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="33264999"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 20:38:52 -0700
X-CSE-ConnectionGUID: nKko0iYUQoCMNqlmu9ZEDw==
X-CSE-MsgGUID: zp2aZgH0Taq6xg4ERESvXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="80384977"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 20:38:50 -0700
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH xe-i915-for-6.11 14/22] drm/xe: Support 'nomodeset' kernel command-line option
Date: Wed, 23 Oct 2024 20:38:06 -0700
Message-ID: <20241024033815.3538736-14-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024033815.3538736-1-lucas.demarchi@intel.com>
References: <20241024033815.3538736-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Zimmermann <tzimmermann@suse.de>

commit 014125c64d09e58e90dde49fbb57d802a13e2559 upstream.

Setting 'nomodeset' on the kernel command line disables all graphics
drivers with modesetting capabilities, leaving only firmware drivers,
such as simpledrm or efifb.

Most DRM drivers automatically support 'nomodeset' via DRM's module
helper macros. In xe, which uses regular module_init(), manually call
drm_firmware_drivers_only() to test for 'nomodeset'. Do not register
the driver if set.

v2:
- use xe's init table (Lucas)
- do NULL test for init/exit functions

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240827121003.97429-1-tzimmermann@suse.de
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/xe_module.c | 39 +++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_module.c b/drivers/gpu/drm/xe/xe_module.c
index 499540add465a..464ec24e2dd20 100644
--- a/drivers/gpu/drm/xe/xe_module.c
+++ b/drivers/gpu/drm/xe/xe_module.c
@@ -8,6 +8,8 @@
 #include <linux/init.h>
 #include <linux/module.h>
 
+#include <drm/drm_module.h>
+
 #include "xe_drv.h"
 #include "xe_hw_fence.h"
 #include "xe_pci.h"
@@ -61,12 +63,23 @@ module_param_named_unsafe(wedged_mode, xe_modparam.wedged_mode, int, 0600);
 MODULE_PARM_DESC(wedged_mode,
 		 "Module's default policy for the wedged mode - 0=never, 1=upon-critical-errors[default], 2=upon-any-hang");
 
+static int xe_check_nomodeset(void)
+{
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
+	return 0;
+}
+
 struct init_funcs {
 	int (*init)(void);
 	void (*exit)(void);
 };
 
 static const struct init_funcs init_funcs[] = {
+	{
+		.init = xe_check_nomodeset,
+	},
 	{
 		.init = xe_hw_fence_module_init,
 		.exit = xe_hw_fence_module_exit,
@@ -85,15 +98,35 @@ static const struct init_funcs init_funcs[] = {
 	},
 };
 
+static int __init xe_call_init_func(unsigned int i)
+{
+	if (WARN_ON(i >= ARRAY_SIZE(init_funcs)))
+		return 0;
+	if (!init_funcs[i].init)
+		return 0;
+
+	return init_funcs[i].init();
+}
+
+static void xe_call_exit_func(unsigned int i)
+{
+	if (WARN_ON(i >= ARRAY_SIZE(init_funcs)))
+		return;
+	if (!init_funcs[i].exit)
+		return;
+
+	init_funcs[i].exit();
+}
+
 static int __init xe_init(void)
 {
 	int err, i;
 
 	for (i = 0; i < ARRAY_SIZE(init_funcs); i++) {
-		err = init_funcs[i].init();
+		err = xe_call_init_func(i);
 		if (err) {
 			while (i--)
-				init_funcs[i].exit();
+				xe_call_exit_func(i);
 			return err;
 		}
 	}
@@ -106,7 +139,7 @@ static void __exit xe_exit(void)
 	int i;
 
 	for (i = ARRAY_SIZE(init_funcs) - 1; i >= 0; i--)
-		init_funcs[i].exit();
+		xe_call_exit_func(i);
 }
 
 module_init(xe_init);
-- 
2.47.0



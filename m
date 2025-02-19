Return-Path: <stable+bounces-118264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA0CA3BF8C
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 14:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 291141752E5
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 13:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893481DF724;
	Wed, 19 Feb 2025 13:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GdiNPkgN"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C63B1E47A5;
	Wed, 19 Feb 2025 13:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739970604; cv=none; b=nC+EjKWics7B6mZqWd1UgdUnha/XiMXiaGqzKOAzz+47IY/1ErC3a3JgD8hoGn7uFv7kzJPqNQg46L02vTXJA7CUwHWaH+M7aq7+ueK0CiSK+eE55XgrcGet17fIK3KYUFQsvkuAGG7GcWat3TI2OP/KuAT0rdEwWcrtqXkg+/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739970604; c=relaxed/simple;
	bh=hhInF30wke/UovUOXAo1FFA7iYgBOW3/hkzvAoWVCCY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jUYFsdncAetgUE2v3s5vDxTCo4KQegDa9QCf/+QVVG3Yn2e6TkLQtCXapxvG1YEzrDS8vOJKA/aEISxlPFujHPE3YQftIX07bZOWavOCkRfOTbs9xa4pCVrDrGS1PxXdxLGDfLWDow1wpgadtHpU5xS+df8/i2kT8jPBygolgNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GdiNPkgN; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Huuvv
	E5ZoWF1UAGvFneCadtnRZGO01ETPd9/BIZRpBI=; b=GdiNPkgNIWJq9fxfCpCgQ
	bQ1qbXV4JfrXThmi+r3MCVsIWpF5HckJQy3bnBRp+n83HrvehZpfEFN57v+L+uej
	ri2TxtBfhnc+b7DkfRoUF/DePXhvnaGnuAVpvnmzUA3xcgUmi93lngAdOI8lsFD5
	+9bu5JNfV9insVqH5dAohg=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wB3yiyy17VnoJLHNA--.52215S4;
	Wed, 19 Feb 2025 21:08:03 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: jani.nikula@linux.intel.com,
	rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com,
	tursulin@ursulin.net,
	airlied@gmail.com,
	simona@ffwll.ch,
	gustavo.sousa@intel.com
Cc: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/display: Add check for alloc_ordered_workqueue() and alloc_workqueue()
Date: Wed, 19 Feb 2025 21:08:00 +0800
Message-Id: <20250219130800.2638016-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3yiyy17VnoJLHNA--.52215S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw4kKFy7ArykKF47tr4rAFb_yoWkKrbEkF
	WrZr1xGry5C3ZruF1UCrn3uryFvr4Yyry8AryxtryYyr47Kw10vrWkZr15Xw1rAFy3AFWq
	93W8WF1kAws7WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNvtCUUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/1tbiqBH4bme10+BHjQAAsE

Add check for the return value of alloc_ordered_workqueue()
and alloc_workqueue() to catch potential exception.

Fixes: 40053823baad ("drm/i915/display: move modeset probe/remove functions to intel_display_driver.c")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/gpu/drm/i915/display/intel_display_driver.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_display_driver.c b/drivers/gpu/drm/i915/display/intel_display_driver.c
index 50ec0c3c7588..dfe5b779aefd 100644
--- a/drivers/gpu/drm/i915/display/intel_display_driver.c
+++ b/drivers/gpu/drm/i915/display/intel_display_driver.c
@@ -245,6 +245,11 @@ int intel_display_driver_probe_noirq(struct intel_display *display)
 						WQ_UNBOUND, WQ_UNBOUND_MAX_ACTIVE);
 	display->wq.cleanup = alloc_workqueue("i915_cleanup", WQ_HIGHPRI, 0);
 
+	if (!display->wq.modeset || !display->wq.flip || !display->wq.cleanup) {
+		ret = -ENOMEM;
+		goto cleanup_vga_client_pw_domain_dmc;
+	}
+
 	intel_mode_config_init(display);
 
 	ret = intel_cdclk_init(display);
-- 
2.25.1



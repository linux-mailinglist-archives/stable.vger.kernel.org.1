Return-Path: <stable+bounces-136498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C5BA99F02
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 04:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E756E1946B8E
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 02:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250DE19CC3D;
	Thu, 24 Apr 2025 02:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LKodL/4w"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21C91A4F12;
	Thu, 24 Apr 2025 02:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745463375; cv=none; b=oXHISJ95YwN8bitzEjSPsUG6TlG7LDLzLJuqEA0It/9K3nY1f5cXRRxAnwIFgjfKG0H9fybcG7RgRJg1EDDad3jTPd43SliS43cNCg5NtWY3vTX3wqs5i8+IWOuLztKC5M7a8+YwRPX/5bwK3dR3wHMFLLKyT74A80iNAaY61E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745463375; c=relaxed/simple;
	bh=3g+VyygBY32+8LDEI0khE/JAkeRjxxSE7M9xcwEsscY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X78ZPJFi5RZN9BylZ+Sgv5B3KZcQM7kZsWk8xdQW1zo9utj1r8BUIh6KQqQc8beDZQn/b6GUNbKUh70Y4/FG+Wivo6YjX/by/umQ2lP0Wktrt0ctIHJlykMJ/Zgr0qyvofUmASB5+VgQrEmPQe6fSFAhj1EktljkmKz5vbVtHMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LKodL/4w; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ZyWGd
	L4fQntO+YSj4uhZTWjk9DIBPdHQjqeylVNy+pc=; b=LKodL/4w1+PguPYD/a3LM
	SjgoRzu9HO0CRJT7QC+pduMeRqc/IC5iSvLCYK8vK16Dego7BtrD7pwNObI6ExLH
	MAuT7PpH+VlN/yHbinMKwsdpkl48RooPbuUhdgmVoq0+ClJ1UynBEXuvV9WloZwf
	MeFZBi1SkGVYnVqC6BbxAc=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wB3U1csqAloHYubCA--.21713S4;
	Thu, 24 Apr 2025 10:55:42 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: rodrigo.vivi@intel.com,
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
Subject: [PATCH v2 RESEND] drm/i915/display: Add check for alloc_ordered_workqueue() and alloc_workqueue()
Date: Thu, 24 Apr 2025 10:55:39 +0800
Message-Id: <20250424025539.3504019-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3U1csqAloHYubCA--.21713S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF4xGw1xAF18WrykKryfZwb_yoW5Ar1xpw
	4fXFyUArW5XFs2kay7Xa18uFyxW3409w15GF1fC3Wqq3WUAw4jg3W0kFyUXryDGF1xXF1f
	AFWqyF429r1DCF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pimhF7UUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/1tbiqAQ5bmgJpmBSsgAAs8

Add check for the return value of alloc_ordered_workqueue()
and alloc_workqueue(). Furthermore, if some allocations fail,
cleanup works are added to avoid potential memory leak problem.

Fixes: 40053823baad ("drm/i915/display: move modeset probe/remove functions to intel_display_driver.c")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
Changes in v2:
- Split the compound conditional statement into separate
  conditional statements to facilitate cleanup works.
- Add cleanup works to destory work queues if allocations fail,
  and modify the later goto destination to do the full excercise.
- modify the patch description. Thanks, Jani!
---
 .../drm/i915/display/intel_display_driver.c   | 30 +++++++++++++++----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_driver.c b/drivers/gpu/drm/i915/display/intel_display_driver.c
index 31740a677dd8..ac94561715dc 100644
--- a/drivers/gpu/drm/i915/display/intel_display_driver.c
+++ b/drivers/gpu/drm/i915/display/intel_display_driver.c
@@ -241,31 +241,45 @@ int intel_display_driver_probe_noirq(struct intel_display *display)
 	intel_dmc_init(display);
 
 	display->wq.modeset = alloc_ordered_workqueue("i915_modeset", 0);
+	if (!display->wq.modeset) {
+		ret = -ENOMEM;
+		goto cleanup_vga_client_pw_domain_dmc;
+	}
+
 	display->wq.flip = alloc_workqueue("i915_flip", WQ_HIGHPRI |
 						WQ_UNBOUND, WQ_UNBOUND_MAX_ACTIVE);
+	if (!display->wq.flip) {
+		ret = -ENOMEM;
+		goto cleanup_wq_modeset;
+	}
+
 	display->wq.cleanup = alloc_workqueue("i915_cleanup", WQ_HIGHPRI, 0);
+	if (!display->wq.cleanup) {
+		ret = -ENOMEM;
+		goto cleanup_wq_flip;
+	}
 
 	intel_mode_config_init(display);
 
 	ret = intel_cdclk_init(display);
 	if (ret)
-		goto cleanup_vga_client_pw_domain_dmc;
+		goto cleanup_wq_cleanup;
 
 	ret = intel_color_init(display);
 	if (ret)
-		goto cleanup_vga_client_pw_domain_dmc;
+		goto cleanup_wq_cleanup;
 
 	ret = intel_dbuf_init(i915);
 	if (ret)
-		goto cleanup_vga_client_pw_domain_dmc;
+		goto cleanup_wq_cleanup;
 
 	ret = intel_bw_init(i915);
 	if (ret)
-		goto cleanup_vga_client_pw_domain_dmc;
+		goto cleanup_wq_cleanup;
 
 	ret = intel_pmdemand_init(display);
 	if (ret)
-		goto cleanup_vga_client_pw_domain_dmc;
+		goto cleanup_wq_cleanup;
 
 	intel_init_quirks(display);
 
@@ -273,6 +287,12 @@ int intel_display_driver_probe_noirq(struct intel_display *display)
 
 	return 0;
 
+cleanup_wq_cleanup:
+	destroy_workqueue(display->wq.cleanup);
+cleanup_wq_flip:
+	destroy_workqueue(display->wq.flip);
+cleanup_wq_modeset:
+	destroy_workqueue(display->wq.modeset);
 cleanup_vga_client_pw_domain_dmc:
 	intel_dmc_fini(display);
 	intel_power_domains_driver_remove(display);
-- 
2.25.1



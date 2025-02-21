Return-Path: <stable+bounces-118541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F16FA3EADA
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 03:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CB9A17D746
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 02:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C324F1CAA87;
	Fri, 21 Feb 2025 02:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SdXS1/bA"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7461367;
	Fri, 21 Feb 2025 02:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740105555; cv=none; b=mJUQHKgKieS30+/iQS7AkkxMxUckAGk5G+dBHxlAfxlNZyKMXKFq0RIrEl08chkeHcAc0bE2Q9OTtkeae/jW2LV4M5YT8b1CGTPAvvj/Ts7pwbcxmHRKDYGLMYrrwhhsgFFJ1YRh1Dt+6SoyRp/bI4HYx3wxvU8TgzwKVMvpOlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740105555; c=relaxed/simple;
	bh=iTC7ITf6jOnAo+xKK1w+9w/KAcoJxPAdKeNh+df0Fx0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PvA5AQ58ww2f3ELiEjREjn4wefTuShuhBfkXwUzjQmb9J25Jsg3L23EWl7KffU4SGMnnQfA6sQxqj7CriLDTvJs2jf61KTdKfwMe/zD14vK1MvJV9SYr9/s5CWuCmM0LOwGf+7DWSqbRG2jzjEU1RR4iiqmRFFIMKEKjROJLOW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SdXS1/bA; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=/f7AI
	zZ1TrU8hxNz23pogo7bbfU7wlUsam29chQ5ZDA=; b=SdXS1/bA0fqGHJD2/ax5A
	I9wuwLqoZ+6XARK2wL/z9D1w0wgrDe5foMkWL91nsCAsJ3zhsd+RLtQDKYuyqJea
	nP1D0NAPKwSdGZTtpibi73kdVU95fYLpFIjUNzopGapU4O/aRQUaLtys9HYYV202
	J7rAfW/b6EEtucxhnSPqqs=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgDHnpc457dn82KsEg--.4363S4;
	Fri, 21 Feb 2025 10:38:49 +0800 (CST)
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
Subject: [PATCH v2] drm/i915/display: Add check for alloc_ordered_workqueue() and alloc_workqueue()
Date: Fri, 21 Feb 2025 10:38:46 +0800
Message-Id: <20250221023846.2727311-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgDHnpc457dn82KsEg--.4363S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF4xGw1xAF18WrykKryfZwb_yoW5Ar17pa
	1fXFyUAFW5XFs2kay7Xa18uFyxW3409w15GF1fC3Wqq3WUAw4qg3W09F1UXryDGF1xXF1f
	AFWqyF429r1qkF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piPCztUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/1tbiqBf5bme23pywzwADsH

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
 .../drm/i915/display/intel_display_driver.c   | 29 +++++++++++++++----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_driver.c b/drivers/gpu/drm/i915/display/intel_display_driver.c
index 50ec0c3c7588..0b9971a5626b 100644
--- a/drivers/gpu/drm/i915/display/intel_display_driver.c
+++ b/drivers/gpu/drm/i915/display/intel_display_driver.c
@@ -241,31 +241,44 @@ int intel_display_driver_probe_noirq(struct intel_display *display)
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
 
@@ -273,6 +286,12 @@ int intel_display_driver_probe_noirq(struct intel_display *display)
 
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



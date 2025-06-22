Return-Path: <stable+bounces-155244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC49AAE2EED
	for <lists+stable@lfdr.de>; Sun, 22 Jun 2025 11:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86A3B1893067
	for <lists+stable@lfdr.de>; Sun, 22 Jun 2025 09:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1521A3161;
	Sun, 22 Jun 2025 09:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qXSco/kW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7551A315D
	for <stable@vger.kernel.org>; Sun, 22 Jun 2025 09:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750583152; cv=none; b=NqUD1m7bvZBwNtWB0XPaYht6rMaImzuu7FJcUB2HmcnjMBuaGNvq9Zk3j2WtXZE8cX5CcBLINr7SrReMfOifsSCatgicE28Qm9li1w2g3AcPVuaao7RMaskhiSYdrlOy88eZ0Rqor9I9Nx/wR8+3Px6vKaIOjvrInl6Nkeh9mfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750583152; c=relaxed/simple;
	bh=3Ig5PblYSLFDx659O6hJFEp2VcE0NozHIxmI/8zqsdY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=V4FzTzP7jCMK8GYV7sMXgC4WGpjJj9hvO3sdrGQqz2me8nuPHtTmWABn109Js8PHsHZ7jnHvEJXxwbia12RMivf4lo6EX0pX2wXdaCtOsRmUuqeiz47b4JXMf1utQ4stOMpP9330zMzofbQPFHlEQ3vZlQxfifoXu/2IJ5Mqmcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qXSco/kW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C731C4CEE3;
	Sun, 22 Jun 2025 09:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750583152;
	bh=3Ig5PblYSLFDx659O6hJFEp2VcE0NozHIxmI/8zqsdY=;
	h=Subject:To:Cc:From:Date:From;
	b=qXSco/kWrMBA9cyPy/FNFW9hYAE3o487pUz1ILzs/BvHrgwDwa4bp/tK5/e9agf/T
	 z5MPZc3LovVWQjiBJg127tnyJSxHJ4g1HFZzAt2cDPHQ/Kp9C6FHzr1sVVktc3tZ+l
	 7BDwtZUg6X9ueoT15x9aydfmUhHZD1Na1AMW7fD0=
Subject: FAILED: patch "[PATCH] drm/i915/display: Add check for alloc_ordered_workqueue() and" failed to apply to 6.12-stable tree
To: haoxiang_li2024@163.com,jani.nikula@intel.com,joonas.lahtinen@linux.intel.com,matthew.auld@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 22 Jun 2025 11:05:39 +0200
Message-ID: <2025062239-playful-huff-6d2b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x f4c7baa0699b69edb6887a992283b389761e0e81
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062239-playful-huff-6d2b@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f4c7baa0699b69edb6887a992283b389761e0e81 Mon Sep 17 00:00:00 2001
From: Haoxiang Li <haoxiang_li2024@163.com>
Date: Fri, 16 May 2025 15:16:54 +0300
Subject: [PATCH] drm/i915/display: Add check for alloc_ordered_workqueue() and
 alloc_workqueue()

Add check for the return value of alloc_ordered_workqueue()
and alloc_workqueue(). Furthermore, if some allocations fail,
cleanup works are added to avoid potential memory leak problem.

Fixes: 40053823baad ("drm/i915/display: move modeset probe/remove functions to intel_display_driver.c")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Link: https://lore.kernel.org/r/20d3d096c6a4907636f8a1389b3b4dd753ca356e.1747397638.git.jani.nikula@intel.com
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
(cherry picked from commit dcab7a228f4ea9cda3f5b0a1f0679e046d23d7f7)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>

diff --git a/drivers/gpu/drm/i915/display/intel_display_driver.c b/drivers/gpu/drm/i915/display/intel_display_driver.c
index 5c74ab5fd1aa..411fe7b918a7 100644
--- a/drivers/gpu/drm/i915/display/intel_display_driver.c
+++ b/drivers/gpu/drm/i915/display/intel_display_driver.c
@@ -244,31 +244,45 @@ int intel_display_driver_probe_noirq(struct intel_display *display)
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
 
 	ret = intel_dbuf_init(display);
 	if (ret)
-		goto cleanup_vga_client_pw_domain_dmc;
+		goto cleanup_wq_cleanup;
 
 	ret = intel_bw_init(display);
 	if (ret)
-		goto cleanup_vga_client_pw_domain_dmc;
+		goto cleanup_wq_cleanup;
 
 	ret = intel_pmdemand_init(display);
 	if (ret)
-		goto cleanup_vga_client_pw_domain_dmc;
+		goto cleanup_wq_cleanup;
 
 	intel_init_quirks(display);
 
@@ -276,6 +290,12 @@ int intel_display_driver_probe_noirq(struct intel_display *display)
 
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



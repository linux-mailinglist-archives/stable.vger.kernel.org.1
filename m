Return-Path: <stable+bounces-1004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 731E47F7D85
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 096F62811AC
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EA83A8C9;
	Fri, 24 Nov 2023 18:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ecgPkfSk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEB23A8C3;
	Fri, 24 Nov 2023 18:25:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A149AC433C7;
	Fri, 24 Nov 2023 18:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850319;
	bh=ujLyL/f3Dj1zssHNzCmsaZXxvX528gR+6pq2jpLmMLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ecgPkfSk6l3DDdM4ZlhCfS7BPM1YFNsAdwrYnOZUAF8avDhAWfEuHu4wLPXYZPE6D
	 /UQK911RiXKH1K3k3YkQQ5+gURyah0uNhT9Pe0UGjBMPw3yuBGje7KZqhH4Lkg0BGM
	 ZB7lY5WkeyZl1PMLBsUEminf4hEN8NskYgbWH3OY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	John Harrison <john.c.harrison@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Matt Roper <matthew.d.roper@intel.com>,
	Nirmoy Das <nirmoy.das@intel.com>,
	Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 6.6 514/530] drm/i915: Flush WC GGTT only on required platforms
Date: Fri, 24 Nov 2023 17:51:20 +0000
Message-ID: <20231124172043.823335370@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nirmoy Das <nirmoy.das@intel.com>

commit 7d7a328d0e8d6edefb7b0d665185d468667588d0 upstream.

gen8_ggtt_invalidate() is only needed for limited set of platforms
where GGTT is mapped as WC. This was added as way to fix WC based GGTT in
commit 0f9b91c754b7 ("drm/i915: flush system agent TLBs on SNB") and
there are no reference in HW docs that forces us to use this on non-WC
backed GGTT.

This can also cause unwanted side-effects on XE_HP platforms where
GFX_FLSH_CNTL_GEN6 is not valid anymore.

v2: Add a func to detect wc ggtt detection (Ville)
v3: Improve commit log and add reference commit (Daniel)

Fixes: d2eae8e98d59 ("drm/i915/dg2: Drop force_probe requirement")
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
Cc: John Harrison <john.c.harrison@intel.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: <stable@vger.kernel.org> # v6.2+
Suggested-by: Matt Roper <matthew.d.roper@intel.com>
Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231018093815.1349-1-nirmoy.das@intel.com
(cherry picked from commit 81de3e296b10a13e5c9f13172825b0d8d9495c68)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/gt/intel_ggtt.c |   35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

--- a/drivers/gpu/drm/i915/gt/intel_ggtt.c
+++ b/drivers/gpu/drm/i915/gt/intel_ggtt.c
@@ -190,6 +190,21 @@ void gen6_ggtt_invalidate(struct i915_gg
 	spin_unlock_irq(&uncore->lock);
 }
 
+static bool needs_wc_ggtt_mapping(struct drm_i915_private *i915)
+{
+	/*
+	 * On BXT+/ICL+ writes larger than 64 bit to the GTT pagetable range
+	 * will be dropped. For WC mappings in general we have 64 byte burst
+	 * writes when the WC buffer is flushed, so we can't use it, but have to
+	 * resort to an uncached mapping. The WC issue is easily caught by the
+	 * readback check when writing GTT PTE entries.
+	 */
+	if (!IS_GEN9_LP(i915) && GRAPHICS_VER(i915) < 11)
+		return true;
+
+	return false;
+}
+
 static void gen8_ggtt_invalidate(struct i915_ggtt *ggtt)
 {
 	struct intel_uncore *uncore = ggtt->vm.gt->uncore;
@@ -197,8 +212,12 @@ static void gen8_ggtt_invalidate(struct
 	/*
 	 * Note that as an uncached mmio write, this will flush the
 	 * WCB of the writes into the GGTT before it triggers the invalidate.
+	 *
+	 * Only perform this when GGTT is mapped as WC, see ggtt_probe_common().
 	 */
-	intel_uncore_write_fw(uncore, GFX_FLSH_CNTL_GEN6, GFX_FLSH_CNTL_EN);
+	if (needs_wc_ggtt_mapping(ggtt->vm.i915))
+		intel_uncore_write_fw(uncore, GFX_FLSH_CNTL_GEN6,
+				      GFX_FLSH_CNTL_EN);
 }
 
 static void guc_ggtt_invalidate(struct i915_ggtt *ggtt)
@@ -902,17 +921,11 @@ static int ggtt_probe_common(struct i915
 	GEM_WARN_ON(pci_resource_len(pdev, GEN4_GTTMMADR_BAR) != gen6_gttmmadr_size(i915));
 	phys_addr = pci_resource_start(pdev, GEN4_GTTMMADR_BAR) + gen6_gttadr_offset(i915);
 
-	/*
-	 * On BXT+/ICL+ writes larger than 64 bit to the GTT pagetable range
-	 * will be dropped. For WC mappings in general we have 64 byte burst
-	 * writes when the WC buffer is flushed, so we can't use it, but have to
-	 * resort to an uncached mapping. The WC issue is easily caught by the
-	 * readback check when writing GTT PTE entries.
-	 */
-	if (IS_GEN9_LP(i915) || GRAPHICS_VER(i915) >= 11)
-		ggtt->gsm = ioremap(phys_addr, size);
-	else
+	if (needs_wc_ggtt_mapping(i915))
 		ggtt->gsm = ioremap_wc(phys_addr, size);
+	else
+		ggtt->gsm = ioremap(phys_addr, size);
+
 	if (!ggtt->gsm) {
 		drm_err(&i915->drm, "Failed to map the ggtt page table\n");
 		return -ENOMEM;




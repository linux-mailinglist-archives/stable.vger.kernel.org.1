Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1873755213
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjGPUDd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjGPUDc (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:03:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E11123
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:03:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FEF560EB0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:03:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2C3C433C7;
        Sun, 16 Jul 2023 20:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537810;
        bh=j6kS7LQm9jiAtqEA+kWOkRi9TYmlZD9KukE45Fd8jhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qD2ZyWfjkSsguFkpS7rsZJfc+jtMl23D6Dc6FmUp0KZeMC0GhjJuPI3b9Pr2oT0WT
         FERKJQMJggjREvDUVKeHPNu6dgZAN8terHHDWxCcJske1DurT2/UbsxBOAzDWAAXd7
         YJDWPBRj592qCuiIzZ9T/4hnoNllCqpS9tMfB9BQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        John Harrison <John.C.Harrison@Intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 228/800] drm/i915/guc/slpc: Provide sysfs for efficient freq
Date:   Sun, 16 Jul 2023 21:41:21 +0200
Message-ID: <20230716194954.385381525@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Vinay Belgaumkar <vinay.belgaumkar@intel.com>

[ Upstream commit 55f9720dbf23ed640a51ea5564c22305efa8a467 ]

SLPC enables use of efficient freq at init by default. It is
possible for GuC to request frequencies that are higher than
the 'software' max if user has set it lower than the efficient
level.

Scenarios/tests that require strict fixing of freq below the efficient
level will need to disable it through this interface.

v2: Keep just one interface to toggle sysfs. With this, user will
be completely responsible for toggling efficient frequency if need
be. There will be no implicit disabling when user sets min < RP1 (Ashutosh)

v3: Remove unused label, review comments (Ashutosh)

v4: Toggle efficient freq usage in SLPC selftest and checkpatch fixes

v5: Review comments (Andi) and add a separate patch for selftest updates

Fixes: 95ccf312a1e4 ("drm/i915/guc/slpc: Allow SLPC to use efficient frequency")
Signed-off-by: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Reviewed-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Signed-off-by: John Harrison <John.C.Harrison@Intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230426003942.1924347-1-vinay.belgaumkar@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c   | 35 +++++++++++++++++
 drivers/gpu/drm/i915/gt/uc/intel_guc_slpc.c   | 38 +++++++++++++------
 drivers/gpu/drm/i915/gt/uc/intel_guc_slpc.h   |  1 +
 .../gpu/drm/i915/gt/uc/intel_guc_slpc_types.h |  1 +
 4 files changed, 64 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c b/drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c
index 28f27091cd3b7..ee2b44f896a27 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c
+++ b/drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c
@@ -451,6 +451,33 @@ static ssize_t punit_req_freq_mhz_show(struct kobject *kobj,
 	return sysfs_emit(buff, "%u\n", preq);
 }
 
+static ssize_t slpc_ignore_eff_freq_show(struct kobject *kobj,
+					 struct kobj_attribute *attr,
+					 char *buff)
+{
+	struct intel_gt *gt = intel_gt_sysfs_get_drvdata(kobj, attr->attr.name);
+	struct intel_guc_slpc *slpc = &gt->uc.guc.slpc;
+
+	return sysfs_emit(buff, "%u\n", slpc->ignore_eff_freq);
+}
+
+static ssize_t slpc_ignore_eff_freq_store(struct kobject *kobj,
+					  struct kobj_attribute *attr,
+					  const char *buff, size_t count)
+{
+	struct intel_gt *gt = intel_gt_sysfs_get_drvdata(kobj, attr->attr.name);
+	struct intel_guc_slpc *slpc = &gt->uc.guc.slpc;
+	int err;
+	u32 val;
+
+	err = kstrtou32(buff, 0, &val);
+	if (err)
+		return err;
+
+	err = intel_guc_slpc_set_ignore_eff_freq(slpc, val);
+	return err ?: count;
+}
+
 struct intel_gt_bool_throttle_attr {
 	struct attribute attr;
 	ssize_t (*show)(struct kobject *kobj, struct kobj_attribute *attr,
@@ -663,6 +690,8 @@ static struct kobj_attribute attr_media_freq_factor_scale =
 INTEL_GT_ATTR_RO(media_RP0_freq_mhz);
 INTEL_GT_ATTR_RO(media_RPn_freq_mhz);
 
+INTEL_GT_ATTR_RW(slpc_ignore_eff_freq);
+
 static const struct attribute *media_perf_power_attrs[] = {
 	&attr_media_freq_factor.attr,
 	&attr_media_freq_factor_scale.attr,
@@ -744,6 +773,12 @@ void intel_gt_sysfs_pm_init(struct intel_gt *gt, struct kobject *kobj)
 	if (ret)
 		gt_warn(gt, "failed to create punit_req_freq_mhz sysfs (%pe)", ERR_PTR(ret));
 
+	if (intel_uc_uses_guc_slpc(&gt->uc)) {
+		ret = sysfs_create_file(kobj, &attr_slpc_ignore_eff_freq.attr);
+		if (ret)
+			gt_warn(gt, "failed to create ignore_eff_freq sysfs (%pe)", ERR_PTR(ret));
+	}
+
 	if (i915_mmio_reg_valid(intel_gt_perf_limit_reasons_reg(gt))) {
 		ret = sysfs_create_files(kobj, throttle_reason_attrs);
 		if (ret)
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_slpc.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_slpc.c
index 026d73855f36c..56dbba1ef6684 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_slpc.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_slpc.c
@@ -277,6 +277,7 @@ int intel_guc_slpc_init(struct intel_guc_slpc *slpc)
 
 	slpc->max_freq_softlimit = 0;
 	slpc->min_freq_softlimit = 0;
+	slpc->ignore_eff_freq = false;
 	slpc->min_is_rpmax = false;
 
 	slpc->boost_freq = 0;
@@ -457,6 +458,29 @@ int intel_guc_slpc_get_max_freq(struct intel_guc_slpc *slpc, u32 *val)
 	return ret;
 }
 
+int intel_guc_slpc_set_ignore_eff_freq(struct intel_guc_slpc *slpc, bool val)
+{
+	struct drm_i915_private *i915 = slpc_to_i915(slpc);
+	intel_wakeref_t wakeref;
+	int ret;
+
+	mutex_lock(&slpc->lock);
+	wakeref = intel_runtime_pm_get(&i915->runtime_pm);
+
+	ret = slpc_set_param(slpc,
+			     SLPC_PARAM_IGNORE_EFFICIENT_FREQUENCY,
+			     val);
+	if (ret)
+		guc_probe_error(slpc_to_guc(slpc), "Failed to set efficient freq(%d): %pe\n",
+				val, ERR_PTR(ret));
+	else
+		slpc->ignore_eff_freq = val;
+
+	intel_runtime_pm_put(&i915->runtime_pm, wakeref);
+	mutex_unlock(&slpc->lock);
+	return ret;
+}
+
 /**
  * intel_guc_slpc_set_min_freq() - Set min frequency limit for SLPC.
  * @slpc: pointer to intel_guc_slpc.
@@ -482,16 +506,6 @@ int intel_guc_slpc_set_min_freq(struct intel_guc_slpc *slpc, u32 val)
 	mutex_lock(&slpc->lock);
 	wakeref = intel_runtime_pm_get(&i915->runtime_pm);
 
-	/* Ignore efficient freq if lower min freq is requested */
-	ret = slpc_set_param(slpc,
-			     SLPC_PARAM_IGNORE_EFFICIENT_FREQUENCY,
-			     val < slpc->rp1_freq);
-	if (ret) {
-		guc_probe_error(slpc_to_guc(slpc), "Failed to toggle efficient freq: %pe\n",
-				ERR_PTR(ret));
-		goto out;
-	}
-
 	ret = slpc_set_param(slpc,
 			     SLPC_PARAM_GLOBAL_MIN_GT_UNSLICE_FREQ_MHZ,
 			     val);
@@ -499,7 +513,6 @@ int intel_guc_slpc_set_min_freq(struct intel_guc_slpc *slpc, u32 val)
 	if (!ret)
 		slpc->min_freq_softlimit = val;
 
-out:
 	intel_runtime_pm_put(&i915->runtime_pm, wakeref);
 	mutex_unlock(&slpc->lock);
 
@@ -752,6 +765,9 @@ int intel_guc_slpc_enable(struct intel_guc_slpc *slpc)
 	/* Set cached media freq ratio mode */
 	intel_guc_slpc_set_media_ratio_mode(slpc, slpc->media_ratio_mode);
 
+	/* Set cached value of ignore efficient freq */
+	intel_guc_slpc_set_ignore_eff_freq(slpc, slpc->ignore_eff_freq);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_slpc.h b/drivers/gpu/drm/i915/gt/uc/intel_guc_slpc.h
index 17ed515f6a852..597eb5413ddf2 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_slpc.h
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_slpc.h
@@ -46,5 +46,6 @@ void intel_guc_slpc_boost(struct intel_guc_slpc *slpc);
 void intel_guc_slpc_dec_waiters(struct intel_guc_slpc *slpc);
 int intel_guc_slpc_unset_gucrc_mode(struct intel_guc_slpc *slpc);
 int intel_guc_slpc_override_gucrc_mode(struct intel_guc_slpc *slpc, u32 mode);
+int intel_guc_slpc_set_ignore_eff_freq(struct intel_guc_slpc *slpc, bool val);
 
 #endif
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_slpc_types.h b/drivers/gpu/drm/i915/gt/uc/intel_guc_slpc_types.h
index a6ef53b04e047..a886513314977 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_slpc_types.h
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_slpc_types.h
@@ -31,6 +31,7 @@ struct intel_guc_slpc {
 	/* frequency softlimits */
 	u32 min_freq_softlimit;
 	u32 max_freq_softlimit;
+	bool ignore_eff_freq;
 
 	/* cached media ratio mode */
 	u32 media_ratio_mode;
-- 
2.39.2




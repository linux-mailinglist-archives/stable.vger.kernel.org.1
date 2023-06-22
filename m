Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11FA73A83D
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 20:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjFVS2S (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 14:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjFVS2S (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 14:28:18 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A1C2111
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 11:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687458489; x=1718994489;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7i915zSnstzNKPvIzxztfUBfh9qOyfI3qCeFZGXamoM=;
  b=mtn+0TCrxMS/ayWYg7ngEOXqxD0rZzPMBosYOvnlI1MUNMoiAkV30Dmi
   ta/wSM6bizGX4oGbWhMXnsm/EQqR2udYNOegsJOKiv8CN+Y9SYrqmO9hd
   9rTXexTa66NTI4RVxeHTdx40DSQGUaPQuMWiEfo9GRY30I7wmHiI39sU4
   Ejw9Yw5VrDWfd+RTxWaRkSTWNJNISjEiHGENEutzBn4PqXjhR8X4QLgTH
   Dunh/fSZlx1mykkknPNyyh8paYmBwmK+RWDf2YrBQC5ZouCOMUXOhY/1r
   DAqkpeweyNEpad2TdBUnGaUo+/uiaULtkjVim7/d7NqzQEYUfnjdIS6AA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="359437770"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="359437770"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 11:27:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="780345380"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="780345380"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 11:27:44 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     dri-devel@lists.freedesktop.org,
        Kenneth Graunke <kenneth@whitecape.org>,
        Matt Roper <matthew.d.roper@intel.com>, stable@vger.kernel.org,
        Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 1/3] drm/i915/gt: Move wal_get_fw_for_rmw()
Date:   Thu, 22 Jun 2023 11:27:29 -0700
Message-Id: <20230622182731.3765039-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Move helper function to get all the forcewakes required by the wa list
to the top, so it can be re-used by other functions.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/i915/gt/intel_workarounds.c | 32 ++++++++++-----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_workarounds.c b/drivers/gpu/drm/i915/gt/intel_workarounds.c
index 4d2dece96011..0578fc2c9e60 100644
--- a/drivers/gpu/drm/i915/gt/intel_workarounds.c
+++ b/drivers/gpu/drm/i915/gt/intel_workarounds.c
@@ -123,6 +123,22 @@ static void wa_init_finish(struct i915_wa_list *wal)
 		wal->wa_count, wal->name, wal->engine_name);
 }
 
+static enum forcewake_domains
+wal_get_fw_for_rmw(struct intel_uncore *uncore, const struct i915_wa_list *wal)
+{
+	enum forcewake_domains fw = 0;
+	struct i915_wa *wa;
+	unsigned int i;
+
+	for (i = 0, wa = wal->list; i < wal->count; i++, wa++)
+		fw |= intel_uncore_forcewake_for_reg(uncore,
+						     wa->reg,
+						     FW_REG_READ |
+						     FW_REG_WRITE);
+
+	return fw;
+}
+
 static void _wa_add(struct i915_wa_list *wal, const struct i915_wa *wa)
 {
 	unsigned int addr = i915_mmio_reg_offset(wa->reg);
@@ -1850,22 +1866,6 @@ void intel_gt_init_workarounds(struct intel_gt *gt)
 	wa_init_finish(wal);
 }
 
-static enum forcewake_domains
-wal_get_fw_for_rmw(struct intel_uncore *uncore, const struct i915_wa_list *wal)
-{
-	enum forcewake_domains fw = 0;
-	struct i915_wa *wa;
-	unsigned int i;
-
-	for (i = 0, wa = wal->list; i < wal->count; i++, wa++)
-		fw |= intel_uncore_forcewake_for_reg(uncore,
-						     wa->reg,
-						     FW_REG_READ |
-						     FW_REG_WRITE);
-
-	return fw;
-}
-
 static bool
 wa_verify(struct intel_gt *gt, const struct i915_wa *wa, u32 cur,
 	  const char *name, const char *from)
-- 
2.40.1


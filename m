Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5B97A397B
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240076AbjIQTty (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240096AbjIQTtr (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:49:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187379F
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:49:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439A3C433C9;
        Sun, 17 Sep 2023 19:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980181;
        bh=Jh+sk4peFWaSY6ep31simryu/e2Zf6CiRiLiFw1p7+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MOLNmwM+xiQBKcpshB7PwNpRqjWGcrZjNwcY1fII1CWXgQBG5GPHFE8X9qNRGcsE8
         hKIEtiFmiUIToX/wY2vOafWyni93ROcfrclB+HYdiBZz0QPBclH88ynt6QFtQTVyDn
         DSETXzVRKXrgbAP2pqrMJlFl8WihRe2XXBKfEhnQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yan Zhao <yan.y.zhao@intel.com>,
        Yongwei Ma <yongwei.ma@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 116/285] drm/i915/gvt: Drop unused helper intel_vgpu_reset_gtt()
Date:   Sun, 17 Sep 2023 21:11:56 +0200
Message-ID: <20230917191055.683269457@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit a90c367e5af63880008e21dd199dac839e0e9e0f ]

Drop intel_vgpu_reset_gtt() as it no longer has any callers.  In addition
to eliminating dead code, this eliminates the last possible scenario where
__kvmgt_protect_table_find() can be reached without holding vgpu_lock.
Requiring vgpu_lock to be held when calling __kvmgt_protect_table_find()
will allow a protecting the gfn hash with vgpu_lock without too much fuss.

No functional change intended.

Fixes: ba25d977571e ("drm/i915/gvt: Do not destroy ppgtt_mm during vGPU D3->D0.")
Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Reviewed-by: Zhi Wang <zhi.a.wang@intel.com>
Link: https://lore.kernel.org/r/20230729013535.1070024-11-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/gvt/gtt.c | 18 ------------------
 drivers/gpu/drm/i915/gvt/gtt.h |  1 -
 2 files changed, 19 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
index 8ba6c8668f033..ef5517ecd9a0c 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -2882,24 +2882,6 @@ void intel_vgpu_reset_ggtt(struct intel_vgpu *vgpu, bool invalidate_old)
 	ggtt_invalidate(gvt->gt);
 }
 
-/**
- * intel_vgpu_reset_gtt - reset the all GTT related status
- * @vgpu: a vGPU
- *
- * This function is called from vfio core to reset reset all
- * GTT related status, including GGTT, PPGTT, scratch page.
- *
- */
-void intel_vgpu_reset_gtt(struct intel_vgpu *vgpu)
-{
-	/* Shadow pages are only created when there is no page
-	 * table tracking data, so remove page tracking data after
-	 * removing the shadow pages.
-	 */
-	intel_vgpu_destroy_all_ppgtt_mm(vgpu);
-	intel_vgpu_reset_ggtt(vgpu, true);
-}
-
 /**
  * intel_gvt_restore_ggtt - restore all vGPU's ggtt entries
  * @gvt: intel gvt device
diff --git a/drivers/gpu/drm/i915/gvt/gtt.h b/drivers/gpu/drm/i915/gvt/gtt.h
index a3b0f59ec8bd9..4cb183e06e95a 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.h
+++ b/drivers/gpu/drm/i915/gvt/gtt.h
@@ -224,7 +224,6 @@ void intel_vgpu_reset_ggtt(struct intel_vgpu *vgpu, bool invalidate_old);
 void intel_vgpu_invalidate_ppgtt(struct intel_vgpu *vgpu);
 
 int intel_gvt_init_gtt(struct intel_gvt *gvt);
-void intel_vgpu_reset_gtt(struct intel_vgpu *vgpu);
 void intel_gvt_clean_gtt(struct intel_gvt *gvt);
 
 struct intel_vgpu_mm *intel_gvt_find_ppgtt_mm(struct intel_vgpu *vgpu,
-- 
2.40.1




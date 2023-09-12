Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3069979BD8F
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242167AbjIKWXr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240402AbjIKOnV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:43:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5598312A
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:43:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460FAC433C8;
        Mon, 11 Sep 2023 14:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443392;
        bh=vNV4bGKY4uTvqOBKrkrtIdWKhKCzVbB7tWVsp6xAmdo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qmSQ335Nfm4YWsgS36XFKoOmyt0byv4Id01i8igaUqaFiNgMsGTLguOs9VzQXoii+
         LhPsW81GUQ7zDahoDqLj0A9DFKkeq1Q/YU72BrMY2kkyfP9vQKIhUTex+k+phET7EC
         3k1EgFnq5ghBZXKqXrg1NH464oBwpceyXJkZ9dx8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 334/737] drm/amdgpu: Update min() to min_t() in amdgpu_info_ioctl
Date:   Mon, 11 Sep 2023 15:43:13 +0200
Message-ID: <20230911134659.867557134@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit a0cc8e1512ad72c9f97cdcb76d42715730adaf62 ]

Fixes the following:

WARNING: min() should probably be min_t(size_t, size, sizeof(ip))
+               ret = copy_to_user(out, &ip, min((size_t)size, sizeof(ip)));

And other style fixes:

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
WARNING: Missing a blank line after declarations

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 724e80c192973..cecae6c1e8935 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -556,6 +556,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			crtc = (struct drm_crtc *)minfo->crtcs[i];
 			if (crtc && crtc->base.id == info->mode_crtc.id) {
 				struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
+
 				ui32 = amdgpu_crtc->crtc_id;
 				found = 1;
 				break;
@@ -574,7 +575,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		if (ret)
 			return ret;
 
-		ret = copy_to_user(out, &ip, min((size_t)size, sizeof(ip)));
+		ret = copy_to_user(out, &ip, min_t(size_t, size, sizeof(ip)));
 		return ret ? -EFAULT : 0;
 	}
 	case AMDGPU_INFO_HW_IP_COUNT: {
@@ -720,17 +721,18 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 				    ? -EFAULT : 0;
 	}
 	case AMDGPU_INFO_READ_MMR_REG: {
-		unsigned n, alloc_size;
+		unsigned int n, alloc_size;
 		uint32_t *regs;
-		unsigned se_num = (info->read_mmr_reg.instance >>
+		unsigned int se_num = (info->read_mmr_reg.instance >>
 				   AMDGPU_INFO_MMR_SE_INDEX_SHIFT) &
 				  AMDGPU_INFO_MMR_SE_INDEX_MASK;
-		unsigned sh_num = (info->read_mmr_reg.instance >>
+		unsigned int sh_num = (info->read_mmr_reg.instance >>
 				   AMDGPU_INFO_MMR_SH_INDEX_SHIFT) &
 				  AMDGPU_INFO_MMR_SH_INDEX_MASK;
 
 		/* set full masks if the userspace set all bits
-		 * in the bitfields */
+		 * in the bitfields
+		 */
 		if (se_num == AMDGPU_INFO_MMR_SE_INDEX_MASK)
 			se_num = 0xffffffff;
 		else if (se_num >= AMDGPU_GFX_MAX_SE)
@@ -882,7 +884,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		return ret;
 	}
 	case AMDGPU_INFO_VCE_CLOCK_TABLE: {
-		unsigned i;
+		unsigned int i;
 		struct drm_amdgpu_info_vce_clock_table vce_clk_table = {};
 		struct amd_vce_state *vce_state;
 
-- 
2.40.1




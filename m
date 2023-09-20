Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9307A7870
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 12:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbjITKBO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 06:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234258AbjITKBN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 06:01:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F313AA3
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 03:01:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B63C433C7;
        Wed, 20 Sep 2023 10:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695204067;
        bh=IOAmHWzAtOc2nBoj1FiP/x7cY257J7vGT0wjmAVXsQM=;
        h=Subject:To:Cc:From:Date:From;
        b=zSJRCwMh+JDDcUE7ZTs4L9j7+fwqqOItLXAZKV4wNEBmK47QNYXmL9D4EcGoQZxnR
         myWXOkyRBo0YaE6hRABB70SpB+8M3cCiWQVZHRUVhtxBfgjrlxpazHqbU4rVMTC84B
         n3ZVWKL16KcW2aObadI1+m6hy/1APP1lWWCkKPDY=
Subject: FAILED: patch "[PATCH] drm/amd/display: fix the white screen issue when >= 64GB DRAM" failed to apply to 5.10-stable tree
To:     yifan1.zhang@amd.com, alexander.deucher@amd.com,
        hamza.mahfooz@amd.com, harry.wentland@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 20 Sep 2023 12:01:04 +0200
Message-ID: <2023092004-excavate-unending-0257@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x ef064187a9709393a981a56cce1e31880fd97107
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023092004-excavate-unending-0257@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

ef064187a970 ("drm/amd/display: fix the white screen issue when >= 64GB DRAM")
c0fb85ae02b6 ("drm/amd/display: setup system context in dm_init")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ef064187a9709393a981a56cce1e31880fd97107 Mon Sep 17 00:00:00 2001
From: Yifan Zhang <yifan1.zhang@amd.com>
Date: Fri, 8 Sep 2023 16:46:39 +0800
Subject: [PATCH] drm/amd/display: fix the white screen issue when >= 64GB DRAM

Dropping bit 31:4 of page table base is wrong, it makes page table
base points to wrong address if phys addr is beyond 64GB; dropping
page_table_start/end bit 31:4 is unnecessary since dcn20_vmid_setup
will do that. Also, while we are at it, cleanup the assignments using
upper_32_bits()/lower_32_bits() and AMDGPU_GPU_PAGE_SHIFT.

Cc: stable@vger.kernel.org
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2354
Fixes: 81d0bcf99009 ("drm/amdgpu: make display pinning more flexible (v2)")
Acked-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Co-developed-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 88ba8b66de1f..6a0ea15936ae 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1274,11 +1274,15 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
 
 	pt_base = amdgpu_gmc_pd_addr(adev->gart.bo);
 
-	page_table_start.high_part = (u32)(adev->gmc.gart_start >> 44) & 0xF;
-	page_table_start.low_part = (u32)(adev->gmc.gart_start >> 12);
-	page_table_end.high_part = (u32)(adev->gmc.gart_end >> 44) & 0xF;
-	page_table_end.low_part = (u32)(adev->gmc.gart_end >> 12);
-	page_table_base.high_part = upper_32_bits(pt_base) & 0xF;
+	page_table_start.high_part = upper_32_bits(adev->gmc.gart_start >>
+						   AMDGPU_GPU_PAGE_SHIFT);
+	page_table_start.low_part = lower_32_bits(adev->gmc.gart_start >>
+						  AMDGPU_GPU_PAGE_SHIFT);
+	page_table_end.high_part = upper_32_bits(adev->gmc.gart_end >>
+						 AMDGPU_GPU_PAGE_SHIFT);
+	page_table_end.low_part = lower_32_bits(adev->gmc.gart_end >>
+						AMDGPU_GPU_PAGE_SHIFT);
+	page_table_base.high_part = upper_32_bits(pt_base);
 	page_table_base.low_part = lower_32_bits(pt_base);
 
 	pa_config->system_aperture.start_addr = (uint64_t)logical_addr_low << 18;


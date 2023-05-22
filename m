Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4F870C9F1
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235469AbjEVTxX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235390AbjEVTxW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:53:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45088C1
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:53:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F1FA62B57
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:53:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51559C433EF;
        Mon, 22 May 2023 19:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684785197;
        bh=AAyKsFlPugJsQaTZ3w5DVEr5j2yEkRYEA2fHXv4tVaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1zxX1sh0rAwPLDUZw98aDt7l3hmy5rxGc30aV7eaXqnrQJmvzWxPrA3hzRE3PBOvh
         SyeCVuWrOGJCabU+zyUBdNMV17Gl/br050Y0SBJqCm2gNE7ALuKAxbyQy5HtBiNYkb
         2asVyKJdqnGE7eYTjCAJzw4dGPd6wvcOCi+vdhWs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tong Liu01 <Tong.Liu01@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.3 341/364] drm/amdgpu: refine get gpu clock counter method
Date:   Mon, 22 May 2023 20:10:46 +0100
Message-Id: <20230522190421.293932699@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tong Liu01 <Tong.Liu01@amd.com>

commit 5591a051b86be170a84943698ab140342602ff7b upstream.

[why]
regGOLDEN_TSC_COUNT_LOWER/regGOLDEN_TSC_COUNT_UPPER are protected and
unaccessible under sriov.
The clock counter high bit may update during reading process.

[How]
Replace regGOLDEN_TSC_COUNT_LOWER/regGOLDEN_TSC_COUNT_UPPER with
regCP_MES_MTIME_LO/regCP_MES_MTIME_HI to get gpu clock under sriov.
Refine get gpu clock counter method to make the result more precise.

Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
Acked-by: Luben Tuikov <luben.tuikov@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4663,11 +4663,24 @@ static int gfx_v11_0_post_soft_reset(voi
 static uint64_t gfx_v11_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 {
 	uint64_t clock;
+	uint64_t clock_counter_lo, clock_counter_hi_pre, clock_counter_hi_after;
 
 	amdgpu_gfx_off_ctrl(adev, false);
 	mutex_lock(&adev->gfx.gpu_clock_mutex);
-	clock = (uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_LOWER) |
-		((uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_UPPER) << 32ULL);
+	if (amdgpu_sriov_vf(adev)) {
+		clock_counter_hi_pre = (uint64_t)RREG32_SOC15(GC, 0, regCP_MES_MTIME_HI);
+		clock_counter_lo = (uint64_t)RREG32_SOC15(GC, 0, regCP_MES_MTIME_LO);
+		clock_counter_hi_after = (uint64_t)RREG32_SOC15(GC, 0, regCP_MES_MTIME_HI);
+		if (clock_counter_hi_pre != clock_counter_hi_after)
+			clock_counter_lo = (uint64_t)RREG32_SOC15(GC, 0, regCP_MES_MTIME_LO);
+	} else {
+		clock_counter_hi_pre = (uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_UPPER);
+		clock_counter_lo = (uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_LOWER);
+		clock_counter_hi_after = (uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_UPPER);
+		if (clock_counter_hi_pre != clock_counter_hi_after)
+			clock_counter_lo = (uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_LOWER);
+	}
+	clock = clock_counter_lo | (clock_counter_hi_after << 32ULL);
 	mutex_unlock(&adev->gfx.gpu_clock_mutex);
 	amdgpu_gfx_off_ctrl(adev, true);
 	return clock;



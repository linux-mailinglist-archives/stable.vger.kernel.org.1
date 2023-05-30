Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05D6715A24
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 11:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjE3J3a (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 05:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjE3J3I (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 05:29:08 -0400
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21D61721
        for <stable@vger.kernel.org>; Tue, 30 May 2023 02:28:12 -0700 (PDT)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-64d2da69fdfso4897340b3a.0
        for <stable@vger.kernel.org>; Tue, 30 May 2023 02:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685438891; x=1688030891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aYjlsvTneI3m29TkkHy6W/pxFdY2fodDXCgmP71vB1Q=;
        b=RPJ3nboYdNHd6Y2xbqbTWzXFxOfaWSL6wp3BmTzC58UhLZrS6Ly6AAN0g04rN7cwLt
         CXNbnmWsJC5OWMTYJdU1nswtpN/kVxKC0xToM+MFQi0AF52QLq0yO5t4NrQtDTV3h888
         ZOpbyd5jgrfmiE1h0GLxjqKTjowXmtTxqSeI3vHQ131D0qEInZmN8A5+MPCd8OZ7svhY
         D0Of8EEPttAr2Tmni8Git7oh3q6ds0UuHbCmrzERAg0nWkunO00sL0zI+5oomNHxCUpn
         48P83kBa7MBhZwNIwi8bS8TCcI1nQujv0lUPF9GpCYyqQduBoD1ROesxrTa2DI6/M3XE
         lX6g==
X-Gm-Message-State: AC+VfDzD09LH83zvqEX+iETTqgAque8xVVmxdlMmru1DNHmoqXqCbriH
        mMmXKioogmzBW3Z+upvwuxw=
X-Google-Smtp-Source: ACHHUZ6NxzRoZBNxsQOYKY9iTBZFd2d8iF24vCJd/D+MWociyqeapHLGMN0oqSW/BFY6746xe4ceuQ==
X-Received: by 2002:a05:6a00:2351:b0:643:9e7c:3829 with SMTP id j17-20020a056a00235100b006439e7c3829mr2109634pfj.12.1685438891577;
        Tue, 30 May 2023 02:28:11 -0700 (PDT)
Received: from localhost.localdomain (61-227-119-36.dynamic-ip.hinet.net. [61.227.119.36])
        by smtp.gmail.com with ESMTPSA id 24-20020a631658000000b0051f15beba7fsm8211229pgw.67.2023.05.30.02.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 02:28:11 -0700 (PDT)
From:   You-Sheng Yang <vicamo.yang@canonical.com>
To:     kernel-team@lists.ubuntu.com
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>, stable@vger.kernel.org,
        You-Sheng Yang <vicamo.yang@canonical.com>
Subject: [PATCH 2/2][SRU][Lunar] drm/amdgpu/gfx11: update gpu_clock_counter logic
Date:   Tue, 30 May 2023 17:25:42 +0800
Message-Id: <20230530092542.1239871-3-vicamo.yang@canonical.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230530092542.1239871-1-vicamo.yang@canonical.com>
References: <20230530092542.1239871-1-vicamo.yang@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

BugLink: https://bugs.launchpad.net/bugs/2020685

This code was written prior to previous updates to this
logic for other chips.  The RSC registers are part of
SMUIO which is an always on block so there is no need
to disable gfxoff.  Additionally add the carryover and
preemption checks.

v2: rebase

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 6.1.y: 5591a051b86b: drm/amdgpu: refine get gpu clock counter method
Cc: stable@vger.kernel.org # 6.2.y: 5591a051b86b: drm/amdgpu: refine get gpu clock counter method
Cc: stable@vger.kernel.org # 6.3.y: 5591a051b86b: drm/amdgpu: refine get gpu clock counter method
(cherry picked from commit d5aa417808cf14c052ca042920b3c6b9f1dc6aa4)
Signed-off-by: You-Sheng Yang <vicamo.yang@canonical.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 2e1c67cfc1bd..bfba3f20e460 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4643,24 +4643,27 @@ static uint64_t gfx_v11_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 	uint64_t clock;
 	uint64_t clock_counter_lo, clock_counter_hi_pre, clock_counter_hi_after;
 
-	amdgpu_gfx_off_ctrl(adev, false);
-	mutex_lock(&adev->gfx.gpu_clock_mutex);
 	if (amdgpu_sriov_vf(adev)) {
+		amdgpu_gfx_off_ctrl(adev, false);
+		mutex_lock(&adev->gfx.gpu_clock_mutex);
 		clock_counter_hi_pre = (uint64_t)RREG32_SOC15(GC, 0, regCP_MES_MTIME_HI);
 		clock_counter_lo = (uint64_t)RREG32_SOC15(GC, 0, regCP_MES_MTIME_LO);
 		clock_counter_hi_after = (uint64_t)RREG32_SOC15(GC, 0, regCP_MES_MTIME_HI);
 		if (clock_counter_hi_pre != clock_counter_hi_after)
 			clock_counter_lo = (uint64_t)RREG32_SOC15(GC, 0, regCP_MES_MTIME_LO);
+		mutex_unlock(&adev->gfx.gpu_clock_mutex);
+		amdgpu_gfx_off_ctrl(adev, true);
 	} else {
+		preempt_disable();
 		clock_counter_hi_pre = (uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_UPPER);
 		clock_counter_lo = (uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_LOWER);
 		clock_counter_hi_after = (uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_UPPER);
 		if (clock_counter_hi_pre != clock_counter_hi_after)
 			clock_counter_lo = (uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_LOWER);
+		preempt_enable();
 	}
 	clock = clock_counter_lo | (clock_counter_hi_after << 32ULL);
-	mutex_unlock(&adev->gfx.gpu_clock_mutex);
-	amdgpu_gfx_off_ctrl(adev, true);
+
 	return clock;
 }
 
-- 
2.39.2


Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F8976AF8F
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbjHAJsp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbjHAJsc (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:48:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F054222
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:47:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6BB06126D
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:47:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FBAC433C9;
        Tue,  1 Aug 2023 09:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883221;
        bh=4QR4i/5FCmjj8vvofHns45GjYebhTG+h+CyJAUo12YA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wkzXth8VRWquiON6+S2T32R12FGVb111gHBBqB/Neh10rwjhFwO7xLqPxiV2fLzx+
         0sEdoif+AcnzsruIZBszUXbOWhmvujOS/DLpDE9JjwcGdIxhx0TlTm/tDUl+WO6wRD
         jWPT7uqKFUvSWi4h/wObokHM9f1ZhIV9fEVOpI8A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 129/239] drm/amd: Fix an error handling mistake in psp_sw_init()
Date:   Tue,  1 Aug 2023 11:19:53 +0200
Message-ID: <20230801091930.372701769@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit c01aebeef3ce45f696ffa0a1303cea9b34babb45 ]

If the second call to amdgpu_bo_create_kernel() fails, the memory
allocated from the first call should be cleared.  If the third call
fails, the memory from the second call should be cleared.

Fixes: b95b5391684b ("drm/amdgpu/psp: move PSP memory alloc from hw_init to sw_init")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index e4757a2807d9a..db820331f2c61 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -491,11 +491,11 @@ static int psp_sw_init(void *handle)
 	return 0;
 
 failed2:
-	amdgpu_bo_free_kernel(&psp->fw_pri_bo,
-			      &psp->fw_pri_mc_addr, &psp->fw_pri_buf);
-failed1:
 	amdgpu_bo_free_kernel(&psp->fence_buf_bo,
 			      &psp->fence_buf_mc_addr, &psp->fence_buf);
+failed1:
+	amdgpu_bo_free_kernel(&psp->fw_pri_bo,
+			      &psp->fw_pri_mc_addr, &psp->fw_pri_buf);
 	return ret;
 }
 
-- 
2.40.1




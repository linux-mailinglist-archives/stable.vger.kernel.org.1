Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BAF775CB8
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbjHILaO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbjHILaL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:30:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D084210C
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:30:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1415663355
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 233FAC433C7;
        Wed,  9 Aug 2023 11:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580608;
        bh=b1JltFsDS8pZU/BREqghDy4F6kNw2qUw677MfruGTuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y6qHKkSRkg0O9AmEkyLRjlxrJunA+MFI0FQck+QvU2ybZ8dNe3rpfZJmrieCfjXYP
         ncjtl2dj0WaUH9fkIVc5gt5eTl14F+fVdRNBfR51lYuqph7IArueLtXS+31B8lKJAB
         cYipSzQ5GLFYaqErU9Y/ZUac8t+NVbLTMSM8cFug=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Rob Clark <robdclark@chromium.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 047/154] drm/msm/adreno: Fix snapshot BINDLESS_DATA size
Date:   Wed,  9 Aug 2023 12:41:18 +0200
Message-ID: <20230809103638.567321274@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.887175326@linuxfoundation.org>
References: <20230809103636.887175326@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

[ Upstream commit bd846ceee9c478d0397428f02696602ba5eb264a ]

The incorrect size was causing "CP | AHB bus error" when snapshotting
the GPU state on a6xx gen4 (a660 family).

Closes: https://gitlab.freedesktop.org/drm/msm/-/issues/26
Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
Fixes: 1707add81551 ("drm/msm/a6xx: Add a6xx gpu state")
Patchwork: https://patchwork.freedesktop.org/patch/546763/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h
index 68cccfa2870a3..9c8eb1ae4acfc 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h
@@ -200,7 +200,7 @@ static const struct a6xx_shader_block {
 	SHADER(A6XX_SP_LB_3_DATA, 0x800),
 	SHADER(A6XX_SP_LB_4_DATA, 0x800),
 	SHADER(A6XX_SP_LB_5_DATA, 0x200),
-	SHADER(A6XX_SP_CB_BINDLESS_DATA, 0x2000),
+	SHADER(A6XX_SP_CB_BINDLESS_DATA, 0x800),
 	SHADER(A6XX_SP_CB_LEGACY_DATA, 0x280),
 	SHADER(A6XX_SP_UAV_DATA, 0x80),
 	SHADER(A6XX_SP_INST_TAG, 0x80),
-- 
2.40.1




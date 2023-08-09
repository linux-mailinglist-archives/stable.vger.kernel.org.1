Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC12775C93
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbjHIL2r (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbjHIL2q (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:28:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30946ED
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:28:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9C6E632F6
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:28:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4BCC433C7;
        Wed,  9 Aug 2023 11:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580525;
        bh=sKx8U7hKkA7P7iEjnCeFXEoD91iSuFfhE0nT1fM+Azg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S/5xRCjyMnKC1FVHPEQeoB8RFMSeT5SKE+kDOD1rGO7XFLqXc50ojyV6XC7Ff850l
         y7Zfmj4U/QJ75Z1/ADVWyQBOgtQ1vUfe452V2qyN4uA6To3bDC8HKWEmozejdsb08V
         t95Hs33j9uUlfiwO3FHsHZsyTWvpSqYtAmDXr7Dg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Gaosheng Cui <cuigaosheng1@huawei.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Rob Clark <robdclark@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 048/154] drm/msm: Fix IS_ERR_OR_NULL() vs NULL check in a5xx_submit_in_rb()
Date:   Wed,  9 Aug 2023 12:41:19 +0200
Message-ID: <20230809103638.609680539@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.887175326@linuxfoundation.org>
References: <20230809103636.887175326@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Gaosheng Cui <cuigaosheng1@huawei.com>

[ Upstream commit 6e8a996563ecbe68e49c49abd4aaeef69f11f2dc ]

The msm_gem_get_vaddr() returns an ERR_PTR() on failure, and a null
is catastrophic here, so we should use IS_ERR_OR_NULL() to check
the return value.

Fixes: 6a8bd08d0465 ("drm/msm: add sudo flag to submit ioctl")
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Reviewed-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
Patchwork: https://patchwork.freedesktop.org/patch/547712/
Signed-off-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index 593b8d83179c9..65c2c5361e5fc 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -71,7 +71,7 @@ static void a5xx_submit_in_rb(struct msm_gpu *gpu, struct msm_gem_submit *submit
 			 * since we've already mapped it once in
 			 * submit_reloc()
 			 */
-			if (WARN_ON(!ptr))
+			if (WARN_ON(IS_ERR_OR_NULL(ptr)))
 				return;
 
 			for (i = 0; i < dwords; i++) {
-- 
2.40.1




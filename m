Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038FD76AD58
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbjHAJ23 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbjHAJ2H (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:28:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671E22D62
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:27:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E063861511
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:27:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD48C4339A;
        Tue,  1 Aug 2023 09:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882023;
        bh=zYbBpl3C+/45YeKEemcPVoWChYo4iY6UjwOzo4mpUgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cH8cXw8K/KNUzURf0/jk4N3OmQgksk4aQ33Rb8Msn+Wx/Yzzsh4J9scO/Sm4SydXr
         eaFOwV2znWux7CBHrxtTt+izaMHEAjrXmXmtveUBGU+QXlzpj5NIAlUrwt43c+1RYs
         Na59nv1QlAJkEyahJjWm0rppCiHICxFoqBdm1Mks=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 083/155] drm/msm/dpu: drop enum dpu_core_perf_data_bus_id
Date:   Tue,  1 Aug 2023 11:19:55 +0200
Message-ID: <20230801091913.140485591@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091910.165050260@linuxfoundation.org>
References: <20230801091910.165050260@linuxfoundation.org>
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

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit e8383f5cf1b3573ce140a80bfbfd809278ab16d6 ]

Drop the leftover of bus-client -> interconnect conversion, the enum
dpu_core_perf_data_bus_id.

Fixes: cb88482e2570 ("drm/msm/dpu: clean up references of DPU custom bus scaling")
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/546048/
Link: https://lore.kernel.org/r/20230707193942.3806526-2-dmitry.baryshkov@linaro.org
Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h
index cf4b9b5964c6c..cd6c3518ba021 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h
@@ -14,19 +14,6 @@
 
 #define	DPU_PERF_DEFAULT_MAX_CORE_CLK_RATE	412500000
 
-/**
- * enum dpu_core_perf_data_bus_id - data bus identifier
- * @DPU_CORE_PERF_DATA_BUS_ID_MNOC: DPU/MNOC data bus
- * @DPU_CORE_PERF_DATA_BUS_ID_LLCC: MNOC/LLCC data bus
- * @DPU_CORE_PERF_DATA_BUS_ID_EBI: LLCC/EBI data bus
- */
-enum dpu_core_perf_data_bus_id {
-	DPU_CORE_PERF_DATA_BUS_ID_MNOC,
-	DPU_CORE_PERF_DATA_BUS_ID_LLCC,
-	DPU_CORE_PERF_DATA_BUS_ID_EBI,
-	DPU_CORE_PERF_DATA_BUS_ID_MAX,
-};
-
 /**
  * struct dpu_core_perf_params - definition of performance parameters
  * @max_per_pipe_ib: maximum instantaneous bandwidth request
-- 
2.40.1




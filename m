Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A3675559A
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbjGPUmi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbjGPUmh (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:42:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0B9D9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:42:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B59560EBD
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:42:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8C0C433C8;
        Sun, 16 Jul 2023 20:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540155;
        bh=FE80Ea0jXX2WXQK9WLQqjBJ7dFGihcn2YWFkqeXITac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K8M97iH1iIvHRtG4njZOoPG5bApVe/NdLefWMteMXIcs4lOUyvZe/35DKcMMvF32P
         Te0/NuUA7P6pl0nv2/lOnFkB5z36Hz9j1mkHe+tVoqlxgfpZ29ChKDv/f2ai7PO28g
         TtI4SBRnfhfDMCkHUGcSrffYnMUt3QCETjNuo5Pc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 263/591] drm/msm/dsi: Flip greater-than check for slice_count and slice_per_intf
Date:   Sun, 16 Jul 2023 21:46:42 +0200
Message-ID: <20230716194930.703198144@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Marijn Suijten <marijn.suijten@somainline.org>

[ Upstream commit 82e72fd22a8f9eff4e75c08be68319008ea90a29 ]

According to downstream /and the comment copied from it/ this comparison
should be the other way around.  In other words, when the panel driver
requests to use more slices per packet than what could be sent over this
interface, it is bumped down to only use a single slice per packet (and
strangely not the number of slices that could fit on the interface).

Fixes: 08802f515c3c ("drm/msm/dsi: Add support for DSC configuration")
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Patchwork: https://patchwork.freedesktop.org/patch/515686/
Link: https://lore.kernel.org/r/20221221231943.1961117-4-marijn.suijten@somainline.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Stable-dep-of: 155fa3a91d64 ("drm/msm/dsi: Remove incorrect references to slice_count")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 5ab5e872c3cf1..ef988e4c21045 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -853,11 +853,12 @@ static void dsi_update_dsc_timing(struct msm_dsi_host *msm_host, bool is_cmd_mod
 	 */
 	slice_per_intf = DIV_ROUND_UP(hdisplay, dsc->slice_width);
 
-	/* If slice_per_pkt is greater than slice_per_intf
+	/*
+	 * If slice_count is greater than slice_per_intf
 	 * then default to 1. This can happen during partial
 	 * update.
 	 */
-	if (slice_per_intf > dsc->slice_count)
+	if (dsc->slice_count > slice_per_intf)
 		dsc->slice_count = 1;
 
 	total_bytes_per_intf = dsc->slice_chunk_size * slice_per_intf;
-- 
2.39.2




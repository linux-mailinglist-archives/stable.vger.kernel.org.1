Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE1C726D8C
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbjFGUn1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbjFGUnU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:43:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B3D1BE4
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:42:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 215EA60FFF
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:42:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3484DC433D2;
        Wed,  7 Jun 2023 20:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170576;
        bh=0v8Pmqr/5nGSIfTDDZwsBt1fsBtIeH8OhGXUdpTmTds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BdkfkZpIVRhMciJdJ43J3ElQszevvYxuCfgIup7G8sWG5lT2nLMRwkHguaNeo9J6a
         H9FBmAQVTbmgFwRNVJOL4Sge/e4xoaXsKVYo0StQDEyArUIRcLHChoLNl0F1+VUlGp
         +w7m1MPL2YvLvg4JV7J2KCMDkXMGzCTFBRlL1bEE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pin-yen Lin <treapking@chromium.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 137/225] media: mediatek: vcodec: Only apply 4K frame sizes on decoder formats
Date:   Wed,  7 Jun 2023 22:15:30 +0200
Message-ID: <20230607200918.855577461@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
References: <20230607200913.334991024@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Pin-yen Lin <treapking@chromium.org>

[ Upstream commit ed17f89e9502f03af493e130620a9bb74c07cf28 ]

When VCODEC_CAPABILITY_4K_DISABLED is not set in dec_capability, skip
formats that are not MTK_FMT_DEC so only decoder formats is updated in
mtk_init_vdec_params.

Fixes: e25528e1dbe5 ("media: mediatek: vcodec: Use 4K frame size when supported by stateful decoder")
Signed-off-by: Pin-yen Lin <treapking@chromium.org>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Yunfei Dong <yunfei.dong@mediatek.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c   | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
index 29991551cf614..0fbd030026c72 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
@@ -584,6 +584,9 @@ static void mtk_init_vdec_params(struct mtk_vcodec_ctx *ctx)
 
 	if (!(ctx->dev->dec_capability & VCODEC_CAPABILITY_4K_DISABLED)) {
 		for (i = 0; i < num_supported_formats; i++) {
+			if (mtk_video_formats[i].type != MTK_FMT_DEC)
+				continue;
+
 			mtk_video_formats[i].frmsize.max_width =
 				VCODEC_DEC_4K_CODED_WIDTH;
 			mtk_video_formats[i].frmsize.max_height =
-- 
2.39.2




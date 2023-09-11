Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9FF79BF49
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242388AbjIKU54 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238880AbjIKOHK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:07:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F83CF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:07:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7A1C433C7;
        Mon, 11 Sep 2023 14:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441226;
        bh=lF/NazABTk6h5wktyneg8+VhxzPi3Oa3WdUUuWnpMqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gwt5zU4hndK8o0Xg/ak58g2/gnMuBvw89saY96+uGS4iyhCmtHffHcjOrvFiCFMvv
         IcAIqkD/cPbeiyTgmxO8vN8A8g7Bs6vt06ntGW+gRvpVsTkou2hxUmnwco/5jzr6sD
         8yVt+Th4mgwNv35i7bsbQIBlu/qRsFd3fMCqVaJM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        CK Hu <ck.hu@mediatek.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 338/739] drm/mediatek: Add cnt checking for coverity issue
Date:   Mon, 11 Sep 2023 15:42:17 +0200
Message-ID: <20230911134700.544644172@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason-JH.Lin <jason-jh.lin@mediatek.com>

[ Upstream commit d761b9450e31e5abd212f0085d424ed32760de5a ]

CERT-C Characters and Strings (CERT STR31-C)
all_drm_priv[cnt] evaluates to an address that could be at negative
offset of an array.

In mtk_drm_get_all_drm_priv():
Guarantee that storage for strings has sufficient space for character
data and the null terminator.

So change cnt to unsigned int and check its max value.

Fixes: 1ef7ed48356c ("drm/mediatek: Modify mediatek-drm for mt8195 multi mmsys support")
Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Link: https://patchwork.kernel.org/project/dri-devel/patch/20230714094908.13087-3-jason-jh.lin@mediatek.com/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 6dcb4ba2466c0..fc217e0acd45d 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -354,7 +354,7 @@ static bool mtk_drm_get_all_drm_priv(struct device *dev)
 	const struct of_device_id *of_id;
 	struct device_node *node;
 	struct device *drm_dev;
-	int cnt = 0;
+	unsigned int cnt = 0;
 	int i, j;
 
 	for_each_child_of_node(phandle->parent, node) {
@@ -375,6 +375,9 @@ static bool mtk_drm_get_all_drm_priv(struct device *dev)
 		all_drm_priv[cnt] = dev_get_drvdata(drm_dev);
 		if (all_drm_priv[cnt] && all_drm_priv[cnt]->mtk_drm_bound)
 			cnt++;
+
+		if (cnt == MAX_CRTC)
+			break;
 	}
 
 	if (drm_priv->data->mmsys_dev_num == cnt) {
-- 
2.40.1




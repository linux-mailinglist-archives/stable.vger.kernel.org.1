Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749167ECFB0
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbjKOTuK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235386AbjKOTuJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:50:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1D01A3
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:50:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4EFC433CA;
        Wed, 15 Nov 2023 19:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077804;
        bh=Z6L44Cwca1BZpKyLBczyJkEfB5zsEckIpT+weXp2tl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EQ4NnW16dlY2Zd9MsBc/5ykY6+jRnyIEzoDWUkawJu5K565RgyFBbENg14CexpzHF
         JsKQeowLjUSKZBX0/gQld8tpKe/AChTweJEHv+u4XER7m5AhiRmhIa9vEXRLZcZWTl
         JuEQMeFEP/JZYUZvMoVcYETPlPKikOtmUQQAPvV4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Moudy Ho <moudy.ho@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 530/603] media: platform: mtk-mdp3: fix uninitialized variable in mdp_path_config()
Date:   Wed, 15 Nov 2023 14:17:55 -0500
Message-ID: <20231115191648.591824128@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Moudy Ho <moudy.ho@mediatek.com>

[ Upstream commit 2a76e7679b594ea3e1b3b7fb6c3d67158114020d ]

Fix the build warnings that were detected by the linux-media
build scripts tool:

drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c:
	In function 'mdp_path_config.isra':
drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c:
	warning: 'ctx' may be used uninitialized [-Wmaybe-uninitialized]
      |                    out = CFG_COMP(MT8195, ctx->param, outputs[0]);
      |                                           ~~~^~~~~~~
drivers/media/platform/mediatek/mdp3/mtk-img-ipi.h: note:
	in definition of macro 'CFG_COMP'
      |         (IS_ERR_OR_NULL(comp) ? 0 : _CFG_COMP(plat, comp, mem))
      |                         ^~~~
drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c:
	note: 'ctx' was declared here
      |         struct mdp_comp_ctx *ctx;
      |

Fixes: 61890ccaefaf ("media: platform: mtk-mdp3: add MediaTek MDP3 driver")
Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
index 3177592490bee..6adac857a4779 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
@@ -261,11 +261,11 @@ static int mdp_path_config(struct mdp_dev *mdp, struct mdp_cmdq_cmd *cmd,
 		const struct v4l2_rect *compose;
 		u32 out = 0;
 
+		ctx = &path->comps[index];
 		if (CFG_CHECK(MT8183, p_id))
 			out = CFG_COMP(MT8183, ctx->param, outputs[0]);
 
 		compose = path->composes[out];
-		ctx = &path->comps[index];
 		ret = call_op(ctx, config_frame, cmd, compose);
 		if (ret)
 			return ret;
-- 
2.42.0




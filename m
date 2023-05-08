Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FED6FAAA5
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235535AbjEHLFT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233663AbjEHLEf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:04:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154AD2FA15
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:03:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B843E62A6C
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:03:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA569C433D2;
        Mon,  8 May 2023 11:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543809;
        bh=wNWmtMDPNyG/bNCrvp1yfDXFETBZtd/ogoSPSsBFXDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gwk7ioMpFkPaglv8JEGDFnu/rFiOeUffIKi0PBIQjRmLLtBT1wYCV9yHRCtxghkhI
         F6lQfZxyFv1ChB5BoqwFFZglSnqDpJGfRG/9Lf8u93PcD9qy5RZKRFoGTUt4JqGGNh
         czu9ItDC4OVR8C/ghqsBE4fOOeH/VMADC0/2cmn0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 207/694] media: platform: mtk-mdp3: Add missing check and free for ida_alloc
Date:   Mon,  8 May 2023 11:40:42 +0200
Message-Id: <20230508094439.093578417@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jiasheng Jiang <jiasheng@iscas.ac.cn>

[ Upstream commit d00f592250782538cda87745607695b0fe27dcd4 ]

Add the check for the return value of the ida_alloc in order to avoid
NULL pointer dereference.
Moreover, free allocated "ctx->id" if mdp_m2m_open fails later in order
to avoid memory leak.

Fixes: 61890ccaefaf ("media: platform: mtk-mdp3: add MediaTek MDP3 driver")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-m2m.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-m2m.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-m2m.c
index 5f74ea3b7a524..8612a48bde10f 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-m2m.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-m2m.c
@@ -566,7 +566,11 @@ static int mdp_m2m_open(struct file *file)
 		goto err_free_ctx;
 	}
 
-	ctx->id = ida_alloc(&mdp->mdp_ida, GFP_KERNEL);
+	ret = ida_alloc(&mdp->mdp_ida, GFP_KERNEL);
+	if (ret < 0)
+		goto err_unlock_mutex;
+	ctx->id = ret;
+
 	ctx->mdp_dev = mdp;
 
 	v4l2_fh_init(&ctx->fh, vdev);
@@ -617,6 +621,8 @@ static int mdp_m2m_open(struct file *file)
 	v4l2_fh_del(&ctx->fh);
 err_exit_fh:
 	v4l2_fh_exit(&ctx->fh);
+	ida_free(&mdp->mdp_ida, ctx->id);
+err_unlock_mutex:
 	mutex_unlock(&mdp->m2m_lock);
 err_free_ctx:
 	kfree(ctx);
-- 
2.39.2




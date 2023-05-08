Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E940A6FA496
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbjEHKBI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbjEHKBG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:01:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0677F2E04C
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:01:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7531262171
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:01:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754CAC433D2;
        Mon,  8 May 2023 10:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540064;
        bh=jvkW4ESrj/bo14bLAISxVFn7BcmfXtFEFu1aZGXd/kk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oxDcK3q79U+q/+dcpYeZQCc6Jb7AhTXdwUFZorUzEU3hzIgAAf6uSMU30SB6zNUwD
         WVVfQEeH9K4ZKsqnG9/7tobBlEHGQ+kY1+aB716+IJK1cLLU7tms5wnusKMVGGTbBg
         p2WsmAIElRW8sZ90dW1wNStCEqr+ELBcBmzt2Sj0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yunfei Dong <yunfei.dong@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 227/611] media: mediatek: vcodec: using each instance lat_buf count replace core ready list
Date:   Mon,  8 May 2023 11:41:09 +0200
Message-Id: <20230508094429.787791234@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Yunfei Dong <yunfei.dong@mediatek.com>

[ Upstream commit f7a3780cf96925670736582b9a623a2c9ffb4166 ]

Core Hardware decoder depends on each instance lat_buf count,
calling queue_work decode again when the lat_buf count of each instance
isn't zero.

Fixes: 365e4ba01df4 ("media: mtk-vcodec: Add work queue for core hardware decode")
Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
index 3f016c87d722c..ad5002ca953e0 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
@@ -239,7 +239,7 @@ static void vdec_msg_queue_core_work(struct work_struct *work)
 	mtk_vcodec_dec_disable_hardware(ctx, MTK_VDEC_CORE);
 	vdec_msg_queue_qbuf(&ctx->msg_queue.lat_ctx, lat_buf);
 
-	if (!list_empty(&dev->msg_queue_core_ctx.ready_queue)) {
+	if (atomic_read(&lat_buf->ctx->msg_queue.core_list_cnt)) {
 		mtk_v4l2_debug(3, "re-schedule to decode for core: %d",
 			       dev->msg_queue_core_ctx.ready_num);
 		queue_work(dev->core_workqueue, &msg_queue->core_work);
-- 
2.39.2




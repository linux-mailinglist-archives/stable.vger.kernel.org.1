Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C75279B2B3
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234801AbjIKUun (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242015AbjIKPUh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:20:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2185FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:20:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390CAC433C8;
        Mon, 11 Sep 2023 15:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445631;
        bh=yzwBLj3nGHdYQGmJOasXxjW+RXhT68QCoX/dvxDVreo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hp0e+lstBUqCcNytIJjPyXhFG1OqkhTEamEhVNVuBoF3jfWWamkpXsddza7ky8yhQ
         +uMguJaalvKRPKCSjiRoncyfG2zjNfzTIKA+7k4OauTN9o8YoVSLtaPZkrqOGbTGTa
         LdMsUnX/p7Gz7YJol9qie3OKrqk2z4rWb5pq+nfE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 416/600] media: mediatek: vcodec: fix resource leaks in vdec_msg_queue_init()
Date:   Mon, 11 Sep 2023 15:47:29 +0200
Message-ID: <20230911134645.949116160@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit cf10b0bb503c974ba049d6f888b21178be20a962 ]

If we encounter any error in the vdec_msg_queue_init() then we need
to set "msg_queue->wdma_addr.size = 0;".  Normally, this is done
inside the vdec_msg_queue_deinit() function.  However, if the
first call to allocate &msg_queue->wdma_addr fails, then the
vdec_msg_queue_deinit() function is a no-op.  For that situation, just
set the size to zero explicitly and return.

There were two other error paths which did not clean up before returning.
Change those error paths to goto mem_alloc_err.

Fixes: b199fe46f35c ("media: mtk-vcodec: Add msg queue feature for lat and core architecture")
Fixes: 2f5d0aef37c6 ("media: mediatek: vcodec: support stateless AV1 decoder")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
index 675f62814f94e..a81212c0ade9d 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
@@ -313,6 +313,7 @@ int vdec_msg_queue_init(struct vdec_msg_queue *msg_queue,
 	err = mtk_vcodec_mem_alloc(ctx, &msg_queue->wdma_addr);
 	if (err) {
 		mtk_v4l2_err("failed to allocate wdma_addr buf");
+		msg_queue->wdma_addr.size = 0;
 		return -ENOMEM;
 	}
 	msg_queue->wdma_rptr_addr = msg_queue->wdma_addr.dma_addr;
-- 
2.40.1




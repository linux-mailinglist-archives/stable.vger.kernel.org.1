Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3B379AE5C
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377524AbjIKW0x (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239177AbjIKONt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:13:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDDEDE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:13:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B05C433C8;
        Mon, 11 Sep 2023 14:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441624;
        bh=rciRXfrP9282CovvK/QOa8kAg+YadThOjA8a/yhxOIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dXxHtgo445+8u6L07XgtaT4kRbsNLmGru7EMbt6ogxCr/a518DNGQnAt0vIsnrB+8
         1Aiw8CXThlzq9msvtbFDFuTceSSwj/0LUELLDd5tN/CGj1wc6/JkTNiSu+Ro13Nbmm
         ljyW3z2VtTRfS6+FLf/3JpI7/vmPQpUXLOzR0xkg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 479/739] media: mediatek: vcodec: fix resource leaks in vdec_msg_queue_init()
Date:   Mon, 11 Sep 2023 15:44:38 +0200
Message-ID: <20230911134704.520823265@linuxfoundation.org>
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
 drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
index f2d21b5bc5c3a..898f9dbb9f46d 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
@@ -308,6 +308,7 @@ int vdec_msg_queue_init(struct vdec_msg_queue *msg_queue,
 	err = mtk_vcodec_mem_alloc(ctx, &msg_queue->wdma_addr);
 	if (err) {
 		mtk_v4l2_err("failed to allocate wdma_addr buf");
+		msg_queue->wdma_addr.size = 0;
 		return -ENOMEM;
 	}
 	msg_queue->wdma_rptr_addr = msg_queue->wdma_addr.dma_addr;
@@ -339,14 +340,14 @@ int vdec_msg_queue_init(struct vdec_msg_queue *msg_queue,
 			err = mtk_vcodec_mem_alloc(ctx, &lat_buf->rd_mv_addr);
 			if (err) {
 				mtk_v4l2_err("failed to allocate rd_mv_addr buf[%d]", i);
-				return -ENOMEM;
+				goto mem_alloc_err;
 			}
 
 			lat_buf->tile_addr.size = VDEC_LAT_TILE_SZ;
 			err = mtk_vcodec_mem_alloc(ctx, &lat_buf->tile_addr);
 			if (err) {
 				mtk_v4l2_err("failed to allocate tile_addr buf[%d]", i);
-				return -ENOMEM;
+				goto mem_alloc_err;
 			}
 		}
 
-- 
2.40.1




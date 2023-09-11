Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA2179BF05
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350367AbjIKVhL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242014AbjIKPUd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:20:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391A2FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:20:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78486C433CC;
        Mon, 11 Sep 2023 15:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445628;
        bh=XwTOlj7qVf9eXCCx58EG9vP0PWW5wurVGgr1+N7CDH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=glrpbL1YQxxoRA97BmgE4ex2zrmmKlYdyEEjOHLHU60C+yq0PpgJgP34iejOa84HX
         owxjG4YHO77oahuajM9QSdug77fwxlDC3OzN7Wak5eBVupIDYhTZN7fOcGnkwcP81n
         i359b7+E7k6w+zds3qDHhpDUFrew1M9u4t9z6BGU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 415/600] media: mediatek: vcodec: fix potential double free
Date:   Mon, 11 Sep 2023 15:47:28 +0200
Message-ID: <20230911134645.920936840@linuxfoundation.org>
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

[ Upstream commit be40f524b6edac4fb9a98ef79620fd9b9497a998 ]

The "lat_buf->private_data" needs to be set to NULL to prevent a
double free.  How this would happen is if vdec_msg_queue_init() failed
twice in a row and on the second time it failed earlier than on the
first time.

The vdec_msg_queue_init() function has a loop which does:
	for (i = 0; i < NUM_BUFFER_COUNT; i++) {

Each iteration initializes one element in the msg_queue->lat_buf[] array
and then the clean up function vdec_msg_queue_deinit() frees each
element of the msg_queue->lat_buf[] array.  This clean up code relies
on the assumption that every element is either initialized or zeroed.
Leaving a freed pointer which is non-zero breaks the assumption.

Fixes: b199fe46f35c ("media: mtk-vcodec: Add msg queue feature for lat and core architecture")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
index 03f8d7cd8eddc..675f62814f94e 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
@@ -246,6 +246,7 @@ void vdec_msg_queue_deinit(struct vdec_msg_queue *msg_queue,
 			mtk_vcodec_mem_free(ctx, mem);
 
 		kfree(lat_buf->private_data);
+		lat_buf->private_data = NULL;
 	}
 }
 
-- 
2.40.1




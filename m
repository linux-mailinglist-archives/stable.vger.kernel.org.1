Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501A379C0D4
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378571AbjIKWfi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239176AbjIKONq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:13:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC2EDE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:13:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F890C433C8;
        Mon, 11 Sep 2023 14:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441621;
        bh=UfgcpOqVv9npvDzEkORKlMCgLllIuq4053v20k6oSqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tIpcukW/kI4UByXY8RN4HmCs9yMWc1i+BCsJwP0l0KZ0nBqU1f1BOnzPQTvhFXG7V
         perf2oHXLZurUq5+yYicvuuEANOqqmA8e0RrCholl/QtTLUCzrgA34IoH1xgYyTsWE
         QvwfNhODBbkzSjxZ/6UEfbnmNyz1WIaKo83dzH3U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 478/739] media: mediatek: vcodec: fix potential double free
Date:   Mon, 11 Sep 2023 15:44:37 +0200
Message-ID: <20230911134704.493778637@linuxfoundation.org>
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
index 04e6dc6cfa1de..f2d21b5bc5c3a 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
@@ -231,6 +231,7 @@ void vdec_msg_queue_deinit(struct vdec_msg_queue *msg_queue,
 			mtk_vcodec_mem_free(ctx, mem);
 
 		kfree(lat_buf->private_data);
+		lat_buf->private_data = NULL;
 	}
 
 	if (msg_queue->wdma_addr.size)
-- 
2.40.1




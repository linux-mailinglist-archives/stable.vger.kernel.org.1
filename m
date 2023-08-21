Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4D778331D
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjHUUBh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjHUUBh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:01:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8707A128
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:01:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 078B4647BC
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:01:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 138B8C433C8;
        Mon, 21 Aug 2023 20:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648091;
        bh=b/O4cFu4h1BNYvcxVUMhwtPAOLTfT4j7dk+kusv3rwY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yW9gJEJbROpZETMuMfpHrvauGLjOlDA/6IvQDID4ea0D9bH1IJ0O5FKgpuuNW+cLm
         6AG8rEugqHnm7NDSrUQRjg1vL/6ZInYdASfgbfqDNK0h2kYR0QJTPbQ7WSpbGgUmhA
         mI3Rh7qal4kC5snIPyLt+kv2DAhjAEIuadR0W8Ts=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Avichal Rakesh <arakesh@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 051/234] usb: gadget: uvc: queue empty isoc requests if no video buffer is available
Date:   Mon, 21 Aug 2023 21:40:14 +0200
Message-ID: <20230821194130.984394147@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Avichal Rakesh <arakesh@google.com>

[ Upstream commit c3ff12a92bd7072170978b8b41c2fa41b038139a ]

ISOC transfers expect a certain cadence of requests being queued. Not
keeping up with the expected rate of requests results in missed ISOC
transfers (EXDEV). The application layer may or may not produce video
frames to match this expectation, so uvc gadget driver must handle cases
where the application is not queuing up buffers fast enough to fulfill
ISOC requirements.

Currently, uvc gadget driver waits for new video buffer to become available
before queuing up usb requests. With this patch the gadget driver queues up
0 length usb requests whenever there are no video buffers available. The
USB controller's complete callback is used as the limiter for how quickly
the 0 length packets will be queued. Video buffers are still queued as
soon as they become available.

Link: https://lore.kernel.org/CAMHf4WKbi6KBPQztj9FA4kPvESc1fVKrC8G73-cs6tTeQby9=w@mail.gmail.com/
Signed-off-by: Avichal Rakesh <arakesh@google.com>
Link: https://lore.kernel.org/r/20230508231103.1621375-1-arakesh@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/uvc_video.c | 32 ++++++++++++++++++-------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index dd1c6b2ca7c6f..e81865978299c 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -386,6 +386,9 @@ static void uvcg_video_pump(struct work_struct *work)
 	struct uvc_buffer *buf;
 	unsigned long flags;
 	int ret;
+	bool buf_int;
+	/* video->max_payload_size is only set when using bulk transfer */
+	bool is_bulk = video->max_payload_size;
 
 	while (video->ep->enabled) {
 		/*
@@ -408,20 +411,35 @@ static void uvcg_video_pump(struct work_struct *work)
 		 */
 		spin_lock_irqsave(&queue->irqlock, flags);
 		buf = uvcg_queue_head(queue);
-		if (buf == NULL) {
+
+		if (buf != NULL) {
+			video->encode(req, video, buf);
+			/* Always interrupt for the last request of a video buffer */
+			buf_int = buf->state == UVC_BUF_STATE_DONE;
+		} else if (!(queue->flags & UVC_QUEUE_DISCONNECTED) && !is_bulk) {
+			/*
+			 * No video buffer available; the queue is still connected and
+			 * we're traferring over ISOC. Queue a 0 length request to
+			 * prevent missed ISOC transfers.
+			 */
+			req->length = 0;
+			buf_int = false;
+		} else {
+			/*
+			 * Either queue has been disconnected or no video buffer
+			 * available to bulk transfer. Either way, stop processing
+			 * further.
+			 */
 			spin_unlock_irqrestore(&queue->irqlock, flags);
 			break;
 		}
 
-		video->encode(req, video, buf);
-
 		/*
 		 * With usb3 we have more requests. This will decrease the
 		 * interrupt load to a quarter but also catches the corner
 		 * cases, which needs to be handled.
 		 */
-		if (list_empty(&video->req_free) ||
-		    buf->state == UVC_BUF_STATE_DONE ||
+		if (list_empty(&video->req_free) || buf_int ||
 		    !(video->req_int_count %
 		       DIV_ROUND_UP(video->uvc_num_requests, 4))) {
 			video->req_int_count = 0;
@@ -441,8 +459,7 @@ static void uvcg_video_pump(struct work_struct *work)
 
 		/* Endpoint now owns the request */
 		req = NULL;
-		if (buf->state != UVC_BUF_STATE_DONE)
-			video->req_int_count++;
+		video->req_int_count++;
 	}
 
 	if (!req)
@@ -527,4 +544,3 @@ int uvcg_video_init(struct uvc_video *video, struct uvc_device *uvc)
 			V4L2_BUF_TYPE_VIDEO_OUTPUT, &video->mutex);
 	return 0;
 }
-
-- 
2.40.1




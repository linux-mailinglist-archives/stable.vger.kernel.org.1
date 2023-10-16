Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5DE7CAC34
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbjJPOvE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbjJPOvD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:51:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AD795
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:51:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE16C433C7;
        Mon, 16 Oct 2023 14:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697467860;
        bh=Ph9FOGnwXWDzsNTSDdG2ZAqhGaZEeER02UGacmaewkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uzCZlWNblW1OxlmunkVgS6zr/njExZ4c5XdZWbAX+r0Q8n3noLVHqwlUeQxshSv58
         W0zmTeTGc0va3av5GWyZZ6oezBW8hkBsN51+l7i0UXv70PBmtWaDxUlsRiSQyFdwBY
         KncQNUNUx27Jn/9Pt+jN2bHy8unMMJpaO5ndZfvQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xingxing Luo <xingxing.luo@unisoc.com>
Subject: [PATCH 6.5 107/191] usb: musb: Get the musb_qh poniter after musb_giveback
Date:   Mon, 16 Oct 2023 10:41:32 +0200
Message-ID: <20231016084017.887984397@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xingxing Luo <xingxing.luo@unisoc.com>

commit 33d7e37232155aadebe4145dcc592f00dabd7a2b upstream.

When multiple threads are performing USB transmission, musb->lock will be
unlocked when musb_giveback is executed. At this time, qh may be released
in the dequeue process in other threads, resulting in a wild pointer, so
it needs to be here get qh again, and judge whether qh is NULL, and when
dequeue, you need to set qh to NULL.

Fixes: dbac5d07d13e ("usb: musb: host: don't start next rx urb if current one failed")
Cc: stable@vger.kernel.org
Signed-off-by: Xingxing Luo <xingxing.luo@unisoc.com>
Link: https://lore.kernel.org/r/20230919033055.14085-1-xingxing.luo@unisoc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/musb/musb_host.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index a02c29216955..bc4507781167 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -321,10 +321,16 @@ static void musb_advance_schedule(struct musb *musb, struct urb *urb,
 	musb_giveback(musb, urb, status);
 	qh->is_ready = ready;
 
+	/*
+	 * musb->lock had been unlocked in musb_giveback, so qh may
+	 * be freed, need to get it again
+	 */
+	qh = musb_ep_get_qh(hw_ep, is_in);
+
 	/* reclaim resources (and bandwidth) ASAP; deschedule it, and
 	 * invalidate qh as soon as list_empty(&hep->urb_list)
 	 */
-	if (list_empty(&qh->hep->urb_list)) {
+	if (qh && list_empty(&qh->hep->urb_list)) {
 		struct list_head	*head;
 		struct dma_controller	*dma = musb->dma_controller;
 
@@ -2398,6 +2404,7 @@ static int musb_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 		 * and its URB list has emptied, recycle this qh.
 		 */
 		if (ready && list_empty(&qh->hep->urb_list)) {
+			musb_ep_set_qh(qh->hw_ep, is_in, NULL);
 			qh->hep->hcpriv = NULL;
 			list_del(&qh->ring);
 			kfree(qh);
-- 
2.42.0




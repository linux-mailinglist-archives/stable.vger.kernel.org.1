Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3DA703378
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242800AbjEOQhY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242723AbjEOQhX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:37:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94823C22
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:37:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4750762837
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:37:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E409C433EF;
        Mon, 15 May 2023 16:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684168641;
        bh=XlUpJ7Pi01HnD8swK0ZTBWvr6cUn/YaGoA7TnB+qEKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J3Jbkfd0gGRzSLOfmVHIJm6S7Mj3X1FMQ8+NdUXW7OPhZdK5yoAOIJI+p0lWcddKS
         NoefYJNxdbYjlpYvRfg3I/1RN4p5ytARR+y1RD2VGw7r6yuw0OeeTXnOe1HAVi/jwP
         hohFeX+8xJMy60P/Q53bhUL5RrBWVrG5LNSQb9tE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@infradead.org>,
        Thomas Voegtle <tv@lio96.de>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.14 114/116] drbd: correctly submit flush bio on barrier
Date:   Mon, 15 May 2023 18:26:51 +0200
Message-Id: <20230515161702.018761516@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161658.228491273@linuxfoundation.org>
References: <20230515161658.228491273@linuxfoundation.org>
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

From: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>

commit 3899d94e3831ee07ea6821c032dc297aec80586a upstream.

When we receive a flush command (or "barrier" in DRBD), we currently use
a REQ_OP_FLUSH with the REQ_PREFLUSH flag set.

The correct way to submit a flush bio is by using a REQ_OP_WRITE without
any data, and set the REQ_PREFLUSH flag.

Since commit b4a6bb3a67aa ("block: add a sanity check for non-write
flush/fua bios"), this triggers a warning in the block layer, but this
has been broken for quite some time before that.

So use the correct set of flags to actually make the flush happen.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: stable@vger.kernel.org
Fixes: f9ff0da56437 ("drbd: allow parallel flushes for multi-volume resources")
Reported-by: Thomas Voegtle <tv@lio96.de>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20230503121937.17232-1-christoph.boehmwalder@linbit.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/drbd/drbd_receiver.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1309,7 +1309,7 @@ static void submit_one_flush(struct drbd
 	bio_set_dev(bio, device->ldev->backing_bdev);
 	bio->bi_private = octx;
 	bio->bi_end_io = one_flush_endio;
-	bio->bi_opf = REQ_OP_FLUSH | REQ_PREFLUSH;
+	bio->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
 
 	device->flush_jif = jiffies;
 	set_bit(FLUSH_PENDING, &device->flags);



Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D17E6FA96F
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbjEHKvN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235259AbjEHKuv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:50:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3306F27F13
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:50:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3DE56291F
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E0DC433EF;
        Mon,  8 May 2023 10:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543013;
        bh=FtV+m2S0jaIWeJiyxNUkr0FhixAtSJNNEoRnu34VeVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zSn8CN2YB4kbHlpWDnPQj4kErwIHwepKaYAXymlmvaifRxiiX9qLYY892SDXH5ziH
         0eL46nPvj0qUqSd2tEV8aUQBvYQGS2+W7A5jLCuICqKvk8aZ/6CzMpoqCxHmvZ6djq
         KL5vFAAkrQInLxik6fkqaJd7MY2DoqeszrZQFn2E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@infradead.org>,
        Thomas Voegtle <tv@lio96.de>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.2 621/663] drbd: correctly submit flush bio on barrier
Date:   Mon,  8 May 2023 11:47:27 +0200
Message-Id: <20230508094449.915722925@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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
@@ -1283,7 +1283,7 @@ static void one_flush_endio(struct bio *
 static void submit_one_flush(struct drbd_device *device, struct issue_flush_context *ctx)
 {
 	struct bio *bio = bio_alloc(device->ldev->backing_bdev, 0,
-				    REQ_OP_FLUSH | REQ_PREFLUSH, GFP_NOIO);
+				    REQ_OP_WRITE | REQ_PREFLUSH, GFP_NOIO);
 	struct one_flush_context *octx = kmalloc(sizeof(*octx), GFP_NOIO);
 
 	if (!octx) {



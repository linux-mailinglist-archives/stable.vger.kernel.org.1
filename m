Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A98C6FA7EB
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbjEHKgM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234800AbjEHKfl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:35:41 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1930828A9A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:35:11 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3078cc99232so1558492f8f.3
        for <stable@vger.kernel.org>; Mon, 08 May 2023 03:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20221208.gappssmtp.com; s=20221208; t=1683542109; x=1686134109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9LhHPq9Cv4hOi0/idQ3kzC2OWbj7XvvKzwe6zTzllE=;
        b=W3EwQef3OqhORw1h77ndtnQWRZbOP8sH3jgXl3vIo8gvBcIne3/GYDGSyYn477S8T1
         jfeopDpgziKBkzAm7Ke3IJ3Gt4CSojQXNCTk6fLEA64B0k0hf2vKXDYHJCL60sBAgWTY
         e97F6w3+lOSysf1QZ/IvCQmjID2GFfGthK6c2Xz3LUriZYog5E1Imu2JPhmh7n4xgJk2
         wjS9AKPw5fjKgsQLrPHYGH/KFYOLsajcR+dvMrtNnivSWS0WjS+oV5yuCVRH/+8mnEa1
         +rayUedT0beKHqSaQD4JtaCqqlO8xE/Q9paTBVTVHrI/OKYZturXkbHO+Jh9ZIzItvjJ
         9Myg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683542109; x=1686134109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o9LhHPq9Cv4hOi0/idQ3kzC2OWbj7XvvKzwe6zTzllE=;
        b=WwhoEVc9gtwwJQZYW0a1cBk+U0u+Oczh1Hozgw7PoLKfyuUxqWXkBW9YL6DR79c4wX
         qA0drYQggmsgwCo383u4wrWu+2+5RknhNxLRYpXT+yTNm0Y7R7xDaOcWwvLe7XV6g5+w
         dx0CIWfg2iQ+L3Ajfjfpk4X9n60jF6nlJS2d3QOae8rTagN/uv7qfRz/A4kCx227Uqn1
         9KBDjXfA2yAgQboGp5dIBhGDmwA2Jwc93oNXl8IgKrgCdoz5H5/n5rcJ3UIP5D9pNgdl
         mKIDtj43bh8BRCzzJm7bdH+JcoClFi6PsQd+Gl641Ep6NZZbfetV7xi0eXk0K5q1Negv
         Yc5A==
X-Gm-Message-State: AC+VfDwkmB4A6Mw0oq1Qf67mZY3EO73QdE4NlFd43OdzkRDwUOKONLKc
        p1Huz7rYdrvyLlw6gvHImIJBdmCAdn3QYjJw3XN7Wg==
X-Google-Smtp-Source: ACHHUZ5J9ejAP1WOR1Dg+8rehRzCkTiltnDMS9w0/L8bJ9ehUtEs72y5IIzHUpBAiwwaVdVJ14o9cw==
X-Received: by 2002:adf:f188:0:b0:307:7f3a:97cf with SMTP id h8-20020adff188000000b003077f3a97cfmr7280926wro.43.1683542109263;
        Mon, 08 May 2023 03:35:09 -0700 (PDT)
Received: from localhost (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id e1-20020a5d4e81000000b003062765bf1dsm10944934wru.33.2023.05.08.03.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 03:35:08 -0700 (PDT)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     stable@vger.kernel.org
Cc:     =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Voegtle <tv@lio96.de>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.14.y] drbd: correctly submit flush bio on barrier
Date:   Mon,  8 May 2023 12:35:06 +0200
Message-Id: <20230508103506.3980789-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <2023050713-unshaved-harmonica-4f00@gregkh>
References: <2023050713-unshaved-harmonica-4f00@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

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
(cherry picked from commit 3899d94e3831ee07ea6821c032dc297aec80586a)
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index a7c180426c60..5a63010f2af3 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1309,7 +1309,7 @@ static void submit_one_flush(struct drbd_device *device, struct issue_flush_cont
 	bio_set_dev(bio, device->ldev->backing_bdev);
 	bio->bi_private = octx;
 	bio->bi_end_io = one_flush_endio;
-	bio->bi_opf = REQ_OP_FLUSH | REQ_PREFLUSH;
+	bio->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
 
 	device->flush_jif = jiffies;
 	set_bit(FLUSH_PENDING, &device->flags);
-- 
2.39.2


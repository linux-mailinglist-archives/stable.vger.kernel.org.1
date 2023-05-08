Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504EA6FA99D
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbjEHKxi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235144AbjEHKxR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:53:17 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507EA2B418
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:52:33 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f427118644so5494295e9.0
        for <stable@vger.kernel.org>; Mon, 08 May 2023 03:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20221208.gappssmtp.com; s=20221208; t=1683543151; x=1686135151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWD1lUHsoofgu/PdyMM1mBZ7PEtH3S1SV5gJRNJ3wSc=;
        b=lbkHQzDbQyUk0OS2nAfQBTEKPvVewjNDiAbKFGlPphch+47tIrbt30FabVC2SJL1OL
         UFOyi082BXR+XXjORnijRhyL6T7UQqFCVuMrkjqj+14LSID2JUh34DbHFW3qcd57E+5U
         mmhZDp3lNDoN+GMkTFgWr9V9YrQg3V3FFK2ecM6k+0U9SLeub772J3kAka90eVdOsEco
         4sOTrelSv0DNoqMqwfJMwHgnZ4UHh/TH9SaeaJwlbGxPrB8Acrqqh9PtmDM6lCxsJOfS
         67RiUEIhNtv46QSgifeRbjqovJR8MOmKnO9Eu160MT7JN0yx9A//aVw08ATRlTcg6Bq3
         8Q+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683543151; x=1686135151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GWD1lUHsoofgu/PdyMM1mBZ7PEtH3S1SV5gJRNJ3wSc=;
        b=AKH4mFi1ZUEpkFfycC5R43N+cs9yGt5RF2MLfuKgd+uQKw2czfFujvTbaBlJLP2FWa
         0DeGFnKM4JdWBHDg8Yzz2IJJTMWgMRc5oaYsT+9teCpVGfvIum+UrKQahQ8AtPe3U3rG
         YMtszjADPlT7AtnZi2d3gxFmm/Qzv5IV6KSau/2ZUysMKsHI28/innOIKLwE8HaBGKWu
         yi6771JWduzrMHJZ8gnnKTSVEFey+xdSlH+FjPlomMkSwbKtX/K+jaSRpDDX94cUB4A8
         iTbe9ENQVtTMEk16zBmiDfcTw8dM6t1zeIw4eLQk2mjSNa+1dfwBRJ/GfHtB4ogdCB9a
         f7tw==
X-Gm-Message-State: AC+VfDyomqr7wOFWKy6YJm+WTcJSywpShQEplv5k+rUMY5qs87M5xaaV
        gWEdEskRaL0/fXWS3mmkWOGqCW0euJLE2gb8m5bofA==
X-Google-Smtp-Source: ACHHUZ4J4dSgvpiifkDE8XeQuYx7mxlTEvZM8f3uHK3A0gdxyO9IIIRydFgXXL3iZxF4Hf+V7if4pQ==
X-Received: by 2002:a05:600c:3646:b0:3f4:2215:6d6 with SMTP id y6-20020a05600c364600b003f4221506d6mr3138312wmq.33.1683543151565;
        Mon, 08 May 2023 03:52:31 -0700 (PDT)
Received: from localhost (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id z18-20020a1c4c12000000b003f188f608b9sm16423426wmf.8.2023.05.08.03.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 03:52:31 -0700 (PDT)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     stable@vger.kernel.org
Cc:     =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Voegtle <tv@lio96.de>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.10.y] drbd: correctly submit flush bio on barrier
Date:   Mon,  8 May 2023 12:52:27 +0200
Message-Id: <20230508105227.4189035-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <2023050709-pebbly-partridge-c4e9@gregkh>
References: <2023050709-pebbly-partridge-c4e9@gregkh>
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
index dc333dbe5232..405e09575f08 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1299,7 +1299,7 @@ static void submit_one_flush(struct drbd_device *device, struct issue_flush_cont
 	bio_set_dev(bio, device->ldev->backing_bdev);
 	bio->bi_private = octx;
 	bio->bi_end_io = one_flush_endio;
-	bio->bi_opf = REQ_OP_FLUSH | REQ_PREFLUSH;
+	bio->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
 
 	device->flush_jif = jiffies;
 	set_bit(FLUSH_PENDING, &device->flags);
-- 
2.39.2


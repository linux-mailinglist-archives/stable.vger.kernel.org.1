Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05CA6FA9F2
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbjEHK5V (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235322AbjEHK44 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:56:56 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7767A33FCA
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:55:53 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3075e802738so3792860f8f.1
        for <stable@vger.kernel.org>; Mon, 08 May 2023 03:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20221208.gappssmtp.com; s=20221208; t=1683543351; x=1686135351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFWoyq0s3lK6vK8jsQ+rYcPtKRWltvnVLE1wXeUTTns=;
        b=E1jmtIw9RPpF8Ic6tlsKq1AxCgXuRW9Q4n9MyjRlBFXGyQcZHpKAb5ER9yvQs+U5Lh
         LZKZQ+zE2j10KR4yXyGWseo5oRRO178oHuWP2J0dZ79eNclS4HtewZ0ilTf+7Bgy0N13
         rTROutAEOp0y/ZIzw+mC91/gmOvX3z3jT5cyqrHycozGdYchwavsSgClXdiIvHg1DvXH
         CVcduKfXfKFmM5X9YBZEZK1M4TIMHDfKvFZ5tIx/dWO5uCO18PethEHZSzNp+XZjnfmP
         btUmiZiM4lCWRbZ+85IrLEdS/t1pp6Vk02vyrknxO+1NaL3Jjm42J39IJDNETTLALc7P
         S9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683543351; x=1686135351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFWoyq0s3lK6vK8jsQ+rYcPtKRWltvnVLE1wXeUTTns=;
        b=N9dWBmorG+T4ocHOepC5vopXzbLXuJbEjononMc/H1zR52owYFSG1pfRJw8owu/hez
         DCcNjbM8FV0IgeT+JatrDJNyoLHAXVsKtfz45kkCs8nuC8RVwk3x77L8OBYZXX64UgYx
         /nrVuLkG39DSEHPX7ikb2CbYcYMrRo/sZ8QkyTqh64LcBlzTOsb3MWce0MMNlPQ8oaiA
         /jGIAAb38N7uFNp+bcF02Oq1m2JplIZsdBqAhXatEZxlctdUqOnyQgmK8fe7I0T1YSRK
         +Dgw7Frb6c+SzYTYtWkeBxOpPL5xH0/EP1UjW3KkxK5A/RnIBCiF75vqREe3rfR53wkX
         ietA==
X-Gm-Message-State: AC+VfDzGDYvsovKaGrRMYC0VB854HqTy+VfblqKnfVcifl/UIsFS6sR9
        E+phjPQBuXUqzs8ufjvdtcgmz+n0CMrfjRlTPa3iFQ==
X-Google-Smtp-Source: ACHHUZ6QKtXHIfROUaUEINGLCTxrXMffJJKEIV2X56oNO9pRHZu7j5qvINWEqPqwtPNebH/ecaPYGg==
X-Received: by 2002:adf:dc81:0:b0:2f8:c94c:3895 with SMTP id r1-20020adfdc81000000b002f8c94c3895mr6888639wrj.23.1683543351647;
        Mon, 08 May 2023 03:55:51 -0700 (PDT)
Received: from localhost (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id l18-20020a5d4bd2000000b003078bb639bdsm6704778wrt.68.2023.05.08.03.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 03:55:51 -0700 (PDT)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     stable@vger.kernel.org
Cc:     =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Voegtle <tv@lio96.de>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.15.y] drbd: correctly submit flush bio on barrier
Date:   Mon,  8 May 2023 12:55:47 +0200
Message-Id: <20230508105547.66993-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <2023050708-absently-subsidy-099a@gregkh>
References: <2023050708-absently-subsidy-099a@gregkh>
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
index 1f740e42e457..0104e101b0d7 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1301,7 +1301,7 @@ static void submit_one_flush(struct drbd_device *device, struct issue_flush_cont
 	bio_set_dev(bio, device->ldev->backing_bdev);
 	bio->bi_private = octx;
 	bio->bi_end_io = one_flush_endio;
-	bio->bi_opf = REQ_OP_FLUSH | REQ_PREFLUSH;
+	bio->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
 
 	device->flush_jif = jiffies;
 	set_bit(FLUSH_PENDING, &device->flags);
-- 
2.39.2


Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582B26FA8AB
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbjEHKoQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234946AbjEHKne (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:43:34 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BF126EB2
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:42:27 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f4271185daso5528165e9.2
        for <stable@vger.kernel.org>; Mon, 08 May 2023 03:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20221208.gappssmtp.com; s=20221208; t=1683542545; x=1686134545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFsL+2XHh4zjwVpIcd9Ep6UeCADXdby3B06oiahzjYE=;
        b=lM6aIlfz73aEM/7lO1UPJVX9GOhhLN+k1SA/7ECSWqumhfH9yRUgGb2O46FZV9MLqU
         S8OAtBqL8v+NCTL6e1/uQ7YsKD7Pz/f9CapFrL8uUk3GVQMKGDzZEu2yfrjA8bzSHgIG
         btmvz+M2YS5Ogp5/pY4tzJ/vRRkipI+ZvR3PVeMhiGHuAjQlDPjbXCgO2QpyIOfdSZ+0
         g6DAGDTA5tI62QRK0Z/J9icUThCv4w6hnWXBFdhb9P5vo8aJ8z4VGWn1izLZ1ZEX90zc
         35Oma/sfWPOIjckz4JtMXp2wsJJTmJQCR1yLjm6zN52AQKZbDXaRb4EQWaCkt2Y9zY1C
         OrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683542545; x=1686134545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFsL+2XHh4zjwVpIcd9Ep6UeCADXdby3B06oiahzjYE=;
        b=J3y6qdZtVIYH8lrPujyTTKnQm1Gbz72OCpyNzlgzQVNDrOI0c6oEMwsKKF5vookJBR
         JRySLVcro8arGajIS34FbAT3l0Sn/7Xl1Je8DbTongq9QYxBduBxlEPSFFCDTaR9X1OC
         uOWFvUQgREjq2hkLy5k2uVDah07M6ApHGmiQ8zanM9K9zvckpmG3c9uEYuJ8bgEDOqaC
         vrOxQDgAzELr6sK4bLVem81i0dUJ9L9z1tyoj8uixYFJJcLHXiwMovEVPL+Ryh53tpOU
         4qFgUt1jKlsDTROyLUEQ0G8YMhO25/DZacKG8n+UCVITfHwKYLY/7EtJ7v0iSMrmVm8/
         MIVg==
X-Gm-Message-State: AC+VfDyWUv4VDCvTsgIcRPMO7MyCd3JYESzI1Qv+n3dJPM2x+wKNOIND
        t4yBSH2gdJnqXHGHwGoAVHPOX3BcIFcD90wZvgfMkg==
X-Google-Smtp-Source: ACHHUZ5MHLCfgy2+yKxqxREglukkmSRM2Z1IBN/mXxrCg4aw0jNeKmTsnIDUJm5vZ3tsUwRiKUePhQ==
X-Received: by 2002:a05:600c:2210:b0:3f4:2174:b288 with SMTP id z16-20020a05600c221000b003f42174b288mr3216221wml.4.1683542545554;
        Mon, 08 May 2023 03:42:25 -0700 (PDT)
Received: from localhost (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id u16-20020a05600c00d000b003f428c4155csm528288wmm.11.2023.05.08.03.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 03:42:25 -0700 (PDT)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     stable@vger.kernel.org
Cc:     =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Voegtle <tv@lio96.de>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.4.y] drbd: correctly submit flush bio on barrier
Date:   Mon,  8 May 2023 12:42:08 +0200
Message-Id: <20230508104208.4111006-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <2023050710-headache-grinch-e08f@gregkh>
References: <2023050710-headache-grinch-e08f@gregkh>
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
index 2b3103c30857..d94f41a0abbe 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1298,7 +1298,7 @@ static void submit_one_flush(struct drbd_device *device, struct issue_flush_cont
 	bio_set_dev(bio, device->ldev->backing_bdev);
 	bio->bi_private = octx;
 	bio->bi_end_io = one_flush_endio;
-	bio->bi_opf = REQ_OP_FLUSH | REQ_PREFLUSH;
+	bio->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
 
 	device->flush_jif = jiffies;
 	set_bit(FLUSH_PENDING, &device->flags);
-- 
2.39.2


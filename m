Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9E56FA83E
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbjEHKi6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234838AbjEHKil (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:38:41 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3F024A91
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:38:40 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3078cc99232so1561530f8f.3
        for <stable@vger.kernel.org>; Mon, 08 May 2023 03:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20221208.gappssmtp.com; s=20221208; t=1683542318; x=1686134318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnQjRjumfdCQ1i8cE0e/QFT3GXiz44/lXUu6ytQdLqA=;
        b=vMFnriYva5D6xvHKkH/4N4P0FwHMvClUgfAmIFEuALMPSqLFWJMeJsKVJ8X3Jsgq1F
         VUQi+UrseGEJ32/XSRgiaQI3NN8ip2kzshp2iqZICZRScjAjQtAjVKy0d86i8VZVR8Vq
         AEQCaqbifE2BH2fNxwIYjtlS2G5/zRD0IbBg8NGL6yQ1ERFWvlvKo+lti/sxX3B15eVc
         jTFYcoT8cIkECZH1hZ7bGf42SZT4AgCZThOaX8I3BLtsbOpYny4RyHHKwuBDWWnUYwtZ
         322ZebcCWmz4cDU5BFuSucEK5hX/SggXBbnuPY3u81PlwLBUvKtpAAdDXwelwJ199t4C
         HjTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683542318; x=1686134318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fnQjRjumfdCQ1i8cE0e/QFT3GXiz44/lXUu6ytQdLqA=;
        b=fqvDLysY77ecLF9wfvOk3WAGXR6fIU/SKeY6nc+018dgIgvSwh0gbhYAdVFtvcLOTj
         XTzBOAzG/FwglIpaM9XZz7ADJjtd7cYrInYfBlbxLRB4hyvzG4KK10q7Wm4HCyajeWaU
         kytoVNUbizlql8gk6edUBF8IsuBn5ZfuTop6axfogl6YvsvZwDF9KzU3cV2F258wqWRz
         gT7tN+vieg9utdxFRcMy/oH3j9pxrqY325oQnBJRIXmoh6iWQcFPVppr6tpTlBl6yzlj
         qQIA3tlirYqWTLUwVTbM+bPvsu9SyCTwmOc66ZBH+nOoQ5QcJl8NLqJqb1gVIXoe0wu7
         0ueA==
X-Gm-Message-State: AC+VfDx3gq7j5JJPR3ojFxyxI900YkX9WeEDktr2DLS5l4uvfEndHVyk
        08KWe6K+JVuWpY35WeteyqyW2cWknrIyraOX8YTdXQ==
X-Google-Smtp-Source: ACHHUZ7pBioGPwm7l7srI3qKOno2usbM4MEytPCbCTjtWN+tHjWG+W0RLKak9h5ppOQ9EGy+Ejry4A==
X-Received: by 2002:adf:e342:0:b0:306:35d1:7a9b with SMTP id n2-20020adfe342000000b0030635d17a9bmr6904292wrj.32.1683542318200;
        Mon, 08 May 2023 03:38:38 -0700 (PDT)
Received: from localhost (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id q15-20020adff94f000000b003078b3e2845sm6816700wrr.31.2023.05.08.03.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 03:38:37 -0700 (PDT)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     stable@vger.kernel.org
Cc:     =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Voegtle <tv@lio96.de>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.19.y] drbd: correctly submit flush bio on barrier
Date:   Mon,  8 May 2023 12:38:12 +0200
Message-Id: <20230508103812.4037417-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <2023050712-gloomy-frenzy-c809@gregkh>
References: <2023050712-gloomy-frenzy-c809@gregkh>
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
index cbb6ef719978..d1d6a7af7e78 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1310,7 +1310,7 @@ static void submit_one_flush(struct drbd_device *device, struct issue_flush_cont
 	bio_set_dev(bio, device->ldev->backing_bdev);
 	bio->bi_private = octx;
 	bio->bi_end_io = one_flush_endio;
-	bio->bi_opf = REQ_OP_FLUSH | REQ_PREFLUSH;
+	bio->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
 
 	device->flush_jif = jiffies;
 	set_bit(FLUSH_PENDING, &device->flags);
-- 
2.39.2


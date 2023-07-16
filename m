Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2055775568D
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbjGPUvn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbjGPUvm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:51:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EE2E9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:51:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9B5A60E9E
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:51:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA65DC433C7;
        Sun, 16 Jul 2023 20:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540700;
        bh=RMp4xByG4ffeO0OOKmDWbpxiTLqmBseqZwL54lV+3dg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZnGvThgVifB98X5MJKn2d1O7l2l/rsaCjjWTiBz+I3YS4Nyh/lrP3HPbYyTl6nIeZ
         IHIUAKBknKxaX8vwi2j6tu6hXOVSSZO+8ZqcRwXEay07FZ7r6QchV335bmhvGnlzdT
         PW51m9iU1UAXKi3OFJQo5ewz28xSFCTyGmqzqNTw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Guenter Roeck <linux@roeck-us.net>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 456/591] lib/bitmap: drop optimization of bitmap_{from,to}_arr64
Date:   Sun, 16 Jul 2023 21:49:55 +0200
Message-ID: <20230716194935.703759168@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yury Norov <yury.norov@gmail.com>

[ Upstream commit c1d2ba10f594046831d14b03f194e8d05e78abad ]

bitmap_{from,to}_arr64() optimization is overly optimistic on 32-bit LE
architectures when it's wired to bitmap_copy_clear_tail().

bitmap_copy_clear_tail() takes care of unused bits in the bitmap up to
the next word boundary. But on 32-bit machines when copying bits from
bitmap to array of 64-bit words, it's expected that the unused part of
a recipient array must be cleared up to 64-bit boundary, so the last 4
bytes may stay untouched when nbits % 64 <= 32.

While the copying part of the optimization works correct, that clear-tail
trick makes corresponding tests reasonably fail:

test_bitmap: bitmap_to_arr64(nbits == 1): tail is not safely cleared: 0xa5a5a5a500000001 (must be 0x0000000000000001)

Fix it by removing bitmap_{from,to}_arr64() optimization for 32-bit LE
arches.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/lkml/20230225184702.GA3587246@roeck-us.net/
Fixes: 0a97953fd221 ("lib: add bitmap_{from,to}_arr64")
Signed-off-by: Yury Norov <yury.norov@gmail.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bitmap.h | 8 +++-----
 lib/bitmap.c           | 2 +-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 7d6d73b781472..03644237e1efb 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -302,12 +302,10 @@ void bitmap_to_arr32(u32 *buf, const unsigned long *bitmap,
 #endif
 
 /*
- * On 64-bit systems bitmaps are represented as u64 arrays internally. On LE32
- * machines the order of hi and lo parts of numbers match the bitmap structure.
- * In both cases conversion is not needed when copying data from/to arrays of
- * u64.
+ * On 64-bit systems bitmaps are represented as u64 arrays internally. So,
+ * the conversion is not needed when copying data from/to arrays of u64.
  */
-#if (BITS_PER_LONG == 32) && defined(__BIG_ENDIAN)
+#if BITS_PER_LONG == 32
 void bitmap_from_arr64(unsigned long *bitmap, const u64 *buf, unsigned int nbits);
 void bitmap_to_arr64(u64 *buf, const unsigned long *bitmap, unsigned int nbits);
 #else
diff --git a/lib/bitmap.c b/lib/bitmap.c
index 1c81413c51f86..ddb31015e38ae 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1495,7 +1495,7 @@ void bitmap_to_arr32(u32 *buf, const unsigned long *bitmap, unsigned int nbits)
 EXPORT_SYMBOL(bitmap_to_arr32);
 #endif
 
-#if (BITS_PER_LONG == 32) && defined(__BIG_ENDIAN)
+#if BITS_PER_LONG == 32
 /**
  * bitmap_from_arr64 - copy the contents of u64 array of bits to bitmap
  *	@bitmap: array of unsigned longs, the destination bitmap
-- 
2.39.2




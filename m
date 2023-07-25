Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DD27615F6
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbjGYLfC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234718AbjGYLfB (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:35:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7A118F
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:35:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 108816166E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:35:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BAAC433C8;
        Tue, 25 Jul 2023 11:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284899;
        bh=IcHyIVsIG9SnJRp4MalCtaRPuWE9SJi2yK0TKu0hAVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mro7CHSbWceFAZ+xWAYLJNtrIgAJ5NLvH7wur1qlpvCmJPzPSQ5/F8ZXVK0U7KT4A
         hq8I2GYE8HOn910lPkS2Np43jqDUUJdRdjyHO3cVW77H0LwURbphuLlbYEu45JTetr
         /e+oBJE+lN9UYPJPK0qmpnmEaqVEe9TV15RsCRN8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Li Nan <linan122@huawei.com>,
        Yu Kuai <yukuai3@huawei.com>, Song Liu <song@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 012/313] md/raid10: check slab-out-of-bounds in md_bitmap_get_counter
Date:   Tue, 25 Jul 2023 12:42:45 +0200
Message-ID: <20230725104521.700725001@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Li Nan <linan122@huawei.com>

[ Upstream commit 301867b1c16805aebbc306aafa6ecdc68b73c7e5 ]

If we write a large number to md/bitmap_set_bits, md_bitmap_checkpage()
will return -EINVAL because 'page >= bitmap->pages', but the return value
was not checked immediately in md_bitmap_get_counter() in order to set
*blocks value and slab-out-of-bounds occurs.

Move check of 'page >= bitmap->pages' to md_bitmap_get_counter() and
return directly if true.

Fixes: ef4256733506 ("md/bitmap: optimise scanning of empty bitmaps.")
Signed-off-by: Li Nan <linan122@huawei.com>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20230515134808.3936750-2-linan666@huaweicloud.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md-bitmap.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 0545cdccf6369..bea8265ce9b8e 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -54,14 +54,7 @@ __acquires(bitmap->lock)
 {
 	unsigned char *mappage;
 
-	if (page >= bitmap->pages) {
-		/* This can happen if bitmap_start_sync goes beyond
-		 * End-of-device while looking for a whole page.
-		 * It is harmless.
-		 */
-		return -EINVAL;
-	}
-
+	WARN_ON_ONCE(page >= bitmap->pages);
 	if (bitmap->bp[page].hijacked) /* it's hijacked, don't try to alloc */
 		return 0;
 
@@ -1369,6 +1362,14 @@ __acquires(bitmap->lock)
 	sector_t csize;
 	int err;
 
+	if (page >= bitmap->pages) {
+		/*
+		 * This can happen if bitmap_start_sync goes beyond
+		 * End-of-device while looking for a whole page or
+		 * user set a huge number to sysfs bitmap_set_bits.
+		 */
+		return NULL;
+	}
 	err = md_bitmap_checkpage(bitmap, page, create, 0);
 
 	if (bitmap->bp[page].hijacked ||
-- 
2.39.2




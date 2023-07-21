Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547F075D468
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjGUTU5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjGUTUv (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:20:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA5030E7
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:20:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FF3161D54
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:20:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F331C433C7;
        Fri, 21 Jul 2023 19:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967249;
        bh=ul0L52/6cMEK2ZNMovbjDrUno3yOLwL7iucOlLhtfE8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sa7r3nj8PtYQYTxdgeYCDGeKoUnYShffvKl7xyMEg1agYggdsSUlYZlX6aw/9/8nM
         Z1i60VrTivRLlmTb9Vd2D2lSPA36ts3GpRyGButzA5x5UVr6SEOd2Ksl0UoxVM6moQ
         9bOuUKr2lm/Hodz9CRG7ds1YG5QZuia1TrutcTL0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1 096/223] kasan: add kasan_tag_mismatch prototype
Date:   Fri, 21 Jul 2023 18:05:49 +0200
Message-ID: <20230721160524.954695577@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

commit fb646a4cd3f0ff27d19911bef7b6622263723df6 upstream.

The kasan sw-tags implementation contains one function that is only called
from assembler and has no prototype in a header.  This causes a W=1
warning:

mm/kasan/sw_tags.c:171:6: warning: no previous prototype for 'kasan_tag_mismatch' [-Wmissing-prototypes]
  171 | void kasan_tag_mismatch(unsigned long addr, unsigned long access_info,

Add a prototype in the local header to get a clean build.

Link: https://lkml.kernel.org/r/20230509145735.9263-1-arnd@kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Marco Elver <elver@google.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/kasan/kasan.h |    3 +++
 1 file changed, 3 insertions(+)

--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -629,4 +629,7 @@ void __hwasan_storeN_noabort(unsigned lo
 
 void __hwasan_tag_memory(unsigned long addr, u8 tag, unsigned long size);
 
+void kasan_tag_mismatch(unsigned long addr, unsigned long access_info,
+			unsigned long ret_ip);
+
 #endif /* __MM_KASAN_KASAN_H */



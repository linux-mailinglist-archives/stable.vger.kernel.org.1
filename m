Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3BC76AFCE
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbjHAJuQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbjHAJuA (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:50:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F172114
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:49:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA63161502
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:49:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA56C433C7;
        Tue,  1 Aug 2023 09:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883372;
        bh=TVORKfXwLGfddHDv9j3C7863sVnGBVkq2BWq3blA7e8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P7h2HsvMSYAK3CtyjIMMhiL73sbmgAu7W/AaqB+mg7z4nWp0BPIcJussYI0PHoFWi
         srK+iAN46QvNxXBrMDHFGkkA6fyopZlRc5szCu/XDOZQbBN37jZ8QsBVk0JvWjpIcV
         OE8m+eS52nv/sRa6Bo2HuwGdJJHqYTJFT70mNZ80=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kernel test robot <lkp@intel.com>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Herve Codina <herve.codina@bootlin.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Richard Weinberger <richard@nod.at>,
        Yang Guang <yang.guang5@zte.com.cn>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.4 212/239] Revert "um: Use swap() to make code cleaner"
Date:   Tue,  1 Aug 2023 11:21:16 +0200
Message-ID: <20230801091933.498698209@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

commit dddfa05eb58076ad60f9a66e7155a5b3502b2dd5 upstream.

This reverts commit 9b0da3f22307af693be80f5d3a89dc4c7f360a85.

The sigio.c is clearly user space code which is handled by
arch/um/scripts/Makefile.rules (see USER_OBJS rule).

The above mentioned commit simply broke this agreement,
we may not use Linux kernel internal headers in them without
thorough thinking.

Hence, revert the wrong commit.

Link: https://lkml.kernel.org/r/20230724143131.30090-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202307212304.cH79zJp1-lkp@intel.com/
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Herve Codina <herve.codina@bootlin.com>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Richard Weinberger <richard@nod.at>
Cc: Yang Guang <yang.guang5@zte.com.cn>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/um/os-Linux/sigio.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/arch/um/os-Linux/sigio.c
+++ b/arch/um/os-Linux/sigio.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2002 - 2008 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  */
 
-#include <linux/minmax.h>
 #include <unistd.h>
 #include <errno.h>
 #include <fcntl.h>
@@ -51,7 +50,7 @@ static struct pollfds all_sigio_fds;
 
 static int write_sigio_thread(void *unused)
 {
-	struct pollfds *fds;
+	struct pollfds *fds, tmp;
 	struct pollfd *p;
 	int i, n, respond_fd;
 	char c;
@@ -78,7 +77,9 @@ static int write_sigio_thread(void *unus
 					       "write_sigio_thread : "
 					       "read on socket failed, "
 					       "err = %d\n", errno);
-				swap(current_poll, next_poll);
+				tmp = current_poll;
+				current_poll = next_poll;
+				next_poll = tmp;
 				respond_fd = sigio_private[1];
 			}
 			else {



Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9403F7039C2
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244662AbjEORpq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244593AbjEORp1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:45:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8538B147DA;
        Mon, 15 May 2023 10:43:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1ACE462303;
        Mon, 15 May 2023 17:43:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BCBC433D2;
        Mon, 15 May 2023 17:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172592;
        bh=GnuTKGySGlfr07daI7HAiFk0boCdBF/4zjHSMFSEV+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W+QMW/86tEhreD3z8mJj0IfD7UAJHyEc6T3wz1J7ZoVVuvuSI/IYvdRI2xiS2onM+
         4rySRdDJuuwJozJT/2FQHlocMgXja1wlivSLWh6cYZ7fsWFCpckKZZw1cwnzx5N9jh
         +c3bAEgXQV/VgPm3Vb9QyjI8wjW3ZRN1gXj6hk50=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 204/381] linux/vt_buffer.h: allow either builtin or modular for macros
Date:   Mon, 15 May 2023 18:27:35 +0200
Message-Id: <20230515161746.023536518@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 2b76ffe81e32afd6d318dc4547e2ba8c46207b77 ]

Fix build errors on ARCH=alpha when CONFIG_MDA_CONSOLE=m.
This allows the ARCH macros to be the only ones defined.

In file included from ../drivers/video/console/mdacon.c:37:
../arch/alpha/include/asm/vga.h:17:40: error: expected identifier or '(' before 'volatile'
   17 | static inline void scr_writew(u16 val, volatile u16 *addr)
      |                                        ^~~~~~~~
../include/linux/vt_buffer.h:24:34: note: in definition of macro 'scr_writew'
   24 | #define scr_writew(val, addr) (*(addr) = (val))
      |                                  ^~~~
../include/linux/vt_buffer.h:24:40: error: expected ')' before '=' token
   24 | #define scr_writew(val, addr) (*(addr) = (val))
      |                                        ^
../arch/alpha/include/asm/vga.h:17:20: note: in expansion of macro 'scr_writew'
   17 | static inline void scr_writew(u16 val, volatile u16 *addr)
      |                    ^~~~~~~~~~
../arch/alpha/include/asm/vga.h:25:29: error: expected identifier or '(' before 'volatile'
   25 | static inline u16 scr_readw(volatile const u16 *addr)
      |                             ^~~~~~~~

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Link: https://lore.kernel.org/r/20230329021529.16188-1-rdunlap@infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/vt_buffer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/vt_buffer.h b/include/linux/vt_buffer.h
index 848db1b1569ff..919d999a8c1db 100644
--- a/include/linux/vt_buffer.h
+++ b/include/linux/vt_buffer.h
@@ -16,7 +16,7 @@
 
 #include <linux/string.h>
 
-#if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_MDA_CONSOLE)
+#if IS_ENABLED(CONFIG_VGA_CONSOLE) || IS_ENABLED(CONFIG_MDA_CONSOLE)
 #include <asm/vga.h>
 #endif
 
-- 
2.39.2




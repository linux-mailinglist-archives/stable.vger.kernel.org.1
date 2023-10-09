Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13FA7BE11C
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377342AbjJINrL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377441AbjJINrH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:47:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A90AC5
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:47:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67CF4C433C7;
        Mon,  9 Oct 2023 13:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696859222;
        bh=l43bXtebmDb0hFgiAPv0N8yRYgZJb3wEZxmL6pL531M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1WofG+CvKMgkHadoW6VR8GfTL/DZUOr5yhLzvTNLJRYZNbTljDKd/F5B5WntXbV/u
         0dRmO9A87cVYL0GPxnm60QQqTKAoqWh9R3v1Y6Z33iUSzM2078LxO3X8m0+acn1XFL
         DXDj8gIh6aFWJvj2JnsWEKO49yOqDxZj8bDlGaxA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 10/55] xtensa: boot/lib: fix function prototypes
Date:   Mon,  9 Oct 2023 15:06:09 +0200
Message-ID: <20231009130108.102818529@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130107.717692466@linuxfoundation.org>
References: <20231009130107.717692466@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Max Filippov <jcmvbkbc@gmail.com>

[ Upstream commit f54d02c8f2cc4b46ba2a3bd8252a6750453b6f2b ]

Add function prototype for gunzip() to the boot library code and make
exit() and zalloc() static.

arch/xtensa/boot/lib/zmem.c:8:6: warning: no previous prototype for 'exit' [-Wmissing-prototypes]
    8 | void exit (void)
arch/xtensa/boot/lib/zmem.c:13:7: warning: no previous prototype for 'zalloc' [-Wmissing-prototypes]
   13 | void *zalloc(unsigned size)
arch/xtensa/boot/lib/zmem.c:35:6: warning: no previous prototype for 'gunzip' [-Wmissing-prototypes]
   35 | void gunzip (void *dst, int dstlen, unsigned char *src, int *lenp)

Fixes: 4bedea945451 ("xtensa: Architecture support for Tensilica Xtensa Part 2")
Fixes: e7d163f76665 ("xtensa: Removed local copy of zlib and fixed O= support")
Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/xtensa/boot/lib/zmem.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/xtensa/boot/lib/zmem.c b/arch/xtensa/boot/lib/zmem.c
index e3ecd743c5153..b89189355122a 100644
--- a/arch/xtensa/boot/lib/zmem.c
+++ b/arch/xtensa/boot/lib/zmem.c
@@ -4,13 +4,14 @@
 /* bits taken from ppc */
 
 extern void *avail_ram, *end_avail;
+void gunzip(void *dst, int dstlen, unsigned char *src, int *lenp);
 
-void exit (void)
+static void exit(void)
 {
   for (;;);
 }
 
-void *zalloc(unsigned size)
+static void *zalloc(unsigned int size)
 {
         void *p = avail_ram;
 
-- 
2.40.1




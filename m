Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F5B7BDF96
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377082AbjJINbj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377077AbjJINbi (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:31:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D513999
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:31:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2201FC433C8;
        Mon,  9 Oct 2023 13:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858296;
        bh=ASYy5/Afb3lGEr/wW856HTVH4Snfr4UxTLS2ImTi1Cw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rE3OOzqye9rfsJ7pBX1vnGyJNsSS0/ktxKjV+TND1ZPp2zLTB39dbXAkxoXozT1De
         700AbFnVl1d4Q/fi4vNdWXND4m14CiB1a1Qza0E4x3QoQdIhaUXxpgIUYWWJ3Zkf3y
         1ofm9SphH8oBtKrkLek6fzH+0XIt2Y3gKj3fWBuQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 050/131] xtensa: boot/lib: fix function prototypes
Date:   Mon,  9 Oct 2023 15:01:30 +0200
Message-ID: <20231009130117.835801488@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130116.329529591@linuxfoundation.org>
References: <20231009130116.329529591@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

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




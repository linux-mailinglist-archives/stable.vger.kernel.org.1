Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC847B8A55
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244398AbjJDSeZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244391AbjJDSeZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:34:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350D498
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:34:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76093C433C8;
        Wed,  4 Oct 2023 18:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444461;
        bh=YVmJfIgdq84eZHefxVy0TLvGxPdjIDGk0XMdWUpcZhg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1nZilS/xKbVVJ9Y7DzRivk+SQdpUbFXZEGa7X9AAC25GV3lnbEnXeLOygxC/tX/fD
         6q5PehaZLvL/xXxWRe9YT3wIKuNq1lGGNb/yNPenm/RXNgH4fG5YMK8d1gYp2t4RGc
         Cacbh64zsZbn7QC4NyQfo+BfqBS1e3hAuCeNS33o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Guenter Roeck <linux@roeck-us.net>,
        Helge Deller <deller@gmx.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        stable <stable@kernel.org>
Subject: [PATCH 6.5 259/321] LoongArch: Fix lockdep static memory detection
Date:   Wed,  4 Oct 2023 19:56:44 +0200
Message-ID: <20231004175241.256973790@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Helge Deller <deller@gmx.de>

commit 68ffa230daa0d35b7cce476098433d763d5fd42f upstream.

Since commit 0a6b58c5cd0d ("lockdep: fix static memory detection even
more") the lockdep code uses is_kernel_core_data(), is_kernel_rodata()
and init_section_contains() to verify if a lock is located inside a
kernel static data section.

This change triggers a failure on LoongArch, for which the vmlinux.lds.S
script misses to put the locks (as part of in the .data.rel symbols)
into the Linux data section.

This patch fixes the lockdep problem by moving *(.data.rel*) symbols
into the kernel data section (from _sdata to _edata).

Additionally, move other wrongly assigned symbols too:
- altinstructions into the _initdata section,
- PLT symbols behind the read-only section, and
- *(.la_abs) into the data section.

Cc: stable <stable@kernel.org> # v6.4+
Fixes: 0a6b58c5cd0d ("lockdep: fix static memory detection even more")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/kernel/vmlinux.lds.S |   55 ++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 27 deletions(-)

--- a/arch/loongarch/kernel/vmlinux.lds.S
+++ b/arch/loongarch/kernel/vmlinux.lds.S
@@ -53,33 +53,6 @@ SECTIONS
 	. = ALIGN(PECOFF_SEGMENT_ALIGN);
 	_etext = .;
 
-	/*
-	 * struct alt_inst entries. From the header (alternative.h):
-	 * "Alternative instructions for different CPU types or capabilities"
-	 * Think locking instructions on spinlocks.
-	 */
-	. = ALIGN(4);
-	.altinstructions : AT(ADDR(.altinstructions) - LOAD_OFFSET) {
-		__alt_instructions = .;
-		*(.altinstructions)
-		__alt_instructions_end = .;
-	}
-
-#ifdef CONFIG_RELOCATABLE
-	. = ALIGN(8);
-	.la_abs : AT(ADDR(.la_abs) - LOAD_OFFSET) {
-		__la_abs_begin = .;
-		*(.la_abs)
-		__la_abs_end = .;
-	}
-#endif
-
-	.got : ALIGN(16) { *(.got) }
-	.plt : ALIGN(16) { *(.plt) }
-	.got.plt : ALIGN(16) { *(.got.plt) }
-
-	.data.rel : { *(.data.rel*) }
-
 	. = ALIGN(PECOFF_SEGMENT_ALIGN);
 	__init_begin = .;
 	__inittext_begin = .;
@@ -94,6 +67,18 @@ SECTIONS
 
 	__initdata_begin = .;
 
+	/*
+	 * struct alt_inst entries. From the header (alternative.h):
+	 * "Alternative instructions for different CPU types or capabilities"
+	 * Think locking instructions on spinlocks.
+	 */
+	. = ALIGN(4);
+	.altinstructions : AT(ADDR(.altinstructions) - LOAD_OFFSET) {
+		__alt_instructions = .;
+		*(.altinstructions)
+		__alt_instructions_end = .;
+	}
+
 	INIT_DATA_SECTION(16)
 	.exit.data : {
 		EXIT_DATA
@@ -113,6 +98,11 @@ SECTIONS
 
 	_sdata = .;
 	RO_DATA(4096)
+
+	.got : ALIGN(16) { *(.got) }
+	.plt : ALIGN(16) { *(.plt) }
+	.got.plt : ALIGN(16) { *(.got.plt) }
+
 	RW_DATA(1 << CONFIG_L1_CACHE_SHIFT, PAGE_SIZE, THREAD_SIZE)
 
 	.rela.dyn : ALIGN(8) {
@@ -121,6 +111,17 @@ SECTIONS
 		__rela_dyn_end = .;
 	}
 
+	.data.rel : { *(.data.rel*) }
+
+#ifdef CONFIG_RELOCATABLE
+	. = ALIGN(8);
+	.la_abs : AT(ADDR(.la_abs) - LOAD_OFFSET) {
+		__la_abs_begin = .;
+		*(.la_abs)
+		__la_abs_end = .;
+	}
+#endif
+
 	.sdata : {
 		*(.sdata)
 	}



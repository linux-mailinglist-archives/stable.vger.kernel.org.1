Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D646B7E250C
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbjKFN1m (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbjKFN1l (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:27:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185F2D8
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:27:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E59EC433C7;
        Mon,  6 Nov 2023 13:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277257;
        bh=B6RNpjn+ZcRoGZac+NJpOV5yyh2KXsIeRuVVKKJ4AuI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=udW9p9ouXATKsMiO6A4Ihj3+QtGnntpAz5HaZHAC/lhENIa4CkTMAVt9QUUUVQwDm
         BKyyMjl/q93p3yOF4RDhLhALfVViELSsTCPYnxkFHY1LVkM/PdmHHoLGEe/yT+9Aby
         fI8b8PIxTvFH0dsHc5osW7Ur4RmiovBAwOzCVeic=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 5.15 062/128] x86/mm: Simplify RESERVE_BRK()
Date:   Mon,  6 Nov 2023 14:03:42 +0100
Message-ID: <20231106130311.913359427@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130309.112650042@linuxfoundation.org>
References: <20231106130309.112650042@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf <jpoimboe@redhat.com>

commit a1e2c031ec3949b8c039b739c0b5bf9c30007b00 upstream.

RESERVE_BRK() reserves data in the .brk_reservation section.  The data
is initialized to zero, like BSS, so the macro specifies 'nobits' to
prevent the data from taking up space in the vmlinux binary.  The only
way to get the compiler to do that (without putting the variable in .bss
proper) is to use inline asm.

The macro also has a hack which encloses the inline asm in a discarded
function, which allows the size to be passed (global inline asm doesn't
allow inputs).

Remove the need for the discarded function hack by just stringifying the
size rather than supplying it as an input to the inline asm.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220506121631.133110232@infradead.org
[nathan: Resolve conflict due to lack of 2b6ff7dea670]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/setup.h |   30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -108,27 +108,19 @@ extern unsigned long _brk_end;
 void *extend_brk(size_t size, size_t align);
 
 /*
- * Reserve space in the brk section.  The name must be unique within
- * the file, and somewhat descriptive.  The size is in bytes.  Must be
- * used at file scope.
+ * Reserve space in the brk section.  The name must be unique within the file,
+ * and somewhat descriptive.  The size is in bytes.
  *
- * (This uses a temp function to wrap the asm so we can pass it the
- * size parameter; otherwise we wouldn't be able to.  We can't use a
- * "section" attribute on a normal variable because it always ends up
- * being @progbits, which ends up allocating space in the vmlinux
- * executable.)
+ * The allocation is done using inline asm (rather than using a section
+ * attribute on a normal variable) in order to allow the use of @nobits, so
+ * that it doesn't take up any space in the vmlinux file.
  */
-#define RESERVE_BRK(name,sz)						\
-	static void __section(".discard.text") __used notrace		\
-	__brk_reservation_fn_##name##__(void) {				\
-		asm volatile (						\
-			".pushsection .brk_reservation,\"aw\",@nobits;" \
-			".brk." #name ":"				\
-			" 1:.skip %c0;"					\
-			" .size .brk." #name ", . - 1b;"		\
-			" .popsection"					\
-			: : "i" (sz));					\
-	}
+#define RESERVE_BRK(name, size)						\
+	asm(".pushsection .brk_reservation,\"aw\",@nobits\n\t"		\
+	    ".brk." #name ":\n\t"					\
+	    ".skip " __stringify(size) "\n\t"				\
+	    ".size .brk." #name ", " __stringify(size) "\n\t"		\
+	    ".popsection\n\t")
 
 extern void probe_roms(void);
 #ifdef __i386__



Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B637E2479
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjKFNWV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbjKFNWU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:22:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95F1D8
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:22:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6BCC433C9;
        Mon,  6 Nov 2023 13:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276937;
        bh=XFnisP0Ql7efzYs/d9bZ2fOeVwEa19SD8dCzdFy03g8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w1bP2x9x9vQO4jn8VUpZSi5wRYFUl2ywApr3thbWDHx7g3t5HhtfBzZDk0wz/NK+0
         pWDpAXhKuulpJmdCKAa0BItzswYEvSnWsBpC6fRGIYwTMiBeu6xMzRROtm5pSPuCIh
         wKT1SRilJk+SVqI93RjEHrysgXFWmtT2TTyIUxlc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Juergen Gross <jgross@suse.com>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH 5.4 50/74] x86: Fix .brk attribute in linker script
Date:   Mon,  6 Nov 2023 14:04:10 +0100
Message-ID: <20231106130303.455188790@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130301.687882731@linuxfoundation.org>
References: <20231106130301.687882731@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Juergen Gross <jgross@suse.com>

commit 7e09ac27f43b382f5fe9bb7c7f4c465ece1f8a23 upstream.

Commit in Fixes added the "NOLOAD" attribute to the .brk section as a
"failsafe" measure.

Unfortunately, this leads to the linker no longer covering the .brk
section in a program header, resulting in the kernel loader not knowing
that the memory for the .brk section must be reserved.

This has led to crashes when loading the kernel as PV dom0 under Xen,
but other scenarios could be hit by the same problem (e.g. in case an
uncompressed kernel is used and the initrd is placed directly behind
it).

So drop the "NOLOAD" attribute. This has been verified to correctly
cover the .brk section by a program header of the resulting ELF file.

Fixes: e32683c6f7d2 ("x86/mm: Fix RESERVE_BRK() for older binutils")
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20220630071441.28576-4-jgross@suse.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/vmlinux.lds.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -380,7 +380,7 @@ SECTIONS
 	__end_of_kernel_reserve = .;
 
 	. = ALIGN(PAGE_SIZE);
-	.brk (NOLOAD) : AT(ADDR(.brk) - LOAD_OFFSET) {
+	.brk : AT(ADDR(.brk) - LOAD_OFFSET) {
 		__brk_base = .;
 		. += 64 * 1024;		/* 64k alignment slop space */
 		*(.bss..brk)		/* areas brk users have reserved */



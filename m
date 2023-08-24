Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83117787151
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 16:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241546AbjHXOQV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 10:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjHXOQF (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 10:16:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9F91989
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 07:16:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A11C960B92
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 14:16:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CEEC433C8;
        Thu, 24 Aug 2023 14:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692886563;
        bh=HQ8bPOu5wruvzUErKDn/m+eSOSUgyJex25sIu/IVKak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XAQ+a8nZ2OZT9Xi7DiiEid9cKLxl+SKm1mcTeWg76IkewpPSScXklnz317nMbTG4g
         ZhuCu1bHWIDSTvvHOfedoTe5TSdU+6C0XgoUIoeuBh/dp+8QbQmKfg4g2x2TcdUW3I
         bnOYnPr35jreEboHhhwWzEhgs/KslqWyPLPnSP8w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christian Bricart <christian@bricart.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH 6.1 09/15] x86/static_call: Fix __static_call_fixup()
Date:   Thu, 24 Aug 2023 16:15:05 +0200
Message-ID: <20230824141447.611980994@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824141447.155846739@linuxfoundation.org>
References: <20230824141447.155846739@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

commit 54097309620ef0dc2d7083783dc521c6a5fef957 upstream.

Christian reported spurious module load crashes after some of Song's
module memory layout patches.

Turns out that if the very last instruction on the very last page of the
module is a 'JMP __x86_return_thunk' then __static_call_fixup() will
trip a fault and die.

And while the module rework made this slightly more likely to happen,
it's always been possible.

Fixes: ee88d363d156 ("x86,static_call: Use alternative RET encoding")
Reported-by: Christian Bricart <christian@bricart.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lkml.kernel.org/r/20230816104419.GA982867@hirez.programming.kicks-ass.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/static_call.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -184,6 +184,19 @@ EXPORT_SYMBOL_GPL(arch_static_call_trans
  */
 bool __static_call_fixup(void *tramp, u8 op, void *dest)
 {
+	unsigned long addr = (unsigned long)tramp;
+	/*
+	 * Not all .return_sites are a static_call trampoline (most are not).
+	 * Check if the 3 bytes after the return are still kernel text, if not,
+	 * then this definitely is not a trampoline and we need not worry
+	 * further.
+	 *
+	 * This avoids the memcmp() below tripping over pagefaults etc..
+	 */
+	if (((addr >> PAGE_SHIFT) != ((addr + 7) >> PAGE_SHIFT)) &&
+	    !kernel_text_address(addr + 7))
+		return false;
+
 	if (memcmp(tramp+5, tramp_ud, 3)) {
 		/* Not a trampoline site, not our problem. */
 		return false;



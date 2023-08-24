Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09DC7872DE
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 16:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241881AbjHXO5u (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 10:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241935AbjHXO51 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 10:57:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62551BC6
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 07:57:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C7EF61642
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 14:57:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C616C433C8;
        Thu, 24 Aug 2023 14:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692889042;
        bh=sEXvklbKhUaVLdgjS/vsW7lE2RKOzFBo4YlkxtGg+20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=taV8u/h0/0MTqKkyBfkmWNR9qvdK900vPorbSL80ZW/+REBPf1LTd+hqm9cAK7Vdq
         jfOBIQdtQ3ADUHakiNuIb94Mk3j5oRa24gGG7sEo16bqCKKZlCx3wec6ogtoFFFyM3
         hj4WgCtjifNFX6OVHQ9H+kmrMFmgvfiZZOb1IzUM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christian Bricart <christian@bricart.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 133/139] x86/static_call: Fix __static_call_fixup()
Date:   Thu, 24 Aug 2023 16:50:56 +0200
Message-ID: <20230824145029.201657914@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145023.559380953@linuxfoundation.org>
References: <20230824145023.559380953@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/static_call.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -135,6 +135,19 @@ EXPORT_SYMBOL_GPL(arch_static_call_trans
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



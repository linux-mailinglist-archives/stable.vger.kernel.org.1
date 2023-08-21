Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA1978324F
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjHUT6H (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjHUT6G (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:58:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA8912F
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:58:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C88F64681
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:58:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C161C433C7;
        Mon, 21 Aug 2023 19:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647883;
        bh=o0EE7y63G0ZO/5dLZPpbvVdAQEgCUAkSDwslwWdrZs0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VXgu5B9GsxFRscxJmY3P/ga6eGTmr+hN0Hp6Xq5L7LnRyQHHmt4t6W9lGyv3617lG
         hJy/ElvdQIz85Hih01XApmjHAg2DyKfWHXskbw6wxhEvkO08cQtvuFQ7BibYq0gaZG
         Q9inzt2sy+TW5WpZNNJddbmUpH6jMbzt7dwwTML0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 6.1 173/194] x86/cpu: Fix __x86_return_thunk symbol type
Date:   Mon, 21 Aug 2023 21:42:32 +0200
Message-ID: <20230821194130.305278841@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
References: <20230821194122.695845670@linuxfoundation.org>
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

commit 77f67119004296a9b2503b377d610e08b08afc2a upstream.

Commit

  fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")

reimplemented __x86_return_thunk with a mix of SYM_FUNC_START and
SYM_CODE_END, this is not a sane combination.

Since nothing should ever actually 'CALL' this, make it consistently
CODE.

Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230814121148.571027074@infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/lib/retpoline.S |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -207,7 +207,9 @@ SYM_CODE_END(srso_safe_ret)
 SYM_FUNC_END(srso_untrain_ret)
 __EXPORT_THUNK(srso_untrain_ret)
 
-SYM_FUNC_START(__x86_return_thunk)
+SYM_CODE_START(__x86_return_thunk)
+	UNWIND_HINT_FUNC
+	ANNOTATE_NOENDBR
 	ALTERNATIVE_2 "jmp __ret", "call srso_safe_ret", X86_FEATURE_SRSO, \
 			"call srso_safe_ret_alias", X86_FEATURE_SRSO_ALIAS
 	int3



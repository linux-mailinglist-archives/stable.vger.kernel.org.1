Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF1D787140
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 16:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241449AbjHXOPn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 10:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241420AbjHXOPT (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 10:15:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEFB11F
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 07:15:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0E0F66D91
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 14:15:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF42C433CA;
        Thu, 24 Aug 2023 14:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692886517;
        bh=o0EE7y63G0ZO/5dLZPpbvVdAQEgCUAkSDwslwWdrZs0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AFtxnKBlCswLp9c3DeqHeOoeQmfNOot3Kc1Jm1xF9jkmJMBvn54qW7tFQbqrnoy2y
         ky2NOBcY4L9lZpM+i8Lw9F8IB8/Fzrbv3HnfDaVbguT1VopS0IwIrqXegfc7F7G5gx
         9pOLSO8BP3EXE7Uo34hNsY5dD2NzW0bJ1O9CxuPc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 6.1 01/15] x86/cpu: Fix __x86_return_thunk symbol type
Date:   Thu, 24 Aug 2023 16:14:57 +0200
Message-ID: <20230824141447.245338999@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824141447.155846739@linuxfoundation.org>
References: <20230824141447.155846739@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
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



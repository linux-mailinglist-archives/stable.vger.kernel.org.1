Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86F07876F4
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 19:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242687AbjHXRVn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 13:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242823AbjHXRVP (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 13:21:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C56219B5
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 10:21:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 025CA67100
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 17:21:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C9EC433C8;
        Thu, 24 Aug 2023 17:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692897672;
        bh=0k43O3RQooUb3RGKiZKllc8RU5F+rBjMQ1G6kOAnL1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ij0RvTpfkkDt1fYgJEuZhoGhs32IynSouUuB4YdjAjrv6XR3n6xv/MWj9B6eR4IGr
         vT7G/WHrHWlXuoZ54Syt/xjMKmjq34ddv11/cmy9SI9X2L7aWtsTvQ6tJim6BW2+9R
         rP7HdlgLsvu2MR36/hTGVtyNrxVoH0e9UrTPiqfg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 120/135] x86/cpu: Fix up srso_safe_ret() and __x86_return_thunk()
Date:   Thu, 24 Aug 2023 19:09:52 +0200
Message-ID: <20230824170622.474621805@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824170617.074557800@linuxfoundation.org>
References: <20230824170617.074557800@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit af023ef335f13c8b579298fc432daeef609a9e60 upstream.

  vmlinux.o: warning: objtool: srso_untrain_ret() falls through to next function __x86_return_skl()
  vmlinux.o: warning: objtool: __x86_return_thunk() falls through to next function __x86_return_skl()

This is because these functions (can) end with CALL, which objtool
does not consider a terminating instruction. Therefore, replace the
INT3 instruction (which is a non-fatal trap) with UD2 (which is a
fatal-trap).

This indicates execution will not continue past this point.

Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230814121148.637802730@infradead.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/lib/retpoline.S |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -199,7 +199,7 @@ SYM_INNER_LABEL(srso_safe_ret, SYM_L_GLO
 	int3
 	lfence
 	call srso_safe_ret
-	int3
+	ud2
 SYM_CODE_END(srso_safe_ret)
 SYM_FUNC_END(srso_untrain_ret)
 __EXPORT_THUNK(srso_untrain_ret)
@@ -209,7 +209,7 @@ SYM_CODE_START(__x86_return_thunk)
 	ANNOTATE_NOENDBR
 	ALTERNATIVE_2 "jmp __ret", "call srso_safe_ret", X86_FEATURE_SRSO, \
 			"call srso_safe_ret_alias", X86_FEATURE_SRSO_ALIAS
-	int3
+	ud2
 SYM_CODE_END(__x86_return_thunk)
 EXPORT_SYMBOL(__x86_return_thunk)
 



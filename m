Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA714726B07
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjFGUV4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbjFGUVr (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:21:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F3626BF
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:21:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A2C56130B
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:21:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25110C433D2;
        Wed,  7 Jun 2023 20:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169271;
        bh=r2vBJmuPSiqnGNFd/mh0t1cCksRZm4Mq4et+X2Sv048=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hhW3UAjEX4OPOioOjTZWSsoWZYsqrBpdnK/5S5YUoSHAsqGtfnLWdXHQyeYnMQuWs
         XlX9GsiSIQZA0J14HNUz+/SSxY1E1fFWog8Q/zmJRkFJFxOVcsQLqIH9AhDirkPqnW
         8/ocj1/mtsKhSIPzJURXXlYIQsAIShzohLMJJgVg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Taehee Yoo <ap420073@gmail.com>,
        syzbot+a6abcf08bad8b18fd198@syzkaller.appspotmail.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 018/286] crypto: x86/aria - Use 16 byte alignment for GFNI constant vectors
Date:   Wed,  7 Jun 2023 22:11:57 +0200
Message-ID: <20230607200923.600616276@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

[ Upstream commit 6ab39f99927eed605728b02d512438d828183c97 ]

The GFNI routines in the AVX version of the ARIA implementation now use
explicit VMOVDQA instructions to load the constant input vectors, which
means they must be 16 byte aligned. So ensure that this is the case, by
dropping the section split and the incorrect .align 8 directive, and
emitting the constants into the 16-byte aligned section instead.

Note that the AVX2 version of this code deviates from this pattern, and
does not require a similar fix, given that it loads these contants as
8-byte memory operands, for which AVX2 permits any alignment.

Cc: Taehee Yoo <ap420073@gmail.com>
Fixes: 8b84475318641c2b ("crypto: x86/aria-avx - Do not use avx2 instructions")
Reported-by: syzbot+a6abcf08bad8b18fd198@syzkaller.appspotmail.com
Tested-by: syzbot+a6abcf08bad8b18fd198@syzkaller.appspotmail.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/crypto/aria-aesni-avx-asm_64.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/crypto/aria-aesni-avx-asm_64.S b/arch/x86/crypto/aria-aesni-avx-asm_64.S
index 9243f6289d34b..ed6c22fb16720 100644
--- a/arch/x86/crypto/aria-aesni-avx-asm_64.S
+++ b/arch/x86/crypto/aria-aesni-avx-asm_64.S
@@ -773,8 +773,6 @@
 	.octa 0x3F893781E95FE1576CDA64D2BA0CB204
 
 #ifdef CONFIG_AS_GFNI
-.section	.rodata.cst8, "aM", @progbits, 8
-.align 8
 /* AES affine: */
 #define tf_aff_const BV8(1, 1, 0, 0, 0, 1, 1, 0)
 .Ltf_aff_bitmatrix:
-- 
2.39.2




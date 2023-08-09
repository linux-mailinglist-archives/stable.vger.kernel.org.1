Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8817A775A9D
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbjHILJ6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbjHILJ6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:09:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DA7172A
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:09:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC69863153
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:09:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC15C433C8;
        Wed,  9 Aug 2023 11:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579397;
        bh=C+1EicSQJNvZOGbCeipkQKbPcfoFEiSfRLYh9vWU/54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a0EiH/jtVmIFbVeGDMUkw4bGyHr4UvFlMiuztAz0/w2NMK4EaDDS728yd0FlH9IUg
         CygPIbj42Wk5uwWHaRKdGMWl7Qnyixvd67YW+aStzrMY9epVKr0cq0HrUqBTiCLEKa
         XdJCHvQQ/TR26UhhWo7eBeVf6/y/fZwlyqZOgCyw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 4.14 182/204] word-at-a-time: use the same return type for has_zero regardless of endianness
Date:   Wed,  9 Aug 2023 12:42:00 +0200
Message-ID: <20230809103648.590422238@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.552405807@linuxfoundation.org>
References: <20230809103642.552405807@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: ndesaulniers@google.com <ndesaulniers@google.com>

[ Upstream commit 79e8328e5acbe691bbde029a52c89d70dcbc22f3 ]

Compiling big-endian targets with Clang produces the diagnostic:

  fs/namei.c:2173:13: warning: use of bitwise '|' with boolean operands [-Wbitwise-instead-of-logical]
	} while (!(has_zero(a, &adata, &constants) | has_zero(b, &bdata, &constants)));
	          ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                               ||
  fs/namei.c:2173:13: note: cast one or both operands to int to silence this warning

It appears that when has_zero was introduced, two definitions were
produced with different signatures (in particular different return
types).

Looking at the usage in hash_name() in fs/namei.c, I suspect that
has_zero() is meant to be invoked twice per while loop iteration; using
logical-or would not update `bdata` when `a` did not have zeros.  So I
think it's preferred to always return an unsigned long rather than a
bool than update the while loop in hash_name() to use a logical-or
rather than bitwise-or.

[ Also changed powerpc version to do the same  - Linus ]

Link: https://github.com/ClangBuiltLinux/linux/issues/1832
Link: https://lore.kernel.org/lkml/20230801-bitwise-v1-1-799bec468dc4@google.com/
Fixes: 36126f8f2ed8 ("word-at-a-time: make the interfaces truly generic")
Debugged-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/word-at-a-time.h | 2 +-
 include/asm-generic/word-at-a-time.h      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/word-at-a-time.h b/arch/powerpc/include/asm/word-at-a-time.h
index f3f4710d4ff52..99129b0cd8b8a 100644
--- a/arch/powerpc/include/asm/word-at-a-time.h
+++ b/arch/powerpc/include/asm/word-at-a-time.h
@@ -34,7 +34,7 @@ static inline long find_zero(unsigned long mask)
 	return leading_zero_bits >> 3;
 }
 
-static inline bool has_zero(unsigned long val, unsigned long *data, const struct word_at_a_time *c)
+static inline unsigned long has_zero(unsigned long val, unsigned long *data, const struct word_at_a_time *c)
 {
 	unsigned long rhs = val | c->low_bits;
 	*data = rhs;
diff --git a/include/asm-generic/word-at-a-time.h b/include/asm-generic/word-at-a-time.h
index 20c93f08c9933..95a1d214108a5 100644
--- a/include/asm-generic/word-at-a-time.h
+++ b/include/asm-generic/word-at-a-time.h
@@ -38,7 +38,7 @@ static inline long find_zero(unsigned long mask)
 	return (mask >> 8) ? byte : byte + 1;
 }
 
-static inline bool has_zero(unsigned long val, unsigned long *data, const struct word_at_a_time *c)
+static inline unsigned long has_zero(unsigned long val, unsigned long *data, const struct word_at_a_time *c)
 {
 	unsigned long rhs = val | c->low_bits;
 	*data = rhs;
-- 
2.40.1




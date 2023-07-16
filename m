Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF877555CC
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjGPUom (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbjGPUol (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:44:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA437D9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:44:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DE2360EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:44:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F31C433C8;
        Sun, 16 Jul 2023 20:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540279;
        bh=U3nwGdPbT9I/ZVSItLdYNIIfVO3tJWnS+NU7PhdK4nc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aI1PQlBrCPI1E0ScVgvrY+Wdsj+6726yr6UXqOVP15pxvhXQgFUcXeomLjZmLNVFs
         wWS+A5+giQbAUqwFnllGb3FWGY6tU2/W54CZtYmU2HGp+b1YhLx4Jmnuo4iBAOHXic
         LwZSCkvuZxQbzIqtZiEdE/zFXfjGzDCzvdqEzzLY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marco Elver <elver@google.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 306/591] kcsan: Dont expect 64 bits atomic builtins from 32 bits architectures
Date:   Sun, 16 Jul 2023 21:47:25 +0200
Message-ID: <20230716194931.808729125@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christophe Leroy <christophe.leroy@csgroup.eu>

[ Upstream commit 353e7300a1db928e427462f2745f9a2cd1625b3d ]

Activating KCSAN on a 32 bits architecture leads to the following
link-time failure:

    LD      .tmp_vmlinux.kallsyms1
  powerpc64-linux-ld: kernel/kcsan/core.o: in function `__tsan_atomic64_load':
  kernel/kcsan/core.c:1273: undefined reference to `__atomic_load_8'
  powerpc64-linux-ld: kernel/kcsan/core.o: in function `__tsan_atomic64_store':
  kernel/kcsan/core.c:1273: undefined reference to `__atomic_store_8'
  powerpc64-linux-ld: kernel/kcsan/core.o: in function `__tsan_atomic64_exchange':
  kernel/kcsan/core.c:1273: undefined reference to `__atomic_exchange_8'
  powerpc64-linux-ld: kernel/kcsan/core.o: in function `__tsan_atomic64_fetch_add':
  kernel/kcsan/core.c:1273: undefined reference to `__atomic_fetch_add_8'
  powerpc64-linux-ld: kernel/kcsan/core.o: in function `__tsan_atomic64_fetch_sub':
  kernel/kcsan/core.c:1273: undefined reference to `__atomic_fetch_sub_8'
  powerpc64-linux-ld: kernel/kcsan/core.o: in function `__tsan_atomic64_fetch_and':
  kernel/kcsan/core.c:1273: undefined reference to `__atomic_fetch_and_8'
  powerpc64-linux-ld: kernel/kcsan/core.o: in function `__tsan_atomic64_fetch_or':
  kernel/kcsan/core.c:1273: undefined reference to `__atomic_fetch_or_8'
  powerpc64-linux-ld: kernel/kcsan/core.o: in function `__tsan_atomic64_fetch_xor':
  kernel/kcsan/core.c:1273: undefined reference to `__atomic_fetch_xor_8'
  powerpc64-linux-ld: kernel/kcsan/core.o: in function `__tsan_atomic64_fetch_nand':
  kernel/kcsan/core.c:1273: undefined reference to `__atomic_fetch_nand_8'
  powerpc64-linux-ld: kernel/kcsan/core.o: in function `__tsan_atomic64_compare_exchange_strong':
  kernel/kcsan/core.c:1273: undefined reference to `__atomic_compare_exchange_8'
  powerpc64-linux-ld: kernel/kcsan/core.o: in function `__tsan_atomic64_compare_exchange_weak':
  kernel/kcsan/core.c:1273: undefined reference to `__atomic_compare_exchange_8'
  powerpc64-linux-ld: kernel/kcsan/core.o: in function `__tsan_atomic64_compare_exchange_val':
  kernel/kcsan/core.c:1273: undefined reference to `__atomic_compare_exchange_8'

32 bits architectures don't have 64 bits atomic builtins. Only
include DEFINE_TSAN_ATOMIC_OPS(64) on 64 bits architectures.

Fixes: 0f8ad5f2e934 ("kcsan: Add support for atomic builtins")
Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Marco Elver <elver@google.com>
Acked-by: Marco Elver <elver@google.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/d9c6afc28d0855240171a4e0ad9ffcdb9d07fceb.1683892665.git.christophe.leroy@csgroup.eu
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/kcsan/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 5a60cc52adc0c..8a7baf4e332e3 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -1270,7 +1270,9 @@ static __always_inline void kcsan_atomic_builtin_memorder(int memorder)
 DEFINE_TSAN_ATOMIC_OPS(8);
 DEFINE_TSAN_ATOMIC_OPS(16);
 DEFINE_TSAN_ATOMIC_OPS(32);
+#ifdef CONFIG_64BIT
 DEFINE_TSAN_ATOMIC_OPS(64);
+#endif
 
 void __tsan_atomic_thread_fence(int memorder);
 void __tsan_atomic_thread_fence(int memorder)
-- 
2.39.2




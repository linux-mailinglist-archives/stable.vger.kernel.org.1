Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C767551C3
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjGPT75 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjGPT7x (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:59:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C20FE51
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:59:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3923460EB0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 19:59:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4671FC433C8;
        Sun, 16 Jul 2023 19:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537591;
        bh=rTzKhQTKx3K9M/sdAMsUbVcPFIgeaZbAXQqdkXyp330=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SsCM7wDa98xkZH8Ga13HD2Yt0emPxkejgrI/3pLkqovq5lfz4cBC9ai515ZgpRIIp
         As3pf5e5/uOhzzQykeK9SgS/90ZdQsNttdlOF6siV7nKJ4NXraI8tAMC6dBQkeY4Gj
         4tmJW/jbIVHEPX55mXgPWo8+Ph7vCgHyra/F54GI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Lennart Poettering <lennart@poettering.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 121/800] libbpf: fix offsetof() and container_of() to work with CO-RE
Date:   Sun, 16 Jul 2023 21:39:34 +0200
Message-ID: <20230716194951.917244816@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit bdeeed3498c7871c17465bb4f11d1bc67f9098af ]

It seems like __builtin_offset() doesn't preserve CO-RE field
relocations properly. So if offsetof() macro is defined through
__builtin_offset(), CO-RE-enabled BPF code using container_of() will be
subtly and silently broken.

To avoid this problem, redefine offsetof() and container_of() in the
form that works with CO-RE relocations more reliably.

Fixes: 5fbc220862fc ("tools/libpf: Add offsetof/container_of macro in bpf_helpers.h")
Reported-by: Lennart Poettering <lennart@poettering.net>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Yonghong Song <yhs@fb.com>
Link: https://lore.kernel.org/r/20230509065502.2306180-1-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/bpf_helpers.h | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 929a3baca8ef3..bbab9ad9dc5a7 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -77,16 +77,21 @@
 /*
  * Helper macros to manipulate data structures
  */
-#ifndef offsetof
-#define offsetof(TYPE, MEMBER)	((unsigned long)&((TYPE *)0)->MEMBER)
-#endif
-#ifndef container_of
+
+/* offsetof() definition that uses __builtin_offset() might not preserve field
+ * offset CO-RE relocation properly, so force-redefine offsetof() using
+ * old-school approach which works with CO-RE correctly
+ */
+#undef offsetof
+#define offsetof(type, member)	((unsigned long)&((type *)0)->member)
+
+/* redefined container_of() to ensure we use the above offsetof() macro */
+#undef container_of
 #define container_of(ptr, type, member)				\
 	({							\
 		void *__mptr = (void *)(ptr);			\
 		((type *)(__mptr - offsetof(type, member)));	\
 	})
-#endif
 
 /*
  * Compiler (optimization) barrier.
-- 
2.39.2




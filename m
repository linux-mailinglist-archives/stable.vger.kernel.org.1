Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E5E7613D3
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbjGYLOR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbjGYLOD (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:14:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482051BDB
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:13:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEDD561656
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:13:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77C4C433CB;
        Tue, 25 Jul 2023 11:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283587;
        bh=83wgxeA2vtxBaeJmqd+cKoHilSB5e5frOn94sfa+NBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nHyj6deHVnEYTro9UWWaiXglMZpIC/+MHTGqef+aaB3I2KME5FdlsvaZs0up1Lh5S
         EQszipLGK6mq47yxsWmQR0z6Txyv/lQu5E4ntaBUKsH9U637m8tsWNUdtHTSqSRf+q
         U/Ah2dCvARHcLdfVzY5RRerSrgCJ+Pr8No8/8Fuc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Lennart Poettering <lennart@poettering.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 050/509] libbpf: fix offsetof() and container_of() to work with CO-RE
Date:   Tue, 25 Jul 2023 12:39:49 +0200
Message-ID: <20230725104555.976699868@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
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
index 72b251110c4d7..1c389b0f5499a 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -42,16 +42,21 @@
 /*
  * Helper macro to manipulate data structures
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
  * Helper macro to throw a compilation error if __bpf_unreachable() gets
-- 
2.39.2




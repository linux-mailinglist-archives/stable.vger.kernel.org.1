Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0B973E866
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjFZSZc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbjFZSZO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:25:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8369E173D
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:24:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 487FF60F57
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:24:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53533C433C0;
        Mon, 26 Jun 2023 18:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803870;
        bh=/jy0jdXDEhOY3t3DIBzvRMyMooNFsh+AkjgnCmlVeMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qc7fPEvpMz1zXF3ZoROOoKE9RKz6FMBvCC2rO4uZ6Q67h03ImaNVsC2KCG5/39aRp
         fvdTLhNH9ITzd/3TpdO3RUPp9k/v5pKzaqHO1oPbhPOjq4MRZyYOuKJzAZYfE2ZCpE
         Ds9TGQobHEieU1UintusqQQpCNxXHTEXl5lxxfRM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Rong Tao <rongtao@cestc.cn>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 189/199] tools/virtio: Fix arm64 ringtest compilation error
Date:   Mon, 26 Jun 2023 20:11:35 +0200
Message-ID: <20230626180814.018526508@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

[ Upstream commit 57380fd1249b20ef772549af2c58ef57b21faba7 ]

Add cpu_relax() for arm64 instead of directly assert(), and add assert.h
header file. Also, add smp_wmb and smp_mb for arm64.

Compilation error as follows, avoid __always_inline undefined.

    $ make
    cc -Wall -pthread -O2 -ggdb -flto -fwhole-program -c -o ring.o ring.c
    In file included from ring.c:10:
    main.h: In function ‘busy_wait’:
    main.h:99:21: warning: implicit declaration of function ‘assert’
    [-Wimplicit-function-declaration]
    99 | #define cpu_relax() assert(0)
        |                     ^~~~~~
    main.h:107:17: note: in expansion of macro ‘cpu_relax’
    107 |                 cpu_relax();
        |                 ^~~~~~~~~
    main.h:12:1: note: ‘assert’ is defined in header ‘<assert.h>’; did you
    forget to ‘#include <assert.h>’?
    11 | #include <stdbool.h>
    +++ |+#include <assert.h>
    12 |
    main.h: At top level:
    main.h:143:23: error: expected ‘;’ before ‘void’
    143 | static __always_inline
        |                       ^
        |                       ;
    144 | void __read_once_size(const volatile void *p, void *res, int
    size)
        | ~~~~
    main.h:158:23: error: expected ‘;’ before ‘void’
    158 | static __always_inline void __write_once_size(volatile void *p,
    void *res, int size)
        |                       ^~~~~
        |                       ;
    make: *** [<builtin>: ring.o] Error 1

Signed-off-by: Rong Tao <rongtao@cestc.cn>
Message-Id: <tencent_F53E159DD7925174445D830DA19FACF44B07@qq.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/virtio/ringtest/main.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/virtio/ringtest/main.h b/tools/virtio/ringtest/main.h
index b68920d527503..d18dd317e27f9 100644
--- a/tools/virtio/ringtest/main.h
+++ b/tools/virtio/ringtest/main.h
@@ -8,6 +8,7 @@
 #ifndef MAIN_H
 #define MAIN_H
 
+#include <assert.h>
 #include <stdbool.h>
 
 extern int param;
@@ -95,6 +96,8 @@ extern unsigned ring_size;
 #define cpu_relax() asm ("rep; nop" ::: "memory")
 #elif defined(__s390x__)
 #define cpu_relax() barrier()
+#elif defined(__aarch64__)
+#define cpu_relax() asm ("yield" ::: "memory")
 #else
 #define cpu_relax() assert(0)
 #endif
@@ -112,6 +115,8 @@ static inline void busy_wait(void)
 
 #if defined(__x86_64__) || defined(__i386__)
 #define smp_mb()     asm volatile("lock; addl $0,-132(%%rsp)" ::: "memory", "cc")
+#elif defined(__aarch64__)
+#define smp_mb()     asm volatile("dmb ish" ::: "memory")
 #else
 /*
  * Not using __ATOMIC_SEQ_CST since gcc docs say they are only synchronized
@@ -136,10 +141,16 @@ static inline void busy_wait(void)
 
 #if defined(__i386__) || defined(__x86_64__) || defined(__s390x__)
 #define smp_wmb() barrier()
+#elif defined(__aarch64__)
+#define smp_wmb() asm volatile("dmb ishst" ::: "memory")
 #else
 #define smp_wmb() smp_release()
 #endif
 
+#ifndef __always_inline
+#define __always_inline inline __attribute__((always_inline))
+#endif
+
 static __always_inline
 void __read_once_size(const volatile void *p, void *res, int size)
 {
-- 
2.39.2




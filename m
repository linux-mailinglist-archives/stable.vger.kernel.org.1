Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9467A77AD59
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbjHMVtK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjHMVse (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:48:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6831B199E
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:40:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F284F60F71
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:40:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147F3C433C7;
        Sun, 13 Aug 2023 21:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962855;
        bh=kXBFi4hfIk+Q14JW8uzgsf+WK2BtG/zSp8omQa2vUck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EtAg1R+kzMyZqZfk2AicWn1mYe8MCGYXZtkze13fj/TLoVrKlCf9G6pxinsvIrhl0
         05D3192ysDQVT2dz74Aua/acjAPJrGHck5ssKVtn27ozcx7R6hfvxJHi+T4XwOTB0S
         kPqfDfASKATjugB9By99DGYQhZJl1Wc6r7k7mlbg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mark Brown <broonie@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.10 32/68] selftests/rseq: Fix build with undefined __weak
Date:   Sun, 13 Aug 2023 23:19:33 +0200
Message-ID: <20230813211709.133936691@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211708.149630011@linuxfoundation.org>
References: <20230813211708.149630011@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mark Brown <broonie@kernel.org>

commit d5ad9aae13dcced333c1a7816ff0a4fbbb052466 upstream.

Commit 3bcbc20942db ("selftests/rseq: Play nice with binaries statically
linked against glibc 2.35+") which is now in Linus' tree introduced uses
of __weak but did nothing to ensure that a definition is provided for it
resulting in build failures for the rseq tests:

rseq.c:41:1: error: unknown type name '__weak'
__weak ptrdiff_t __rseq_offset;
^
rseq.c:41:17: error: expected ';' after top level declarator
__weak ptrdiff_t __rseq_offset;
                ^
                ;
rseq.c:42:1: error: unknown type name '__weak'
__weak unsigned int __rseq_size;
^
rseq.c:43:1: error: unknown type name '__weak'
__weak unsigned int __rseq_flags;

Fix this by using the definition from tools/include compiler.h.

Fixes: 3bcbc20942db ("selftests/rseq: Play nice with binaries statically linked against glibc 2.35+")
Signed-off-by: Mark Brown <broonie@kernel.org>
Message-Id: <20230804-kselftest-rseq-build-v1-1-015830b66aa9@kernel.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/rseq/Makefile |    4 +++-
 tools/testing/selftests/rseq/rseq.c   |    2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -4,8 +4,10 @@ ifneq ($(shell $(CC) --version 2>&1 | he
 CLANG_FLAGS += -no-integrated-as
 endif
 
+top_srcdir = ../../../..
+
 CFLAGS += -O2 -Wall -g -I./ -I../../../../usr/include/ -L$(OUTPUT) -Wl,-rpath=./ \
-	  $(CLANG_FLAGS)
+	  $(CLANG_FLAGS) -I$(top_srcdir)/tools/include
 LDLIBS += -lpthread -ldl
 
 # Own dependencies because we only want to build against 1st prerequisite, but
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -29,6 +29,8 @@
 #include <dlfcn.h>
 #include <stddef.h>
 
+#include <linux/compiler.h>
+
 #include "../kselftest.h"
 #include "rseq.h"
 



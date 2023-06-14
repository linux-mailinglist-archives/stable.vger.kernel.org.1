Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E73726F3F
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235434AbjFGU4x (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235521AbjFGU4w (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:56:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62A21721
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:56:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5078564851
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:56:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6505EC4339B;
        Wed,  7 Jun 2023 20:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171403;
        bh=QD6I+bCr+RV/71NDqpz6EaS9MABIMIitX+jkoggWWIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e2r22vFDYr181f6AollGSEVchGN7WvqWB7Rhrw9Zb4T0sRZ5ix7AT/b0GNW5m0U8P
         ZHI21dg0W1nW9ijm2ZlB7oU02lXXTChOb1poxYRSkUAK5Qn+jqEaWJ6XvBqw3c+OMq
         gYmyr7+ko5CrT3sZJ9H5/7Whq2QxJJKc4LT1HaAk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.4 80/99] lib/dynamic_debug.c: use address-of operator on section symbols
Date:   Wed,  7 Jun 2023 22:17:12 +0200
Message-ID: <20230607200902.731741043@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200900.195572674@linuxfoundation.org>
References: <20230607200900.195572674@linuxfoundation.org>
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

From: Nathan Chancellor <natechancellor@gmail.com>

commit 8306b057a85ec07482da5d4b99d5c0b47af69be1 upstream.

Clang warns:

../lib/dynamic_debug.c:1034:24: warning: array comparison always
evaluates to false [-Wtautological-compare]
        if (__start___verbose == __stop___verbose) {
                              ^
1 warning generated.

These are not true arrays, they are linker defined symbols, which are just
addresses.  Using the address of operator silences the warning and does
not change the resulting assembly with either clang/ld.lld or gcc/ld
(tested with diff + objdump -Dr).

Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Jason Baron <jbaron@akamai.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/894
Link: http://lkml.kernel.org/r/20200220051320.10739-1-natechancellor@gmail.com
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/dynamic_debug.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1015,7 +1015,7 @@ static int __init dynamic_debug_init(voi
 	int n = 0, entries = 0, modct = 0;
 	int verbose_bytes = 0;
 
-	if (__start___verbose == __stop___verbose) {
+	if (&__start___verbose == &__stop___verbose) {
 		pr_warn("_ddebug table is empty in a CONFIG_DYNAMIC_DEBUG build\n");
 		return 1;
 	}



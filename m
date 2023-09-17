Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110367A39CB
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240158AbjIQTyl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240165AbjIQTyR (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:54:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2E612F
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:54:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61DB9C433CB;
        Sun, 17 Sep 2023 19:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980451;
        bh=TxYAOnsZAPc0Wj+wN1x6u4+LJciXT++KaEx7oZxPnyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IEbL6A7IBXCphNBJAdrinrWLKAmWEaosg8rtHlEhF9/BnoHK3kXlxoCt5asixwZKg
         BV4KlMAZh+FE1NXuoKPqwEBqK3urdkQbhq5nbO6lynsh663RPTlfjmLkP4Y/grKug0
         TIAat05IoelykwTPOU2YH6uQeqSS0L6M4r0ugaBw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH 6.5 194/285] lib: test_scanf: Add explicit type cast to result initialization in test_number_prefix()
Date:   Sun, 17 Sep 2023 21:13:14 +0200
Message-ID: <20230917191058.309752463@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nathan Chancellor <nathan@kernel.org>

commit 92382d744176f230101d54f5c017bccd62770f01 upstream.

A recent change in clang allows it to consider more expressions as
compile time constants, which causes it to point out an implicit
conversion in the scanf tests:

  lib/test_scanf.c:661:2: warning: implicit conversion from 'int' to 'unsigned char' changes value from -168 to 88 [-Wconstant-conversion]
    661 |         test_number_prefix(unsigned char,       "0xA7", "%2hhx%hhx", 0, 0xa7, 2, check_uchar);
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  lib/test_scanf.c:609:29: note: expanded from macro 'test_number_prefix'
    609 |         T result[2] = {~expect[0], ~expect[1]};                                 \
        |                       ~            ^~~~~~~~~~
  1 warning generated.

The result of the bitwise negation is the type of the operand after
going through the integer promotion rules, so this truncation is
expected but harmless, as the initial values in the result array get
overwritten by _test() anyways. Add an explicit cast to the expected
type in test_number_prefix() to silence the warning. There is no
functional change, as all the tests still pass with GCC 13.1.0 and clang
18.0.0.

Cc: stable@vger.kernel.org
Link: https://github.com/ClangBuiltLinux/linuxq/issues/1899
Link: https://github.com/llvm/llvm-project/commit/610ec954e1f81c0e8fcadedcd25afe643f5a094e
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20230807-test_scanf-wconstant-conversion-v2-1-839ca39083e1@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/test_scanf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/lib/test_scanf.c
+++ b/lib/test_scanf.c
@@ -606,7 +606,7 @@ static void __init numbers_slice(void)
 #define test_number_prefix(T, str, scan_fmt, expect0, expect1, n_args, fn)	\
 do {										\
 	const T expect[2] = { expect0, expect1 };				\
-	T result[2] = {~expect[0], ~expect[1]};					\
+	T result[2] = { (T)~expect[0], (T)~expect[1] };				\
 										\
 	_test(fn, &expect, str, scan_fmt, n_args, &result[0], &result[1]);	\
 } while (0)



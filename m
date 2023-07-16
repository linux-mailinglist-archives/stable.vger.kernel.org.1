Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514E5755180
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjGPT5P (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjGPT5H (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:57:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4D8F1
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:57:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 698A060EB2
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 19:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78DBEC433C7;
        Sun, 16 Jul 2023 19:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537425;
        bh=8AOQlVVAdP77U3lk/tBPswUyCXNRf2M3SbER/kWYn1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j3d2bQscmIHNCeX7a3ThEDlTOLyXJl8L3pcflx/e8BP6+3bLVvGkGEHoHZQB4ybyR
         Ou3o+ILqSHd+suEiyAGwFtAoWk41xFYXJyIss/BEJEaP+zt76aCo1ZmIGyHghSHAyl
         /g1tDsIHb5xHK3VxqBIBKlS069pkF8JOXcF6vhqs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 092/800] tools/nolibc: ensure fast64 integer types have 64 bits
Date:   Sun, 16 Jul 2023 21:39:05 +0200
Message-ID: <20230716194951.249079141@linuxfoundation.org>
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

From: Thomas Weißschuh <linux@weissschuh.net>

[ Upstream commit f9bf5944d37b75b8238349d4fb5b7a97bbecfc9d ]

On 32bit platforms size_t is not enough to represent [u]int_fast64_t.

Fixes: 3e9fd4e9a1d5 ("tools/nolibc: add integer types and integer limit macros")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/include/nolibc/stdint.h                | 10 +++++-----
 tools/testing/selftests/nolibc/nolibc-test.c |  6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/include/nolibc/stdint.h b/tools/include/nolibc/stdint.h
index c1ce4f5e06034..661d942862c0b 100644
--- a/tools/include/nolibc/stdint.h
+++ b/tools/include/nolibc/stdint.h
@@ -36,8 +36,8 @@ typedef  ssize_t       int_fast16_t;
 typedef   size_t      uint_fast16_t;
 typedef  ssize_t       int_fast32_t;
 typedef   size_t      uint_fast32_t;
-typedef  ssize_t       int_fast64_t;
-typedef   size_t      uint_fast64_t;
+typedef  int64_t       int_fast64_t;
+typedef uint64_t      uint_fast64_t;
 
 typedef  int64_t           intmax_t;
 typedef uint64_t          uintmax_t;
@@ -84,16 +84,16 @@ typedef uint64_t          uintmax_t;
 #define  INT_FAST8_MIN   INT8_MIN
 #define INT_FAST16_MIN   INTPTR_MIN
 #define INT_FAST32_MIN   INTPTR_MIN
-#define INT_FAST64_MIN   INTPTR_MIN
+#define INT_FAST64_MIN   INT64_MIN
 
 #define  INT_FAST8_MAX   INT8_MAX
 #define INT_FAST16_MAX   INTPTR_MAX
 #define INT_FAST32_MAX   INTPTR_MAX
-#define INT_FAST64_MAX   INTPTR_MAX
+#define INT_FAST64_MAX   INT64_MAX
 
 #define  UINT_FAST8_MAX  UINT8_MAX
 #define UINT_FAST16_MAX  SIZE_MAX
 #define UINT_FAST32_MAX  SIZE_MAX
-#define UINT_FAST64_MAX  SIZE_MAX
+#define UINT_FAST64_MAX  UINT64_MAX
 
 #endif /* _NOLIBC_STDINT_H */
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 21bacc928bf7b..d37d036876ea9 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -639,9 +639,9 @@ int run_stdlib(int min, int max)
 		CASE_TEST(limit_int_fast32_min);    EXPECT_EQ(1, INT_FAST32_MIN,   (int_fast32_t)    INTPTR_MIN); break;
 		CASE_TEST(limit_int_fast32_max);    EXPECT_EQ(1, INT_FAST32_MAX,   (int_fast32_t)    INTPTR_MAX); break;
 		CASE_TEST(limit_uint_fast32_max);   EXPECT_EQ(1, UINT_FAST32_MAX,  (uint_fast32_t)   UINTPTR_MAX); break;
-		CASE_TEST(limit_int_fast64_min);    EXPECT_EQ(1, INT_FAST64_MIN,   (int_fast64_t)    INTPTR_MIN); break;
-		CASE_TEST(limit_int_fast64_max);    EXPECT_EQ(1, INT_FAST64_MAX,   (int_fast64_t)    INTPTR_MAX); break;
-		CASE_TEST(limit_uint_fast64_max);   EXPECT_EQ(1, UINT_FAST64_MAX,  (uint_fast64_t)   UINTPTR_MAX); break;
+		CASE_TEST(limit_int_fast64_min);    EXPECT_EQ(1, INT_FAST64_MIN,   (int_fast64_t)    INT64_MIN); break;
+		CASE_TEST(limit_int_fast64_max);    EXPECT_EQ(1, INT_FAST64_MAX,   (int_fast64_t)    INT64_MAX); break;
+		CASE_TEST(limit_uint_fast64_max);   EXPECT_EQ(1, UINT_FAST64_MAX,  (uint_fast64_t)   UINT64_MAX); break;
 #if __SIZEOF_LONG__ == 8
 		CASE_TEST(limit_intptr_min);        EXPECT_EQ(1, INTPTR_MIN,       (intptr_t)        0x8000000000000000LL); break;
 		CASE_TEST(limit_intptr_max);        EXPECT_EQ(1, INTPTR_MAX,       (intptr_t)        0x7fffffffffffffffLL); break;
-- 
2.39.2




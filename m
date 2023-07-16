Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BCC75532E
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjGPUQU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjGPUQT (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:16:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D60FE43;
        Sun, 16 Jul 2023 13:16:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A89960EAE;
        Sun, 16 Jul 2023 20:16:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E407BC433C8;
        Sun, 16 Jul 2023 20:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538576;
        bh=Oc4BTr5K3vTeSxq00miA1QYT23jOa88djcW0k/clk4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bGe9napxUyK/4tdwao8Ae0nlmRu8cUIHeGLMfCpCr7ZKkCeySuWJr5K4YVpA28qUB
         05N+GvS6GuaPl2r/KaQChWPhC6pJ7YaUVJfgeCbVbgKmFRfoV9ydzuK7VfasySDEZ4
         kj9DtzAILC/lvl83hekEBnG1NUpHvBeAkGnXOU/4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        =?UTF-8?q?Breno=20Leit=C3=A3o?= <leitao@debian.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Paulo Flabiano Smorigo <pfsmorigo@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 501/800] crypto: nx - fix build warnings when DEBUG_FS is not enabled
Date:   Sun, 16 Jul 2023 21:45:54 +0200
Message-ID: <20230716195000.731459159@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit b04b076fb56560b39d695ac3744db457e12278fd ]

Fix build warnings when DEBUG_FS is not enabled by using an empty
do-while loop instead of a value:

In file included from ../drivers/crypto/nx/nx.c:27:
../drivers/crypto/nx/nx.c: In function 'nx_register_algs':
../drivers/crypto/nx/nx.h:173:33: warning: statement with no effect [-Wunused-value]
  173 | #define NX_DEBUGFS_INIT(drv)    (0)
../drivers/crypto/nx/nx.c:573:9: note: in expansion of macro 'NX_DEBUGFS_INIT'
  573 |         NX_DEBUGFS_INIT(&nx_driver);
../drivers/crypto/nx/nx.c: In function 'nx_remove':
../drivers/crypto/nx/nx.h:174:33: warning: statement with no effect [-Wunused-value]
  174 | #define NX_DEBUGFS_FINI(drv)    (0)
../drivers/crypto/nx/nx.c:793:17: note: in expansion of macro 'NX_DEBUGFS_FINI'
  793 |                 NX_DEBUGFS_FINI(&nx_driver);

Also, there is no need to build nx_debugfs.o when DEBUG_FS is not
enabled, so change the Makefile to accommodate that.

Fixes: ae0222b7289d ("powerpc/crypto: nx driver code supporting nx encryption")
Fixes: aef7b31c8833 ("powerpc/crypto: Build files for the nx device driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Breno Leitão <leitao@debian.org>
Cc: Nayna Jain <nayna@linux.ibm.com>
Cc: Paulo Flabiano Smorigo <pfsmorigo@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/nx/Makefile | 2 +-
 drivers/crypto/nx/nx.h     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/nx/Makefile b/drivers/crypto/nx/Makefile
index d00181a26dd65..483cef62acee8 100644
--- a/drivers/crypto/nx/Makefile
+++ b/drivers/crypto/nx/Makefile
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CRYPTO_DEV_NX_ENCRYPT) += nx-crypto.o
 nx-crypto-objs := nx.o \
-		  nx_debugfs.o \
 		  nx-aes-cbc.o \
 		  nx-aes-ecb.o \
 		  nx-aes-gcm.o \
@@ -11,6 +10,7 @@ nx-crypto-objs := nx.o \
 		  nx-sha256.o \
 		  nx-sha512.o
 
+nx-crypto-$(CONFIG_DEBUG_FS) += nx_debugfs.o
 obj-$(CONFIG_CRYPTO_DEV_NX_COMPRESS_PSERIES) += nx-compress-pseries.o nx-compress.o
 obj-$(CONFIG_CRYPTO_DEV_NX_COMPRESS_POWERNV) += nx-compress-powernv.o nx-compress.o
 nx-compress-objs := nx-842.o
diff --git a/drivers/crypto/nx/nx.h b/drivers/crypto/nx/nx.h
index c6233173c612e..2697baebb6a35 100644
--- a/drivers/crypto/nx/nx.h
+++ b/drivers/crypto/nx/nx.h
@@ -170,8 +170,8 @@ struct nx_sg *nx_walk_and_build(struct nx_sg *, unsigned int,
 void nx_debugfs_init(struct nx_crypto_driver *);
 void nx_debugfs_fini(struct nx_crypto_driver *);
 #else
-#define NX_DEBUGFS_INIT(drv)	(0)
-#define NX_DEBUGFS_FINI(drv)	(0)
+#define NX_DEBUGFS_INIT(drv)	do {} while (0)
+#define NX_DEBUGFS_FINI(drv)	do {} while (0)
 #endif
 
 #define NX_PAGE_NUM(x)		((u64)(x) & 0xfffffffffffff000ULL)
-- 
2.39.2




Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FDC79B852
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343535AbjIKVLn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239948AbjIKOcI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:32:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED4CF2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:32:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5191C433C8;
        Mon, 11 Sep 2023 14:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442724;
        bh=Ix6E76ph/b6yJHkPXu2ablcKZ1kobIqd+KKTn0W6IP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VxGo6fv4fc84X0Y+WHj9xJyoLVu9P0/OyFher5KPl2TJ8bNJ7XraFAnJikW9leq2z
         Gk/+11ZFDy9mWaxTsp7+k9EvigGr0hqNWMexbTl4TKf9rjo74NfgB6JzJIwZI5EZJy
         Jeb3SDn8XXqeNaLkISWONzyv2QGZLCPUWfIPJRzo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Holger Dengler <dengler@linux.ibm.com>,
        Ingo Franzki <ifranzki@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 126/737] s390/pkey: fix/harmonize internal keyblob headers
Date:   Mon, 11 Sep 2023 15:39:45 +0200
Message-ID: <20230911134654.023724254@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Holger Dengler <dengler@linux.ibm.com>

[ Upstream commit 37a08f010b7c423b5e4c9ed3b187d21166553007 ]

Commit 'fa6999e326fe ("s390/pkey: support CCA and EP11 secure ECC
private keys")' introduced PKEY_TYPE_EP11_AES as a supplement to
PKEY_TYPE_EP11. All pkeys have an internal header/payload structure,
which is opaque to the userspace. The header structures for
PKEY_TYPE_EP11 and PKEY_TYPE_EP11_AES are nearly identical and there
is no reason, why different structures are used. In preparation to fix
the keyversion handling in the broken PKEY IOCTLs, the same header
structure is used for PKEY_TYPE_EP11 and PKEY_TYPE_EP11_AES. This
reduces the number of different code paths and increases the
readability.

Fixes: fa6999e326fe ("s390/pkey: support CCA and EP11 secure ECC private keys")
Signed-off-by: Holger Dengler <dengler@linux.ibm.com>
Reviewed-by: Ingo Franzki <ifranzki@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/crypto/pkey_api.c        | 2 +-
 drivers/s390/crypto/zcrypt_ep11misc.c | 4 ++--
 drivers/s390/crypto/zcrypt_ep11misc.h | 9 +--------
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index a8def50c149bd..e650df3fe7ccb 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -747,7 +747,7 @@ static int pkey_verifykey2(const u8 *key, size_t keylen,
 		if (ktype)
 			*ktype = PKEY_TYPE_EP11;
 		if (ksize)
-			*ksize = kb->head.keybitlen;
+			*ksize = kb->head.bitlen;
 
 		rc = ep11_findcard2(&_apqns, &_nr_apqns, *cardnr, *domain,
 				    ZCRYPT_CEX7, EP11_API_V, kb->wkvp);
diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
index f67d19d08571b..79dc57e720ff1 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.c
+++ b/drivers/s390/crypto/zcrypt_ep11misc.c
@@ -787,7 +787,7 @@ int ep11_genaeskey(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
 	kb->head.type = TOKTYPE_NON_CCA;
 	kb->head.len = rep_pl->data_len;
 	kb->head.version = TOKVER_EP11_AES;
-	kb->head.keybitlen = keybitsize;
+	kb->head.bitlen = keybitsize;
 
 out:
 	kfree(req);
@@ -1055,7 +1055,7 @@ static int ep11_unwrapkey(u16 card, u16 domain,
 	kb->head.type = TOKTYPE_NON_CCA;
 	kb->head.len = rep_pl->data_len;
 	kb->head.version = TOKVER_EP11_AES;
-	kb->head.keybitlen = keybitsize;
+	kb->head.bitlen = keybitsize;
 
 out:
 	kfree(req);
diff --git a/drivers/s390/crypto/zcrypt_ep11misc.h b/drivers/s390/crypto/zcrypt_ep11misc.h
index 07445041869fe..912b3918c10a1 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.h
+++ b/drivers/s390/crypto/zcrypt_ep11misc.h
@@ -29,14 +29,7 @@ struct ep11keyblob {
 	union {
 		u8 session[32];
 		/* only used for PKEY_TYPE_EP11: */
-		struct {
-			u8  type;      /* 0x00 (TOKTYPE_NON_CCA) */
-			u8  res0;      /* unused */
-			u16 len;       /* total length in bytes of this blob */
-			u8  version;   /* 0x03 (TOKVER_EP11_AES) */
-			u8  res1;      /* unused */
-			u16 keybitlen; /* clear key bit len, 0 for unknown */
-		} head;
+		struct ep11kblob_header head;
 	};
 	u8  wkvp[16];  /* wrapping key verification pattern */
 	u64 attr;      /* boolean key attributes */
-- 
2.40.1




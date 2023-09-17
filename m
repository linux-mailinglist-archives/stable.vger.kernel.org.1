Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74527A37A6
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239447AbjIQTXM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239487AbjIQTWy (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:22:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3661119
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:22:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58BAC433C8;
        Sun, 17 Sep 2023 19:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694978566;
        bh=fyvBnvOtzaXpfOgrQ8PoWWw2Ocp/pmX2Uj4hRrKUOXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z+gkejZkilfw3vPJezp6FovZeMHb1Z61kG+junocxsloaW+2sKqRUVLfvy0QbHP0P
         nCTF1cYe/A4Of6HoED7xdF5pfXY8KzkjuwoAqT7u1uP9Eu/iGC72t2hJgBXrpDWjjW
         4A/bxUaElqrnqPKVxkLGUl3Erh5fFuYGbEbGPZtA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Holger Dengler <dengler@linux.ibm.com>,
        Ingo Franzki <ifranzki@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 078/406] s390/pkey: fix/harmonize internal keyblob headers
Date:   Sun, 17 Sep 2023 21:08:52 +0200
Message-ID: <20230917191103.191834329@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index 870e00effe439..69882ff4db107 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -735,7 +735,7 @@ static int pkey_verifykey2(const u8 *key, size_t keylen,
 		if (ktype)
 			*ktype = PKEY_TYPE_EP11;
 		if (ksize)
-			*ksize = kb->head.keybitlen;
+			*ksize = kb->head.bitlen;
 
 		rc = ep11_findcard2(&_apqns, &_nr_apqns, *cardnr, *domain,
 				    ZCRYPT_CEX7, EP11_API_V, kb->wkvp);
diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
index 9ce5a71da69b8..3daf259ba10e7 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.c
+++ b/drivers/s390/crypto/zcrypt_ep11misc.c
@@ -788,7 +788,7 @@ int ep11_genaeskey(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
 	kb->head.type = TOKTYPE_NON_CCA;
 	kb->head.len = rep_pl->data_len;
 	kb->head.version = TOKVER_EP11_AES;
-	kb->head.keybitlen = keybitsize;
+	kb->head.bitlen = keybitsize;
 
 out:
 	kfree(req);
@@ -1056,7 +1056,7 @@ static int ep11_unwrapkey(u16 card, u16 domain,
 	kb->head.type = TOKTYPE_NON_CCA;
 	kb->head.len = rep_pl->data_len;
 	kb->head.version = TOKVER_EP11_AES;
-	kb->head.keybitlen = keybitsize;
+	kb->head.bitlen = keybitsize;
 
 out:
 	kfree(req);
diff --git a/drivers/s390/crypto/zcrypt_ep11misc.h b/drivers/s390/crypto/zcrypt_ep11misc.h
index 1e02b197c0035..d424fa901f1b0 100644
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




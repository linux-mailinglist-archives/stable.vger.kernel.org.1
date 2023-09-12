Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B3179B659
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344704AbjIKVOm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238287AbjIKNxV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:53:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85755CF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:53:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3146C433C7;
        Mon, 11 Sep 2023 13:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440394;
        bh=WanORLhAiAagNO+Fg77mbefLL+fqOAA1IWjevCTW5S0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sFJSuGSYSXBZO0KCP09Bm6RQ1heR0JmjaD34MUay9HbOXOKkeukz0IThc/kwFN1hg
         F3mPUnNeenm+TIGxxiQioJywOuQV4i3AuPsh/t7gtXithmzP1UuKNSjVWF/R+uvPKv
         tnvR7CCOiZGfcWoUn6q/wKs0HRgkQAELWlRH2Ep4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Holger Dengler <dengler@linux.ibm.com>,
        Ingo Franzki <ifranzki@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 045/739] s390/pkey: fix PKEY_TYPE_EP11_AES handling in PKEY_GENSECK2 IOCTL
Date:   Mon, 11 Sep 2023 15:37:24 +0200
Message-ID: <20230911134652.378819214@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Holger Dengler <dengler@linux.ibm.com>

[ Upstream commit fb249ce7f7bfd8621a38e4ad401ba74b680786d4 ]

Commit 'fa6999e326fe ("s390/pkey: support CCA and EP11 secure ECC
private keys")' introduced PKEY_TYPE_EP11_AES for the PKEY_GENSECK2
IOCTL, to enable userspace to generate securekey blobs of this
type. Unfortunately, all PKEY_GENSECK2 IOCTL requests for
PKEY_TYPE_EP11_AES return with an error (-EINVAL). Fix the handling
for PKEY_TYPE_EP11_AES in PKEY_GENSECK2 IOCTL, so that userspace can
generate securekey blobs of this type.

The start of the header and the keyblob, as well as the length need
special handling, depending on the internal keyversion. Add a helper
function that splits an uninitialized buffer into start and size of
the header as well as start and size of the payload, depending on the
requested keyversion.

Do the header-related calculations and the raw genkey request handling
in separate functions. Use the raw genkey request function for
internal purposes.

Fixes: fa6999e326fe ("s390/pkey: support CCA and EP11 secure ECC private keys")
Signed-off-by: Holger Dengler <dengler@linux.ibm.com>
Reviewed-by: Ingo Franzki <ifranzki@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/crypto/pkey_api.c        |  18 +++--
 drivers/s390/crypto/zcrypt_ep11misc.c | 103 ++++++++++++++++++++++----
 drivers/s390/crypto/zcrypt_ep11misc.h |   2 +-
 3 files changed, 102 insertions(+), 21 deletions(-)

diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index ba8581e0809cd..2661d6a9ea131 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -713,6 +713,11 @@ static int pkey_genseckey2(const struct pkey_apqn *apqns, size_t nr_apqns,
 		if (*keybufsize < MINEP11AESKEYBLOBSIZE)
 			return -EINVAL;
 		break;
+	case PKEY_TYPE_EP11_AES:
+		if (*keybufsize < (sizeof(struct ep11kblob_header) +
+				   MINEP11AESKEYBLOBSIZE))
+			return -EINVAL;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -729,9 +734,10 @@ static int pkey_genseckey2(const struct pkey_apqn *apqns, size_t nr_apqns,
 	for (i = 0, rc = -ENODEV; i < nr_apqns; i++) {
 		card = apqns[i].card;
 		dom = apqns[i].domain;
-		if (ktype == PKEY_TYPE_EP11) {
+		if (ktype == PKEY_TYPE_EP11 ||
+		    ktype == PKEY_TYPE_EP11_AES) {
 			rc = ep11_genaeskey(card, dom, ksize, kflags,
-					    keybuf, keybufsize);
+					    keybuf, keybufsize, ktype);
 		} else if (ktype == PKEY_TYPE_CCA_DATA) {
 			rc = cca_genseckey(card, dom, ksize, keybuf);
 			*keybufsize = (rc ? 0 : SECKEYBLOBSIZE);
@@ -1466,7 +1472,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 		apqns = _copy_apqns_from_user(kgs.apqns, kgs.apqn_entries);
 		if (IS_ERR(apqns))
 			return PTR_ERR(apqns);
-		kkey = kmalloc(klen, GFP_KERNEL);
+		kkey = kzalloc(klen, GFP_KERNEL);
 		if (!kkey) {
 			kfree(apqns);
 			return -ENOMEM;
@@ -2130,7 +2136,8 @@ static ssize_t pkey_ep11_aes_attr_read(enum pkey_key_size keybits,
 	for (i = 0, rc = -ENODEV; i < nr_apqns; i++) {
 		card = apqns[i] >> 16;
 		dom = apqns[i] & 0xFFFF;
-		rc = ep11_genaeskey(card, dom, keybits, 0, buf, &keysize);
+		rc = ep11_genaeskey(card, dom, keybits, 0, buf, &keysize,
+				    PKEY_TYPE_EP11);
 		if (rc == 0)
 			break;
 	}
@@ -2140,7 +2147,8 @@ static ssize_t pkey_ep11_aes_attr_read(enum pkey_key_size keybits,
 	if (is_xts) {
 		keysize = MAXEP11AESKEYBLOBSIZE;
 		buf += MAXEP11AESKEYBLOBSIZE;
-		rc = ep11_genaeskey(card, dom, keybits, 0, buf, &keysize);
+		rc = ep11_genaeskey(card, dom, keybits, 0, buf, &keysize,
+				    PKEY_TYPE_EP11);
 		if (rc == 0)
 			return 2 * MAXEP11AESKEYBLOBSIZE;
 	}
diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
index d7ecd6ce5b7a7..51f6753e01c50 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.c
+++ b/drivers/s390/crypto/zcrypt_ep11misc.c
@@ -113,6 +113,50 @@ static void __exit card_cache_free(void)
 	spin_unlock_bh(&card_list_lock);
 }
 
+static int ep11_kb_split(const u8 *kb, size_t kblen, u32 kbver,
+			 struct ep11kblob_header **kbhdr, size_t *kbhdrsize,
+			 u8 **kbpl, size_t *kbplsize)
+{
+	struct ep11kblob_header *hdr = NULL;
+	size_t hdrsize, plsize = 0;
+	int rc = -EINVAL;
+	u8 *pl = NULL;
+
+	if (kblen < sizeof(struct ep11kblob_header))
+		goto out;
+	hdr = (struct ep11kblob_header *)kb;
+
+	switch (kbver) {
+	case TOKVER_EP11_AES:
+		/* header overlays the payload */
+		hdrsize = 0;
+		break;
+	case TOKVER_EP11_ECC_WITH_HEADER:
+	case TOKVER_EP11_AES_WITH_HEADER:
+		/* payload starts after the header */
+		hdrsize = sizeof(struct ep11kblob_header);
+		break;
+	default:
+		goto out;
+	}
+
+	plsize = kblen - hdrsize;
+	pl = (u8 *)kb + hdrsize;
+
+	if (kbhdr)
+		*kbhdr = hdr;
+	if (kbhdrsize)
+		*kbhdrsize = hdrsize;
+	if (kbpl)
+		*kbpl = pl;
+	if (kbplsize)
+		*kbplsize = plsize;
+
+	rc = 0;
+out:
+	return rc;
+}
+
 /*
  * Simple check if the key blob is a valid EP11 AES key blob with header.
  */
@@ -664,8 +708,9 @@ EXPORT_SYMBOL(ep11_get_domain_info);
  */
 #define KEY_ATTR_DEFAULTS 0x00200c00
 
-int ep11_genaeskey(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
-		   u8 *keybuf, size_t *keybufsize)
+static int _ep11_genaeskey(u16 card, u16 domain,
+			   u32 keybitsize, u32 keygenflags,
+			   u8 *keybuf, size_t *keybufsize)
 {
 	struct keygen_req_pl {
 		struct pl_head head;
@@ -701,7 +746,6 @@ int ep11_genaeskey(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
 	struct ep11_cprb *req = NULL, *rep = NULL;
 	struct ep11_target_dev target;
 	struct ep11_urb *urb = NULL;
-	struct ep11keyblob *kb;
 	int api, rc = -ENOMEM;
 
 	switch (keybitsize) {
@@ -780,14 +824,9 @@ int ep11_genaeskey(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
 		goto out;
 	}
 
-	/* copy key blob and set header values */
+	/* copy key blob */
 	memcpy(keybuf, rep_pl->data, rep_pl->data_len);
 	*keybufsize = rep_pl->data_len;
-	kb = (struct ep11keyblob *)keybuf;
-	kb->head.type = TOKTYPE_NON_CCA;
-	kb->head.len = rep_pl->data_len;
-	kb->head.version = TOKVER_EP11_AES;
-	kb->head.bitlen = keybitsize;
 
 out:
 	kfree(req);
@@ -795,6 +834,43 @@ int ep11_genaeskey(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
 	kfree(urb);
 	return rc;
 }
+
+int ep11_genaeskey(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
+		   u8 *keybuf, size_t *keybufsize, u32 keybufver)
+{
+	struct ep11kblob_header *hdr;
+	size_t hdr_size, pl_size;
+	u8 *pl;
+	int rc;
+
+	switch (keybufver) {
+	case TOKVER_EP11_AES:
+	case TOKVER_EP11_AES_WITH_HEADER:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	rc = ep11_kb_split(keybuf, *keybufsize, keybufver,
+			   &hdr, &hdr_size, &pl, &pl_size);
+	if (rc)
+		return rc;
+
+	rc = _ep11_genaeskey(card, domain, keybitsize, keygenflags,
+			     pl, &pl_size);
+	if (rc)
+		return rc;
+
+	*keybufsize = hdr_size + pl_size;
+
+	/* update header information */
+	hdr->type = TOKTYPE_NON_CCA;
+	hdr->len = *keybufsize;
+	hdr->version = keybufver;
+	hdr->bitlen = keybitsize;
+
+	return 0;
+}
 EXPORT_SYMBOL(ep11_genaeskey);
 
 static int ep11_cryptsingle(u16 card, u16 domain,
@@ -1201,7 +1277,6 @@ int ep11_clr2keyblob(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
 		     const u8 *clrkey, u8 *keybuf, size_t *keybufsize)
 {
 	int rc;
-	struct ep11keyblob *kb;
 	u8 encbuf[64], *kek = NULL;
 	size_t clrkeylen, keklen, encbuflen = sizeof(encbuf);
 
@@ -1223,17 +1298,15 @@ int ep11_clr2keyblob(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
 	}
 
 	/* Step 1: generate AES 256 bit random kek key */
-	rc = ep11_genaeskey(card, domain, 256,
-			    0x00006c00, /* EN/DECRYPT, WRAP/UNWRAP */
-			    kek, &keklen);
+	rc = _ep11_genaeskey(card, domain, 256,
+			     0x00006c00, /* EN/DECRYPT, WRAP/UNWRAP */
+			     kek, &keklen);
 	if (rc) {
 		DEBUG_ERR(
 			"%s generate kek key failed, rc=%d\n",
 			__func__, rc);
 		goto out;
 	}
-	kb = (struct ep11keyblob *)kek;
-	memset(&kb->head, 0, sizeof(kb->head));
 
 	/* Step 2: encrypt clear key value with the kek key */
 	rc = ep11_cryptsingle(card, domain, 0, 0, def_iv, kek, keklen,
diff --git a/drivers/s390/crypto/zcrypt_ep11misc.h b/drivers/s390/crypto/zcrypt_ep11misc.h
index 67cc80d71ba3b..2eecbd7be6e5e 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.h
+++ b/drivers/s390/crypto/zcrypt_ep11misc.h
@@ -107,7 +107,7 @@ int ep11_get_domain_info(u16 card, u16 domain, struct ep11_domain_info *info);
  * Generate (random) EP11 AES secure key.
  */
 int ep11_genaeskey(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
-		   u8 *keybuf, size_t *keybufsize);
+		   u8 *keybuf, size_t *keybufsize, u32 keybufver);
 
 /*
  * Generate EP11 AES secure key with given clear key value.
-- 
2.40.1




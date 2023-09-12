Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C3379BFB8
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239280AbjIKUys (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238288AbjIKNxW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:53:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5684BE40
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:53:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953C7C433C8;
        Mon, 11 Sep 2023 13:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440397;
        bh=dy9WiKsuhmVIiRk9kM27qsiOjVWtcNuzP84a2XzZPGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gyt1YAW18NR3uY7dR2NcKlufrD11VKEUJJ0Q2oQi04YbpR7wuNhDVrNUHSpiDPSom
         2J+Py0QaAp21zitFICceSxvyuNbsw/v1z2Tem2grXIgh6sgHAsgPfoYsSLnLlmNHmG
         g2LszUhr0yY2ACDv3lc33sOjjgyhp2/1R+YLAAsQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Holger Dengler <dengler@linux.ibm.com>,
        Ingo Franzki <ifranzki@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 046/739] s390/pkey: fix PKEY_TYPE_EP11_AES handling in PKEY_CLR2SECK2 IOCTL
Date:   Mon, 11 Sep 2023 15:37:25 +0200
Message-ID: <20230911134652.406686569@linuxfoundation.org>
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

[ Upstream commit da2863f15945de100b95c72d5656541d30956c5d ]

Commit 'fa6999e326fe ("s390/pkey: support CCA and EP11 secure ECC
private keys")' introduced PKEY_TYPE_EP11_AES for the PKEY_CLR2SECK2
IOCTL to convert an AES clearkey into a securekey of this type.
Unfortunately, all PKEY_CLR2SECK2 IOCTL requests with type
PKEY_TYPE_EP11_AES return with an error (-EINVAL). Fix the handling
for PKEY_TYPE_EP11_AES in PKEY_CLR2SECK2 IOCTL, so that userspace can
convert clearkey blobs into PKEY_TYPE_EP11_AES securekey blobs.

Cc: stable@vger.kernel.org # v5.10+
Fixes: fa6999e326fe ("s390/pkey: support CCA and EP11 secure ECC private keys")
Signed-off-by: Holger Dengler <dengler@linux.ibm.com>
Reviewed-by: Ingo Franzki <ifranzki@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Stable-dep-of: d1fdfb0b2f33 ("s390/pkey: fix PKEY_TYPE_EP11_AES handling in PKEY_KBLOB2PROTK[23]")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/crypto/pkey_api.c        | 16 +++++--
 drivers/s390/crypto/zcrypt_ep11misc.c | 61 ++++++++++++++++++++-------
 drivers/s390/crypto/zcrypt_ep11misc.h |  3 +-
 3 files changed, 60 insertions(+), 20 deletions(-)

diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index 2661d6a9ea131..7543757c82e2e 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -272,7 +272,8 @@ static int pkey_clr2ep11key(const u8 *clrkey, size_t clrkeylen,
 		card = apqns[i] >> 16;
 		dom = apqns[i] & 0xFFFF;
 		rc = ep11_clr2keyblob(card, dom, clrkeylen * 8,
-				      0, clrkey, keybuf, keybuflen);
+				      0, clrkey, keybuf, keybuflen,
+				      PKEY_TYPE_EP11);
 		if (rc == 0)
 			break;
 	}
@@ -775,6 +776,11 @@ static int pkey_clr2seckey2(const struct pkey_apqn *apqns, size_t nr_apqns,
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
@@ -793,9 +799,11 @@ static int pkey_clr2seckey2(const struct pkey_apqn *apqns, size_t nr_apqns,
 	for (i = 0, rc = -ENODEV; i < nr_apqns; i++) {
 		card = apqns[i].card;
 		dom = apqns[i].domain;
-		if (ktype == PKEY_TYPE_EP11) {
+		if (ktype == PKEY_TYPE_EP11 ||
+		    ktype == PKEY_TYPE_EP11_AES) {
 			rc = ep11_clr2keyblob(card, dom, ksize, kflags,
-					      clrkey, keybuf, keybufsize);
+					      clrkey, keybuf, keybufsize,
+					      ktype);
 		} else if (ktype == PKEY_TYPE_CCA_DATA) {
 			rc = cca_clr2seckey(card, dom, ksize,
 					    clrkey, keybuf);
@@ -1514,7 +1522,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 		apqns = _copy_apqns_from_user(kcs.apqns, kcs.apqn_entries);
 		if (IS_ERR(apqns))
 			return PTR_ERR(apqns);
-		kkey = kmalloc(klen, GFP_KERNEL);
+		kkey = kzalloc(klen, GFP_KERNEL);
 		if (!kkey) {
 			kfree(apqns);
 			return -ENOMEM;
diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
index 51f6753e01c50..355d30bc0aac8 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.c
+++ b/drivers/s390/crypto/zcrypt_ep11misc.c
@@ -1000,12 +1000,12 @@ static int ep11_cryptsingle(u16 card, u16 domain,
 	return rc;
 }
 
-static int ep11_unwrapkey(u16 card, u16 domain,
-			  const u8 *kek, size_t keksize,
-			  const u8 *enckey, size_t enckeysize,
-			  u32 mech, const u8 *iv,
-			  u32 keybitsize, u32 keygenflags,
-			  u8 *keybuf, size_t *keybufsize)
+static int _ep11_unwrapkey(u16 card, u16 domain,
+			   const u8 *kek, size_t keksize,
+			   const u8 *enckey, size_t enckeysize,
+			   u32 mech, const u8 *iv,
+			   u32 keybitsize, u32 keygenflags,
+			   u8 *keybuf, size_t *keybufsize)
 {
 	struct uw_req_pl {
 		struct pl_head head;
@@ -1042,7 +1042,6 @@ static int ep11_unwrapkey(u16 card, u16 domain,
 	struct ep11_cprb *req = NULL, *rep = NULL;
 	struct ep11_target_dev target;
 	struct ep11_urb *urb = NULL;
-	struct ep11keyblob *kb;
 	size_t req_pl_size;
 	int api, rc = -ENOMEM;
 	u8 *p;
@@ -1124,14 +1123,9 @@ static int ep11_unwrapkey(u16 card, u16 domain,
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
@@ -1140,6 +1134,42 @@ static int ep11_unwrapkey(u16 card, u16 domain,
 	return rc;
 }
 
+static int ep11_unwrapkey(u16 card, u16 domain,
+			  const u8 *kek, size_t keksize,
+			  const u8 *enckey, size_t enckeysize,
+			  u32 mech, const u8 *iv,
+			  u32 keybitsize, u32 keygenflags,
+			  u8 *keybuf, size_t *keybufsize,
+			  u8 keybufver)
+{
+	struct ep11kblob_header *hdr;
+	size_t hdr_size, pl_size;
+	u8 *pl;
+	int rc;
+
+	rc = ep11_kb_split(keybuf, *keybufsize, keybufver,
+			   &hdr, &hdr_size, &pl, &pl_size);
+	if (rc)
+		return rc;
+
+	rc = _ep11_unwrapkey(card, domain, kek, keksize, enckey, enckeysize,
+			     mech, iv, keybitsize, keygenflags,
+			     pl, &pl_size);
+	if (rc)
+		return rc;
+
+	*keybufsize = hdr_size + pl_size;
+
+	/* update header information */
+	hdr = (struct ep11kblob_header *)keybuf;
+	hdr->type = TOKTYPE_NON_CCA;
+	hdr->len = *keybufsize;
+	hdr->version = keybufver;
+	hdr->bitlen = keybitsize;
+
+	return 0;
+}
+
 static int ep11_wrapkey(u16 card, u16 domain,
 			const u8 *key, size_t keysize,
 			u32 mech, const u8 *iv,
@@ -1274,7 +1304,8 @@ static int ep11_wrapkey(u16 card, u16 domain,
 }
 
 int ep11_clr2keyblob(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
-		     const u8 *clrkey, u8 *keybuf, size_t *keybufsize)
+		     const u8 *clrkey, u8 *keybuf, size_t *keybufsize,
+		     u32 keytype)
 {
 	int rc;
 	u8 encbuf[64], *kek = NULL;
@@ -1321,7 +1352,7 @@ int ep11_clr2keyblob(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
 	/* Step 3: import the encrypted key value as a new key */
 	rc = ep11_unwrapkey(card, domain, kek, keklen,
 			    encbuf, encbuflen, 0, def_iv,
-			    keybitsize, 0, keybuf, keybufsize);
+			    keybitsize, 0, keybuf, keybufsize, keytype);
 	if (rc) {
 		DEBUG_ERR(
 			"%s importing key value as new key failed,, rc=%d\n",
diff --git a/drivers/s390/crypto/zcrypt_ep11misc.h b/drivers/s390/crypto/zcrypt_ep11misc.h
index 2eecbd7be6e5e..b611cf64231d5 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.h
+++ b/drivers/s390/crypto/zcrypt_ep11misc.h
@@ -113,7 +113,8 @@ int ep11_genaeskey(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
  * Generate EP11 AES secure key with given clear key value.
  */
 int ep11_clr2keyblob(u16 cardnr, u16 domain, u32 keybitsize, u32 keygenflags,
-		     const u8 *clrkey, u8 *keybuf, size_t *keybufsize);
+		     const u8 *clrkey, u8 *keybuf, size_t *keybufsize,
+		     u32 keytype);
 
 /*
  * Build a list of ep11 apqns meeting the following constrains:
-- 
2.40.1




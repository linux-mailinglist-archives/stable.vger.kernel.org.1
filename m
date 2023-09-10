Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DA4799DAF
	for <lists+stable@lfdr.de>; Sun, 10 Sep 2023 12:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235834AbjIJKf1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 10 Sep 2023 06:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346592AbjIJKf1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 10 Sep 2023 06:35:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E40CDA
        for <stable@vger.kernel.org>; Sun, 10 Sep 2023 03:35:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E063C433C7;
        Sun, 10 Sep 2023 10:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694342122;
        bh=F1a/t7AyQxAVkuPtoXXY8suEhSBfRfO315BH6KfGC4k=;
        h=Subject:To:Cc:From:Date:From;
        b=tXz3PPR+s8Hcm/vrENjROQqgSvynnDY1le1XpUcmkHM6yNXA8WDsvx15G1VNFl2IT
         rdJpBZOiZdTsfBuZiC5QAJcQtJ2AB+y8VhD19oWdc7y4/cwAhIIOqKToEaHJI2oE/l
         NQeH5Pp2CTssl2ZcbcKiq9CzKeoVMLMb/7uTi92I=
Subject: FAILED: patch "[PATCH] s390/pkey: fix PKEY_TYPE_EP11_AES handling in PKEY_CLR2SECK2" failed to apply to 5.15-stable tree
To:     dengler@linux.ibm.com, hca@linux.ibm.com, ifranzki@linux.ibm.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 10 Sep 2023 11:22:07 +0100
Message-ID: <2023091007-protract-hummus-2232@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x da2863f15945de100b95c72d5656541d30956c5d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091007-protract-hummus-2232@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From da2863f15945de100b95c72d5656541d30956c5d Mon Sep 17 00:00:00 2001
From: Holger Dengler <dengler@linux.ibm.com>
Date: Tue, 25 Jul 2023 11:24:47 +0200
Subject: [PATCH] s390/pkey: fix PKEY_TYPE_EP11_AES handling in PKEY_CLR2SECK2
 IOCTL

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

diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index 2661d6a9ea13..7543757c82e2 100644
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
index 51f6753e01c5..355d30bc0aac 100644
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
index 2eecbd7be6e5..b611cf64231d 100644
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


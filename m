Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3C179BB80
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245623AbjIKVLM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241443AbjIKPIu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:08:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE77FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:08:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9362C433C8;
        Mon, 11 Sep 2023 15:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444926;
        bh=DZ/Dd3srd0wRNzvLTG6LrWf3rpmmH+umQQ5pVsreoso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0eo4JH3M0eMpTqrEGNQsgrNJmRXpwOCDROI1Eanks5K55qwljF/UKpsypNrKJHS50
         WfTMWUEeLbWjnGXNhSoALsNmMfj22XKtXnFkssJpmOFygoQP+HZsH58inZfbKTSmk4
         60aDUKT7tsuWwrLYM00FKjHbP8Wa1aICiFjCvUzQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Holger Dengler <dengler@linux.ibm.com>,
        Ingo Franzki <ifranzki@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 126/600] s390/pkey: fix PKEY_TYPE_EP11_AES handling for sysfs attributes
Date:   Mon, 11 Sep 2023 15:42:39 +0200
Message-ID: <20230911134637.335245023@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Holger Dengler <dengler@linux.ibm.com>

[ Upstream commit b9352e4b9b9eff949bcc6907b8569b3a1d992f1e ]

Commit 'fa6999e326fe ("s390/pkey: support CCA and EP11 secure ECC
private keys")' introduced a new PKEY_TYPE_EP11_AES securekey type as
a supplement to the existing PKEY_TYPE_EP11 (which won't work in
environments with session-bound keys). The pkey EP11 securekey
attributes use PKEY_TYPE_EP11_AES (instead of PKEY_TYPE_EP11)
keyblobs, to make the generated keyblobs usable also in environments,
where session-bound keys are required.

There should be no negative impacts to userspace because the internal
structure of the keyblobs is opaque. The increased size of the
generated keyblobs is reflected by the changed size of the attributes.

Fixes: fa6999e326fe ("s390/pkey: support CCA and EP11 secure ECC private keys")
Signed-off-by: Holger Dengler <dengler@linux.ibm.com>
Reviewed-by: Ingo Franzki <ifranzki@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/include/uapi/asm/pkey.h | 2 +-
 drivers/s390/crypto/pkey_api.c    | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/uapi/asm/pkey.h b/arch/s390/include/uapi/asm/pkey.h
index 924b876f992c1..29c6fd369761e 100644
--- a/arch/s390/include/uapi/asm/pkey.h
+++ b/arch/s390/include/uapi/asm/pkey.h
@@ -26,7 +26,7 @@
 #define MAXCLRKEYSIZE	32	   /* a clear key value may be up to 32 bytes */
 #define MAXAESCIPHERKEYSIZE 136  /* our aes cipher keys have always 136 bytes */
 #define MINEP11AESKEYBLOBSIZE 256  /* min EP11 AES key blob size  */
-#define MAXEP11AESKEYBLOBSIZE 320  /* max EP11 AES key blob size */
+#define MAXEP11AESKEYBLOBSIZE 336  /* max EP11 AES key blob size */
 
 /* Minimum size of a key blob */
 #define MINKEYBLOBSIZE	SECKEYBLOBSIZE
diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index 79568da580c67..2b92ec20ed68e 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -1947,7 +1947,7 @@ static struct attribute_group ccacipher_attr_group = {
  * (i.e. off != 0 or count < key blob size) -EINVAL is returned.
  * This function and the sysfs attributes using it provide EP11 key blobs
  * padded to the upper limit of MAXEP11AESKEYBLOBSIZE which is currently
- * 320 bytes.
+ * 336 bytes.
  */
 static ssize_t pkey_ep11_aes_attr_read(enum pkey_key_size keybits,
 				       bool is_xts, char *buf, loff_t off,
@@ -1976,7 +1976,7 @@ static ssize_t pkey_ep11_aes_attr_read(enum pkey_key_size keybits,
 		card = apqns[i] >> 16;
 		dom = apqns[i] & 0xFFFF;
 		rc = ep11_genaeskey(card, dom, keybits, 0, buf, &keysize,
-				    PKEY_TYPE_EP11);
+				    PKEY_TYPE_EP11_AES);
 		if (rc == 0)
 			break;
 	}
@@ -1987,7 +1987,7 @@ static ssize_t pkey_ep11_aes_attr_read(enum pkey_key_size keybits,
 		keysize = MAXEP11AESKEYBLOBSIZE;
 		buf += MAXEP11AESKEYBLOBSIZE;
 		rc = ep11_genaeskey(card, dom, keybits, 0, buf, &keysize,
-				    PKEY_TYPE_EP11);
+				    PKEY_TYPE_EP11_AES);
 		if (rc == 0)
 			return 2 * MAXEP11AESKEYBLOBSIZE;
 	}
-- 
2.40.1




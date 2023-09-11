Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651D979B0AD
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355247AbjIKV5h (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238307AbjIKNxr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:53:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5257CCF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:53:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB49C433C7;
        Mon, 11 Sep 2023 13:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440422;
        bh=u2mAFRkqG0LaPcxyd8hGcM31BgmaXykQ2wzdQ8+trCc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BBzDtfdTjMQLLMHXVf7eAWj2U/WtZiCzlw6jVDZiJy2HaSP0OL1DKvHNAaNQQGRH9
         q1IylU4U8GrTC5/Ey8OevmyjQHDyQiTM0cY7PQLCqg6je36DgjIhwqiMcZgLSbpapF
         2IC095yl0cutVdzRke51Nx9z9AT/TJot7zPpk3LM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Holger Dengler <dengler@linux.ibm.com>,
        Ingo Franzki <ifranzki@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 048/739] s390/pkey: fix PKEY_TYPE_EP11_AES handling in PKEY_VERIFYKEY2 IOCTL
Date:   Mon, 11 Sep 2023 15:37:27 +0200
Message-ID: <20230911134652.462107024@linuxfoundation.org>
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

[ Upstream commit 745742dbca11a1b63684ec7032a81aaedcf51fb0 ]

Commit 'fa6999e326fe ("s390/pkey: support CCA and EP11 secure ECC
private keys")' introduced a new PKEY_TYPE_EP11_AES type for the
PKEY_VERIFYKEY2 IOCTL to verify keyblobs of this type. Unfortunately,
all PKEY_VERIFYKEY2 IOCTL requests with keyblobs of this type return
with an error (-EINVAL). Fix PKEY_TYPE_EP11_AES handling in
PKEY_VERIFYKEY2 IOCTL, so that userspace can verify keyblobs of this
type.

Fixes: fa6999e326fe ("s390/pkey: support CCA and EP11 secure ECC private keys")
Signed-off-by: Holger Dengler <dengler@linux.ibm.com>
Reviewed-by: Ingo Franzki <ifranzki@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/crypto/pkey_api.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index 75d7f0d5f14ef..8d6f35ccc561d 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -912,7 +912,8 @@ static int pkey_verifykey2(const u8 *key, size_t keylen,
 			*ksize = kb->head.bitlen;
 
 		rc = ep11_findcard2(&_apqns, &_nr_apqns, *cardnr, *domain,
-				    ZCRYPT_CEX7, EP11_API_V, kb->wkvp);
+				    ZCRYPT_CEX7, EP11_API_V,
+				    ep11_kb_wkvp(key, keylen));
 		if (rc)
 			goto out;
 
@@ -922,6 +923,30 @@ static int pkey_verifykey2(const u8 *key, size_t keylen,
 		*cardnr = ((struct pkey_apqn *)_apqns)->card;
 		*domain = ((struct pkey_apqn *)_apqns)->domain;
 
+	} else if (hdr->type == TOKTYPE_NON_CCA &&
+		   hdr->version == TOKVER_EP11_AES_WITH_HEADER) {
+		struct ep11kblob_header *kh = (struct ep11kblob_header *)key;
+
+		rc = ep11_check_aes_key_with_hdr(debug_info, 3,
+						 key, keylen, 1);
+		if (rc)
+			goto out;
+		if (ktype)
+			*ktype = PKEY_TYPE_EP11_AES;
+		if (ksize)
+			*ksize = kh->bitlen;
+
+		rc = ep11_findcard2(&_apqns, &_nr_apqns, *cardnr, *domain,
+				    ZCRYPT_CEX7, EP11_API_V,
+				    ep11_kb_wkvp(key, keylen));
+		if (rc)
+			goto out;
+
+		if (flags)
+			*flags = PKEY_FLAGS_MATCH_CUR_MKVP;
+
+		*cardnr = ((struct pkey_apqn *)_apqns)->card;
+		*domain = ((struct pkey_apqn *)_apqns)->domain;
 	} else {
 		rc = -EINVAL;
 	}
-- 
2.40.1




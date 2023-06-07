Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99F0726E71
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbjFGUum (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235571AbjFGUuJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:50:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F013F1FEE
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:49:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE3C6646C9
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:49:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1CC4C433D2;
        Wed,  7 Jun 2023 20:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170992;
        bh=vR3gdLk2lwQFpq5DKF6oeHeq/xHoQob/o2RETl2k0ow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zWkCCDncG6qxVVv2gjfj0b6Os4LovxMlX0vaGnAlt9mGQDFoYSSG9vTQTse9R/qWk
         9sJG4R+IeXMLthUdh2TjgG8dLbGoI7V+a9ZgWVdMWvX8Dqu2Z0AgAm/FUXYSVpLhs2
         cdoLnqEvaCBoPHt+b/EIrCI5b1oekTAZ/nOozvz4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 062/120] s390/pkey: zeroize key blobs
Date:   Wed,  7 Jun 2023 22:16:18 +0200
Message-ID: <20230607200902.837657997@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200900.915613242@linuxfoundation.org>
References: <20230607200900.915613242@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Holger Dengler <dengler@linux.ibm.com>

[ Upstream commit 844cf829e5f33e00b279230470c8c93b58b8c16f ]

Key blobs for the IOCTLs PKEY_KBLOB2PROTK[23] may contain clear key
material. Zeroize the copies of these keys in kernel memory after
creating the protected key.

Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
Signed-off-by: Holger Dengler <dengler@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/crypto/pkey_api.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index dd84995049b91..870e00effe439 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -1271,6 +1271,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 			return PTR_ERR(kkey);
 		rc = pkey_keyblob2pkey(kkey, ktp.keylen, &ktp.protkey);
 		DEBUG_DBG("%s pkey_keyblob2pkey()=%d\n", __func__, rc);
+		memzero_explicit(kkey, ktp.keylen);
 		kfree(kkey);
 		if (rc)
 			break;
@@ -1404,6 +1405,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 					kkey, ktp.keylen, &ktp.protkey);
 		DEBUG_DBG("%s pkey_keyblob2pkey2()=%d\n", __func__, rc);
 		kfree(apqns);
+		memzero_explicit(kkey, ktp.keylen);
 		kfree(kkey);
 		if (rc)
 			break;
@@ -1530,6 +1532,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 					protkey, &protkeylen);
 		DEBUG_DBG("%s pkey_keyblob2pkey3()=%d\n", __func__, rc);
 		kfree(apqns);
+		memzero_explicit(kkey, ktp.keylen);
 		kfree(kkey);
 		if (rc) {
 			kfree(protkey);
-- 
2.39.2




Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FBC7A37AF
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239483AbjIQTXq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239521AbjIQTX3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:23:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFF5D9
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:23:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4DBC433C8;
        Sun, 17 Sep 2023 19:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694978603;
        bh=Mj0MdEFh8/6JtpIkZSFpS48jVyD0msraU27pIKb7hX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K3zFs6Vt8Vdn5yg5Lt1AogARuLGDKRAjnxU5OqpAEfPFB9/aNd4Ax+zPJx1atXg6t
         6Pjl5Lo8gG+GCKJzBXtlGCIx/WRr/SDhy13N3FEYJSEmrq6mnMxD2iyqAyiJqHvGiO
         I9Pt1z2eTgqVwmxHYQX5oEgir9280ePsP0GZ3Sdk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Holger Dengler <dengler@linux.ibm.com>,
        Ingo Franzki <ifranzki@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 079/406] s390/paes: fix PKEY_TYPE_EP11_AES handling for secure keyblobs
Date:   Sun, 17 Sep 2023 21:08:53 +0200
Message-ID: <20230917191103.218091505@linuxfoundation.org>
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

[ Upstream commit cba33db3fc4dbf2e54294b0e499d2335a3a00d78 ]

Commit 'fa6999e326fe ("s390/pkey: support CCA and EP11 secure ECC
private keys")' introduced PKEY_TYPE_EP11_AES securekey blobs as a
supplement to the PKEY_TYPE_EP11 (which won't work in environments
with session-bound keys). This new keyblobs has a different maximum
size, so fix paes crypto module to accept also these larger keyblobs.

Fixes: fa6999e326fe ("s390/pkey: support CCA and EP11 secure ECC private keys")
Signed-off-by: Holger Dengler <dengler@linux.ibm.com>
Reviewed-by: Ingo Franzki <ifranzki@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/crypto/paes_s390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
index f3caeb17c85b9..a6727ad58d65a 100644
--- a/arch/s390/crypto/paes_s390.c
+++ b/arch/s390/crypto/paes_s390.c
@@ -34,7 +34,7 @@
  * and padding is also possible, the limits need to be generous.
  */
 #define PAES_MIN_KEYSIZE 16
-#define PAES_MAX_KEYSIZE 320
+#define PAES_MAX_KEYSIZE MAXEP11AESKEYBLOBSIZE
 
 static u8 *ctrblk;
 static DEFINE_MUTEX(ctrblk_lock);
-- 
2.40.1




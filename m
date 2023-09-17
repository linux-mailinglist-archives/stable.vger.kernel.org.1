Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854177A3995
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240098AbjIQTvb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240144AbjIQTvR (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:51:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA1B12F
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:51:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E0EFC433C7;
        Sun, 17 Sep 2023 19:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980272;
        bh=+xTgfJqyqiPqjCdIVVFzWNs5GFP6/s1im2zgckiZ36A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s0DjprpNsrXfRBIYNT84Q/h1diZVUuT/okq7zVxNknS40c7SAZStpURGjKioLubfZ
         QmVd2KFFKhJ1Qpj4kfq+jK2P/x5QBPZu+R702j2FGQM8zcVd7N4o68fyeD7riZVQuq
         2PYmO5iejgy1fPvIvyAscYDiA5+yu2xiH3qIcfco=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 144/285] s390/zcrypt: dont leak memory if dev_set_name() fails
Date:   Sun, 17 Sep 2023 21:12:24 +0200
Message-ID: <20230917191056.666756677@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 6252f47b78031979ad919f971dc8468b893488bd ]

When dev_set_name() fails, zcdn_create() doesn't free the newly
allocated resources. Do it.

Fixes: 00fab2350e6b ("s390/zcrypt: multiple zcrypt device nodes support")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20230831110000.24279-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/crypto/zcrypt_api.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index 4b23c9f7f3e54..6b99f7dd06433 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -413,6 +413,7 @@ static int zcdn_create(const char *name)
 			 ZCRYPT_NAME "_%d", (int)MINOR(devt));
 	nodename[sizeof(nodename) - 1] = '\0';
 	if (dev_set_name(&zcdndev->device, nodename)) {
+		kfree(zcdndev);
 		rc = -EINVAL;
 		goto unlockout;
 	}
-- 
2.40.1




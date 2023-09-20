Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E8D7A80CB
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236118AbjITMkg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236433AbjITMkP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:40:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F048F
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:40:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E762C433C9;
        Wed, 20 Sep 2023 12:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213608;
        bh=2nRUaTV2oo2/5Pm70mVlJLqePYua6lk2eRD9fPP7n2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=euVtOM+luDhsjFGOEoP57QrShIdiEoWEToVYSkKRB3BBQiHO33UF3N330/uBW00FV
         GOKegsYH6CHPk8jvPz8Rpzwl/CfxdMq5YfIttdwIcZsr/ngJiEloJonsLge/ZKGWsB
         mGBFmyu8hftqN0Wl6+i+TXinJmvCf2e+q5eY5oR0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 273/367] s390/zcrypt: dont leak memory if dev_set_name() fails
Date:   Wed, 20 Sep 2023 13:30:50 +0200
Message-ID: <20230920112905.631426826@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

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
index ec41a8a76398c..f376dfcd7dbeb 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -397,6 +397,7 @@ static int zcdn_create(const char *name)
 			 ZCRYPT_NAME "_%d", (int) MINOR(devt));
 	nodename[sizeof(nodename)-1] = '\0';
 	if (dev_set_name(&zcdndev->device, nodename)) {
+		kfree(zcdndev);
 		rc = -EINVAL;
 		goto unlockout;
 	}
-- 
2.40.1




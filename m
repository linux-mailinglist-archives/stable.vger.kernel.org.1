Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E5F7ECEE4
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbjKOTpB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235183AbjKOTpA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:45:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221BD189
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:44:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E4BC433D9;
        Wed, 15 Nov 2023 19:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077496;
        bh=Nbq5xno+3vAfUvCm/NpGZQJPoCSaRmXJpwGsPqpysHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=omsyQ7dNePgUczgTors5OTnagRL/R3PQNHulbyrTImSVrYHeHU6332zjDClfsO5hI
         +DPja4NvTqL9Mvr79uqrDu3EqUuWDl1lDYABoMZOlxwDkpKzisJNUUU3NL+m+BrsnT
         oyaZvnu/+eH/U0+br4Vo88EaOP2u4TM6gQROyXq0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 338/603] crypto: ccp - Get a free page to use while fetching initial nonce
Date:   Wed, 15 Nov 2023 14:14:43 -0500
Message-ID: <20231115191636.922568889@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 53f7f779f45cbe1771bc4ae05f0320e204a18611 ]

dbc_dev_init() gets a free page from `GFP_KERNEL`, but if that page has
any data in it the first nonce request will fail.
This prevents dynamic boost control from probing. To fix this, explicitly
request a zeroed page with `__GFP_ZERO` to ensure first nonce fetch works.

Fixes: c04cf9e14f10 ("crypto: ccp - Add support for fetching a nonce for dynamic boost control")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/ccp/dbc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/ccp/dbc.c b/drivers/crypto/ccp/dbc.c
index 839ea14b9a853..6f33149ef80df 100644
--- a/drivers/crypto/ccp/dbc.c
+++ b/drivers/crypto/ccp/dbc.c
@@ -205,7 +205,7 @@ int dbc_dev_init(struct psp_device *psp)
 		return -ENOMEM;
 
 	BUILD_BUG_ON(sizeof(union dbc_buffer) > PAGE_SIZE);
-	dbc_dev->mbox = (void *)devm_get_free_pages(dev, GFP_KERNEL, 0);
+	dbc_dev->mbox = (void *)devm_get_free_pages(dev, GFP_KERNEL | __GFP_ZERO, 0);
 	if (!dbc_dev->mbox) {
 		ret = -ENOMEM;
 		goto cleanup_dev;
-- 
2.42.0




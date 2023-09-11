Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D612479B8DD
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbjIKWsZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240999AbjIKO7W (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:59:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1301B9
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:59:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D1CC433C7;
        Mon, 11 Sep 2023 14:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444358;
        bh=TyXKBzDPyX+1LfhuRgM5Mq5C45oByi295AR6crWR8vo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PqJIYQQjtuXfKJ5Z6ounnUPa/W78BeZUhIF4epXofFx5PMAHU+WuRVkAMzwSwRh5d
         /v5Mx6L47W2GWlS6bU6ttas/KEFuD01oEpZlQ4gKO3a0upRKfF7T4KtMrXYukmSB1r
         JYpmRaMgMgbto6SEbd4xqivzQPKuAmnfA/QgqCMg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Frederick Lawler <fred@cloudflare.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 6.4 700/737] crypto: af_alg - Decrement struct key.usage in alg_set_by_key_serial()
Date:   Mon, 11 Sep 2023 15:49:19 +0200
Message-ID: <20230911134710.077434458@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Frederick Lawler <fred@cloudflare.com>

commit 6b4b53ca0b7300ba2af98a49dbce22054bf034fe upstream.

Calls to lookup_user_key() require a corresponding key_put() to
decrement the usage counter. Once it reaches zero, we schedule key GC.
Therefore decrement struct key.usage in alg_set_by_key_serial().

Fixes: 7984ceb134bf ("crypto: af_alg - Support symmetric encryption via keyring keys")
Cc: <stable@vger.kernel.org>
Signed-off-by: Frederick Lawler <fred@cloudflare.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 crypto/af_alg.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -320,18 +320,21 @@ static int alg_setkey_by_key_serial(stru
 
 	if (IS_ERR(ret)) {
 		up_read(&key->sem);
+		key_put(key);
 		return PTR_ERR(ret);
 	}
 
 	key_data = sock_kmalloc(&ask->sk, key_datalen, GFP_KERNEL);
 	if (!key_data) {
 		up_read(&key->sem);
+		key_put(key);
 		return -ENOMEM;
 	}
 
 	memcpy(key_data, ret, key_datalen);
 
 	up_read(&key->sem);
+	key_put(key);
 
 	err = type->setkey(ask->private, key_data, key_datalen);
 



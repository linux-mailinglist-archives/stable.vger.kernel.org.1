Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C2976B678
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 15:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbjHAN5Y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 09:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbjHAN5X (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 09:57:23 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86147E4
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 06:57:18 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-78360f61ba0so259139239f.1
        for <stable@vger.kernel.org>; Tue, 01 Aug 2023 06:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1690898238; x=1691503038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V63lX8jJADmT+x3ehocFhAwNy3zEROKPKQmkKeMAkns=;
        b=XisN9mTlhuU084244jOxq6rmViLU82rCKFQtm0CjqcgougXjSCdQGow1jYSz+tRjh8
         lxKt+UFf9ri4gIjw4gO7pdos4kpYqyVdP8WGa7uZobSlzhZpe8z0+qtU+O/07MtbRbD1
         MvcryH0sBl7lUx4XFlKiVasvyU+Y3XSotWELQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690898238; x=1691503038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V63lX8jJADmT+x3ehocFhAwNy3zEROKPKQmkKeMAkns=;
        b=gptkubNWKoz6OoRUtrtq6NIlIpciBR4frxS8a3fxbjJ+YGHUAPqUCd/JFL2/erXH56
         XFYFPnTSYRDwijQZN4bhcUqWW5IvPrFJMcgW8PHwDupOamEzzpVCQblr0c6diaPpDJsV
         HnIt8TBjkculYY39PmRIi8Jrwdg17+oJgMTkPaXWn5e4CuyxkA9wfuSnGqlxQDk+nOKm
         DXuREJl2E1mWjww2vQaaGzDG8ge/IZhrFpjvWsyrbtqzS9lhFW+aVf90lEhY5IiY1rKf
         1U/hgGasXI3zAvdkoBn6PIBAOaFd+m5cHoZ1Yu91TPE+9Nx2ntSLyjRFHjov4HzeuVkV
         2kWQ==
X-Gm-Message-State: ABy/qLaozQ5WKuxkZV/WFAgfep1IaK3kYLCpZaQS9liRGVlCO1CFuB3m
        j1nxcjfTFQSmjUY3J5+biDhysg==
X-Google-Smtp-Source: APBJJlE0JBSqcsLqZVUTUAYd4lW88JFS1i1F/6t/hSUtRBVdBJ48IvYgSaIlxoMu/WxqEfcFjgW2LQ==
X-Received: by 2002:a92:c9c3:0:b0:348:f28d:d06 with SMTP id k3-20020a92c9c3000000b00348f28d0d06mr5261388ilq.31.1690898237863;
        Tue, 01 Aug 2023 06:57:17 -0700 (PDT)
Received: from CMGLRV3.. ([2a09:bac5:9478:4e6::7d:54])
        by smtp.gmail.com with ESMTPSA id x1-20020a92de01000000b00342f537e3c3sm3834793ilm.2.2023.08.01.06.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 06:57:17 -0700 (PDT)
From:   Frederick Lawler <fred@cloudflare.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Frederick Lawler <fred@cloudflare.com>,
        stable@vger.kernel.org
Subject: [PATCH] crypto: af_alg - Decrement struct key.usage in alg_set_by_key_serial()
Date:   Tue,  1 Aug 2023 08:57:09 -0500
Message-Id: <20230801135709.2218855-1-fred@cloudflare.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Calls to lookup_user_key() require a corresponding key_put() to
decrement the usage counter. Once it reaches zero, we schedule key GC.
Therefore decrement struct key.usage in alg_set_by_key_serial().

Fixes: 7984ceb134bf ("crypto: af_alg - Support symmetric encryption via keyring keys")
Cc: <stable@vger.kernel.org>
Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
This is rebased ontop of Linus's 6.5-rc1. Original patch was introduced in 6.2.
---
 crypto/af_alg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index 6218c773d71c..295ede1996a4 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -320,18 +320,21 @@ static int alg_setkey_by_key_serial(struct alg_sock *ask, sockptr_t optval,
 
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
 
-- 
2.34.1


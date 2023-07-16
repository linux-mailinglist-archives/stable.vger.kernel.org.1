Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3431D75561E
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbjGPUro (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbjGPUro (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:47:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEB3D9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:47:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C90EA60E2C
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:47:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCFCBC433C8;
        Sun, 16 Jul 2023 20:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540462;
        bh=9wUHqV2X2sdeCrpS+UNSLmXXTqCaWp+y1iS0yra1TFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0KzhcBvPFhquLsWSKI4+WqRW8vNJUsp2RAe+6J9NDgAOSkIuKgI+y6arpz0COxOg1
         uDvXe7+2HxuB4pshaCR426qOcBOGZ9ndhIajke7njQpuVycORxcNRuMP7HDb3oOMcb
         SzCjRk71vVVapPUssbcT06TsAbhpBCGK8tVzIHnY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Herbert Xu <herbert@gondor.apana.org.au>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 344/591] crypto: qat - Use helper to set reqsize
Date:   Sun, 16 Jul 2023 21:48:03 +0200
Message-ID: <20230716194932.811427039@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>

[ Upstream commit 80e62ad58db084920d8cf23323b713391e09f374 ]

The value of reqsize must only be changed through the helper.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: eb7713f5ca97 ("crypto: qat - unmap buffer before free for DH")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/qat/qat_common/qat_asym_algs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/qat_asym_algs.c b/drivers/crypto/qat/qat_common/qat_asym_algs.c
index 94a26702aeae1..935a7e012946e 100644
--- a/drivers/crypto/qat/qat_common/qat_asym_algs.c
+++ b/drivers/crypto/qat/qat_common/qat_asym_algs.c
@@ -494,6 +494,8 @@ static int qat_dh_init_tfm(struct crypto_kpp *tfm)
 	if (!inst)
 		return -EINVAL;
 
+	kpp_set_reqsize(tfm, sizeof(struct qat_asym_request) + 64);
+
 	ctx->p_size = 0;
 	ctx->g2 = false;
 	ctx->inst = inst;
@@ -1230,6 +1232,8 @@ static int qat_rsa_init_tfm(struct crypto_akcipher *tfm)
 	if (!inst)
 		return -EINVAL;
 
+	akcipher_set_reqsize(tfm, sizeof(struct qat_asym_request) + 64);
+
 	ctx->key_sz = 0;
 	ctx->inst = inst;
 	return 0;
@@ -1252,7 +1256,6 @@ static struct akcipher_alg rsa = {
 	.max_size = qat_rsa_max_size,
 	.init = qat_rsa_init_tfm,
 	.exit = qat_rsa_exit_tfm,
-	.reqsize = sizeof(struct qat_asym_request) + 64,
 	.base = {
 		.cra_name = "rsa",
 		.cra_driver_name = "qat-rsa",
@@ -1269,7 +1272,6 @@ static struct kpp_alg dh = {
 	.max_size = qat_dh_max_size,
 	.init = qat_dh_init_tfm,
 	.exit = qat_dh_exit_tfm,
-	.reqsize = sizeof(struct qat_asym_request) + 64,
 	.base = {
 		.cra_name = "dh",
 		.cra_driver_name = "qat-dh",
-- 
2.39.2




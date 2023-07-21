Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8236175D2A5
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbjGUTCD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjGUTCC (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:02:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F98130D0
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:02:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D918261D84
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:02:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E276AC433C7;
        Fri, 21 Jul 2023 19:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966120;
        bh=Wu6RO+w72wZbV4pMlzMZ3AHV9YOH2/poFvnStYIEdaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ce11XHVvbREgNptTuHAgB1Yylg+XtfsEx1Cgmt8i6nXkngXfeWlESq3lHlKO/eK3D
         KcasbVHn1ppE1s2s2wPqYe824e7Y5ycQUirvazwRVOpfMxBImXqaaXZAFGDNfhN2vG
         Qb1msbKSMQcNlim/jbwe9o3VGWNENhizu8xMmfc0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yoan Picchi <Yoan.Picchi@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Yoan Picchi <yoan.picchi@arm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 232/532] crypto: qat - replace get_current_node() with numa_node_id()
Date:   Fri, 21 Jul 2023 18:02:16 +0200
Message-ID: <20230721160626.958761474@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
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

From: Andre Przywara <andre.przywara@arm.com>

[ Upstream commit c2a1b91e47984e477298912ffd55570095d67318 ]

Currently the QAT driver code uses a self-defined wrapper function
called get_current_node() when it wants to learn the current NUMA node.
This implementation references the topology_physical_package_id[] array,
which more or less coincidentally contains the NUMA node id, at least
on x86.

Because this is not universal, and Linux offers a direct function to
learn the NUMA node ID, replace that function with a call to
numa_node_id(), which would work everywhere.

This fixes the QAT driver operation on arm64 machines.

Reported-by: Yoan Picchi <Yoan.Picchi@arm.com>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Yoan Picchi <yoan.picchi@arm.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: eb7713f5ca97 ("crypto: qat - unmap buffer before free for DH")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/qat/qat_common/adf_common_drv.h | 5 -----
 drivers/crypto/qat/qat_common/qat_algs.c       | 4 ++--
 drivers/crypto/qat/qat_common/qat_asym_algs.c  | 4 ++--
 3 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/adf_common_drv.h b/drivers/crypto/qat/qat_common/adf_common_drv.h
index 4261749fae8d4..75693ca4afea1 100644
--- a/drivers/crypto/qat/qat_common/adf_common_drv.h
+++ b/drivers/crypto/qat/qat_common/adf_common_drv.h
@@ -49,11 +49,6 @@ struct service_hndl {
 	struct list_head list;
 };
 
-static inline int get_current_node(void)
-{
-	return topology_physical_package_id(raw_smp_processor_id());
-}
-
 int adf_service_register(struct service_hndl *service);
 int adf_service_unregister(struct service_hndl *service);
 
diff --git a/drivers/crypto/qat/qat_common/qat_algs.c b/drivers/crypto/qat/qat_common/qat_algs.c
index d36f90628603c..f56ee4cc5ae8b 100644
--- a/drivers/crypto/qat/qat_common/qat_algs.c
+++ b/drivers/crypto/qat/qat_common/qat_algs.c
@@ -605,7 +605,7 @@ static int qat_alg_aead_newkey(struct crypto_aead *tfm, const u8 *key,
 {
 	struct qat_alg_aead_ctx *ctx = crypto_aead_ctx(tfm);
 	struct qat_crypto_instance *inst = NULL;
-	int node = get_current_node();
+	int node = numa_node_id();
 	struct device *dev;
 	int ret;
 
@@ -1071,7 +1071,7 @@ static int qat_alg_skcipher_newkey(struct qat_alg_skcipher_ctx *ctx,
 {
 	struct qat_crypto_instance *inst = NULL;
 	struct device *dev;
-	int node = get_current_node();
+	int node = numa_node_id();
 	int ret;
 
 	inst = qat_crypto_get_instance_node(node);
diff --git a/drivers/crypto/qat/qat_common/qat_asym_algs.c b/drivers/crypto/qat/qat_common/qat_asym_algs.c
index 11c7f2b6e5975..85b0f30712e16 100644
--- a/drivers/crypto/qat/qat_common/qat_asym_algs.c
+++ b/drivers/crypto/qat/qat_common/qat_asym_algs.c
@@ -489,7 +489,7 @@ static int qat_dh_init_tfm(struct crypto_kpp *tfm)
 {
 	struct qat_dh_ctx *ctx = kpp_tfm_ctx(tfm);
 	struct qat_crypto_instance *inst =
-			qat_crypto_get_instance_node(get_current_node());
+			qat_crypto_get_instance_node(numa_node_id());
 
 	if (!inst)
 		return -EINVAL;
@@ -1225,7 +1225,7 @@ static int qat_rsa_init_tfm(struct crypto_akcipher *tfm)
 {
 	struct qat_rsa_ctx *ctx = akcipher_tfm_ctx(tfm);
 	struct qat_crypto_instance *inst =
-			qat_crypto_get_instance_node(get_current_node());
+			qat_crypto_get_instance_node(numa_node_id());
 
 	if (!inst)
 		return -EINVAL;
-- 
2.39.2




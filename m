Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3A275D2A6
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjGUTCI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjGUTCG (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:02:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4186E30CF
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:02:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACCBE61D8E
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:02:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF448C433CB;
        Fri, 21 Jul 2023 19:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966123;
        bh=6MR7BegXIZH9K/T33qUZZMYphL1zrRvn4emK0DmjG6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aqdXkdEOuJKPvd7QQgPTWbd34dQKIGzYKKKQVtseCx7TB7GYT1cnL8Fj7umMmrLAQ
         3LZXIxzXNJmUUu4eCCeinELHGP0vvxHK0GrJOFpcJG8CfS8nHq7J2pDy2nUonUwT6v
         Ysh/XO1O4JDUXCZ74WqQP0l0vZ8+ktEMRjmm4mkQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Damian Muszynski <damian.muszynski@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Adam Guerin <adam.guerin@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 233/532] crypto: qat - use reference to structure in dma_map_single()
Date:   Fri, 21 Jul 2023 18:02:17 +0200
Message-ID: <20230721160627.009471465@linuxfoundation.org>
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

From: Damian Muszynski <damian.muszynski@intel.com>

[ Upstream commit 072d36eefd6fde17928d214df64fdac32f60b4f4 ]

When mapping the input and output parameters, the implementations of RSA
and DH pass to the function dma_map_single() a pointer to the first
member of the structure they want to map instead of a pointer to the
actual structure.
This results in set of warnings reported by the static analyser Smatch:

    drivers/crypto/qat/qat_common/qat_asym_algs.c:335 qat_dh_compute_value() error: dma_map_single_attrs() '&qat_req->in.dh.in.b' too small (8 vs 64)
    drivers/crypto/qat/qat_common/qat_asym_algs.c:341 qat_dh_compute_value() error: dma_map_single_attrs() '&qat_req->out.dh.r' too small (8 vs 64)
    drivers/crypto/qat/qat_common/qat_asym_algs.c:732 qat_rsa_enc() error: dma_map_single_attrs() '&qat_req->in.rsa.enc.m' too small (8 vs 64)
    drivers/crypto/qat/qat_common/qat_asym_algs.c:738 qat_rsa_enc() error: dma_map_single_attrs() '&qat_req->out.rsa.enc.c' too small (8 vs 64)
    drivers/crypto/qat/qat_common/qat_asym_algs.c:878 qat_rsa_dec() error: dma_map_single_attrs() '&qat_req->in.rsa.dec.c' too small (8 vs 64)
    drivers/crypto/qat/qat_common/qat_asym_algs.c:884 qat_rsa_dec() error: dma_map_single_attrs() '&qat_req->out.rsa.dec.m' too small (8 vs 64)

Where the address of the first element of a structure is used as an
input for the function dma_map_single(), replace it with the address of
the structure. This fix does not introduce any functional change as the
addresses are the same.

Signed-off-by: Damian Muszynski <damian.muszynski@intel.com>
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Adam Guerin <adam.guerin@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: eb7713f5ca97 ("crypto: qat - unmap buffer before free for DH")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/qat/qat_common/qat_asym_algs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/qat_asym_algs.c b/drivers/crypto/qat/qat_common/qat_asym_algs.c
index 85b0f30712e16..94a26702aeae1 100644
--- a/drivers/crypto/qat/qat_common/qat_asym_algs.c
+++ b/drivers/crypto/qat/qat_common/qat_asym_algs.c
@@ -332,13 +332,13 @@ static int qat_dh_compute_value(struct kpp_request *req)
 	qat_req->in.dh.in_tab[n_input_params] = 0;
 	qat_req->out.dh.out_tab[1] = 0;
 	/* Mapping in.in.b or in.in_g2.xa is the same */
-	qat_req->phy_in = dma_map_single(dev, &qat_req->in.dh.in.b,
+	qat_req->phy_in = dma_map_single(dev, &qat_req->in.dh,
 					 sizeof(struct qat_dh_input_params),
 					 DMA_TO_DEVICE);
 	if (unlikely(dma_mapping_error(dev, qat_req->phy_in)))
 		goto unmap_dst;
 
-	qat_req->phy_out = dma_map_single(dev, &qat_req->out.dh.r,
+	qat_req->phy_out = dma_map_single(dev, &qat_req->out.dh,
 					  sizeof(struct qat_dh_output_params),
 					  DMA_TO_DEVICE);
 	if (unlikely(dma_mapping_error(dev, qat_req->phy_out)))
@@ -729,13 +729,13 @@ static int qat_rsa_enc(struct akcipher_request *req)
 
 	qat_req->in.rsa.in_tab[3] = 0;
 	qat_req->out.rsa.out_tab[1] = 0;
-	qat_req->phy_in = dma_map_single(dev, &qat_req->in.rsa.enc.m,
+	qat_req->phy_in = dma_map_single(dev, &qat_req->in.rsa,
 					 sizeof(struct qat_rsa_input_params),
 					 DMA_TO_DEVICE);
 	if (unlikely(dma_mapping_error(dev, qat_req->phy_in)))
 		goto unmap_dst;
 
-	qat_req->phy_out = dma_map_single(dev, &qat_req->out.rsa.enc.c,
+	qat_req->phy_out = dma_map_single(dev, &qat_req->out.rsa,
 					  sizeof(struct qat_rsa_output_params),
 					  DMA_TO_DEVICE);
 	if (unlikely(dma_mapping_error(dev, qat_req->phy_out)))
@@ -875,13 +875,13 @@ static int qat_rsa_dec(struct akcipher_request *req)
 	else
 		qat_req->in.rsa.in_tab[3] = 0;
 	qat_req->out.rsa.out_tab[1] = 0;
-	qat_req->phy_in = dma_map_single(dev, &qat_req->in.rsa.dec.c,
+	qat_req->phy_in = dma_map_single(dev, &qat_req->in.rsa,
 					 sizeof(struct qat_rsa_input_params),
 					 DMA_TO_DEVICE);
 	if (unlikely(dma_mapping_error(dev, qat_req->phy_in)))
 		goto unmap_dst;
 
-	qat_req->phy_out = dma_map_single(dev, &qat_req->out.rsa.dec.m,
+	qat_req->phy_out = dma_map_single(dev, &qat_req->out.rsa,
 					  sizeof(struct qat_rsa_output_params),
 					  DMA_TO_DEVICE);
 	if (unlikely(dma_mapping_error(dev, qat_req->phy_out)))
-- 
2.39.2




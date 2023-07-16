Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76569755621
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbjGPUrx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbjGPUrw (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:47:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4041FE54
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:47:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 668FD60DFD
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:47:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D8FC433C7;
        Sun, 16 Jul 2023 20:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540467;
        bh=XMuA7nh0BQwZUUMeFkOezyFXWyBpxIiuq4Q67HyTXfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K+H/NfjB7rKWgEuCGTABT3EKRigbs4A7HVuLrkByMoPLu1GapXWI2OGZ84RkHAh4P
         BOSL3qK8+O7nzvekGEremL5VAwx2/VFiCZxnX9xdUN1ju5wrwImgD6LL+Nl7Um5NAs
         Ne/1TJ+67lza0NHr4KbqcRr3bKUGTgJK4CZ4AV5M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Hareshx Sankar Raj <hareshx.sankar.raj@intel.com>,
        Bolemx Sivanagaleela <bolemx.sivanagaleela@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 346/591] crypto: qat - unmap buffers before free for RSA
Date:   Sun, 16 Jul 2023 21:48:05 +0200
Message-ID: <20230716194932.860488020@linuxfoundation.org>
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

From: Hareshx Sankar Raj <hareshx.sankar.raj@intel.com>

[ Upstream commit d776b25495f2c71b9dbf1f5e53b642215ba72f3c ]

The callback function for RSA frees the memory allocated for the source
and destination buffers before unmapping them.
This sequence is wrong.

Change the cleanup sequence to unmap the buffers before freeing them.

Fixes: 3dfaf0071ed7 ("crypto: qat - remove dma_free_coherent() for RSA")
Signed-off-by: Hareshx Sankar Raj <hareshx.sankar.raj@intel.com>
Co-developed-by: Bolemx Sivanagaleela <bolemx.sivanagaleela@intel.com>
Signed-off-by: Bolemx Sivanagaleela <bolemx.sivanagaleela@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/qat/qat_common/qat_asym_algs.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/qat_asym_algs.c b/drivers/crypto/qat/qat_common/qat_asym_algs.c
index 8806242469a06..4128200a90329 100644
--- a/drivers/crypto/qat/qat_common/qat_asym_algs.c
+++ b/drivers/crypto/qat/qat_common/qat_asym_algs.c
@@ -520,12 +520,14 @@ static void qat_rsa_cb(struct icp_qat_fw_pke_resp *resp)
 
 	err = (err == ICP_QAT_FW_COMN_STATUS_FLAG_OK) ? 0 : -EINVAL;
 
-	kfree_sensitive(req->src_align);
-
 	dma_unmap_single(dev, req->in.rsa.enc.m, req->ctx.rsa->key_sz,
 			 DMA_TO_DEVICE);
 
+	kfree_sensitive(req->src_align);
+
 	areq->dst_len = req->ctx.rsa->key_sz;
+	dma_unmap_single(dev, req->out.rsa.enc.c, req->ctx.rsa->key_sz,
+			 DMA_FROM_DEVICE);
 	if (req->dst_align) {
 		scatterwalk_map_and_copy(req->dst_align, areq->dst, 0,
 					 areq->dst_len, 1);
@@ -533,9 +535,6 @@ static void qat_rsa_cb(struct icp_qat_fw_pke_resp *resp)
 		kfree_sensitive(req->dst_align);
 	}
 
-	dma_unmap_single(dev, req->out.rsa.enc.c, req->ctx.rsa->key_sz,
-			 DMA_FROM_DEVICE);
-
 	dma_unmap_single(dev, req->phy_in, sizeof(struct qat_rsa_input_params),
 			 DMA_TO_DEVICE);
 	dma_unmap_single(dev, req->phy_out,
-- 
2.39.2




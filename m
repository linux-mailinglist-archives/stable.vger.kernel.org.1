Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7069D74C3B5
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbjGILf0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbjGILfZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:35:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1436595
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:35:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CECF60BC0
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:35:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C642C433C8;
        Sun,  9 Jul 2023 11:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902523;
        bh=CjEeqMPI2n/OTGK31VVR8XLwKS+V+r9xCLRenEbjhOY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gkMYehF8CsQNxJ/VbW204Aq6OSOqlDxIUXcOFr2d+efFAY9EgMY3UuhNN6HF+Id/J
         QJN0CPH+Q6ZJKITYVTjcSAQeO93VMrreCdxdhJ0kOjEkDL5ew0NwFihoJooxdjePFh
         TflpwXJ7PJaJJWcRj9ym2cwDJXsLuNoyaS/3pY58=
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
Subject: [PATCH 6.3 407/431] crypto: qat - unmap buffer before free for DH
Date:   Sun,  9 Jul 2023 13:15:55 +0200
Message-ID: <20230709111500.726924747@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
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

[ Upstream commit eb7713f5ca97697b92f225127440d1525119b8de ]

The callback function for DH frees the memory allocated for the
destination buffer before unmapping it.
This sequence is wrong.

Change the cleanup sequence to unmap the buffer before freeing it.

Fixes: 029aa4624a7f ("crypto: qat - remove dma_free_coherent() for DH")
Signed-off-by: Hareshx Sankar Raj <hareshx.sankar.raj@intel.com>
Co-developed-by: Bolemx Sivanagaleela <bolemx.sivanagaleela@intel.com>
Signed-off-by: Bolemx Sivanagaleela <bolemx.sivanagaleela@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/qat/qat_common/qat_asym_algs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/qat_asym_algs.c b/drivers/crypto/qat/qat_common/qat_asym_algs.c
index 935a7e012946e..8806242469a06 100644
--- a/drivers/crypto/qat/qat_common/qat_asym_algs.c
+++ b/drivers/crypto/qat/qat_common/qat_asym_algs.c
@@ -170,15 +170,14 @@ static void qat_dh_cb(struct icp_qat_fw_pke_resp *resp)
 	}
 
 	areq->dst_len = req->ctx.dh->p_size;
+	dma_unmap_single(dev, req->out.dh.r, req->ctx.dh->p_size,
+			 DMA_FROM_DEVICE);
 	if (req->dst_align) {
 		scatterwalk_map_and_copy(req->dst_align, areq->dst, 0,
 					 areq->dst_len, 1);
 		kfree_sensitive(req->dst_align);
 	}
 
-	dma_unmap_single(dev, req->out.dh.r, req->ctx.dh->p_size,
-			 DMA_FROM_DEVICE);
-
 	dma_unmap_single(dev, req->phy_in, sizeof(struct qat_dh_input_params),
 			 DMA_TO_DEVICE);
 	dma_unmap_single(dev, req->phy_out,
-- 
2.39.2




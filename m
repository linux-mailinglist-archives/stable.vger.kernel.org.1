Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B2076AE5E
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbjHAJiO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbjHAJhd (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:37:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABEC18F
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:35:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49390614FD
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:35:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF74C433C9;
        Tue,  1 Aug 2023 09:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882552;
        bh=IoEG7q9mPu3X3bRdL41O63Y7dnPP8yF2EdxkNkzviWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MNk1JGH0k2yatD8DtBhMK1T8t7zkca3skovzVcK0qjoCZLedriKAbJdIUECMH63kg
         vsfN5fgXD/eFgzGh9sNiVadNXPridqrKAbKPjSDF9Anevj5B8MSHc5YmEnZ7lh8L8F
         qP5j2Spd3tlMWMrtpQyIMpfiwoG9ajhP4J2BRMtM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shiraz Saleem <shiraz.saleem@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 118/228] RDMA/irdma: Add missing read barriers
Date:   Tue,  1 Aug 2023 11:19:36 +0200
Message-ID: <20230801091927.027989080@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Shiraz Saleem <shiraz.saleem@intel.com>

[ Upstream commit 4984eb51453ff7eddee9e5ce816145be39c0ec5c ]

On code inspection, there are many instances in the driver where
CEQE and AEQE fields written to by HW are read without guaranteeing
that the polarity bit has been read and checked first.

Add a read barrier to avoid reordering of loads on the CEQE/AEQE fields
prior to checking the polarity bit.

Fixes: 3f49d6842569 ("RDMA/irdma: Implement HW Admin Queue OPs")
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Link: https://lore.kernel.org/r/20230711175253.1289-2-shiraz.saleem@intel.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/irdma/ctrl.c | 9 ++++++++-
 drivers/infiniband/hw/irdma/puda.c | 6 ++++++
 drivers/infiniband/hw/irdma/uk.c   | 3 +++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
index a41e0d21143ae..d86d7ca9cee4a 100644
--- a/drivers/infiniband/hw/irdma/ctrl.c
+++ b/drivers/infiniband/hw/irdma/ctrl.c
@@ -3344,6 +3344,9 @@ int irdma_sc_ccq_get_cqe_info(struct irdma_sc_cq *ccq,
 	if (polarity != ccq->cq_uk.polarity)
 		return -ENOENT;
 
+	/* Ensure CEQE contents are read after valid bit is checked */
+	dma_rmb();
+
 	get_64bit_val(cqe, 8, &qp_ctx);
 	cqp = (struct irdma_sc_cqp *)(unsigned long)qp_ctx;
 	info->error = (bool)FIELD_GET(IRDMA_CQ_ERROR, temp);
@@ -3990,13 +3993,17 @@ int irdma_sc_get_next_aeqe(struct irdma_sc_aeq *aeq,
 	u8 polarity;
 
 	aeqe = IRDMA_GET_CURRENT_AEQ_ELEM(aeq);
-	get_64bit_val(aeqe, 0, &compl_ctx);
 	get_64bit_val(aeqe, 8, &temp);
 	polarity = (u8)FIELD_GET(IRDMA_AEQE_VALID, temp);
 
 	if (aeq->polarity != polarity)
 		return -ENOENT;
 
+	/* Ensure AEQE contents are read after valid bit is checked */
+	dma_rmb();
+
+	get_64bit_val(aeqe, 0, &compl_ctx);
+
 	print_hex_dump_debug("WQE: AEQ_ENTRY WQE", DUMP_PREFIX_OFFSET, 16, 8,
 			     aeqe, 16, false);
 
diff --git a/drivers/infiniband/hw/irdma/puda.c b/drivers/infiniband/hw/irdma/puda.c
index 4ec9639f1bdbf..562531712ea44 100644
--- a/drivers/infiniband/hw/irdma/puda.c
+++ b/drivers/infiniband/hw/irdma/puda.c
@@ -230,6 +230,9 @@ static int irdma_puda_poll_info(struct irdma_sc_cq *cq,
 	if (valid_bit != cq_uk->polarity)
 		return -ENOENT;
 
+	/* Ensure CQE contents are read after valid bit is checked */
+	dma_rmb();
+
 	if (cq->dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_2)
 		ext_valid = (bool)FIELD_GET(IRDMA_CQ_EXTCQE, qword3);
 
@@ -243,6 +246,9 @@ static int irdma_puda_poll_info(struct irdma_sc_cq *cq,
 		if (polarity != cq_uk->polarity)
 			return -ENOENT;
 
+		/* Ensure ext CQE contents are read after ext valid bit is checked */
+		dma_rmb();
+
 		IRDMA_RING_MOVE_HEAD_NOCHECK(cq_uk->cq_ring);
 		if (!IRDMA_RING_CURRENT_HEAD(cq_uk->cq_ring))
 			cq_uk->polarity = !cq_uk->polarity;
diff --git a/drivers/infiniband/hw/irdma/uk.c b/drivers/infiniband/hw/irdma/uk.c
index dd428d915c175..ea2c07751245a 100644
--- a/drivers/infiniband/hw/irdma/uk.c
+++ b/drivers/infiniband/hw/irdma/uk.c
@@ -1527,6 +1527,9 @@ void irdma_uk_clean_cq(void *q, struct irdma_cq_uk *cq)
 		if (polarity != temp)
 			break;
 
+		/* Ensure CQE contents are read after valid bit is checked */
+		dma_rmb();
+
 		get_64bit_val(cqe, 8, &comp_ctx);
 		if ((void *)(unsigned long)comp_ctx == q)
 			set_64bit_val(cqe, 8, 0);
-- 
2.40.1




Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD59976AD5E
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjHAJ2j (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjHAJ2U (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:28:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A9B3C29
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:27:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3228614CF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:27:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDFD4C433C8;
        Tue,  1 Aug 2023 09:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882037;
        bh=B28jOyjaNmF2IVqKPmCZXi/DGMf3VnPp980hBsyqFxM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GYKgiWmfAbUOOFO4nAgANEYepMNBU/Bno1amTg5VwmtvMdtr8hMfFr4khmUy0OlOa
         BCS51oqqlw9xldVrWko/HiWmsbzlw7ngDCk22yz97ItW+XRC3RX26ECdkJLYICuyBe
         bJ8fPy3AobcvUDEb4UmN1ALgyVbh81icTpiDCTOI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 088/155] RDMA/mthca: Fix crash when polling CQ for shared QPs
Date:   Tue,  1 Aug 2023 11:20:00 +0200
Message-ID: <20230801091913.324096885@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091910.165050260@linuxfoundation.org>
References: <20230801091910.165050260@linuxfoundation.org>
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

From: Thomas Bogendoerfer <tbogendoerfer@suse.de>

[ Upstream commit dc52aadbc1849cbe3fcf6bc54d35f6baa396e0a1 ]

Commit 21c2fe94abb2 ("RDMA/mthca: Combine special QP struct with mthca QP")
introduced a new struct mthca_sqp which doesn't contain struct mthca_qp
any longer. Placing a pointer of this new struct into qptable leads
to crashes, because mthca_poll_one() expects a qp pointer. Fix this
by putting the correct pointer into qptable.

Fixes: 21c2fe94abb2 ("RDMA/mthca: Combine special QP struct with mthca QP")
Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Link: https://lore.kernel.org/r/20230713141658.9426-1-tbogendoerfer@suse.de
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mthca/mthca_qp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
index 69bba0ef4a5df..53f43649f7d08 100644
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -1393,7 +1393,7 @@ int mthca_alloc_sqp(struct mthca_dev *dev,
 	if (mthca_array_get(&dev->qp_table.qp, mqpn))
 		err = -EBUSY;
 	else
-		mthca_array_set(&dev->qp_table.qp, mqpn, qp->sqp);
+		mthca_array_set(&dev->qp_table.qp, mqpn, qp);
 	spin_unlock_irq(&dev->qp_table.lock);
 
 	if (err)
-- 
2.40.1




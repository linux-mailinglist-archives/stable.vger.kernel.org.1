Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35DB775D6C
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbjHILhX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbjHILhW (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:37:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417F0E3
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:37:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4E9863566
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:37:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8FCC433C8;
        Wed,  9 Aug 2023 11:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691581041;
        bh=WuRcf7NTsT+vMms9zLqIZ851iIGflwb13qu7kPnfZKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KHCQR48NPyQ5S3iG1GhczMMhykNx2i+2X5axrI746DCdqQB49q0gnBOPhqDFg7yk3
         bkvCcbFwo7swgg4zlQN1gZejNai3WYrsEf9NuX9JphBPi05j/FOxeSTitCjSW92jK8
         sj+y3U4L7Swom0+maxC85YdL5icWAsdj+J8Bcw6A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 055/201] RDMA/mthca: Fix crash when polling CQ for shared QPs
Date:   Wed,  9 Aug 2023 12:40:57 +0200
Message-ID: <20230809103645.683635667@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
index 08a2a7afafd3d..3f57f7dfb822f 100644
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -1390,7 +1390,7 @@ int mthca_alloc_sqp(struct mthca_dev *dev,
 	if (mthca_array_get(&dev->qp_table.qp, mqpn))
 		err = -EBUSY;
 	else
-		mthca_array_set(&dev->qp_table.qp, mqpn, qp->sqp);
+		mthca_array_set(&dev->qp_table.qp, mqpn, qp);
 	spin_unlock_irq(&dev->qp_table.lock);
 
 	if (err)
-- 
2.40.1




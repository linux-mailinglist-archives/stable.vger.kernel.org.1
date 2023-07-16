Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7F17552AB
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjGPUKe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbjGPUKd (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:10:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883CA123
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:10:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E4CF60EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA8FC433C9;
        Sun, 16 Jul 2023 20:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538231;
        bh=EUlAzn4v+aovxDVHF8sVQJ2AMOWMnLbNYvO559t/gCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z65r0hAeAaxFBcP6cdfZjnN1oOr2pjCVAs3De/4EhK7ZM5GV/ZzjXGUt9tAMQAaBu
         BikRlCZQf7Se+Jx6xf2tZ6n3NQxK875b8w0fSsy0oQEguxMs9CxRQ19118jCynwxyU
         Wliv6+Xkw+VOnYBLKM5luUiYWNEe4Q+7FfRIPdOU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 376/800] RDMA/bnxt_re: wraparound mbox producer index
Date:   Sun, 16 Jul 2023 21:43:49 +0200
Message-ID: <20230716194957.809087629@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Kashyap Desai <kashyap.desai@broadcom.com>

[ Upstream commit 0af91306e17ef3d18e5f100aa58aa787869118af ]

Driver is not handling the wraparound of the mbox producer index correctly.
Currently the wraparound happens once u32 max is reached.

Bit 31 of the producer index register is special and should be set
only once for the first command. Because the producer index overflow
setting bit31 after a long time, FW goes to initialization sequence
and this causes FW hang.

Fix is to wraparound the mbox producer index once it reaches u16 max.

Fixes: cee0c7bba486 ("RDMA/bnxt_re: Refactor command queue management code")
Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Link: https://lore.kernel.org/r/1686308514-11996-2-git-send-email-selvin.xavier@broadcom.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 688eaa01db649..d4ce82bebb0a5 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -180,7 +180,7 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw,
 	} while (bsize > 0);
 	cmdq->seq_num++;
 
-	cmdq_prod = hwq->prod;
+	cmdq_prod = hwq->prod & 0xFFFF;
 	if (test_bit(FIRMWARE_FIRST_FLAG, &cmdq->flags)) {
 		/* The very first doorbell write
 		 * is required to set this flag
@@ -599,7 +599,7 @@ int bnxt_qplib_alloc_rcfw_channel(struct bnxt_qplib_res *res,
 		rcfw->cmdq_depth = BNXT_QPLIB_CMDQE_MAX_CNT_8192;
 
 	sginfo.pgsize = bnxt_qplib_cmdqe_page_size(rcfw->cmdq_depth);
-	hwq_attr.depth = rcfw->cmdq_depth;
+	hwq_attr.depth = rcfw->cmdq_depth & 0x7FFFFFFF;
 	hwq_attr.stride = BNXT_QPLIB_CMDQE_UNITS;
 	hwq_attr.type = HWQ_TYPE_CTX;
 	if (bnxt_qplib_alloc_init_hwq(&cmdq->hwq, &hwq_attr)) {
-- 
2.39.2




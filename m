Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7743755281
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjGPUIl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjGPUIk (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:08:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D550C9B
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:08:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AB5060DD4
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:08:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D9FC433C9;
        Sun, 16 Jul 2023 20:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538118;
        bh=tDEY2Jg+E3JWJHtY7yGVeW6buAETziqXevjbXQJTiX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DPZX9eAoniInWnbbfc9YKrBA8ofoJc4i/kC7DEHBZmyZYUArE0c6ul3stsYbE/tuJ
         Bye9JhjFboMxN8WEPEK97or+lV7uTzsgoHRaSrl2ruBf3uV2lwcJeAbKmFhDpxy8v/
         Wm11qr04jqBs5qdSFrCmq+OojnUfjvbAKPSd0K5s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 337/800] RDMA/irdma: avoid fortify-string warning in irdma_clr_wqes
Date:   Sun, 16 Jul 2023 21:43:10 +0200
Message-ID: <20230716194956.910004059@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit b002760f877c0d91ecd3c78565b52f4bbac379dd ]

Commit df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3") triggers a
warning for fortified memset():

In function 'fortify_memset_chk',
    inlined from 'irdma_clr_wqes' at drivers/infiniband/hw/irdma/uk.c:103:4:
include/linux/fortify-string.h:493:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
  493 |                         __write_overflow_field(p_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The problem here isthat the inner array only has four 8-byte elements, so
clearing 4096 bytes overflows that. As this structure is part of an outer
array, change the code to pass a pointer to the irdma_qp_quanta instead,
and change the size argument for readability, matching the comment above
it.

Fixes: 551c46edc769 ("RDMA/irdma: Add user/kernel shared libraries")
Link: https://lore.kernel.org/r/20230523111859.2197825-1-arnd@kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/irdma/uk.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/uk.c b/drivers/infiniband/hw/irdma/uk.c
index 16183e894da77..dd428d915c175 100644
--- a/drivers/infiniband/hw/irdma/uk.c
+++ b/drivers/infiniband/hw/irdma/uk.c
@@ -93,16 +93,18 @@ static int irdma_nop_1(struct irdma_qp_uk *qp)
  */
 void irdma_clr_wqes(struct irdma_qp_uk *qp, u32 qp_wqe_idx)
 {
-	__le64 *wqe;
+	struct irdma_qp_quanta *sq;
 	u32 wqe_idx;
 
 	if (!(qp_wqe_idx & 0x7F)) {
 		wqe_idx = (qp_wqe_idx + 128) % qp->sq_ring.size;
-		wqe = qp->sq_base[wqe_idx].elem;
+		sq = qp->sq_base + wqe_idx;
 		if (wqe_idx)
-			memset(wqe, qp->swqe_polarity ? 0 : 0xFF, 0x1000);
+			memset(sq, qp->swqe_polarity ? 0 : 0xFF,
+			       128 * sizeof(*sq));
 		else
-			memset(wqe, qp->swqe_polarity ? 0xFF : 0, 0x1000);
+			memset(sq, qp->swqe_polarity ? 0xFF : 0,
+			       128 * sizeof(*sq));
 	}
 }
 
-- 
2.39.2




Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E46726F83
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235666AbjFGU7H (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235678AbjFGU7G (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:59:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7508C2694
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:58:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52DD6648B2
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:58:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65478C433EF;
        Wed,  7 Jun 2023 20:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171526;
        bh=859yAD7btMtFMPipLhBxZrv//dJynJj5sbElCQtWntg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sQooncLIZXRd1X6dx15rzrF6Bz+YdIUyHz7L9sunhCy7WFrZeiEH36OxlkeLrG/9R
         wzZgOyw4cGAT7S0/EDEEJP7rNPrjxpgId9yKetB0FOnZZs8T82OW7nytJebWKZU1az
         9nbpbE+mqSnEaKOevnghwig3oCEHY1qWtwinlvdE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 022/159] RDMA/irdma: Fix Local Invalidate fencing
Date:   Wed,  7 Jun 2023 22:15:25 +0200
Message-ID: <20230607200904.398797358@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200903.652580797@linuxfoundation.org>
References: <20230607200903.652580797@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mustafa Ismail <mustafa.ismail@intel.com>

[ Upstream commit 5842d1d9c1b0d17e0c29eae65ae1f245f83682dd ]

If the local invalidate fence is indicated in the WR, only the read fence
is currently being set in WQE. Fix this to set both the read and local
fence in the WQE.

Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Link: https://lore.kernel.org/r/20230522155654.1309-4-shiraz.saleem@intel.com
Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/irdma/verbs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 7745740e737a3..60cf83c4119e7 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -3196,6 +3196,7 @@ static int irdma_post_send(struct ib_qp *ibqp,
 			break;
 		case IB_WR_LOCAL_INV:
 			info.op_type = IRDMA_OP_TYPE_INV_STAG;
+			info.local_fence = info.read_fence;
 			info.op.inv_local_stag.target_stag = ib_wr->ex.invalidate_rkey;
 			ret = irdma_uk_stag_local_invalidate(ukqp, &info, true);
 			if (ret)
-- 
2.39.2




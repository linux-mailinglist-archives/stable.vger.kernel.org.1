Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF3772700D
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 23:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236149AbjFGVEP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 17:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236160AbjFGVDy (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 17:03:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC0810C6
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 14:03:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8BFB649A7
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 21:03:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC692C4339E;
        Wed,  7 Jun 2023 21:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171812;
        bh=wpqimjoRh3myYLdDLmVHpxtLQHTTj77fCvhWttUCUZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jnP2agsiiUoPmbK0bYSebaZyeIJvDByMUuVVJ6i06f/RNfGT1lMOthjJrwsP6/MoC
         4qQu6Oq/PFucgAr6P4WvNoN4nZg68EXv11UGcygF3h+QnSWtXMB7fZ/pWe1rd4uQQL
         1uJ/yYbl+oVWyyYVolyc2/fzxTw48X4o+7y2tCWs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Leon Romanovsky <leon@kernel.org>
Subject: [PATCH 5.15 159/159] RDMA/irdma: Do not generate SW completions for NOPs
Date:   Wed,  7 Jun 2023 22:17:42 +0200
Message-ID: <20230607200908.866523203@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200903.652580797@linuxfoundation.org>
References: <20230607200903.652580797@linuxfoundation.org>
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

From: Mustafa Ismail <mustafa.ismail@intel.com>

commit 30ed9ee9a10a90ae719dcfcacead1d0506fa45ed upstream.

Currently, artificial SW completions are generated for NOP wqes which can
generate unexpected completions with wr_id = 0. Skip the generation of
artificial completions for NOPs.

Fixes: 81091d7696ae ("RDMA/irdma: Add SW mechanism to generate completions on error")
Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Link: https://lore.kernel.org/r/20230315145231.931-2-shiraz.saleem@intel.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/irdma/utils.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -2650,7 +2650,10 @@ void irdma_generate_flush_completions(st
 			/* remove the SQ WR by moving SQ tail*/
 			IRDMA_RING_SET_TAIL(*sq_ring,
 				sq_ring->tail + qp->sq_wrtrk_array[sq_ring->tail].quanta);
-
+			if (cmpl->cpi.op_type == IRDMAQP_OP_NOP) {
+				kfree(cmpl);
+				continue;
+			}
 			ibdev_dbg(iwqp->iwscq->ibcq.device,
 				  "DEV: %s: adding wr_id = 0x%llx SQ Completion to list qp_id=%d\n",
 				  __func__, cmpl->cpi.wr_id, qp->qp_id);



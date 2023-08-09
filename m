Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC55775B10
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbjHILOA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbjHILOA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:14:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A285BED
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:13:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41ED962347
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:13:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58450C433C7;
        Wed,  9 Aug 2023 11:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579638;
        bh=HKRaxvRnUhokZeNNN2PFfXjlXkFAjE3umRg8wo8XlZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fqk7QhmBW5pkec1nyOrjhgvzZkmRdtVKqlHpW//UqHfmX3C0h215fGimRY9n3Rq1U
         VoDlXS7rfIMM9/0HzntixL9aG0vWbQUBelr2r4Ra6ozkKO6AR8pS9+e08Hb39io7dK
         ujFv39W/mDFKhtzskalis6fJkN8lb9pZNg9Lc5vI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        Patrick Kelsey <pat.kelsey@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 062/323] IB/hfi1: Fix sdma.h tx->num_descs off-by-one errors
Date:   Wed,  9 Aug 2023 12:38:20 +0200
Message-ID: <20230809103700.991021721@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
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

From: Patrick Kelsey <pat.kelsey@cornelisnetworks.com>

[ Upstream commit fd8958efe8779d3db19c9124fce593ce681ac709 ]

Fix three sources of error involving struct sdma_txreq.num_descs.

When _extend_sdma_tx_descs() extends the descriptor array, it uses the
value of tx->num_descs to determine how many existing entries from the
tx's original, internal descriptor array to copy to the newly allocated
one.  As this value was incremented before the call, the copy loop will
access one entry past the internal descriptor array, copying its contents
into the corresponding slot in the new array.

If the call to _extend_sdma_tx_descs() fails, _pad_smda_tx_descs() then
invokes __sdma_tx_clean() which uses the value of tx->num_desc to drive a
loop that unmaps all descriptor entries in use.  As this value was
incremented before the call, the unmap loop will invoke sdma_unmap_desc()
on a descriptor entry whose contents consist of whatever random data was
copied into it during (1), leading to cascading further calls into the
kernel and driver using arbitrary data.

_sdma_close_tx() was using tx->num_descs instead of tx->num_descs - 1.

Fix all of the above by:
- Only increment .num_descs after .descp is extended.
- Use .num_descs - 1 instead of .num_descs for last .descp entry.

Fixes: f4d26d81ad7f ("staging/rdma/hfi1: Add coalescing support for SDMA TX descriptors")
Link: https://lore.kernel.org/r/167656658879.2223096.10026561343022570690.stgit@awfm-02.cornelisnetworks.com
Signed-off-by: Brendan Cunningham <bcunningham@cornelisnetworks.com>
Signed-off-by: Patrick Kelsey <pat.kelsey@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hfi1/sdma.c |  4 ++--
 drivers/infiniband/hw/hfi1/sdma.h | 15 +++++++--------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
index 33ff9eca28f69..245f9505a9aca 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -3202,8 +3202,7 @@ int _pad_sdma_tx_descs(struct hfi1_devdata *dd, struct sdma_txreq *tx)
 {
 	int rval = 0;
 
-	tx->num_desc++;
-	if ((unlikely(tx->num_desc == tx->desc_limit))) {
+	if ((unlikely(tx->num_desc + 1 == tx->desc_limit))) {
 		rval = _extend_sdma_tx_descs(dd, tx);
 		if (rval) {
 			__sdma_txclean(dd, tx);
@@ -3216,6 +3215,7 @@ int _pad_sdma_tx_descs(struct hfi1_devdata *dd, struct sdma_txreq *tx)
 		SDMA_MAP_NONE,
 		dd->sdma_pad_phys,
 		sizeof(u32) - (tx->packet_len & (sizeof(u32) - 1)));
+	tx->num_desc++;
 	_sdma_close_tx(dd, tx);
 	return rval;
 }
diff --git a/drivers/infiniband/hw/hfi1/sdma.h b/drivers/infiniband/hw/hfi1/sdma.h
index 46c775f255d14..a3dd2f3d56cca 100644
--- a/drivers/infiniband/hw/hfi1/sdma.h
+++ b/drivers/infiniband/hw/hfi1/sdma.h
@@ -680,14 +680,13 @@ static inline void sdma_txclean(struct hfi1_devdata *dd, struct sdma_txreq *tx)
 static inline void _sdma_close_tx(struct hfi1_devdata *dd,
 				  struct sdma_txreq *tx)
 {
-	tx->descp[tx->num_desc].qw[0] |=
-		SDMA_DESC0_LAST_DESC_FLAG;
-	tx->descp[tx->num_desc].qw[1] |=
-		dd->default_desc1;
+	u16 last_desc = tx->num_desc - 1;
+
+	tx->descp[last_desc].qw[0] |= SDMA_DESC0_LAST_DESC_FLAG;
+	tx->descp[last_desc].qw[1] |= dd->default_desc1;
 	if (tx->flags & SDMA_TXREQ_F_URGENT)
-		tx->descp[tx->num_desc].qw[1] |=
-			(SDMA_DESC1_HEAD_TO_HOST_FLAG |
-			 SDMA_DESC1_INT_REQ_FLAG);
+		tx->descp[last_desc].qw[1] |= (SDMA_DESC1_HEAD_TO_HOST_FLAG |
+					       SDMA_DESC1_INT_REQ_FLAG);
 }
 
 static inline int _sdma_txadd_daddr(
@@ -704,6 +703,7 @@ static inline int _sdma_txadd_daddr(
 		type,
 		addr, len);
 	WARN_ON(len > tx->tlen);
+	tx->num_desc++;
 	tx->tlen -= len;
 	/* special cases for last */
 	if (!tx->tlen) {
@@ -715,7 +715,6 @@ static inline int _sdma_txadd_daddr(
 			_sdma_close_tx(dd, tx);
 		}
 	}
-	tx->num_desc++;
 	return rval;
 }
 
-- 
2.39.2




Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072846FAB82
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbjEHLOK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbjEHLOG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:14:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F6535B3E
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:14:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD4A262BC1
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:14:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F125AC433D2;
        Mon,  8 May 2023 11:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544443;
        bh=Ib1jyX5nibVghdm8I0eoXTj9B2t409WaWaMcDU2OhVA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c1JZaWwLKyCzbhrpcwXSr1lUB7nLmX6qeIvZ0A97lPCwh1N1Tsso4OEDl7aNLCPTD
         A4j0THKZ3JpyM83AL20JMDcbSLAj4aDKqpzic6s0hmLlfljHIeqMpUebhqVfuF64nU
         8+/mGLYnvjDiGWb+Mj/JciNGOpzCfO4saCMAl77k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 410/694] blk-mq: dont plug for head insertions in blk_execute_rq_nowait
Date:   Mon,  8 May 2023 11:44:05 +0200
Message-Id: <20230508094446.542905108@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 50947d7fe9fa6abe3ddc40769dfb02a51c58edb6 ]

Plugs never insert at head, so don't plug for head insertions.

Fixes: 1c2d2fff6dc0 ("block: wire-up support for passthrough plugging")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Link: https://lore.kernel.org/r/20230413064057.707578-2-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f5bec5258d32b..ae08c4936743d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1345,7 +1345,7 @@ void blk_execute_rq_nowait(struct request *rq, bool at_head)
 	 * device, directly accessing the plug instead of using blk_mq_plug()
 	 * should not have any consequences.
 	 */
-	if (current->plug)
+	if (current->plug && !at_head)
 		blk_add_rq_to_plug(current->plug, rq);
 	else
 		blk_mq_sched_insert_request(rq, at_head, true, false);
-- 
2.39.2




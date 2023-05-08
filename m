Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335676FA524
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbjEHKGX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbjEHKGW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:06:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BB030468
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:06:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3440F62345
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:06:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A44C4339B;
        Mon,  8 May 2023 10:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540379;
        bh=MHKFsfiJ9Lrz5/Zx0Bgm24w5+itETN8I+hw8LrwLMzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m+LGUOwEZ1/EiCHp6/WspLcZqwD77xAJhjX2UJ5SQGxSieplfM/nGDb+rl/dR7zbW
         j13oDmCW8KuQC8O2u6qYs4Y+GPaayqZsG2xFmRyb6rtI4vzNBU/vYR+kwGFc6rEtU+
         YxRpybqOxYs7dEuS2PFESht6ta9xHVBOc7I2zsUE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 341/611] blk-mq: dont plug for head insertions in blk_execute_rq_nowait
Date:   Mon,  8 May 2023 11:43:03 +0200
Message-Id: <20230508094433.495537956@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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
index b3ebf604b1dd5..1ab41fbca0946 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1313,7 +1313,7 @@ void blk_execute_rq_nowait(struct request *rq, bool at_head)
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




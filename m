Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B0574C233
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjGILRz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjGILRu (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:17:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314C0B5
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:17:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4C2260BD8
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:17:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7DB8C433C8;
        Sun,  9 Jul 2023 11:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901469;
        bh=EA8DLC+oQi3k3KrQIP5Ryg4HPp0DAxXQ3uznduvgu10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mSLgJw3ixTeDUjRhPV7wsZCH0n1kd5hL66wqe1rYqFg2nGopNFwUsCuyF8/zY/+st
         K7yKXhqZ2bo8Oo39moIKDYIQoFhncIz9tvZHSJugCUV2V5PWwEqCuZsdlF0VNOkFZH
         ZW85qrLGVg9jOs9wJLZQzF87KFSLgS/3HZWLcLS0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <dlemoal@kernel.org>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 004/431] block: Fix the type of the second bdev_op_is_zoned_write() argument
Date:   Sun,  9 Jul 2023 13:09:12 +0200
Message-ID: <20230709111451.212896010@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
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

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit 3ddbe2a7e0d4a155a805f69c906c9beed30d4cc4 ]

Change the type of the second argument of bdev_op_is_zoned_write() from
blk_opf_t into enum req_op because this function expects an operation
without flags as second argument.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Cc: Ming Lei <ming.lei@redhat.com>
Fixes: 8cafdb5ab94c ("block: adapt blk_mq_plug() to not plug for writes that require a zone lock")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Link: https://lore.kernel.org/r/20230517174230.897144-4-bvanassche@acm.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/blkdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 941304f17492f..3d620f298aebd 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1297,7 +1297,7 @@ static inline unsigned int bdev_zone_no(struct block_device *bdev, sector_t sec)
 }
 
 static inline bool bdev_op_is_zoned_write(struct block_device *bdev,
-					  blk_opf_t op)
+					  enum req_op op)
 {
 	if (!bdev_is_zoned(bdev))
 		return false;
-- 
2.39.2




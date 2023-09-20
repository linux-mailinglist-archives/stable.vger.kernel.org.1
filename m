Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5BE7A7B79
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234726AbjITLwa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234721AbjITLwa (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:52:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5567F92
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:52:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E930C433C8;
        Wed, 20 Sep 2023 11:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210744;
        bh=VfQ96Z2Gl+Q2kZ1MiUCHenWai9OOy6ikjvJF64tlRcw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XDu9uLuGPdRPxcXXvTZfG6/eeAjzYvDFRmtmsMGOzGWmG0q6y/aVjd8YbSfTTH+9l
         duyUvKoD71A3yE+uQnY2yufhOpVHe8rGyANjffSphWoGI/Y8Ru1XekVeaFaJgjRQSn
         Jq8StacSVUkC91JzhgqOYgNhuzEUY6byxA3prXWw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.5 163/211] blk-mq: prealloc tags when increase tagset nr_hw_queues
Date:   Wed, 20 Sep 2023 13:30:07 +0200
Message-ID: <20230920112850.941684982@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chengming Zhou <zhouchengming@bytedance.com>

commit 7222657e51b5626d10154b3e48ad441c33b5da96 upstream.

Just like blk_mq_alloc_tag_set(), it's better to prepare all tags before
using to map to queue ctxs in blk_mq_map_swqueue(), which now have to
consider empty set->tags[].

The good point is that we can fallback easily if increasing nr_hw_queues
fail, instead of just mapping to hctx[0] when fail in blk_mq_map_swqueue().

And the fallback path already has tags free & clean handling, so all
is good.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20230821095602.70742-3-chengming.zhou@linux.dev
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-mq.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4420,6 +4420,16 @@ static int blk_mq_realloc_tag_set_tags(s
 		       sizeof(*set->tags));
 	kfree(set->tags);
 	set->tags = new_tags;
+
+	for (i = set->nr_hw_queues; i < new_nr_hw_queues; i++) {
+		if (!__blk_mq_alloc_map_and_rqs(set, i)) {
+			while (--i >= set->nr_hw_queues)
+				__blk_mq_free_map_and_rqs(set, i);
+			return -ENOMEM;
+		}
+		cond_resched();
+	}
+
 done:
 	set->nr_hw_queues = new_nr_hw_queues;
 	return 0;



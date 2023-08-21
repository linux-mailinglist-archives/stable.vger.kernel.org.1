Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5298478327B
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjHUUE6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjHUUE6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:04:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2CDA8
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:04:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D6EF648E9
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:04:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39710C433C8;
        Mon, 21 Aug 2023 20:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648295;
        bh=C5q3SOTBD4NfhERyVb5s13TlF2jrebvsEOI2F/8obsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SdF2QwvQmCnVDQxveK1r8dWzfKhE7ExSfvD/wLjdVvA5CTndzZUPjXCiI6wJsXb9p
         wuooCBSDCOC4Dnx2V3ANDPEbSpZYT8eUaKRgcIWy+4i5D4mNl2dqg89SbR78+8sbf/
         75PjpKVBsRFrLIR/I/pQxHmVIdj0z5nJFUnbPlAU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yu Kuai <yukuai3@huawei.com>,
        xiaoli feng <xifeng@redhat.com>, Chunyu Hu <chuhu@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, Tejun Heo <tj@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.4 096/234] blk-cgroup: hold queue_lock when removing blkg->q_node
Date:   Mon, 21 Aug 2023 21:40:59 +0200
Message-ID: <20230821194133.054232282@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

commit c164c7bc9775be7bcc68754bb3431fce5823822e upstream.

When blkg is removed from q->blkg_list from blkg_free_workfn(), queue_lock
has to be held, otherwise, all kinds of bugs(list corruption, hard lockup,
..) can be triggered from blkg_destroy_all().

Fixes: f1c006f1c685 ("blk-cgroup: synchronize pd_free_fn() from blkg_free_workfn() and blkcg_deactivate_policy()")
Cc: Yu Kuai <yukuai3@huawei.com>
Cc: xiaoli feng <xifeng@redhat.com>
Cc: Chunyu Hu <chuhu@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20230817141751.1128970-1-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-cgroup.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -136,7 +136,9 @@ static void blkg_free_workfn(struct work
 			blkcg_policy[i]->pd_free_fn(blkg->pd[i]);
 	if (blkg->parent)
 		blkg_put(blkg->parent);
+	spin_lock_irq(&q->queue_lock);
 	list_del_init(&blkg->q_node);
+	spin_unlock_irq(&q->queue_lock);
 	mutex_unlock(&q->blkcg_mutex);
 
 	blk_put_queue(q);



Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E310F6FA988
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235294AbjEHKwi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235268AbjEHKwK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:52:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8867A1A480
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:51:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6897662949
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:51:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69936C433EF;
        Mon,  8 May 2023 10:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543100;
        bh=Urn5vg1mBdvCq+wg7pN/rwfg92IUT9GVI8Z68g60H/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0T5Zt5SyFp1uq45TcxOprngBrKGs4jiGi7j6JSCBtmm3rLB9XfB8Q0w+/64Y7uyz+
         g+wDa5mpFPjJLrVYu0DMD9BDIMQeY8mzaLUd1mG/6v8w3li3oEOWxH5mdK5DYVeNdL
         8w1oGypB46/ZIZp+fJldyA1EaYHBpsbB2EW1rcvw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zheng Zhang <zheng.zhang@email.ucr.edu>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH 6.2 649/663] dm ioctl: fix nested locking in table_clear() to remove deadlock concern
Date:   Mon,  8 May 2023 11:47:55 +0200
Message-Id: <20230508094451.141284520@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mike Snitzer <snitzer@kernel.org>

commit 3d32aaa7e66d5c1479a3c31d6c2c5d45dd0d3b89 upstream.

syzkaller found the following problematic rwsem locking (with write
lock already held):

 down_read+0x9d/0x450 kernel/locking/rwsem.c:1509
 dm_get_inactive_table+0x2b/0xc0 drivers/md/dm-ioctl.c:773
 __dev_status+0x4fd/0x7c0 drivers/md/dm-ioctl.c:844
 table_clear+0x197/0x280 drivers/md/dm-ioctl.c:1537

In table_clear, it first acquires a write lock
https://elixir.bootlin.com/linux/v6.2/source/drivers/md/dm-ioctl.c#L1520
down_write(&_hash_lock);

Then before the lock is released at L1539, there is a path shown above:
table_clear -> __dev_status -> dm_get_inactive_table ->  down_read
https://elixir.bootlin.com/linux/v6.2/source/drivers/md/dm-ioctl.c#L773
down_read(&_hash_lock);

It tries to acquire the same read lock again, resulting in the deadlock
problem.

Fix this by moving table_clear()'s __dev_status() call to after its
up_write(&_hash_lock);

Cc: stable@vger.kernel.org
Reported-by: Zheng Zhang <zheng.zhang@email.ucr.edu>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-ioctl.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1539,11 +1539,12 @@ static int table_clear(struct file *filp
 		has_new_map = true;
 	}
 
-	param->flags &= ~DM_INACTIVE_PRESENT_FLAG;
-
-	__dev_status(hc->md, param);
 	md = hc->md;
 	up_write(&_hash_lock);
+
+	param->flags &= ~DM_INACTIVE_PRESENT_FLAG;
+	__dev_status(md, param);
+
 	if (old_map) {
 		dm_sync_table(md);
 		dm_table_destroy(old_map);



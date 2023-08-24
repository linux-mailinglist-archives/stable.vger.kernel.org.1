Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F657876BB
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 19:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242556AbjHXRTH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 13:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242863AbjHXRS6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 13:18:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6222E50
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 10:18:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AB526750B
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 17:18:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1A9C433C8;
        Thu, 24 Aug 2023 17:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692897534;
        bh=uxzaPKdAypYU2TiA64o10bJy43fivCqpSFD6Cc4ExV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pM2FQXQe7A3t7pVfeNYlaOmISviMjjrct0HVGzmJsuerEIvsACul08qVfE9DzVmcL
         PgkUHZr/vXFNk5zk5MDdnjvGX1Nhs6b/xP4vLjM3DtgNtQ+HLv0tUUHJgQBy+4UWqS
         8LUzdeV9J2mCk6gFEgohBYEQxvqQ4yfFWKXaxY/s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, xiaoshoukui <xiaoshoukui@ruijie.com.cn>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.10 074/135] btrfs: fix BUG_ON condition in btrfs_cancel_balance
Date:   Thu, 24 Aug 2023 19:09:06 +0200
Message-ID: <20230824170620.428719506@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824170617.074557800@linuxfoundation.org>
References: <20230824170617.074557800@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: xiaoshoukui <xiaoshoukui@gmail.com>

commit 29eefa6d0d07e185f7bfe9576f91e6dba98189c2 upstream.

Pausing and canceling balance can race to interrupt balance lead to BUG_ON
panic in btrfs_cancel_balance. The BUG_ON condition in btrfs_cancel_balance
does not take this race scenario into account.

However, the race condition has no other side effects. We can fix that.

Reproducing it with panic trace like this:

  kernel BUG at fs/btrfs/volumes.c:4618!
  RIP: 0010:btrfs_cancel_balance+0x5cf/0x6a0
  Call Trace:
   <TASK>
   ? do_nanosleep+0x60/0x120
   ? hrtimer_nanosleep+0xb7/0x1a0
   ? sched_core_clone_cookie+0x70/0x70
   btrfs_ioctl_balance_ctl+0x55/0x70
   btrfs_ioctl+0xa46/0xd20
   __x64_sys_ioctl+0x7d/0xa0
   do_syscall_64+0x38/0x80
   entry_SYSCALL_64_after_hwframe+0x63/0xcd

  Race scenario as follows:
  > mutex_unlock(&fs_info->balance_mutex);
  > --------------------
  > .......issue pause and cancel req in another thread
  > --------------------
  > ret = __btrfs_balance(fs_info);
  >
  > mutex_lock(&fs_info->balance_mutex);
  > if (ret == -ECANCELED && atomic_read(&fs_info->balance_pause_req)) {
  >         btrfs_info(fs_info, "balance: paused");
  >         btrfs_exclop_balance(fs_info, BTRFS_EXCLOP_BALANCE_PAUSED);
  > }

CC: stable@vger.kernel.org # 4.19+
Signed-off-by: xiaoshoukui <xiaoshoukui@ruijie.com.cn>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/volumes.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4460,8 +4460,7 @@ int btrfs_cancel_balance(struct btrfs_fs
 		}
 	}
 
-	BUG_ON(fs_info->balance_ctl ||
-		test_bit(BTRFS_FS_BALANCE_RUNNING, &fs_info->flags));
+	ASSERT(!test_bit(BTRFS_FS_BALANCE_RUNNING, &fs_info->flags));
 	atomic_dec(&fs_info->balance_cancel_req);
 	mutex_unlock(&fs_info->balance_mutex);
 	return 0;



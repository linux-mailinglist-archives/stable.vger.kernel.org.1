Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F4275545B
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbjGPU3e (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbjGPU3d (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:29:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CF59F
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:29:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76E1A60EBB
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:29:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C6AC433C8;
        Sun, 16 Jul 2023 20:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539371;
        bh=TPN4eboNSU9FTdcGiI1lPpiBQSxXZybB9e7GNfEhcUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eNRhFbwEMZ+S3bl1gQcGD75Qmnl4JpFeAuoQQQ8AqoaF5KuEWoNpVzBe9gDXq3B32
         JbBfH7agpqW15eeJ3Ty0XHMjb0gHztm0kBgE6cNUFY9be/dfcRq1HwtJiHia+p5N8p
         fzptBq/dWFwr3FkaeBugfH5rKgxZshz7G/kxaWWM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Filipe Manana <fdmanana@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 6.4 757/800] btrfs: delete unused BGs while reclaiming BGs
Date:   Sun, 16 Jul 2023 21:50:10 +0200
Message-ID: <20230716195006.726194975@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Naohiro Aota <naota@elisp.net>

commit 3ed01616bad6c7e3de196676b542ae3df8058592 upstream.

The reclaiming process only starts after the filesystem volumes are
allocated to a certain level (75% by default). Thus, the list of
reclaiming target block groups can build up so huge at the time the
reclaim process kicks in. On a test run, there were over 1000 BGs in the
reclaim list.

As the reclaim involves rewriting the data, it takes really long time to
reclaim the BGs. While the reclaim is running, btrfs_delete_unused_bgs()
won't proceed because the reclaim side is holding
fs_info->reclaim_bgs_lock. As a result, we will have a large number of
unused BGs kept in the unused list. On my test run, I got 1057 unused BGs.

Since deleting a block group is relatively easy and fast work, we can call
btrfs_delete_unused_bgs() while it reclaims BGs, to avoid building up
unused BGs.

Fixes: 18bb8bbf13c1 ("btrfs: zoned: automatically reclaim zones")
CC: stable@vger.kernel.org # 5.15+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/block-group.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1831,10 +1831,24 @@ void btrfs_reclaim_bgs_work(struct work_
 
 next:
 		btrfs_put_block_group(bg);
+
+		mutex_unlock(&fs_info->reclaim_bgs_lock);
+		/*
+		 * Reclaiming all the block groups in the list can take really
+		 * long.  Prioritize cleaning up unused block groups.
+		 */
+		btrfs_delete_unused_bgs(fs_info);
+		/*
+		 * If we are interrupted by a balance, we can just bail out. The
+		 * cleaner thread restart again if necessary.
+		 */
+		if (!mutex_trylock(&fs_info->reclaim_bgs_lock))
+			goto end;
 		spin_lock(&fs_info->unused_bgs_lock);
 	}
 	spin_unlock(&fs_info->unused_bgs_lock);
 	mutex_unlock(&fs_info->reclaim_bgs_lock);
+end:
 	btrfs_exclop_finish(fs_info);
 	sb_end_write(fs_info->sb);
 }



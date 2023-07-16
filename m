Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D02755707
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbjGPU4e (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbjGPU4d (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:56:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A62E4B
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:56:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00F4560E9E
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:56:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147B0C433C7;
        Sun, 16 Jul 2023 20:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540988;
        bh=qyaMtAGlANZUAtjWELoeezFYeOaiLokf8RR7jSEW7EI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LQ+cBS2lwVFsqWKy3Cg+2FKoJ0iXrDQG+tMIi8o818KthJGXpaSQKwDWV3PtykhlO
         sWN5dbQXMh+OrwqYlQzFsAKCtZkHyJBzbltnr63c9nLkLRO8JXbGvUG/HUnFG+NzDQ
         qDRfoGTeNewT9TFSPoPzbIhg4Nuux1j71eIy3qrw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Filipe Manana <fdmanana@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 6.1 560/591] btrfs: move out now unused BG from the reclaim list
Date:   Sun, 16 Jul 2023 21:51:39 +0200
Message-ID: <20230716194938.344875552@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
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

commit a9f189716cf15913c453299d72f69c51a9b0f86b upstream.

An unused block group is easy to remove to free up space and should be
reclaimed fast. Such block group can often already be a target of the
reclaim process. As we check list_empty(&bg->bg_list), we keep it in the
reclaim list. That block group is never reclaimed until the file system
is filled e.g. up to 75%.

Instead, we can move unused block group to the unused list and delete it
fast.

Fixes: 18bb8bbf13c1 ("btrfs: zoned: automatically reclaim zones")
CC: stable@vger.kernel.org # 5.15+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/block-group.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1503,11 +1503,14 @@ void btrfs_mark_bg_unused(struct btrfs_b
 {
 	struct btrfs_fs_info *fs_info = bg->fs_info;
 
+	trace_btrfs_add_unused_block_group(bg);
 	spin_lock(&fs_info->unused_bgs_lock);
 	if (list_empty(&bg->bg_list)) {
 		btrfs_get_block_group(bg);
-		trace_btrfs_add_unused_block_group(bg);
 		list_add_tail(&bg->bg_list, &fs_info->unused_bgs);
+	} else {
+		/* Pull out the block group from the reclaim_bgs list. */
+		list_move_tail(&bg->bg_list, &fs_info->unused_bgs);
 	}
 	spin_unlock(&fs_info->unused_bgs_lock);
 }



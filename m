Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50151787284
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 16:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241862AbjHXOyj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 10:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241876AbjHXOyT (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 10:54:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3813E10D7
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 07:54:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3A4D66457
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 14:54:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D8DC433C7;
        Thu, 24 Aug 2023 14:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692888857;
        bh=Na26/LHSTxghy5O7pY7BhTFMHTJAF9aPdtKv12Om0KU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=13mRVd96zD0Xv552fkQkUsbJx0MsaNtfu5tr41XwMnxiZVzSItWH4Lj80bHA5xMwL
         AqxXMRs0l5Ny9EXvODXv1OcRDijiyYrvn3AU/e8Os4ZfwYLi+joqZH8EcrJuFKAkDb
         x6m8HqZ63gTFw+zqvpsLpJucaqH1QGtIBMcQ2hfM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Filipe Manana <fdmanana@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 066/139] btrfs: move out now unused BG from the reclaim list
Date:   Thu, 24 Aug 2023 16:49:49 +0200
Message-ID: <20230824145026.527997766@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145023.559380953@linuxfoundation.org>
References: <20230824145023.559380953@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Naohiro Aota <naota@elisp.net>

[ Upstream commit a9f189716cf15913c453299d72f69c51a9b0f86b ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/block-group.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index d24cef671c1aa..4ca6828586af5 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1475,11 +1475,14 @@ void btrfs_mark_bg_unused(struct btrfs_block_group *bg)
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
-- 
2.40.1




Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FC873E935
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjFZSdc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbjFZSdb (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:33:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A85AC
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:33:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1AAE60F45
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:33:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC738C433C8;
        Mon, 26 Jun 2023 18:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804409;
        bh=Fd4saYOK9ypMr4Uy3KAKwn8wSqzhoTf5+Mj1UgUwJSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C37p9qwG2pykdm2UAiixBunU20SUYz0rJ4KDpYBdLGYtvY5j/Cp+PX5hL40hxR0pR
         Vc58LB/EpGBOqZn+gdKl3sDkQn6FKS60UozN767+6SBsXK5RY/g6H2sE3cTebvlRvB
         r39WLXRoZ4wnA6HMyQLVz0fUKQMlBIc174QICV+U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, k2ci <kernel-bot@kylinos.cn>,
        Anand Jain <anand.jain@oracle.com>,
        Shida Zhang <zhangshida@kylinos.cn>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 139/170] btrfs: fix an uninitialized variable warning in btrfs_log_inode
Date:   Mon, 26 Jun 2023 20:11:48 +0200
Message-ID: <20230626180806.791542607@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
References: <20230626180800.476539630@linuxfoundation.org>
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

From: Shida Zhang <zhangshida@kylinos.cn>

[ Upstream commit 8fd9f4232d8152c650fd15127f533a0f6d0a4b2b ]

This fixes the following warning reported by gcc 10.2.1 under x86_64:

../fs/btrfs/tree-log.c: In function ‘btrfs_log_inode’:
../fs/btrfs/tree-log.c:6211:9: error: ‘last_range_start’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
 6211 |   ret = insert_dir_log_key(trans, log, path, key.objectid,
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 6212 |       first_dir_index, last_dir_index);
      |       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../fs/btrfs/tree-log.c:6161:6: note: ‘last_range_start’ was declared here
 6161 |  u64 last_range_start;
      |      ^~~~~~~~~~~~~~~~

This might be a false positive fixed in later compiler versions but we
want to have it fixed.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/tree-log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index e71464c0e4667..00be69ce7b90f 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6205,7 +6205,7 @@ static int log_delayed_deletions_incremental(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_root *log = inode->root->log_root;
 	const struct btrfs_delayed_item *curr;
-	u64 last_range_start;
+	u64 last_range_start = 0;
 	u64 last_range_end = 0;
 	struct btrfs_key key;
 
-- 
2.39.2




Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFE8775BD2
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbjHILVZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbjHILVY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:21:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1392AFA
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:21:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D3A2631ED
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:21:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD41C433C8;
        Wed,  9 Aug 2023 11:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580083;
        bh=h4sb3l1f45CrUkwpXuPL82M6AZV5h4R6sGrLY06Ppqc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fClq33XPB9liLeSHB/mq2vvM3b8Ca8j5VEM1kxZj76Ina0WTItqqs3DyBEYsca5BA
         iT6MBnCISUILLUbevLXoJnKX9ci+oJJzY6+gEkdNEHwatiE0A1c+wgo8bf27bShN2a
         +67QCrQ6glhokOMl29iepNTytkJaA9j2usaVjqb4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Qu Wenruo <wqu@suse.com>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 221/323] btrfs: fix extent buffer leak after tree mod log failure at split_node()
Date:   Wed,  9 Aug 2023 12:40:59 +0200
Message-ID: <20230809103708.215173679@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit ede600e497b1461d06d22a7d17703d9096868bc3 ]

At split_node(), if we fail to log the tree mod log copy operation, we
return without unlocking the split extent buffer we just allocated and
without decrementing the reference we own on it. Fix this by unlocking
it and decrementing the ref count before returning.

Fixes: 5de865eebb83 ("Btrfs: fix tree mod logging")
CC: stable@vger.kernel.org # 5.4+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/ctree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 34d56f0fa7501..e48c6d7a860f4 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -3590,6 +3590,8 @@ static noinline int split_node(struct btrfs_trans_handle *trans,
 
 	ret = tree_mod_log_eb_copy(fs_info, split, c, 0, mid, c_nritems - mid);
 	if (ret) {
+		btrfs_tree_unlock(split);
+		free_extent_buffer(split);
 		btrfs_abort_transaction(trans, ret);
 		return ret;
 	}
-- 
2.39.2




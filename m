Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9566D755709
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbjGPU4k (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbjGPU4i (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:56:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FA7E51
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:56:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 848E460E9E
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:56:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96F1FC433C7;
        Sun, 16 Jul 2023 20:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540994;
        bh=RFS0HhjUudssGt59fZUw8MvUc3HdKHdWQsfjKNPDqMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GkxNwHnlGdbPFWwOcfyvHspBXRp3Hivi4laDJOJklxskYdAdup//1z4FV8k+y4mZw
         KLE1FiMjyIKCyplbB1fLO8dtReUf6uOuN9YiDrJOyAlNDoLmoVaC2+G1sNizaVXg3l
         PgVfRSYhSBNk/SiT+Fje9qhxky49vNi6K3zFk3f0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Qu Wenruo <wqu@suse.com>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 6.1 562/591] btrfs: fix extent buffer leak after tree mod log failure at split_node()
Date:   Sun, 16 Jul 2023 21:51:41 +0200
Message-ID: <20230716194938.397142861@linuxfoundation.org>
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

From: Filipe Manana <fdmanana@suse.com>

commit ede600e497b1461d06d22a7d17703d9096868bc3 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/ctree.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2861,6 +2861,8 @@ static noinline int split_node(struct bt
 
 	ret = btrfs_tree_mod_log_eb_copy(split, c, 0, mid, c_nritems - mid);
 	if (ret) {
+		btrfs_tree_unlock(split);
+		free_extent_buffer(split);
 		btrfs_abort_transaction(trans, ret);
 		return ret;
 	}



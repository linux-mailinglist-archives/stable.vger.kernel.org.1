Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A0A72BFDD
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjFLKrc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjFLKrT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:47:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248A576B9
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:32:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC640623CE
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:31:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52DCC433D2;
        Mon, 12 Jun 2023 10:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686565910;
        bh=OZbe/Cq7omvPd1un4y5/vDe2jgq1Pve2H9PXDZsWSk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NUHHXfAdVtV0ky2XeOJQFGn2DyPbXnGMGOad+8pEvdrYSM3OFz4kh+Nr7Mopq4aaM
         9lqrkuCpdVRbycUUNToIQ2CmMWYGsmDzbqnUK7k07xg2TKbczzcGjXsSy5ct7NNm9v
         cUdgNQc/QdF3CcdGMRfFImI7g0/WCsX3a1IM3dds=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Theodore Tso <tytso@mit.edu>
Subject: [PATCH 5.4 37/45] ext4: only check dquot_initialize_needed() when debugging
Date:   Mon, 12 Jun 2023 12:26:31 +0200
Message-ID: <20230612101656.174786844@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101654.644983109@linuxfoundation.org>
References: <20230612101654.644983109@linuxfoundation.org>
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

From: Theodore Ts'o <tytso@mit.edu>

commit dea9d8f7643fab07bf89a1155f1f94f37d096a5e upstream.

ext4_xattr_block_set() relies on its caller to call dquot_initialize()
on the inode.  To assure that this has happened there are WARN_ON
checks.  Unfortunately, this is subject to false positives if there is
an antagonist thread which is flipping the file system at high rates
between r/o and rw.  So only do the check if EXT4_XATTR_DEBUG is
enabled.

Link: https://lore.kernel.org/r/20230608044056.GA1418535@mit.edu
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/xattr.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2016,8 +2016,9 @@ inserted:
 			else {
 				u32 ref;
 
+#ifdef EXT4_XATTR_DEBUG
 				WARN_ON_ONCE(dquot_initialize_needed(inode));
-
+#endif
 				/* The old block is released after updating
 				   the inode. */
 				error = dquot_alloc_block(inode,
@@ -2079,8 +2080,9 @@ inserted:
 			/* We need to allocate a new block */
 			ext4_fsblk_t goal, block;
 
+#ifdef EXT4_XATTR_DEBUG
 			WARN_ON_ONCE(dquot_initialize_needed(inode));
-
+#endif
 			goal = ext4_group_first_block_no(sb,
 						EXT4_I(inode)->i_block_group);
 			block = ext4_new_meta_blocks(handle, inode, goal, 0,



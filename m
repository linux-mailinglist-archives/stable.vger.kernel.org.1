Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29258726FF2
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 23:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236150AbjFGVD0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 17:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236056AbjFGVDJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 17:03:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF91C2D76
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 14:02:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6BF861EA2
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 21:02:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5629C433D2;
        Wed,  7 Jun 2023 21:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171757;
        bh=E/dEAXxrfbv8BVxEW/QkPa1yO6paHAzqy4MKjBPtG9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IVOtrYNZWtI3aTE3caO1R6ZjjWrOBwxAgMFJL+bCRtQt2IMxXE0Vf8GhGczIhhxwy
         GERiy5J/IS4z0OHlYPrjtHJLJLOlYvASRzNGiZP+P3Jr/meLSOWuRrSQd7nVuUzLsm
         dgI378oDnh34pFqwtxcwXxprPwB0thLL6g4HA1OY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        syzbot+d4b971e744b1f5439336@syzkaller.appspotmail.com,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 5.15 137/159] ext4: set lockdep subclass for the ea_inode in ext4_xattr_inode_cache_find()
Date:   Wed,  7 Jun 2023 22:17:20 +0200
Message-ID: <20230607200908.153687894@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200903.652580797@linuxfoundation.org>
References: <20230607200903.652580797@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Theodore Ts'o <tytso@mit.edu>

commit b928dfdcb27d8fa59917b794cfba53052a2f050f upstream.

If the ea_inode has been pushed out of the inode cache while there is
still a reference in the mb_cache, the lockdep subclass will not be
set on the inode, which can lead to some lockdep false positives.

Fixes: 33d201e0277b ("ext4: fix lockdep warning about recursive inode locking")
Cc: stable@kernel.org
Reported-by: syzbot+d4b971e744b1f5439336@syzkaller.appspotmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Link: https://lore.kernel.org/r/20230524034951.779531-3-tytso@mit.edu
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/xattr.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1490,6 +1490,7 @@ ext4_xattr_inode_cache_find(struct inode
 				     EXT4_IGET_EA_INODE);
 		if (IS_ERR(ea_inode))
 			goto next_entry;
+		ext4_xattr_inode_set_class(ea_inode);
 		if (i_size_read(ea_inode) == value_len &&
 		    !ext4_xattr_inode_read(ea_inode, ea_data, value_len) &&
 		    !ext4_xattr_inode_verify_hashes(ea_inode, NULL, ea_data,



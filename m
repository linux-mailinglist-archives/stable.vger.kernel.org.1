Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD224726C61
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbjFGUdO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbjFGUdN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:33:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED02213D
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:33:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D38B264528
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:33:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3769C433EF;
        Wed,  7 Jun 2023 20:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169982;
        bh=ryAirADRq97SZESUS9GJ6TB/4LdEQAzaox0+dkbWTXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zU7yEvP4ClHBy3UAieNcggVBjhq9OP6vxQO2SfZCb4uWfZlEVBVGgzoXiiH8i5fqU
         u8fcul/mRjyRSW/36+4r82PTuAu6LOrB+qZYjNkv/7FlrCnpY6KwkbtcPvsZEYK4dI
         zXmFXARh723z3qtY0HnB1gU4TRL1uD0QRJQYX6XA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        syzbot+d4b971e744b1f5439336@syzkaller.appspotmail.com,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 6.3 260/286] ext4: set lockdep subclass for the ea_inode in ext4_xattr_inode_cache_find()
Date:   Wed,  7 Jun 2023 22:15:59 +0200
Message-ID: <20230607200931.806729667@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
@@ -1540,6 +1540,7 @@ ext4_xattr_inode_cache_find(struct inode
 				     EXT4_IGET_EA_INODE);
 		if (IS_ERR(ea_inode))
 			goto next_entry;
+		ext4_xattr_inode_set_class(ea_inode);
 		if (i_size_read(ea_inode) == value_len &&
 		    !ext4_xattr_inode_read(ea_inode, ea_data, value_len) &&
 		    !ext4_xattr_inode_verify_hashes(ea_inode, NULL, ea_data,



Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A48F726C63
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbjFGUdR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbjFGUdR (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:33:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6177B2102
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:33:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38A476452D
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:33:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AFB4C433D2;
        Wed,  7 Jun 2023 20:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169987;
        bh=duYsHaa5YRXM1i3ehZPvSHSXPpt2MOh/CM0cGJdLbJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ws7nrP1wVTOwVzlRr4IRk9aDH23rJ0tA8HuuoH3+4n4iG23pcTGHvbCmrzw5hrzUk
         9LfYkNBW49HvvwzOJ3N3jruZpjs931IbEFFwZnyAOGFzCrkcaVFutn7FGx/Z5HIdHR
         lHs1tTvzx6w+ky7eIU1L4lyAN8sfn4jGE0QRAJGY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        syzbot+298c5d8fb4a128bc27b0@syzkaller.appspotmail.com,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 6.3 262/286] ext4: add lockdep annotations for i_data_sem for ea_inodes
Date:   Wed,  7 Jun 2023 22:16:01 +0200
Message-ID: <20230607200931.870784089@linuxfoundation.org>
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

commit aff3bea95388299eec63440389b4545c8041b357 upstream.

Treat i_data_sem for ea_inodes as being in their own lockdep class to
avoid lockdep complaints about ext4_setattr's use of inode_lock() on
normal inodes potentially causing lock ordering with i_data_sem on
ea_inodes in ext4_xattr_inode_write().  However, ea_inodes will be
operated on by ext4_setattr(), so this isn't a problem.

Cc: stable@kernel.org
Link: https://syzkaller.appspot.com/bug?extid=298c5d8fb4a128bc27b0
Reported-by: syzbot+298c5d8fb4a128bc27b0@syzkaller.appspotmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Link: https://lore.kernel.org/r/20230524034951.779531-5-tytso@mit.edu
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/ext4.h  |    2 ++
 fs/ext4/xattr.c |    4 ++++
 2 files changed, 6 insertions(+)

--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1007,11 +1007,13 @@ do {									       \
  *			  where the second inode has larger inode number
  *			  than the first
  *  I_DATA_SEM_QUOTA  - Used for quota inodes only
+ *  I_DATA_SEM_EA     - Used for ea_inodes only
  */
 enum {
 	I_DATA_SEM_NORMAL = 0,
 	I_DATA_SEM_OTHER,
 	I_DATA_SEM_QUOTA,
+	I_DATA_SEM_EA
 };
 
 
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -125,7 +125,11 @@ ext4_expand_inode_array(struct ext4_xatt
 #ifdef CONFIG_LOCKDEP
 void ext4_xattr_inode_set_class(struct inode *ea_inode)
 {
+	struct ext4_inode_info *ei = EXT4_I(ea_inode);
+
 	lockdep_set_subclass(&ea_inode->i_rwsem, 1);
+	(void) ei;	/* shut up clang warning if !CONFIG_LOCKDEP */
+	lockdep_set_subclass(&ei->i_data_sem, I_DATA_SEM_EA);
 }
 #endif
 



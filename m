Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7C4726EC0
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235262AbjFGUwa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235280AbjFGUwY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:52:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DBBE79
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:52:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1406A64764
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:52:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2874AC433EF;
        Wed,  7 Jun 2023 20:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171142;
        bh=93y0fy3jAXlSvG0Uv7InDyw1KvoaHnvub+n/ZAk6SXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nwwkEDvHN+wrOSGv4l08QLpRpXIIofoiOYPs9acGaZANWo9i7NspOoqSjJD9OFCfy
         Tf8kBZeH5iLFtTsUInSqOPuI+q6eWHTeDlkU9nqSisCmyvROi4IBcH+psSBWUlxFr9
         dL6nTGhhYHdEJZpJhTOb0Mj8o1Ev/CnxjzmSMeW8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        syzbot+e44749b6ba4d0434cd47@syzkaller.appspotmail.com,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 5.10 101/120] ext4: disallow ea_inodes with extended attributes
Date:   Wed,  7 Jun 2023 22:16:57 +0200
Message-ID: <20230607200904.096230979@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200900.915613242@linuxfoundation.org>
References: <20230607200900.915613242@linuxfoundation.org>
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

commit 2bc7e7c1a3bc9bd0cbf0f71006f6fe7ef24a00c2 upstream.

An ea_inode stores the value of an extended attribute; it can not have
extended attributes itself, or this will cause recursive nightmares.
Add a check in ext4_iget() to make sure this is the case.

Cc: stable@kernel.org
Reported-by: syzbot+e44749b6ba4d0434cd47@syzkaller.appspotmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Link: https://lore.kernel.org/r/20230524034951.779531-4-tytso@mit.edu
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/inode.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4686,6 +4686,9 @@ static const char *check_igot_inode(stru
 	if (flags & EXT4_IGET_EA_INODE) {
 		if (!(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL))
 			return "missing EA_INODE flag";
+		if (ext4_test_inode_state(inode, EXT4_STATE_XATTR) ||
+		    EXT4_I(inode)->i_file_acl)
+			return "ea_inode with extended attributes";
 	} else {
 		if ((EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL))
 			return "unexpected EA_INODE flag";



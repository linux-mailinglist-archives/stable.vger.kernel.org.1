Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D468C726C62
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbjFGUdQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbjFGUdP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:33:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D672680
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:33:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93494644CE
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:33:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F406C433D2;
        Wed,  7 Jun 2023 20:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169985;
        bh=gIrpZpxqj2DyurvKFclCP8BFpxcD1gYPzqvWChT/VT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F7WC5jcJBy1i/2RLc+N/Zb66nAj5lzbun1aV6ohHum26aKDII8BHHgY60Vs4suTOW
         NSfqHe87ailoi2ZRBO+zJNUp3bnxJrNrLoTDB3IdK48At9ZQ/A2sVlyqnlHBCB9Zhb
         rIJFelH/V92sjN7o9HFNIa3LPu6pn9xLIySp8aUo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        syzbot+e44749b6ba4d0434cd47@syzkaller.appspotmail.com,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 6.3 261/286] ext4: disallow ea_inodes with extended attributes
Date:   Wed,  7 Jun 2023 22:16:00 +0200
Message-ID: <20230607200931.838530800@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
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
@@ -4841,6 +4841,9 @@ static const char *check_igot_inode(stru
 	if (flags & EXT4_IGET_EA_INODE) {
 		if (!(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL))
 			return "missing EA_INODE flag";
+		if (ext4_test_inode_state(inode, EXT4_STATE_XATTR) ||
+		    EXT4_I(inode)->i_file_acl)
+			return "ea_inode with extended attributes";
 	} else {
 		if ((EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL))
 			return "unexpected EA_INODE flag";



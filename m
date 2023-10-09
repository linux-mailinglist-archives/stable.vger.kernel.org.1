Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1667BDD4A
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376741AbjJINJU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376736AbjJINJT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:09:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AA88F
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:09:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C6BC433C9;
        Mon,  9 Oct 2023 13:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696856957;
        bh=e1uZ4AEJYrs58ypu8pc1rZc9SlrGLusJIwAHVUeFQJQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VhQz0nRm5WewOc5q1jRuA92/telqfCH9v2dWf4jCYRWfiHDasYMytIqAFeTy8mCiT
         VEEe9DnzDL7BwpvXSiLDa87rCfeUU7AU1Qm2kmCP1YqVhCqk+9+3pdNi19Sh1geet6
         F75o2zV+OMhmnE9RekpQM/kwEhP/1ZFv9L6aMmUg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Qu Wenruo <wqu@suse.com>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 6.5 048/163] btrfs: always print transaction aborted messages with an error level
Date:   Mon,  9 Oct 2023 15:00:12 +0200
Message-ID: <20231009130125.356987460@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

commit f8d1b011ca8c9d64ce32da431a8420635a96958a upstream.

Commit b7af0635c87f ("btrfs: print transaction aborted messages with an
error level") changed the log level of transaction aborted messages from
a debug level to an error level, so that such messages are always visible
even on production systems where the log level is normally above the debug
level (and also on some syzbot reports).

Later, commit fccf0c842ed4 ("btrfs: move btrfs_abort_transaction to
transaction.c") changed the log level back to debug level when the error
number for a transaction abort should not have a stack trace printed.
This happened for absolutely no reason. It's always useful to print
transaction abort messages with an error level, regardless of whether
the error number should cause a stack trace or not.

So change back the log level to error level.

Fixes: fccf0c842ed4 ("btrfs: move btrfs_abort_transaction to transaction.c")
CC: stable@vger.kernel.org # 6.5+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/transaction.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -218,8 +218,8 @@ do {								\
 			(errno))) {					\
 			/* Stack trace printed. */			\
 		} else {						\
-			btrfs_debug((trans)->fs_info,			\
-				    "Transaction aborted (error %d)", \
+			btrfs_err((trans)->fs_info,			\
+				  "Transaction aborted (error %d)",	\
 				  (errno));			\
 		}						\
 	}							\



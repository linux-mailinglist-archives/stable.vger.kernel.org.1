Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86177A3CF4
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241169AbjIQUhY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241212AbjIQUhJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:37:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660C810F
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:37:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D278C433C7;
        Sun, 17 Sep 2023 20:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694983024;
        bh=hM+A9NhCJUkv/KZ6L2nuAMWUEbXXtXh1VUaTy+4LPiw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QJdUxyTNDAI+yIOOGygbYVbczE8cV9STCa3G8ZmldAaNhTsA1kvYr8RuaXYVonIw+
         zWL1lCf2z5XBjM9oEr4o0EWxpdu1ouQNfVRWsB2xbwBYmqHTOubueKF07ITGTACp+7
         Nlu3yKwX9TnuFXJ1T8diBw7NrOj6Eo0jmX+nENnA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 5.15 371/511] udf: initialize newblock to 0
Date:   Sun, 17 Sep 2023 21:13:18 +0200
Message-ID: <20230917191122.764853007@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tom Rix <trix@redhat.com>

commit 23970a1c9475b305770fd37bebfec7a10f263787 upstream.

The clang build reports this error
fs/udf/inode.c:805:6: error: variable 'newblock' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
        if (*err < 0)
            ^~~~~~~~
newblock is never set before error handling jump.
Initialize newblock to 0 and remove redundant settings.

Fixes: d8b39db5fab8 ("udf: Handle error when adding extent to a file")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Tom Rix <trix@redhat.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Message-Id: <20221230175341.1629734-1-trix@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/udf/inode.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -695,7 +695,7 @@ static sector_t inode_getblk(struct inod
 	struct kernel_lb_addr eloc, tmpeloc;
 	int c = 1;
 	loff_t lbcount = 0, b_off = 0;
-	udf_pblk_t newblocknum, newblock;
+	udf_pblk_t newblocknum, newblock = 0;
 	sector_t offset = 0;
 	int8_t etype;
 	struct udf_inode_info *iinfo = UDF_I(inode);
@@ -798,7 +798,6 @@ static sector_t inode_getblk(struct inod
 		ret = udf_do_extend_file(inode, &prev_epos, laarr, hole_len);
 		if (ret < 0) {
 			*err = ret;
-			newblock = 0;
 			goto out_free;
 		}
 		c = 0;
@@ -861,7 +860,6 @@ static sector_t inode_getblk(struct inod
 				goal, err);
 		if (!newblocknum) {
 			*err = -ENOSPC;
-			newblock = 0;
 			goto out_free;
 		}
 		if (isBeyondEOF)



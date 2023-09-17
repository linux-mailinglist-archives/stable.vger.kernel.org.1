Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502117A39C9
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240155AbjIQTyK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240180AbjIQTyC (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:54:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6B4EE
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:53:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A17C433C8;
        Sun, 17 Sep 2023 19:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980436;
        bh=S33edq4/IjUMOqhW+dfkeknk4czdlFWsmC/W88KH/tk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bxQ3NWIGS1uMDK3LXKwTo3tMhWw5Ubrn94Ys9HoVSdnRJ0N8AgecIYWDKuGx2em/Y
         dsg+stOWly0WMPeDtXwCtf/Lz2aIdtShbY7T2EMfdJjTO1TcvUUwntDlOyQMN8x0tw
         +XvdGk7cLqpPps0gwqqhhO+rHsGqmx8yiDkd7Zco=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 6.5 191/285] f2fs: get out of a repeat loop when getting a locked data page
Date:   Sun, 17 Sep 2023 21:13:11 +0200
Message-ID: <20230917191058.211820637@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jaegeuk Kim <jaegeuk@kernel.org>

commit d2d9bb3b6d2fbccb5b33d3a85a2830971625a4ea upstream.

https://bugzilla.kernel.org/show_bug.cgi?id=216050

Somehow we're getting a page which has a different mapping.
Let's avoid the infinite loop.

Cc: <stable@vger.kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/data.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1389,18 +1389,14 @@ struct page *f2fs_get_lock_data_page(str
 {
 	struct address_space *mapping = inode->i_mapping;
 	struct page *page;
-repeat:
+
 	page = f2fs_get_read_data_page(inode, index, 0, for_write, NULL);
 	if (IS_ERR(page))
 		return page;
 
 	/* wait for read completion */
 	lock_page(page);
-	if (unlikely(page->mapping != mapping)) {
-		f2fs_put_page(page, 1);
-		goto repeat;
-	}
-	if (unlikely(!PageUptodate(page))) {
+	if (unlikely(page->mapping != mapping || !PageUptodate(page))) {
 		f2fs_put_page(page, 1);
 		return ERR_PTR(-EIO);
 	}



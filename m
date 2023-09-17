Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E7B7A3B3B
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240619AbjIQUO6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240660AbjIQUOd (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:14:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40270100
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:14:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58CE8C433C8;
        Sun, 17 Sep 2023 20:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981667;
        bh=ZF/iJ2Wa6I6/z03+htBREgN1G+mO7hI6TjWirjRRP8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KtYeXG0tIDral+ixhOmluK5aELZlpbIFt1AM5WfyccFMUFH+tFtkE1ye4rXh2keKg
         HLHHob9I4sryQ6t2ktslnHjTh/TfgUu8Dq/+YGgvuokeoUMhzd7OrDKtOEA5TAgZiX
         SABFMp8LLtUQNiTel09Nz9zOkxZQVuBPC1w7+nY8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        butt3rflyh4ck <butterflyhuangxx@gmail.com>,
        Edward Shishkin <edward.shishkin@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 056/511] reiserfs: Check the return value from __getblk()
Date:   Sun, 17 Sep 2023 21:08:03 +0200
Message-ID: <20230917191115.240559946@linuxfoundation.org>
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

From: Matthew Wilcox <willy@infradead.org>

[ Upstream commit ba38980add7ffc9e674ada5b4ded4e7d14e76581 ]

__getblk() can return a NULL pointer if we run out of memory or if we
try to access beyond the end of the device; check it and handle it
appropriately.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Link: https://lore.kernel.org/lkml/CAFcO6XOacq3hscbXevPQP7sXRoYFz34ZdKPYjmd6k5sZuhGFDw@mail.gmail.com/
Tested-by: butt3rflyh4ck <butterflyhuangxx@gmail.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2") # probably introduced in 2002
Acked-by: Edward Shishkin <edward.shishkin@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/reiserfs/journal.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index 0834b101c316d..86a1dee6e2e7d 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -2323,7 +2323,7 @@ static struct buffer_head *reiserfs_breada(struct block_device *dev,
 	int i, j;
 
 	bh = __getblk(dev, block, bufsize);
-	if (buffer_uptodate(bh))
+	if (!bh || buffer_uptodate(bh))
 		return (bh);
 
 	if (block + BUFNR > max_block) {
@@ -2333,6 +2333,8 @@ static struct buffer_head *reiserfs_breada(struct block_device *dev,
 	j = 1;
 	for (i = 1; i < blocks; i++) {
 		bh = __getblk(dev, block + i, bufsize);
+		if (!bh)
+			break;
 		if (buffer_uptodate(bh)) {
 			brelse(bh);
 			break;
-- 
2.40.1




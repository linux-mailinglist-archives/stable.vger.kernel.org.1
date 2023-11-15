Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981817ECF41
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbjKOTrV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235263AbjKOTrU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:47:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A02AB
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:47:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE6AC433C7;
        Wed, 15 Nov 2023 19:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077637;
        bh=dJCSkS9B4JFtvNXif94u+qsHCxPD+7+oZ4s3MCdSYO8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aEldTvIH+OdZBqvRuQwjisRNX5yEMiNFt+V8I9QIbmRxBHSv4D08eZI6lwFR/UEsl
         UeS9YaqbW/GZMbCxp6owtJ8bNZO15LrGbSWzjhBJqkznUrKzgawwtMxT3VnQ0Nrl9E
         kB3suXKn0I60HTTIRtQCPd983Jy9UQ7dDbNEGR1w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chao Yu <chao@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 426/603] f2fs: compress: fix to avoid use-after-free on dic
Date:   Wed, 15 Nov 2023 14:16:11 -0500
Message-ID: <20231115191642.306139129@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chao Yu <chao@kernel.org>

[ Upstream commit b0327c84e91a0f4f0abced8cb83ec86a7083f086 ]

Call trace:
 __memcpy+0x128/0x250
 f2fs_read_multi_pages+0x940/0xf7c
 f2fs_mpage_readpages+0x5a8/0x624
 f2fs_readahead+0x5c/0x110
 page_cache_ra_unbounded+0x1b8/0x590
 do_sync_mmap_readahead+0x1dc/0x2e4
 filemap_fault+0x254/0xa8c
 f2fs_filemap_fault+0x2c/0x104
 __do_fault+0x7c/0x238
 do_handle_mm_fault+0x11bc/0x2d14
 do_mem_abort+0x3a8/0x1004
 el0_da+0x3c/0xa0
 el0t_64_sync_handler+0xc4/0xec
 el0t_64_sync+0x1b4/0x1b8

In f2fs_read_multi_pages(), once f2fs_decompress_cluster() was called if
we hit cached page in compress_inode's cache, dic may be released, it needs
break the loop rather than continuing it, in order to avoid accessing
invalid dic pointer.

Fixes: 6ce19aff0b8c ("f2fs: compress: add compress_inode to cache compressed blocks")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 3f33e14dc7f81..1ac34eb49a0e8 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2344,8 +2344,10 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 		f2fs_wait_on_block_writeback(inode, blkaddr);
 
 		if (f2fs_load_compressed_page(sbi, page, blkaddr)) {
-			if (atomic_dec_and_test(&dic->remaining_pages))
+			if (atomic_dec_and_test(&dic->remaining_pages)) {
 				f2fs_decompress_cluster(dic, true);
+				break;
+			}
 			continue;
 		}
 
-- 
2.42.0




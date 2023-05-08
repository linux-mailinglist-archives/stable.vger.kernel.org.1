Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A4D6FADCE
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236129AbjEHLii (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236135AbjEHLiE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:38:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DD124A94
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:37:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1C636335B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:37:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4699C433D2;
        Mon,  8 May 2023 11:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545848;
        bh=soHq+OslF1xZnOw0+hQVB/3IW3DgHLlVyGqCOze1PKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jie8nEjexg+UH700qOU/VJrZbOEhLPk1LPCyoMxzI4KngzU37mnV0ta1BDJ5SWydo
         VYZ2KLmT2W7KS7pmFtryQqKiv3Eaw2GxAj8Fs7vgjeZbEfS3VBF+6ERPXq4zGvwIo3
         1GJJo4sSijZ5Qd+CQg+B5ds+sQkC316bsXfW5Ts0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        Qi Han <hanqi@vivo.com>, Yangtao Li <frank.li@vivo.com>,
        Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 174/371] f2fs: compress: fix to call f2fs_wait_on_page_writeback() in f2fs_write_raw_pages()
Date:   Mon,  8 May 2023 11:46:15 +0200
Message-Id: <20230508094819.043202122@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yangtao Li <frank.li@vivo.com>

[ Upstream commit babedcbac164cec970872b8097401ca913a80e61 ]

BUG_ON() will be triggered when writing files concurrently,
because the same page is writtenback multiple times.

1597 void folio_end_writeback(struct folio *folio)
1598 {
		......
1618     if (!__folio_end_writeback(folio))
1619         BUG();
		......
1625 }

kernel BUG at mm/filemap.c:1619!
Call Trace:
 <TASK>
 f2fs_write_end_io+0x1a0/0x370
 blk_update_request+0x6c/0x410
 blk_mq_end_request+0x15/0x130
 blk_complete_reqs+0x3c/0x50
 __do_softirq+0xb8/0x29b
 ? sort_range+0x20/0x20
 run_ksoftirqd+0x19/0x20
 smpboot_thread_fn+0x10b/0x1d0
 kthread+0xde/0x110
 ? kthread_complete_and_exit+0x20/0x20
 ret_from_fork+0x22/0x30
 </TASK>

Below is the concurrency scenario:

[Process A]		[Process B]		[Process C]
f2fs_write_raw_pages()
  - redirty_page_for_writepage()
  - unlock page()
			f2fs_do_write_data_page()
			  - lock_page()
			  - clear_page_dirty_for_io()
			  - set_page_writeback() [1st writeback]
			    .....
			    - unlock page()

						generic_perform_write()
						  - f2fs_write_begin()
						    - wait_for_stable_page()

						  - f2fs_write_end()
						    - set_page_dirty()

  - lock_page()
    - f2fs_do_write_data_page()
      - set_page_writeback() [2st writeback]

This problem was introduced by the previous commit 7377e853967b ("f2fs:
compress: fix potential deadlock of compress file"). All pagelocks were
released in f2fs_write_raw_pages(), but whether the page was
in the writeback state was ignored in the subsequent writing process.
Let's fix it by waiting for the page to writeback before writing.

Cc: Christoph Hellwig <hch@lst.de>
Fixes: 4c8ff7095bef ("f2fs: support data compression")
Fixes: 7377e853967b ("f2fs: compress: fix potential deadlock of compress file")
Signed-off-by: Qi Han <hanqi@vivo.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/compress.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 4fa62f98cb515..455fac164fda0 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1477,6 +1477,12 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 		if (!PageDirty(cc->rpages[i]))
 			goto continue_unlock;
 
+		if (PageWriteback(cc->rpages[i])) {
+			if (wbc->sync_mode == WB_SYNC_NONE)
+				goto continue_unlock;
+			f2fs_wait_on_page_writeback(cc->rpages[i], DATA, true, true);
+		}
+
 		if (!clear_page_dirty_for_io(cc->rpages[i]))
 			goto continue_unlock;
 
-- 
2.39.2




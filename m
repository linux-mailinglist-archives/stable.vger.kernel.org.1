Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083FA79AF47
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355136AbjIKV5H (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239894AbjIKObD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:31:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CF5E4B
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:30:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79624C433C9;
        Mon, 11 Sep 2023 14:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442658;
        bh=hMicBlBqso5KABRHRv4YU72C2VWl2i3k2A7ayqBAVnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zKYo2xbNZrbKOaYpVqDb1a0GKX9J663kH3t79pINoaKAo1dJhiNrgKiqK7w9Tm2YA
         A5JxredsQBmIhopToDjYlMyyQ4Rq+uy93VC0v1tUQfVvdok+NVeWfaCQpoNILUE3UF
         vlh3J8Nos6i9iD/E7f7Do6s7f8teV/30utaadUE0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 103/737] iomap: Remove large folio handling in iomap_invalidate_folio()
Date:   Mon, 11 Sep 2023 15:39:22 +0200
Message-ID: <20230911134653.390665656@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Wilcox (Oracle) <willy@infradead.org>

[ Upstream commit a221ab717c43147f728d93513923ba3528f861bf ]

We do not need to release the iomap_page in iomap_invalidate_folio()
to allow the folio to be split.  The splitting code will call
->release_folio() if there is still per-fs private data attached to
the folio.  At that point, we will check if the folio is still dirty
and decline to release the iomap_page.  It is possible to trigger the
warning in perfectly legitimate circumstances (eg if a disk read fails,
we do a partial write to the folio, then we truncate the folio), which
will cause those writes to be lost.

Fixes: 60d8231089f0 ("iomap: Support large folios in invalidatepage")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/iomap/buffered-io.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 063133ec77f49..08ee293c4117c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -508,11 +508,6 @@ void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len)
 		WARN_ON_ONCE(folio_test_writeback(folio));
 		folio_cancel_dirty(folio);
 		iomap_page_release(folio);
-	} else if (folio_test_large(folio)) {
-		/* Must release the iop so the page can be split */
-		WARN_ON_ONCE(!folio_test_uptodate(folio) &&
-			     folio_test_dirty(folio));
-		iomap_page_release(folio);
 	}
 }
 EXPORT_SYMBOL_GPL(iomap_invalidate_folio);
-- 
2.40.1




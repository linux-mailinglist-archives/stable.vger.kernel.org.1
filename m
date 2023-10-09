Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4703B7BDD62
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376777AbjJINJ4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376752AbjJINJz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:09:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A429D
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:09:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B294CC433C7;
        Mon,  9 Oct 2023 13:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696856993;
        bh=SvQF6HEJ4Iqni93ujiKR1KEqKTgT5ML3Idf1vw/F3Jg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AJ4HbEmpFl9qsJWalAj3MkpCBo29jYEXjQS2sVn0kyoAIm0wYIakR3rJR2oo/Xl6H
         V0gD/3QNPoqk42qabyTLwSJvs9Ki7jHjd0rzcI9JSdpZWosIFi9ie8QcTk2W+MR35Z
         Dx4RX6ob96R9/FYzAuDUrRE1Jy0OZ4pivBmk5SkI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Gao Xiang <hsiangkao@linux.alibaba.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 059/163] erofs: fix memory leak of LZMA global compressed deduplication
Date:   Mon,  9 Oct 2023 15:00:23 +0200
Message-ID: <20231009130125.664636564@linuxfoundation.org>
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

From: Gao Xiang <hsiangkao@linux.alibaba.com>

[ Upstream commit 75a5221630fe5aa3fedba7a06be618db0f79ba1e ]

When stressing microLZMA EROFS images with the new global compressed
deduplication feature enabled (`-Ededupe`), I found some short-lived
temporary pages weren't properly released, which could slowly cause
unexpected OOMs hours later.

Let's fix it now (LZ4 and DEFLATE don't have this issue.)

Fixes: 5c2a64252c5d ("erofs: introduce partial-referenced pclusters")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Link: https://lore.kernel.org/r/20230907050542.97152-1-hsiangkao@linux.alibaba.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/decompressor_lzma.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
index 73091fbe3ea45..dee10d22ada96 100644
--- a/fs/erofs/decompressor_lzma.c
+++ b/fs/erofs/decompressor_lzma.c
@@ -217,9 +217,12 @@ int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
 			strm->buf.out_size = min_t(u32, outlen,
 						   PAGE_SIZE - pageofs);
 			outlen -= strm->buf.out_size;
-			if (!rq->out[no] && rq->fillgaps)	/* deduped */
+			if (!rq->out[no] && rq->fillgaps) {	/* deduped */
 				rq->out[no] = erofs_allocpage(pagepool,
 						GFP_KERNEL | __GFP_NOFAIL);
+				set_page_private(rq->out[no],
+						 Z_EROFS_SHORTLIVED_PAGE);
+			}
 			if (rq->out[no])
 				strm->buf.out = kmap(rq->out[no]) + pageofs;
 			pageofs = 0;
-- 
2.40.1




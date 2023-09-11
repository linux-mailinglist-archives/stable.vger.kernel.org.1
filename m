Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5625779BFA1
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377807AbjIKW2k (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239571AbjIKOX4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:23:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A287DE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:23:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D513EC433C7;
        Mon, 11 Sep 2023 14:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442232;
        bh=V5raUm+Y2RlbgNj8FgDk8KNQeFbvgQ17mZJq0imrvfw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zo+i0V72TruIZjp5ZpfosgHsAuDy4wDSkorMypvB+TkUxp3CmTvXtw9z9BgzNkpXe
         fh0bV+1V0gUeiE/Dya/JGRS4HJ2vx1gEGxGHaaLhUSw6xVf0hHyY0anRoxmdYju5LX
         UU+YOU46gKbebPfN/6IPcLvYIEjJBlzzIOKfdV3M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <dlemoal@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.5 692/739] block: fix pin count management when merging same-page segments
Date:   Mon, 11 Sep 2023 15:48:11 +0200
Message-ID: <20230911134710.426463256@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Hellwig <hch@lst.de>

commit 5905afc2c7bb713d52c7c7585565feecbb686b44 upstream.

There is no need to unpin the added page when adding it to the bio fails
as that is done by the loop below.  Instead we want to unpin it when adding
a single page to the bio more than once as bio_release_pages will only
unpin it once.

Fixes: d1916c86ccdc ("block: move same page handling from __bio_add_pc_page to the callers")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Link: https://lore.kernel.org/r/20230905124731.328255-1-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-map.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -315,12 +315,11 @@ static int bio_map_user_iov(struct reque
 					n = bytes;
 
 				if (!bio_add_hw_page(rq->q, bio, page, n, offs,
-						     max_sectors, &same_page)) {
-					if (same_page)
-						bio_release_page(bio, page);
+						     max_sectors, &same_page))
 					break;
-				}
 
+				if (same_page)
+					bio_release_page(bio, page);
 				bytes -= n;
 				offs = 0;
 			}



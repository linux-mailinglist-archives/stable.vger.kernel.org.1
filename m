Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2713479B9C9
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377504AbjIKW0o (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238769AbjIKOEj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:04:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4086CF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:04:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF500C433C8;
        Mon, 11 Sep 2023 14:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441075;
        bh=Uh7cuEVwhcnT7BtIkO5cRCqcOGlHb7cRjXfHxc5IQco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q0W8pPkOG9ruBRmUG7C37pqNOm53DOlH/+zaYhXgBCEMB7I/ttEq17sd3hDG/QT0U
         Sh+Lw1JrtSSG4haT7h6PUDYEd4IP42sONzFh/tHC6145e0+gtFuzWdgu9zpy2FYZU9
         A8cXPR5K1cOkkn+RRuxWHYYVaTHH/zIWv+oQ9m3I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 260/739] block: cleanup queue_wc_store
Date:   Mon, 11 Sep 2023 15:40:59 +0200
Message-ID: <20230911134658.408649632@linuxfoundation.org>
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

[ Upstream commit c4e21bcd0f9d01f9c5d6c52007f5541871a5b1de ]

Get rid of the local queue_wc_store variable and handling setting and
clearing the QUEUE_FLAG_WC flag diretly instead the if / else if.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20230707094239.107968-2-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 43c9835b144c ("block: don't allow enabling a cache on devices that don't support it")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-sysfs.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index afc797fb0dfc4..0cde6598fb2f4 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -449,21 +449,13 @@ static ssize_t queue_wc_show(struct request_queue *q, char *page)
 static ssize_t queue_wc_store(struct request_queue *q, const char *page,
 			      size_t count)
 {
-	int set = -1;
-
 	if (!strncmp(page, "write back", 10))
-		set = 1;
+		blk_queue_flag_set(QUEUE_FLAG_WC, q);
 	else if (!strncmp(page, "write through", 13) ||
 		 !strncmp(page, "none", 4))
-		set = 0;
-
-	if (set == -1)
-		return -EINVAL;
-
-	if (set)
-		blk_queue_flag_set(QUEUE_FLAG_WC, q);
-	else
 		blk_queue_flag_clear(QUEUE_FLAG_WC, q);
+	else
+		return -EINVAL;
 
 	return count;
 }
-- 
2.40.1




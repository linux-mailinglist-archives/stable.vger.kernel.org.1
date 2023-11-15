Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB56A7ECFF2
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbjKOTvx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235443AbjKOTvv (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:51:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19981B9
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:51:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FF0C433C9;
        Wed, 15 Nov 2023 19:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077907;
        bh=qI1RbfecNYKz04rlFyEEInKbq3Z6kYs30dkXbitd+ek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hHdEqNX/LDIyUvMRw8YvTbJKhJlvsAB53GGqLFSSSIQ7xeoXL8iCDorTan0azV/lU
         ok/Mm7ZGg7KdJpeWgOJqUCkicVxagTKFV/Q1QHCuN1q5XTzPtUm9NHE5fBTW1IJ3Jn
         2Mx5yr1bzXMsqdYBSAHvFE4d2DZ1CY6/igddhbZM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yu Kuai <yukuai3@huawei.com>,
        Ye Bin <yebin10@huawei.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 568/603] blk-core: use pr_warn_ratelimited() in bio_check_ro()
Date:   Wed, 15 Nov 2023 14:18:33 -0500
Message-ID: <20231115191650.856628071@linuxfoundation.org>
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

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit 1b0a151c10a6d823f033023b9fdd9af72a89591b ]

If one of the underlying disks of raid or dm is set to read-only, then
each io will generate new log, which will cause message storm. This
environment is indeed problematic, however we can't make sure our
naive custormer won't do this, hence use pr_warn_ratelimited() to
prevent message storm in this case.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Fixes: 57e95e4670d1 ("block: fix and cleanup bio_check_ro")
Signed-off-by: Ye Bin <yebin10@huawei.com>
Link: https://lore.kernel.org/r/20231107111247.2157820-1-yukuai1@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 9d51e9894ece7..fdf25b8d6e784 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -501,8 +501,8 @@ static inline void bio_check_ro(struct bio *bio)
 	if (op_is_write(bio_op(bio)) && bdev_read_only(bio->bi_bdev)) {
 		if (op_is_flush(bio->bi_opf) && !bio_sectors(bio))
 			return;
-		pr_warn("Trying to write to read-only block-device %pg\n",
-			bio->bi_bdev);
+		pr_warn_ratelimited("Trying to write to read-only block-device %pg\n",
+				    bio->bi_bdev);
 		/* Older lvm-tools actually trigger this */
 	}
 }
-- 
2.42.0




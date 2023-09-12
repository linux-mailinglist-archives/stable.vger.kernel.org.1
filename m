Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF5C79B5FD
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357857AbjIKWGi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240467AbjIKOpC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:45:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B06A12A
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:44:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5517C433C8;
        Mon, 11 Sep 2023 14:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443498;
        bh=pwo55L/GomvOw1VUypRtnDrvKIwAQGw5xeR3n4qtVUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bxzVFLFJYo9R4uYl4lSizgsWlJpPHDOkWF1kPn5EsCrAZ9oZQfTo6AK+FusGDcfdO
         1boGl+kK8Ea+QcvGScGAWpNzsi7X1hGAyLCSYmuw2gjXtltxc8zcsLMlzyUpRa481x
         hyDjklwljnqbn+lq5DwEQJ6WwUWmyUaGTHQ4+EIg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yu Kuai <yukuai3@huawei.com>,
        Xueshi Hu <xueshi.hu@smartx.com>, Song Liu <song@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 399/737] md/raid1: hold the barrier until handle_read_error() finishes
Date:   Mon, 11 Sep 2023 15:44:18 +0200
Message-ID: <20230911134701.748793017@linuxfoundation.org>
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

From: Xueshi Hu <xueshi.hu@smartx.com>

[ Upstream commit c069da449a13669ffa754fd971747e7e17e7d691 ]

handle_read_error() will call allow_barrier() to match the former barrier
raising. However, it should put the allow_barrier() at the end to avoid a
concurrent raid reshape.

Fixes: 689389a06ce7 ("md/raid1: simplify handle_read_error().")
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Xueshi Hu <xueshi.hu@smartx.com>
Link: https://lore.kernel.org/r/20230814135356.1113639-4-xueshi.hu@smartx.com
Signed-off-by: Song Liu <song@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/raid1.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index ebbe41a33b821..975301f2debdd 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2495,6 +2495,7 @@ static void handle_read_error(struct r1conf *conf, struct r1bio *r1_bio)
 	struct mddev *mddev = conf->mddev;
 	struct bio *bio;
 	struct md_rdev *rdev;
+	sector_t sector;
 
 	clear_bit(R1BIO_ReadError, &r1_bio->state);
 	/* we got a read error. Maybe the drive is bad.  Maybe just
@@ -2524,12 +2525,13 @@ static void handle_read_error(struct r1conf *conf, struct r1bio *r1_bio)
 	}
 
 	rdev_dec_pending(rdev, conf->mddev);
-	allow_barrier(conf, r1_bio->sector);
+	sector = r1_bio->sector;
 	bio = r1_bio->master_bio;
 
 	/* Reuse the old r1_bio so that the IO_BLOCKED settings are preserved */
 	r1_bio->state = 0;
 	raid1_read_request(mddev, bio, r1_bio->sectors, r1_bio);
+	allow_barrier(conf, sector);
 }
 
 static void raid1d(struct md_thread *thread)
-- 
2.40.1




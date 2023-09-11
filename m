Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6599379B6D8
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348522AbjIKV1K (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238946AbjIKOIE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:08:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88903CF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:08:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6E0C433C8;
        Mon, 11 Sep 2023 14:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441280;
        bh=/P2dSr24EPMb+O8+dVhEMQxW7QMvV7AgZ/Rm4Bj9KVo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h7wrNnEKkeG6qPTP8k81nZumJgiEp1FCkoVDAEQWE+371NusbZtVr9d2deKh6webW
         Azm7w7u0GfvBIZiVnBsDjCkJlDYCU8DB4Mx4jF4sFeFTWNm2bW9wjYRgVYkkY3Joip
         MiQO1rvHYDW870rcUrlYe3TJ9dpdSK0zdF5jx+5w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yu Kuai <yukuai3@huawei.com>,
        Xueshi Hu <xueshi.hu@smartx.com>, Song Liu <song@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 358/739] md/raid1: free the r1bio before waiting for blocked rdev
Date:   Mon, 11 Sep 2023 15:42:37 +0200
Message-ID: <20230911134701.138464290@linuxfoundation.org>
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

From: Xueshi Hu <xueshi.hu@smartx.com>

[ Upstream commit 992db13a4aee766c8bfbf046ad15c2db5fa7cab8 ]

Raid1 reshape will change mempool and r1conf::raid_disks which are
needed to free r1bio. allow_barrier() make a concurrent raid1_reshape()
possible. So, free the in-flight r1bio before waiting blocked rdev.

Fixes: 6bfe0b499082 ("md: support blocking writes to an array on device failure")
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Xueshi Hu <xueshi.hu@smartx.com>
Link: https://lore.kernel.org/r/20230814135356.1113639-3-xueshi.hu@smartx.com
Signed-off-by: Song Liu <song@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/raid1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index dd25832eb0452..f6a33c7824a70 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1373,6 +1373,7 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 		return;
 	}
 
+ retry_write:
 	r1_bio = alloc_r1bio(mddev, bio);
 	r1_bio->sectors = max_write_sectors;
 
@@ -1388,7 +1389,6 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 	 */
 
 	disks = conf->raid_disks * 2;
- retry_write:
 	blocked_rdev = NULL;
 	rcu_read_lock();
 	max_sectors = r1_bio->sectors;
@@ -1468,7 +1468,7 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 		for (j = 0; j < i; j++)
 			if (r1_bio->bios[j])
 				rdev_dec_pending(conf->mirrors[j].rdev, mddev);
-		r1_bio->state = 0;
+		free_r1bio(r1_bio);
 		allow_barrier(conf, bio->bi_iter.bi_sector);
 
 		if (bio->bi_opf & REQ_NOWAIT) {
-- 
2.40.1




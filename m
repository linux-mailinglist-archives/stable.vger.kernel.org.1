Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B2E7A3BEC
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240846AbjIQUYE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240870AbjIQUXv (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:23:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F002101
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:23:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80845C433C7;
        Sun, 17 Sep 2023 20:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982226;
        bh=LGTbFhvnmpe6d4pX48WCUlFZ7WB4GghuRn0OV9C4BcE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QVE7YeUcHYlExHFuRzBZgpqn/GqjJDO1T71xqBsLpvYRNksyfvd4Ot0D56hOrpt+d
         81vJLdWXr1MVSVia5TzyOgxk7bzEg3pmPAkYaQzA4cFsEdrCz+MVH8MERBCXi74E5d
         mAnQrr36VouTVal8ifz/4sOY6EkPdoK5dl0YIvQE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Li Nan <linan122@huawei.com>,
        Song Liu <song@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 161/511] md/raid10: factor out dereference_rdev_and_rrdev()
Date:   Sun, 17 Sep 2023 21:09:48 +0200
Message-ID: <20230917191117.734305789@linuxfoundation.org>
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

From: Li Nan <linan122@huawei.com>

[ Upstream commit b99f8fd2d91eb734f13098aa1cf337edaca454b7 ]

Factor out a helper to get 'rdev' and 'replacement' from config->mirrors.
Just to make code cleaner and prepare to fix the bug of io loss while
'replacement' replace 'rdev'.

There is no functional change.

Signed-off-by: Li Nan <linan122@huawei.com>
Link: https://lore.kernel.org/r/20230701080529.2684932-3-linan666@huaweicloud.com
Signed-off-by: Song Liu <song@kernel.org>
Stable-dep-of: 673643490b9a ("md/raid10: use dereference_rdev_and_rrdev() to get devices")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/raid10.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index edd3b65c447db..ff3c97cde7699 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1316,6 +1316,25 @@ static void raid10_write_one_disk(struct mddev *mddev, struct r10bio *r10_bio,
 	}
 }
 
+static struct md_rdev *dereference_rdev_and_rrdev(struct raid10_info *mirror,
+						  struct md_rdev **prrdev)
+{
+	struct md_rdev *rdev, *rrdev;
+
+	rrdev = rcu_dereference(mirror->replacement);
+	/*
+	 * Read replacement first to prevent reading both rdev and
+	 * replacement as NULL during replacement replace rdev.
+	 */
+	smp_mb();
+	rdev = rcu_dereference(mirror->rdev);
+	if (rdev == rrdev)
+		rrdev = NULL;
+
+	*prrdev = rrdev;
+	return rdev;
+}
+
 static void wait_blocked_dev(struct mddev *mddev, struct r10bio *r10_bio)
 {
 	int i;
@@ -1459,15 +1478,7 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 		int d = r10_bio->devs[i].devnum;
 		struct md_rdev *rdev, *rrdev;
 
-		rrdev = rcu_dereference(conf->mirrors[d].replacement);
-		/*
-		 * Read replacement first to prevent reading both rdev and
-		 * replacement as NULL during replacement replace rdev.
-		 */
-		smp_mb();
-		rdev = rcu_dereference(conf->mirrors[d].rdev);
-		if (rdev == rrdev)
-			rrdev = NULL;
+		rdev = dereference_rdev_and_rrdev(&conf->mirrors[d], &rrdev);
 		if (rdev && (test_bit(Faulty, &rdev->flags)))
 			rdev = NULL;
 		if (rrdev && (test_bit(Faulty, &rrdev->flags)))
-- 
2.40.1




Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A5F79AF53
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240066AbjIKVir (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240353AbjIKOmP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:42:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A878C12A
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:42:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE393C433C8;
        Mon, 11 Sep 2023 14:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443330;
        bh=l/m4RKQ0DzSb5yH+GsivYMjJxqX42+74Wo1dvss4j28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l19NWAaVKXyjZLBU7g+smgOCMxH2ETzaN3G7cdB39iG6kzbafNfE/n2ArAYeQvm7K
         qyObHo0DfuUQFCZSs6dXm7tpB8w2fdSoWj5P6LzIzsznpID7TuFp0b90QGfKLD64xr
         UX27inVEklT+L+IyWMT2MtrufJS9aGDj9xeJuaVA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Li Nan <linan122@huawei.com>,
        Song Liu <song@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 340/737] md/raid10: use dereference_rdev_and_rrdev() to get devices
Date:   Mon, 11 Sep 2023 15:43:19 +0200
Message-ID: <20230911134700.028899844@linuxfoundation.org>
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

From: Li Nan <linan122@huawei.com>

[ Upstream commit 673643490b9a0eb3b25633abe604f62b8f63dba1 ]

Commit 2ae6aaf76912 ("md/raid10: fix io loss while replacement replace
rdev") reads replacement first to prevent io loss. However, there are same
issue in wait_blocked_dev() and raid10_handle_discard(), too. Fix it by
using dereference_rdev_and_rrdev() to get devices.

Fixes: d30588b2731f ("md/raid10: improve raid10 discard request")
Fixes: f2e7e269a752 ("md/raid10: pull the code that wait for blocked dev into one function")
Signed-off-by: Li Nan <linan122@huawei.com>
Link: https://lore.kernel.org/r/20230701080529.2684932-4-linan666@huaweicloud.com
Signed-off-by: Song Liu <song@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/raid10.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index f47fd50651c45..925ab30c15d49 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1350,11 +1350,9 @@ static void wait_blocked_dev(struct mddev *mddev, struct r10bio *r10_bio)
 	blocked_rdev = NULL;
 	rcu_read_lock();
 	for (i = 0; i < conf->copies; i++) {
-		struct md_rdev *rdev = rcu_dereference(conf->mirrors[i].rdev);
-		struct md_rdev *rrdev = rcu_dereference(
-			conf->mirrors[i].replacement);
-		if (rdev == rrdev)
-			rrdev = NULL;
+		struct md_rdev *rdev, *rrdev;
+
+		rdev = dereference_rdev_and_rrdev(&conf->mirrors[i], &rrdev);
 		if (rdev && unlikely(test_bit(Blocked, &rdev->flags))) {
 			atomic_inc(&rdev->nr_pending);
 			blocked_rdev = rdev;
@@ -1790,10 +1788,9 @@ static int raid10_handle_discard(struct mddev *mddev, struct bio *bio)
 	 */
 	rcu_read_lock();
 	for (disk = 0; disk < geo->raid_disks; disk++) {
-		struct md_rdev *rdev = rcu_dereference(conf->mirrors[disk].rdev);
-		struct md_rdev *rrdev = rcu_dereference(
-			conf->mirrors[disk].replacement);
+		struct md_rdev *rdev, *rrdev;
 
+		rdev = dereference_rdev_and_rrdev(&conf->mirrors[disk], &rrdev);
 		r10_bio->devs[disk].bio = NULL;
 		r10_bio->devs[disk].repl_bio = NULL;
 
-- 
2.40.1




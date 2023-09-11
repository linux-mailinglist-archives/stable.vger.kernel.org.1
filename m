Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900B779BAC2
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239763AbjIKWJk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238936AbjIKOHx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:07:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C310ACF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:07:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ABCAC433C7;
        Mon, 11 Sep 2023 14:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441268;
        bh=Lr9vh9djFIbD7bVb55hq6T1rAQ5bbXlhBzdy/7CUKrY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lyPv/ao4Uf8Amq9SifHYWN2xshGXI636trnrGLBgOxRwcSYEkfZ5pDN/9oGpaM79K
         M/T5+JWmOr1na1pclBjrIEG91V91oShSf2KArybKG1sWrvtUbsiXb8yIEJCValN2Ya
         P9RKu8Ea/HUq6y3dMtt378WURZsjlIco4lY5jbq8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yu Kuai <yukuai3@huawei.com>,
        Song Liu <song@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 354/739] md/raid5-cache: fix a deadlock in r5l_exit_log()
Date:   Mon, 11 Sep 2023 15:42:33 +0200
Message-ID: <20230911134701.013479399@linuxfoundation.org>
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

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit a705b11b358dee677aad80630e7608b2d5f56691 ]

Commit b13015af94cf ("md/raid5-cache: Clear conf->log after finishing
work") introduce a new problem:

// caller hold reconfig_mutex
r5l_exit_log
 flush_work(&log->disable_writeback_work)
			r5c_disable_writeback_async
			 wait_event
			  /*
			   * conf->log is not NULL, and mddev_trylock()
			   * will fail, wait_event() can never pass.
			   */
 conf->log = NULL

Fix this problem by setting 'config->log' to NULL before wake_up() as it
used to be, so that wait_event() from r5c_disable_writeback_async() can
exist. In the meantime, move forward md_unregister_thread() so that
null-ptr-deref this commit fixed can still be fixed.

Fixes: b13015af94cf ("md/raid5-cache: Clear conf->log after finishing work")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Link: https://lore.kernel.org/r/20230708091727.1417894-1-yukuai1@huaweicloud.com
Signed-off-by: Song Liu <song@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/raid5-cache.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 47ba7d9e81e18..2eac4a50d99bd 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -3168,12 +3168,15 @@ void r5l_exit_log(struct r5conf *conf)
 {
 	struct r5l_log *log = conf->log;
 
-	/* Ensure disable_writeback_work wakes up and exits */
-	wake_up(&conf->mddev->sb_wait);
-	flush_work(&log->disable_writeback_work);
 	md_unregister_thread(&log->reclaim_thread);
 
+	/*
+	 * 'reconfig_mutex' is held by caller, set 'confg->log' to NULL to
+	 * ensure disable_writeback_work wakes up and exits.
+	 */
 	conf->log = NULL;
+	wake_up(&conf->mddev->sb_wait);
+	flush_work(&log->disable_writeback_work);
 
 	mempool_exit(&log->meta_pool);
 	bioset_exit(&log->bs);
-- 
2.40.1




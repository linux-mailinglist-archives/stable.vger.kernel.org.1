Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3651D6FA549
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbjEHKHu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234092AbjEHKHs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:07:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB73B32907
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:07:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41AFB6237A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:07:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575D2C433D2;
        Mon,  8 May 2023 10:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540466;
        bh=+hu4KO2XEvv7lPiuVlx3oYrOe8T2h5j3Smu7paDNRkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qUoT4Afa0hZiklHVPgLYJ45lSIaxLALLMUCLOUKKygHZQzaUd1QPs7bb9zfCL5p7O
         FvDZPrw6BAAxfLk8MCJi0JULXnIBwt/dEPF8vqyg3N//H5i4oUORsZF2AvzMBBrtzS
         DQDuJ2bHWaColodrTe+rmJ8vBorGUNMPD4m2ts/0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Li Nan <linan122@huawei.com>,
        Song Liu <song@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 348/611] md/raid10: fix task hung in raid10d
Date:   Mon,  8 May 2023 11:43:10 +0200
Message-Id: <20230508094433.713592854@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Li Nan <linan122@huawei.com>

[ Upstream commit 72c215ed8731c88b2d7e09afc51fffc207ae47b8 ]

commit fe630de009d0 ("md/raid10: avoid deadlock on recovery.") allowed
normal io and sync io to exist at the same time. Task hung will occur as
below:

T1                      T2		T3		T4
raid10d
 handle_read_error
  allow_barrier
   conf->nr_pending--
    -> 0
                        //submit sync io
                        raid10_sync_request
                         raise_barrier
			  ->will not be blocked
			  ...
			//submit to drivers
  raid10_read_request
   wait_barrier
    conf->nr_pending++
     -> 1
					//retry read fail
					raid10_end_read_request
					 reschedule_retry
					  add to retry_list
					  conf->nr_queued++
					   -> 1
							//sync io fail
							end_sync_read
							 __end_sync_read
							  reschedule_retry
							   add to retry_list
					                    conf->nr_queued++
							     -> 2
 ...
 handle_read_error
 get form retry_list
 conf->nr_queued--
  freeze_array
   wait nr_pending == nr_queued+1
        ->1	      ->2
   //task hung

retry read and sync io will be added to retry_list(nr_queued->2) if they
fails. raid10d() called handle_read_error() and hung in freeze_array().
nr_queued will not decrease because raid10d is blocked, nr_pending will
not increase because conf->barrier is not released.

Fix it by moving allow_barrier() after raid10_read_request().
raise_barrier() will wait for nr_waiting to become 0. Therefore, sync io
and regular io will not be issued at the same time.

Also remove the check of nr_queued in stop_waiting_barrier. It can be 0
but don't need to be blocking. Remove the check for MD_RECOVERY_RUNNING as
the check is redundent.

Fixes: fe630de009d0 ("md/raid10: avoid deadlock on recovery.")
Signed-off-by: Li Nan <linan122@huawei.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20230222041000.3341651-2-linan666@huaweicloud.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/raid10.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 9a6503f5cb982..ab0eef8634b14 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -995,11 +995,15 @@ static bool stop_waiting_barrier(struct r10conf *conf)
 	    (!bio_list_empty(&bio_list[0]) || !bio_list_empty(&bio_list[1])))
 		return true;
 
-	/* move on if recovery thread is blocked by us */
-	if (conf->mddev->thread->tsk == current &&
-	    test_bit(MD_RECOVERY_RUNNING, &conf->mddev->recovery) &&
-	    conf->nr_queued > 0)
+	/*
+	 * move on if io is issued from raid10d(), nr_pending is not released
+	 * from original io(see handle_read_error()). All raise barrier is
+	 * blocked until this io is done.
+	 */
+	if (conf->mddev->thread->tsk == current) {
+		WARN_ON_ONCE(atomic_read(&conf->nr_pending) == 0);
 		return true;
+	}
 
 	return false;
 }
@@ -2978,9 +2982,13 @@ static void handle_read_error(struct mddev *mddev, struct r10bio *r10_bio)
 		md_error(mddev, rdev);
 
 	rdev_dec_pending(rdev, mddev);
-	allow_barrier(conf);
 	r10_bio->state = 0;
 	raid10_read_request(mddev, r10_bio->master_bio, r10_bio);
+	/*
+	 * allow_barrier after re-submit to ensure no sync io
+	 * can be issued while regular io pending.
+	 */
+	allow_barrier(conf);
 }
 
 static void handle_write_completed(struct r10conf *conf, struct r10bio *r10_bio)
-- 
2.39.2



